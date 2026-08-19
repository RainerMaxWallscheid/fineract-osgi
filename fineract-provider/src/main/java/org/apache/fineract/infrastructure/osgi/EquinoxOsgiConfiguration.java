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

import java.nio.file.Path;
import java.util.List;
import org.apache.fineract.accounting.closure.service.GLClosureReadPlatformService;
import org.apache.fineract.adhocquery.service.AdHocReadPlatformService;
import org.apache.fineract.cob.service.ConfigJobParameterService;
import org.apache.fineract.infrastructure.accountnumberformat.service.AccountNumberFormatReadPlatformService;
import org.apache.fineract.infrastructure.businessdate.service.BusinessDateReadPlatformService;
import org.apache.fineract.infrastructure.cache.service.CacheWritePlatformService;
import org.apache.fineract.infrastructure.campaigns.sms.service.SmsCampaignDropdownReadPlatformService;
import org.apache.fineract.infrastructure.codes.service.CodeReadPlatformService;
import org.apache.fineract.infrastructure.configuration.service.ExternalServicesReadPlatformService;
import org.apache.fineract.infrastructure.contentstore.service.ContentStoreService;
import org.apache.fineract.infrastructure.creditbureau.service.CreditBureauReadPlatformService;
import org.apache.fineract.infrastructure.dataqueries.service.ReportWritePlatformService;
import org.apache.fineract.infrastructure.entityaccess.service.FineractEntityAccessReadService;
import org.apache.fineract.infrastructure.gcm.service.NotificationConfigurationReadService;
import org.apache.fineract.infrastructure.hooks.service.HookReadPlatformService;
import org.apache.fineract.infrastructure.jobs.service.StuckJobExecutorService;
import org.apache.fineract.infrastructure.reportmailingjob.service.ReportMailingJobConfigurationReadPlatformService;
import org.apache.fineract.infrastructure.security.service.AccessTokenGenerationService;
import org.apache.fineract.infrastructure.sms.service.SmsWritePlatformService;
import org.apache.fineract.infrastructure.springbatch.PropertyService;
import org.apache.fineract.infrastructure.survey.service.ReadLikelihoodService;
import org.apache.fineract.investor.service.DelayedSettlementAttributeService;
import org.apache.fineract.mix.service.MixTaxonomyReadService;
import org.apache.fineract.notification.service.UserNotificationService;
import org.apache.fineract.organisation.monetary.service.CurrencyWritePlatformService;
import org.apache.fineract.organisation.provisioning.service.ProvisioningCategoryReadPlatformService;
import org.apache.fineract.organisation.teller.moduleapi.CashierTxnValidationPort;
import org.apache.fineract.portfolio.account.service.StandingInstructionWritePlatformService;
import org.apache.fineract.portfolio.address.service.FieldConfigurationReadPlatformService;
import org.apache.fineract.portfolio.calendar.service.CalendarDropdownReadPlatformService;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort;
import org.apache.fineract.portfolio.client.service.ClientIdentifierWritePlatformService;
import org.apache.fineract.portfolio.collateral.service.CollateralWritePlatformService;
import org.apache.fineract.portfolio.collateralmanagement.service.CollateralManagementReadService;
import org.apache.fineract.portfolio.collectionsheet.service.CollectionSheetWritePlatformService;
import org.apache.fineract.portfolio.floatingrates.moduleapi.FloatingRatePort;
import org.apache.fineract.portfolio.fund.service.FundReadPlatformService;
import org.apache.fineract.portfolio.group.service.GroupLevelReadPlatformService;
import org.apache.fineract.portfolio.loanaccount.progressiveloan.service.BuyDownFeeReadPlatformService;
import org.apache.fineract.portfolio.loanorigination.service.LoanOriginatorReadPlatformService;
import org.apache.fineract.portfolio.loanproduct.service.LoanProductLookupReadPort;
import org.apache.fineract.portfolio.meeting.service.MeetingAttendanceDropdownReadService;
import org.apache.fineract.portfolio.note.service.NoteReadPlatformService;
import org.apache.fineract.portfolio.paymenttype.service.PaymentTypeReadService;
import org.apache.fineract.portfolio.products.service.ProductCommandsService;
import org.apache.fineract.portfolio.repaymentwithpostdatedchecks.service.RepaymentWithPostDatedChecksWritePlatformService;
import org.apache.fineract.portfolio.savings.service.SavingsDropdownReadPlatformService;
import org.apache.fineract.portfolio.search.service.SearchReadService;
import org.apache.fineract.portfolio.tax.moduleapi.TaxCatalogPort;
import org.apache.fineract.portfolio.transfer.service.TransferWritePlatformService;
import org.apache.fineract.portfolio.workingcapitalloan.service.WorkingCapitalLoanPeriodPaymentRateChangeReadService;
import org.apache.fineract.shares.shareproducts.service.ShareProductDropdownReadPlatformService;
import org.apache.fineract.spm.service.ScorecardReadPlatformService;
import org.apache.fineract.template.service.TemplateMergeService;
import org.apache.fineract.useradministration.service.PasswordValidationPolicyReadPlatformService;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Boot composition-root Equinox embed (ADR-022 B3). Off unless
 * {@code fineract.osgi.enabled=true}.
 */
@Configuration
@ConditionalOnProperty(name = "fineract.osgi.enabled", havingValue = "true")
public class EquinoxOsgiConfiguration {

    @Bean
    public SpringOsgiPortBridge springOsgiPortBridge(final ObjectProvider<ChargeDefinitionPort> charge,
            final ObjectProvider<FloatingRatePort> rates, final ObjectProvider<TaxCatalogPort> tax,
            final ObjectProvider<ContentStoreService> content, final ObjectProvider<CashierTxnValidationPort> cashier,
            final ObjectProvider<LoanOriginatorReadPlatformService> originator, final ObjectProvider<MixTaxonomyReadService> mix,
            final ObjectProvider<DelayedSettlementAttributeService> delayedSettlement,
            final ObjectProvider<GLClosureReadPlatformService> closures, final ObjectProvider<SavingsDropdownReadPlatformService> savings,
            final ObjectProvider<LoanProductLookupReadPort> loanProducts, final ObjectProvider<BuyDownFeeReadPlatformService> buyDown,
            final ObjectProvider<WorkingCapitalLoanPeriodPaymentRateChangeReadService> wcRateChange,
            final ObjectProvider<ConfigJobParameterService> cobJobs, final ObjectProvider<AccessTokenGenerationService> accessTokens,
            final ObjectProvider<BusinessDateReadPlatformService> businessDates, final ObjectProvider<CodeReadPlatformService> codes,
            final ObjectProvider<ProvisioningCategoryReadPlatformService> provisioning,
            final ObjectProvider<CurrencyWritePlatformService> currencies,
            final ObjectProvider<PasswordValidationPolicyReadPlatformService> passwordPolicies,
            final ObjectProvider<AdHocReadPlatformService> adhoc, final ObjectProvider<TemplateMergeService> templates,
            final ObjectProvider<UserNotificationService> notifications, final ObjectProvider<ScorecardReadPlatformService> scorecards,
            final ObjectProvider<FundReadPlatformService> funds,
            final ObjectProvider<AccountNumberFormatReadPlatformService> accountNumbers,
            final ObjectProvider<ReadLikelihoodService> likelihood, final ObjectProvider<TransferWritePlatformService> transfers,
            final ObjectProvider<PaymentTypeReadService> paymentTypes, final ObjectProvider<SearchReadService> search,
            final ObjectProvider<CollectionSheetWritePlatformService> collectionSheets,
            final ObjectProvider<StandingInstructionWritePlatformService> standingInstructions,
            final ObjectProvider<ShareProductDropdownReadPlatformService> shareProducts,
            final ObjectProvider<GroupLevelReadPlatformService> groupLevels,
            final ObjectProvider<ClientIdentifierWritePlatformService> clientIdentifiers,
            final ObjectProvider<RepaymentWithPostDatedChecksWritePlatformService> postDatedChecks,
            final ObjectProvider<ProductCommandsService> productCommands, final ObjectProvider<CacheWritePlatformService> cache,
            final ObjectProvider<FineractEntityAccessReadService> entityAccess,
            final ObjectProvider<CalendarDropdownReadPlatformService> calendars,
            final ObjectProvider<MeetingAttendanceDropdownReadService> meetings,
            final ObjectProvider<FieldConfigurationReadPlatformService> addressFields,
            final ObjectProvider<CreditBureauReadPlatformService> creditBureaus,
            final ObjectProvider<CollateralWritePlatformService> collateral,
            final ObjectProvider<CollateralManagementReadService> collateralMgmt, final ObjectProvider<NoteReadPlatformService> notes,
            final ObjectProvider<HookReadPlatformService> hooks, final ObjectProvider<SmsWritePlatformService> sms,
            final ObjectProvider<ReportMailingJobConfigurationReadPlatformService> reportMailing,
            final ObjectProvider<SmsCampaignDropdownReadPlatformService> smsCampaigns,
            final ObjectProvider<NotificationConfigurationReadService> gcmConfig,
            final ObjectProvider<ReportWritePlatformService> reports,
            final ObjectProvider<ExternalServicesReadPlatformService> externalServices,
            final ObjectProvider<StuckJobExecutorService> stuckJobs, final ObjectProvider<PropertyService> batchProperties) {
        return new SpringOsgiPortBridge(List.of(owned(ChargeDefinitionPort.class, charge),
                owned(FloatingRatePort.class, rates), owned(TaxCatalogPort.class, tax),
                owned(ContentStoreService.class, content), owned(CashierTxnValidationPort.class, cashier),
                owned(LoanOriginatorReadPlatformService.class, originator),
                owned(MixTaxonomyReadService.class, mix),
                owned(DelayedSettlementAttributeService.class, delayedSettlement),
                owned(GLClosureReadPlatformService.class, closures),
                owned(SavingsDropdownReadPlatformService.class, savings),
                owned(LoanProductLookupReadPort.class, loanProducts),
                owned(BuyDownFeeReadPlatformService.class, buyDown),
                owned(WorkingCapitalLoanPeriodPaymentRateChangeReadService.class, wcRateChange),
                owned(ConfigJobParameterService.class, cobJobs),
                owned(AccessTokenGenerationService.class, accessTokens),
                owned(BusinessDateReadPlatformService.class, businessDates),
                owned(CodeReadPlatformService.class, codes),
                owned(ProvisioningCategoryReadPlatformService.class, provisioning),
                owned(CurrencyWritePlatformService.class, currencies),
                owned(PasswordValidationPolicyReadPlatformService.class, passwordPolicies),
                owned(AdHocReadPlatformService.class, adhoc),
                owned(TemplateMergeService.class, templates),
                owned(UserNotificationService.class, notifications),
                owned(ScorecardReadPlatformService.class, scorecards),
                owned(FundReadPlatformService.class, funds),
                owned(AccountNumberFormatReadPlatformService.class, accountNumbers),
                owned(ReadLikelihoodService.class, likelihood),
                owned(TransferWritePlatformService.class, transfers),
                owned(PaymentTypeReadService.class, paymentTypes),
                owned(SearchReadService.class, search),
                owned(CollectionSheetWritePlatformService.class, collectionSheets),
                owned(StandingInstructionWritePlatformService.class, standingInstructions),
                owned(ShareProductDropdownReadPlatformService.class, shareProducts),
                owned(GroupLevelReadPlatformService.class, groupLevels),
                owned(ClientIdentifierWritePlatformService.class, clientIdentifiers),
                owned(RepaymentWithPostDatedChecksWritePlatformService.class, postDatedChecks),
                owned(ProductCommandsService.class, productCommands),
                owned(CacheWritePlatformService.class, cache),
                owned(FineractEntityAccessReadService.class, entityAccess),
                owned(CalendarDropdownReadPlatformService.class, calendars),
                owned(MeetingAttendanceDropdownReadService.class, meetings),
                owned(FieldConfigurationReadPlatformService.class, addressFields),
                owned(CreditBureauReadPlatformService.class, creditBureaus),
                owned(CollateralWritePlatformService.class, collateral),
                owned(CollateralManagementReadService.class, collateralMgmt),
                owned(NoteReadPlatformService.class, notes), owned(HookReadPlatformService.class, hooks),
                owned(SmsWritePlatformService.class, sms),
                owned(ReportMailingJobConfigurationReadPlatformService.class, reportMailing),
                owned(SmsCampaignDropdownReadPlatformService.class, smsCampaigns),
                owned(NotificationConfigurationReadService.class, gcmConfig),
                owned(ReportWritePlatformService.class, reports),
                owned(ExternalServicesReadPlatformService.class, externalServices),
                owned(StuckJobExecutorService.class, stuckJobs),
                owned(PropertyService.class, batchProperties)));
    }

    /**
     * Resolve the Spring-owned adapter at Equinox start, not at bean
     * construction — {@code @Primary} OSGi lookup proxies must not be
     * published back into the Service Registry.
     */
    private static <T> SpringOsgiPortBridge.Binding<T> owned(final Class<T> type, final ObjectProvider<T> provider) {
        return SpringOsgiPortBridge.bindLater(type, () -> SpringOsgiPortBridge.owned(provider.orderedStream().toList()));
    }

    @Bean
    public EquinoxFrameworkLifecycle equinoxFrameworkLifecycle(final SpringOsgiPortBridge bridge,
            @Value("${fineract.osgi.catalog-dir:}") final String catalogDir) {
        return new EquinoxFrameworkLifecycle(bridge, catalogDir.isBlank() ? null : Path.of(catalogDir).toAbsolutePath());
    }

    @Bean
    public OsgiServiceLookup osgiServiceLookup(final EquinoxFrameworkLifecycle lifecycle) {
        return new OsgiServiceLookup(lifecycle::getBundleContext);
    }
}
