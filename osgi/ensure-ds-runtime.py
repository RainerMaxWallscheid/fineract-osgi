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

"""Download Felix SCR + OSGi DS API jars into osgi/equinox/ (not git).

ADR-022 B6. Start level 1, before fineract-core. Prints absolute paths
one per line for :osgiStageBundles.
"""

from __future__ import annotations

import urllib.request
from pathlib import Path

OSGI_DIR = Path(__file__).resolve().parent
MAVEN = "https://repo1.maven.org/maven2"
JARS = (
    ("org/osgi/org.osgi.util.function/1.2.0/org.osgi.util.function-1.2.0.jar", "org.osgi.util.function-1.2.0.jar"),
    ("org/osgi/org.osgi.util.promise/1.3.0/org.osgi.util.promise-1.3.0.jar", "org.osgi.util.promise-1.3.0.jar"),
    ("org/osgi/org.osgi.service.component/1.5.1/org.osgi.service.component-1.5.1.jar", "org.osgi.service.component-1.5.1.jar"),
    ("org/apache/felix/org.apache.felix.scr/2.2.12/org.apache.felix.scr-2.2.12.jar", "org.apache.felix.scr-2.2.12.jar"),
)


def ensure() -> list[Path]:
    dest_dir = OSGI_DIR / "equinox"
    dest_dir.mkdir(parents=True, exist_ok=True)
    paths: list[Path] = []
    for rel, name in JARS:
        dest = dest_dir / name
        if not dest.is_file() or dest.stat().st_size == 0:
            print(f"Downloading DS runtime {name} ...", file=__import__("sys").stderr, flush=True)
            urllib.request.urlretrieve(f"{MAVEN}/{rel}", dest)
        paths.append(dest)
    return paths


def main() -> int:
    for path in ensure():
        print(path)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
