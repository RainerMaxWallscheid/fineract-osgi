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

"""Bounded Equinox resolve / start smoke (ADR-022).

Compiles and runs ``EquinoxResolveSmoke`` against the staged api/impl/core
catalog. Installs and resolves bundles. ``--start`` also starts them (no
Spring, so ``*OsgiServiceRegistrar`` does not fire) and probes pilot ports
in the Service Registry. ``--start`` fails when any pilot port is unpublished.
Writes ``osgi/logs/resolve-smoke.txt``.

Usage:
    python3 osgi/resolve-smoke.py
    python3 osgi/resolve-smoke.py --strict
    python3 osgi/resolve-smoke.py --start --strict
    ./gradlew equinoxResolveSmoke
    ./gradlew equinoxStartSmoke
"""

from __future__ import annotations

import argparse
import os
import subprocess
import sys
import tempfile
import urllib.request
from pathlib import Path

OSGI_DIR = Path(__file__).resolve().parent
EQUINOX_URL = (
    "https://repo1.maven.org/maven2/org/eclipse/platform/"
    "org.eclipse.osgi/3.20.0/org.eclipse.osgi-3.20.0.jar"
)
EQUINOX_NAME = "org.eclipse.osgi-3.20.0.jar"
SOURCE = OSGI_DIR / "EquinoxResolveSmoke.java"


def ensure_equinox_jar() -> Path:
    dest = OSGI_DIR / "equinox" / EQUINOX_NAME
    if dest.is_file() and dest.stat().st_size > 0:
        return dest
    dest.parent.mkdir(parents=True, exist_ok=True)
    print(f"Downloading Equinox to {dest} ...")
    urllib.request.urlretrieve(EQUINOX_URL, dest)
    return dest


def require_staged() -> None:
    if not list((OSGI_DIR / "bundles").glob("*.jar")):
        raise SystemExit(
            "No jars in osgi/bundles/. Run ./gradlew osgiStageBundles first."
        )
    config = OSGI_DIR / "config" / "config.ini"
    if not config.is_file() or "osgi.bundles=" not in config.read_text(encoding="utf-8"):
        raise SystemExit(
            "osgi/config/config.ini has no osgi.bundles. Run ./gradlew osgiStageBundles."
        )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--strict",
        action="store_true",
        help="fail if any org.apache.fineract.* bundle is INSTALLED (or not ACTIVE with --start)",
    )
    parser.add_argument(
        "--start",
        action="store_true",
        help="start staged bundles after resolve; fail if a pilot OSGi service is missing",
    )
    args = parser.parse_args()
    require_staged()
    equinox = ensure_equinox_jar()
    if not SOURCE.is_file():
        raise SystemExit(f"Missing {SOURCE}")

    (OSGI_DIR / "logs").mkdir(parents=True, exist_ok=True)
    java_args = [str(OSGI_DIR)]
    if args.start:
        java_args.append("--start")
    with tempfile.TemporaryDirectory(prefix="equinox-smoke-classes-") as tmp:
        compile_cmd = ["javac", "--release", "21", "-cp", str(equinox), "-d", tmp, str(SOURCE)]
        compiled = subprocess.run(compile_cmd, capture_output=True, text=True)
        if compiled.returncode != 0:
            sys.stderr.write(compiled.stderr)
            raise SystemExit("javac EquinoxResolveSmoke.java failed")
        run = subprocess.run(
            ["java", "-cp", f"{tmp}{os.pathsep}{equinox}", "EquinoxResolveSmoke", *java_args],
            capture_output=True,
            text=True,
        )

    output = (run.stdout or "") + (run.stderr or "")
    log_path = OSGI_DIR / "logs" / "resolve-smoke.txt"
    log_path.write_text(output, encoding="utf-8")
    print(output, end="" if output.endswith("\n") else "\n")
    print(f"Wrote {log_path}")
    if run.returncode != 0:
        return run.returncode
    if args.strict:
        if args.start:
            not_active = [
                line
                for line in output.splitlines()
                if line.startswith(("INSTALLED org.apache.fineract.", "RESOLVED org.apache.fineract."))
            ]
            if not_active:
                return 1
        else:
            installed = [
                line
                for line in output.splitlines()
                if line.startswith("INSTALLED org.apache.fineract.")
            ]
            if installed:
                return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
