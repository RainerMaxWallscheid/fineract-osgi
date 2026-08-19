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

"""B4 Gradle/api-first guard (ADR-022).

Scans fineract-*/{api,impl}/dependencies.gradle.

Fails on:
  * any *-api compile/runtime dependency on a *-impl project
  * a domain *-impl dependency on a foreign *-impl that is not in
    osgi/foreign-impl-allowlist.txt (leftover JPA residual)
  * a stale allowlist entry that is no longer a Gradle edge

Composition roots (provider, war) and test fragments are not scanned.
Do not add allowlist rows to avoid retargeting; shrink the file when an
edge becomes api-only.

Usage:
    python3 osgi/check-foreign-impl-deps.py
    ./gradlew checkForeignImplDeps
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ALLOWLIST = ROOT / "osgi" / "foreign-impl-allowlist.txt"

DEP_RE = re.compile(
    r"(implementation|api|compileOnly|runtimeOnly)\(\s*project\(\s*path:\s*':(fineract-[^']+-impl)'"
)
MODULE_RE = re.compile(r"(fineract-[^/]+)/(api|impl)/dependencies\.gradle$")


def load_allowlist() -> set[tuple[str, str]]:
    allowed: set[tuple[str, str]] = set()
    for raw in ALLOWLIST.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        consumer, target = line.split()
        allowed.add((consumer, target))
    return allowed


def scan_edges() -> tuple[list[tuple[str, str]], list[tuple[str, str]]]:
    """Return (api_to_impl, impl_to_foreign_impl)."""
    api_hits: list[tuple[str, str]] = []
    impl_hits: list[tuple[str, str]] = []
    for path in sorted(ROOT.rglob("dependencies.gradle")):
        rel = path.relative_to(ROOT).as_posix()
        if "/build/" in rel:
            continue
        match = MODULE_RE.search(rel)
        if match is None:
            continue
        stem, kind = match.group(1), match.group(2)
        own_impl = f"{stem}-impl"
        for line in path.read_text(encoding="utf-8").splitlines():
            dep = DEP_RE.search(line)
            if dep is None:
                continue
            target = dep.group(2)
            if kind == "api":
                api_hits.append((rel, target))
                continue
            if target == own_impl:
                continue
            impl_hits.append((rel, target))
    return api_hits, impl_hits


def main() -> int:
    if not ALLOWLIST.is_file():
        print(f"FAIL: missing allowlist {ALLOWLIST}", file=sys.stderr)
        return 1
    allowed = load_allowlist()
    api_hits, impl_hits = scan_edges()
    errors: list[str] = []
    for consumer, target in api_hits:
        errors.append(f"api {consumer} must not depend on {target}")
    seen = set(impl_hits)
    for consumer, target in impl_hits:
        if (consumer, target) not in allowed:
            errors.append(f"new foreign impl edge {consumer} -> {target}")
    for consumer, target in sorted(allowed - seen):
        errors.append(f"stale allowlist entry {consumer} -> {target}")
    if errors:
        print("FAIL: foreign -impl dependency guard (ADR-022 B4)", file=sys.stderr)
        for err in errors:
            print(f"  {err}", file=sys.stderr)
        return 1
    print(f"OK: {len(impl_hits)} leftover-JPA foreign -impl edges allow-listed; no api->impl")
    return 0


if __name__ == "__main__":
    sys.exit(main())
