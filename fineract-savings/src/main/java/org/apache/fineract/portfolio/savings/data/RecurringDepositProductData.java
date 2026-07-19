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
package org.apache.fineract.portfolio.savings.data;

import java.math.BigDecimal;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import org.apache.fineract.accounting.common.AccountingRuleType;
import org.apache.fineract.accounting.glaccount.data.GLAccountData;
import org.apache.fineract.accounting.producttoaccountmapping.data.ChargeToGLAccountMapper;
import org.apache.fineract.accounting.producttoaccountmapping.data.PaymentTypeToGLAccountMapper;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.portfolio.charge.data.ChargeData;
import org.apache.fineract.portfolio.interestratechart.data.InterestRateChartData;
import org.apache.fineract.portfolio.paymenttype.data.PaymentTypeData;
import org.apache.fineract.portfolio.tax.data.TaxGroupData;

/**
 * Immutable data object representing a Recurring Deposit product.
 * <p>
 * Composes shared {@link DepositProductData} fields (flattened for Gson/API compatibility)
 * instead of extending that type.
 */
public final class RecurringDepositProductData {

    // Flattened shared product fields (composed from DepositProductData)
    private final Long id;
    private final String name;
    private final String shortName;
    private final String description;
    private final CurrencyData currency;
    private final BigDecimal nominalAnnualInterestRate;
    private final EnumOptionData interestCompoundingPeriodType;
    private final EnumOptionData interestPostingPeriodType;
    private final EnumOptionData interestCalculationType;
    private final EnumOptionData interestCalculationDaysInYearType;
    private final Integer lockinPeriodFrequency;
    private final EnumOptionData lockinPeriodFrequencyType;
    private final BigDecimal minBalanceForInterestCalculation;
    private final boolean withHoldTax;
    private final TaxGroupData taxGroup;
    private final EnumOptionData accountingRule;
    private final Map<String, Object> accountingMappings;
    private final Collection<PaymentTypeToGLAccountMapper> paymentChannelToFundSourceMappings;
    private final Collection<ChargeToGLAccountMapper> feeToIncomeAccountMappings;
    private final Collection<ChargeToGLAccountMapper> penaltyToIncomeAccountMappings;
    private final Collection<ChargeData> charges;
    private final Collection<InterestRateChartData> interestRateCharts;
    private final InterestRateChartData activeChart;
    private final Collection<CurrencyData> currencyOptions;
    private final Collection<EnumOptionData> interestCompoundingPeriodTypeOptions;
    private final Collection<EnumOptionData> interestPostingPeriodTypeOptions;
    private final Collection<EnumOptionData> interestCalculationTypeOptions;
    private final Collection<EnumOptionData> interestCalculationDaysInYearTypeOptions;
    private final Collection<EnumOptionData> lockinPeriodFrequencyTypeOptions;
    private final Collection<EnumOptionData> withdrawalFeeTypeOptions;
    private final Collection<PaymentTypeData> paymentTypeOptions;
    private final Collection<EnumOptionData> accountingRuleOptions;
    private final Map<String, List<GLAccountData>> accountingMappingOptions;
    private final Collection<ChargeData> chargeOptions;
    private final Collection<ChargeData> penaltyOptions;
    private final InterestRateChartData chartTemplate;
    private final Collection<TaxGroupData> taxGroupOptions;

    // Recurring-deposit specific fields
    private final boolean preClosurePenalApplicable;
    private final BigDecimal preClosurePenalInterest;
    private final EnumOptionData preClosurePenalInterestOnType;
    private final Integer minDepositTerm;
    private final Integer maxDepositTerm;
    private final EnumOptionData minDepositTermType;
    private final EnumOptionData maxDepositTermType;
    private final Integer inMultiplesOfDepositTerm;
    private final EnumOptionData inMultiplesOfDepositTermType;
    private final BigDecimal minDepositAmount;
    private final BigDecimal depositAmount;
    private final BigDecimal maxDepositAmount;
    private final boolean isMandatoryDeposit;
    private final boolean allowWithdrawal;
    private final boolean adjustAdvanceTowardsFuturePayments;
    private final Collection<EnumOptionData> preClosurePenalInterestOnTypeOptions;
    private final Collection<EnumOptionData> periodFrequencyTypeOptions;

    public static RecurringDepositProductData template(final CurrencyData currency, final EnumOptionData interestCompoundingPeriodType,
            final EnumOptionData interestPostingPeriodType, final EnumOptionData interestCalculationType,
            final EnumOptionData interestCalculationDaysInYearType, final EnumOptionData accountingRule,
            final Collection<CurrencyData> currencyOptions, final Collection<EnumOptionData> interestCompoundingPeriodTypeOptions,
            final Collection<EnumOptionData> interestPostingPeriodTypeOptions,
            final Collection<EnumOptionData> interestCalculationTypeOptions,
            final Collection<EnumOptionData> interestCalculationDaysInYearTypeOptions,
            final Collection<EnumOptionData> lockinPeriodFrequencyTypeOptions, final Collection<EnumOptionData> withdrawalFeeTypeOptions,
            final Collection<PaymentTypeData> paymentTypeOptions, final Collection<EnumOptionData> accountingRuleOptions,
            final Map<String, List<GLAccountData>> accountingMappingOptions, final Collection<ChargeData> chargeOptions,
            final Collection<ChargeData> penaltyOptions, final InterestRateChartData chartTemplate,
            final Collection<EnumOptionData> preClosurePenalInterestOnTypeOptions,
            final Collection<EnumOptionData> periodFrequencyTypeOptions, final Collection<TaxGroupData> taxGroupOptions) {

        final DepositProductData product = DepositProductData.template(currency, interestCompoundingPeriodType, interestPostingPeriodType,
                interestCalculationType, interestCalculationDaysInYearType, accountingRule, currencyOptions,
                interestCompoundingPeriodTypeOptions, interestPostingPeriodTypeOptions, interestCalculationTypeOptions,
                interestCalculationDaysInYearTypeOptions, lockinPeriodFrequencyTypeOptions, withdrawalFeeTypeOptions, paymentTypeOptions,
                accountingRuleOptions, accountingMappingOptions, chargeOptions, penaltyOptions, chartTemplate, taxGroupOptions);
        return fromProduct(product, false, null, null, null, null, null, null, null, null, false, false, false, null, null, null,
                preClosurePenalInterestOnTypeOptions, periodFrequencyTypeOptions);
    }

    public static RecurringDepositProductData withCharges(final RecurringDepositProductData existingProduct,
            final Collection<ChargeData> charges) {
        return fromProduct(DepositProductData.withCharges(existingProduct.asProductData(), charges), existingProduct);
    }

    public static RecurringDepositProductData withTemplate(final RecurringDepositProductData existingProduct,
            final Collection<CurrencyData> currencyOptions, final Collection<EnumOptionData> interestCompoundingPeriodTypeOptions,
            final Collection<EnumOptionData> interestPostingPeriodTypeOptions,
            final Collection<EnumOptionData> interestCalculationTypeOptions,
            final Collection<EnumOptionData> interestCalculationDaysInYearTypeOptions,
            final Collection<EnumOptionData> lockinPeriodFrequencyTypeOptions, final Collection<EnumOptionData> withdrawalFeeTypeOptions,
            final Collection<PaymentTypeData> paymentTypeOptions, final Collection<EnumOptionData> accountingRuleOptions,
            final Map<String, List<GLAccountData>> accountingMappingOptions, final Collection<ChargeData> chargeOptions,
            final Collection<ChargeData> penaltyOptions, final InterestRateChartData chartTemplate,
            final Collection<EnumOptionData> preClosurePenalInterestOnTypeOptions,
            final Collection<EnumOptionData> periodFrequencyTypeOptions, final Collection<TaxGroupData> taxGroupOptions) {

        final DepositProductData product = DepositProductData.withTemplate(existingProduct.asProductData(), currencyOptions,
                interestCompoundingPeriodTypeOptions, interestPostingPeriodTypeOptions, interestCalculationTypeOptions,
                interestCalculationDaysInYearTypeOptions, lockinPeriodFrequencyTypeOptions, withdrawalFeeTypeOptions, paymentTypeOptions,
                accountingRuleOptions, accountingMappingOptions, chargeOptions, penaltyOptions, chartTemplate, taxGroupOptions);
        return fromProduct(product, existingProduct.preClosurePenalApplicable, existingProduct.preClosurePenalInterest,
                existingProduct.preClosurePenalInterestOnType, existingProduct.minDepositTerm, existingProduct.maxDepositTerm,
                existingProduct.minDepositTermType, existingProduct.maxDepositTermType, existingProduct.inMultiplesOfDepositTerm,
                existingProduct.inMultiplesOfDepositTermType, existingProduct.isMandatoryDeposit, existingProduct.allowWithdrawal,
                existingProduct.adjustAdvanceTowardsFuturePayments, existingProduct.minDepositAmount, existingProduct.depositAmount,
                existingProduct.maxDepositAmount, preClosurePenalInterestOnTypeOptions, periodFrequencyTypeOptions);
    }

    public static RecurringDepositProductData withAccountingDetails(final RecurringDepositProductData existingProduct,
            final Map<String, Object> accountingMappings, final Collection<PaymentTypeToGLAccountMapper> paymentChannelToFundSourceMappings,
            final Collection<ChargeToGLAccountMapper> feeToIncomeAccountMappings,
            final Collection<ChargeToGLAccountMapper> penaltyToIncomeAccountMappings) {
        return fromProduct(DepositProductData.withAccountingDetails(existingProduct.asProductData(), accountingMappings,
                paymentChannelToFundSourceMappings, feeToIncomeAccountMappings, penaltyToIncomeAccountMappings), existingProduct);
    }

    public static RecurringDepositProductData instance(final DepositProductData depositProductData, final boolean preClosurePenalApplicable,
            final BigDecimal preClosurePenalInterest, final EnumOptionData preClosurePenalInterestOnType, final Integer minDepositTerm,
            final Integer maxDepositTerm, final EnumOptionData minDepositTermType, final EnumOptionData maxDepositTermType,
            final Integer inMultiplesOfDepositTerm, final EnumOptionData inMultiplesOfDepositTermType, final boolean isMandatoryDeposit,
            final boolean allowWithdrawal, final boolean adjustAdvanceTowardsFuturePayments, final BigDecimal minDepositAmount,
            final BigDecimal depositAmount, final BigDecimal maxDepositAmount) {
        return fromProduct(depositProductData, preClosurePenalApplicable, preClosurePenalInterest, preClosurePenalInterestOnType,
                minDepositTerm, maxDepositTerm, minDepositTermType, maxDepositTermType, inMultiplesOfDepositTerm,
                inMultiplesOfDepositTermType, isMandatoryDeposit, allowWithdrawal, adjustAdvanceTowardsFuturePayments, minDepositAmount,
                depositAmount, maxDepositAmount, null, null);
    }

    public static RecurringDepositProductData lookup(final Long id, final String name) {
        return fromProduct(DepositProductData.lookup(id, name), false, null, null, null, null, null, null, null, null, false, false, false,
                null, null, null, null, null);
    }

    public static RecurringDepositProductData withInterestChart(final RecurringDepositProductData product,
            final Collection<InterestRateChartData> interestRateCharts) {
        return fromProduct(DepositProductData.withInterestChart(product.asProductData(), interestRateCharts), product);
    }

    private static RecurringDepositProductData fromProduct(final DepositProductData product, final RecurringDepositProductData existing) {
        return fromProduct(product, existing.preClosurePenalApplicable, existing.preClosurePenalInterest,
                existing.preClosurePenalInterestOnType, existing.minDepositTerm, existing.maxDepositTerm, existing.minDepositTermType,
                existing.maxDepositTermType, existing.inMultiplesOfDepositTerm, existing.inMultiplesOfDepositTermType,
                existing.isMandatoryDeposit, existing.allowWithdrawal, existing.adjustAdvanceTowardsFuturePayments,
                existing.minDepositAmount, existing.depositAmount, existing.maxDepositAmount,
                existing.preClosurePenalInterestOnTypeOptions, existing.periodFrequencyTypeOptions);
    }

    private static RecurringDepositProductData fromProduct(final DepositProductData product, final boolean preClosurePenalApplicable,
            final BigDecimal preClosurePenalInterest, final EnumOptionData preClosurePenalInterestOnType, final Integer minDepositTerm,
            final Integer maxDepositTerm, final EnumOptionData minDepositTermType, final EnumOptionData maxDepositTermType,
            final Integer inMultiplesOfDepositTerm, final EnumOptionData inMultiplesOfDepositTermType, final boolean isMandatoryDeposit,
            final boolean allowWithdrawal, final boolean adjustAdvanceTowardsFuturePayments, final BigDecimal minDepositAmount,
            final BigDecimal depositAmount, final BigDecimal maxDepositAmount,
            final Collection<EnumOptionData> preClosurePenalInterestOnTypeOptions,
            final Collection<EnumOptionData> periodFrequencyTypeOptions) {
        return new RecurringDepositProductData(product, preClosurePenalApplicable, preClosurePenalInterest, preClosurePenalInterestOnType,
                minDepositTerm, maxDepositTerm, minDepositTermType, maxDepositTermType, inMultiplesOfDepositTerm,
                inMultiplesOfDepositTermType, isMandatoryDeposit, allowWithdrawal, adjustAdvanceTowardsFuturePayments, minDepositAmount,
                depositAmount, maxDepositAmount, preClosurePenalInterestOnTypeOptions, periodFrequencyTypeOptions);
    }

    private RecurringDepositProductData(final DepositProductData product, final boolean preClosurePenalApplicable,
            final BigDecimal preClosurePenalInterest, final EnumOptionData preClosurePenalInterestOnType, final Integer minDepositTerm,
            final Integer maxDepositTerm, final EnumOptionData minDepositTermType, final EnumOptionData maxDepositTermType,
            final Integer inMultiplesOfDepositTerm, final EnumOptionData inMultiplesOfDepositTermType, final boolean isMandatoryDeposit,
            final boolean allowWithdrawal, final boolean adjustAdvanceTowardsFuturePayments, final BigDecimal minDepositAmount,
            final BigDecimal depositAmount, final BigDecimal maxDepositAmount,
            final Collection<EnumOptionData> preClosurePenalInterestOnTypeOptions,
            final Collection<EnumOptionData> periodFrequencyTypeOptions) {
        this.id = product.id;
        this.name = product.name;
        this.shortName = product.shortName;
        this.description = product.description;
        this.currency = product.currency;
        this.nominalAnnualInterestRate = product.nominalAnnualInterestRate;
        this.interestCompoundingPeriodType = product.interestCompoundingPeriodType;
        this.interestPostingPeriodType = product.interestPostingPeriodType;
        this.interestCalculationType = product.interestCalculationType;
        this.interestCalculationDaysInYearType = product.interestCalculationDaysInYearType;
        this.lockinPeriodFrequency = product.lockinPeriodFrequency;
        this.lockinPeriodFrequencyType = product.lockinPeriodFrequencyType;
        this.minBalanceForInterestCalculation = product.minBalanceForInterestCalculation;
        this.withHoldTax = product.withHoldTax;
        this.taxGroup = product.taxGroup;
        this.accountingRule = product.accountingRule;
        this.accountingMappings = product.accountingMappings;
        this.paymentChannelToFundSourceMappings = product.paymentChannelToFundSourceMappings;
        this.feeToIncomeAccountMappings = product.feeToIncomeAccountMappings;
        this.penaltyToIncomeAccountMappings = product.penaltyToIncomeAccountMappings;
        this.charges = product.charges;
        this.interestRateCharts = product.interestRateCharts;
        this.activeChart = product.activeChart;
        this.currencyOptions = product.currencyOptions;
        this.interestCompoundingPeriodTypeOptions = product.interestCompoundingPeriodTypeOptions;
        this.interestPostingPeriodTypeOptions = product.interestPostingPeriodTypeOptions;
        this.interestCalculationTypeOptions = product.interestCalculationTypeOptions;
        this.interestCalculationDaysInYearTypeOptions = product.interestCalculationDaysInYearTypeOptions;
        this.lockinPeriodFrequencyTypeOptions = product.lockinPeriodFrequencyTypeOptions;
        this.withdrawalFeeTypeOptions = product.withdrawalFeeTypeOptions;
        this.paymentTypeOptions = product.paymentTypeOptions;
        this.accountingRuleOptions = product.accountingRuleOptions;
        this.accountingMappingOptions = product.accountingMappingOptions;
        this.chargeOptions = product.chargeOptions;
        this.penaltyOptions = product.penaltyOptions;
        this.chartTemplate = product.chartTemplate;
        this.taxGroupOptions = product.taxGroupOptions;

        this.preClosurePenalApplicable = preClosurePenalApplicable;
        this.preClosurePenalInterest = preClosurePenalInterest;
        this.preClosurePenalInterestOnType = preClosurePenalInterestOnType;
        this.minDepositTerm = minDepositTerm;
        this.maxDepositTerm = maxDepositTerm;
        this.minDepositTermType = minDepositTermType;
        this.maxDepositTermType = maxDepositTermType;
        this.inMultiplesOfDepositTerm = inMultiplesOfDepositTerm;
        this.inMultiplesOfDepositTermType = inMultiplesOfDepositTermType;
        this.minDepositAmount = minDepositAmount;
        this.depositAmount = depositAmount;
        this.maxDepositAmount = maxDepositAmount;
        this.isMandatoryDeposit = isMandatoryDeposit;
        this.allowWithdrawal = allowWithdrawal;
        this.adjustAdvanceTowardsFuturePayments = adjustAdvanceTowardsFuturePayments;
        this.preClosurePenalInterestOnTypeOptions = preClosurePenalInterestOnTypeOptions;
        this.periodFrequencyTypeOptions = periodFrequencyTypeOptions;
    }

    DepositProductData asProductData() {
        return new DepositProductData(id, name, shortName, description, currency, nominalAnnualInterestRate,
                interestCompoundingPeriodType, interestPostingPeriodType, interestCalculationType, interestCalculationDaysInYearType,
                lockinPeriodFrequency, lockinPeriodFrequencyType, accountingRule, accountingMappings, paymentChannelToFundSourceMappings,
                currencyOptions, interestCompoundingPeriodTypeOptions, interestPostingPeriodTypeOptions, interestCalculationTypeOptions,
                interestCalculationDaysInYearTypeOptions, lockinPeriodFrequencyTypeOptions, withdrawalFeeTypeOptions, paymentTypeOptions,
                accountingRuleOptions, accountingMappingOptions, charges, chargeOptions, penaltyOptions, feeToIncomeAccountMappings,
                penaltyToIncomeAccountMappings, interestRateCharts, chartTemplate, minBalanceForInterestCalculation, withHoldTax, taxGroup,
                taxGroupOptions);
    }

    public boolean hasAccountingEnabled() {
        return this.accountingRule != null && this.accountingRule.getId() > AccountingRuleType.NONE.getValue();
    }

    public int accountingRuleTypeId() {
        return this.accountingRule.getId().intValue();
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getShortName() {
        return shortName;
    }

    public CurrencyData getCurrency() {
        return currency;
    }

    public BigDecimal getNominalAnnualInterestRate() {
        return nominalAnnualInterestRate;
    }

    public EnumOptionData getInterestCompoundingPeriodType() {
        return interestCompoundingPeriodType;
    }

    public EnumOptionData getInterestPostingPeriodType() {
        return interestPostingPeriodType;
    }

    public EnumOptionData getInterestCalculationType() {
        return interestCalculationType;
    }

    public EnumOptionData getInterestCalculationDaysInYearType() {
        return interestCalculationDaysInYearType;
    }

    public Integer getLockinPeriodFrequency() {
        return lockinPeriodFrequency;
    }

    public EnumOptionData getLockinPeriodFrequencyType() {
        return lockinPeriodFrequencyType;
    }

    public BigDecimal getMinBalanceForInterestCalculation() {
        return minBalanceForInterestCalculation;
    }

    public EnumOptionData getMinDepositTermType() {
        return minDepositTermType;
    }

    public boolean isPreClosurePenalApplicable() {
        return preClosurePenalApplicable;
    }

    public BigDecimal getPreClosurePenalInterest() {
        return preClosurePenalInterest;
    }

    public EnumOptionData getPreClosurePenalInterestOnType() {
        return preClosurePenalInterestOnType;
    }

    public Integer getMinDepositTerm() {
        return minDepositTerm;
    }

    public Integer getMaxDepositTerm() {
        return maxDepositTerm;
    }

    public EnumOptionData getMaxDepositTermType() {
        return maxDepositTermType;
    }

    public BigDecimal getMinDepositAmount() {
        return minDepositAmount;
    }

    public BigDecimal getDepositAmount() {
        return depositAmount;
    }

    public BigDecimal getMaxDepositAmount() {
        return maxDepositAmount;
    }

    public Integer getInMultiplesOfDepositTerm() {
        return inMultiplesOfDepositTerm;
    }

    public EnumOptionData getInMultiplesOfDepositTermType() {
        return inMultiplesOfDepositTermType;
    }

    public boolean isMandatoryDeposit() {
        return isMandatoryDeposit;
    }

    public boolean isAllowWithdrawal() {
        return allowWithdrawal;
    }

    public boolean isAdjustAdvanceTowardsFuturePayments() {
        return adjustAdvanceTowardsFuturePayments;
    }
}
