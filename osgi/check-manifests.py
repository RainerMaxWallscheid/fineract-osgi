#!/usr/bin/env python3
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements. See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership. The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.

"""Static Equinox-readiness check of Gradle OSGi manifests (ADR-022).

Scans fineract-*/{api,impl,test}/build.gradle, fineract-core/build.gradle,
and fineract-command-integrationtest.
Fails on:
  * missing / duplicate Bundle-SymbolicName
  * BSN that does not match the Gradle module stem
  * test fragment whose Fragment-Host is missing or does not resolve
  * impl Export-Package that is not empty (impl packages stay private)
  * impl Bundle-Activator outside the loan / COB / security allow-list
  * impl Service-Component file, implementation class, or provide interface missing
  * DS provide interface that is not a PILOT_PORT in EquinoxResolveSmoke
  * unused org.osgi.framework Import-Package on a DS or no-port impl
  * impl with neither Service-Component, an allow-listed activator, nor a no-port stem
  * impl-involved cross-stem Export-Package (split packages)
  * new api-api / kernel-api Export-Package collisions (none are allow-listed)
  * fineract-core Export-Package that is missing, overlaps an *-api export,
    or does not match unique kernel source packages
  * api Import-Package that omits an org.apache.fineract package the sources
    import when that package is exported by another scanned bundle
    (`*` is not DynamicImport-Package; Gradle writes the header literally)

Historical same-package type splits used to live in KNOWN_API_SPLITS.
That map is empty after the loan/jobs, charge/savings, and
loan/progressive close-ins.

Usage:
    python3 osgi/check-manifests.py
    ./gradlew checkOsgiManifests
"""

from __future__ import annotations

import re
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

# No remaining same-package type splits across two *-api bundles.
# The check fails on any new api-api Export-Package collision.
KNOWN_API_SPLITS: dict[str, frozenset[str]] = {}

# Bundle-Activator remains only for loan/COB/security.
ALLOWED_ACTIVATOR_STEMS: frozenset[str] = frozenset(
    {
        "cob",
        "loan",
        "progressiveloan",
        "security",
        "workingcapitalloan",
    }
)

# No Equinox-safe catalog port (jersey / AWS / swagger / leftover types).
NO_PORT_STEMS: frozenset[str] = frozenset(
    {
        "bulkimport",
        "event",
        "instancemode",
        "interoperation",
        "openapi",
        "s3",
    }
)

IMPLEMENTATION_CLASS_RE = re.compile(r'<implementation\s+class="([^"]+)"')
PROVIDE_INTERFACE_RE = re.compile(r'<provide\s+interface="([^"]+)"')

# Packages that exist in fineract-core source but must not be exported.
# org.springframework.batch.core.scope.context hosts a Spring Batch patch;
# exporting it would split the real Spring Batch bundle.
KERNEL_EXPORT_EXCLUDES: frozenset[str] = frozenset(
    {
        "org.springframework.batch.core.scope.context",
    }
)

ATTR_KEYS = (
    "Bundle-SymbolicName",
    "Fragment-Host",
    "Export-Package",
    "Import-Package",
    "Bundle-Version",
    "Automatic-Module-Name",
    "Bundle-Activator",
    "Service-Component",
)

IMPORT_TYPE_RE = re.compile(
    r"^import\s+(?:static\s+)?(org\.apache\.fineract(?:\.[A-Za-z0-9_]+)+(?:\.\*)?)\s*;",
    re.MULTILINE,
)

ATTR_RE = {
    key: re.compile(rf"'{re.escape(key)}'\s*:\s*((?:'[^']*'\s*\+?\s*)+)", re.MULTILINE)
    for key in ATTR_KEYS
}


def gradle_stem(module_dir_name: str) -> str:
    """fineract-loan-origination → loanorigination."""
    name = module_dir_name
    if name.startswith("fineract-"):
        name = name[len("fineract-") :]
    return name.replace("-", "")


def extract_attrs(text: str) -> dict[str, str]:
    attrs: dict[str, str] = {}
    for key, pattern in ATTR_RE.items():
        match = pattern.search(text)
        if not match:
            continue
        parts = re.findall(r"'([^']*)'", match.group(1))
        attrs[key] = "".join(parts).strip().rstrip(",")
    return attrs


def parse_export_packages(raw: str | None) -> list[str]:
    if not raw:
        return []
    return [part.strip() for part in raw.split(",") if part.strip()]


def pilot_ports() -> set[str]:
    source = ROOT / "osgi" / "EquinoxResolveSmoke.java"
    text = source.read_text(encoding="utf-8")
    block = text.split("PILOT_PORTS", 1)[1].split("};", 1)[0]
    return set(re.findall(r'"(org\.apache\.fineract[^"]+)"', block))


def contract_type_names() -> set[str]:
    """Fully qualified main-source types on *-api and fineract-core."""
    types: set[str] = set()
    roots = list(ROOT.glob("fineract-*/api/src/main/java"))
    core = ROOT / "fineract-core" / "src" / "main" / "java"
    if core.is_dir():
        roots.append(core)
    for src_root in roots:
        for source in src_root.rglob("*.java"):
            rel = source.relative_to(src_root).with_suffix("")
            if rel.parts:
                types.add(".".join(rel.parts))
    return types


def java_source_packages(src_root: Path) -> set[str]:
    packages: set[str] = set()
    if not src_root.is_dir():
        return packages
    for source in src_root.rglob("*.java"):
        rel = source.parent.relative_to(src_root)
        if rel.parts:
            packages.add(".".join(rel.parts))
    return packages


def imported_package(qualified: str) -> str:
    parts = qualified.split(".")
    if parts and parts[-1] == "*":
        parts = parts[:-1]
    else:
        while parts and parts[-1][:1].isupper():
            parts.pop()
    return ".".join(parts)


def java_imported_packages(src_root: Path) -> set[str]:
    packages: set[str] = set()
    if not src_root.is_dir():
        return packages
    for source in src_root.rglob("*.java"):
        text = source.read_text(encoding="utf-8")
        for match in IMPORT_TYPE_RE.finditer(text):
            package = imported_package(match.group(1))
            if package:
                packages.add(package)
    return packages


def bsn_stem_and_role(bsn: str) -> tuple[str | None, str | None]:
    prefix = "org.apache.fineract."
    if not bsn.startswith(prefix):
        return None, None
    rest = bsn[len(prefix) :]
    for role in ("integrationtest", "api", "impl", "test"):
        suffix = "." + role
        if rest.endswith(suffix):
            return rest[: -len(suffix)], role
    return rest, None


def discover_manifests() -> list[dict]:
    rows: list[dict] = []
    for build in sorted(ROOT.glob("fineract-*/api/build.gradle")):
        rows.append(load_row(build, "api"))
    for build in sorted(ROOT.glob("fineract-*/impl/build.gradle")):
        rows.append(load_row(build, "impl"))
    for build in sorted(ROOT.glob("fineract-*/test/build.gradle")):
        rows.append(load_row(build, "test"))
    extra = ROOT / "fineract-command-integrationtest" / "build.gradle"
    if extra.is_file():
        rows.append(load_row(extra, "support"))
    core = ROOT / "fineract-core" / "build.gradle"
    if core.is_file():
        rows.append(load_row(core, "kernel"))
    return rows


def load_row(build: Path, layout_role: str) -> dict:
    text = build.read_text(encoding="utf-8")
    attrs = extract_attrs(text)
    module_dir = (
        build.parent.name
        if layout_role in {"support", "kernel"}
        else build.parent.parent.name
    )
    return {
        "path": str(build.relative_to(ROOT)),
        "module": module_dir,
        "layout_role": layout_role,
        "expected_stem": gradle_stem(module_dir),
        "bsn": attrs.get("Bundle-SymbolicName"),
        "fragment_host": attrs.get("Fragment-Host"),
        "exports": parse_export_packages(attrs.get("Export-Package")),
        "imports": parse_export_packages(attrs.get("Import-Package")),
        "activator": attrs.get("Bundle-Activator"),
        "components": parse_export_packages(attrs.get("Service-Component")),
        "impl_dir": build.parent,
    }


def main() -> int:
    rows = discover_manifests()
    errors: list[str] = []
    warnings: list[str] = []

    by_bsn: dict[str, list[str]] = defaultdict(list)
    for row in rows:
        bsn = row["bsn"]
        if not bsn:
            errors.append(f"{row['path']}: missing Bundle-SymbolicName")
            continue
        by_bsn[bsn].append(row["path"])

    for bsn, paths in sorted(by_bsn.items()):
        if len(paths) > 1:
            errors.append(f"duplicate Bundle-SymbolicName {bsn}: {', '.join(paths)}")

    for row in rows:
        bsn = row["bsn"]
        if not bsn:
            continue
        stem, role = bsn_stem_and_role(bsn)
        row["bsn_stem"] = stem
        row["bsn_role"] = role
        if row["layout_role"] == "support":
            continue
        if row["layout_role"] == "kernel":
            if bsn != "org.apache.fineract.core":
                errors.append(f"{row['path']}: kernel BSN must be org.apache.fineract.core, got {bsn}")
            if role is not None:
                errors.append(f"{row['path']}: kernel BSN {bsn} must not use .{role}")
            if stem != "core":
                errors.append(
                    f"{row['path']}: BSN stem {stem!r} does not match module {row['module']}"
                )
            if not row["exports"]:
                errors.append(f"{row['path']}: kernel Export-Package is empty")
            continue
        expected_role = row["layout_role"]
        if role != expected_role:
            errors.append(
                f"{row['path']}: BSN {bsn} role .{role} does not match layout {expected_role}"
            )
        if stem != row["expected_stem"]:
            errors.append(
                f"{row['path']}: BSN stem {stem!r} does not match module {row['module']} "
                f"(expected {row['expected_stem']!r})"
            )

    hosts = {row["bsn"] for row in rows if row["bsn"]}
    for row in rows:
        if row["layout_role"] != "test":
            if row["fragment_host"]:
                warnings.append(
                    f"{row['path']}: Fragment-Host on non-test bundle ({row['fragment_host']})"
                )
            continue
        host = row["fragment_host"]
        if not host:
            errors.append(f"{row['path']}: test fragment missing Fragment-Host")
            continue
        if host not in hosts:
            errors.append(f"{row['path']}: Fragment-Host {host} does not resolve to a known BSN")
        expected_host = f"org.apache.fineract.{row['expected_stem']}.impl"
        if host != expected_host:
            errors.append(
                f"{row['path']}: Fragment-Host {host} expected {expected_host}"
            )

    contract_types = contract_type_names()
    smoked_ports = pilot_ports()

    exporters: dict[str, list[dict]] = defaultdict(list)
    for row in rows:
        for package in row["exports"]:
            exporters[package].append(row)

    for row in rows:
        if row["layout_role"] != "impl":
            continue
        exports = row["exports"]
        if exports:
            errors.append(
                f"{row['path']}: impl Export-Package must be empty "
                f"(packages stay private), got {exports}"
            )
        activator = row.get("activator")
        if activator and row["expected_stem"] not in ALLOWED_ACTIVATOR_STEMS:
            errors.append(
                f"{row['path']}: Bundle-Activator {activator} is not allow-listed "
                f"(loan / COB / security only)"
            )
        components = row.get("components") or []
        if activator and components:
            errors.append(
                f"{row['path']}: impl must not declare both Bundle-Activator and Service-Component"
            )
        impl_dir = Path(row["impl_dir"])
        for header in components:
            xml_path = impl_dir / "src" / "main" / "resources" / header
            if not xml_path.is_file():
                errors.append(f"{row['path']}: Service-Component {header} is missing ({xml_path})")
                continue
            xml = xml_path.read_text(encoding="utf-8")
            classes = IMPLEMENTATION_CLASS_RE.findall(xml)
            if not classes:
                errors.append(f"{xml_path}: Service-Component has no implementation class")
                continue
            for fqcn in classes:
                java_path = impl_dir / "src" / "main" / "java" / Path(*fqcn.split(".")).with_suffix(".java")
                if not java_path.is_file():
                    errors.append(
                        f"{xml_path}: implementation class {fqcn} is missing ({java_path})"
                    )
            interfaces = PROVIDE_INTERFACE_RE.findall(xml)
            if not interfaces:
                errors.append(f"{xml_path}: Service-Component has no provide interface")
                continue
            for iface in interfaces:
                if iface not in contract_types:
                    errors.append(
                        f"{xml_path}: provide interface {iface} is not an *-api or fineract-core type"
                    )
                if iface not in smoked_ports:
                    errors.append(
                        f"{xml_path}: provide interface {iface} is not a PILOT_PORT in "
                        "osgi/EquinoxResolveSmoke.java"
                    )
        if (
            not activator
            and "org.osgi.framework" in (row.get("imports") or [])
        ):
            errors.append(
                f"{row['path']}: unused org.osgi.framework Import-Package "
                "(DS / no-port impls do not compile against OSGi Framework)"
            )
        if not activator and not components and row["expected_stem"] not in NO_PORT_STEMS:
            errors.append(
                f"{row['path']}: impl has no Service-Component and no allow-listed Bundle-Activator"
            )

    seen_known: set[str] = set()
    for package, owners in sorted(exporters.items()):
        if len(owners) < 2:
            continue
        stems = {owner.get("bsn_stem") or owner["expected_stem"] for owner in owners}
        roles = {owner["layout_role"] for owner in owners}
        owner_desc = ", ".join(
            f"{owner['bsn'] or owner['path']} ({owner['layout_role']})" for owner in owners
        )
        if "impl" in roles or "test" in roles:
            errors.append(f"impl-involved split Export-Package {package}: {owner_desc}")
            continue
        expected = KNOWN_API_SPLITS.get(package)
        if expected is None:
            errors.append(f"new split Export-Package {package}: {owner_desc}")
            continue
        if stems != expected:
            errors.append(
                f"api-api split Export-Package {package} stems {sorted(stems)} "
                f"do not match allow-list {sorted(expected)}: {owner_desc}"
            )
            continue
        seen_known.add(package)
        warnings.append(f"known api-api residual split {package}: {owner_desc}")

    for package, expected in KNOWN_API_SPLITS.items():
        if package not in seen_known:
            warnings.append(
                f"allow-list stale: {package} (stems {sorted(expected)}) is no longer a split; "
                "remove it from KNOWN_API_SPLITS"
            )

    exported_packages = set(exporters)
    for row in rows:
        if row["layout_role"] != "api":
            continue
        src_root = ROOT / Path(row["path"]).parent / "src" / "main" / "java"
        own = java_source_packages(src_root)
        used = java_imported_packages(src_root)
        declared = {package for package in row["imports"] if package != "*"}
        required = sorted(
            package for package in used if package in exported_packages and package not in own
        )
        missing = [package for package in required if package not in declared]
        if missing:
            errors.append(
                f"{row['path']}: Import-Package missing exported packages used by api sources: "
                + ", ".join(missing)
            )

    kernel_rows = [row for row in rows if row["layout_role"] == "kernel"]
    if len(kernel_rows) != 1:
        errors.append(f"expected exactly one kernel manifest, found {len(kernel_rows)}")
    else:
        api_exports = {
            package
            for row in rows
            if row["layout_role"] == "api"
            for package in row["exports"]
        }
        source_packages = java_source_packages(ROOT / "fineract-core" / "src" / "main" / "java")
        expected_exports = sorted(
            package
            for package in source_packages
            if package not in api_exports and package not in KERNEL_EXPORT_EXCLUDES
        )
        declared = kernel_rows[0]["exports"]
        missing = [package for package in expected_exports if package not in declared]
        extra = [package for package in declared if package not in expected_exports]
        if missing:
            errors.append(
                "fineract-core Export-Package missing unique kernel packages: "
                + ", ".join(missing)
            )
        if extra:
            errors.append(
                "fineract-core Export-Package has unexpected packages: " + ", ".join(extra)
            )

    print(f"Scanned {len(rows)} OSGi Gradle manifests, {len(exporters)} exported packages.")
    if warnings:
        print(f"WARNINGS ({len(warnings)}):")
        for item in warnings:
            print(f"  - {item}")
    if errors:
        print(f"ERRORS ({len(errors)}):")
        for item in errors:
            print(f"  - {item}")
        return 1
    print("OK — no blocking OSGi manifest violations.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
