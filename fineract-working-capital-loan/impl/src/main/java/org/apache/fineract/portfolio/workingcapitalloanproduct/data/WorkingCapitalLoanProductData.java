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
package org.apache.fineract.portfolio.workingcapitalloanproduct.data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import org.apache.fineract.accounting.glaccount.data.GLAccountData;
import org.apache.fineract.accounting.producttoaccountmapping.data.AdvancedMappingToExpenseAccountData;
import org.apache.fineract.accounting.producttoaccountmapping.data.ChargeToGLAccountMapper;
import org.apache.fineract.accounting.producttoaccountmapping.data.PaymentTypeToGLAccountMapper;
import org.apache.fineract.infrastructure.codes.data.CodeValueData;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.infrastructure.core.data.StringEnumOptionData;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.portfolio.charge.data.ChargeData;
import org.apache.fineract.portfolio.delinquency.data.DelinquencyBucketData;
import org.apache.fineract.portfolio.fund.data.FundData;
import org.apache.fineract.portfolio.paymenttype.data.PaymentTypeData;
import org.apache.fineract.portfolio.workingcapitalloanbreach.data.WorkingCapitalBreachData;
import org.apache.fineract.portfolio.workingcapitalloannearbreach.data.WorkingCapitalNearBreachData;

/**
 * Data Transfer Object for Working Capital Loan Product.
 */
public class WorkingCapitalLoanProductData implements Serializable {
    private Long id;
    private String name;
    private String shortName;
    private String description;
    private Long fundId;
    private String fundName;
    private LocalDate startDate;
    private LocalDate closeDate;
    private String externalId;
    private String status;
    // Currency details
    private CurrencyData currency;
    // Settings details
    private StringEnumOptionData amortizationType;
    private DelinquencyBucketData delinquencyBucket;
    private WorkingCapitalBreachData breach;
    private Integer npvDayCount;
    private List<WorkingCapitalPaymentAllocationData> paymentAllocation;
    private WorkingCapitalNearBreachData nearBreach;
    // Term details
    private BigDecimal minPrincipal;
    private BigDecimal principal;
    private BigDecimal maxPrincipal;
    private BigDecimal minPeriodPaymentRate;
    private BigDecimal periodPaymentRate;
    private BigDecimal maxPeriodPaymentRate;
    private BigDecimal discount;
    private Integer repaymentEvery;
    private StringEnumOptionData repaymentFrequencyType;
    private Integer delinquencyGraceDays;
    private StringEnumOptionData delinquencyStartType;
    private Integer breachGraceDays;
    // Configurable attributes (allowAttributeOverrides)
    private WorkingCapitalLoanProductConfigurableAttributesData allowAttributeOverrides;
    // Accounting
    private StringEnumOptionData accountingRule;
    private Map<String, GLAccountData> accountingMappings;
    private Collection<PaymentTypeToGLAccountMapper> paymentChannelToFundSourceMappings;
    private Collection<ChargeToGLAccountMapper> feeToIncomeAccountMappings;
    private Collection<ChargeToGLAccountMapper> penaltyToIncomeAccountMappings;
    private List<AdvancedMappingToExpenseAccountData> chargeOffReasonToExpenseAccountMappings;
    private List<AdvancedMappingToExpenseAccountData> writeOffReasonsToExpenseMappings;
    // Template related
    private Collection<FundData> fundOptions;
    private Collection<PaymentTypeData> paymentTypeOptions;
    private Collection<ChargeData> chargeOptions;
    private Collection<ChargeData> penaltyOptions;
    private Collection<CurrencyData> currencyOptions;
    private List<StringEnumOptionData> amortizationTypeOptions;
    private List<StringEnumOptionData> periodFrequencyTypeOptions;
    private List<StringEnumOptionData> advancedPaymentAllocationTypes;
    private List<StringEnumOptionData> delinquencyStartTypeOptions;
    private List<StringEnumOptionData> delinquencyMinimumPaymentTypeOptions;
    private List<EnumOptionData> advancedPaymentAllocationTransactionTypes;
    private Collection<DelinquencyBucketData> delinquencyBucketOptions;
    private List<WorkingCapitalBreachData> breachOptions;
    private List<StringEnumOptionData> accountingRuleOptions;
    private Map<String, List<GLAccountData>> accountingMappingOptions;
    private List<WorkingCapitalNearBreachData> nearBreachOptions;
    private List<CodeValueData> chargeOffReasonOptions;
    private List<CodeValueData> writeOffReasonOptions;

    public WorkingCapitalLoanProductData applyTemplate(final WorkingCapitalLoanProductData productTemplate) {
        setFundOptions(productTemplate.getFundOptions());
        setCurrencyOptions(productTemplate.getCurrencyOptions());
        setAmortizationTypeOptions(productTemplate.getAmortizationTypeOptions());
        setPeriodFrequencyTypeOptions(productTemplate.getPeriodFrequencyTypeOptions());
        setAdvancedPaymentAllocationTransactionTypes(productTemplate.getAdvancedPaymentAllocationTransactionTypes());
        setAdvancedPaymentAllocationTypes(productTemplate.getAdvancedPaymentAllocationTypes());
        setDelinquencyBucketOptions(productTemplate.getDelinquencyBucketOptions());
        setBreachOptions(productTemplate.getBreachOptions());
        setDelinquencyStartTypeOptions(productTemplate.getDelinquencyStartTypeOptions());
        setAccountingRuleOptions(productTemplate.getAccountingRuleOptions());
        setAccountingMappingOptions(productTemplate.getAccountingMappingOptions());
        setPaymentTypeOptions(productTemplate.getPaymentTypeOptions());
        setChargeOptions(productTemplate.getChargeOptions());
        setPenaltyOptions(productTemplate.getPenaltyOptions());
        setChargeOffReasonOptions(productTemplate.getChargeOffReasonOptions());
        setWriteOffReasonOptions(productTemplate.getWriteOffReasonOptions());
        setDelinquencyMinimumPaymentTypeOptions(productTemplate.getDelinquencyMinimumPaymentTypeOptions());
        setNearBreachOptions(productTemplate.getNearBreachOptions());
        return this;
    }


    @java.lang.SuppressWarnings("all")
        public static class WorkingCapitalLoanProductDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private String shortName;
        @java.lang.SuppressWarnings("all")
                private String description;
        @java.lang.SuppressWarnings("all")
                private Long fundId;
        @java.lang.SuppressWarnings("all")
                private String fundName;
        @java.lang.SuppressWarnings("all")
                private LocalDate startDate;
        @java.lang.SuppressWarnings("all")
                private LocalDate closeDate;
        @java.lang.SuppressWarnings("all")
                private String externalId;
        @java.lang.SuppressWarnings("all")
                private String status;
        @java.lang.SuppressWarnings("all")
                private CurrencyData currency;
        @java.lang.SuppressWarnings("all")
                private StringEnumOptionData amortizationType;
        @java.lang.SuppressWarnings("all")
                private DelinquencyBucketData delinquencyBucket;
        @java.lang.SuppressWarnings("all")
                private WorkingCapitalBreachData breach;
        @java.lang.SuppressWarnings("all")
                private Integer npvDayCount;
        @java.lang.SuppressWarnings("all")
                private List<WorkingCapitalPaymentAllocationData> paymentAllocation;
        @java.lang.SuppressWarnings("all")
                private WorkingCapitalNearBreachData nearBreach;
        @java.lang.SuppressWarnings("all")
                private BigDecimal minPrincipal;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principal;
        @java.lang.SuppressWarnings("all")
                private BigDecimal maxPrincipal;
        @java.lang.SuppressWarnings("all")
                private BigDecimal minPeriodPaymentRate;
        @java.lang.SuppressWarnings("all")
                private BigDecimal periodPaymentRate;
        @java.lang.SuppressWarnings("all")
                private BigDecimal maxPeriodPaymentRate;
        @java.lang.SuppressWarnings("all")
                private BigDecimal discount;
        @java.lang.SuppressWarnings("all")
                private Integer repaymentEvery;
        @java.lang.SuppressWarnings("all")
                private StringEnumOptionData repaymentFrequencyType;
        @java.lang.SuppressWarnings("all")
                private Integer delinquencyGraceDays;
        @java.lang.SuppressWarnings("all")
                private StringEnumOptionData delinquencyStartType;
        @java.lang.SuppressWarnings("all")
                private Integer breachGraceDays;
        @java.lang.SuppressWarnings("all")
                private WorkingCapitalLoanProductConfigurableAttributesData allowAttributeOverrides;
        @java.lang.SuppressWarnings("all")
                private StringEnumOptionData accountingRule;
        @java.lang.SuppressWarnings("all")
                private Map<String, GLAccountData> accountingMappings;
        @java.lang.SuppressWarnings("all")
                private Collection<PaymentTypeToGLAccountMapper> paymentChannelToFundSourceMappings;
        @java.lang.SuppressWarnings("all")
                private Collection<ChargeToGLAccountMapper> feeToIncomeAccountMappings;
        @java.lang.SuppressWarnings("all")
                private Collection<ChargeToGLAccountMapper> penaltyToIncomeAccountMappings;
        @java.lang.SuppressWarnings("all")
                private List<AdvancedMappingToExpenseAccountData> chargeOffReasonToExpenseAccountMappings;
        @java.lang.SuppressWarnings("all")
                private List<AdvancedMappingToExpenseAccountData> writeOffReasonsToExpenseMappings;
        @java.lang.SuppressWarnings("all")
                private Collection<FundData> fundOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<PaymentTypeData> paymentTypeOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<ChargeData> chargeOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<ChargeData> penaltyOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<CurrencyData> currencyOptions;
        @java.lang.SuppressWarnings("all")
                private List<StringEnumOptionData> amortizationTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<StringEnumOptionData> periodFrequencyTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<StringEnumOptionData> advancedPaymentAllocationTypes;
        @java.lang.SuppressWarnings("all")
                private List<StringEnumOptionData> delinquencyStartTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<StringEnumOptionData> delinquencyMinimumPaymentTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<EnumOptionData> advancedPaymentAllocationTransactionTypes;
        @java.lang.SuppressWarnings("all")
                private Collection<DelinquencyBucketData> delinquencyBucketOptions;
        @java.lang.SuppressWarnings("all")
                private List<WorkingCapitalBreachData> breachOptions;
        @java.lang.SuppressWarnings("all")
                private List<StringEnumOptionData> accountingRuleOptions;
        @java.lang.SuppressWarnings("all")
                private Map<String, List<GLAccountData>> accountingMappingOptions;
        @java.lang.SuppressWarnings("all")
                private List<WorkingCapitalNearBreachData> nearBreachOptions;
        @java.lang.SuppressWarnings("all")
                private List<CodeValueData> chargeOffReasonOptions;
        @java.lang.SuppressWarnings("all")
                private List<CodeValueData> writeOffReasonOptions;

        @java.lang.SuppressWarnings("all")
                WorkingCapitalLoanProductDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder shortName(final String shortName) {
            this.shortName = shortName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder description(final String description) {
            this.description = description;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder fundId(final Long fundId) {
            this.fundId = fundId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder fundName(final String fundName) {
            this.fundName = fundName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder startDate(final LocalDate startDate) {
            this.startDate = startDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder closeDate(final LocalDate closeDate) {
            this.closeDate = closeDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder externalId(final String externalId) {
            this.externalId = externalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder status(final String status) {
            this.status = status;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder currency(final CurrencyData currency) {
            this.currency = currency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder amortizationType(final StringEnumOptionData amortizationType) {
            this.amortizationType = amortizationType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder delinquencyBucket(final DelinquencyBucketData delinquencyBucket) {
            this.delinquencyBucket = delinquencyBucket;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder breach(final WorkingCapitalBreachData breach) {
            this.breach = breach;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder npvDayCount(final Integer npvDayCount) {
            this.npvDayCount = npvDayCount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder paymentAllocation(final List<WorkingCapitalPaymentAllocationData> paymentAllocation) {
            this.paymentAllocation = paymentAllocation;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder nearBreach(final WorkingCapitalNearBreachData nearBreach) {
            this.nearBreach = nearBreach;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder minPrincipal(final BigDecimal minPrincipal) {
            this.minPrincipal = minPrincipal;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder principal(final BigDecimal principal) {
            this.principal = principal;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder maxPrincipal(final BigDecimal maxPrincipal) {
            this.maxPrincipal = maxPrincipal;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder minPeriodPaymentRate(final BigDecimal minPeriodPaymentRate) {
            this.minPeriodPaymentRate = minPeriodPaymentRate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder periodPaymentRate(final BigDecimal periodPaymentRate) {
            this.periodPaymentRate = periodPaymentRate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder maxPeriodPaymentRate(final BigDecimal maxPeriodPaymentRate) {
            this.maxPeriodPaymentRate = maxPeriodPaymentRate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder discount(final BigDecimal discount) {
            this.discount = discount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder repaymentEvery(final Integer repaymentEvery) {
            this.repaymentEvery = repaymentEvery;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder repaymentFrequencyType(final StringEnumOptionData repaymentFrequencyType) {
            this.repaymentFrequencyType = repaymentFrequencyType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder delinquencyGraceDays(final Integer delinquencyGraceDays) {
            this.delinquencyGraceDays = delinquencyGraceDays;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder delinquencyStartType(final StringEnumOptionData delinquencyStartType) {
            this.delinquencyStartType = delinquencyStartType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder breachGraceDays(final Integer breachGraceDays) {
            this.breachGraceDays = breachGraceDays;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder allowAttributeOverrides(final WorkingCapitalLoanProductConfigurableAttributesData allowAttributeOverrides) {
            this.allowAttributeOverrides = allowAttributeOverrides;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder accountingRule(final StringEnumOptionData accountingRule) {
            this.accountingRule = accountingRule;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder accountingMappings(final Map<String, GLAccountData> accountingMappings) {
            this.accountingMappings = accountingMappings;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder paymentChannelToFundSourceMappings(final Collection<PaymentTypeToGLAccountMapper> paymentChannelToFundSourceMappings) {
            this.paymentChannelToFundSourceMappings = paymentChannelToFundSourceMappings;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder feeToIncomeAccountMappings(final Collection<ChargeToGLAccountMapper> feeToIncomeAccountMappings) {
            this.feeToIncomeAccountMappings = feeToIncomeAccountMappings;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder penaltyToIncomeAccountMappings(final Collection<ChargeToGLAccountMapper> penaltyToIncomeAccountMappings) {
            this.penaltyToIncomeAccountMappings = penaltyToIncomeAccountMappings;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder chargeOffReasonToExpenseAccountMappings(final List<AdvancedMappingToExpenseAccountData> chargeOffReasonToExpenseAccountMappings) {
            this.chargeOffReasonToExpenseAccountMappings = chargeOffReasonToExpenseAccountMappings;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder writeOffReasonsToExpenseMappings(final List<AdvancedMappingToExpenseAccountData> writeOffReasonsToExpenseMappings) {
            this.writeOffReasonsToExpenseMappings = writeOffReasonsToExpenseMappings;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder fundOptions(final Collection<FundData> fundOptions) {
            this.fundOptions = fundOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder paymentTypeOptions(final Collection<PaymentTypeData> paymentTypeOptions) {
            this.paymentTypeOptions = paymentTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder chargeOptions(final Collection<ChargeData> chargeOptions) {
            this.chargeOptions = chargeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder penaltyOptions(final Collection<ChargeData> penaltyOptions) {
            this.penaltyOptions = penaltyOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder currencyOptions(final Collection<CurrencyData> currencyOptions) {
            this.currencyOptions = currencyOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder amortizationTypeOptions(final List<StringEnumOptionData> amortizationTypeOptions) {
            this.amortizationTypeOptions = amortizationTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder periodFrequencyTypeOptions(final List<StringEnumOptionData> periodFrequencyTypeOptions) {
            this.periodFrequencyTypeOptions = periodFrequencyTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder advancedPaymentAllocationTypes(final List<StringEnumOptionData> advancedPaymentAllocationTypes) {
            this.advancedPaymentAllocationTypes = advancedPaymentAllocationTypes;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder delinquencyStartTypeOptions(final List<StringEnumOptionData> delinquencyStartTypeOptions) {
            this.delinquencyStartTypeOptions = delinquencyStartTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder delinquencyMinimumPaymentTypeOptions(final List<StringEnumOptionData> delinquencyMinimumPaymentTypeOptions) {
            this.delinquencyMinimumPaymentTypeOptions = delinquencyMinimumPaymentTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder advancedPaymentAllocationTransactionTypes(final List<EnumOptionData> advancedPaymentAllocationTransactionTypes) {
            this.advancedPaymentAllocationTransactionTypes = advancedPaymentAllocationTransactionTypes;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder delinquencyBucketOptions(final Collection<DelinquencyBucketData> delinquencyBucketOptions) {
            this.delinquencyBucketOptions = delinquencyBucketOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder breachOptions(final List<WorkingCapitalBreachData> breachOptions) {
            this.breachOptions = breachOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder accountingRuleOptions(final List<StringEnumOptionData> accountingRuleOptions) {
            this.accountingRuleOptions = accountingRuleOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder accountingMappingOptions(final Map<String, List<GLAccountData>> accountingMappingOptions) {
            this.accountingMappingOptions = accountingMappingOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder nearBreachOptions(final List<WorkingCapitalNearBreachData> nearBreachOptions) {
            this.nearBreachOptions = nearBreachOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder chargeOffReasonOptions(final List<CodeValueData> chargeOffReasonOptions) {
            this.chargeOffReasonOptions = chargeOffReasonOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder writeOffReasonOptions(final List<CodeValueData> writeOffReasonOptions) {
            this.writeOffReasonOptions = writeOffReasonOptions;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductData build() {
            return new WorkingCapitalLoanProductData(this.id, this.name, this.shortName, this.description, this.fundId, this.fundName, this.startDate, this.closeDate, this.externalId, this.status, this.currency, this.amortizationType, this.delinquencyBucket, this.breach, this.npvDayCount, this.paymentAllocation, this.nearBreach, this.minPrincipal, this.principal, this.maxPrincipal, this.minPeriodPaymentRate, this.periodPaymentRate, this.maxPeriodPaymentRate, this.discount, this.repaymentEvery, this.repaymentFrequencyType, this.delinquencyGraceDays, this.delinquencyStartType, this.breachGraceDays, this.allowAttributeOverrides, this.accountingRule, this.accountingMappings, this.paymentChannelToFundSourceMappings, this.feeToIncomeAccountMappings, this.penaltyToIncomeAccountMappings, this.chargeOffReasonToExpenseAccountMappings, this.writeOffReasonsToExpenseMappings, this.fundOptions, this.paymentTypeOptions, this.chargeOptions, this.penaltyOptions, this.currencyOptions, this.amortizationTypeOptions, this.periodFrequencyTypeOptions, this.advancedPaymentAllocationTypes, this.delinquencyStartTypeOptions, this.delinquencyMinimumPaymentTypeOptions, this.advancedPaymentAllocationTransactionTypes, this.delinquencyBucketOptions, this.breachOptions, this.accountingRuleOptions, this.accountingMappingOptions, this.nearBreachOptions, this.chargeOffReasonOptions, this.writeOffReasonOptions);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder(id=" + this.id + ", name=" + this.name + ", shortName=" + this.shortName + ", description=" + this.description + ", fundId=" + this.fundId + ", fundName=" + this.fundName + ", startDate=" + this.startDate + ", closeDate=" + this.closeDate + ", externalId=" + this.externalId + ", status=" + this.status + ", currency=" + this.currency + ", amortizationType=" + this.amortizationType + ", delinquencyBucket=" + this.delinquencyBucket + ", breach=" + this.breach + ", npvDayCount=" + this.npvDayCount + ", paymentAllocation=" + this.paymentAllocation + ", nearBreach=" + this.nearBreach + ", minPrincipal=" + this.minPrincipal + ", principal=" + this.principal + ", maxPrincipal=" + this.maxPrincipal + ", minPeriodPaymentRate=" + this.minPeriodPaymentRate + ", periodPaymentRate=" + this.periodPaymentRate + ", maxPeriodPaymentRate=" + this.maxPeriodPaymentRate + ", discount=" + this.discount + ", repaymentEvery=" + this.repaymentEvery + ", repaymentFrequencyType=" + this.repaymentFrequencyType + ", delinquencyGraceDays=" + this.delinquencyGraceDays + ", delinquencyStartType=" + this.delinquencyStartType + ", breachGraceDays=" + this.breachGraceDays + ", allowAttributeOverrides=" + this.allowAttributeOverrides + ", accountingRule=" + this.accountingRule + ", accountingMappings=" + this.accountingMappings + ", paymentChannelToFundSourceMappings=" + this.paymentChannelToFundSourceMappings + ", feeToIncomeAccountMappings=" + this.feeToIncomeAccountMappings + ", penaltyToIncomeAccountMappings=" + this.penaltyToIncomeAccountMappings + ", chargeOffReasonToExpenseAccountMappings=" + this.chargeOffReasonToExpenseAccountMappings + ", writeOffReasonsToExpenseMappings=" + this.writeOffReasonsToExpenseMappings + ", fundOptions=" + this.fundOptions + ", paymentTypeOptions=" + this.paymentTypeOptions + ", chargeOptions=" + this.chargeOptions + ", penaltyOptions=" + this.penaltyOptions + ", currencyOptions=" + this.currencyOptions + ", amortizationTypeOptions=" + this.amortizationTypeOptions + ", periodFrequencyTypeOptions=" + this.periodFrequencyTypeOptions + ", advancedPaymentAllocationTypes=" + this.advancedPaymentAllocationTypes + ", delinquencyStartTypeOptions=" + this.delinquencyStartTypeOptions + ", delinquencyMinimumPaymentTypeOptions=" + this.delinquencyMinimumPaymentTypeOptions + ", advancedPaymentAllocationTransactionTypes=" + this.advancedPaymentAllocationTransactionTypes + ", delinquencyBucketOptions=" + this.delinquencyBucketOptions + ", breachOptions=" + this.breachOptions + ", accountingRuleOptions=" + this.accountingRuleOptions + ", accountingMappingOptions=" + this.accountingMappingOptions + ", nearBreachOptions=" + this.nearBreachOptions + ", chargeOffReasonOptions=" + this.chargeOffReasonOptions + ", writeOffReasonOptions=" + this.writeOffReasonOptions + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder builder() {
        return new WorkingCapitalLoanProductData.WorkingCapitalLoanProductDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getShortName() {
        return this.shortName;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public Long getFundId() {
        return this.fundId;
    }

    @java.lang.SuppressWarnings("all")
        public String getFundName() {
        return this.fundName;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getStartDate() {
        return this.startDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getCloseDate() {
        return this.closeDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public String getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getAmortizationType() {
        return this.amortizationType;
    }

    @java.lang.SuppressWarnings("all")
        public DelinquencyBucketData getDelinquencyBucket() {
        return this.delinquencyBucket;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalBreachData getBreach() {
        return this.breach;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getNpvDayCount() {
        return this.npvDayCount;
    }

    @java.lang.SuppressWarnings("all")
        public List<WorkingCapitalPaymentAllocationData> getPaymentAllocation() {
        return this.paymentAllocation;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalNearBreachData getNearBreach() {
        return this.nearBreach;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMinPrincipal() {
        return this.minPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipal() {
        return this.principal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMaxPrincipal() {
        return this.maxPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMinPeriodPaymentRate() {
        return this.minPeriodPaymentRate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPeriodPaymentRate() {
        return this.periodPaymentRate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMaxPeriodPaymentRate() {
        return this.maxPeriodPaymentRate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDiscount() {
        return this.discount;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRepaymentEvery() {
        return this.repaymentEvery;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getRepaymentFrequencyType() {
        return this.repaymentFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getDelinquencyGraceDays() {
        return this.delinquencyGraceDays;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getDelinquencyStartType() {
        return this.delinquencyStartType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getBreachGraceDays() {
        return this.breachGraceDays;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanProductConfigurableAttributesData getAllowAttributeOverrides() {
        return this.allowAttributeOverrides;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getAccountingRule() {
        return this.accountingRule;
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, GLAccountData> getAccountingMappings() {
        return this.accountingMappings;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<PaymentTypeToGLAccountMapper> getPaymentChannelToFundSourceMappings() {
        return this.paymentChannelToFundSourceMappings;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<ChargeToGLAccountMapper> getFeeToIncomeAccountMappings() {
        return this.feeToIncomeAccountMappings;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<ChargeToGLAccountMapper> getPenaltyToIncomeAccountMappings() {
        return this.penaltyToIncomeAccountMappings;
    }

    @java.lang.SuppressWarnings("all")
        public List<AdvancedMappingToExpenseAccountData> getChargeOffReasonToExpenseAccountMappings() {
        return this.chargeOffReasonToExpenseAccountMappings;
    }

    @java.lang.SuppressWarnings("all")
        public List<AdvancedMappingToExpenseAccountData> getWriteOffReasonsToExpenseMappings() {
        return this.writeOffReasonsToExpenseMappings;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<FundData> getFundOptions() {
        return this.fundOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<PaymentTypeData> getPaymentTypeOptions() {
        return this.paymentTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<ChargeData> getChargeOptions() {
        return this.chargeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<ChargeData> getPenaltyOptions() {
        return this.penaltyOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CurrencyData> getCurrencyOptions() {
        return this.currencyOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getAmortizationTypeOptions() {
        return this.amortizationTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getPeriodFrequencyTypeOptions() {
        return this.periodFrequencyTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getAdvancedPaymentAllocationTypes() {
        return this.advancedPaymentAllocationTypes;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getDelinquencyStartTypeOptions() {
        return this.delinquencyStartTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getDelinquencyMinimumPaymentTypeOptions() {
        return this.delinquencyMinimumPaymentTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getAdvancedPaymentAllocationTransactionTypes() {
        return this.advancedPaymentAllocationTransactionTypes;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<DelinquencyBucketData> getDelinquencyBucketOptions() {
        return this.delinquencyBucketOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<WorkingCapitalBreachData> getBreachOptions() {
        return this.breachOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getAccountingRuleOptions() {
        return this.accountingRuleOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, List<GLAccountData>> getAccountingMappingOptions() {
        return this.accountingMappingOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<WorkingCapitalNearBreachData> getNearBreachOptions() {
        return this.nearBreachOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<CodeValueData> getChargeOffReasonOptions() {
        return this.chargeOffReasonOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<CodeValueData> getWriteOffReasonOptions() {
        return this.writeOffReasonOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setShortName(final String shortName) {
        this.shortName = shortName;
    }

    @java.lang.SuppressWarnings("all")
        public void setDescription(final String description) {
        this.description = description;
    }

    @java.lang.SuppressWarnings("all")
        public void setFundId(final Long fundId) {
        this.fundId = fundId;
    }

    @java.lang.SuppressWarnings("all")
        public void setFundName(final String fundName) {
        this.fundName = fundName;
    }

    @java.lang.SuppressWarnings("all")
        public void setStartDate(final LocalDate startDate) {
        this.startDate = startDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setCloseDate(final LocalDate closeDate) {
        this.closeDate = closeDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalId(final String externalId) {
        this.externalId = externalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setStatus(final String status) {
        this.status = status;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrency(final CurrencyData currency) {
        this.currency = currency;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmortizationType(final StringEnumOptionData amortizationType) {
        this.amortizationType = amortizationType;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyBucket(final DelinquencyBucketData delinquencyBucket) {
        this.delinquencyBucket = delinquencyBucket;
    }

    @java.lang.SuppressWarnings("all")
        public void setBreach(final WorkingCapitalBreachData breach) {
        this.breach = breach;
    }

    @java.lang.SuppressWarnings("all")
        public void setNpvDayCount(final Integer npvDayCount) {
        this.npvDayCount = npvDayCount;
    }

    @java.lang.SuppressWarnings("all")
        public void setPaymentAllocation(final List<WorkingCapitalPaymentAllocationData> paymentAllocation) {
        this.paymentAllocation = paymentAllocation;
    }

    @java.lang.SuppressWarnings("all")
        public void setNearBreach(final WorkingCapitalNearBreachData nearBreach) {
        this.nearBreach = nearBreach;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinPrincipal(final BigDecimal minPrincipal) {
        this.minPrincipal = minPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public void setPrincipal(final BigDecimal principal) {
        this.principal = principal;
    }

    @java.lang.SuppressWarnings("all")
        public void setMaxPrincipal(final BigDecimal maxPrincipal) {
        this.maxPrincipal = maxPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinPeriodPaymentRate(final BigDecimal minPeriodPaymentRate) {
        this.minPeriodPaymentRate = minPeriodPaymentRate;
    }

    @java.lang.SuppressWarnings("all")
        public void setPeriodPaymentRate(final BigDecimal periodPaymentRate) {
        this.periodPaymentRate = periodPaymentRate;
    }

    @java.lang.SuppressWarnings("all")
        public void setMaxPeriodPaymentRate(final BigDecimal maxPeriodPaymentRate) {
        this.maxPeriodPaymentRate = maxPeriodPaymentRate;
    }

    @java.lang.SuppressWarnings("all")
        public void setDiscount(final BigDecimal discount) {
        this.discount = discount;
    }

    @java.lang.SuppressWarnings("all")
        public void setRepaymentEvery(final Integer repaymentEvery) {
        this.repaymentEvery = repaymentEvery;
    }

    @java.lang.SuppressWarnings("all")
        public void setRepaymentFrequencyType(final StringEnumOptionData repaymentFrequencyType) {
        this.repaymentFrequencyType = repaymentFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyGraceDays(final Integer delinquencyGraceDays) {
        this.delinquencyGraceDays = delinquencyGraceDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyStartType(final StringEnumOptionData delinquencyStartType) {
        this.delinquencyStartType = delinquencyStartType;
    }

    @java.lang.SuppressWarnings("all")
        public void setBreachGraceDays(final Integer breachGraceDays) {
        this.breachGraceDays = breachGraceDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setAllowAttributeOverrides(final WorkingCapitalLoanProductConfigurableAttributesData allowAttributeOverrides) {
        this.allowAttributeOverrides = allowAttributeOverrides;
    }

    @java.lang.SuppressWarnings("all")
        public void setAccountingRule(final StringEnumOptionData accountingRule) {
        this.accountingRule = accountingRule;
    }

    @java.lang.SuppressWarnings("all")
        public void setAccountingMappings(final Map<String, GLAccountData> accountingMappings) {
        this.accountingMappings = accountingMappings;
    }

    @java.lang.SuppressWarnings("all")
        public void setPaymentChannelToFundSourceMappings(final Collection<PaymentTypeToGLAccountMapper> paymentChannelToFundSourceMappings) {
        this.paymentChannelToFundSourceMappings = paymentChannelToFundSourceMappings;
    }

    @java.lang.SuppressWarnings("all")
        public void setFeeToIncomeAccountMappings(final Collection<ChargeToGLAccountMapper> feeToIncomeAccountMappings) {
        this.feeToIncomeAccountMappings = feeToIncomeAccountMappings;
    }

    @java.lang.SuppressWarnings("all")
        public void setPenaltyToIncomeAccountMappings(final Collection<ChargeToGLAccountMapper> penaltyToIncomeAccountMappings) {
        this.penaltyToIncomeAccountMappings = penaltyToIncomeAccountMappings;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargeOffReasonToExpenseAccountMappings(final List<AdvancedMappingToExpenseAccountData> chargeOffReasonToExpenseAccountMappings) {
        this.chargeOffReasonToExpenseAccountMappings = chargeOffReasonToExpenseAccountMappings;
    }

    @java.lang.SuppressWarnings("all")
        public void setWriteOffReasonsToExpenseMappings(final List<AdvancedMappingToExpenseAccountData> writeOffReasonsToExpenseMappings) {
        this.writeOffReasonsToExpenseMappings = writeOffReasonsToExpenseMappings;
    }

    @java.lang.SuppressWarnings("all")
        public void setFundOptions(final Collection<FundData> fundOptions) {
        this.fundOptions = fundOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setPaymentTypeOptions(final Collection<PaymentTypeData> paymentTypeOptions) {
        this.paymentTypeOptions = paymentTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargeOptions(final Collection<ChargeData> chargeOptions) {
        this.chargeOptions = chargeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setPenaltyOptions(final Collection<ChargeData> penaltyOptions) {
        this.penaltyOptions = penaltyOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrencyOptions(final Collection<CurrencyData> currencyOptions) {
        this.currencyOptions = currencyOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmortizationTypeOptions(final List<StringEnumOptionData> amortizationTypeOptions) {
        this.amortizationTypeOptions = amortizationTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setPeriodFrequencyTypeOptions(final List<StringEnumOptionData> periodFrequencyTypeOptions) {
        this.periodFrequencyTypeOptions = periodFrequencyTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setAdvancedPaymentAllocationTypes(final List<StringEnumOptionData> advancedPaymentAllocationTypes) {
        this.advancedPaymentAllocationTypes = advancedPaymentAllocationTypes;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyStartTypeOptions(final List<StringEnumOptionData> delinquencyStartTypeOptions) {
        this.delinquencyStartTypeOptions = delinquencyStartTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyMinimumPaymentTypeOptions(final List<StringEnumOptionData> delinquencyMinimumPaymentTypeOptions) {
        this.delinquencyMinimumPaymentTypeOptions = delinquencyMinimumPaymentTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setAdvancedPaymentAllocationTransactionTypes(final List<EnumOptionData> advancedPaymentAllocationTransactionTypes) {
        this.advancedPaymentAllocationTransactionTypes = advancedPaymentAllocationTransactionTypes;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyBucketOptions(final Collection<DelinquencyBucketData> delinquencyBucketOptions) {
        this.delinquencyBucketOptions = delinquencyBucketOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setBreachOptions(final List<WorkingCapitalBreachData> breachOptions) {
        this.breachOptions = breachOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setAccountingRuleOptions(final List<StringEnumOptionData> accountingRuleOptions) {
        this.accountingRuleOptions = accountingRuleOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setAccountingMappingOptions(final Map<String, List<GLAccountData>> accountingMappingOptions) {
        this.accountingMappingOptions = accountingMappingOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setNearBreachOptions(final List<WorkingCapitalNearBreachData> nearBreachOptions) {
        this.nearBreachOptions = nearBreachOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargeOffReasonOptions(final List<CodeValueData> chargeOffReasonOptions) {
        this.chargeOffReasonOptions = chargeOffReasonOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setWriteOffReasonOptions(final List<CodeValueData> writeOffReasonOptions) {
        this.writeOffReasonOptions = writeOffReasonOptions;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanProductData() {
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanProductData(final Long id, final String name, final String shortName, final String description, final Long fundId, final String fundName, final LocalDate startDate, final LocalDate closeDate, final String externalId, final String status, final CurrencyData currency, final StringEnumOptionData amortizationType, final DelinquencyBucketData delinquencyBucket, final WorkingCapitalBreachData breach, final Integer npvDayCount, final List<WorkingCapitalPaymentAllocationData> paymentAllocation, final WorkingCapitalNearBreachData nearBreach, final BigDecimal minPrincipal, final BigDecimal principal, final BigDecimal maxPrincipal, final BigDecimal minPeriodPaymentRate, final BigDecimal periodPaymentRate, final BigDecimal maxPeriodPaymentRate, final BigDecimal discount, final Integer repaymentEvery, final StringEnumOptionData repaymentFrequencyType, final Integer delinquencyGraceDays, final StringEnumOptionData delinquencyStartType, final Integer breachGraceDays, final WorkingCapitalLoanProductConfigurableAttributesData allowAttributeOverrides, final StringEnumOptionData accountingRule, final Map<String, GLAccountData> accountingMappings, final Collection<PaymentTypeToGLAccountMapper> paymentChannelToFundSourceMappings, final Collection<ChargeToGLAccountMapper> feeToIncomeAccountMappings, final Collection<ChargeToGLAccountMapper> penaltyToIncomeAccountMappings, final List<AdvancedMappingToExpenseAccountData> chargeOffReasonToExpenseAccountMappings, final List<AdvancedMappingToExpenseAccountData> writeOffReasonsToExpenseMappings, final Collection<FundData> fundOptions, final Collection<PaymentTypeData> paymentTypeOptions, final Collection<ChargeData> chargeOptions, final Collection<ChargeData> penaltyOptions, final Collection<CurrencyData> currencyOptions, final List<StringEnumOptionData> amortizationTypeOptions, final List<StringEnumOptionData> periodFrequencyTypeOptions, final List<StringEnumOptionData> advancedPaymentAllocationTypes, final List<StringEnumOptionData> delinquencyStartTypeOptions, final List<StringEnumOptionData> delinquencyMinimumPaymentTypeOptions, final List<EnumOptionData> advancedPaymentAllocationTransactionTypes, final Collection<DelinquencyBucketData> delinquencyBucketOptions, final List<WorkingCapitalBreachData> breachOptions, final List<StringEnumOptionData> accountingRuleOptions, final Map<String, List<GLAccountData>> accountingMappingOptions, final List<WorkingCapitalNearBreachData> nearBreachOptions, final List<CodeValueData> chargeOffReasonOptions, final List<CodeValueData> writeOffReasonOptions) {
        this.id = id;
        this.name = name;
        this.shortName = shortName;
        this.description = description;
        this.fundId = fundId;
        this.fundName = fundName;
        this.startDate = startDate;
        this.closeDate = closeDate;
        this.externalId = externalId;
        this.status = status;
        this.currency = currency;
        this.amortizationType = amortizationType;
        this.delinquencyBucket = delinquencyBucket;
        this.breach = breach;
        this.npvDayCount = npvDayCount;
        this.paymentAllocation = paymentAllocation;
        this.nearBreach = nearBreach;
        this.minPrincipal = minPrincipal;
        this.principal = principal;
        this.maxPrincipal = maxPrincipal;
        this.minPeriodPaymentRate = minPeriodPaymentRate;
        this.periodPaymentRate = periodPaymentRate;
        this.maxPeriodPaymentRate = maxPeriodPaymentRate;
        this.discount = discount;
        this.repaymentEvery = repaymentEvery;
        this.repaymentFrequencyType = repaymentFrequencyType;
        this.delinquencyGraceDays = delinquencyGraceDays;
        this.delinquencyStartType = delinquencyStartType;
        this.breachGraceDays = breachGraceDays;
        this.allowAttributeOverrides = allowAttributeOverrides;
        this.accountingRule = accountingRule;
        this.accountingMappings = accountingMappings;
        this.paymentChannelToFundSourceMappings = paymentChannelToFundSourceMappings;
        this.feeToIncomeAccountMappings = feeToIncomeAccountMappings;
        this.penaltyToIncomeAccountMappings = penaltyToIncomeAccountMappings;
        this.chargeOffReasonToExpenseAccountMappings = chargeOffReasonToExpenseAccountMappings;
        this.writeOffReasonsToExpenseMappings = writeOffReasonsToExpenseMappings;
        this.fundOptions = fundOptions;
        this.paymentTypeOptions = paymentTypeOptions;
        this.chargeOptions = chargeOptions;
        this.penaltyOptions = penaltyOptions;
        this.currencyOptions = currencyOptions;
        this.amortizationTypeOptions = amortizationTypeOptions;
        this.periodFrequencyTypeOptions = periodFrequencyTypeOptions;
        this.advancedPaymentAllocationTypes = advancedPaymentAllocationTypes;
        this.delinquencyStartTypeOptions = delinquencyStartTypeOptions;
        this.delinquencyMinimumPaymentTypeOptions = delinquencyMinimumPaymentTypeOptions;
        this.advancedPaymentAllocationTransactionTypes = advancedPaymentAllocationTransactionTypes;
        this.delinquencyBucketOptions = delinquencyBucketOptions;
        this.breachOptions = breachOptions;
        this.accountingRuleOptions = accountingRuleOptions;
        this.accountingMappingOptions = accountingMappingOptions;
        this.nearBreachOptions = nearBreachOptions;
        this.chargeOffReasonOptions = chargeOffReasonOptions;
        this.writeOffReasonOptions = writeOffReasonOptions;
    }
}
