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

Scans fineract-*/{api,impl,test}/build.gradle plus fineract-command-integrationtest.
Fails on:
  * missing / duplicate Bundle-SymbolicName
  * BSN that does not match the Gradle module stem
  * test fragment whose Fragment-Host is missing or does not resolve
  * impl Export-Package that is not exactly one *.impl.osgi package
  * impl-involved cross-stem Export-Package (split packages)
  * new api-api Export-Package collisions that are not allow-listed

Known same-package type splits that still live in two *-api bundles are
printed as residuals (do not fail until the allow-list entry is removed
or the exporter set changes).

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

# Same-package types still split across two *-api bundles. Equinox resolve of
# the full catalog still needs these types moved to unique packages. The check
# fails if the exporter set changes (new collision or unexpected extra stem).
KNOWN_API_SPLITS: dict[str, frozenset[str]] = {
    "org.apache.fineract.infrastructure.jobs.exception": frozenset({"loan", "jobs"}),
    "org.apache.fineract.portfolio.charge.exception": frozenset({"charge", "savings"}),
    "org.apache.fineract.portfolio.loanaccount.data": frozenset({"loan", "progressiveloan"}),
    "org.apache.fineract.portfolio.loanaccount.service": frozenset({"loan", "progressiveloan"}),
    "org.apache.fineract.portfolio.loanaccount.loanschedule.data": frozenset(
        {"loan", "progressiveloan"}
    ),
}

ATTR_KEYS = (
    "Bundle-SymbolicName",
    "Fragment-Host",
    "Export-Package",
    "Bundle-Version",
    "Automatic-Module-Name",
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
    return rows


def load_row(build: Path, layout_role: str) -> dict:
    text = build.read_text(encoding="utf-8")
    attrs = extract_attrs(text)
    module_dir = build.parent.name if layout_role == "support" else build.parent.parent.name
    return {
        "path": str(build.relative_to(ROOT)),
        "module": module_dir,
        "layout_role": layout_role,
        "expected_stem": gradle_stem(module_dir),
        "bsn": attrs.get("Bundle-SymbolicName"),
        "fragment_host": attrs.get("Fragment-Host"),
        "exports": parse_export_packages(attrs.get("Export-Package")),
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

    exporters: dict[str, list[dict]] = defaultdict(list)
    for row in rows:
        for package in row["exports"]:
            exporters[package].append(row)

    for row in rows:
        if row["layout_role"] != "impl":
            continue
        exports = row["exports"]
        if len(exports) != 1:
            errors.append(
                f"{row['path']}: impl Export-Package must be exactly one registrar "
                f"package, got {exports or ['<empty>']}"
            )
            continue
        package = exports[0]
        if not package.endswith(".impl.osgi"):
            errors.append(
                f"{row['path']}: impl Export-Package {package} must end with .impl.osgi"
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
            errors.append(f"new api-api split Export-Package {package}: {owner_desc}")
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
