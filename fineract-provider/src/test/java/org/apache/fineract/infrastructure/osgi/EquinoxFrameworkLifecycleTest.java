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
import java.time.LocalDate;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.apache.fineract.accounting.closure.data.GLClosureData;
import org.apache.fineract.accounting.closure.service.GLClosureReadPlatformService;
import org.apache.fineract.adhocquery.data.AdHocData;
import org.apache.fineract.adhocquery.service.AdHocReadPlatformService;
import org.apache.fineract.cob.data.JobBusinessStepConfigData;
import org.apache.fineract.cob.data.JobBusinessStepDetail;
import org.apache.fineract.cob.service.ConfigJobParameterService;
import org.apache.fineract.infrastructure.accountnumberformat.data.AccountNumberFormatData;
import org.apache.fineract.infrastructure.accountnumberformat.domain.EntityAccountType;
import org.apache.fineract.infrastructure.accountnumberformat.service.AccountNumberFormatReadPlatformService;
import org.apache.fineract.infrastructure.businessdate.data.service.BusinessDateDTO;
import org.apache.fineract.infrastructure.businessdate.domain.BusinessDateType;
import org.apache.fineract.infrastructure.businessdate.service.BusinessDateReadPlatformService;
import org.apache.fineract.infrastructure.codes.data.CodeData;
import org.apache.fineract.infrastructure.codes.service.CodeReadPlatformService;
import org.apache.fineract.infrastructure.contentstore.data.ContentStoreType;
import org.apache.fineract.infrastructure.contentstore.service.ContentStoreService;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.infrastructure.security.service.AccessTokenGenerationService;
import org.apache.fineract.infrastructure.springbatch.PropertyService;
import org.apache.fineract.infrastructure.survey.data.LikelihoodData;
import org.apache.fineract.infrastructure.survey.service.ReadLikelihoodService;
import org.apache.fineract.investor.service.DelayedSettlementAttributeService;
import org.apache.fineract.mix.data.MixTaxonomyData;
import org.apache.fineract.mix.service.MixTaxonomyReadService;
import org.apache.fineract.notification.data.NotificationData;
import org.apache.fineract.notification.service.UserNotificationService;
import org.apache.fineract.organisation.monetary.data.CurrencyUpdateRequest;
import org.apache.fineract.organisation.monetary.data.CurrencyUpdateResponse;
import org.apache.fineract.organisation.monetary.service.CurrencyWritePlatformService;
import org.apache.fineract.organisation.provisioning.data.ProvisioningCategoryData;
import org.apache.fineract.organisation.provisioning.service.ProvisioningCategoryReadPlatformService;
import org.apache.fineract.organisation.teller.moduleapi.CashierTxnValidationPort;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionData;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort;
import org.apache.fineract.portfolio.floatingrates.data.FloatingRateDTO;
import org.apache.fineract.portfolio.floatingrates.data.FloatingRatePeriodData;
import org.apache.fineract.portfolio.floatingrates.moduleapi.FloatingRateDefinitionData;
import org.apache.fineract.portfolio.floatingrates.moduleapi.FloatingRatePort;
import org.apache.fineract.portfolio.fund.data.FundData;
import org.apache.fineract.portfolio.fund.service.FundReadPlatformService;
import org.apache.fineract.portfolio.loanaccount.progressiveloan.data.BuyDownFeeAmortizationDetails;
import org.apache.fineract.portfolio.loanaccount.progressiveloan.service.BuyDownFeeReadPlatformService;
import org.apache.fineract.portfolio.loanorigination.data.LoanOriginatorData;
import org.apache.fineract.portfolio.loanorigination.data.LoanOriginatorTemplateData;
import org.apache.fineract.portfolio.loanorigination.service.LoanOriginatorReadPlatformService;
import org.apache.fineract.portfolio.loanproduct.data.LoanProductLookupData;
import org.apache.fineract.portfolio.loanproduct.service.LoanProductLookupReadPort;
import org.apache.fineract.portfolio.paymenttype.data.PaymentTypeData;
import org.apache.fineract.portfolio.paymenttype.service.PaymentTypeReadService;
import org.apache.fineract.portfolio.savings.service.SavingsDropdownReadPlatformService;
import org.apache.fineract.portfolio.search.data.AdHocQuerySearchRequest;
import org.apache.fineract.portfolio.search.data.AdHocSearchQueryData;
import org.apache.fineract.portfolio.search.data.SearchConditions;
import org.apache.fineract.portfolio.search.data.SearchData;
import org.apache.fineract.portfolio.search.service.SearchReadService;
import org.apache.fineract.portfolio.tax.moduleapi.TaxCatalogPort;
import org.apache.fineract.portfolio.tax.moduleapi.TaxComponentDefinitionData;
import org.apache.fineract.portfolio.tax.moduleapi.TaxGroupDefinitionData;
import org.apache.fineract.portfolio.transfer.service.TransferWritePlatformService;
import org.apache.fineract.portfolio.workingcapitalloan.data.WorkingCapitalLoanPeriodPaymentRateChangeData;
import org.apache.fineract.portfolio.workingcapitalloan.service.WorkingCapitalLoanPeriodPaymentRateChangeReadService;
import org.apache.fineract.spm.data.ScorecardData;
import org.apache.fineract.spm.service.ScorecardReadPlatformService;
import org.apache.fineract.template.data.TemplateData;
import org.apache.fineract.template.service.TemplateMergeService;
import org.apache.fineract.useradministration.data.PasswordValidationPolicyData;
import org.apache.fineract.useradministration.service.PasswordValidationPolicyReadPlatformService;
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
    void originatorLookupFacadeDelegatesToPublishedSpringPort() {
        final LoanOriginatorReadPlatformService spring = new LoanOriginatorReadPlatformService() {

            @Override
            public List<LoanOriginatorData> retrieveAll() {
                return List.of();
            }

            @Override
            public LoanOriginatorData retrieveById(final Long id) {
                return id != null && id == 7L ? LoanOriginatorData.builder().id(7L).build() : null;
            }

            @Override
            public LoanOriginatorData retrieveByExternalId(final String externalId) {
                return null;
            }

            @Override
            public Long resolveIdByExternalId(final String externalId) {
                return null;
            }

            @Override
            public List<LoanOriginatorData> retrieveByLoanId(final Long loanId) {
                return List.of();
            }

            @Override
            public LoanOriginatorTemplateData retrieveTemplate() {
                return null;
            }
        };
        final SpringOsgiPortBridge bridge = originatorBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final LoanOriginatorReadPlatformService facade = OsgiBackedPortFactory.of(lookup, LoanOriginatorReadPlatformService.class);

        assertEquals(null, facade.retrieveById(7L));
        lifecycle.start();
        try {
            assertEquals(7L, facade.retrieveById(7L).getId());
        } finally {
            lifecycle.stop();
        }
        assertEquals(null, facade.retrieveById(7L));
    }

    @Test
    void mixLookupFacadeDelegatesToPublishedSpringPort() {
        final MixTaxonomyReadService spring = new MixTaxonomyReadService() {

            @Override
            public List<MixTaxonomyData> retrieveAll() {
                return List.of();
            }

            @Override
            public MixTaxonomyData retrieveOne(final Long id) {
                return id != null && id == 7L ? MixTaxonomyData.builder().id(7L).build() : null;
            }
        };
        final SpringOsgiPortBridge bridge = mixBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final MixTaxonomyReadService facade = OsgiBackedPortFactory.of(lookup, MixTaxonomyReadService.class);

        assertEquals(null, facade.retrieveOne(7L));
        lifecycle.start();
        try {
            assertEquals(7L, facade.retrieveOne(7L).getId());
        } finally {
            lifecycle.stop();
        }
        assertEquals(null, facade.retrieveOne(7L));
    }

    @Test
    void delayedSettlementLookupFacadeDelegatesToPublishedSpringPort() {
        final DelayedSettlementAttributeService spring = id -> id != null && id == 7L;
        final SpringOsgiPortBridge bridge = delayedBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final DelayedSettlementAttributeService facade = OsgiBackedPortFactory.of(lookup, DelayedSettlementAttributeService.class);

        assertFalse(facade.isEnabled(7L));
        lifecycle.start();
        try {
            assertTrue(facade.isEnabled(7L));
            assertFalse(facade.isEnabled(1L));
        } finally {
            lifecycle.stop();
        }
        assertFalse(facade.isEnabled(7L));
    }

    @Test
    void glClosureLookupFacadeDelegatesToPublishedSpringPort() {
        final GLClosureReadPlatformService spring = new GLClosureReadPlatformService() {

            @Override
            public List<GLClosureData> retrieveAllGLClosures(final Long officeId) {
                return List.of();
            }

            @Override
            public GLClosureData retrieveGLClosureById(final long glClosureId) {
                return glClosureId == 7L ? new GLClosureData(7L, 7L, "hosted", null, false, null, null, null, null, null, null, null)
                        : null;
            }
        };
        final SpringOsgiPortBridge bridge = glClosureBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final GLClosureReadPlatformService facade = OsgiBackedPortFactory.of(lookup, GLClosureReadPlatformService.class);

        assertEquals(null, facade.retrieveGLClosureById(7L));
        lifecycle.start();
        try {
            assertEquals(7L, facade.retrieveGLClosureById(7L).getId());
        } finally {
            lifecycle.stop();
        }
        assertEquals(null, facade.retrieveGLClosureById(7L));
    }

    @Test
    void savingsDropdownLookupFacadeDelegatesToPublishedSpringPort() {
        final SavingsDropdownReadPlatformService spring = new SavingsDropdownReadPlatformService() {

            @Override
            public Collection<EnumOptionData> retrieveLockinPeriodFrequencyTypeOptions() {
                return List.of(new EnumOptionData(7L, "hosted", "hosted"));
            }

            @Override
            public Collection<EnumOptionData> retrieveCompoundingInterestPeriodTypeOptions() {
                return List.of();
            }

            @Override
            public Collection<EnumOptionData> retrieveInterestPostingPeriodTypeOptions() {
                return List.of();
            }

            @Override
            public Collection<EnumOptionData> retrieveInterestCalculationTypeOptions() {
                return List.of();
            }

            @Override
            public Collection<EnumOptionData> retrieveInterestCalculationDaysInYearTypeOptions() {
                return List.of();
            }

            @Override
            public Collection<EnumOptionData> retrievewithdrawalFeeTypeOptions() {
                return List.of();
            }
        };
        final SpringOsgiPortBridge bridge = savingsDropdownBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final SavingsDropdownReadPlatformService facade = OsgiBackedPortFactory.of(lookup, SavingsDropdownReadPlatformService.class);

        assertTrue(facade.retrieveLockinPeriodFrequencyTypeOptions().isEmpty());
        lifecycle.start();
        try {
            assertEquals(7L, facade.retrieveLockinPeriodFrequencyTypeOptions().iterator().next().getId());
        } finally {
            lifecycle.stop();
        }
        assertTrue(facade.retrieveLockinPeriodFrequencyTypeOptions().isEmpty());
    }

    @Test
    void loanProductLookupFacadeDelegatesToPublishedSpringPort() {
        final LoanProductLookupReadPort spring = new LoanProductLookupReadPort() {

            @Override
            public Collection<LoanProductLookupData> retrieveAllLoanProductsForLookup() {
                return retrieveAllLoanProductsForLookup(false);
            }

            @Override
            public Collection<LoanProductLookupData> retrieveAllLoanProductsForLookup(final boolean activeOnly) {
                return List.of(LoanProductLookupData.lookup(7L, "hosted", false));
            }

            @Override
            public String nameById(final Long loanProductId) {
                return null;
            }

            @Override
            public String loanEnumerationValue(final String typeName, final int id) {
                return null;
            }

            @Override
            public Collection<LoanProductLookupData> findAllByNameIgnoreCase(final Collection<String> names) {
                return List.of();
            }
        };
        final SpringOsgiPortBridge bridge = loanProductLookupBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final LoanProductLookupReadPort facade = OsgiBackedPortFactory.of(lookup, LoanProductLookupReadPort.class);

        assertTrue(facade.retrieveAllLoanProductsForLookup().isEmpty());
        lifecycle.start();
        try {
            assertEquals(7L, facade.retrieveAllLoanProductsForLookup().iterator().next().getId());
        } finally {
            lifecycle.stop();
        }
        assertTrue(facade.retrieveAllLoanProductsForLookup().isEmpty());
    }

    @Test
    void buyDownFeeLookupFacadeDelegatesToPublishedSpringPort() {
        final BuyDownFeeReadPlatformService spring = loanId -> loanId != null && loanId == 7L
                ? List.of(new BuyDownFeeAmortizationDetails(7L, 7L, 7L, null, null, null, null, null, null))
                : List.of();
        final SpringOsgiPortBridge bridge = buyDownFeeBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final BuyDownFeeReadPlatformService facade = OsgiBackedPortFactory.of(lookup, BuyDownFeeReadPlatformService.class);

        assertTrue(facade.retrieveLoanBuyDownFeeAmortizationDetails(7L).isEmpty());
        lifecycle.start();
        try {
            assertEquals(7L, facade.retrieveLoanBuyDownFeeAmortizationDetails(7L).get(0).id());
        } finally {
            lifecycle.stop();
        }
        assertTrue(facade.retrieveLoanBuyDownFeeAmortizationDetails(7L).isEmpty());
    }

    @Test
    void wcRateChangeLookupFacadeDelegatesToPublishedSpringPort() {
        final WorkingCapitalLoanPeriodPaymentRateChangeReadService spring = loanId -> loanId != null && loanId == 7L
                ? List.of(new WorkingCapitalLoanPeriodPaymentRateChangeData(7L, 7L, null, null, null, false, null, null))
                : List.of();
        final SpringOsgiPortBridge bridge = wcRateChangeBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final WorkingCapitalLoanPeriodPaymentRateChangeReadService facade = OsgiBackedPortFactory.of(lookup,
                WorkingCapitalLoanPeriodPaymentRateChangeReadService.class);

        assertTrue(facade.retrieveRateChangeHistory(7L).isEmpty());
        lifecycle.start();
        try {
            assertEquals(7L, facade.retrieveRateChangeHistory(7L).get(0).id());
        } finally {
            lifecycle.stop();
        }
        assertTrue(facade.retrieveRateChangeHistory(7L).isEmpty());
    }

    @Test
    void configJobLookupFacadeDelegatesToPublishedSpringPort() {
        final ConfigJobParameterService spring = new ConfigJobParameterService() {

            @Override
            public JobBusinessStepConfigData getBusinessStepConfigByJobName(final String jobName) {
                return null;
            }

            @Override
            public CommandProcessingResult updateStepConfigByJobName(final JsonCommand command, final String jobName) {
                return null;
            }

            @Override
            public JobBusinessStepDetail getAvailableBusinessStepsByJobName(final String jobName) {
                return null;
            }

            @Override
            public List<String> getAllConfiguredJobNames() {
                return List.of("hosted");
            }
        };
        final SpringOsgiPortBridge bridge = configJobBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final ConfigJobParameterService facade = OsgiBackedPortFactory.of(lookup, ConfigJobParameterService.class);

        assertTrue(facade.getAllConfiguredJobNames().isEmpty());
        lifecycle.start();
        try {
            assertTrue(facade.getAllConfiguredJobNames().contains("hosted"));
        } finally {
            lifecycle.stop();
        }
        assertTrue(facade.getAllConfiguredJobNames().isEmpty());
    }

    @Test
    void accessTokenLookupFacadeDelegatesToPublishedSpringPort() {
        final AccessTokenGenerationService spring = () -> "hosted";
        final SpringOsgiPortBridge bridge = accessTokenBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final AccessTokenGenerationService facade = OsgiBackedPortFactory.of(lookup, AccessTokenGenerationService.class);

        assertEquals("", facade.generateRandomToken());
        lifecycle.start();
        try {
            assertEquals("hosted", facade.generateRandomToken());
        } finally {
            lifecycle.stop();
        }
        assertEquals("", facade.generateRandomToken());
    }

    @Test
    void businessDateLookupFacadeDelegatesToPublishedSpringPort() {
        final BusinessDateReadPlatformService spring = new BusinessDateReadPlatformService() {

            @Override
            public List<BusinessDateDTO> findAll() {
                return List.of();
            }

            @Override
            public BusinessDateDTO findByType(final String type) {
                return BusinessDateType.BUSINESS_DATE.name().equals(type)
                        ? BusinessDateDTO.builder().type(BusinessDateType.BUSINESS_DATE).build()
                        : null;
            }

            @Override
            public HashMap<BusinessDateType, LocalDate> getBusinessDates() {
                return new HashMap<>();
            }
        };
        final SpringOsgiPortBridge bridge = businessDateBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final BusinessDateReadPlatformService facade = OsgiBackedPortFactory.of(lookup, BusinessDateReadPlatformService.class);

        assertEquals(null, facade.findByType(BusinessDateType.BUSINESS_DATE.name()));
        lifecycle.start();
        try {
            assertEquals(BusinessDateType.BUSINESS_DATE, facade.findByType(BusinessDateType.BUSINESS_DATE.name()).getType());
        } finally {
            lifecycle.stop();
        }
        assertEquals(null, facade.findByType(BusinessDateType.BUSINESS_DATE.name()));
    }

    @Test
    void codeLookupFacadeDelegatesToPublishedSpringPort() {
        final CodeReadPlatformService spring = new CodeReadPlatformService() {

            @Override
            public Collection<CodeData> retrieveAllCodes() {
                return List.of();
            }

            @Override
            public CodeData retrieveCode(final Long codeId) {
                return codeId != null && codeId == 7L ? CodeData.instance(7L, "hosted", false) : null;
            }

            @Override
            public CodeData retrieveCode(final String codeName) {
                return null;
            }
        };
        final SpringOsgiPortBridge bridge = codeBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final CodeReadPlatformService facade = OsgiBackedPortFactory.of(lookup, CodeReadPlatformService.class);

        assertEquals(null, facade.retrieveCode(7L));
        lifecycle.start();
        try {
            assertEquals(7L, facade.retrieveCode(7L).getId());
        } finally {
            lifecycle.stop();
        }
        assertEquals(null, facade.retrieveCode(7L));
    }

    @Test
    void provisioningCategoryLookupFacadeDelegatesToPublishedSpringPort() {
        final ProvisioningCategoryReadPlatformService spring = new ProvisioningCategoryReadPlatformService() {

            @Override
            public List<ProvisioningCategoryData> retrieveAllProvisionCategories() {
                return List.of(new ProvisioningCategoryData().setId(7L).setCategoryName("hosted"));
            }
        };
        final SpringOsgiPortBridge bridge = provisioningCategoryBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final ProvisioningCategoryReadPlatformService facade = OsgiBackedPortFactory.of(lookup,
                ProvisioningCategoryReadPlatformService.class);

        assertTrue(facade.retrieveAllProvisionCategories().isEmpty());
        lifecycle.start();
        try {
            assertEquals(7L, facade.retrieveAllProvisionCategories().get(0).getId());
        } finally {
            lifecycle.stop();
        }
        assertTrue(facade.retrieveAllProvisionCategories().isEmpty());
    }

    @Test
    void currencyWriteLookupFacadeDelegatesToPublishedSpringPort() {
        final CurrencyWritePlatformService spring = new CurrencyWritePlatformService() {

            @Override
            public CurrencyUpdateResponse updateAllowedCurrencies(final CurrencyUpdateRequest request) {
                return new CurrencyUpdateResponse(List.of("hosted"));
            }
        };
        final SpringOsgiPortBridge bridge = currencyWriteBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final CurrencyWritePlatformService facade = OsgiBackedPortFactory.of(lookup, CurrencyWritePlatformService.class);

        assertEquals(null, facade.updateAllowedCurrencies(null));
        lifecycle.start();
        try {
            assertEquals("hosted", facade.updateAllowedCurrencies(null).getCurrencies().get(0));
        } finally {
            lifecycle.stop();
        }
        assertEquals(null, facade.updateAllowedCurrencies(null));
    }

    @Test
    void passwordValidationPolicyLookupFacadeDelegatesToPublishedSpringPort() {
        final PasswordValidationPolicyData hosted = new PasswordValidationPolicyData(7L, true, "hosted", "hosted");
        final PasswordValidationPolicyReadPlatformService spring = new PasswordValidationPolicyReadPlatformService() {

            @Override
            public Collection<PasswordValidationPolicyData> retrieveAll() {
                return List.of(hosted);
            }

            @Override
            public PasswordValidationPolicyData retrieveActiveValidationPolicy() {
                return hosted;
            }
        };
        final SpringOsgiPortBridge bridge = passwordValidationPolicyBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final PasswordValidationPolicyReadPlatformService facade = OsgiBackedPortFactory.of(lookup,
                PasswordValidationPolicyReadPlatformService.class);

        assertEquals(null, facade.retrieveActiveValidationPolicy());
        lifecycle.start();
        try {
            assertSame(hosted, facade.retrieveActiveValidationPolicy());
        } finally {
            lifecycle.stop();
        }
        assertEquals(null, facade.retrieveActiveValidationPolicy());
    }

    @Test
    void adHocLookupFacadeDelegatesToPublishedSpringPort() {
        final AdHocReadPlatformService spring = new AdHocReadPlatformService() {

            @Override
            public List<AdHocData> retrieveAllAdHocQuery() {
                return List.of();
            }

            @Override
            public List<AdHocData> retrieveAllActiveAdHocQuery() {
                return List.of();
            }

            @Override
            public AdHocData retrieveOne(final Long adHocId) {
                return adHocId != null && adHocId == 7L ? new AdHocData().setId(7L).setName("hosted") : null;
            }

            @Override
            public AdHocData retrieveNewAdHocDetails() {
                return null;
            }
        };
        final SpringOsgiPortBridge bridge = adHocBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final AdHocReadPlatformService facade = OsgiBackedPortFactory.of(lookup, AdHocReadPlatformService.class);

        assertEquals(null, facade.retrieveOne(7L));
        lifecycle.start();
        try {
            assertEquals(7L, facade.retrieveOne(7L).getId());
        } finally {
            lifecycle.stop();
        }
        assertEquals(null, facade.retrieveOne(7L));
    }

    @Test
    void templateMergeLookupFacadeDelegatesToPublishedSpringPort() {
        final TemplateMergeService spring = new TemplateMergeService() {

            @Override
            public String compile(final TemplateData template, final Map<String, Object> scopes) {
                return "hosted";
            }
        };
        final SpringOsgiPortBridge bridge = templateMergeBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final TemplateMergeService facade = OsgiBackedPortFactory.of(lookup, TemplateMergeService.class);

        assertEquals("", facade.compile(null, null));
        lifecycle.start();
        try {
            assertEquals("hosted", facade.compile(null, null));
        } finally {
            lifecycle.stop();
        }
        assertEquals("", facade.compile(null, null));
    }

    @Test
    void userNotificationLookupFacadeDelegatesToPublishedSpringPort() {
        final UserNotificationService spring = new UserNotificationService() {

            @Override
            public void notifyUsers(final String permission, final String objectType, final Long objectIdentifier,
                    final String notificationContent, final String eventType, final Long appUserId, final Long officeId) {
                // hosted unread flag only
            }

            @Override
            public boolean hasUnreadUserNotifications(final Long appUserId) {
                return appUserId != null && appUserId == 7L;
            }

            @Override
            public void notifyUsers(final NotificationData notificationData) {
                // hosted unread flag only
            }
        };
        final SpringOsgiPortBridge bridge = userNotificationBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final UserNotificationService facade = OsgiBackedPortFactory.of(lookup, UserNotificationService.class);

        assertFalse(facade.hasUnreadUserNotifications(7L));
        lifecycle.start();
        try {
            assertTrue(facade.hasUnreadUserNotifications(7L));
        } finally {
            lifecycle.stop();
        }
        assertFalse(facade.hasUnreadUserNotifications(7L));
    }

    @Test
    void scorecardLookupFacadeDelegatesToPublishedSpringPort() {
        final ScorecardReadPlatformService spring = new ScorecardReadPlatformService() {

            @Override
            public Collection<ScorecardData> retrieveScorecardByClient(final Long clientId) {
                return clientId != null && clientId == 7L ? List.of(ScorecardData.instance(7L, 7L, "hosted", 7L, "hosted", 7L)) : List.of();
            }

            @Override
            public Collection<ScorecardData> retrieveScorecardBySurveyAndClient(final Long surveyId, final Long clientId) {
                return List.of();
            }

            @Override
            public Collection<ScorecardData> retrieveScorecardBySurvey(final Long surveyId) {
                return List.of();
            }
        };
        final SpringOsgiPortBridge bridge = scorecardBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final ScorecardReadPlatformService facade = OsgiBackedPortFactory.of(lookup, ScorecardReadPlatformService.class);

        assertTrue(facade.retrieveScorecardByClient(7L).isEmpty());
        lifecycle.start();
        try {
            assertEquals(7L, facade.retrieveScorecardByClient(7L).iterator().next().getId());
        } finally {
            lifecycle.stop();
        }
        assertTrue(facade.retrieveScorecardByClient(7L).isEmpty());
    }

    @Test
    void fundLookupFacadeDelegatesToPublishedSpringPort() {
        final FundReadPlatformService spring = new FundReadPlatformService() {

            @Override
            public List<FundData> retrieveAllFunds() {
                return List.of();
            }

            @Override
            public FundData retrieveFund(final Long fundId) {
                return fundId != null && fundId == 7L ? FundData.instance(7L, "hosted", "hosted") : null;
            }
        };
        final SpringOsgiPortBridge bridge = fundBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final FundReadPlatformService facade = OsgiBackedPortFactory.of(lookup, FundReadPlatformService.class);

        assertEquals(null, facade.retrieveFund(7L));
        lifecycle.start();
        try {
            assertEquals(7L, facade.retrieveFund(7L).getId());
        } finally {
            lifecycle.stop();
        }
        assertEquals(null, facade.retrieveFund(7L));
    }

    @Test
    void accountNumberFormatLookupFacadeDelegatesToPublishedSpringPort() {
        final AccountNumberFormatReadPlatformService spring = new AccountNumberFormatReadPlatformService() {

            @Override
            public List<AccountNumberFormatData> getAllAccountNumberFormats() {
                return List.of();
            }

            @Override
            public AccountNumberFormatData getAccountNumberFormat(final Long id) {
                return id != null && id == 7L
                        ? new AccountNumberFormatData(7L, new EnumOptionData(7L, "hosted", "hosted"),
                                new EnumOptionData(7L, "hosted", "hosted"), "hosted")
                        : null;
            }

            @Override
            public AccountNumberFormatData retrieveTemplate(final EntityAccountType entityAccountTypeForTemplate) {
                return null;
            }
        };
        final SpringOsgiPortBridge bridge = accountNumberFormatBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final AccountNumberFormatReadPlatformService facade = OsgiBackedPortFactory.of(lookup,
                AccountNumberFormatReadPlatformService.class);

        assertEquals(null, facade.getAccountNumberFormat(7L));
        lifecycle.start();
        try {
            assertEquals(7L, facade.getAccountNumberFormat(7L).getId());
        } finally {
            lifecycle.stop();
        }
        assertEquals(null, facade.getAccountNumberFormat(7L));
    }

    @Test
    void readLikelihoodLookupFacadeDelegatesToPublishedSpringPort() {
        final ReadLikelihoodService spring = new ReadLikelihoodService() {

            @Override
            public List<LikelihoodData> retrieveAll(final String ppiName) {
                return List.of();
            }

            @Override
            public LikelihoodData retrieve(final Long likelihoodId) {
                return likelihoodId != null && likelihoodId == 7L ? new LikelihoodData().setResourceId(7L).setLikeliHoodName("hosted")
                        : null;
            }
        };
        final SpringOsgiPortBridge bridge = readLikelihoodBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final ReadLikelihoodService facade = OsgiBackedPortFactory.of(lookup, ReadLikelihoodService.class);

        assertEquals(null, facade.retrieve(7L));
        lifecycle.start();
        try {
            assertEquals(7L, facade.retrieve(7L).getResourceId());
        } finally {
            lifecycle.stop();
        }
        assertEquals(null, facade.retrieve(7L));
    }

    @Test
    void transferWriteLookupFacadeDelegatesToPublishedSpringPort() {
        final TransferWritePlatformService spring = new TransferWritePlatformService() {

            @Override
            public CommandProcessingResult transferClientsBetweenGroups(final Long sourceGroupId, final JsonCommand jsonCommand) {
                return CommandProcessingResult.empty();
            }

            @Override
            public CommandProcessingResult proposeClientTransfer(final Long clientId, final JsonCommand jsonCommand) {
                return CommandProcessingResult.resourceResult(7L);
            }

            @Override
            public CommandProcessingResult withdrawClientTransfer(final Long clientId, final JsonCommand jsonCommand) {
                return CommandProcessingResult.empty();
            }

            @Override
            public CommandProcessingResult acceptClientTransfer(final Long clientId, final JsonCommand jsonCommand) {
                return CommandProcessingResult.empty();
            }

            @Override
            public CommandProcessingResult rejectClientTransfer(final Long clientId, final JsonCommand jsonCommand) {
                return CommandProcessingResult.empty();
            }

            @Override
            public CommandProcessingResult proposeAndAcceptClientTransfer(final Long clientId, final JsonCommand jsonCommand) {
                return CommandProcessingResult.empty();
            }
        };
        final SpringOsgiPortBridge bridge = transferWriteBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final TransferWritePlatformService facade = OsgiBackedPortFactory.of(lookup, TransferWritePlatformService.class);

        assertEquals(null, facade.proposeClientTransfer(7L, null).getResourceId());
        lifecycle.start();
        try {
            assertEquals(7L, facade.proposeClientTransfer(7L, null).getResourceId());
        } finally {
            lifecycle.stop();
        }
        assertEquals(null, facade.proposeClientTransfer(7L, null).getResourceId());
    }

    @Test
    void paymentTypeLookupFacadeDelegatesToPublishedSpringPort() {
        final PaymentTypeReadService spring = new PaymentTypeReadService() {

            @Override
            public List<PaymentTypeData> retrieveAllPaymentTypes() {
                return List.of();
            }

            @Override
            public List<PaymentTypeData> retrieveAllPaymentTypesWithCode() {
                return List.of();
            }

            @Override
            public PaymentTypeData retrieveOne(final Long paymentTypeId) {
                return paymentTypeId != null && paymentTypeId == 7L ? PaymentTypeData.builder().id(7L).name("hosted").build() : null;
            }
        };
        final SpringOsgiPortBridge bridge = paymentTypeBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final PaymentTypeReadService facade = OsgiBackedPortFactory.of(lookup, PaymentTypeReadService.class);

        assertEquals(null, facade.retrieveOne(7L));
        lifecycle.start();
        try {
            assertEquals(7L, facade.retrieveOne(7L).getId());
        } finally {
            lifecycle.stop();
        }
        assertEquals(null, facade.retrieveOne(7L));
    }

    @Test
    void searchLookupFacadeDelegatesToPublishedSpringPort() {
        final SearchReadService spring = new SearchReadService() {

            @Override
            public List<SearchData> retriveMatchingData(final SearchConditions searchConditions) {
                return List.of(new SearchData(7L, "hosted", "hosted", "hosted", "client", null, null, null, null,
                        new EnumOptionData(7L, "hosted", "hosted"), null));
            }

            @Override
            public AdHocSearchQueryData retrieveAdHocQueryTemplate() {
                return null;
            }

            @Override
            public List<AdHocSearchQueryData> retrieveAdHocQueryMatchingData(final AdHocQuerySearchRequest request) {
                return List.of();
            }
        };
        final SpringOsgiPortBridge bridge = searchBridge(spring);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);
        final OsgiServiceLookup lookup = new OsgiServiceLookup(lifecycle::getBundleContext);
        final SearchReadService facade = OsgiBackedPortFactory.of(lookup, SearchReadService.class);

        assertTrue(facade.retriveMatchingData(null).isEmpty());
        lifecycle.start();
        try {
            assertEquals(7L, facade.retriveMatchingData(null).get(0).getEntityId());
        } finally {
            lifecycle.stop();
        }
        assertTrue(facade.retriveMatchingData(null).isEmpty());
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

    @Test
    void stagedCatalogStartsAndSpringOriginatorPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final LoanOriginatorReadPlatformService originator = new StubLoanOriginatorReadPlatformService();
        final SpringOsgiPortBridge bridge = originatorBridge(originator);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean originatorImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.loanorigination.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    originatorImplActive = true;
                    break;
                }
            }
            assertTrue(originatorImplActive);
            final ServiceReference<LoanOriginatorReadPlatformService> selected = ctx
                    .getServiceReference(LoanOriginatorReadPlatformService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(originator, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringMixPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final MixTaxonomyReadService mix = new StubMixTaxonomyReadService();
        final SpringOsgiPortBridge bridge = mixBridge(mix);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean mixImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.mix.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    mixImplActive = true;
                    break;
                }
            }
            assertTrue(mixImplActive);
            final ServiceReference<MixTaxonomyReadService> selected = ctx.getServiceReference(MixTaxonomyReadService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(mix, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringDelayedSettlementPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final DelayedSettlementAttributeService delayed = new StubDelayedSettlementAttributeService();
        final SpringOsgiPortBridge bridge = delayedBridge(delayed);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean investorImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.investor.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    investorImplActive = true;
                    break;
                }
            }
            assertTrue(investorImplActive);
            final ServiceReference<DelayedSettlementAttributeService> selected = ctx
                    .getServiceReference(DelayedSettlementAttributeService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(delayed, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringGLClosurePortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final GLClosureReadPlatformService closures = new StubGLClosureReadPlatformService();
        final SpringOsgiPortBridge bridge = glClosureBridge(closures);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean accountingImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.accounting.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    accountingImplActive = true;
                    break;
                }
            }
            assertTrue(accountingImplActive);
            final ServiceReference<GLClosureReadPlatformService> selected = ctx.getServiceReference(GLClosureReadPlatformService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(closures, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringSavingsDropdownPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final SavingsDropdownReadPlatformService savings = new StubSavingsDropdownReadPlatformService();
        final SpringOsgiPortBridge bridge = savingsDropdownBridge(savings);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean savingsImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.savings.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    savingsImplActive = true;
                    break;
                }
            }
            assertTrue(savingsImplActive);
            final ServiceReference<SavingsDropdownReadPlatformService> selected = ctx
                    .getServiceReference(SavingsDropdownReadPlatformService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(savings, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringLoanProductLookupPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final LoanProductLookupReadPort loanProducts = new StubLoanProductLookupReadPort();
        final SpringOsgiPortBridge bridge = loanProductLookupBridge(loanProducts);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean loanImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.loan.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    loanImplActive = true;
                    break;
                }
            }
            assertTrue(loanImplActive);
            final ServiceReference<LoanProductLookupReadPort> selected = ctx.getServiceReference(LoanProductLookupReadPort.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(loanProducts, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringBuyDownFeePortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final BuyDownFeeReadPlatformService buyDown = new StubBuyDownFeeReadPlatformService();
        final SpringOsgiPortBridge bridge = buyDownFeeBridge(buyDown);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean progressiveLoanImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.progressiveloan.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    progressiveLoanImplActive = true;
                    break;
                }
            }
            assertTrue(progressiveLoanImplActive);
            final ServiceReference<BuyDownFeeReadPlatformService> selected = ctx.getServiceReference(BuyDownFeeReadPlatformService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(buyDown, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringWcRateChangePortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final WorkingCapitalLoanPeriodPaymentRateChangeReadService rateChange = new StubWorkingCapitalLoanPeriodPaymentRateChangeReadService();
        final SpringOsgiPortBridge bridge = wcRateChangeBridge(rateChange);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean wcImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.workingcapitalloan.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    wcImplActive = true;
                    break;
                }
            }
            assertTrue(wcImplActive);
            final ServiceReference<WorkingCapitalLoanPeriodPaymentRateChangeReadService> selected = ctx
                    .getServiceReference(WorkingCapitalLoanPeriodPaymentRateChangeReadService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(rateChange, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringConfigJobPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final ConfigJobParameterService cobJobs = new StubConfigJobParameterService();
        final SpringOsgiPortBridge bridge = configJobBridge(cobJobs);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean cobImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.cob.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    cobImplActive = true;
                    break;
                }
            }
            assertTrue(cobImplActive);
            final ServiceReference<ConfigJobParameterService> selected = ctx.getServiceReference(ConfigJobParameterService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(cobJobs, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringAccessTokenPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final AccessTokenGenerationService accessToken = new StubAccessTokenGenerationService();
        final SpringOsgiPortBridge bridge = accessTokenBridge(accessToken);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean securityImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.security.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    securityImplActive = true;
                    break;
                }
            }
            assertTrue(securityImplActive);
            final ServiceReference<AccessTokenGenerationService> selected = ctx.getServiceReference(AccessTokenGenerationService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(accessToken, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringBusinessDatePortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final BusinessDateReadPlatformService businessDates = new StubBusinessDateReadPlatformService();
        final SpringOsgiPortBridge bridge = businessDateBridge(businessDates);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean businessDateImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.businessdate.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    businessDateImplActive = true;
                    break;
                }
            }
            assertTrue(businessDateImplActive);
            final ServiceReference<BusinessDateReadPlatformService> selected = ctx
                    .getServiceReference(BusinessDateReadPlatformService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(businessDates, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringCodePortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final CodeReadPlatformService codes = new StubCodeReadPlatformService();
        final SpringOsgiPortBridge bridge = codeBridge(codes);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean codesImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.codes.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    codesImplActive = true;
                    break;
                }
            }
            assertTrue(codesImplActive);
            final ServiceReference<CodeReadPlatformService> selected = ctx.getServiceReference(CodeReadPlatformService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(codes, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringProvisioningCategoryPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final ProvisioningCategoryReadPlatformService categories = new StubProvisioningCategoryReadPlatformService();
        final SpringOsgiPortBridge bridge = provisioningCategoryBridge(categories);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean organisationImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.organisation.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    organisationImplActive = true;
                    break;
                }
            }
            assertTrue(organisationImplActive);
            final ServiceReference<ProvisioningCategoryReadPlatformService> selected = ctx
                    .getServiceReference(ProvisioningCategoryReadPlatformService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(categories, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringCurrencyWritePortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final CurrencyWritePlatformService currencies = new StubCurrencyWritePlatformService();
        final SpringOsgiPortBridge bridge = currencyWriteBridge(currencies);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean monetaryImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.monetary.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    monetaryImplActive = true;
                    break;
                }
            }
            assertTrue(monetaryImplActive);
            final ServiceReference<CurrencyWritePlatformService> selected = ctx.getServiceReference(CurrencyWritePlatformService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(currencies, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringPasswordValidationPolicyPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final PasswordValidationPolicyReadPlatformService policies = new StubPasswordValidationPolicyReadPlatformService();
        final SpringOsgiPortBridge bridge = passwordValidationPolicyBridge(policies);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean userAdminImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.useradministration.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    userAdminImplActive = true;
                    break;
                }
            }
            assertTrue(userAdminImplActive);
            final ServiceReference<PasswordValidationPolicyReadPlatformService> selected = ctx
                    .getServiceReference(PasswordValidationPolicyReadPlatformService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(policies, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringAdHocPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final AdHocReadPlatformService adhoc = new StubAdHocReadPlatformService();
        final SpringOsgiPortBridge bridge = adHocBridge(adhoc);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean adhocImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.adhocquery.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    adhocImplActive = true;
                    break;
                }
            }
            assertTrue(adhocImplActive);
            final ServiceReference<AdHocReadPlatformService> selected = ctx.getServiceReference(AdHocReadPlatformService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(adhoc, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringTemplateMergePortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final TemplateMergeService templates = new StubTemplateMergeService();
        final SpringOsgiPortBridge bridge = templateMergeBridge(templates);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean templateImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.template.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    templateImplActive = true;
                    break;
                }
            }
            assertTrue(templateImplActive);
            final ServiceReference<TemplateMergeService> selected = ctx.getServiceReference(TemplateMergeService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(templates, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringUserNotificationPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final UserNotificationService notifications = new StubUserNotificationService();
        final SpringOsgiPortBridge bridge = userNotificationBridge(notifications);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean notificationImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.notification.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    notificationImplActive = true;
                    break;
                }
            }
            assertTrue(notificationImplActive);
            final ServiceReference<UserNotificationService> selected = ctx.getServiceReference(UserNotificationService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(notifications, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringScorecardPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final ScorecardReadPlatformService scorecards = new StubScorecardReadPlatformService();
        final SpringOsgiPortBridge bridge = scorecardBridge(scorecards);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean spmImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.spm.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    spmImplActive = true;
                    break;
                }
            }
            assertTrue(spmImplActive);
            final ServiceReference<ScorecardReadPlatformService> selected = ctx.getServiceReference(ScorecardReadPlatformService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(scorecards, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringFundPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final FundReadPlatformService funds = new StubFundReadPlatformService();
        final SpringOsgiPortBridge bridge = fundBridge(funds);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean fundImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.fund.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    fundImplActive = true;
                    break;
                }
            }
            assertTrue(fundImplActive);
            final ServiceReference<FundReadPlatformService> selected = ctx.getServiceReference(FundReadPlatformService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(funds, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringAccountNumberFormatPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final AccountNumberFormatReadPlatformService formats = new StubAccountNumberFormatReadPlatformService();
        final SpringOsgiPortBridge bridge = accountNumberFormatBridge(formats);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean accountNumberFormatImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.accountnumberformat.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    accountNumberFormatImplActive = true;
                    break;
                }
            }
            assertTrue(accountNumberFormatImplActive);
            final ServiceReference<AccountNumberFormatReadPlatformService> selected = ctx
                    .getServiceReference(AccountNumberFormatReadPlatformService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(formats, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringReadLikelihoodPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final ReadLikelihoodService likelihood = new StubReadLikelihoodService();
        final SpringOsgiPortBridge bridge = readLikelihoodBridge(likelihood);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean surveyImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.survey.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    surveyImplActive = true;
                    break;
                }
            }
            assertTrue(surveyImplActive);
            final ServiceReference<ReadLikelihoodService> selected = ctx.getServiceReference(ReadLikelihoodService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(likelihood, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringTransferWritePortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final TransferWritePlatformService transfers = new StubTransferWritePlatformService();
        final SpringOsgiPortBridge bridge = transferWriteBridge(transfers);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean transferImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.transfer.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    transferImplActive = true;
                    break;
                }
            }
            assertTrue(transferImplActive);
            final ServiceReference<TransferWritePlatformService> selected = ctx.getServiceReference(TransferWritePlatformService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(transfers, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringPaymentTypePortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final PaymentTypeReadService paymentTypes = new StubPaymentTypeReadService();
        final SpringOsgiPortBridge bridge = paymentTypeBridge(paymentTypes);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean paymentTypeImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.paymenttype.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    paymentTypeImplActive = true;
                    break;
                }
            }
            assertTrue(paymentTypeImplActive);
            final ServiceReference<PaymentTypeReadService> selected = ctx.getServiceReference(PaymentTypeReadService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(paymentTypes, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    @Test
    void stagedCatalogStartsAndSpringSearchPortStillWins() {
        final Path catalog = stagedCatalog();
        assumeTrue(Files.isRegularFile(catalog.resolve("config").resolve("config.ini")), "run ./gradlew osgiStageBundles first");
        final SearchReadService search = new StubSearchReadService();
        final SpringOsgiPortBridge bridge = searchBridge(search);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge, catalog);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            boolean searchImplActive = false;
            for (final Bundle bundle : ctx.getBundles()) {
                if ("org.apache.fineract.search.impl".equals(bundle.getSymbolicName()) && bundle.getState() == Bundle.ACTIVE) {
                    searchImplActive = true;
                    break;
                }
            }
            assertTrue(searchImplActive);
            final ServiceReference<SearchReadService> selected = ctx.getServiceReference(SearchReadService.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertSame(search, ctx.getService(selected));
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

    private static SpringOsgiPortBridge originatorBridge(final LoanOriginatorReadPlatformService originator) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(LoanOriginatorReadPlatformService.class, originator)));
    }

    private static SpringOsgiPortBridge mixBridge(final MixTaxonomyReadService mix) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(MixTaxonomyReadService.class, mix)));
    }

    private static SpringOsgiPortBridge delayedBridge(final DelayedSettlementAttributeService delayed) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(DelayedSettlementAttributeService.class, delayed)));
    }

    private static SpringOsgiPortBridge glClosureBridge(final GLClosureReadPlatformService closures) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(GLClosureReadPlatformService.class, closures)));
    }

    private static SpringOsgiPortBridge savingsDropdownBridge(final SavingsDropdownReadPlatformService savings) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(SavingsDropdownReadPlatformService.class, savings)));
    }

    private static SpringOsgiPortBridge loanProductLookupBridge(final LoanProductLookupReadPort loanProducts) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(LoanProductLookupReadPort.class, loanProducts)));
    }

    private static SpringOsgiPortBridge buyDownFeeBridge(final BuyDownFeeReadPlatformService buyDown) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(BuyDownFeeReadPlatformService.class, buyDown)));
    }

    private static SpringOsgiPortBridge wcRateChangeBridge(final WorkingCapitalLoanPeriodPaymentRateChangeReadService rateChange) {
        return new SpringOsgiPortBridge(
                List.of(SpringOsgiPortBridge.bind(WorkingCapitalLoanPeriodPaymentRateChangeReadService.class, rateChange)));
    }

    private static SpringOsgiPortBridge configJobBridge(final ConfigJobParameterService cobJobs) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(ConfigJobParameterService.class, cobJobs)));
    }

    private static SpringOsgiPortBridge accessTokenBridge(final AccessTokenGenerationService accessToken) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(AccessTokenGenerationService.class, accessToken)));
    }

    private static SpringOsgiPortBridge businessDateBridge(final BusinessDateReadPlatformService businessDates) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(BusinessDateReadPlatformService.class, businessDates)));
    }

    private static SpringOsgiPortBridge codeBridge(final CodeReadPlatformService codes) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(CodeReadPlatformService.class, codes)));
    }

    private static SpringOsgiPortBridge provisioningCategoryBridge(final ProvisioningCategoryReadPlatformService categories) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(ProvisioningCategoryReadPlatformService.class, categories)));
    }

    private static SpringOsgiPortBridge currencyWriteBridge(final CurrencyWritePlatformService currencies) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(CurrencyWritePlatformService.class, currencies)));
    }

    private static SpringOsgiPortBridge passwordValidationPolicyBridge(final PasswordValidationPolicyReadPlatformService policies) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(PasswordValidationPolicyReadPlatformService.class, policies)));
    }

    private static SpringOsgiPortBridge adHocBridge(final AdHocReadPlatformService adhoc) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(AdHocReadPlatformService.class, adhoc)));
    }

    private static SpringOsgiPortBridge templateMergeBridge(final TemplateMergeService templates) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(TemplateMergeService.class, templates)));
    }

    private static SpringOsgiPortBridge userNotificationBridge(final UserNotificationService notifications) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(UserNotificationService.class, notifications)));
    }

    private static SpringOsgiPortBridge scorecardBridge(final ScorecardReadPlatformService scorecards) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(ScorecardReadPlatformService.class, scorecards)));
    }

    private static SpringOsgiPortBridge fundBridge(final FundReadPlatformService funds) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(FundReadPlatformService.class, funds)));
    }

    private static SpringOsgiPortBridge accountNumberFormatBridge(final AccountNumberFormatReadPlatformService formats) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(AccountNumberFormatReadPlatformService.class, formats)));
    }

    private static SpringOsgiPortBridge readLikelihoodBridge(final ReadLikelihoodService likelihood) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(ReadLikelihoodService.class, likelihood)));
    }

    private static SpringOsgiPortBridge transferWriteBridge(final TransferWritePlatformService transfers) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(TransferWritePlatformService.class, transfers)));
    }

    private static SpringOsgiPortBridge paymentTypeBridge(final PaymentTypeReadService paymentTypes) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(PaymentTypeReadService.class, paymentTypes)));
    }

    private static SpringOsgiPortBridge searchBridge(final SearchReadService search) {
        return new SpringOsgiPortBridge(List.of(SpringOsgiPortBridge.bind(SearchReadService.class, search)));
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

    private static final class StubLoanOriginatorReadPlatformService implements LoanOriginatorReadPlatformService {

        @Override
        public List<LoanOriginatorData> retrieveAll() {
            return List.of();
        }

        @Override
        public LoanOriginatorData retrieveById(final Long id) {
            return null;
        }

        @Override
        public LoanOriginatorData retrieveByExternalId(final String externalId) {
            return null;
        }

        @Override
        public Long resolveIdByExternalId(final String externalId) {
            return null;
        }

        @Override
        public List<LoanOriginatorData> retrieveByLoanId(final Long loanId) {
            return List.of();
        }

        @Override
        public LoanOriginatorTemplateData retrieveTemplate() {
            return null;
        }
    }

    private static final class StubMixTaxonomyReadService implements MixTaxonomyReadService {

        @Override
        public List<MixTaxonomyData> retrieveAll() {
            return List.of();
        }

        @Override
        public MixTaxonomyData retrieveOne(final Long id) {
            return null;
        }
    }

    private static final class StubDelayedSettlementAttributeService implements DelayedSettlementAttributeService {

        @Override
        public boolean isEnabled(final Long loanProductId) {
            return false;
        }
    }

    private static final class StubGLClosureReadPlatformService implements GLClosureReadPlatformService {

        @Override
        public List<GLClosureData> retrieveAllGLClosures(final Long officeId) {
            return List.of();
        }

        @Override
        public GLClosureData retrieveGLClosureById(final long glClosureId) {
            return null;
        }
    }

    private static final class StubSavingsDropdownReadPlatformService implements SavingsDropdownReadPlatformService {

        @Override
        public Collection<EnumOptionData> retrieveLockinPeriodFrequencyTypeOptions() {
            return List.of();
        }

        @Override
        public Collection<EnumOptionData> retrieveCompoundingInterestPeriodTypeOptions() {
            return List.of();
        }

        @Override
        public Collection<EnumOptionData> retrieveInterestPostingPeriodTypeOptions() {
            return List.of();
        }

        @Override
        public Collection<EnumOptionData> retrieveInterestCalculationTypeOptions() {
            return List.of();
        }

        @Override
        public Collection<EnumOptionData> retrieveInterestCalculationDaysInYearTypeOptions() {
            return List.of();
        }

        @Override
        public Collection<EnumOptionData> retrievewithdrawalFeeTypeOptions() {
            return List.of();
        }
    }

    private static final class StubLoanProductLookupReadPort implements LoanProductLookupReadPort {

        @Override
        public Collection<LoanProductLookupData> retrieveAllLoanProductsForLookup() {
            return List.of();
        }

        @Override
        public Collection<LoanProductLookupData> retrieveAllLoanProductsForLookup(final boolean activeOnly) {
            return List.of();
        }

        @Override
        public String nameById(final Long loanProductId) {
            return null;
        }

        @Override
        public String loanEnumerationValue(final String typeName, final int id) {
            return null;
        }

        @Override
        public Collection<LoanProductLookupData> findAllByNameIgnoreCase(final Collection<String> names) {
            return List.of();
        }
    }

    private static final class StubBuyDownFeeReadPlatformService implements BuyDownFeeReadPlatformService {

        @Override
        public List<BuyDownFeeAmortizationDetails> retrieveLoanBuyDownFeeAmortizationDetails(final Long loanId) {
            return List.of();
        }
    }

    private static final class StubWorkingCapitalLoanPeriodPaymentRateChangeReadService
            implements WorkingCapitalLoanPeriodPaymentRateChangeReadService {

        @Override
        public List<WorkingCapitalLoanPeriodPaymentRateChangeData> retrieveRateChangeHistory(final Long loanId) {
            return List.of();
        }
    }

    private static final class StubConfigJobParameterService implements ConfigJobParameterService {

        @Override
        public JobBusinessStepConfigData getBusinessStepConfigByJobName(final String jobName) {
            return null;
        }

        @Override
        public CommandProcessingResult updateStepConfigByJobName(final JsonCommand command, final String jobName) {
            return null;
        }

        @Override
        public JobBusinessStepDetail getAvailableBusinessStepsByJobName(final String jobName) {
            return null;
        }

        @Override
        public List<String> getAllConfiguredJobNames() {
            return List.of();
        }
    }

    private static final class StubAccessTokenGenerationService implements AccessTokenGenerationService {

        @Override
        public String generateRandomToken() {
            return "";
        }
    }

    private static final class StubBusinessDateReadPlatformService implements BusinessDateReadPlatformService {

        @Override
        public List<BusinessDateDTO> findAll() {
            return List.of();
        }

        @Override
        public BusinessDateDTO findByType(final String type) {
            return null;
        }

        @Override
        public HashMap<BusinessDateType, LocalDate> getBusinessDates() {
            return new HashMap<>();
        }
    }

    private static final class StubCodeReadPlatformService implements CodeReadPlatformService {

        @Override
        public Collection<CodeData> retrieveAllCodes() {
            return List.of();
        }

        @Override
        public CodeData retrieveCode(final Long codeId) {
            return null;
        }

        @Override
        public CodeData retrieveCode(final String codeName) {
            return null;
        }
    }

    private static final class StubProvisioningCategoryReadPlatformService implements ProvisioningCategoryReadPlatformService {

        @Override
        public List<ProvisioningCategoryData> retrieveAllProvisionCategories() {
            return List.of();
        }
    }

    private static final class StubCurrencyWritePlatformService implements CurrencyWritePlatformService {

        @Override
        public CurrencyUpdateResponse updateAllowedCurrencies(final CurrencyUpdateRequest request) {
            return null;
        }
    }

    private static final class StubPasswordValidationPolicyReadPlatformService implements PasswordValidationPolicyReadPlatformService {

        @Override
        public Collection<PasswordValidationPolicyData> retrieveAll() {
            return List.of();
        }

        @Override
        public PasswordValidationPolicyData retrieveActiveValidationPolicy() {
            return null;
        }
    }

    private static final class StubAdHocReadPlatformService implements AdHocReadPlatformService {

        @Override
        public List<AdHocData> retrieveAllAdHocQuery() {
            return List.of();
        }

        @Override
        public List<AdHocData> retrieveAllActiveAdHocQuery() {
            return List.of();
        }

        @Override
        public AdHocData retrieveOne(final Long adHocId) {
            return null;
        }

        @Override
        public AdHocData retrieveNewAdHocDetails() {
            return null;
        }
    }

    private static final class StubTemplateMergeService implements TemplateMergeService {

        @Override
        public String compile(final TemplateData template, final Map<String, Object> scopes) {
            return "";
        }
    }

    private static final class StubUserNotificationService implements UserNotificationService {

        @Override
        public void notifyUsers(final String permission, final String objectType, final Long objectIdentifier,
                final String notificationContent, final String eventType, final Long appUserId, final Long officeId) {
            // no-op
        }

        @Override
        public boolean hasUnreadUserNotifications(final Long appUserId) {
            return false;
        }

        @Override
        public void notifyUsers(final NotificationData notificationData) {
            // no-op
        }
    }

    private static final class StubScorecardReadPlatformService implements ScorecardReadPlatformService {

        @Override
        public Collection<ScorecardData> retrieveScorecardByClient(final Long clientId) {
            return List.of();
        }

        @Override
        public Collection<ScorecardData> retrieveScorecardBySurveyAndClient(final Long surveyId, final Long clientId) {
            return List.of();
        }

        @Override
        public Collection<ScorecardData> retrieveScorecardBySurvey(final Long surveyId) {
            return List.of();
        }
    }

    private static final class StubFundReadPlatformService implements FundReadPlatformService {

        @Override
        public List<FundData> retrieveAllFunds() {
            return List.of();
        }

        @Override
        public FundData retrieveFund(final Long fundId) {
            return null;
        }
    }

    private static final class StubAccountNumberFormatReadPlatformService implements AccountNumberFormatReadPlatformService {

        @Override
        public List<AccountNumberFormatData> getAllAccountNumberFormats() {
            return List.of();
        }

        @Override
        public AccountNumberFormatData getAccountNumberFormat(final Long id) {
            return null;
        }

        @Override
        public AccountNumberFormatData retrieveTemplate(final EntityAccountType entityAccountTypeForTemplate) {
            return null;
        }
    }

    private static final class StubReadLikelihoodService implements ReadLikelihoodService {

        @Override
        public List<LikelihoodData> retrieveAll(final String ppiName) {
            return List.of();
        }

        @Override
        public LikelihoodData retrieve(final Long likelihoodId) {
            return null;
        }
    }

    private static final class StubTransferWritePlatformService implements TransferWritePlatformService {

        @Override
        public CommandProcessingResult transferClientsBetweenGroups(final Long sourceGroupId, final JsonCommand jsonCommand) {
            return CommandProcessingResult.empty();
        }

        @Override
        public CommandProcessingResult proposeClientTransfer(final Long clientId, final JsonCommand jsonCommand) {
            return CommandProcessingResult.empty();
        }

        @Override
        public CommandProcessingResult withdrawClientTransfer(final Long clientId, final JsonCommand jsonCommand) {
            return CommandProcessingResult.empty();
        }

        @Override
        public CommandProcessingResult acceptClientTransfer(final Long clientId, final JsonCommand jsonCommand) {
            return CommandProcessingResult.empty();
        }

        @Override
        public CommandProcessingResult rejectClientTransfer(final Long clientId, final JsonCommand jsonCommand) {
            return CommandProcessingResult.empty();
        }

        @Override
        public CommandProcessingResult proposeAndAcceptClientTransfer(final Long clientId, final JsonCommand jsonCommand) {
            return CommandProcessingResult.empty();
        }
    }

    private static final class StubPaymentTypeReadService implements PaymentTypeReadService {

        @Override
        public List<PaymentTypeData> retrieveAllPaymentTypes() {
            return List.of();
        }

        @Override
        public List<PaymentTypeData> retrieveAllPaymentTypesWithCode() {
            return List.of();
        }

        @Override
        public PaymentTypeData retrieveOne(final Long paymentTypeId) {
            return null;
        }
    }

    private static final class StubSearchReadService implements SearchReadService {

        @Override
        public List<SearchData> retriveMatchingData(final SearchConditions searchConditions) {
            return List.of();
        }

        @Override
        public AdHocSearchQueryData retrieveAdHocQueryTemplate() {
            return null;
        }

        @Override
        public List<AdHocSearchQueryData> retrieveAdHocQueryMatchingData(final AdHocQuerySearchRequest request) {
            return List.of();
        }
    }
}
