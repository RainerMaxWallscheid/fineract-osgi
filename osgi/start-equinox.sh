#!/bin/bash
echo "Starting Equinox OSGi Framework for fineract-osgi..."

java \
  -Xmx2g \
  -XX:+UseG1GC \
  -jar osgi/equinox/org.eclipse.osgi-*.jar \
  -console 2501 \
  -clean \
  -configuration osgi/equinox/config.ini
