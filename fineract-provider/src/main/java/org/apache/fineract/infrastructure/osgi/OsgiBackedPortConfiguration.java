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
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

/**
 * OSGi→Spring port beans (ADR-022 B4 / playbook §15.5). {@code ChargeDefinitionPort}, {@code FloatingRatePort},
 * {@code TaxCatalogPort}, {@code ContentStoreService}, {@code CashierTxnValidationPort},
 * {@code LoanOriginatorReadPlatformService}, {@code MixTaxonomyReadService}, {@code DelayedSettlementAttributeService},
 * {@code GLClosureReadPlatformService}, {@code SavingsDropdownReadPlatformService}, {@code LoanProductLookupReadPort},
 * {@code BuyDownFeeReadPlatformService}, {@code WorkingCapitalLoanPeriodPaymentRateChangeReadService},
 * {@code ConfigJobParameterService}, {@code AccessTokenGenerationService}, {@code BusinessDateReadPlatformService},
 * {@code CodeReadPlatformService}, {@code ProvisioningCategoryReadPlatformService},
 * {@code CurrencyWritePlatformService}, {@code PasswordValidationPolicyReadPlatformService},
 * {@code AdHocReadPlatformService}, {@code TemplateMergeService}, {@code UserNotificationService},
 * {@code ScorecardReadPlatformService}, {@code FundReadPlatformService},
 * {@code AccountNumberFormatReadPlatformService}, {@code ReadLikelihoodService}, {@code TransferWritePlatformService},
 * {@code PaymentTypeReadService}, {@code SearchReadService}, and {@code CollectionSheetWritePlatformService} are
 * {@code @Primary} lookup façades when Equinox is on — Boot consumers resolve them from the Service Registry. Other
 * ports are created only when Boot has no bean of that type. {@code CommandDispatcher} stays hosted-only.
 * {@code ContentStreamPort} and {@code PaymentDetailWritePlatformService} stay empty-catalog only.
 */
@Configuration
@ConditionalOnProperty(name = "fineract.osgi.enabled", havingValue = "true")
public class OsgiBackedPortConfiguration {

    private static <T> T backed(final OsgiServiceLookup lookup, final Class<T> type) {
        return OsgiBackedPortFactory.of(lookup, type);
    }

    @Bean
    @Primary
    public ChargeDefinitionPort osgiChargeDefinitionPort(final OsgiServiceLookup lookup) {
        return backed(lookup, ChargeDefinitionPort.class);
    }

    @Bean
    @Primary
    public FloatingRatePort osgiFloatingRatePort(final OsgiServiceLookup lookup) {
        return backed(lookup, FloatingRatePort.class);
    }

    @Bean
    @Primary
    public TaxCatalogPort osgiTaxCatalogPort(final OsgiServiceLookup lookup) {
        return backed(lookup, TaxCatalogPort.class);
    }

    @Bean
    @Primary
    public ContentStoreService osgiContentStoreService(final OsgiServiceLookup lookup) {
        return backed(lookup, ContentStoreService.class);
    }

    @Bean
    @Primary
    public CashierTxnValidationPort osgiCashierTxnValidationPort(final OsgiServiceLookup lookup) {
        return backed(lookup, CashierTxnValidationPort.class);
    }

    @Bean
    @Primary
    public LoanOriginatorReadPlatformService osgiLoanOriginatorReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, LoanOriginatorReadPlatformService.class);
    }

    @Bean
    @Primary
    public MixTaxonomyReadService osgiMixTaxonomyReadService(final OsgiServiceLookup lookup) {
        return backed(lookup, MixTaxonomyReadService.class);
    }

    @Bean
    @Primary
    public DelayedSettlementAttributeService osgiDelayedSettlementAttributeService(final OsgiServiceLookup lookup) {
        return backed(lookup, DelayedSettlementAttributeService.class);
    }

    @Bean
    @Primary
    public GLClosureReadPlatformService osgiGLClosureReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, GLClosureReadPlatformService.class);
    }

    @Bean
    @Primary
    public SavingsDropdownReadPlatformService osgiSavingsDropdownReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, SavingsDropdownReadPlatformService.class);
    }

    @Bean
    @Primary
    public LoanProductLookupReadPort osgiLoanProductLookupReadPort(final OsgiServiceLookup lookup) {
        return backed(lookup, LoanProductLookupReadPort.class);
    }

    @Bean
    @Primary
    public BuyDownFeeReadPlatformService osgiBuyDownFeeReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, BuyDownFeeReadPlatformService.class);
    }

    @Bean
    @Primary
    public WorkingCapitalLoanPeriodPaymentRateChangeReadService osgiWorkingCapitalLoanPeriodPaymentRateChangeReadService(
            final OsgiServiceLookup lookup) {
        return backed(lookup, WorkingCapitalLoanPeriodPaymentRateChangeReadService.class);
    }

    @Bean
    @Primary
    public ConfigJobParameterService osgiConfigJobParameterService(final OsgiServiceLookup lookup) {
        return backed(lookup, ConfigJobParameterService.class);
    }

    @Bean
    @Primary
    public AccessTokenGenerationService osgiAccessTokenGenerationService(final OsgiServiceLookup lookup) {
        return backed(lookup, AccessTokenGenerationService.class);
    }

    @Bean
    @Primary
    public BusinessDateReadPlatformService osgiBusinessDateReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, BusinessDateReadPlatformService.class);
    }

    @Bean
    @Primary
    public CodeReadPlatformService osgiCodeReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, CodeReadPlatformService.class);
    }

    @Bean
    @Primary
    public ProvisioningCategoryReadPlatformService osgiProvisioningCategoryReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, ProvisioningCategoryReadPlatformService.class);
    }

    @Bean
    @Primary
    public CurrencyWritePlatformService osgiCurrencyWritePlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, CurrencyWritePlatformService.class);
    }

    @Bean
    @Primary
    public PasswordValidationPolicyReadPlatformService osgiPasswordValidationPolicyReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, PasswordValidationPolicyReadPlatformService.class);
    }

    @Bean
    @Primary
    public AdHocReadPlatformService osgiAdHocReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, AdHocReadPlatformService.class);
    }

    @Bean
    @Primary
    public TemplateMergeService osgiTemplateMergeService(final OsgiServiceLookup lookup) {
        return backed(lookup, TemplateMergeService.class);
    }

    @Bean
    @Primary
    public UserNotificationService osgiUserNotificationService(final OsgiServiceLookup lookup) {
        return backed(lookup, UserNotificationService.class);
    }

    @Bean
    @Primary
    public ScorecardReadPlatformService osgiScorecardReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, ScorecardReadPlatformService.class);
    }

    @Bean
    @Primary
    public FundReadPlatformService osgiFundReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, FundReadPlatformService.class);
    }

    @Bean
    @Primary
    public AccountNumberFormatReadPlatformService osgiAccountNumberFormatReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, AccountNumberFormatReadPlatformService.class);
    }

    @Bean
    @Primary
    public ReadLikelihoodService osgiReadLikelihoodService(final OsgiServiceLookup lookup) {
        return backed(lookup, ReadLikelihoodService.class);
    }

    @Bean
    @Primary
    public TransferWritePlatformService osgiTransferWritePlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, TransferWritePlatformService.class);
    }

    @Bean
    @Primary
    public PaymentTypeReadService osgiPaymentTypeReadService(final OsgiServiceLookup lookup) {
        return backed(lookup, PaymentTypeReadService.class);
    }

    @Bean
    @Primary
    public SearchReadService osgiSearchReadService(final OsgiServiceLookup lookup) {
        return backed(lookup, SearchReadService.class);
    }

    @Bean
    @Primary
    public CollectionSheetWritePlatformService osgiCollectionSheetWritePlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, CollectionSheetWritePlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(StandingInstructionWritePlatformService.class)
    public StandingInstructionWritePlatformService osgiStandingInstructionWritePlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, StandingInstructionWritePlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(ShareProductDropdownReadPlatformService.class)
    public ShareProductDropdownReadPlatformService osgiShareProductDropdownReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, ShareProductDropdownReadPlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(GroupLevelReadPlatformService.class)
    public GroupLevelReadPlatformService osgiGroupLevelReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, GroupLevelReadPlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(ClientIdentifierWritePlatformService.class)
    public ClientIdentifierWritePlatformService osgiClientIdentifierWritePlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, ClientIdentifierWritePlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(RepaymentWithPostDatedChecksWritePlatformService.class)
    public RepaymentWithPostDatedChecksWritePlatformService osgiRepaymentWithPostDatedChecksWritePlatformService(
            final OsgiServiceLookup lookup) {
        return backed(lookup, RepaymentWithPostDatedChecksWritePlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(ProductCommandsService.class)
    public ProductCommandsService osgiProductCommandsService(final OsgiServiceLookup lookup) {
        return backed(lookup, ProductCommandsService.class);
    }

    @Bean
    @ConditionalOnMissingBean(CacheWritePlatformService.class)
    public CacheWritePlatformService osgiCacheWritePlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, CacheWritePlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(FineractEntityAccessReadService.class)
    public FineractEntityAccessReadService osgiFineractEntityAccessReadService(final OsgiServiceLookup lookup) {
        return backed(lookup, FineractEntityAccessReadService.class);
    }

    @Bean
    @ConditionalOnMissingBean(CalendarDropdownReadPlatformService.class)
    public CalendarDropdownReadPlatformService osgiCalendarDropdownReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, CalendarDropdownReadPlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(MeetingAttendanceDropdownReadService.class)
    public MeetingAttendanceDropdownReadService osgiMeetingAttendanceDropdownReadService(final OsgiServiceLookup lookup) {
        return backed(lookup, MeetingAttendanceDropdownReadService.class);
    }

    @Bean
    @ConditionalOnMissingBean(FieldConfigurationReadPlatformService.class)
    public FieldConfigurationReadPlatformService osgiFieldConfigurationReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, FieldConfigurationReadPlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(CreditBureauReadPlatformService.class)
    public CreditBureauReadPlatformService osgiCreditBureauReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, CreditBureauReadPlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(CollateralWritePlatformService.class)
    public CollateralWritePlatformService osgiCollateralWritePlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, CollateralWritePlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(CollateralManagementReadService.class)
    public CollateralManagementReadService osgiCollateralManagementReadService(final OsgiServiceLookup lookup) {
        return backed(lookup, CollateralManagementReadService.class);
    }

    @Bean
    @ConditionalOnMissingBean(NoteReadPlatformService.class)
    public NoteReadPlatformService osgiNoteReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, NoteReadPlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(HookReadPlatformService.class)
    public HookReadPlatformService osgiHookReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, HookReadPlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(SmsWritePlatformService.class)
    public SmsWritePlatformService osgiSmsWritePlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, SmsWritePlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(ReportMailingJobConfigurationReadPlatformService.class)
    public ReportMailingJobConfigurationReadPlatformService osgiReportMailingJobConfigurationReadPlatformService(
            final OsgiServiceLookup lookup) {
        return backed(lookup, ReportMailingJobConfigurationReadPlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(SmsCampaignDropdownReadPlatformService.class)
    public SmsCampaignDropdownReadPlatformService osgiSmsCampaignDropdownReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, SmsCampaignDropdownReadPlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(NotificationConfigurationReadService.class)
    public NotificationConfigurationReadService osgiNotificationConfigurationReadService(final OsgiServiceLookup lookup) {
        return backed(lookup, NotificationConfigurationReadService.class);
    }

    @Bean
    @ConditionalOnMissingBean(ReportWritePlatformService.class)
    public ReportWritePlatformService osgiReportWritePlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, ReportWritePlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(ExternalServicesReadPlatformService.class)
    public ExternalServicesReadPlatformService osgiExternalServicesReadPlatformService(final OsgiServiceLookup lookup) {
        return backed(lookup, ExternalServicesReadPlatformService.class);
    }

    @Bean
    @ConditionalOnMissingBean(StuckJobExecutorService.class)
    public StuckJobExecutorService osgiStuckJobExecutorService(final OsgiServiceLookup lookup) {
        return backed(lookup, StuckJobExecutorService.class);
    }

    @Bean
    @ConditionalOnMissingBean(PropertyService.class)
    public PropertyService osgiPropertyService(final OsgiServiceLookup lookup) {
        return backed(lookup, PropertyService.class);
    }
}
