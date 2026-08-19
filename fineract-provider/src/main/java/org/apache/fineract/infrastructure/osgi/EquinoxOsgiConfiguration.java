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
import org.apache.fineract.infrastructure.businessdate.service.BusinessDateReadPlatformService;
import org.apache.fineract.infrastructure.codes.service.CodeReadPlatformService;
import org.apache.fineract.infrastructure.contentstore.service.ContentStoreService;
import org.apache.fineract.infrastructure.security.service.AccessTokenGenerationService;
import org.apache.fineract.investor.service.DelayedSettlementAttributeService;
import org.apache.fineract.mix.service.MixTaxonomyReadService;
import org.apache.fineract.notification.service.UserNotificationService;
import org.apache.fineract.organisation.monetary.service.CurrencyWritePlatformService;
import org.apache.fineract.organisation.provisioning.service.ProvisioningCategoryReadPlatformService;
import org.apache.fineract.organisation.teller.moduleapi.CashierTxnValidationPort;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort;
import org.apache.fineract.portfolio.floatingrates.moduleapi.FloatingRatePort;
import org.apache.fineract.portfolio.loanaccount.progressiveloan.service.BuyDownFeeReadPlatformService;
import org.apache.fineract.portfolio.loanorigination.service.LoanOriginatorReadPlatformService;
import org.apache.fineract.portfolio.loanproduct.service.LoanProductLookupReadPort;
import org.apache.fineract.portfolio.savings.service.SavingsDropdownReadPlatformService;
import org.apache.fineract.portfolio.tax.moduleapi.TaxCatalogPort;
import org.apache.fineract.portfolio.workingcapitalloan.service.WorkingCapitalLoanPeriodPaymentRateChangeReadService;
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
            final ObjectProvider<UserNotificationService> notifications) {
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
                bind(UserNotificationService.class, notifications.getIfAvailable())));
    }

    @Bean
    public EquinoxFrameworkLifecycle equinoxFrameworkLifecycle(final SpringOsgiPortBridge bridge,
            @Value("${fineract.osgi.catalog-dir:}") final String catalogDir) {
        return new EquinoxFrameworkLifecycle(bridge, catalogDir.isBlank() ? null : Path.of(catalogDir).toAbsolutePath());
    }
}
