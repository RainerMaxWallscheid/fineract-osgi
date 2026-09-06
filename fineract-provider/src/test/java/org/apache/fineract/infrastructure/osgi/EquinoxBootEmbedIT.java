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
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assumptions.assumeTrue;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Optional;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionData;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort;
import org.junit.jupiter.api.Test;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.context.TestPropertySource;

/**
 * Boot-embed slice: {@code fineract.osgi.enabled=true} starts in-process Equinox, injects the {@code @Primary}
 * ChargeDefinitionPort façade, and ranks the Spring adapter over the empty catalog when
 * {@code fineract.osgi.catalog-dir} is staged.
 */
@SpringBootTest(classes = EquinoxBootEmbedIT.BootEmbedApp.class, webEnvironment = SpringBootTest.WebEnvironment.NONE)
@TestPropertySource(properties = "fineract.osgi.enabled=true")
class EquinoxBootEmbedIT {

    @DynamicPropertySource
    static void catalogDir(final DynamicPropertyRegistry registry) {
        final Path catalog = stagedCatalog();
        if (Files.isRegularFile(catalog.resolve("config").resolve("config.ini"))) {
            registry.add("fineract.osgi.catalog-dir", () -> catalog.toAbsolutePath().toString());
        }
    }

    @Autowired
    private ChargeDefinitionPort charge;

    @Autowired
    private EquinoxFrameworkLifecycle lifecycle;

    @Test
    void primaryFacadeDelegatesToPublishedSpringAdapter() {
        assertTrue(charge instanceof OsgiBackedPort);
        assertTrue(lifecycle.isRunning());
        assertTrue(charge.existsActiveCharge(7L));
        assertFalse(charge.existsActiveCharge(1L));
        final BundleContext ctx = lifecycle.getBundleContext();
        final ServiceReference<ChargeDefinitionPort> selected = ctx.getServiceReference(ChargeDefinitionPort.class);
        assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
        final ChargeDefinitionPort adapter = ctx.getService(selected);
        assertFalse(adapter instanceof OsgiBackedPort);
        assertTrue(adapter.existsActiveCharge(7L));
        ctx.ungetService(selected);
    }

    @Test
    void stagedCatalogDoesNotOutrankSpringAdapter() {
        assumeTrue(Files.isRegularFile(stagedCatalog().resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
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
        assertTrue(ctx.getService(selected).existsActiveCharge(7L));
        ctx.ungetService(selected);
    }

    @SpringBootConfiguration
    @Import({ EquinoxOsgiConfiguration.class, OsgiBackedPortConfiguration.class })
    static class BootEmbedApp {

        @Bean
        ChargeDefinitionPort hostedChargeDefinitionPort() {
            return new ChargeDefinitionPort() {

                @Override
                public boolean existsActiveCharge(final Long chargeId) {
                    return chargeId != null && chargeId == 7L;
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
        }
    }

    private static Path stagedCatalog() {
        final Path cwd = Path.of("").toAbsolutePath();
        final Path here = cwd.resolve("osgi");
        if (Files.isRegularFile(here.resolve("config").resolve("config.ini"))) {
            return here;
        }
        return cwd.getParent() == null ? here : cwd.getParent().resolve("osgi");
    }
}
