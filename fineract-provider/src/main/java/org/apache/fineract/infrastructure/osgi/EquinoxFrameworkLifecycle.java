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
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.ServiceLoader;
import org.osgi.framework.BundleContext;
import org.osgi.framework.Constants;
import org.osgi.framework.launch.Framework;
import org.osgi.framework.launch.FrameworkFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.SmartLifecycle;

/**
 * Optional in-process Equinox for the Boot composition root. Does not stage
 * Spring. When {@code catalogDir} points at a staged {@code osgi/} tree,
 * empty catalog activators start first; Wave-1 Spring ports then rank above
 * them.
 */
public class EquinoxFrameworkLifecycle implements SmartLifecycle {

    private static final Logger LOG = LoggerFactory.getLogger(EquinoxFrameworkLifecycle.class);

    private final SpringOsgiPortBridge bridge;
    private final Path catalogDir;
    private Framework framework;
    private boolean running;

    public EquinoxFrameworkLifecycle(final SpringOsgiPortBridge bridge) {
        this(bridge, null);
    }

    public EquinoxFrameworkLifecycle(final SpringOsgiPortBridge bridge, final Path catalogDir) {
        this.bridge = bridge;
        this.catalogDir = catalogDir;
    }

    @Override
    public void start() {
        if (running) {
            return;
        }
        final Iterator<FrameworkFactory> factories = ServiceLoader.load(FrameworkFactory.class).iterator();
        if (!factories.hasNext()) {
            LOG.warn("fineract.osgi.enabled=true but no OSGi FrameworkFactory is on the classpath");
            return;
        }
        try {
            final Path storage = Files.createTempDirectory("fineract-equinox-");
            final Map<String, String> cfg = new HashMap<>();
            cfg.put(Constants.FRAMEWORK_STORAGE, storage.toString());
            cfg.put(Constants.FRAMEWORK_STORAGE_CLEAN, Constants.FRAMEWORK_STORAGE_CLEAN_ONFIRSTINIT);
            cfg.put("osgi.console.enable.builtin", "false");
            framework = factories.next().newFramework(cfg);
            framework.init();
            framework.start();
            final BundleContext context = framework.getBundleContext();
            if (catalogDir != null) {
                EquinoxCatalogInstaller.installAndStart(context, catalogDir);
            }
            bridge.start(context);
            running = true;
            LOG.info("Embedded Equinox started; Wave-1 through Wave-5 Spring ports registered in the Service Registry");
        } catch (final Exception ex) {
            LOG.warn("Failed to start embedded Equinox; Boot continues without OSGi: {}", ex.toString());
            stopQuietly();
        }
    }

    @Override
    public void stop() {
        stopQuietly();
    }

    private void stopQuietly() {
        try {
            bridge.stop();
        } catch (final RuntimeException ignored) {
            // already stopped
        }
        if (framework != null) {
            try {
                framework.stop();
                framework.waitForStop(10_000);
            } catch (final InterruptedException ex) {
                Thread.currentThread().interrupt();
            } catch (final Exception ignored) {
                // already stopped
            }
            framework = null;
        }
        running = false;
    }

    @Override
    public boolean isRunning() {
        return running;
    }

    BundleContext getBundleContext() {
        return framework == null ? null : framework.getBundleContext();
    }
}
