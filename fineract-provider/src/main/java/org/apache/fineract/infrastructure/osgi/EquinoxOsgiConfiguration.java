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

import static org.apache.fineract.infrastructure.osgi.SpringOsgiPortBridge.bind;
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
        return new SpringOsgiPortBridge(List.of(bind(ChargeDefinitionPort.class, charge.getIfAvailable()),
                bind(FloatingRatePort.class, rates.getIfAvailable()), bind(TaxCatalogPort.class, tax.getIfAvailable()),
                bind(ContentStoreService.class, content.getIfAvailable()), bind(CashierTxnValidationPort.class, cashier.getIfAvailable()),
                bind(LoanOriginatorReadPlatformService.class, originator.getIfAvailable()),
                bind(MixTaxonomyReadService.class, mix.getIfAvailable()),
                bind(DelayedSettlementAttributeService.class, delayedSettlement.getIfAvailable()),
                bind(GLClosureReadPlatformService.class, closures.getIfAvailable()),
                bind(SavingsDropdownReadPlatformService.class, savings.getIfAvailable()),
                bind(LoanProductLookupReadPort.class, loanProducts.getIfAvailable()),
                bind(BuyDownFeeReadPlatformService.class, buyDown.getIfAvailable()),
                bind(WorkingCapitalLoanPeriodPaymentRateChangeReadService.class, wcRateChange.getIfAvailable()),
                bind(ConfigJobParameterService.class, cobJobs.getIfAvailable()),
                bind(AccessTokenGenerationService.class, accessTokens.getIfAvailable()),
                bind(BusinessDateReadPlatformService.class, businessDates.getIfAvailable()),
                bind(CodeReadPlatformService.class, codes.getIfAvailable()),
                bind(ProvisioningCategoryReadPlatformService.class, provisioning.getIfAvailable()),
                bind(CurrencyWritePlatformService.class, currencies.getIfAvailable()),
                bind(PasswordValidationPolicyReadPlatformService.class, passwordPolicies.getIfAvailable()),
                bind(AdHocReadPlatformService.class, adhoc.getIfAvailable()),
                bind(TemplateMergeService.class, templates.getIfAvailable()),
                bind(UserNotificationService.class, notifications.getIfAvailable()),
                bind(ScorecardReadPlatformService.class, scorecards.getIfAvailable()),
                bind(FundReadPlatformService.class, funds.getIfAvailable()),
                bind(AccountNumberFormatReadPlatformService.class, accountNumbers.getIfAvailable()),
                bind(ReadLikelihoodService.class, likelihood.getIfAvailable()),
                bind(TransferWritePlatformService.class, transfers.getIfAvailable()),
                bind(PaymentTypeReadService.class, paymentTypes.getIfAvailable()),
                bind(SearchReadService.class, search.getIfAvailable()),
                bind(CollectionSheetWritePlatformService.class, collectionSheets.getIfAvailable()),
                bind(StandingInstructionWritePlatformService.class, standingInstructions.getIfAvailable()),
                bind(ShareProductDropdownReadPlatformService.class, shareProducts.getIfAvailable()),
                bind(GroupLevelReadPlatformService.class, groupLevels.getIfAvailable()),
                bind(ClientIdentifierWritePlatformService.class, clientIdentifiers.getIfAvailable()),
                bind(RepaymentWithPostDatedChecksWritePlatformService.class, postDatedChecks.getIfAvailable()),
                bind(ProductCommandsService.class, productCommands.getIfAvailable()),
                bind(CacheWritePlatformService.class, cache.getIfAvailable()),
                bind(FineractEntityAccessReadService.class, entityAccess.getIfAvailable()),
                bind(CalendarDropdownReadPlatformService.class, calendars.getIfAvailable()),
                bind(MeetingAttendanceDropdownReadService.class, meetings.getIfAvailable()),
                bind(FieldConfigurationReadPlatformService.class, addressFields.getIfAvailable()),
                bind(CreditBureauReadPlatformService.class, creditBureaus.getIfAvailable()),
                bind(CollateralWritePlatformService.class, collateral.getIfAvailable()),
                bind(CollateralManagementReadService.class, collateralMgmt.getIfAvailable()),
                bind(NoteReadPlatformService.class, notes.getIfAvailable()), bind(HookReadPlatformService.class, hooks.getIfAvailable()),
                bind(SmsWritePlatformService.class, sms.getIfAvailable()),
                bind(ReportMailingJobConfigurationReadPlatformService.class, reportMailing.getIfAvailable()),
                bind(SmsCampaignDropdownReadPlatformService.class, smsCampaigns.getIfAvailable()),
                bind(NotificationConfigurationReadService.class, gcmConfig.getIfAvailable()),
                bind(ReportWritePlatformService.class, reports.getIfAvailable()),
                bind(ExternalServicesReadPlatformService.class, externalServices.getIfAvailable()),
                bind(StuckJobExecutorService.class, stuckJobs.getIfAvailable()),
                bind(PropertyService.class, batchProperties.getIfAvailable())));
    }

    @Bean
    public EquinoxFrameworkLifecycle equinoxFrameworkLifecycle(final SpringOsgiPortBridge bridge,
            @Value("${fineract.osgi.catalog-dir:}") final String catalogDir) {
        return new EquinoxFrameworkLifecycle(bridge, catalogDir.isBlank() ? null : Path.of(catalogDir).toAbsolutePath());
    }
}
