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
package org.apache.fineract.portfolio.loanaccount.data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Collection;
import java.util.List;
import org.apache.fineract.infrastructure.codes.data.CodeValueData;
import org.apache.fineract.infrastructure.core.data.StringEnumOptionData;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.portfolio.account.data.AccountTransferData;
import org.apache.fineract.portfolio.common.domain.PeriodFrequencyType;
import org.apache.fineract.portfolio.paymentdetail.data.PaymentDetailData;
import org.apache.fineract.portfolio.paymenttype.data.PaymentTypeData;

/**
 * Immutable data object representing a loan transaction.
 */
public class LoanTransactionData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private final Long id;
    private final Long loanId;
    private final ExternalId externalLoanId;
    private final Long officeId;
    private final String officeName;
    private final LoanTransactionEnumData type;
    private final LocalDate date;
    private final CurrencyData currency;
    private final PaymentDetailData paymentDetailData;
    private final BigDecimal amount;
    private final BigDecimal netDisbursalAmount;
    private final BigDecimal principalPortion;
    private final BigDecimal interestPortion;
    private final BigDecimal feeChargesPortion;
    private final BigDecimal penaltyChargesPortion;
    private final BigDecimal overpaymentPortion;
    private final BigDecimal unrecognizedIncomePortion;
    private final ExternalId externalId;
    private final AccountTransferData transfer;
    private final BigDecimal fixedEmiAmount;
    private final BigDecimal outstandingLoanBalance;
    private final LocalDate submittedOnDate;
    private final boolean manuallyReversed;
    private final LocalDate possibleNextRepaymentDate;
    private final BigDecimal availableDisbursementAmountWithOverApplied;
    private Collection<LoanChargePaidByData> loanChargePaidByList;
    // templates
    final Collection<PaymentTypeData> paymentTypeOptions;
    private Collection<CodeValueData> writeOffReasonOptions;
    private Integer numberOfRepayments;
    // import fields
    private transient Integer rowIndex;
    private String dateFormat;
    private String locale;
    private BigDecimal transactionAmount;
    private LocalDate transactionDate;
    private Long paymentTypeId;
    private String accountNumber;
    private Integer checkNumber;
    private Integer routingCode;
    private Integer receiptNumber;
    private Integer bankNumber;
    private transient Long accountId;
    private transient String transactionType;
    private List<LoanRepaymentScheduleInstallmentData> loanRepaymentScheduleInstallments;
    // Reverse Data
    private final ExternalId reversalExternalId;
    private LocalDate reversedOnDate;
    private List<LoanTransactionRelationData> transactionRelations;
    private Collection<CodeValueData> chargeOffReasonOptions;
    private Collection<CodeValueData> classificationOptions;
    private CodeValueData classification;
    private Collection<CodeValueData> reAgeReasonOptions;
    private Collection<PeriodFrequencyType> periodFrequencyOptions;
    private Collection<StringEnumOptionData> reAgeInterestHandlingOptions;
    private Collection<CodeValueData> reAmortizationReasonOptions;
    private Collection<StringEnumOptionData> reAmortizationInterestHandlingOptions;
    private Integer numberOfFutureInstallments;
    private Integer numberOfPastInstallments;
    private LocalDate nextInstallmentDueDate;
    private LocalDate calculatedStartDate;

    public static LoanTransactionData importInstance(BigDecimal repaymentAmount, LocalDate lastRepaymentDate, Long repaymentTypeId, Integer rowIndex, String locale, String dateFormat) {
        return LoanTransactionData.builder().transactionAmount(repaymentAmount).transactionDate(lastRepaymentDate).paymentTypeId(repaymentTypeId).rowIndex(rowIndex).locale(locale).dateFormat(dateFormat).externalLoanId(ExternalId.empty()).externalId(ExternalId.empty()).reversalExternalId(ExternalId.empty()).manuallyReversed(false).build();
    }

    public static LoanTransactionData importInstance(BigDecimal repaymentAmount, LocalDate repaymentDate, Long repaymentTypeId, String accountNumber, Integer checkNumber, Integer routingCode, Integer receiptNumber, Integer bankNumber, Long loanAccountId, String transactionType, Integer rowIndex, String locale, String dateFormat) {
        return LoanTransactionData.builder().transactionAmount(repaymentAmount).transactionDate(repaymentDate).paymentTypeId(repaymentTypeId).accountNumber(accountNumber).checkNumber(checkNumber).routingCode(routingCode).receiptNumber(receiptNumber).bankNumber(bankNumber).accountId(loanAccountId).transactionType(transactionType).rowIndex(rowIndex).locale(locale).dateFormat(dateFormat).externalLoanId(ExternalId.empty()).externalId(ExternalId.empty()).reversalExternalId(ExternalId.empty()).manuallyReversed(false).build();
    }

    public static LoanTransactionData templateOnTop(final LoanTransactionData loanTransactionData, final Collection<PaymentTypeData> paymentTypeOptions) {
        return builder().id(loanTransactionData.id).officeId(loanTransactionData.officeId).officeName(loanTransactionData.officeName).type(loanTransactionData.type).paymentDetailData(loanTransactionData.paymentDetailData).currency(loanTransactionData.currency).date(loanTransactionData.date).amount(loanTransactionData.amount).netDisbursalAmount(loanTransactionData.netDisbursalAmount).principalPortion(loanTransactionData.principalPortion).interestPortion(loanTransactionData.interestPortion).feeChargesPortion(loanTransactionData.feeChargesPortion).penaltyChargesPortion(loanTransactionData.penaltyChargesPortion).overpaymentPortion(loanTransactionData.overpaymentPortion).unrecognizedIncomePortion(loanTransactionData.unrecognizedIncomePortion).paymentTypeOptions(paymentTypeOptions).externalId(loanTransactionData.externalId).transfer(loanTransactionData.transfer).fixedEmiAmount(loanTransactionData.fixedEmiAmount).outstandingLoanBalance(loanTransactionData.outstandingLoanBalance).manuallyReversed(loanTransactionData.manuallyReversed).loanId(loanTransactionData.loanId).externalLoanId(loanTransactionData.externalLoanId).build();
    }

    public static LoanTransactionData templateOnTop(final LoanTransactionData loanTransactionData, final LoanTransactionEnumData typeOf) {
        return builder().id(loanTransactionData.id).officeId(loanTransactionData.officeId).officeName(loanTransactionData.officeName).type(typeOf).paymentDetailData(loanTransactionData.paymentDetailData).currency(loanTransactionData.currency).date(loanTransactionData.date).amount(loanTransactionData.amount).netDisbursalAmount(loanTransactionData.netDisbursalAmount).principalPortion(loanTransactionData.principalPortion).interestPortion(loanTransactionData.interestPortion).feeChargesPortion(loanTransactionData.feeChargesPortion).penaltyChargesPortion(loanTransactionData.penaltyChargesPortion).overpaymentPortion(loanTransactionData.overpaymentPortion).unrecognizedIncomePortion(loanTransactionData.unrecognizedIncomePortion).paymentTypeOptions(loanTransactionData.paymentTypeOptions).externalId(loanTransactionData.externalId).transfer(loanTransactionData.transfer).fixedEmiAmount(loanTransactionData.fixedEmiAmount).outstandingLoanBalance(loanTransactionData.outstandingLoanBalance).manuallyReversed(loanTransactionData.manuallyReversed).loanId(loanTransactionData.loanId).externalLoanId(loanTransactionData.externalLoanId).build();
    }

    public static LoanTransactionData loanTransactionDataForCreditTemplate(final LoanTransactionEnumData transactionType, final LocalDate transactionDate, final BigDecimal transactionAmount, final Collection<PaymentTypeData> paymentOptions, final CurrencyData currency, List<CodeValueData> classificationOptions) {
        return builder().type(transactionType).date(transactionDate).amount(transactionAmount).paymentTypeOptions(paymentOptions).currency(currency).externalLoanId(ExternalId.empty()).externalId(ExternalId.empty()).reversalExternalId(ExternalId.empty()).manuallyReversed(false).classificationOptions(classificationOptions).build();
    }

    public static LoanTransactionData loanTransactionDataForDisbursalTemplate(final LoanTransactionEnumData transactionType, final LocalDate expectedDisbursedOnLocalDateForTemplate, final BigDecimal disburseAmountForTemplate, final BigDecimal netDisbursalAmount, final Collection<PaymentTypeData> paymentOptions, final BigDecimal fixedEmiAmount, final LocalDate possibleNextRepaymentDate, final CurrencyData currency, final BigDecimal availableDisbursementAmountWithOverApplied) {
        return builder().type(transactionType).date(expectedDisbursedOnLocalDateForTemplate).amount(disburseAmountForTemplate).netDisbursalAmount(netDisbursalAmount).paymentTypeOptions(paymentOptions).fixedEmiAmount(fixedEmiAmount).possibleNextRepaymentDate(possibleNextRepaymentDate).currency(currency).availableDisbursementAmountWithOverApplied(availableDisbursementAmountWithOverApplied).externalLoanId(ExternalId.empty()).externalId(ExternalId.empty()).reversalExternalId(ExternalId.empty()).manuallyReversed(false).build();
    }


    @java.lang.SuppressWarnings("all")
        public static class Builder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private Long loanId;
        @java.lang.SuppressWarnings("all")
                private ExternalId externalLoanId;
        @java.lang.SuppressWarnings("all")
                private Long officeId;
        @java.lang.SuppressWarnings("all")
                private String officeName;
        @java.lang.SuppressWarnings("all")
                private LoanTransactionEnumData type;
        @java.lang.SuppressWarnings("all")
                private LocalDate date;
        @java.lang.SuppressWarnings("all")
                private CurrencyData currency;
        @java.lang.SuppressWarnings("all")
                private PaymentDetailData paymentDetailData;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal netDisbursalAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalPortion;
        @java.lang.SuppressWarnings("all")
                private BigDecimal interestPortion;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feeChargesPortion;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penaltyChargesPortion;
        @java.lang.SuppressWarnings("all")
                private BigDecimal overpaymentPortion;
        @java.lang.SuppressWarnings("all")
                private BigDecimal unrecognizedIncomePortion;
        @java.lang.SuppressWarnings("all")
                private ExternalId externalId;
        @java.lang.SuppressWarnings("all")
                private AccountTransferData transfer;
        @java.lang.SuppressWarnings("all")
                private BigDecimal fixedEmiAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal outstandingLoanBalance;
        @java.lang.SuppressWarnings("all")
                private LocalDate submittedOnDate;
        @java.lang.SuppressWarnings("all")
                private boolean manuallyReversed;
        @java.lang.SuppressWarnings("all")
                private LocalDate possibleNextRepaymentDate;
        @java.lang.SuppressWarnings("all")
                private BigDecimal availableDisbursementAmountWithOverApplied;
        @java.lang.SuppressWarnings("all")
                private Collection<LoanChargePaidByData> loanChargePaidByList;
        @java.lang.SuppressWarnings("all")
                private Collection<PaymentTypeData> paymentTypeOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<CodeValueData> writeOffReasonOptions;
        @java.lang.SuppressWarnings("all")
                private Integer numberOfRepayments;
        @java.lang.SuppressWarnings("all")
                private Integer rowIndex;
        @java.lang.SuppressWarnings("all")
                private String dateFormat;
        @java.lang.SuppressWarnings("all")
                private String locale;
        @java.lang.SuppressWarnings("all")
                private BigDecimal transactionAmount;
        @java.lang.SuppressWarnings("all")
                private LocalDate transactionDate;
        @java.lang.SuppressWarnings("all")
                private Long paymentTypeId;
        @java.lang.SuppressWarnings("all")
                private String accountNumber;
        @java.lang.SuppressWarnings("all")
                private Integer checkNumber;
        @java.lang.SuppressWarnings("all")
                private Integer routingCode;
        @java.lang.SuppressWarnings("all")
                private Integer receiptNumber;
        @java.lang.SuppressWarnings("all")
                private Integer bankNumber;
        @java.lang.SuppressWarnings("all")
                private Long accountId;
        @java.lang.SuppressWarnings("all")
                private String transactionType;
        @java.lang.SuppressWarnings("all")
                private List<LoanRepaymentScheduleInstallmentData> loanRepaymentScheduleInstallments;
        @java.lang.SuppressWarnings("all")
                private ExternalId reversalExternalId;
        @java.lang.SuppressWarnings("all")
                private LocalDate reversedOnDate;
        @java.lang.SuppressWarnings("all")
                private List<LoanTransactionRelationData> transactionRelations;
        @java.lang.SuppressWarnings("all")
                private Collection<CodeValueData> chargeOffReasonOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<CodeValueData> classificationOptions;
        @java.lang.SuppressWarnings("all")
                private CodeValueData classification;
        @java.lang.SuppressWarnings("all")
                private Collection<CodeValueData> reAgeReasonOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<PeriodFrequencyType> periodFrequencyOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<StringEnumOptionData> reAgeInterestHandlingOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<CodeValueData> reAmortizationReasonOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<StringEnumOptionData> reAmortizationInterestHandlingOptions;
        @java.lang.SuppressWarnings("all")
                private Integer numberOfFutureInstallments;
        @java.lang.SuppressWarnings("all")
                private Integer numberOfPastInstallments;
        @java.lang.SuppressWarnings("all")
                private LocalDate nextInstallmentDueDate;
        @java.lang.SuppressWarnings("all")
                private LocalDate calculatedStartDate;

        @java.lang.SuppressWarnings("all")
                Builder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder loanId(final Long loanId) {
            this.loanId = loanId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder externalLoanId(final ExternalId externalLoanId) {
            this.externalLoanId = externalLoanId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder officeId(final Long officeId) {
            this.officeId = officeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder officeName(final String officeName) {
            this.officeName = officeName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder type(final LoanTransactionEnumData type) {
            this.type = type;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder date(final LocalDate date) {
            this.date = date;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder currency(final CurrencyData currency) {
            this.currency = currency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder paymentDetailData(final PaymentDetailData paymentDetailData) {
            this.paymentDetailData = paymentDetailData;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder amount(final BigDecimal amount) {
            this.amount = amount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder netDisbursalAmount(final BigDecimal netDisbursalAmount) {
            this.netDisbursalAmount = netDisbursalAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder principalPortion(final BigDecimal principalPortion) {
            this.principalPortion = principalPortion;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder interestPortion(final BigDecimal interestPortion) {
            this.interestPortion = interestPortion;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder feeChargesPortion(final BigDecimal feeChargesPortion) {
            this.feeChargesPortion = feeChargesPortion;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder penaltyChargesPortion(final BigDecimal penaltyChargesPortion) {
            this.penaltyChargesPortion = penaltyChargesPortion;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder overpaymentPortion(final BigDecimal overpaymentPortion) {
            this.overpaymentPortion = overpaymentPortion;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder unrecognizedIncomePortion(final BigDecimal unrecognizedIncomePortion) {
            this.unrecognizedIncomePortion = unrecognizedIncomePortion;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder externalId(final ExternalId externalId) {
            this.externalId = externalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder transfer(final AccountTransferData transfer) {
            this.transfer = transfer;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder fixedEmiAmount(final BigDecimal fixedEmiAmount) {
            this.fixedEmiAmount = fixedEmiAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder outstandingLoanBalance(final BigDecimal outstandingLoanBalance) {
            this.outstandingLoanBalance = outstandingLoanBalance;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder submittedOnDate(final LocalDate submittedOnDate) {
            this.submittedOnDate = submittedOnDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder manuallyReversed(final boolean manuallyReversed) {
            this.manuallyReversed = manuallyReversed;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder possibleNextRepaymentDate(final LocalDate possibleNextRepaymentDate) {
            this.possibleNextRepaymentDate = possibleNextRepaymentDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder availableDisbursementAmountWithOverApplied(final BigDecimal availableDisbursementAmountWithOverApplied) {
            this.availableDisbursementAmountWithOverApplied = availableDisbursementAmountWithOverApplied;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder loanChargePaidByList(final Collection<LoanChargePaidByData> loanChargePaidByList) {
            this.loanChargePaidByList = loanChargePaidByList;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder paymentTypeOptions(final Collection<PaymentTypeData> paymentTypeOptions) {
            this.paymentTypeOptions = paymentTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder writeOffReasonOptions(final Collection<CodeValueData> writeOffReasonOptions) {
            this.writeOffReasonOptions = writeOffReasonOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder numberOfRepayments(final Integer numberOfRepayments) {
            this.numberOfRepayments = numberOfRepayments;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder rowIndex(final Integer rowIndex) {
            this.rowIndex = rowIndex;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder dateFormat(final String dateFormat) {
            this.dateFormat = dateFormat;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder locale(final String locale) {
            this.locale = locale;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder transactionAmount(final BigDecimal transactionAmount) {
            this.transactionAmount = transactionAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder transactionDate(final LocalDate transactionDate) {
            this.transactionDate = transactionDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder paymentTypeId(final Long paymentTypeId) {
            this.paymentTypeId = paymentTypeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder accountNumber(final String accountNumber) {
            this.accountNumber = accountNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder checkNumber(final Integer checkNumber) {
            this.checkNumber = checkNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder routingCode(final Integer routingCode) {
            this.routingCode = routingCode;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder receiptNumber(final Integer receiptNumber) {
            this.receiptNumber = receiptNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder bankNumber(final Integer bankNumber) {
            this.bankNumber = bankNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder accountId(final Long accountId) {
            this.accountId = accountId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder transactionType(final String transactionType) {
            this.transactionType = transactionType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder loanRepaymentScheduleInstallments(final List<LoanRepaymentScheduleInstallmentData> loanRepaymentScheduleInstallments) {
            this.loanRepaymentScheduleInstallments = loanRepaymentScheduleInstallments;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder reversalExternalId(final ExternalId reversalExternalId) {
            this.reversalExternalId = reversalExternalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder reversedOnDate(final LocalDate reversedOnDate) {
            this.reversedOnDate = reversedOnDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder transactionRelations(final List<LoanTransactionRelationData> transactionRelations) {
            this.transactionRelations = transactionRelations;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder chargeOffReasonOptions(final Collection<CodeValueData> chargeOffReasonOptions) {
            this.chargeOffReasonOptions = chargeOffReasonOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder classificationOptions(final Collection<CodeValueData> classificationOptions) {
            this.classificationOptions = classificationOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder classification(final CodeValueData classification) {
            this.classification = classification;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder reAgeReasonOptions(final Collection<CodeValueData> reAgeReasonOptions) {
            this.reAgeReasonOptions = reAgeReasonOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder periodFrequencyOptions(final Collection<PeriodFrequencyType> periodFrequencyOptions) {
            this.periodFrequencyOptions = periodFrequencyOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder reAgeInterestHandlingOptions(final Collection<StringEnumOptionData> reAgeInterestHandlingOptions) {
            this.reAgeInterestHandlingOptions = reAgeInterestHandlingOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder reAmortizationReasonOptions(final Collection<CodeValueData> reAmortizationReasonOptions) {
            this.reAmortizationReasonOptions = reAmortizationReasonOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder reAmortizationInterestHandlingOptions(final Collection<StringEnumOptionData> reAmortizationInterestHandlingOptions) {
            this.reAmortizationInterestHandlingOptions = reAmortizationInterestHandlingOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder numberOfFutureInstallments(final Integer numberOfFutureInstallments) {
            this.numberOfFutureInstallments = numberOfFutureInstallments;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder numberOfPastInstallments(final Integer numberOfPastInstallments) {
            this.numberOfPastInstallments = numberOfPastInstallments;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder nextInstallmentDueDate(final LocalDate nextInstallmentDueDate) {
            this.nextInstallmentDueDate = nextInstallmentDueDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanTransactionData.Builder calculatedStartDate(final LocalDate calculatedStartDate) {
            this.calculatedStartDate = calculatedStartDate;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public LoanTransactionData build() {
            return new LoanTransactionData(this.id, this.loanId, this.externalLoanId, this.officeId, this.officeName, this.type, this.date, this.currency, this.paymentDetailData, this.amount, this.netDisbursalAmount, this.principalPortion, this.interestPortion, this.feeChargesPortion, this.penaltyChargesPortion, this.overpaymentPortion, this.unrecognizedIncomePortion, this.externalId, this.transfer, this.fixedEmiAmount, this.outstandingLoanBalance, this.submittedOnDate, this.manuallyReversed, this.possibleNextRepaymentDate, this.availableDisbursementAmountWithOverApplied, this.loanChargePaidByList, this.paymentTypeOptions, this.writeOffReasonOptions, this.numberOfRepayments, this.rowIndex, this.dateFormat, this.locale, this.transactionAmount, this.transactionDate, this.paymentTypeId, this.accountNumber, this.checkNumber, this.routingCode, this.receiptNumber, this.bankNumber, this.accountId, this.transactionType, this.loanRepaymentScheduleInstallments, this.reversalExternalId, this.reversedOnDate, this.transactionRelations, this.chargeOffReasonOptions, this.classificationOptions, this.classification, this.reAgeReasonOptions, this.periodFrequencyOptions, this.reAgeInterestHandlingOptions, this.reAmortizationReasonOptions, this.reAmortizationInterestHandlingOptions, this.numberOfFutureInstallments, this.numberOfPastInstallments, this.nextInstallmentDueDate, this.calculatedStartDate);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "LoanTransactionData.Builder(id=" + this.id + ", loanId=" + this.loanId + ", externalLoanId=" + this.externalLoanId + ", officeId=" + this.officeId + ", officeName=" + this.officeName + ", type=" + this.type + ", date=" + this.date + ", currency=" + this.currency + ", paymentDetailData=" + this.paymentDetailData + ", amount=" + this.amount + ", netDisbursalAmount=" + this.netDisbursalAmount + ", principalPortion=" + this.principalPortion + ", interestPortion=" + this.interestPortion + ", feeChargesPortion=" + this.feeChargesPortion + ", penaltyChargesPortion=" + this.penaltyChargesPortion + ", overpaymentPortion=" + this.overpaymentPortion + ", unrecognizedIncomePortion=" + this.unrecognizedIncomePortion + ", externalId=" + this.externalId + ", transfer=" + this.transfer + ", fixedEmiAmount=" + this.fixedEmiAmount + ", outstandingLoanBalance=" + this.outstandingLoanBalance + ", submittedOnDate=" + this.submittedOnDate + ", manuallyReversed=" + this.manuallyReversed + ", possibleNextRepaymentDate=" + this.possibleNextRepaymentDate + ", availableDisbursementAmountWithOverApplied=" + this.availableDisbursementAmountWithOverApplied + ", loanChargePaidByList=" + this.loanChargePaidByList + ", paymentTypeOptions=" + this.paymentTypeOptions + ", writeOffReasonOptions=" + this.writeOffReasonOptions + ", numberOfRepayments=" + this.numberOfRepayments + ", rowIndex=" + this.rowIndex + ", dateFormat=" + this.dateFormat + ", locale=" + this.locale + ", transactionAmount=" + this.transactionAmount + ", transactionDate=" + this.transactionDate + ", paymentTypeId=" + this.paymentTypeId + ", accountNumber=" + this.accountNumber + ", checkNumber=" + this.checkNumber + ", routingCode=" + this.routingCode + ", receiptNumber=" + this.receiptNumber + ", bankNumber=" + this.bankNumber + ", accountId=" + this.accountId + ", transactionType=" + this.transactionType + ", loanRepaymentScheduleInstallments=" + this.loanRepaymentScheduleInstallments + ", reversalExternalId=" + this.reversalExternalId + ", reversedOnDate=" + this.reversedOnDate + ", transactionRelations=" + this.transactionRelations + ", chargeOffReasonOptions=" + this.chargeOffReasonOptions + ", classificationOptions=" + this.classificationOptions + ", classification=" + this.classification + ", reAgeReasonOptions=" + this.reAgeReasonOptions + ", periodFrequencyOptions=" + this.periodFrequencyOptions + ", reAgeInterestHandlingOptions=" + this.reAgeInterestHandlingOptions + ", reAmortizationReasonOptions=" + this.reAmortizationReasonOptions + ", reAmortizationInterestHandlingOptions=" + this.reAmortizationInterestHandlingOptions + ", numberOfFutureInstallments=" + this.numberOfFutureInstallments + ", numberOfPastInstallments=" + this.numberOfPastInstallments + ", nextInstallmentDueDate=" + this.nextInstallmentDueDate + ", calculatedStartDate=" + this.calculatedStartDate + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static LoanTransactionData.Builder builder() {
        return new LoanTransactionData.Builder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getExternalLoanId() {
        return this.externalLoanId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getOfficeName() {
        return this.officeName;
    }

    @java.lang.SuppressWarnings("all")
        public LoanTransactionEnumData getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDate() {
        return this.date;
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public PaymentDetailData getPaymentDetailData() {
        return this.paymentDetailData;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getNetDisbursalAmount() {
        return this.netDisbursalAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalPortion() {
        return this.principalPortion;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestPortion() {
        return this.interestPortion;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeChargesPortion() {
        return this.feeChargesPortion;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyChargesPortion() {
        return this.penaltyChargesPortion;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOverpaymentPortion() {
        return this.overpaymentPortion;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getUnrecognizedIncomePortion() {
        return this.unrecognizedIncomePortion;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public AccountTransferData getTransfer() {
        return this.transfer;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFixedEmiAmount() {
        return this.fixedEmiAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOutstandingLoanBalance() {
        return this.outstandingLoanBalance;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSubmittedOnDate() {
        return this.submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isManuallyReversed() {
        return this.manuallyReversed;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getPossibleNextRepaymentDate() {
        return this.possibleNextRepaymentDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAvailableDisbursementAmountWithOverApplied() {
        return this.availableDisbursementAmountWithOverApplied;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LoanChargePaidByData> getLoanChargePaidByList() {
        return this.loanChargePaidByList;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<PaymentTypeData> getPaymentTypeOptions() {
        return this.paymentTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getWriteOffReasonOptions() {
        return this.writeOffReasonOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getNumberOfRepayments() {
        return this.numberOfRepayments;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRowIndex() {
        return this.rowIndex;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTransactionAmount() {
        return this.transactionAmount;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getTransactionDate() {
        return this.transactionDate;
    }

    @java.lang.SuppressWarnings("all")
        public Long getPaymentTypeId() {
        return this.paymentTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getAccountNumber() {
        return this.accountNumber;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getCheckNumber() {
        return this.checkNumber;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRoutingCode() {
        return this.routingCode;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getReceiptNumber() {
        return this.receiptNumber;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getBankNumber() {
        return this.bankNumber;
    }

    @java.lang.SuppressWarnings("all")
        public Long getAccountId() {
        return this.accountId;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransactionType() {
        return this.transactionType;
    }

    @java.lang.SuppressWarnings("all")
        public List<LoanRepaymentScheduleInstallmentData> getLoanRepaymentScheduleInstallments() {
        return this.loanRepaymentScheduleInstallments;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getReversalExternalId() {
        return this.reversalExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getReversedOnDate() {
        return this.reversedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public List<LoanTransactionRelationData> getTransactionRelations() {
        return this.transactionRelations;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getChargeOffReasonOptions() {
        return this.chargeOffReasonOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getClassificationOptions() {
        return this.classificationOptions;
    }

    @java.lang.SuppressWarnings("all")
        public CodeValueData getClassification() {
        return this.classification;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getReAgeReasonOptions() {
        return this.reAgeReasonOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<PeriodFrequencyType> getPeriodFrequencyOptions() {
        return this.periodFrequencyOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<StringEnumOptionData> getReAgeInterestHandlingOptions() {
        return this.reAgeInterestHandlingOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getReAmortizationReasonOptions() {
        return this.reAmortizationReasonOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<StringEnumOptionData> getReAmortizationInterestHandlingOptions() {
        return this.reAmortizationInterestHandlingOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getNumberOfFutureInstallments() {
        return this.numberOfFutureInstallments;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getNumberOfPastInstallments() {
        return this.numberOfPastInstallments;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getNextInstallmentDueDate() {
        return this.nextInstallmentDueDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getCalculatedStartDate() {
        return this.calculatedStartDate;
    }

    @java.lang.SuppressWarnings("all")
        public LoanTransactionData(final Long id, final Long loanId, final ExternalId externalLoanId, final Long officeId, final String officeName, final LoanTransactionEnumData type, final LocalDate date, final CurrencyData currency, final PaymentDetailData paymentDetailData, final BigDecimal amount, final BigDecimal netDisbursalAmount, final BigDecimal principalPortion, final BigDecimal interestPortion, final BigDecimal feeChargesPortion, final BigDecimal penaltyChargesPortion, final BigDecimal overpaymentPortion, final BigDecimal unrecognizedIncomePortion, final ExternalId externalId, final AccountTransferData transfer, final BigDecimal fixedEmiAmount, final BigDecimal outstandingLoanBalance, final LocalDate submittedOnDate, final boolean manuallyReversed, final LocalDate possibleNextRepaymentDate, final BigDecimal availableDisbursementAmountWithOverApplied, final Collection<LoanChargePaidByData> loanChargePaidByList, final Collection<PaymentTypeData> paymentTypeOptions, final Collection<CodeValueData> writeOffReasonOptions, final Integer numberOfRepayments, final Integer rowIndex, final String dateFormat, final String locale, final BigDecimal transactionAmount, final LocalDate transactionDate, final Long paymentTypeId, final String accountNumber, final Integer checkNumber, final Integer routingCode, final Integer receiptNumber, final Integer bankNumber, final Long accountId, final String transactionType, final List<LoanRepaymentScheduleInstallmentData> loanRepaymentScheduleInstallments, final ExternalId reversalExternalId, final LocalDate reversedOnDate, final List<LoanTransactionRelationData> transactionRelations, final Collection<CodeValueData> chargeOffReasonOptions, final Collection<CodeValueData> classificationOptions, final CodeValueData classification, final Collection<CodeValueData> reAgeReasonOptions, final Collection<PeriodFrequencyType> periodFrequencyOptions, final Collection<StringEnumOptionData> reAgeInterestHandlingOptions, final Collection<CodeValueData> reAmortizationReasonOptions, final Collection<StringEnumOptionData> reAmortizationInterestHandlingOptions, final Integer numberOfFutureInstallments, final Integer numberOfPastInstallments, final LocalDate nextInstallmentDueDate, final LocalDate calculatedStartDate) {
        this.id = id;
        this.loanId = loanId;
        this.externalLoanId = externalLoanId;
        this.officeId = officeId;
        this.officeName = officeName;
        this.type = type;
        this.date = date;
        this.currency = currency;
        this.paymentDetailData = paymentDetailData;
        this.amount = amount;
        this.netDisbursalAmount = netDisbursalAmount;
        this.principalPortion = principalPortion;
        this.interestPortion = interestPortion;
        this.feeChargesPortion = feeChargesPortion;
        this.penaltyChargesPortion = penaltyChargesPortion;
        this.overpaymentPortion = overpaymentPortion;
        this.unrecognizedIncomePortion = unrecognizedIncomePortion;
        this.externalId = externalId;
        this.transfer = transfer;
        this.fixedEmiAmount = fixedEmiAmount;
        this.outstandingLoanBalance = outstandingLoanBalance;
        this.submittedOnDate = submittedOnDate;
        this.manuallyReversed = manuallyReversed;
        this.possibleNextRepaymentDate = possibleNextRepaymentDate;
        this.availableDisbursementAmountWithOverApplied = availableDisbursementAmountWithOverApplied;
        this.loanChargePaidByList = loanChargePaidByList;
        this.paymentTypeOptions = paymentTypeOptions;
        this.writeOffReasonOptions = writeOffReasonOptions;
        this.numberOfRepayments = numberOfRepayments;
        this.rowIndex = rowIndex;
        this.dateFormat = dateFormat;
        this.locale = locale;
        this.transactionAmount = transactionAmount;
        this.transactionDate = transactionDate;
        this.paymentTypeId = paymentTypeId;
        this.accountNumber = accountNumber;
        this.checkNumber = checkNumber;
        this.routingCode = routingCode;
        this.receiptNumber = receiptNumber;
        this.bankNumber = bankNumber;
        this.accountId = accountId;
        this.transactionType = transactionType;
        this.loanRepaymentScheduleInstallments = loanRepaymentScheduleInstallments;
        this.reversalExternalId = reversalExternalId;
        this.reversedOnDate = reversedOnDate;
        this.transactionRelations = transactionRelations;
        this.chargeOffReasonOptions = chargeOffReasonOptions;
        this.classificationOptions = classificationOptions;
        this.classification = classification;
        this.reAgeReasonOptions = reAgeReasonOptions;
        this.periodFrequencyOptions = periodFrequencyOptions;
        this.reAgeInterestHandlingOptions = reAgeInterestHandlingOptions;
        this.reAmortizationReasonOptions = reAmortizationReasonOptions;
        this.reAmortizationInterestHandlingOptions = reAmortizationInterestHandlingOptions;
        this.numberOfFutureInstallments = numberOfFutureInstallments;
        this.numberOfPastInstallments = numberOfPastInstallments;
        this.nextInstallmentDueDate = nextInstallmentDueDate;
        this.calculatedStartDate = calculatedStartDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanChargePaidByList(final Collection<LoanChargePaidByData> loanChargePaidByList) {
        this.loanChargePaidByList = loanChargePaidByList;
    }

    @java.lang.SuppressWarnings("all")
        public void setNumberOfRepayments(final Integer numberOfRepayments) {
        this.numberOfRepayments = numberOfRepayments;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanRepaymentScheduleInstallments(final List<LoanRepaymentScheduleInstallmentData> loanRepaymentScheduleInstallments) {
        this.loanRepaymentScheduleInstallments = loanRepaymentScheduleInstallments;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransactionRelations(final List<LoanTransactionRelationData> transactionRelations) {
        this.transactionRelations = transactionRelations;
    }
}
