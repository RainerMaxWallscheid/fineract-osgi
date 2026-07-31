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
package org.apache.fineract.portfolio.charge.data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.MonthDay;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import org.apache.fineract.accounting.glaccount.data.GLAccountData;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeTimeType;
import org.apache.fineract.portfolio.paymenttype.data.PaymentTypeData;
import org.apache.fineract.portfolio.tax.data.TaxGroupData;

/**
 * Immutable data object for charge data.
 */
public final class ChargeData implements Comparable<ChargeData>, Serializable {
    private final Long id;
    private final String name;
    private final boolean active;
    private final boolean penalty;
    private final boolean freeWithdrawal;
    private final boolean isPaymentType;
    private final Integer freeWithdrawalChargeFrequency;
    private final Integer restartFrequency;
    private final Integer restartFrequencyEnum;
    private final PaymentTypeData paymentTypeOptions;
    private final CurrencyData currency;
    private final BigDecimal amount;
    private final EnumOptionData chargeTimeType;
    private final EnumOptionData chargeAppliesTo;
    private final EnumOptionData chargeCalculationType;
    private final EnumOptionData chargePaymentMode;
    private final MonthDay feeOnMonthDay;
    private final Integer feeInterval;
    private final BigDecimal minCap;
    private final BigDecimal maxCap;
    private final EnumOptionData feeFrequency;
    private final GLAccountData incomeOrLiabilityAccount;
    private final TaxGroupData taxGroup;
    // template attributes
    private final Collection<CurrencyData> currencyOptions;
    private final List<EnumOptionData> chargeCalculationTypeOptions;//
    private final List<EnumOptionData> chargeAppliesToOptions;//
    private final List<EnumOptionData> chargeTimeTypeOptions;//
    private final List<EnumOptionData> chargePaymetModeOptions;//
    private final List<EnumOptionData> loanChargeCalculationTypeOptions;
    private final List<EnumOptionData> loanChargeTimeTypeOptions;
    private final List<EnumOptionData> savingsChargeCalculationTypeOptions;
    private final List<EnumOptionData> savingsChargeTimeTypeOptions;
    private final List<EnumOptionData> clientChargeCalculationTypeOptions;
    private final List<EnumOptionData> clientChargeTimeTypeOptions;
    private final List<EnumOptionData> shareChargeCalculationTypeOptions;
    private final List<EnumOptionData> shareChargeTimeTypeOptions;
    private final List<EnumOptionData> feeFrequencyOptions;
    private final Map<String, List<GLAccountData>> incomeOrLiabilityAccountOptions;
    private final Collection<TaxGroupData> taxGroupOptions;
    private final String accountMappingForChargeConfig;
    private final List<GLAccountData> expenseAccountOptions;
    private final List<GLAccountData> assetAccountOptions;

    public static ChargeData withTemplate(final ChargeData charge, final ChargeData template) {
        return charge.toBuilder().currencyOptions(template.getCurrencyOptions()).chargeCalculationTypeOptions(template.getChargeCalculationTypeOptions()).chargeAppliesToOptions(template.getChargeAppliesToOptions()).chargeTimeTypeOptions(template.getChargeTimeTypeOptions()).chargePaymetModeOptions(template.getChargePaymetModeOptions()).loanChargeCalculationTypeOptions(template.getLoanChargeCalculationTypeOptions()).loanChargeTimeTypeOptions(template.getLoanChargeTimeTypeOptions()).savingsChargeCalculationTypeOptions(template.getSavingsChargeCalculationTypeOptions()).savingsChargeTimeTypeOptions(template.getSavingsChargeTimeTypeOptions()).clientChargeCalculationTypeOptions(template.getClientChargeCalculationTypeOptions()).clientChargeTimeTypeOptions(template.getClientChargeTimeTypeOptions()).feeFrequencyOptions(template.getFeeFrequencyOptions()).incomeOrLiabilityAccountOptions(template.getIncomeOrLiabilityAccountOptions()).taxGroupOptions(template.getTaxGroupOptions()).shareChargeCalculationTypeOptions(template.getShareChargeCalculationTypeOptions()).shareChargeTimeTypeOptions(template.getShareChargeTimeTypeOptions()).accountMappingForChargeConfig(template.getAccountMappingForChargeConfig()).expenseAccountOptions(template.getExpenseAccountOptions()).assetAccountOptions(template.getAssetAccountOptions()).build();
    }

    @Override
    public int compareTo(final ChargeData obj) {
        if (obj == null) {
            return -1;
        }
        return obj.id.compareTo(this.id);
    }

    public boolean isOverdueInstallmentCharge() {
        boolean isOverdueInstallmentCharge = false;
        if (this.chargeTimeType != null) {
            isOverdueInstallmentCharge = ChargeTimeType.fromInt(this.chargeTimeType.getId().intValue()).isOverdueInstallment();
        }
        return isOverdueInstallmentCharge;
    }

    public boolean isIsPaymentType() {
        return this.isPaymentType;
    }

    @java.lang.SuppressWarnings("all")
        private static boolean $default$active() {
        return Boolean.FALSE;
    }

    @java.lang.SuppressWarnings("all")
        private static boolean $default$penalty() {
        return Boolean.FALSE;
    }

    @java.lang.SuppressWarnings("all")
        private static boolean $default$freeWithdrawal() {
        return Boolean.FALSE;
    }

    @java.lang.SuppressWarnings("all")
        private static boolean $default$isPaymentType() {
        return Boolean.FALSE;
    }

    @java.lang.SuppressWarnings("all")
        ChargeData(final Long id, final String name, final boolean active, final boolean penalty, final boolean freeWithdrawal, final boolean isPaymentType, final Integer freeWithdrawalChargeFrequency, final Integer restartFrequency, final Integer restartFrequencyEnum, final PaymentTypeData paymentTypeOptions, final CurrencyData currency, final BigDecimal amount, final EnumOptionData chargeTimeType, final EnumOptionData chargeAppliesTo, final EnumOptionData chargeCalculationType, final EnumOptionData chargePaymentMode, final MonthDay feeOnMonthDay, final Integer feeInterval, final BigDecimal minCap, final BigDecimal maxCap, final EnumOptionData feeFrequency, final GLAccountData incomeOrLiabilityAccount, final TaxGroupData taxGroup, final Collection<CurrencyData> currencyOptions, final List<EnumOptionData> chargeCalculationTypeOptions, final List<EnumOptionData> chargeAppliesToOptions, final List<EnumOptionData> chargeTimeTypeOptions, final List<EnumOptionData> chargePaymetModeOptions, final List<EnumOptionData> loanChargeCalculationTypeOptions, final List<EnumOptionData> loanChargeTimeTypeOptions, final List<EnumOptionData> savingsChargeCalculationTypeOptions, final List<EnumOptionData> savingsChargeTimeTypeOptions, final List<EnumOptionData> clientChargeCalculationTypeOptions, final List<EnumOptionData> clientChargeTimeTypeOptions, final List<EnumOptionData> shareChargeCalculationTypeOptions, final List<EnumOptionData> shareChargeTimeTypeOptions, final List<EnumOptionData> feeFrequencyOptions, final Map<String, List<GLAccountData>> incomeOrLiabilityAccountOptions, final Collection<TaxGroupData> taxGroupOptions, final String accountMappingForChargeConfig, final List<GLAccountData> expenseAccountOptions, final List<GLAccountData> assetAccountOptions) {
        this.id = id;
        this.name = name;
        this.active = active;
        this.penalty = penalty;
        this.freeWithdrawal = freeWithdrawal;
        this.isPaymentType = isPaymentType;
        this.freeWithdrawalChargeFrequency = freeWithdrawalChargeFrequency;
        this.restartFrequency = restartFrequency;
        this.restartFrequencyEnum = restartFrequencyEnum;
        this.paymentTypeOptions = paymentTypeOptions;
        this.currency = currency;
        this.amount = amount;
        this.chargeTimeType = chargeTimeType;
        this.chargeAppliesTo = chargeAppliesTo;
        this.chargeCalculationType = chargeCalculationType;
        this.chargePaymentMode = chargePaymentMode;
        this.feeOnMonthDay = feeOnMonthDay;
        this.feeInterval = feeInterval;
        this.minCap = minCap;
        this.maxCap = maxCap;
        this.feeFrequency = feeFrequency;
        this.incomeOrLiabilityAccount = incomeOrLiabilityAccount;
        this.taxGroup = taxGroup;
        this.currencyOptions = currencyOptions;
        this.chargeCalculationTypeOptions = chargeCalculationTypeOptions;
        this.chargeAppliesToOptions = chargeAppliesToOptions;
        this.chargeTimeTypeOptions = chargeTimeTypeOptions;
        this.chargePaymetModeOptions = chargePaymetModeOptions;
        this.loanChargeCalculationTypeOptions = loanChargeCalculationTypeOptions;
        this.loanChargeTimeTypeOptions = loanChargeTimeTypeOptions;
        this.savingsChargeCalculationTypeOptions = savingsChargeCalculationTypeOptions;
        this.savingsChargeTimeTypeOptions = savingsChargeTimeTypeOptions;
        this.clientChargeCalculationTypeOptions = clientChargeCalculationTypeOptions;
        this.clientChargeTimeTypeOptions = clientChargeTimeTypeOptions;
        this.shareChargeCalculationTypeOptions = shareChargeCalculationTypeOptions;
        this.shareChargeTimeTypeOptions = shareChargeTimeTypeOptions;
        this.feeFrequencyOptions = feeFrequencyOptions;
        this.incomeOrLiabilityAccountOptions = incomeOrLiabilityAccountOptions;
        this.taxGroupOptions = taxGroupOptions;
        this.accountMappingForChargeConfig = accountMappingForChargeConfig;
        this.expenseAccountOptions = expenseAccountOptions;
        this.assetAccountOptions = assetAccountOptions;
    }


    @java.lang.SuppressWarnings("all")
        public static class ChargeDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private boolean active$set;
        @java.lang.SuppressWarnings("all")
                private boolean active$value;
        @java.lang.SuppressWarnings("all")
                private boolean penalty$set;
        @java.lang.SuppressWarnings("all")
                private boolean penalty$value;
        @java.lang.SuppressWarnings("all")
                private boolean freeWithdrawal$set;
        @java.lang.SuppressWarnings("all")
                private boolean freeWithdrawal$value;
        @java.lang.SuppressWarnings("all")
                private boolean isPaymentType$set;
        @java.lang.SuppressWarnings("all")
                private boolean isPaymentType$value;
        @java.lang.SuppressWarnings("all")
                private Integer freeWithdrawalChargeFrequency;
        @java.lang.SuppressWarnings("all")
                private Integer restartFrequency;
        @java.lang.SuppressWarnings("all")
                private Integer restartFrequencyEnum;
        @java.lang.SuppressWarnings("all")
                private PaymentTypeData paymentTypeOptions;
        @java.lang.SuppressWarnings("all")
                private CurrencyData currency;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amount;
        @java.lang.SuppressWarnings("all")
                private EnumOptionData chargeTimeType;
        @java.lang.SuppressWarnings("all")
                private EnumOptionData chargeAppliesTo;
        @java.lang.SuppressWarnings("all")
                private EnumOptionData chargeCalculationType;
        @java.lang.SuppressWarnings("all")
                private EnumOptionData chargePaymentMode;
        @java.lang.SuppressWarnings("all")
                private MonthDay feeOnMonthDay;
        @java.lang.SuppressWarnings("all")
                private Integer feeInterval;
        @java.lang.SuppressWarnings("all")
                private BigDecimal minCap;
        @java.lang.SuppressWarnings("all")
                private BigDecimal maxCap;
        @java.lang.SuppressWarnings("all")
                private EnumOptionData feeFrequency;
        @java.lang.SuppressWarnings("all")
                private GLAccountData incomeOrLiabilityAccount;
        @java.lang.SuppressWarnings("all")
                private TaxGroupData taxGroup;
        @java.lang.SuppressWarnings("all")
                private Collection<CurrencyData> currencyOptions;
        @java.lang.SuppressWarnings("all")
                private List<EnumOptionData> chargeCalculationTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<EnumOptionData> chargeAppliesToOptions;
        @java.lang.SuppressWarnings("all")
                private List<EnumOptionData> chargeTimeTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<EnumOptionData> chargePaymetModeOptions;
        @java.lang.SuppressWarnings("all")
                private List<EnumOptionData> loanChargeCalculationTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<EnumOptionData> loanChargeTimeTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<EnumOptionData> savingsChargeCalculationTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<EnumOptionData> savingsChargeTimeTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<EnumOptionData> clientChargeCalculationTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<EnumOptionData> clientChargeTimeTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<EnumOptionData> shareChargeCalculationTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<EnumOptionData> shareChargeTimeTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<EnumOptionData> feeFrequencyOptions;
        @java.lang.SuppressWarnings("all")
                private Map<String, List<GLAccountData>> incomeOrLiabilityAccountOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<TaxGroupData> taxGroupOptions;
        @java.lang.SuppressWarnings("all")
                private String accountMappingForChargeConfig;
        @java.lang.SuppressWarnings("all")
                private List<GLAccountData> expenseAccountOptions;
        @java.lang.SuppressWarnings("all")
                private List<GLAccountData> assetAccountOptions;

        @java.lang.SuppressWarnings("all")
                ChargeDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder active(final boolean active) {
            this.active$value = active;
            active$set = true;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder penalty(final boolean penalty) {
            this.penalty$value = penalty;
            penalty$set = true;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder freeWithdrawal(final boolean freeWithdrawal) {
            this.freeWithdrawal$value = freeWithdrawal;
            freeWithdrawal$set = true;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder isPaymentType(final boolean isPaymentType) {
            this.isPaymentType$value = isPaymentType;
            isPaymentType$set = true;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder freeWithdrawalChargeFrequency(final Integer freeWithdrawalChargeFrequency) {
            this.freeWithdrawalChargeFrequency = freeWithdrawalChargeFrequency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder restartFrequency(final Integer restartFrequency) {
            this.restartFrequency = restartFrequency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder restartFrequencyEnum(final Integer restartFrequencyEnum) {
            this.restartFrequencyEnum = restartFrequencyEnum;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder paymentTypeOptions(final PaymentTypeData paymentTypeOptions) {
            this.paymentTypeOptions = paymentTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder currency(final CurrencyData currency) {
            this.currency = currency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder amount(final BigDecimal amount) {
            this.amount = amount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder chargeTimeType(final EnumOptionData chargeTimeType) {
            this.chargeTimeType = chargeTimeType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder chargeAppliesTo(final EnumOptionData chargeAppliesTo) {
            this.chargeAppliesTo = chargeAppliesTo;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder chargeCalculationType(final EnumOptionData chargeCalculationType) {
            this.chargeCalculationType = chargeCalculationType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder chargePaymentMode(final EnumOptionData chargePaymentMode) {
            this.chargePaymentMode = chargePaymentMode;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder feeOnMonthDay(final MonthDay feeOnMonthDay) {
            this.feeOnMonthDay = feeOnMonthDay;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder feeInterval(final Integer feeInterval) {
            this.feeInterval = feeInterval;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder minCap(final BigDecimal minCap) {
            this.minCap = minCap;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder maxCap(final BigDecimal maxCap) {
            this.maxCap = maxCap;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder feeFrequency(final EnumOptionData feeFrequency) {
            this.feeFrequency = feeFrequency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder incomeOrLiabilityAccount(final GLAccountData incomeOrLiabilityAccount) {
            this.incomeOrLiabilityAccount = incomeOrLiabilityAccount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder taxGroup(final TaxGroupData taxGroup) {
            this.taxGroup = taxGroup;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder currencyOptions(final Collection<CurrencyData> currencyOptions) {
            this.currencyOptions = currencyOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder chargeCalculationTypeOptions(final List<EnumOptionData> chargeCalculationTypeOptions) {
            this.chargeCalculationTypeOptions = chargeCalculationTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder chargeAppliesToOptions(final List<EnumOptionData> chargeAppliesToOptions) {
            this.chargeAppliesToOptions = chargeAppliesToOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder chargeTimeTypeOptions(final List<EnumOptionData> chargeTimeTypeOptions) {
            this.chargeTimeTypeOptions = chargeTimeTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder chargePaymetModeOptions(final List<EnumOptionData> chargePaymetModeOptions) {
            this.chargePaymetModeOptions = chargePaymetModeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder loanChargeCalculationTypeOptions(final List<EnumOptionData> loanChargeCalculationTypeOptions) {
            this.loanChargeCalculationTypeOptions = loanChargeCalculationTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder loanChargeTimeTypeOptions(final List<EnumOptionData> loanChargeTimeTypeOptions) {
            this.loanChargeTimeTypeOptions = loanChargeTimeTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder savingsChargeCalculationTypeOptions(final List<EnumOptionData> savingsChargeCalculationTypeOptions) {
            this.savingsChargeCalculationTypeOptions = savingsChargeCalculationTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder savingsChargeTimeTypeOptions(final List<EnumOptionData> savingsChargeTimeTypeOptions) {
            this.savingsChargeTimeTypeOptions = savingsChargeTimeTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder clientChargeCalculationTypeOptions(final List<EnumOptionData> clientChargeCalculationTypeOptions) {
            this.clientChargeCalculationTypeOptions = clientChargeCalculationTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder clientChargeTimeTypeOptions(final List<EnumOptionData> clientChargeTimeTypeOptions) {
            this.clientChargeTimeTypeOptions = clientChargeTimeTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder shareChargeCalculationTypeOptions(final List<EnumOptionData> shareChargeCalculationTypeOptions) {
            this.shareChargeCalculationTypeOptions = shareChargeCalculationTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder shareChargeTimeTypeOptions(final List<EnumOptionData> shareChargeTimeTypeOptions) {
            this.shareChargeTimeTypeOptions = shareChargeTimeTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder feeFrequencyOptions(final List<EnumOptionData> feeFrequencyOptions) {
            this.feeFrequencyOptions = feeFrequencyOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder incomeOrLiabilityAccountOptions(final Map<String, List<GLAccountData>> incomeOrLiabilityAccountOptions) {
            this.incomeOrLiabilityAccountOptions = incomeOrLiabilityAccountOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder taxGroupOptions(final Collection<TaxGroupData> taxGroupOptions) {
            this.taxGroupOptions = taxGroupOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder accountMappingForChargeConfig(final String accountMappingForChargeConfig) {
            this.accountMappingForChargeConfig = accountMappingForChargeConfig;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder expenseAccountOptions(final List<GLAccountData> expenseAccountOptions) {
            this.expenseAccountOptions = expenseAccountOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ChargeData.ChargeDataBuilder assetAccountOptions(final List<GLAccountData> assetAccountOptions) {
            this.assetAccountOptions = assetAccountOptions;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ChargeData build() {
            boolean active$value = this.active$value;
            if (!this.active$set) active$value = ChargeData.$default$active();
            boolean penalty$value = this.penalty$value;
            if (!this.penalty$set) penalty$value = ChargeData.$default$penalty();
            boolean freeWithdrawal$value = this.freeWithdrawal$value;
            if (!this.freeWithdrawal$set) freeWithdrawal$value = ChargeData.$default$freeWithdrawal();
            boolean isPaymentType$value = this.isPaymentType$value;
            if (!this.isPaymentType$set) isPaymentType$value = ChargeData.$default$isPaymentType();
            return new ChargeData(this.id, this.name, active$value, penalty$value, freeWithdrawal$value, isPaymentType$value, this.freeWithdrawalChargeFrequency, this.restartFrequency, this.restartFrequencyEnum, this.paymentTypeOptions, this.currency, this.amount, this.chargeTimeType, this.chargeAppliesTo, this.chargeCalculationType, this.chargePaymentMode, this.feeOnMonthDay, this.feeInterval, this.minCap, this.maxCap, this.feeFrequency, this.incomeOrLiabilityAccount, this.taxGroup, this.currencyOptions, this.chargeCalculationTypeOptions, this.chargeAppliesToOptions, this.chargeTimeTypeOptions, this.chargePaymetModeOptions, this.loanChargeCalculationTypeOptions, this.loanChargeTimeTypeOptions, this.savingsChargeCalculationTypeOptions, this.savingsChargeTimeTypeOptions, this.clientChargeCalculationTypeOptions, this.clientChargeTimeTypeOptions, this.shareChargeCalculationTypeOptions, this.shareChargeTimeTypeOptions, this.feeFrequencyOptions, this.incomeOrLiabilityAccountOptions, this.taxGroupOptions, this.accountMappingForChargeConfig, this.expenseAccountOptions, this.assetAccountOptions);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ChargeData.ChargeDataBuilder(id=" + this.id + ", name=" + this.name + ", active$value=" + this.active$value + ", penalty$value=" + this.penalty$value + ", freeWithdrawal$value=" + this.freeWithdrawal$value + ", isPaymentType$value=" + this.isPaymentType$value + ", freeWithdrawalChargeFrequency=" + this.freeWithdrawalChargeFrequency + ", restartFrequency=" + this.restartFrequency + ", restartFrequencyEnum=" + this.restartFrequencyEnum + ", paymentTypeOptions=" + this.paymentTypeOptions + ", currency=" + this.currency + ", amount=" + this.amount + ", chargeTimeType=" + this.chargeTimeType + ", chargeAppliesTo=" + this.chargeAppliesTo + ", chargeCalculationType=" + this.chargeCalculationType + ", chargePaymentMode=" + this.chargePaymentMode + ", feeOnMonthDay=" + this.feeOnMonthDay + ", feeInterval=" + this.feeInterval + ", minCap=" + this.minCap + ", maxCap=" + this.maxCap + ", feeFrequency=" + this.feeFrequency + ", incomeOrLiabilityAccount=" + this.incomeOrLiabilityAccount + ", taxGroup=" + this.taxGroup + ", currencyOptions=" + this.currencyOptions + ", chargeCalculationTypeOptions=" + this.chargeCalculationTypeOptions + ", chargeAppliesToOptions=" + this.chargeAppliesToOptions + ", chargeTimeTypeOptions=" + this.chargeTimeTypeOptions + ", chargePaymetModeOptions=" + this.chargePaymetModeOptions + ", loanChargeCalculationTypeOptions=" + this.loanChargeCalculationTypeOptions + ", loanChargeTimeTypeOptions=" + this.loanChargeTimeTypeOptions + ", savingsChargeCalculationTypeOptions=" + this.savingsChargeCalculationTypeOptions + ", savingsChargeTimeTypeOptions=" + this.savingsChargeTimeTypeOptions + ", clientChargeCalculationTypeOptions=" + this.clientChargeCalculationTypeOptions + ", clientChargeTimeTypeOptions=" + this.clientChargeTimeTypeOptions + ", shareChargeCalculationTypeOptions=" + this.shareChargeCalculationTypeOptions + ", shareChargeTimeTypeOptions=" + this.shareChargeTimeTypeOptions + ", feeFrequencyOptions=" + this.feeFrequencyOptions + ", incomeOrLiabilityAccountOptions=" + this.incomeOrLiabilityAccountOptions + ", taxGroupOptions=" + this.taxGroupOptions + ", accountMappingForChargeConfig=" + this.accountMappingForChargeConfig + ", expenseAccountOptions=" + this.expenseAccountOptions + ", assetAccountOptions=" + this.assetAccountOptions + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ChargeData.ChargeDataBuilder builder() {
        return new ChargeData.ChargeDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public ChargeData.ChargeDataBuilder toBuilder() {
        return new ChargeData.ChargeDataBuilder().id(this.id).name(this.name).active(this.active).penalty(this.penalty).freeWithdrawal(this.freeWithdrawal).isPaymentType(this.isPaymentType).freeWithdrawalChargeFrequency(this.freeWithdrawalChargeFrequency).restartFrequency(this.restartFrequency).restartFrequencyEnum(this.restartFrequencyEnum).paymentTypeOptions(this.paymentTypeOptions).currency(this.currency).amount(this.amount).chargeTimeType(this.chargeTimeType).chargeAppliesTo(this.chargeAppliesTo).chargeCalculationType(this.chargeCalculationType).chargePaymentMode(this.chargePaymentMode).feeOnMonthDay(this.feeOnMonthDay).feeInterval(this.feeInterval).minCap(this.minCap).maxCap(this.maxCap).feeFrequency(this.feeFrequency).incomeOrLiabilityAccount(this.incomeOrLiabilityAccount).taxGroup(this.taxGroup).currencyOptions(this.currencyOptions).chargeCalculationTypeOptions(this.chargeCalculationTypeOptions).chargeAppliesToOptions(this.chargeAppliesToOptions).chargeTimeTypeOptions(this.chargeTimeTypeOptions).chargePaymetModeOptions(this.chargePaymetModeOptions).loanChargeCalculationTypeOptions(this.loanChargeCalculationTypeOptions).loanChargeTimeTypeOptions(this.loanChargeTimeTypeOptions).savingsChargeCalculationTypeOptions(this.savingsChargeCalculationTypeOptions).savingsChargeTimeTypeOptions(this.savingsChargeTimeTypeOptions).clientChargeCalculationTypeOptions(this.clientChargeCalculationTypeOptions).clientChargeTimeTypeOptions(this.clientChargeTimeTypeOptions).shareChargeCalculationTypeOptions(this.shareChargeCalculationTypeOptions).shareChargeTimeTypeOptions(this.shareChargeTimeTypeOptions).feeFrequencyOptions(this.feeFrequencyOptions).incomeOrLiabilityAccountOptions(this.incomeOrLiabilityAccountOptions).taxGroupOptions(this.taxGroupOptions).accountMappingForChargeConfig(this.accountMappingForChargeConfig).expenseAccountOptions(this.expenseAccountOptions).assetAccountOptions(this.assetAccountOptions);
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
        public boolean isActive() {
        return this.active;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isPenalty() {
        return this.penalty;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isFreeWithdrawal() {
        return this.freeWithdrawal;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getFreeWithdrawalChargeFrequency() {
        return this.freeWithdrawalChargeFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRestartFrequency() {
        return this.restartFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRestartFrequencyEnum() {
        return this.restartFrequencyEnum;
    }

    @java.lang.SuppressWarnings("all")
        public PaymentTypeData getPaymentTypeOptions() {
        return this.paymentTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getChargeTimeType() {
        return this.chargeTimeType;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getChargeAppliesTo() {
        return this.chargeAppliesTo;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getChargeCalculationType() {
        return this.chargeCalculationType;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getChargePaymentMode() {
        return this.chargePaymentMode;
    }

    @java.lang.SuppressWarnings("all")
        public MonthDay getFeeOnMonthDay() {
        return this.feeOnMonthDay;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getFeeInterval() {
        return this.feeInterval;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMinCap() {
        return this.minCap;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMaxCap() {
        return this.maxCap;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getFeeFrequency() {
        return this.feeFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public GLAccountData getIncomeOrLiabilityAccount() {
        return this.incomeOrLiabilityAccount;
    }

    @java.lang.SuppressWarnings("all")
        public TaxGroupData getTaxGroup() {
        return this.taxGroup;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CurrencyData> getCurrencyOptions() {
        return this.currencyOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getChargeCalculationTypeOptions() {
        return this.chargeCalculationTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getChargeAppliesToOptions() {
        return this.chargeAppliesToOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getChargeTimeTypeOptions() {
        return this.chargeTimeTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getChargePaymetModeOptions() {
        return this.chargePaymetModeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getLoanChargeCalculationTypeOptions() {
        return this.loanChargeCalculationTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getLoanChargeTimeTypeOptions() {
        return this.loanChargeTimeTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getSavingsChargeCalculationTypeOptions() {
        return this.savingsChargeCalculationTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getSavingsChargeTimeTypeOptions() {
        return this.savingsChargeTimeTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getClientChargeCalculationTypeOptions() {
        return this.clientChargeCalculationTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getClientChargeTimeTypeOptions() {
        return this.clientChargeTimeTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getShareChargeCalculationTypeOptions() {
        return this.shareChargeCalculationTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getShareChargeTimeTypeOptions() {
        return this.shareChargeTimeTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getFeeFrequencyOptions() {
        return this.feeFrequencyOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, List<GLAccountData>> getIncomeOrLiabilityAccountOptions() {
        return this.incomeOrLiabilityAccountOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<TaxGroupData> getTaxGroupOptions() {
        return this.taxGroupOptions;
    }

    @java.lang.SuppressWarnings("all")
        public String getAccountMappingForChargeConfig() {
        return this.accountMappingForChargeConfig;
    }

    @java.lang.SuppressWarnings("all")
        public List<GLAccountData> getExpenseAccountOptions() {
        return this.expenseAccountOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<GLAccountData> getAssetAccountOptions() {
        return this.assetAccountOptions;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ChargeData)) return false;
        final ChargeData other = (ChargeData) o;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        return result;
    }
}
