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

"""Composition-root Equinox bridge smoke (ADR-022 B3).

Starts the staged catalog, then registers every hosted PILOT_PORT from the
composition-root classpath. Fails when Felix SCR or a fineract bundle is
not ACTIVE. Does not stage Spring.
``ContentStreamPort`` stays empty-catalog only. Writes
``osgi/logs/spring-bridge-smoke.txt``.

Usage:
    python3 osgi/spring-bridge-smoke.py
    ./gradlew equinoxSpringBridgeSmoke
"""

from __future__ import annotations

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


def one_jar(pattern: str) -> Path:
    matches = sorted((OSGI_DIR / "bundles").glob(pattern))
    if not matches:
        raise SystemExit(f"Missing staged jar {pattern}. Run ./gradlew osgiStageBundles.")
    return matches[-1]


def main() -> int:
    require_staged()
    equinox = ensure_equinox_jar()
    sources = sorted(OSGI_DIR.glob("Hosted*.java")) + [
        OSGI_DIR / "CompositionRootOsgiBridge.java",
        OSGI_DIR / "EquinoxSpringBridgeSmoke.java",
    ]
    missing = [str(src) for src in sources if not src.is_file()]
    if missing:
        raise SystemExit("Missing " + ", ".join(missing))

    api_jars = sorted((OSGI_DIR / "bundles").glob("fineract-*-api-*.jar"))
    if not api_jars:
        raise SystemExit("Missing staged fineract-*-api-*.jar. Run ./gradlew osgiStageBundles.")
    core = one_jar("fineract-core-*.jar")
    compile_cp = os.pathsep.join([str(equinox), *(str(jar) for jar in api_jars), str(core)])
    run_cp_prefix = compile_cp

    (OSGI_DIR / "logs").mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix="equinox-bridge-smoke-classes-") as tmp:
        compile_cmd = [
            "javac",
            "--release",
            "21",
            "-cp",
            compile_cp,
            "-d",
            tmp,
            *(str(src) for src in sources),
        ]
        compiled = subprocess.run(compile_cmd, capture_output=True, text=True)
        if compiled.returncode != 0:
            sys.stderr.write(compiled.stderr)
            raise SystemExit("javac EquinoxSpringBridgeSmoke sources failed")
        run = subprocess.run(
            [
                "java",
                "-cp",
                f"{tmp}{os.pathsep}{run_cp_prefix}",
                "EquinoxSpringBridgeSmoke",
                str(OSGI_DIR),
            ],
            capture_output=True,
            text=True,
        )

    output = (run.stdout or "") + (run.stderr or "")
    log_path = OSGI_DIR / "logs" / "spring-bridge-smoke.txt"
    log_path.write_text(output, encoding="utf-8")
    print(output, end="" if output.endswith("\n") else "\n")
    print(f"Wrote {log_path}")
    return run.returncode


if __name__ == "__main__":
    sys.exit(main())
