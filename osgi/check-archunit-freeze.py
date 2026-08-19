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

"""B5 ArchUnit freeze-store budget (ADR-022).

Counts leftover-violation lines under
fineract-architecture/src/test/resources/archunit_store/ (not stored.rules).

Fails on:
  * more lines than osgi/archunit-freeze-budget.txt (new debt)
  * fewer lines than the budget (stale budget after a shrink)

Do not raise the budget to hide new coupling. Lower it when a residual
fix shrinks the store. Remaining lines are leftover JPA / entity residuals;
do not peel fineract-core or the composition root to force a shrink.

Usage:
    python3 osgi/check-archunit-freeze.py
    ./gradlew checkArchUnitFreeze
"""

from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
STORE = ROOT / "fineract-architecture" / "src" / "test" / "resources" / "archunit_store"
BUDGET = ROOT / "osgi" / "archunit-freeze-budget.txt"


def count_violations() -> int:
    total = 0
    for path in sorted(STORE.iterdir()):
        if not path.is_file() or path.name == "stored.rules" or path.name.startswith("."):
            continue
        total += sum(1 for line in path.read_text(encoding="utf-8").splitlines() if line.strip())
    return total


def load_budget() -> int:
    for raw in BUDGET.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if line and not line.startswith("#"):
            return int(line)
    raise ValueError(f"no budget number in {BUDGET}")


def main() -> int:
    if not STORE.is_dir():
        print(f"FAIL: missing freeze store {STORE}", file=sys.stderr)
        return 1
    if not BUDGET.is_file():
        print(f"FAIL: missing budget {BUDGET}", file=sys.stderr)
        return 1
    actual = count_violations()
    budget = load_budget()
    if actual > budget:
        print(
            f"FAIL: ArchUnit freeze store grew ({actual} > {budget}). "
            "New leftover coupling is B5 debt; do not raise the budget.",
            file=sys.stderr,
        )
        return 1
    if actual < budget:
        print(
            f"FAIL: stale freeze budget ({actual} < {budget}). "
            "Lower osgi/archunit-freeze-budget.txt after the shrink.",
            file=sys.stderr,
        )
        return 1
    print(f"OK: ArchUnit freeze store is {actual} leftover-violation lines")
    return 0


if __name__ == "__main__":
    sys.exit(main())
