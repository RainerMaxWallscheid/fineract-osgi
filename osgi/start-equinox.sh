#!/bin/bash
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

# Equinox -configuration must be a *directory* (the configuration area).
# Passing osgi/equinox/config.ini as that argument makes Equinox fail to start.

set -euo pipefail

OSGI_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "${OSGI_DIR}"

shopt -s nullglob
EQUINOX_JARS=(equinox/org.eclipse.osgi-*.jar)
if [ ${#EQUINOX_JARS[@]} -eq 0 ]; then
    echo "Missing Equinox framework JAR under osgi/equinox/." >&2
    echo "Download once:" >&2
    echo "  curl -L -o osgi/equinox/org.eclipse.osgi-3.20.0.jar \\" >&2
    echo "    https://repo1.maven.org/maven2/org/eclipse/platform/org.eclipse.osgi/3.20.0/org.eclipse.osgi-3.20.0.jar" >&2
    exit 1
fi

mkdir -p config logs bundles
if [ ! -f config/config.ini ]; then
    echo "Seeding osgi/config/config.ini from osgi/equinox/config.ini (no staged bundles)."
    echo "Run ./gradlew osgiStageBundles to copy api/impl/core jars and write osgi.bundles."
    cp equinox/config.ini config/config.ini
fi

echo "Starting Equinox OSGi Framework for fineract-osgi (console 2501)..."
exec java \
    -Xmx2g \
    -XX:+UseG1GC \
    -jar "${EQUINOX_JARS[0]}" \
    -console 2501 \
    -clean \
    -configuration config
