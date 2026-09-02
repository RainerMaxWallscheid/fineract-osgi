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
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assumptions.assumeTrue;

import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import org.apache.fineract.infrastructure.contentstore.data.ContentStoreType;
import org.apache.fineract.infrastructure.contentstore.service.ContentStoreService;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;
import org.apache.fineract.infrastructure.springbatch.PropertyService;
import org.apache.fineract.investor.service.DelayedSettlementAttributeService;
import org.apache.fineract.organisation.teller.moduleapi.CashierTxnValidationPort;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionData;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort;
import org.apache.fineract.portfolio.floatingrates.data.FloatingRateDTO;
import org.apache.fineract.portfolio.floatingrates.data.FloatingRatePeriodData;
import org.apache.fineract.portfolio.floatingrates.moduleapi.FloatingRateDefinitionData;
import org.apache.fineract.portfolio.floatingrates.moduleapi.FloatingRatePort;
import org.apache.fineract.portfolio.tax.moduleapi.TaxCatalogPort;
import org.apache.fineract.portfolio.tax.moduleapi.TaxComponentDefinitionData;
import org.apache.fineract.portfolio.tax.moduleapi.TaxGroupDefinitionData;
import org.apache.fineract.portfolio.transfer.service.TransferWritePlatformService;
import org.junit.jupiter.api.Test;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceReference;

class EquinoxFrameworkLifecycleTest {

    @Test
    void parseBundleLocationsReadsReferenceFileEntries() {
        final var locations = EquinoxCatalogInstaller
                .parseBundleLocations("osgi.bundles=reference:file:/tmp/a.jar@2:start,reference:file:/tmp/b.jar@3:start\n");
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
        final ChargeDefinitionPort backed = OsgiBackedPortFactory.of(lookup, ChargeDefinitionPort.class);

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
    void ownedSkipsOsgiBackedPort() {
        final ChargeDefinitionPort spring = new StubChargeDefinitionPort();
        final ChargeDefinitionPort proxy = OsgiBackedPortFactory.of(new OsgiServiceLookup(() -> null), ChargeDefinitionPort.class);
        assertSame(spring, SpringOsgiPortBridge.owned(List.of(proxy, spring)));
        assertNull(SpringOsgiPortBridge.owned(List.of(proxy)));
        assertNull(SpringOsgiPortBridge.owned(List.of()));
    }

    @Test
    void lazyOwnedBindingPublishesSpringPortNotLookupProxy() {
        final ChargeDefinitionPort spring = new StubChargeDefinitionPort();
        final ChargeDefinitionPort proxy = OsgiBackedPortFactory.of(new OsgiServiceLookup(() -> null), ChargeDefinitionPort.class);
        final SpringOsgiPortBridge bridge = new SpringOsgiPortBridge(List
                .of(SpringOsgiPortBridge.bindLater(ChargeDefinitionPort.class, () -> SpringOsgiPortBridge.owned(List.of(proxy, spring)))));
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final ServiceReference<ChargeDefinitionPort> selected = lifecycle.getBundleContext()
                    .getServiceReference(ChargeDefinitionPort.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(spring, lifecycle.getBundleContext().getService(selected));
            lifecycle.getBundleContext().ungetService(selected);
        } finally {
            lifecycle.stop();
        }
    }

    @Test
    void chargeLookupFacadeDelegatesToPublishedSpringPort() {
        final ChargeDefinitionPort spring = new ChargeDefinitionPort() {

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
        final SpringOsgiPortBridge bridge = wave2Bridge(spring, null);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final ChargeDefinitionPort facade = OsgiBackedPortFactory.of(lookup, ChargeDefinitionPort.class);

        assertFalse(facade.existsActiveCharge(7L));
        lifecycle.start();
        try {
            assertTrue(facade.existsActiveCharge(7L));
            assertFalse(facade.existsActiveCharge(1L));
        } finally {
            lifecycle.stop();
        }
        assertFalse(facade.existsActiveCharge(7L));
    }

    @Test
    void bridgeDoesNotPublishOsgiBackedChargePort() {
        final ChargeDefinitionPort backed = OsgiBackedPortFactory.of(new OsgiServiceLookup(() -> null), ChargeDefinitionPort.class);
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
    void ratesLookupFacadeDelegatesToPublishedSpringPort() {
        final FloatingRatePort spring = new FloatingRatePort() {

            @Override
            public Optional<FloatingRateDefinitionData> findFloatingRate(final Long floatingRateId) {
                return floatingRateId != null && floatingRateId == 7L
                        ? Optional.of(new FloatingRateDefinitionData(7L, "hosted", true, true))
                        : Optional.empty();
            }

            @Override
            public Optional<FloatingRateDefinitionData> findBaseLendingRate() {
                return Optional.empty();
            }

            @Override
            public FloatingRateDefinitionData getFloatingRate(final Long floatingRateId) {
                return null;
            }

            @Override
            public Collection<FloatingRatePeriodData> fetchInterestRates(final Long floatingRateId, final FloatingRateDTO floatingRateDTO) {
                return Collections.emptyList();
            }
        };
        final SpringOsgiPortBridge bridge = ratesBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final FloatingRatePort facade = OsgiBackedPortFactory.of(lookup, FloatingRatePort.class);

        assertTrue(facade.findFloatingRate(7L).isEmpty());
        lifecycle.start();
        try {
            assertTrue(facade.findFloatingRate(7L).isPresent());
            assertTrue(facade.findFloatingRate(1L).isEmpty());
        } finally {
            lifecycle.stop();
        }
        assertTrue(facade.findFloatingRate(7L).isEmpty());
    }

    @Test
    void taxLookupFacadeDelegatesToPublishedSpringPort() {
        final TaxCatalogPort spring = new TaxCatalogPort() {

            @Override
            public Optional<TaxGroupDefinitionData> findTaxGroup(final Long taxGroupId) {
                return taxGroupId != null && taxGroupId == 7L ? Optional.of(new TaxGroupDefinitionData(7L, "hosted")) : Optional.empty();
            }

            @Override
            public TaxGroupDefinitionData getTaxGroup(final Long taxGroupId) {
                return null;
            }

            @Override
            public Optional<TaxComponentDefinitionData> findTaxComponent(final Long taxComponentId) {
                return Optional.empty();
            }

            @Override
            public TaxComponentDefinitionData getTaxComponent(final Long taxComponentId) {
                return null;
            }
        };
        final SpringOsgiPortBridge bridge = taxBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final TaxCatalogPort facade = OsgiBackedPortFactory.of(lookup, TaxCatalogPort.class);

        assertTrue(facade.findTaxGroup(7L).isEmpty());
        lifecycle.start();
        try {
            assertTrue(facade.findTaxGroup(7L).isPresent());
            assertTrue(facade.findTaxGroup(1L).isEmpty());
        } finally {
            lifecycle.stop();
        }
        assertTrue(facade.findTaxGroup(7L).isEmpty());
    }

    @Test
    void contentStoreLookupFacadeDelegatesToPublishedSpringPort() {
        final ContentStoreService spring = new ContentStoreService() {

            @Override
            public InputStream download(final String path) {
                return null;
            }

            @Override
            public String upload(final String path, final InputStream is, final String mimeType) {
                return path;
            }

            @Override
            public void delete(final String path) {}

            @Override
            public ContentStoreType getType() {
                return ContentStoreType.S3;
            }
        };
        final SpringOsgiPortBridge bridge = contentBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final ContentStoreService facade = OsgiBackedPortFactory.of(lookup, ContentStoreService.class);

        assertEquals(null, facade.getType());
        lifecycle.start();
        try {
            assertEquals(ContentStoreType.S3, facade.getType());
        } finally {
            lifecycle.stop();
        }
        assertEquals(null, facade.getType());
    }

    @Test
    void cashierLookupFacadeDelegatesToPublishedSpringPort() {
        final RecordingCashierTxnValidationPort spring = new RecordingCashierTxnValidationPort();
        final SpringOsgiPortBridge bridge = cashierBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final CashierTxnValidationPort facade = OsgiBackedPortFactory.of(lookup, CashierTxnValidationPort.class);

        facade.validateOnLoanDisbursal(7L, "USD", BigDecimal.TEN);
        assertEquals(null, spring.lastStaffId);
        lifecycle.start();
        try {
            facade.validateOnLoanDisbursal(7L, "USD", BigDecimal.TEN);
            assertEquals(7L, spring.lastStaffId);
        } finally {
            lifecycle.stop();
        }
        spring.lastStaffId = null;
        facade.validateOnLoanDisbursal(7L, "USD", BigDecimal.TEN);
        assertEquals(null, spring.lastStaffId);
    }

    @Test
    void emptyFallbackReturnsOptionalCollectionCommandResultAndZero() {
        final FloatingRatePort rates = OsgiBackedPortFactory.empty(FloatingRatePort.class);
        assertTrue(rates.findFloatingRate(1L).isEmpty());
        assertTrue(rates.fetchInterestRates(1L, null).isEmpty());
        final TransferWritePlatformService transfers = OsgiBackedPortFactory.empty(TransferWritePlatformService.class);
        assertEquals(CommandProcessingResult.empty().getClass(), transfers.proposeClientTransfer(1L, null).getClass());
        assertEquals(0, OsgiBackedPortFactory.empty(PropertyService.class).getPartitionSize("hosted"));
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

    @Test
    void stagedCatalogStartsAndSpringRatesPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final FloatingRatePort rates = new StubFloatingRatePort();
        final SpringOsgiPortBridge bridge = ratesBridge(rates);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean ratesImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.rates.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    ratesImplActive = true;
                    break;
                }
            }
            assertTrue(ratesImplActive);
            final ServiceReference<FloatingRatePort> selected = ctx.getServiceReference(FloatingRatePort.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(rates, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringTaxPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final TaxCatalogPort tax = new StubTaxCatalogPort();
        final SpringOsgiPortBridge bridge = taxBridge(tax);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean taxImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.tax.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    taxImplActive = true;
                    break;
                }
            }
            assertTrue(taxImplActive);
            final ServiceReference<TaxCatalogPort> selected = ctx.getServiceReference(TaxCatalogPort.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(tax, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringContentStoreStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final ContentStoreService content = new StubContentStoreService();
        final SpringOsgiPortBridge bridge = contentBridge(content);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean documentImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.document.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    documentImplActive = true;
                    break;
                }
            }
            assertTrue(documentImplActive);
            final ServiceReference<ContentStoreService> selected = ctx.getServiceReference(ContentStoreService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(content, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringCashierPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final CashierTxnValidationPort cashier = new StubCashierTxnValidationPort();
        final SpringOsgiPortBridge bridge = cashierBridge(cashier);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean branchImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.branch.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    branchImplActive = true;
                    break;
                }
            }
            assertTrue(branchImplActive);
            final ServiceReference<CashierTxnValidationPort> selected = ctx.getServiceReference(CashierTxnValidationPort.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(cashier, ctx.getService(selected));
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

    private static SpringOsgiPortBridge ratesBridge(final FloatingRatePort rates) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(FloatingRatePort.class, rates)));
    }

    private static SpringOsgiPortBridge taxBridge(final TaxCatalogPort tax) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(TaxCatalogPort.class, tax)));
    }

    private static SpringOsgiPortBridge contentBridge(final ContentStoreService content) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(ContentStoreService.class, content)));
    }

    private static SpringOsgiPortBridge cashierBridge(final CashierTxnValidationPort cashier) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(CashierTxnValidationPort.class, cashier)));
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

    private static final class StubFloatingRatePort implements FloatingRatePort {

        @Override
        public Optional<FloatingRateDefinitionData> findFloatingRate(final Long floatingRateId) {
            return Optional.empty();
        }

        @Override
        public Optional<FloatingRateDefinitionData> findBaseLendingRate() {
            return Optional.empty();
        }

        @Override
        public FloatingRateDefinitionData getFloatingRate(final Long floatingRateId) {
            return null;
        }

        @Override
        public Collection<FloatingRatePeriodData> fetchInterestRates(final Long floatingRateId, final FloatingRateDTO floatingRateDTO) {
            return Collections.emptyList();
        }
    }

    private static final class StubTaxCatalogPort implements TaxCatalogPort {

        @Override
        public Optional<TaxGroupDefinitionData> findTaxGroup(final Long taxGroupId) {
            return Optional.empty();
        }

        @Override
        public TaxGroupDefinitionData getTaxGroup(final Long taxGroupId) {
            return null;
        }

        @Override
        public Optional<TaxComponentDefinitionData> findTaxComponent(final Long taxComponentId) {
            return Optional.empty();
        }

        @Override
        public TaxComponentDefinitionData getTaxComponent(final Long taxComponentId) {
            return null;
        }
    }

    private static final class StubContentStoreService implements ContentStoreService {

        @Override
        public InputStream download(final String path) {
            return null;
        }

        @Override
        public String upload(final String path, final InputStream is, final String mimeType) {
            return path;
        }

        @Override
        public void delete(final String path) {}

        @Override
        public ContentStoreType getType() {
            return ContentStoreType.FILE_SYSTEM;
        }
    }

    private static final class RecordingCashierTxnValidationPort implements CashierTxnValidationPort {

        Long lastStaffId;

        @Override
        public void validateOnLoanDisbursal(final Long staffId, final String currencyCode, final BigDecimal transactionAmount) {
            lastStaffId = staffId;
        }
    }

    private static final class StubCashierTxnValidationPort implements CashierTxnValidationPort {

        @Override
        public void validateOnLoanDisbursal(final Long staffId, final String currencyCode, final BigDecimal transactionAmount) {}
    }
}
