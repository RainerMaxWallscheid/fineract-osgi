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
import java.time.LocalDate;
import java.util.Collection;
import java.util.HashSet;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.organisation.staff.data.StaffData;
import org.apache.fineract.portfolio.account.data.PortfolioAccountData;
import org.apache.fineract.portfolio.charge.data.ChargeData;
import org.apache.fineract.portfolio.paymenttype.data.PaymentTypeData;
import org.apache.fineract.portfolio.savings.DepositAccountType;
import org.apache.fineract.portfolio.savings.service.SavingsEnumerations;
import org.apache.fineract.portfolio.tax.data.TaxGroupData;

/**
 * Immutable data object representing a Fixed Deposit account.
 * <p>
 * Composes shared {@link DepositAccountData} fields (flattened for Gson/API compatibility)
 * instead of extending that type.
 */
public final class FixedDepositAccountData {

    // Flattened shared account fields (composed from DepositAccountData)
    private final Long id;
    private final String accountNo;
    private final String externalId;
    private final Long groupId;
    private final String groupName;
    private final Long clientId;
    private final String clientName;
    private final Long depositProductId;
    private final String depositProductName;
    private final Long fieldOfficerId;
    private final String fieldOfficerName;
    private final SavingsAccountStatusEnumData status;
    private final SavingsAccountApplicationTimelineData timeline;
    private final CurrencyData currency;
    private final BigDecimal nominalAnnualInterestRate;
    private final EnumOptionData interestCompoundingPeriodType;
    private final EnumOptionData interestPostingPeriodType;
    private final EnumOptionData interestCalculationType;
    private final EnumOptionData interestCalculationDaysInYearType;
    private final BigDecimal minRequiredOpeningBalance;
    private final Integer lockinPeriodFrequency;
    private final EnumOptionData lockinPeriodFrequencyType;
    private final boolean withdrawalFeeForTransfers;
    private final EnumOptionData depositType;
    private final BigDecimal minBalanceForInterestCalculation;
    private final boolean withHoldTax;
    private final TaxGroupData taxGroup;
    private final SavingsAccountSummaryData summary;
    private final Collection<SavingsAccountTransactionData> transactions;
    private final Collection<SavingsAccountChargeData> charges;
    private final DepositAccountInterestRateChartData accountChart;
    private final Collection<DepositProductData> productOptions;
    private final Collection<StaffData> fieldOfficerOptions;
    private final Collection<EnumOptionData> interestCompoundingPeriodTypeOptions;
    private final Collection<EnumOptionData> interestPostingPeriodTypeOptions;
    private final Collection<EnumOptionData> interestCalculationTypeOptions;
    private final Collection<EnumOptionData> interestCalculationDaysInYearTypeOptions;
    private final Collection<EnumOptionData> lockinPeriodFrequencyTypeOptions;
    private final Collection<EnumOptionData> withdrawalFeeTypeOptions;
    private final Collection<ChargeData> chargeOptions;
    private final SavingsAccountChargeData withdrawalFee;
    private final SavingsAccountChargeData annualFee;
    private final DepositAccountInterestRateChartData chartTemplate;
    private final Long productId;

    // Fixed-deposit specific fields
    private final boolean preClosurePenalApplicable;
    private final BigDecimal preClosurePenalInterest;
    private final EnumOptionData preClosurePenalInterestOnType;
    private final Integer minDepositTerm;
    private final Integer maxDepositTerm;
    private final EnumOptionData minDepositTermType;
    private final EnumOptionData maxDepositTermType;
    private final Integer inMultiplesOfDepositTerm;
    private final EnumOptionData inMultiplesOfDepositTermType;
    private final BigDecimal depositAmount;
    private final BigDecimal maturityAmount;
    private final LocalDate maturityDate;
    private final Integer depositPeriod;
    private final EnumOptionData depositPeriodFrequency;
    private BigDecimal activationCharge;
    private final Long transferToSavingsId;
    private final EnumOptionData onAccountClosure;
    private final PortfolioAccountData linkedAccount;
    private final Boolean transferInterestToSavings;
    private final PortfolioAccountData transferToSavingsAccount;
    private final Collection<EnumOptionData> preClosurePenalInterestOnTypeOptions;
    private final Collection<EnumOptionData> periodFrequencyTypeOptions;
    private final Collection<SavingsAccountData> savingsAccounts;
    private final Collection<EnumOptionData> onAccountClosureOptions;
    private final Collection<PaymentTypeData> paymentTypeOptions;
    private final Collection<EnumOptionData> maturityInstructionOptions;

    // import fields
    private transient Integer rowIndex;
    private String dateFormat;
    private String locale;
    private LocalDate submittedOnDate;
    private Long depositPeriodFrequencyId;

    public static FixedDepositAccountData importInstance(Long clientId, Long productId, Long fieldOfficerId, LocalDate submittedOnDate,
            EnumOptionData interestCompoundingPeriodTypeEnum, EnumOptionData interestPostingPeriodTypeEnum,
            EnumOptionData interestCalculationTypeEnum, EnumOptionData interestCalculationDaysInYearTypeEnum, Integer lockinPeriodFrequency,
            EnumOptionData lockinPeriodFrequencyTypeEnum, BigDecimal depositAmount, Integer depositPeriod, Long depositPeriodFrequencyId,
            String externalId, Collection<SavingsAccountChargeData> charges, Integer rowIndex, String locale, String dateFormat) {
        return new FixedDepositAccountData(clientId, productId, fieldOfficerId, submittedOnDate, interestCompoundingPeriodTypeEnum,
                interestPostingPeriodTypeEnum, interestCalculationTypeEnum, interestCalculationDaysInYearTypeEnum, lockinPeriodFrequency,
                lockinPeriodFrequencyTypeEnum, depositAmount, depositPeriod, depositPeriodFrequencyId, externalId, charges, rowIndex,
                locale, dateFormat);
    }

    private FixedDepositAccountData(Long clientId, Long productId, Long fieldofficerId, LocalDate submittedOnDate,
            EnumOptionData interestCompoundingPeriodType, EnumOptionData interestPostingPeriodType,
            EnumOptionData interestCalculationType, EnumOptionData interestCalculationDaysInYearType, Integer lockinPeriodFrequency,
            EnumOptionData lockinPeriodFrequencyType, BigDecimal depositAmount, Integer depositPeriod, Long depositPeriodFrequencyId,
            String externalId, Collection<SavingsAccountChargeData> charges, Integer rowIndex, String locale, String dateFormat) {
        this.id = null;
        this.accountNo = null;
        this.externalId = externalId;
        this.groupId = null;
        this.groupName = null;
        this.clientId = clientId;
        this.clientName = null;
        this.depositProductId = null;
        this.depositProductName = null;
        this.fieldOfficerId = fieldofficerId;
        this.fieldOfficerName = null;
        this.status = null;
        this.timeline = null;
        this.currency = null;
        this.nominalAnnualInterestRate = null;
        this.interestCompoundingPeriodType = interestCompoundingPeriodType;
        this.interestPostingPeriodType = interestPostingPeriodType;
        this.interestCalculationType = interestCalculationType;
        this.interestCalculationDaysInYearType = interestCalculationDaysInYearType;
        this.minRequiredOpeningBalance = null;
        this.lockinPeriodFrequency = lockinPeriodFrequency;
        this.lockinPeriodFrequencyType = lockinPeriodFrequencyType;
        this.withdrawalFeeForTransfers = false;
        this.depositType = null;
        this.minBalanceForInterestCalculation = null;
        this.withHoldTax = false;
        this.taxGroup = null;
        this.summary = null;
        this.transactions = null;
        this.charges = charges;
        this.accountChart = null;
        this.productOptions = null;
        this.fieldOfficerOptions = null;
        this.interestCompoundingPeriodTypeOptions = null;
        this.interestPostingPeriodTypeOptions = null;
        this.interestCalculationTypeOptions = null;
        this.interestCalculationDaysInYearTypeOptions = null;
        this.lockinPeriodFrequencyTypeOptions = null;
        this.withdrawalFeeTypeOptions = null;
        this.chargeOptions = null;
        this.withdrawalFee = null;
        this.annualFee = null;
        this.chartTemplate = null;
        this.productId = productId;

        this.preClosurePenalApplicable = false;
        this.preClosurePenalInterest = null;
        this.preClosurePenalInterestOnType = null;
        this.minDepositTerm = null;
        this.maxDepositTerm = null;
        this.minDepositTermType = null;
        this.maxDepositTermType = null;
        this.inMultiplesOfDepositTerm = null;
        this.inMultiplesOfDepositTermType = null;
        this.depositAmount = depositAmount;
        this.maturityAmount = null;
        this.maturityDate = null;
        this.depositPeriod = depositPeriod;
        this.depositPeriodFrequency = null;
        this.activationCharge = null;
        this.onAccountClosure = null;
        this.linkedAccount = null;
        this.transferToSavingsAccount = null;
        this.transferInterestToSavings = null;
        this.preClosurePenalInterestOnTypeOptions = null;
        this.periodFrequencyTypeOptions = null;
        this.savingsAccounts = null;
        this.onAccountClosureOptions = null;
        this.paymentTypeOptions = null;
        this.maturityInstructionOptions = null;
        this.transferToSavingsId = null;
        this.rowIndex = rowIndex;
        this.dateFormat = dateFormat;
        this.locale = locale;
        this.submittedOnDate = submittedOnDate;
        this.depositPeriodFrequencyId = depositPeriodFrequencyId;
    }

    public static FixedDepositAccountData instance(final DepositAccountData depositAccountData, final boolean preClosurePenalApplicable,
            final BigDecimal preClosurePenalInterest, final EnumOptionData preClosurePenalInterestOnType, final Integer minDepositTerm,
            final Integer maxDepositTerm, final EnumOptionData minDepositTermType, final EnumOptionData maxDepositTermType,
            final Integer inMultiplesOfDepositTerm, final EnumOptionData inMultiplesOfDepositTermType, final BigDecimal depositAmount,
            final BigDecimal maturityAmount, final LocalDate maturityDate, final Integer depositPeriod,
            final EnumOptionData depositPeriodFrequency, final EnumOptionData onAccountClosure, final Boolean transferInterestToSavings,
            final Long transferToSavingsId) {
        return fromAccount(depositAccountData, preClosurePenalApplicable, preClosurePenalInterest, preClosurePenalInterestOnType,
                minDepositTerm, maxDepositTerm, minDepositTermType, maxDepositTermType, inMultiplesOfDepositTerm,
                inMultiplesOfDepositTermType, depositAmount, maturityAmount, maturityDate, depositPeriod, depositPeriodFrequency, null,
                onAccountClosure, null, null, null, null, transferInterestToSavings, null, null, transferToSavingsId, null);
    }

    public static FixedDepositAccountData withInterestChart(final FixedDepositAccountData account,
            final DepositAccountInterestRateChartData accountChart) {
        final DepositAccountData base = account.asAccountDataWith(account.transactions, account.charges, account.productOptions,
                account.fieldOfficerOptions, account.interestCompoundingPeriodTypeOptions, account.interestPostingPeriodTypeOptions,
                account.interestCalculationTypeOptions, account.interestCalculationDaysInYearTypeOptions,
                account.lockinPeriodFrequencyTypeOptions, account.withdrawalFeeTypeOptions, account.chargeOptions, accountChart,
                account.chartTemplate);
        return fromAccount(base, account);
    }

    public static FixedDepositAccountData associationsAndTemplate(final FixedDepositAccountData account, FixedDepositAccountData template,
            final Collection<SavingsAccountTransactionData> transactions, final Collection<SavingsAccountChargeData> charges,
            final PortfolioAccountData linkedAccount, PortfolioAccountData transferToSavingsAccount) {
        if (template == null) {
            template = account;
        }
        final DepositAccountData base = account.asAccountDataWith(transactions, charges, template.productOptions,
                template.fieldOfficerOptions, template.interestCompoundingPeriodTypeOptions, template.interestPostingPeriodTypeOptions,
                template.interestCalculationTypeOptions, template.interestCalculationDaysInYearTypeOptions,
                template.lockinPeriodFrequencyTypeOptions, template.withdrawalFeeTypeOptions, template.chargeOptions, account.accountChart,
                account.chartTemplate);
        return fromAccount(base, account.preClosurePenalApplicable, account.preClosurePenalInterest, account.preClosurePenalInterestOnType,
                account.minDepositTerm, account.maxDepositTerm, account.minDepositTermType, account.maxDepositTermType,
                account.inMultiplesOfDepositTerm, account.inMultiplesOfDepositTermType, account.depositAmount, account.maturityAmount,
                account.maturityDate, account.depositPeriod, account.depositPeriodFrequency, template.preClosurePenalInterestOnTypeOptions,
                account.onAccountClosure, account.onAccountClosureOptions, account.paymentTypeOptions, template.savingsAccounts,
                template.periodFrequencyTypeOptions, account.transferInterestToSavings, linkedAccount,
                account.maturityInstructionOptions, account.transferToSavingsId, transferToSavingsAccount);
    }

    public static FixedDepositAccountData withTemplateOptions(final FixedDepositAccountData account,
            final Collection<DepositProductData> productOptions, final Collection<StaffData> fieldOfficerOptions,
            final Collection<EnumOptionData> interestCompoundingPeriodTypeOptions,
            final Collection<EnumOptionData> interestPostingPeriodTypeOptions,
            final Collection<EnumOptionData> interestCalculationTypeOptions,
            final Collection<EnumOptionData> interestCalculationDaysInYearTypeOptions,
            final Collection<EnumOptionData> lockinPeriodFrequencyTypeOptions, final Collection<EnumOptionData> withdrawalFeeTypeOptions,
            final Collection<SavingsAccountTransactionData> transactions, final Collection<SavingsAccountChargeData> charges,
            final Collection<ChargeData> chargeOptions, final Collection<EnumOptionData> preClosurePenalInterestOnTypeOptions,
            final Collection<EnumOptionData> periodFrequencyTypeOptions, final Collection<SavingsAccountData> savingsAccounts,
            final Collection<EnumOptionData> maturityInstructionOptions) {
        final DepositAccountData base = account.asAccountDataWith(transactions, charges, productOptions, fieldOfficerOptions,
                interestCompoundingPeriodTypeOptions, interestPostingPeriodTypeOptions, interestCalculationTypeOptions,
                interestCalculationDaysInYearTypeOptions, lockinPeriodFrequencyTypeOptions, withdrawalFeeTypeOptions, chargeOptions,
                account.accountChart, account.chartTemplate);
        return fromAccount(base, account.preClosurePenalApplicable, account.preClosurePenalInterest, account.preClosurePenalInterestOnType,
                account.minDepositTerm, account.maxDepositTerm, account.minDepositTermType, account.maxDepositTermType,
                account.inMultiplesOfDepositTerm, account.inMultiplesOfDepositTermType, account.depositAmount, account.maturityAmount,
                account.maturityDate, account.depositPeriod, account.depositPeriodFrequency, preClosurePenalInterestOnTypeOptions,
                account.onAccountClosure, account.onAccountClosureOptions, account.paymentTypeOptions, savingsAccounts,
                periodFrequencyTypeOptions, account.transferInterestToSavings, account.linkedAccount, maturityInstructionOptions,
                account.transferToSavingsId, account.transferToSavingsAccount);
    }

    public static FixedDepositAccountData withClientTemplate(final Long clientId, final String clientName, final Long groupId,
            final String groupName) {
        final EnumOptionData depositType = SavingsEnumerations.depositType(DepositAccountType.FIXED_DEPOSIT.getValue());
        final DepositAccountData base = new DepositAccountData(null, null, null, groupId, groupName, clientId, clientName, null, null, null,
                null, null, null, null, null, null, null, null, null, null, null, null, false, null, null, null, null, null, null, null,
                null, null, null, null, null, null, null, depositType, null, false, null);
        return fromAccount(base, false, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null,
                null, null, null, null, null, null, null);
    }

    public static FixedDepositAccountData preClosureDetails(final Long accountId, BigDecimal maturityAmount,
            final Collection<EnumOptionData> onAccountClosureOptions, final Collection<PaymentTypeData> paymentTypeOptions,
            final Collection<SavingsAccountData> savingsAccountDatas) {
        final EnumOptionData depositType = SavingsEnumerations.depositType(DepositAccountType.FIXED_DEPOSIT.getValue());
        final DepositAccountData base = new DepositAccountData(accountId, null, null, null, null, null, null, null, null, null, null, null,
                null, null, null, null, null, null, null, null, null, null, false, null, null, null, null, null, null, null, null, null,
                null, null, null, null, null, depositType, null, false, null);
        return fromAccount(base, false, null, null, null, null, null, null, null, null, null, maturityAmount, null, null, null, null, null,
                onAccountClosureOptions, paymentTypeOptions, savingsAccountDatas, null, null, null, null, null, null);
    }

    public static FixedDepositAccountData withClosureTemplateDetails(final FixedDepositAccountData account,
            final Collection<EnumOptionData> onAccountClosureOptions, final Collection<PaymentTypeData> paymentTypeOptions,
            final Collection<SavingsAccountData> savingsAccountDatas) {
        return fromAccount(account.asAccountData(), account.preClosurePenalApplicable, account.preClosurePenalInterest,
                account.preClosurePenalInterestOnType, account.minDepositTerm, account.maxDepositTerm, account.minDepositTermType,
                account.maxDepositTermType, account.inMultiplesOfDepositTerm, account.inMultiplesOfDepositTermType, account.depositAmount,
                account.maturityAmount, account.maturityDate, account.depositPeriod, account.depositPeriodFrequency,
                account.preClosurePenalInterestOnTypeOptions, account.onAccountClosure, onAccountClosureOptions, paymentTypeOptions,
                savingsAccountDatas, account.periodFrequencyTypeOptions, account.transferInterestToSavings, account.linkedAccount,
                account.maturityInstructionOptions, account.transferToSavingsId, account.transferToSavingsAccount);
    }

    private static FixedDepositAccountData fromAccount(final DepositAccountData account, final FixedDepositAccountData existing) {
        return fromAccount(account, existing.preClosurePenalApplicable, existing.preClosurePenalInterest,
                existing.preClosurePenalInterestOnType, existing.minDepositTerm, existing.maxDepositTerm, existing.minDepositTermType,
                existing.maxDepositTermType, existing.inMultiplesOfDepositTerm, existing.inMultiplesOfDepositTermType,
                existing.depositAmount, existing.maturityAmount, existing.maturityDate, existing.depositPeriod,
                existing.depositPeriodFrequency, existing.preClosurePenalInterestOnTypeOptions, existing.onAccountClosure,
                existing.onAccountClosureOptions, existing.paymentTypeOptions, existing.savingsAccounts,
                existing.periodFrequencyTypeOptions, existing.transferInterestToSavings, existing.linkedAccount,
                existing.maturityInstructionOptions, existing.transferToSavingsId, existing.transferToSavingsAccount);
    }

    private static FixedDepositAccountData fromAccount(final DepositAccountData account, final boolean preClosurePenalApplicable,
            final BigDecimal preClosurePenalInterest, final EnumOptionData preClosurePenalInterestOnType, final Integer minDepositTerm,
            final Integer maxDepositTerm, final EnumOptionData minDepositTermType, final EnumOptionData maxDepositTermType,
            final Integer inMultiplesOfDepositTerm, final EnumOptionData inMultiplesOfDepositTermType, final BigDecimal depositAmount,
            final BigDecimal maturityAmount, final LocalDate maturityDate, final Integer depositPeriod,
            final EnumOptionData depositPeriodFrequency, final Collection<EnumOptionData> preClosurePenalInterestOnTypeOptions,
            final EnumOptionData onAccountClosure, final Collection<EnumOptionData> onAccountClosureOptions,
            final Collection<PaymentTypeData> paymentTypeOptions, final Collection<SavingsAccountData> savingsAccounts,
            final Collection<EnumOptionData> periodFrequencyTypeOptions, final Boolean transferInterestToSavings,
            final PortfolioAccountData linkedAccount, final Collection<EnumOptionData> maturityInstructionOptions,
            final Long transferToSavingsId, final PortfolioAccountData transferToSavingsAccount) {
        return new FixedDepositAccountData(account, preClosurePenalApplicable, preClosurePenalInterest, preClosurePenalInterestOnType,
                minDepositTerm, maxDepositTerm, minDepositTermType, maxDepositTermType, inMultiplesOfDepositTerm,
                inMultiplesOfDepositTermType, depositAmount, maturityAmount, maturityDate, depositPeriod, depositPeriodFrequency,
                preClosurePenalInterestOnTypeOptions, onAccountClosure, onAccountClosureOptions, paymentTypeOptions, savingsAccounts,
                periodFrequencyTypeOptions, transferInterestToSavings, linkedAccount, maturityInstructionOptions, transferToSavingsId,
                transferToSavingsAccount);
    }

    private FixedDepositAccountData(final DepositAccountData account, final boolean preClosurePenalApplicable,
            final BigDecimal preClosurePenalInterest, final EnumOptionData preClosurePenalInterestOnType, final Integer minDepositTerm,
            final Integer maxDepositTerm, final EnumOptionData minDepositTermType, final EnumOptionData maxDepositTermType,
            final Integer inMultiplesOfDepositTerm, final EnumOptionData inMultiplesOfDepositTermType, final BigDecimal depositAmount,
            final BigDecimal maturityAmount, final LocalDate maturityDate, final Integer depositPeriod,
            final EnumOptionData depositPeriodFrequency, final Collection<EnumOptionData> preClosurePenalInterestOnTypeOptions,
            final EnumOptionData onAccountClosure, final Collection<EnumOptionData> onAccountClosureOptions,
            final Collection<PaymentTypeData> paymentTypeOptions, final Collection<SavingsAccountData> savingsAccounts,
            final Collection<EnumOptionData> periodFrequencyTypeOptions, final Boolean transferInterestToSavings,
            final PortfolioAccountData linkedAccount, final Collection<EnumOptionData> maturityInstructionOptions,
            final Long transferToSavingsId, final PortfolioAccountData transferToSavingsAccount) {
        // Flatten composed account for API/Gson compatibility
        this.id = account.id;
        this.accountNo = account.accountNo;
        this.externalId = account.externalId;
        this.groupId = account.groupId;
        this.groupName = account.groupName;
        this.clientId = account.clientId;
        this.clientName = account.clientName;
        this.depositProductId = account.depositProductId;
        this.depositProductName = account.depositProductName;
        this.fieldOfficerId = account.fieldOfficerId;
        this.fieldOfficerName = account.fieldOfficerName;
        this.status = account.status;
        this.timeline = account.timeline;
        this.currency = account.currency;
        this.nominalAnnualInterestRate = account.nominalAnnualInterestRate;
        this.interestCompoundingPeriodType = account.interestCompoundingPeriodType;
        this.interestPostingPeriodType = account.interestPostingPeriodType;
        this.interestCalculationType = account.interestCalculationType;
        this.interestCalculationDaysInYearType = account.interestCalculationDaysInYearType;
        this.minRequiredOpeningBalance = account.minRequiredOpeningBalance;
        this.lockinPeriodFrequency = account.lockinPeriodFrequency;
        this.lockinPeriodFrequencyType = account.lockinPeriodFrequencyType;
        this.withdrawalFeeForTransfers = account.withdrawalFeeForTransfers;
        this.depositType = account.depositType;
        this.minBalanceForInterestCalculation = account.minBalanceForInterestCalculation;
        this.withHoldTax = account.withHoldTax;
        this.taxGroup = account.taxGroup;
        this.summary = account.summary;
        this.transactions = account.transactions;
        this.charges = account.charges;
        this.accountChart = account.accountChart;
        this.productOptions = account.productOptions;
        this.fieldOfficerOptions = account.fieldOfficerOptions;
        this.interestCompoundingPeriodTypeOptions = account.interestCompoundingPeriodTypeOptions;
        this.interestPostingPeriodTypeOptions = account.interestPostingPeriodTypeOptions;
        this.interestCalculationTypeOptions = account.interestCalculationTypeOptions;
        this.interestCalculationDaysInYearTypeOptions = account.interestCalculationDaysInYearTypeOptions;
        this.lockinPeriodFrequencyTypeOptions = account.lockinPeriodFrequencyTypeOptions;
        this.withdrawalFeeTypeOptions = account.withdrawalFeeTypeOptions;
        this.chargeOptions = account.chargeOptions;
        this.withdrawalFee = account.withdrawalFee;
        this.annualFee = account.annualFee;
        this.chartTemplate = account.chartTemplate;
        this.productId = account.getProductId();

        this.preClosurePenalApplicable = preClosurePenalApplicable;
        this.preClosurePenalInterest = preClosurePenalInterest;
        this.preClosurePenalInterestOnType = preClosurePenalInterestOnType;
        this.minDepositTerm = minDepositTerm;
        this.maxDepositTerm = maxDepositTerm;
        this.minDepositTermType = minDepositTermType;
        this.maxDepositTermType = maxDepositTermType;
        this.inMultiplesOfDepositTerm = inMultiplesOfDepositTerm;
        this.inMultiplesOfDepositTermType = inMultiplesOfDepositTermType;
        this.depositAmount = depositAmount;
        this.maturityAmount = maturityAmount;
        this.maturityDate = maturityDate;
        this.depositPeriod = depositPeriod;
        this.depositPeriodFrequency = depositPeriodFrequency;
        this.onAccountClosure = onAccountClosure;
        this.linkedAccount = linkedAccount;
        this.transferToSavingsAccount = transferToSavingsAccount;
        this.transferInterestToSavings = transferInterestToSavings;
        this.preClosurePenalInterestOnTypeOptions = preClosurePenalInterestOnTypeOptions;
        this.periodFrequencyTypeOptions = periodFrequencyTypeOptions;
        this.onAccountClosureOptions = onAccountClosureOptions;
        this.paymentTypeOptions = paymentTypeOptions;
        this.savingsAccounts = savingsAccounts;
        this.maturityInstructionOptions = maturityInstructionOptions;
        this.transferToSavingsId = transferToSavingsId;
        this.activationCharge = null;
    }

    /** Rebuild shared account view for factory composition helpers. */
    DepositAccountData asAccountData() {
        return asAccountDataWith(transactions, charges, productOptions, fieldOfficerOptions, interestCompoundingPeriodTypeOptions,
                interestPostingPeriodTypeOptions, interestCalculationTypeOptions, interestCalculationDaysInYearTypeOptions,
                lockinPeriodFrequencyTypeOptions, withdrawalFeeTypeOptions, chargeOptions, accountChart, chartTemplate);
    }

    private DepositAccountData asAccountDataWith(final Collection<SavingsAccountTransactionData> transactions,
            final Collection<SavingsAccountChargeData> charges, final Collection<DepositProductData> productOptions,
            final Collection<StaffData> fieldOfficerOptions, final Collection<EnumOptionData> interestCompoundingPeriodTypeOptions,
            final Collection<EnumOptionData> interestPostingPeriodTypeOptions,
            final Collection<EnumOptionData> interestCalculationTypeOptions,
            final Collection<EnumOptionData> interestCalculationDaysInYearTypeOptions,
            final Collection<EnumOptionData> lockinPeriodFrequencyTypeOptions, final Collection<EnumOptionData> withdrawalFeeTypeOptions,
            final Collection<ChargeData> chargeOptions, final DepositAccountInterestRateChartData accountChart,
            final DepositAccountInterestRateChartData chartTemplate) {
        return new DepositAccountData(id, accountNo, externalId, groupId, groupName, clientId, clientName, depositProductId,
                depositProductName, fieldOfficerId, fieldOfficerName, status, timeline, currency, nominalAnnualInterestRate,
                interestCompoundingPeriodType, interestPostingPeriodType, interestCalculationType, interestCalculationDaysInYearType,
                minRequiredOpeningBalance, lockinPeriodFrequency, lockinPeriodFrequencyType, withdrawalFeeForTransfers, summary,
                transactions, productOptions, fieldOfficerOptions, interestCompoundingPeriodTypeOptions, interestPostingPeriodTypeOptions,
                interestCalculationTypeOptions, interestCalculationDaysInYearTypeOptions, lockinPeriodFrequencyTypeOptions,
                withdrawalFeeTypeOptions, charges, chargeOptions, accountChart, chartTemplate, depositType, minBalanceForInterestCalculation,
                withHoldTax, taxGroup);
    }

    @Override
    public boolean equals(final Object obj) {
        if (obj == null) {
            return false;
        }
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof FixedDepositAccountData)) {
            return false;
        }
        final FixedDepositAccountData rhs = (FixedDepositAccountData) obj;
        return new EqualsBuilder().append(this.id, rhs.id).append(this.accountNo, rhs.accountNo).isEquals();
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 37).append(this.id).append(this.accountNo).toHashCode();
    }

    public void setActivationCharge(BigDecimal activationCharge) {
        this.activationCharge = activationCharge;
    }

    public Collection<SavingsAccountChargeData> charges() {
        return (this.charges == null) ? new HashSet<>() : this.charges;
    }

    public Long getId() {
        return this.id;
    }

    public String getAccountNo() {
        return this.accountNo;
    }

    public String getExternalId() {
        return this.externalId;
    }

    public Long getGroupId() {
        return this.groupId;
    }

    public String getGroupName() {
        return this.groupName;
    }

    public Long getClientId() {
        return this.clientId;
    }

    public String getClientName() {
        return this.clientName;
    }

    public Long getDepositProductId() {
        return this.depositProductId;
    }

    public String getDepositProductName() {
        return this.depositProductName;
    }

    public Long getFieldOfficerId() {
        return this.fieldOfficerId;
    }

    public String getFieldOfficerName() {
        return this.fieldOfficerName;
    }

    public SavingsAccountStatusEnumData getStatus() {
        return this.status;
    }

    public SavingsAccountApplicationTimelineData getTimeline() {
        return this.timeline;
    }

    public CurrencyData getCurrency() {
        return this.currency;
    }

    public BigDecimal getNominalAnnualInterestRate() {
        return this.nominalAnnualInterestRate;
    }

    public EnumOptionData getInterestCompoundingPeriodType() {
        return this.interestCompoundingPeriodType;
    }

    public EnumOptionData getInterestPostingPeriodType() {
        return this.interestPostingPeriodType;
    }

    public EnumOptionData getInterestCalculationType() {
        return this.interestCalculationType;
    }

    public EnumOptionData getInterestCalculationDaysInYearType() {
        return this.interestCalculationDaysInYearType;
    }

    public BigDecimal getMinRequiredOpeningBalance() {
        return this.minRequiredOpeningBalance;
    }

    public Integer getLockinPeriodFrequency() {
        return this.lockinPeriodFrequency;
    }

    public EnumOptionData getLockinPeriodFrequencyType() {
        return this.lockinPeriodFrequencyType;
    }

    public boolean isWithdrawalFeeForTransfers() {
        return this.withdrawalFeeForTransfers;
    }

    public EnumOptionData getDepositType() {
        return this.depositType;
    }

    public BigDecimal getMinBalanceForInterestCalculation() {
        return this.minBalanceForInterestCalculation;
    }

    public boolean isWithHoldTax() {
        return this.withHoldTax;
    }

    public TaxGroupData getTaxGroup() {
        return this.taxGroup;
    }

    public SavingsAccountSummaryData getSummary() {
        return this.summary;
    }

    public Collection<SavingsAccountTransactionData> getTransactions() {
        return this.transactions;
    }

    public Collection<SavingsAccountChargeData> getCharges() {
        return this.charges;
    }

    public DepositAccountInterestRateChartData getAccountChart() {
        return this.accountChart;
    }

    public Collection<DepositProductData> getProductOptions() {
        return this.productOptions;
    }

    public Collection<StaffData> getFieldOfficerOptions() {
        return this.fieldOfficerOptions;
    }

    public Collection<EnumOptionData> getInterestCompoundingPeriodTypeOptions() {
        return this.interestCompoundingPeriodTypeOptions;
    }

    public Collection<EnumOptionData> getInterestPostingPeriodTypeOptions() {
        return this.interestPostingPeriodTypeOptions;
    }

    public Collection<EnumOptionData> getInterestCalculationTypeOptions() {
        return this.interestCalculationTypeOptions;
    }

    public Collection<EnumOptionData> getInterestCalculationDaysInYearTypeOptions() {
        return this.interestCalculationDaysInYearTypeOptions;
    }

    public Collection<EnumOptionData> getLockinPeriodFrequencyTypeOptions() {
        return this.lockinPeriodFrequencyTypeOptions;
    }

    public Collection<EnumOptionData> getWithdrawalFeeTypeOptions() {
        return this.withdrawalFeeTypeOptions;
    }

    public Collection<ChargeData> getChargeOptions() {
        return this.chargeOptions;
    }

    public DepositAccountInterestRateChartData getChartTemplate() {
        return this.chartTemplate;
    }

    public Long getProductId() {
        return this.productId;
    }

    public boolean isPreClosurePenalApplicable() {
        return this.preClosurePenalApplicable;
    }

    public BigDecimal getPreClosurePenalInterest() {
        return this.preClosurePenalInterest;
    }

    public EnumOptionData getPreClosurePenalInterestOnType() {
        return this.preClosurePenalInterestOnType;
    }

    public Integer getMinDepositTerm() {
        return this.minDepositTerm;
    }

    public Integer getMaxDepositTerm() {
        return this.maxDepositTerm;
    }

    public EnumOptionData getMinDepositTermType() {
        return this.minDepositTermType;
    }

    public EnumOptionData getMaxDepositTermType() {
        return this.maxDepositTermType;
    }

    public Integer getInMultiplesOfDepositTerm() {
        return this.inMultiplesOfDepositTerm;
    }

    public EnumOptionData getInMultiplesOfDepositTermType() {
        return this.inMultiplesOfDepositTermType;
    }

    public BigDecimal getDepositAmount() {
        return this.depositAmount;
    }

    public BigDecimal getMaturityAmount() {
        return this.maturityAmount;
    }

    public LocalDate getMaturityDate() {
        return this.maturityDate;
    }

    public Integer getDepositPeriod() {
        return this.depositPeriod;
    }

    public EnumOptionData getDepositPeriodFrequency() {
        return this.depositPeriodFrequency;
    }

    public BigDecimal getActivationCharge() {
        return this.activationCharge;
    }

    public Long getTransferToSavingsId() {
        return this.transferToSavingsId;
    }

    public EnumOptionData getOnAccountClosure() {
        return this.onAccountClosure;
    }

    public PortfolioAccountData getLinkedAccount() {
        return this.linkedAccount;
    }

    public Boolean getTransferInterestToSavings() {
        return this.transferInterestToSavings;
    }

    public PortfolioAccountData getTransferToSavingsAccount() {
        return this.transferToSavingsAccount;
    }

    public Collection<EnumOptionData> getPreClosurePenalInterestOnTypeOptions() {
        return this.preClosurePenalInterestOnTypeOptions;
    }

    public Collection<EnumOptionData> getPeriodFrequencyTypeOptions() {
        return this.periodFrequencyTypeOptions;
    }

    public Collection<SavingsAccountData> getSavingsAccounts() {
        return this.savingsAccounts;
    }

    public Collection<EnumOptionData> getOnAccountClosureOptions() {
        return this.onAccountClosureOptions;
    }

    public Collection<PaymentTypeData> getPaymentTypeOptions() {
        return this.paymentTypeOptions;
    }

    public Collection<EnumOptionData> getMaturityInstructionOptions() {
        return this.maturityInstructionOptions;
    }

    public Integer getRowIndex() {
        return this.rowIndex;
    }

    public String getDateFormat() {
        return this.dateFormat;
    }

    public String getLocale() {
        return this.locale;
    }

    public LocalDate getSubmittedOnDate() {
        return this.submittedOnDate;
    }

    public Long getDepositPeriodFrequencyId() {
        return this.depositPeriodFrequencyId;
    }
}
