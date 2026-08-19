/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.apache.fineract.infrastructure.osgi;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.wiring.FrameworkWiring;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Installs and starts a staged Equinox catalog ({@code config/config.ini}
 * from {@code :osgiStageBundles}). Spring is not staged. Missing catalog
 * is a no-op so Boot can run without {@code osgi/bundles}.
 */
final class EquinoxCatalogInstaller {

    private static final Logger LOG = LoggerFactory.getLogger(EquinoxCatalogInstaller.class);
    private static final Pattern BUNDLE_REF = Pattern.compile("reference:file:([^@,\\s]+)(?:@[^,]*)?");

    private EquinoxCatalogInstaller() {}

    static int installAndStart(final BundleContext context, final Path osgiDir) {
        final Path configIni = osgiDir.resolve("config").resolve("config.ini");
        if (!Files.isRegularFile(configIni)) {
            LOG.info("No staged Equinox catalog at {}; Spring ports only", configIni);
            return 0;
        }
        final List<String> locations;
        try {
            locations = parseBundleLocations(Files.readString(configIni));
        } catch (final IOException ex) {
            LOG.warn("Could not read {}; skipping catalog install: {}", configIni, ex.toString());
            return 0;
        }
        if (locations.isEmpty()) {
            LOG.info("Staged catalog {} has no osgi.bundles; Spring ports only", configIni);
            return 0;
        }
        int installFailures = 0;
        for (final String location : locations) {
            try {
                context.installBundle(location);
            } catch (final Exception ex) {
                installFailures++;
                LOG.warn("INSTALL_FAIL {} {}", location, ex.toString());
            }
        }
        final FrameworkWiring wiring = context.getBundle().adapt(FrameworkWiring.class);
        if (wiring != null) {
            wiring.resolveBundles(null);
        }
        int startFailures = 0;
        for (final Bundle bundle : context.getBundles()) {
            if (bundle.getBundleId() == 0) {
                continue;
            }
            try {
                bundle.start();
            } catch (final Exception ex) {
                startFailures++;
                LOG.warn("START_FAIL {} {}", bundle.getSymbolicName(), ex.toString());
            }
        }
        LOG.info("Staged Equinox catalog: locations={} installFailures={} startFailures={}", locations.size(), installFailures,
                startFailures);
        return locations.size();
    }

    static List<String> parseBundleLocations(final String ini) {
        String bundlesLine = null;
        for (final String raw : ini.split("\\R")) {
            if (raw.startsWith("osgi.bundles=")) {
                bundlesLine = raw.substring("osgi.bundles=".length());
                break;
            }
        }
        if (bundlesLine == null) {
            return List.of();
        }
        final List<String> locations = new ArrayList<>();
        final Matcher matcher = BUNDLE_REF.matcher(bundlesLine);
        while (matcher.find()) {
            locations.add("reference:file:" + matcher.group(1));
        }
        return locations;
    }
}
