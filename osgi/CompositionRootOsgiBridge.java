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
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.accounting.closure.service.GLClosureReadPlatformService;
import org.apache.fineract.adhocquery.service.AdHocReadPlatformService;
import org.apache.fineract.cob.service.ConfigJobParameterService;
import org.apache.fineract.command.core.CommandDispatcher;
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
import org.osgi.framework.BundleContext;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceRegistration;

/**
 * Composition-root Spring→OSGi registration (ADR-022 B3 / playbook §15.5).
 * Boot owns the {@link BundleContext}; Spring 6 is not staged as Equinox
 * bundles. Ranks above empty catalog activators. Hosted implementations are
 * in-memory smoke stand-ins — JPA adapters stay on the Boot classpath.
 */
public final class CompositionRootOsgiBridge {

    public static final String PROVIDER = "fineract-osgi-bridge";
    public static final int RANKING = 1;

    private final BundleContext context;
    private final List<ServiceRegistration<?>> registrations = new ArrayList<>();

    public CompositionRootOsgiBridge(final BundleContext context) {
        this.context = context;
    }

    public void start() {
        register(ChargeDefinitionPort.class, new HostedChargeDefinitionPort());
        register(FloatingRatePort.class, new HostedFloatingRatePort());
        register(TaxCatalogPort.class, new HostedTaxCatalogPort());
        register(ContentStoreService.class, new HostedContentStoreService());
        register(CashierTxnValidationPort.class, new HostedCashierTxnValidationPort());
        register(LoanOriginatorReadPlatformService.class, new HostedLoanOriginatorReadPlatformService());
        register(MixTaxonomyReadService.class, new HostedMixTaxonomyReadService());
        register(DelayedSettlementAttributeService.class, new HostedDelayedSettlementAttributeService());
        register(CommandDispatcher.class, new HostedCommandDispatcher());
        register(GLClosureReadPlatformService.class, new HostedGLClosureReadPlatformService());
        register(SavingsDropdownReadPlatformService.class, new HostedSavingsDropdownReadPlatformService());
        register(LoanProductLookupReadPort.class, new HostedLoanProductLookupReadPort());
        register(BuyDownFeeReadPlatformService.class, new HostedBuyDownFeeReadPlatformService());
        register(WorkingCapitalLoanPeriodPaymentRateChangeReadService.class,
                new HostedWorkingCapitalLoanPeriodPaymentRateChangeReadService());
        register(ConfigJobParameterService.class, new HostedConfigJobParameterService());
        register(AccessTokenGenerationService.class, new HostedAccessTokenGenerationService());
        register(BusinessDateReadPlatformService.class, new HostedBusinessDateReadPlatformService());
        register(CodeReadPlatformService.class, new HostedCodeReadPlatformService());
        register(ProvisioningCategoryReadPlatformService.class, new HostedProvisioningCategoryReadPlatformService());
        register(CurrencyWritePlatformService.class, new HostedCurrencyWritePlatformService());
        register(PasswordValidationPolicyReadPlatformService.class, new HostedPasswordValidationPolicyReadPlatformService());
        register(AdHocReadPlatformService.class, new HostedAdHocReadPlatformService());
        register(TemplateMergeService.class, new HostedTemplateMergeService());
        register(UserNotificationService.class, new HostedUserNotificationService());
        register(ScorecardReadPlatformService.class, new HostedScorecardReadPlatformService());
        register(FundReadPlatformService.class, new HostedFundReadPlatformService());
        register(AccountNumberFormatReadPlatformService.class, new HostedAccountNumberFormatReadPlatformService());
        register(ReadLikelihoodService.class, new HostedReadLikelihoodService());
        register(TransferWritePlatformService.class, new HostedTransferWritePlatformService());
        register(PaymentTypeReadService.class, new HostedPaymentTypeReadService());
        register(SearchReadService.class, new HostedSearchReadService());
        register(CollectionSheetWritePlatformService.class, new HostedCollectionSheetWritePlatformService());
        register(StandingInstructionWritePlatformService.class, new HostedStandingInstructionWritePlatformService());
        register(ShareProductDropdownReadPlatformService.class, new HostedShareProductDropdownReadPlatformService());
        register(GroupLevelReadPlatformService.class, new HostedGroupLevelReadPlatformService());
        register(ClientIdentifierWritePlatformService.class, new HostedClientIdentifierWritePlatformService());
        register(RepaymentWithPostDatedChecksWritePlatformService.class, new HostedRepaymentWithPostDatedChecksWritePlatformService());
        register(ProductCommandsService.class, new HostedProductCommandsService());
        register(CacheWritePlatformService.class, new HostedCacheWritePlatformService());
        register(FineractEntityAccessReadService.class, new HostedFineractEntityAccessReadService());
        register(CalendarDropdownReadPlatformService.class, new HostedCalendarDropdownReadPlatformService());
        register(MeetingAttendanceDropdownReadService.class, new HostedMeetingAttendanceDropdownReadService());
        register(FieldConfigurationReadPlatformService.class, new HostedFieldConfigurationReadPlatformService());
        register(CreditBureauReadPlatformService.class, new HostedCreditBureauReadPlatformService());
        register(CollateralWritePlatformService.class, new HostedCollateralWritePlatformService());
        register(CollateralManagementReadService.class, new HostedCollateralManagementReadService());
        register(NoteReadPlatformService.class, new HostedNoteReadPlatformService());
        register(HookReadPlatformService.class, new HostedHookReadPlatformService());
        register(SmsWritePlatformService.class, new HostedSmsWritePlatformService());
        register(ReportMailingJobConfigurationReadPlatformService.class, new HostedReportMailingJobConfigurationReadPlatformService());
        register(SmsCampaignDropdownReadPlatformService.class, new HostedSmsCampaignDropdownReadPlatformService());
        register(NotificationConfigurationReadService.class, new HostedNotificationConfigurationReadService());
        register(ReportWritePlatformService.class, new HostedReportWritePlatformService());
        register(ExternalServicesReadPlatformService.class, new HostedExternalServicesReadPlatformService());
        register(StuckJobExecutorService.class, new HostedStuckJobExecutorService());
        register(PropertyService.class, new HostedPropertyService());
    }

    private <T> void register(final Class<T> type, final T service) {
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", PROVIDER);
        props.put(Constants.SERVICE_RANKING, RANKING);
        registrations.add(context.registerService(type, service, props));
    }

    public void stop() {
        for (int i = registrations.size() - 1; i >= 0; i--) {
            try {
                registrations.get(i).unregister();
            } catch (final IllegalStateException ignored) {
                // already unregistered
            }
        }
        registrations.clear();
    }
}
