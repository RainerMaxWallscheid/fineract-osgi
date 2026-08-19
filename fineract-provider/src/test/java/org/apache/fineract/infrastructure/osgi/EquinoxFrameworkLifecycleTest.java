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

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assumptions.assumeTrue;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.Optional;
import org.apache.fineract.investor.service.DelayedSettlementAttributeService;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionData;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort;
import org.junit.jupiter.api.Test;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceReference;

class EquinoxFrameworkLifecycleTest {

    @Test
    void parseBundleLocationsReadsReferenceFileEntries() {
        final var locations = EquinoxCatalogInstaller.parseBundleLocations(
                "osgi.bundles=reference:file:/tmp/a.jar@2:start,reference:file:/tmp/b.jar@3:start\n");
        assertEquals(2, locations.size());
        assertEquals("reference:file:/tmp/a.jar", locations.get(0));
        assertEquals("reference:file:/tmp/b.jar", locations.get(1));
    }

    @Test
    void registersWave1ChargePortAndUnbindsOnStop() {
        final ChargeDefinitionPort charge = new StubChargeDefinitionPort();
        final DelayedSettlementAttributeService delayed = id -> true;
        final SpringOsgiPortBridge bridge = wave2Bridge(charge, delayed);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            final ServiceReference<ChargeDefinitionPort> selected = ctx.getServiceReference(ChargeDefinitionPort.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertEquals(SpringOsgiPortBridge.RANKING, selected.getProperty(Constants.SERVICE_RANKING));
            assertSame(charge, ctx.getService(selected));
            ctx.ungetService(selected);
            final ServiceReference<DelayedSettlementAttributeService> delayedRef = ctx
                    .getServiceReference(DelayedSettlementAttributeService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, delayedRef.getProperty("provider"));
            assertSame(delayed, ctx.getService(delayedRef));
            ctx.ungetService(delayedRef);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void lookupFindsWave1ChargePortAndIsEmptyAfterStop() {
        final ChargeDefinitionPort charge = new StubChargeDefinitionPort();
        final SpringOsgiPortBridge bridge = wave2Bridge(charge, null);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);

        assertTrue(lookup.find(ChargeDefinitionPort.class).isEmpty());
        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            assertSame(charge, lookup.find(ChargeDefinitionPort.class).orElseThrow());
            assertTrue(lookup.find(DelayedSettlementAttributeService.class).isEmpty());
        } finally {
            lifecycle.stop();
        }
        assertTrue(lookup.find(ChargeDefinitionPort.class).isEmpty());
    }

    @Test
    void osgiBackedChargePortDelegatesAfterStartAndNoopsAfterStop() {
        final ChargeDefinitionPort charge = new ChargeDefinitionPort() {

            @Override
            public boolean existsActiveCharge(final Long chargeId) {
                return true;
            }

            @Override
            public Optional<ChargeDefinitionData> findActiveCharge(final Long chargeId) {
                return Optional.empty();
            }

            @Override
            public Optional<ChargeDefinitionData> findCharge(final Long chargeId) {
                return Optional.empty();
            }

            @Override
            public ChargeDefinitionData getActiveCharge(final Long chargeId) {
                return null;
            }
        };
        final SpringOsgiPortBridge bridge = wave2Bridge(charge, null);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final ChargeDefinitionPort backed = OsgiBackedPortFactory.of(lookup, ChargeDefinitionPort.class,
                new EmptyChargeDefinitionPort());

        assertFalse(backed.existsActiveCharge(1L));
        assertTrue(backed instanceof OsgiBackedPort);
        lifecycle.start();
        try {
            assertTrue(backed.existsActiveCharge(1L));
            final ServiceReference<ChargeDefinitionPort> selected = lifecycle.getBundleContext()
                    .getServiceReference(ChargeDefinitionPort.class);
            assertSame(charge, lifecycle.getBundleContext().getService(selected));
            lifecycle.getBundleContext().ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(backed.existsActiveCharge(1L));
    }

    @Test
    void bridgeDoesNotPublishOsgiBackedChargePort() {
        final ChargeDefinitionPort backed = OsgiBackedPortFactory.of(new OsgiServiceLookup(() -> null), ChargeDefinitionPort.class,
                new EmptyChargeDefinitionPort());
        final SpringOsgiPortBridge bridge = new SpringOsgiPortBridge(
                List.of(SpringOsgiPortBridge.bind(ChargeDefinitionPort.class, backed)));
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            assertEquals(null, lifecycle.getBundleContext().getServiceReference(ChargeDefinitionPort.class));
        } finally {
            lifecycle.stop();
        }
    }

    @Test
    void stagedCatalogStartsAndSpringChargePortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final ChargeDefinitionPort charge = new StubChargeDefinitionPort();
        final SpringOsgiPortBridge bridge = wave2Bridge(charge, null);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean chargeImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.charge.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    chargeImplActive = true;
                    break;
                }
            }
            assertTrue(chargeImplActive);
            final ServiceReference<ChargeDefinitionPort> selected = ctx.getServiceReference(ChargeDefinitionPort.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(charge, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    private static SpringOsgiPortBridge wave2Bridge(final ChargeDefinitionPort charge, final DelayedSettlementAttributeService delayed) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(ChargeDefinitionPort.class, charge),
                SpringOsgiPortBridge.bind(DelayedSettlementAttributeService.class, delayed)));
    }

    private static Path stagedCatalog() {
        final Path cwd = Path.of("").toAbsolutePath();
        final Path here = cwd.resolve("osgi");
        if (Files.isRegularFile(here.resolve("config").resolve("config.ini"))) {
            return here;
        }
        return cwd.getParent() == null ? here : cwd.getParent().resolve("osgi");
    }

    private static final class StubChargeDefinitionPort implements ChargeDefinitionPort {

        @Override
        public boolean existsActiveCharge(final Long chargeId) {
            return false;
        }

        @Override
        public Optional<ChargeDefinitionData> findActiveCharge(final Long chargeId) {
            return Optional.empty();
        }

        @Override
        public Optional<ChargeDefinitionData> findCharge(final Long chargeId) {
            return Optional.empty();
        }

        @Override
        public ChargeDefinitionData getActiveCharge(final Long chargeId) {
            return null;
        }
    }
}
