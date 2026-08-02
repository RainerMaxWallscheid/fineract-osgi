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

import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.organisation.monetary.data.CurrencyData;

/**
 * Immutable data object representing loan summary information.
 */
public class LoanSummaryData {
    private final CurrencyData currency;
    private final BigDecimal totalPrincipal;
    private final BigDecimal totalCapitalizedIncome;
    private final BigDecimal totalCapitalizedIncomeAdjustment;
    private final BigDecimal principalDisbursed;
    private final BigDecimal principalAdjustments;
    private final BigDecimal principalPaid;
    private final BigDecimal principalWrittenOff;
    private final BigDecimal principalOutstanding;
    private final BigDecimal principalOverdue;
    private final BigDecimal interestCharged;
    private final BigDecimal interestPaid;
    private final BigDecimal interestWaived;
    private final BigDecimal interestWrittenOff;
    private final BigDecimal interestOutstanding;
    private final BigDecimal interestOverdue;
    private final BigDecimal feeChargesCharged;
    private final BigDecimal feeAdjustments;
    private final BigDecimal feeChargesDueAtDisbursementCharged;
    private final BigDecimal feeChargesPaid;
    private final BigDecimal feeChargesWaived;
    private final BigDecimal feeChargesWrittenOff;
    private final BigDecimal feeChargesOutstanding;
    private final BigDecimal feeChargesOverdue;
    private final BigDecimal penaltyChargesCharged;
    private final BigDecimal penaltyAdjustments;
    private final BigDecimal penaltyChargesPaid;
    private final BigDecimal penaltyChargesWaived;
    private final BigDecimal penaltyChargesWrittenOff;
    private final BigDecimal penaltyChargesOutstanding;
    private final BigDecimal penaltyChargesOverdue;
    private final BigDecimal totalExpectedRepayment;
    private final BigDecimal totalRepayment;
    private final BigDecimal totalExpectedCostOfLoan;
    private final BigDecimal totalCostOfLoan;
    private final BigDecimal totalWaived;
    private final BigDecimal totalWrittenOff;
    private final BigDecimal totalOutstanding;
    private final BigDecimal totalOverdue;
    private final BigDecimal totalRecovered;
    private final LocalDate overdueSinceDate;
    private final Long writeoffReasonId;
    private final String writeoffReason;
    // Adding fields for transaction summary
    private BigDecimal totalMerchantRefund;
    private BigDecimal totalMerchantRefundReversed;
    private BigDecimal totalPayoutRefund;
    private BigDecimal totalPayoutRefundReversed;
    private BigDecimal totalGoodwillCredit;
    private BigDecimal totalGoodwillCreditReversed;
    private BigDecimal totalChargeAdjustment;
    private BigDecimal totalChargeAdjustmentReversed;
    private BigDecimal totalChargeback;
    private BigDecimal totalCreditBalanceRefund;
    private BigDecimal totalCreditBalanceRefundReversed;
    private BigDecimal totalRepaymentTransaction;
    private BigDecimal totalRepaymentTransactionReversed;
    private BigDecimal totalInterestPaymentWaiver;
    private BigDecimal totalInterestRefund;
    private final Long chargeOffReasonId;
    private final String chargeOffReason;
    private BigDecimal totalUnpaidPayableDueInterest;
    private BigDecimal totalUnpaidPayableNotDueInterest;

    @java.lang.SuppressWarnings("all")
        LoanSummaryData(final CurrencyData currency, final BigDecimal totalPrincipal, final BigDecimal totalCapitalizedIncome, final BigDecimal totalCapitalizedIncomeAdjustment, final BigDecimal principalDisbursed, final BigDecimal principalAdjustments, final BigDecimal principalPaid, final BigDecimal principalWrittenOff, final BigDecimal principalOutstanding, final BigDecimal principalOverdue, final BigDecimal interestCharged, final BigDecimal interestPaid, final BigDecimal interestWaived, final BigDecimal interestWrittenOff, final BigDecimal interestOutstanding, final BigDecimal interestOverdue, final BigDecimal feeChargesCharged, final BigDecimal feeAdjustments, final BigDecimal feeChargesDueAtDisbursementCharged, final BigDecimal feeChargesPaid, final BigDecimal feeChargesWaived, final BigDecimal feeChargesWrittenOff, final BigDecimal feeChargesOutstanding, final BigDecimal feeChargesOverdue, final BigDecimal penaltyChargesCharged, final BigDecimal penaltyAdjustments, final BigDecimal penaltyChargesPaid, final BigDecimal penaltyChargesWaived, final BigDecimal penaltyChargesWrittenOff, final BigDecimal penaltyChargesOutstanding, final BigDecimal penaltyChargesOverdue, final BigDecimal totalExpectedRepayment, final BigDecimal totalRepayment, final BigDecimal totalExpectedCostOfLoan, final BigDecimal totalCostOfLoan, final BigDecimal totalWaived, final BigDecimal totalWrittenOff, final BigDecimal totalOutstanding, final BigDecimal totalOverdue, final BigDecimal totalRecovered, final LocalDate overdueSinceDate, final Long writeoffReasonId, final String writeoffReason, final BigDecimal totalMerchantRefund, final BigDecimal totalMerchantRefundReversed, final BigDecimal totalPayoutRefund, final BigDecimal totalPayoutRefundReversed, final BigDecimal totalGoodwillCredit, final BigDecimal totalGoodwillCreditReversed, final BigDecimal totalChargeAdjustment, final BigDecimal totalChargeAdjustmentReversed, final BigDecimal totalChargeback, final BigDecimal totalCreditBalanceRefund, final BigDecimal totalCreditBalanceRefundReversed, final BigDecimal totalRepaymentTransaction, final BigDecimal totalRepaymentTransactionReversed, final BigDecimal totalInterestPaymentWaiver, final BigDecimal totalInterestRefund, final Long chargeOffReasonId, final String chargeOffReason, final BigDecimal totalUnpaidPayableDueInterest, final BigDecimal totalUnpaidPayableNotDueInterest) {
        this.currency = currency;
        this.totalPrincipal = totalPrincipal;
        this.totalCapitalizedIncome = totalCapitalizedIncome;
        this.totalCapitalizedIncomeAdjustment = totalCapitalizedIncomeAdjustment;
        this.principalDisbursed = principalDisbursed;
        this.principalAdjustments = principalAdjustments;
        this.principalPaid = principalPaid;
        this.principalWrittenOff = principalWrittenOff;
        this.principalOutstanding = principalOutstanding;
        this.principalOverdue = principalOverdue;
        this.interestCharged = interestCharged;
        this.interestPaid = interestPaid;
        this.interestWaived = interestWaived;
        this.interestWrittenOff = interestWrittenOff;
        this.interestOutstanding = interestOutstanding;
        this.interestOverdue = interestOverdue;
        this.feeChargesCharged = feeChargesCharged;
        this.feeAdjustments = feeAdjustments;
        this.feeChargesDueAtDisbursementCharged = feeChargesDueAtDisbursementCharged;
        this.feeChargesPaid = feeChargesPaid;
        this.feeChargesWaived = feeChargesWaived;
        this.feeChargesWrittenOff = feeChargesWrittenOff;
        this.feeChargesOutstanding = feeChargesOutstanding;
        this.feeChargesOverdue = feeChargesOverdue;
        this.penaltyChargesCharged = penaltyChargesCharged;
        this.penaltyAdjustments = penaltyAdjustments;
        this.penaltyChargesPaid = penaltyChargesPaid;
        this.penaltyChargesWaived = penaltyChargesWaived;
        this.penaltyChargesWrittenOff = penaltyChargesWrittenOff;
        this.penaltyChargesOutstanding = penaltyChargesOutstanding;
        this.penaltyChargesOverdue = penaltyChargesOverdue;
        this.totalExpectedRepayment = totalExpectedRepayment;
        this.totalRepayment = totalRepayment;
        this.totalExpectedCostOfLoan = totalExpectedCostOfLoan;
        this.totalCostOfLoan = totalCostOfLoan;
        this.totalWaived = totalWaived;
        this.totalWrittenOff = totalWrittenOff;
        this.totalOutstanding = totalOutstanding;
        this.totalOverdue = totalOverdue;
        this.totalRecovered = totalRecovered;
        this.overdueSinceDate = overdueSinceDate;
        this.writeoffReasonId = writeoffReasonId;
        this.writeoffReason = writeoffReason;
        this.totalMerchantRefund = totalMerchantRefund;
        this.totalMerchantRefundReversed = totalMerchantRefundReversed;
        this.totalPayoutRefund = totalPayoutRefund;
        this.totalPayoutRefundReversed = totalPayoutRefundReversed;
        this.totalGoodwillCredit = totalGoodwillCredit;
        this.totalGoodwillCreditReversed = totalGoodwillCreditReversed;
        this.totalChargeAdjustment = totalChargeAdjustment;
        this.totalChargeAdjustmentReversed = totalChargeAdjustmentReversed;
        this.totalChargeback = totalChargeback;
        this.totalCreditBalanceRefund = totalCreditBalanceRefund;
        this.totalCreditBalanceRefundReversed = totalCreditBalanceRefundReversed;
        this.totalRepaymentTransaction = totalRepaymentTransaction;
        this.totalRepaymentTransactionReversed = totalRepaymentTransactionReversed;
        this.totalInterestPaymentWaiver = totalInterestPaymentWaiver;
        this.totalInterestRefund = totalInterestRefund;
        this.chargeOffReasonId = chargeOffReasonId;
        this.chargeOffReason = chargeOffReason;
        this.totalUnpaidPayableDueInterest = totalUnpaidPayableDueInterest;
        this.totalUnpaidPayableNotDueInterest = totalUnpaidPayableNotDueInterest;
    }


    @java.lang.SuppressWarnings("all")
        public static class LoanSummaryDataBuilder {
        @java.lang.SuppressWarnings("all")
                private CurrencyData currency;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalPrincipal;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalCapitalizedIncome;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalCapitalizedIncomeAdjustment;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalDisbursed;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalAdjustments;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalPaid;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalWrittenOff;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalOutstanding;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalOverdue;
        @java.lang.SuppressWarnings("all")
                private BigDecimal interestCharged;
        @java.lang.SuppressWarnings("all")
                private BigDecimal interestPaid;
        @java.lang.SuppressWarnings("all")
                private BigDecimal interestWaived;
        @java.lang.SuppressWarnings("all")
                private BigDecimal interestWrittenOff;
        @java.lang.SuppressWarnings("all")
                private BigDecimal interestOutstanding;
        @java.lang.SuppressWarnings("all")
                private BigDecimal interestOverdue;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feeChargesCharged;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feeAdjustments;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feeChargesDueAtDisbursementCharged;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feeChargesPaid;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feeChargesWaived;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feeChargesWrittenOff;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feeChargesOutstanding;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feeChargesOverdue;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penaltyChargesCharged;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penaltyAdjustments;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penaltyChargesPaid;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penaltyChargesWaived;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penaltyChargesWrittenOff;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penaltyChargesOutstanding;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penaltyChargesOverdue;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalExpectedRepayment;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalRepayment;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalExpectedCostOfLoan;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalCostOfLoan;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalWaived;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalWrittenOff;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalOutstanding;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalOverdue;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalRecovered;
        @java.lang.SuppressWarnings("all")
                private LocalDate overdueSinceDate;
        @java.lang.SuppressWarnings("all")
                private Long writeoffReasonId;
        @java.lang.SuppressWarnings("all")
                private String writeoffReason;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalMerchantRefund;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalMerchantRefundReversed;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalPayoutRefund;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalPayoutRefundReversed;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalGoodwillCredit;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalGoodwillCreditReversed;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalChargeAdjustment;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalChargeAdjustmentReversed;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalChargeback;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalCreditBalanceRefund;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalCreditBalanceRefundReversed;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalRepaymentTransaction;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalRepaymentTransactionReversed;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalInterestPaymentWaiver;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalInterestRefund;
        @java.lang.SuppressWarnings("all")
                private Long chargeOffReasonId;
        @java.lang.SuppressWarnings("all")
                private String chargeOffReason;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalUnpaidPayableDueInterest;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalUnpaidPayableNotDueInterest;

        @java.lang.SuppressWarnings("all")
                LoanSummaryDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder currency(final CurrencyData currency) {
            this.currency = currency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalPrincipal(final BigDecimal totalPrincipal) {
            this.totalPrincipal = totalPrincipal;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalCapitalizedIncome(final BigDecimal totalCapitalizedIncome) {
            this.totalCapitalizedIncome = totalCapitalizedIncome;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalCapitalizedIncomeAdjustment(final BigDecimal totalCapitalizedIncomeAdjustment) {
            this.totalCapitalizedIncomeAdjustment = totalCapitalizedIncomeAdjustment;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder principalDisbursed(final BigDecimal principalDisbursed) {
            this.principalDisbursed = principalDisbursed;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder principalAdjustments(final BigDecimal principalAdjustments) {
            this.principalAdjustments = principalAdjustments;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder principalPaid(final BigDecimal principalPaid) {
            this.principalPaid = principalPaid;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder principalWrittenOff(final BigDecimal principalWrittenOff) {
            this.principalWrittenOff = principalWrittenOff;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder principalOutstanding(final BigDecimal principalOutstanding) {
            this.principalOutstanding = principalOutstanding;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder principalOverdue(final BigDecimal principalOverdue) {
            this.principalOverdue = principalOverdue;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder interestCharged(final BigDecimal interestCharged) {
            this.interestCharged = interestCharged;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder interestPaid(final BigDecimal interestPaid) {
            this.interestPaid = interestPaid;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder interestWaived(final BigDecimal interestWaived) {
            this.interestWaived = interestWaived;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder interestWrittenOff(final BigDecimal interestWrittenOff) {
            this.interestWrittenOff = interestWrittenOff;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder interestOutstanding(final BigDecimal interestOutstanding) {
            this.interestOutstanding = interestOutstanding;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder interestOverdue(final BigDecimal interestOverdue) {
            this.interestOverdue = interestOverdue;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder feeChargesCharged(final BigDecimal feeChargesCharged) {
            this.feeChargesCharged = feeChargesCharged;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder feeAdjustments(final BigDecimal feeAdjustments) {
            this.feeAdjustments = feeAdjustments;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder feeChargesDueAtDisbursementCharged(final BigDecimal feeChargesDueAtDisbursementCharged) {
            this.feeChargesDueAtDisbursementCharged = feeChargesDueAtDisbursementCharged;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder feeChargesPaid(final BigDecimal feeChargesPaid) {
            this.feeChargesPaid = feeChargesPaid;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder feeChargesWaived(final BigDecimal feeChargesWaived) {
            this.feeChargesWaived = feeChargesWaived;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder feeChargesWrittenOff(final BigDecimal feeChargesWrittenOff) {
            this.feeChargesWrittenOff = feeChargesWrittenOff;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder feeChargesOutstanding(final BigDecimal feeChargesOutstanding) {
            this.feeChargesOutstanding = feeChargesOutstanding;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder feeChargesOverdue(final BigDecimal feeChargesOverdue) {
            this.feeChargesOverdue = feeChargesOverdue;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder penaltyChargesCharged(final BigDecimal penaltyChargesCharged) {
            this.penaltyChargesCharged = penaltyChargesCharged;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder penaltyAdjustments(final BigDecimal penaltyAdjustments) {
            this.penaltyAdjustments = penaltyAdjustments;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder penaltyChargesPaid(final BigDecimal penaltyChargesPaid) {
            this.penaltyChargesPaid = penaltyChargesPaid;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder penaltyChargesWaived(final BigDecimal penaltyChargesWaived) {
            this.penaltyChargesWaived = penaltyChargesWaived;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder penaltyChargesWrittenOff(final BigDecimal penaltyChargesWrittenOff) {
            this.penaltyChargesWrittenOff = penaltyChargesWrittenOff;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder penaltyChargesOutstanding(final BigDecimal penaltyChargesOutstanding) {
            this.penaltyChargesOutstanding = penaltyChargesOutstanding;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder penaltyChargesOverdue(final BigDecimal penaltyChargesOverdue) {
            this.penaltyChargesOverdue = penaltyChargesOverdue;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalExpectedRepayment(final BigDecimal totalExpectedRepayment) {
            this.totalExpectedRepayment = totalExpectedRepayment;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalRepayment(final BigDecimal totalRepayment) {
            this.totalRepayment = totalRepayment;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalExpectedCostOfLoan(final BigDecimal totalExpectedCostOfLoan) {
            this.totalExpectedCostOfLoan = totalExpectedCostOfLoan;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalCostOfLoan(final BigDecimal totalCostOfLoan) {
            this.totalCostOfLoan = totalCostOfLoan;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalWaived(final BigDecimal totalWaived) {
            this.totalWaived = totalWaived;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalWrittenOff(final BigDecimal totalWrittenOff) {
            this.totalWrittenOff = totalWrittenOff;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalOutstanding(final BigDecimal totalOutstanding) {
            this.totalOutstanding = totalOutstanding;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalOverdue(final BigDecimal totalOverdue) {
            this.totalOverdue = totalOverdue;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalRecovered(final BigDecimal totalRecovered) {
            this.totalRecovered = totalRecovered;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder overdueSinceDate(final LocalDate overdueSinceDate) {
            this.overdueSinceDate = overdueSinceDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder writeoffReasonId(final Long writeoffReasonId) {
            this.writeoffReasonId = writeoffReasonId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder writeoffReason(final String writeoffReason) {
            this.writeoffReason = writeoffReason;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalMerchantRefund(final BigDecimal totalMerchantRefund) {
            this.totalMerchantRefund = totalMerchantRefund;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalMerchantRefundReversed(final BigDecimal totalMerchantRefundReversed) {
            this.totalMerchantRefundReversed = totalMerchantRefundReversed;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalPayoutRefund(final BigDecimal totalPayoutRefund) {
            this.totalPayoutRefund = totalPayoutRefund;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalPayoutRefundReversed(final BigDecimal totalPayoutRefundReversed) {
            this.totalPayoutRefundReversed = totalPayoutRefundReversed;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalGoodwillCredit(final BigDecimal totalGoodwillCredit) {
            this.totalGoodwillCredit = totalGoodwillCredit;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalGoodwillCreditReversed(final BigDecimal totalGoodwillCreditReversed) {
            this.totalGoodwillCreditReversed = totalGoodwillCreditReversed;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalChargeAdjustment(final BigDecimal totalChargeAdjustment) {
            this.totalChargeAdjustment = totalChargeAdjustment;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalChargeAdjustmentReversed(final BigDecimal totalChargeAdjustmentReversed) {
            this.totalChargeAdjustmentReversed = totalChargeAdjustmentReversed;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalChargeback(final BigDecimal totalChargeback) {
            this.totalChargeback = totalChargeback;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalCreditBalanceRefund(final BigDecimal totalCreditBalanceRefund) {
            this.totalCreditBalanceRefund = totalCreditBalanceRefund;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalCreditBalanceRefundReversed(final BigDecimal totalCreditBalanceRefundReversed) {
            this.totalCreditBalanceRefundReversed = totalCreditBalanceRefundReversed;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalRepaymentTransaction(final BigDecimal totalRepaymentTransaction) {
            this.totalRepaymentTransaction = totalRepaymentTransaction;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalRepaymentTransactionReversed(final BigDecimal totalRepaymentTransactionReversed) {
            this.totalRepaymentTransactionReversed = totalRepaymentTransactionReversed;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalInterestPaymentWaiver(final BigDecimal totalInterestPaymentWaiver) {
            this.totalInterestPaymentWaiver = totalInterestPaymentWaiver;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalInterestRefund(final BigDecimal totalInterestRefund) {
            this.totalInterestRefund = totalInterestRefund;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder chargeOffReasonId(final Long chargeOffReasonId) {
            this.chargeOffReasonId = chargeOffReasonId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder chargeOffReason(final String chargeOffReason) {
            this.chargeOffReason = chargeOffReason;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalUnpaidPayableDueInterest(final BigDecimal totalUnpaidPayableDueInterest) {
            this.totalUnpaidPayableDueInterest = totalUnpaidPayableDueInterest;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSummaryData.LoanSummaryDataBuilder totalUnpaidPayableNotDueInterest(final BigDecimal totalUnpaidPayableNotDueInterest) {
            this.totalUnpaidPayableNotDueInterest = totalUnpaidPayableNotDueInterest;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public LoanSummaryData build() {
            return new LoanSummaryData(this.currency, this.totalPrincipal, this.totalCapitalizedIncome, this.totalCapitalizedIncomeAdjustment, this.principalDisbursed, this.principalAdjustments, this.principalPaid, this.principalWrittenOff, this.principalOutstanding, this.principalOverdue, this.interestCharged, this.interestPaid, this.interestWaived, this.interestWrittenOff, this.interestOutstanding, this.interestOverdue, this.feeChargesCharged, this.feeAdjustments, this.feeChargesDueAtDisbursementCharged, this.feeChargesPaid, this.feeChargesWaived, this.feeChargesWrittenOff, this.feeChargesOutstanding, this.feeChargesOverdue, this.penaltyChargesCharged, this.penaltyAdjustments, this.penaltyChargesPaid, this.penaltyChargesWaived, this.penaltyChargesWrittenOff, this.penaltyChargesOutstanding, this.penaltyChargesOverdue, this.totalExpectedRepayment, this.totalRepayment, this.totalExpectedCostOfLoan, this.totalCostOfLoan, this.totalWaived, this.totalWrittenOff, this.totalOutstanding, this.totalOverdue, this.totalRecovered, this.overdueSinceDate, this.writeoffReasonId, this.writeoffReason, this.totalMerchantRefund, this.totalMerchantRefundReversed, this.totalPayoutRefund, this.totalPayoutRefundReversed, this.totalGoodwillCredit, this.totalGoodwillCreditReversed, this.totalChargeAdjustment, this.totalChargeAdjustmentReversed, this.totalChargeback, this.totalCreditBalanceRefund, this.totalCreditBalanceRefundReversed, this.totalRepaymentTransaction, this.totalRepaymentTransactionReversed, this.totalInterestPaymentWaiver, this.totalInterestRefund, this.chargeOffReasonId, this.chargeOffReason, this.totalUnpaidPayableDueInterest, this.totalUnpaidPayableNotDueInterest);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "LoanSummaryData.LoanSummaryDataBuilder(currency=" + this.currency + ", totalPrincipal=" + this.totalPrincipal + ", totalCapitalizedIncome=" + this.totalCapitalizedIncome + ", totalCapitalizedIncomeAdjustment=" + this.totalCapitalizedIncomeAdjustment + ", principalDisbursed=" + this.principalDisbursed + ", principalAdjustments=" + this.principalAdjustments + ", principalPaid=" + this.principalPaid + ", principalWrittenOff=" + this.principalWrittenOff + ", principalOutstanding=" + this.principalOutstanding + ", principalOverdue=" + this.principalOverdue + ", interestCharged=" + this.interestCharged + ", interestPaid=" + this.interestPaid + ", interestWaived=" + this.interestWaived + ", interestWrittenOff=" + this.interestWrittenOff + ", interestOutstanding=" + this.interestOutstanding + ", interestOverdue=" + this.interestOverdue + ", feeChargesCharged=" + this.feeChargesCharged + ", feeAdjustments=" + this.feeAdjustments + ", feeChargesDueAtDisbursementCharged=" + this.feeChargesDueAtDisbursementCharged + ", feeChargesPaid=" + this.feeChargesPaid + ", feeChargesWaived=" + this.feeChargesWaived + ", feeChargesWrittenOff=" + this.feeChargesWrittenOff + ", feeChargesOutstanding=" + this.feeChargesOutstanding + ", feeChargesOverdue=" + this.feeChargesOverdue + ", penaltyChargesCharged=" + this.penaltyChargesCharged + ", penaltyAdjustments=" + this.penaltyAdjustments + ", penaltyChargesPaid=" + this.penaltyChargesPaid + ", penaltyChargesWaived=" + this.penaltyChargesWaived + ", penaltyChargesWrittenOff=" + this.penaltyChargesWrittenOff + ", penaltyChargesOutstanding=" + this.penaltyChargesOutstanding + ", penaltyChargesOverdue=" + this.penaltyChargesOverdue + ", totalExpectedRepayment=" + this.totalExpectedRepayment + ", totalRepayment=" + this.totalRepayment + ", totalExpectedCostOfLoan=" + this.totalExpectedCostOfLoan + ", totalCostOfLoan=" + this.totalCostOfLoan + ", totalWaived=" + this.totalWaived + ", totalWrittenOff=" + this.totalWrittenOff + ", totalOutstanding=" + this.totalOutstanding + ", totalOverdue=" + this.totalOverdue + ", totalRecovered=" + this.totalRecovered + ", overdueSinceDate=" + this.overdueSinceDate + ", writeoffReasonId=" + this.writeoffReasonId + ", writeoffReason=" + this.writeoffReason + ", totalMerchantRefund=" + this.totalMerchantRefund + ", totalMerchantRefundReversed=" + this.totalMerchantRefundReversed + ", totalPayoutRefund=" + this.totalPayoutRefund + ", totalPayoutRefundReversed=" + this.totalPayoutRefundReversed + ", totalGoodwillCredit=" + this.totalGoodwillCredit + ", totalGoodwillCreditReversed=" + this.totalGoodwillCreditReversed + ", totalChargeAdjustment=" + this.totalChargeAdjustment + ", totalChargeAdjustmentReversed=" + this.totalChargeAdjustmentReversed + ", totalChargeback=" + this.totalChargeback + ", totalCreditBalanceRefund=" + this.totalCreditBalanceRefund + ", totalCreditBalanceRefundReversed=" + this.totalCreditBalanceRefundReversed + ", totalRepaymentTransaction=" + this.totalRepaymentTransaction + ", totalRepaymentTransactionReversed=" + this.totalRepaymentTransactionReversed + ", totalInterestPaymentWaiver=" + this.totalInterestPaymentWaiver + ", totalInterestRefund=" + this.totalInterestRefund + ", chargeOffReasonId=" + this.chargeOffReasonId + ", chargeOffReason=" + this.chargeOffReason + ", totalUnpaidPayableDueInterest=" + this.totalUnpaidPayableDueInterest + ", totalUnpaidPayableNotDueInterest=" + this.totalUnpaidPayableNotDueInterest + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static LoanSummaryData.LoanSummaryDataBuilder builder() {
        return new LoanSummaryData.LoanSummaryDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalPrincipal() {
        return this.totalPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalCapitalizedIncome() {
        return this.totalCapitalizedIncome;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalCapitalizedIncomeAdjustment() {
        return this.totalCapitalizedIncomeAdjustment;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalDisbursed() {
        return this.principalDisbursed;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalAdjustments() {
        return this.principalAdjustments;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalPaid() {
        return this.principalPaid;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalWrittenOff() {
        return this.principalWrittenOff;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalOutstanding() {
        return this.principalOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalOverdue() {
        return this.principalOverdue;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestCharged() {
        return this.interestCharged;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestPaid() {
        return this.interestPaid;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestWaived() {
        return this.interestWaived;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestWrittenOff() {
        return this.interestWrittenOff;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestOutstanding() {
        return this.interestOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestOverdue() {
        return this.interestOverdue;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeChargesCharged() {
        return this.feeChargesCharged;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeAdjustments() {
        return this.feeAdjustments;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeChargesDueAtDisbursementCharged() {
        return this.feeChargesDueAtDisbursementCharged;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeChargesPaid() {
        return this.feeChargesPaid;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeChargesWaived() {
        return this.feeChargesWaived;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeChargesWrittenOff() {
        return this.feeChargesWrittenOff;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeChargesOutstanding() {
        return this.feeChargesOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeChargesOverdue() {
        return this.feeChargesOverdue;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyChargesCharged() {
        return this.penaltyChargesCharged;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyAdjustments() {
        return this.penaltyAdjustments;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyChargesPaid() {
        return this.penaltyChargesPaid;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyChargesWaived() {
        return this.penaltyChargesWaived;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyChargesWrittenOff() {
        return this.penaltyChargesWrittenOff;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyChargesOutstanding() {
        return this.penaltyChargesOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyChargesOverdue() {
        return this.penaltyChargesOverdue;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalExpectedRepayment() {
        return this.totalExpectedRepayment;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalRepayment() {
        return this.totalRepayment;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalExpectedCostOfLoan() {
        return this.totalExpectedCostOfLoan;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalCostOfLoan() {
        return this.totalCostOfLoan;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalWaived() {
        return this.totalWaived;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalWrittenOff() {
        return this.totalWrittenOff;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalOutstanding() {
        return this.totalOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalOverdue() {
        return this.totalOverdue;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalRecovered() {
        return this.totalRecovered;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getOverdueSinceDate() {
        return this.overdueSinceDate;
    }

    @java.lang.SuppressWarnings("all")
        public Long getWriteoffReasonId() {
        return this.writeoffReasonId;
    }

    @java.lang.SuppressWarnings("all")
        public String getWriteoffReason() {
        return this.writeoffReason;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalMerchantRefund() {
        return this.totalMerchantRefund;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalMerchantRefundReversed() {
        return this.totalMerchantRefundReversed;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalPayoutRefund() {
        return this.totalPayoutRefund;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalPayoutRefundReversed() {
        return this.totalPayoutRefundReversed;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalGoodwillCredit() {
        return this.totalGoodwillCredit;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalGoodwillCreditReversed() {
        return this.totalGoodwillCreditReversed;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalChargeAdjustment() {
        return this.totalChargeAdjustment;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalChargeAdjustmentReversed() {
        return this.totalChargeAdjustmentReversed;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalChargeback() {
        return this.totalChargeback;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalCreditBalanceRefund() {
        return this.totalCreditBalanceRefund;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalCreditBalanceRefundReversed() {
        return this.totalCreditBalanceRefundReversed;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalRepaymentTransaction() {
        return this.totalRepaymentTransaction;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalRepaymentTransactionReversed() {
        return this.totalRepaymentTransactionReversed;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalInterestPaymentWaiver() {
        return this.totalInterestPaymentWaiver;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalInterestRefund() {
        return this.totalInterestRefund;
    }

    @java.lang.SuppressWarnings("all")
        public Long getChargeOffReasonId() {
        return this.chargeOffReasonId;
    }

    @java.lang.SuppressWarnings("all")
        public String getChargeOffReason() {
        return this.chargeOffReason;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalUnpaidPayableDueInterest() {
        return this.totalUnpaidPayableDueInterest;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalUnpaidPayableNotDueInterest() {
        return this.totalUnpaidPayableNotDueInterest;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalMerchantRefund(final BigDecimal totalMerchantRefund) {
        this.totalMerchantRefund = totalMerchantRefund;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalMerchantRefundReversed(final BigDecimal totalMerchantRefundReversed) {
        this.totalMerchantRefundReversed = totalMerchantRefundReversed;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalPayoutRefund(final BigDecimal totalPayoutRefund) {
        this.totalPayoutRefund = totalPayoutRefund;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalPayoutRefundReversed(final BigDecimal totalPayoutRefundReversed) {
        this.totalPayoutRefundReversed = totalPayoutRefundReversed;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalGoodwillCredit(final BigDecimal totalGoodwillCredit) {
        this.totalGoodwillCredit = totalGoodwillCredit;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalGoodwillCreditReversed(final BigDecimal totalGoodwillCreditReversed) {
        this.totalGoodwillCreditReversed = totalGoodwillCreditReversed;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalChargeAdjustment(final BigDecimal totalChargeAdjustment) {
        this.totalChargeAdjustment = totalChargeAdjustment;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalChargeAdjustmentReversed(final BigDecimal totalChargeAdjustmentReversed) {
        this.totalChargeAdjustmentReversed = totalChargeAdjustmentReversed;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalChargeback(final BigDecimal totalChargeback) {
        this.totalChargeback = totalChargeback;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalCreditBalanceRefund(final BigDecimal totalCreditBalanceRefund) {
        this.totalCreditBalanceRefund = totalCreditBalanceRefund;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalCreditBalanceRefundReversed(final BigDecimal totalCreditBalanceRefundReversed) {
        this.totalCreditBalanceRefundReversed = totalCreditBalanceRefundReversed;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalRepaymentTransaction(final BigDecimal totalRepaymentTransaction) {
        this.totalRepaymentTransaction = totalRepaymentTransaction;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalRepaymentTransactionReversed(final BigDecimal totalRepaymentTransactionReversed) {
        this.totalRepaymentTransactionReversed = totalRepaymentTransactionReversed;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalInterestPaymentWaiver(final BigDecimal totalInterestPaymentWaiver) {
        this.totalInterestPaymentWaiver = totalInterestPaymentWaiver;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalInterestRefund(final BigDecimal totalInterestRefund) {
        this.totalInterestRefund = totalInterestRefund;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalUnpaidPayableDueInterest(final BigDecimal totalUnpaidPayableDueInterest) {
        this.totalUnpaidPayableDueInterest = totalUnpaidPayableDueInterest;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanSummaryData setTotalUnpaidPayableNotDueInterest(final BigDecimal totalUnpaidPayableNotDueInterest) {
        this.totalUnpaidPayableNotDueInterest = totalUnpaidPayableNotDueInterest;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanSummaryData)) return false;
        final LoanSummaryData other = (LoanSummaryData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$writeoffReasonId = this.getWriteoffReasonId();
        final java.lang.Object other$writeoffReasonId = other.getWriteoffReasonId();
        if (this$writeoffReasonId == null ? other$writeoffReasonId != null : !this$writeoffReasonId.equals(other$writeoffReasonId)) return false;
        final java.lang.Object this$chargeOffReasonId = this.getChargeOffReasonId();
        final java.lang.Object other$chargeOffReasonId = other.getChargeOffReasonId();
        if (this$chargeOffReasonId == null ? other$chargeOffReasonId != null : !this$chargeOffReasonId.equals(other$chargeOffReasonId)) return false;
        final java.lang.Object this$currency = this.getCurrency();
        final java.lang.Object other$currency = other.getCurrency();
        if (this$currency == null ? other$currency != null : !this$currency.equals(other$currency)) return false;
        final java.lang.Object this$totalPrincipal = this.getTotalPrincipal();
        final java.lang.Object other$totalPrincipal = other.getTotalPrincipal();
        if (this$totalPrincipal == null ? other$totalPrincipal != null : !this$totalPrincipal.equals(other$totalPrincipal)) return false;
        final java.lang.Object this$totalCapitalizedIncome = this.getTotalCapitalizedIncome();
        final java.lang.Object other$totalCapitalizedIncome = other.getTotalCapitalizedIncome();
        if (this$totalCapitalizedIncome == null ? other$totalCapitalizedIncome != null : !this$totalCapitalizedIncome.equals(other$totalCapitalizedIncome)) return false;
        final java.lang.Object this$totalCapitalizedIncomeAdjustment = this.getTotalCapitalizedIncomeAdjustment();
        final java.lang.Object other$totalCapitalizedIncomeAdjustment = other.getTotalCapitalizedIncomeAdjustment();
        if (this$totalCapitalizedIncomeAdjustment == null ? other$totalCapitalizedIncomeAdjustment != null : !this$totalCapitalizedIncomeAdjustment.equals(other$totalCapitalizedIncomeAdjustment)) return false;
        final java.lang.Object this$principalDisbursed = this.getPrincipalDisbursed();
        final java.lang.Object other$principalDisbursed = other.getPrincipalDisbursed();
        if (this$principalDisbursed == null ? other$principalDisbursed != null : !this$principalDisbursed.equals(other$principalDisbursed)) return false;
        final java.lang.Object this$principalAdjustments = this.getPrincipalAdjustments();
        final java.lang.Object other$principalAdjustments = other.getPrincipalAdjustments();
        if (this$principalAdjustments == null ? other$principalAdjustments != null : !this$principalAdjustments.equals(other$principalAdjustments)) return false;
        final java.lang.Object this$principalPaid = this.getPrincipalPaid();
        final java.lang.Object other$principalPaid = other.getPrincipalPaid();
        if (this$principalPaid == null ? other$principalPaid != null : !this$principalPaid.equals(other$principalPaid)) return false;
        final java.lang.Object this$principalWrittenOff = this.getPrincipalWrittenOff();
        final java.lang.Object other$principalWrittenOff = other.getPrincipalWrittenOff();
        if (this$principalWrittenOff == null ? other$principalWrittenOff != null : !this$principalWrittenOff.equals(other$principalWrittenOff)) return false;
        final java.lang.Object this$principalOutstanding = this.getPrincipalOutstanding();
        final java.lang.Object other$principalOutstanding = other.getPrincipalOutstanding();
        if (this$principalOutstanding == null ? other$principalOutstanding != null : !this$principalOutstanding.equals(other$principalOutstanding)) return false;
        final java.lang.Object this$principalOverdue = this.getPrincipalOverdue();
        final java.lang.Object other$principalOverdue = other.getPrincipalOverdue();
        if (this$principalOverdue == null ? other$principalOverdue != null : !this$principalOverdue.equals(other$principalOverdue)) return false;
        final java.lang.Object this$interestCharged = this.getInterestCharged();
        final java.lang.Object other$interestCharged = other.getInterestCharged();
        if (this$interestCharged == null ? other$interestCharged != null : !this$interestCharged.equals(other$interestCharged)) return false;
        final java.lang.Object this$interestPaid = this.getInterestPaid();
        final java.lang.Object other$interestPaid = other.getInterestPaid();
        if (this$interestPaid == null ? other$interestPaid != null : !this$interestPaid.equals(other$interestPaid)) return false;
        final java.lang.Object this$interestWaived = this.getInterestWaived();
        final java.lang.Object other$interestWaived = other.getInterestWaived();
        if (this$interestWaived == null ? other$interestWaived != null : !this$interestWaived.equals(other$interestWaived)) return false;
        final java.lang.Object this$interestWrittenOff = this.getInterestWrittenOff();
        final java.lang.Object other$interestWrittenOff = other.getInterestWrittenOff();
        if (this$interestWrittenOff == null ? other$interestWrittenOff != null : !this$interestWrittenOff.equals(other$interestWrittenOff)) return false;
        final java.lang.Object this$interestOutstanding = this.getInterestOutstanding();
        final java.lang.Object other$interestOutstanding = other.getInterestOutstanding();
        if (this$interestOutstanding == null ? other$interestOutstanding != null : !this$interestOutstanding.equals(other$interestOutstanding)) return false;
        final java.lang.Object this$interestOverdue = this.getInterestOverdue();
        final java.lang.Object other$interestOverdue = other.getInterestOverdue();
        if (this$interestOverdue == null ? other$interestOverdue != null : !this$interestOverdue.equals(other$interestOverdue)) return false;
        final java.lang.Object this$feeChargesCharged = this.getFeeChargesCharged();
        final java.lang.Object other$feeChargesCharged = other.getFeeChargesCharged();
        if (this$feeChargesCharged == null ? other$feeChargesCharged != null : !this$feeChargesCharged.equals(other$feeChargesCharged)) return false;
        final java.lang.Object this$feeAdjustments = this.getFeeAdjustments();
        final java.lang.Object other$feeAdjustments = other.getFeeAdjustments();
        if (this$feeAdjustments == null ? other$feeAdjustments != null : !this$feeAdjustments.equals(other$feeAdjustments)) return false;
        final java.lang.Object this$feeChargesDueAtDisbursementCharged = this.getFeeChargesDueAtDisbursementCharged();
        final java.lang.Object other$feeChargesDueAtDisbursementCharged = other.getFeeChargesDueAtDisbursementCharged();
        if (this$feeChargesDueAtDisbursementCharged == null ? other$feeChargesDueAtDisbursementCharged != null : !this$feeChargesDueAtDisbursementCharged.equals(other$feeChargesDueAtDisbursementCharged)) return false;
        final java.lang.Object this$feeChargesPaid = this.getFeeChargesPaid();
        final java.lang.Object other$feeChargesPaid = other.getFeeChargesPaid();
        if (this$feeChargesPaid == null ? other$feeChargesPaid != null : !this$feeChargesPaid.equals(other$feeChargesPaid)) return false;
        final java.lang.Object this$feeChargesWaived = this.getFeeChargesWaived();
        final java.lang.Object other$feeChargesWaived = other.getFeeChargesWaived();
        if (this$feeChargesWaived == null ? other$feeChargesWaived != null : !this$feeChargesWaived.equals(other$feeChargesWaived)) return false;
        final java.lang.Object this$feeChargesWrittenOff = this.getFeeChargesWrittenOff();
        final java.lang.Object other$feeChargesWrittenOff = other.getFeeChargesWrittenOff();
        if (this$feeChargesWrittenOff == null ? other$feeChargesWrittenOff != null : !this$feeChargesWrittenOff.equals(other$feeChargesWrittenOff)) return false;
        final java.lang.Object this$feeChargesOutstanding = this.getFeeChargesOutstanding();
        final java.lang.Object other$feeChargesOutstanding = other.getFeeChargesOutstanding();
        if (this$feeChargesOutstanding == null ? other$feeChargesOutstanding != null : !this$feeChargesOutstanding.equals(other$feeChargesOutstanding)) return false;
        final java.lang.Object this$feeChargesOverdue = this.getFeeChargesOverdue();
        final java.lang.Object other$feeChargesOverdue = other.getFeeChargesOverdue();
        if (this$feeChargesOverdue == null ? other$feeChargesOverdue != null : !this$feeChargesOverdue.equals(other$feeChargesOverdue)) return false;
        final java.lang.Object this$penaltyChargesCharged = this.getPenaltyChargesCharged();
        final java.lang.Object other$penaltyChargesCharged = other.getPenaltyChargesCharged();
        if (this$penaltyChargesCharged == null ? other$penaltyChargesCharged != null : !this$penaltyChargesCharged.equals(other$penaltyChargesCharged)) return false;
        final java.lang.Object this$penaltyAdjustments = this.getPenaltyAdjustments();
        final java.lang.Object other$penaltyAdjustments = other.getPenaltyAdjustments();
        if (this$penaltyAdjustments == null ? other$penaltyAdjustments != null : !this$penaltyAdjustments.equals(other$penaltyAdjustments)) return false;
        final java.lang.Object this$penaltyChargesPaid = this.getPenaltyChargesPaid();
        final java.lang.Object other$penaltyChargesPaid = other.getPenaltyChargesPaid();
        if (this$penaltyChargesPaid == null ? other$penaltyChargesPaid != null : !this$penaltyChargesPaid.equals(other$penaltyChargesPaid)) return false;
        final java.lang.Object this$penaltyChargesWaived = this.getPenaltyChargesWaived();
        final java.lang.Object other$penaltyChargesWaived = other.getPenaltyChargesWaived();
        if (this$penaltyChargesWaived == null ? other$penaltyChargesWaived != null : !this$penaltyChargesWaived.equals(other$penaltyChargesWaived)) return false;
        final java.lang.Object this$penaltyChargesWrittenOff = this.getPenaltyChargesWrittenOff();
        final java.lang.Object other$penaltyChargesWrittenOff = other.getPenaltyChargesWrittenOff();
        if (this$penaltyChargesWrittenOff == null ? other$penaltyChargesWrittenOff != null : !this$penaltyChargesWrittenOff.equals(other$penaltyChargesWrittenOff)) return false;
        final java.lang.Object this$penaltyChargesOutstanding = this.getPenaltyChargesOutstanding();
        final java.lang.Object other$penaltyChargesOutstanding = other.getPenaltyChargesOutstanding();
        if (this$penaltyChargesOutstanding == null ? other$penaltyChargesOutstanding != null : !this$penaltyChargesOutstanding.equals(other$penaltyChargesOutstanding)) return false;
        final java.lang.Object this$penaltyChargesOverdue = this.getPenaltyChargesOverdue();
        final java.lang.Object other$penaltyChargesOverdue = other.getPenaltyChargesOverdue();
        if (this$penaltyChargesOverdue == null ? other$penaltyChargesOverdue != null : !this$penaltyChargesOverdue.equals(other$penaltyChargesOverdue)) return false;
        final java.lang.Object this$totalExpectedRepayment = this.getTotalExpectedRepayment();
        final java.lang.Object other$totalExpectedRepayment = other.getTotalExpectedRepayment();
        if (this$totalExpectedRepayment == null ? other$totalExpectedRepayment != null : !this$totalExpectedRepayment.equals(other$totalExpectedRepayment)) return false;
        final java.lang.Object this$totalRepayment = this.getTotalRepayment();
        final java.lang.Object other$totalRepayment = other.getTotalRepayment();
        if (this$totalRepayment == null ? other$totalRepayment != null : !this$totalRepayment.equals(other$totalRepayment)) return false;
        final java.lang.Object this$totalExpectedCostOfLoan = this.getTotalExpectedCostOfLoan();
        final java.lang.Object other$totalExpectedCostOfLoan = other.getTotalExpectedCostOfLoan();
        if (this$totalExpectedCostOfLoan == null ? other$totalExpectedCostOfLoan != null : !this$totalExpectedCostOfLoan.equals(other$totalExpectedCostOfLoan)) return false;
        final java.lang.Object this$totalCostOfLoan = this.getTotalCostOfLoan();
        final java.lang.Object other$totalCostOfLoan = other.getTotalCostOfLoan();
        if (this$totalCostOfLoan == null ? other$totalCostOfLoan != null : !this$totalCostOfLoan.equals(other$totalCostOfLoan)) return false;
        final java.lang.Object this$totalWaived = this.getTotalWaived();
        final java.lang.Object other$totalWaived = other.getTotalWaived();
        if (this$totalWaived == null ? other$totalWaived != null : !this$totalWaived.equals(other$totalWaived)) return false;
        final java.lang.Object this$totalWrittenOff = this.getTotalWrittenOff();
        final java.lang.Object other$totalWrittenOff = other.getTotalWrittenOff();
        if (this$totalWrittenOff == null ? other$totalWrittenOff != null : !this$totalWrittenOff.equals(other$totalWrittenOff)) return false;
        final java.lang.Object this$totalOutstanding = this.getTotalOutstanding();
        final java.lang.Object other$totalOutstanding = other.getTotalOutstanding();
        if (this$totalOutstanding == null ? other$totalOutstanding != null : !this$totalOutstanding.equals(other$totalOutstanding)) return false;
        final java.lang.Object this$totalOverdue = this.getTotalOverdue();
        final java.lang.Object other$totalOverdue = other.getTotalOverdue();
        if (this$totalOverdue == null ? other$totalOverdue != null : !this$totalOverdue.equals(other$totalOverdue)) return false;
        final java.lang.Object this$totalRecovered = this.getTotalRecovered();
        final java.lang.Object other$totalRecovered = other.getTotalRecovered();
        if (this$totalRecovered == null ? other$totalRecovered != null : !this$totalRecovered.equals(other$totalRecovered)) return false;
        final java.lang.Object this$overdueSinceDate = this.getOverdueSinceDate();
        final java.lang.Object other$overdueSinceDate = other.getOverdueSinceDate();
        if (this$overdueSinceDate == null ? other$overdueSinceDate != null : !this$overdueSinceDate.equals(other$overdueSinceDate)) return false;
        final java.lang.Object this$writeoffReason = this.getWriteoffReason();
        final java.lang.Object other$writeoffReason = other.getWriteoffReason();
        if (this$writeoffReason == null ? other$writeoffReason != null : !this$writeoffReason.equals(other$writeoffReason)) return false;
        final java.lang.Object this$totalMerchantRefund = this.getTotalMerchantRefund();
        final java.lang.Object other$totalMerchantRefund = other.getTotalMerchantRefund();
        if (this$totalMerchantRefund == null ? other$totalMerchantRefund != null : !this$totalMerchantRefund.equals(other$totalMerchantRefund)) return false;
        final java.lang.Object this$totalMerchantRefundReversed = this.getTotalMerchantRefundReversed();
        final java.lang.Object other$totalMerchantRefundReversed = other.getTotalMerchantRefundReversed();
        if (this$totalMerchantRefundReversed == null ? other$totalMerchantRefundReversed != null : !this$totalMerchantRefundReversed.equals(other$totalMerchantRefundReversed)) return false;
        final java.lang.Object this$totalPayoutRefund = this.getTotalPayoutRefund();
        final java.lang.Object other$totalPayoutRefund = other.getTotalPayoutRefund();
        if (this$totalPayoutRefund == null ? other$totalPayoutRefund != null : !this$totalPayoutRefund.equals(other$totalPayoutRefund)) return false;
        final java.lang.Object this$totalPayoutRefundReversed = this.getTotalPayoutRefundReversed();
        final java.lang.Object other$totalPayoutRefundReversed = other.getTotalPayoutRefundReversed();
        if (this$totalPayoutRefundReversed == null ? other$totalPayoutRefundReversed != null : !this$totalPayoutRefundReversed.equals(other$totalPayoutRefundReversed)) return false;
        final java.lang.Object this$totalGoodwillCredit = this.getTotalGoodwillCredit();
        final java.lang.Object other$totalGoodwillCredit = other.getTotalGoodwillCredit();
        if (this$totalGoodwillCredit == null ? other$totalGoodwillCredit != null : !this$totalGoodwillCredit.equals(other$totalGoodwillCredit)) return false;
        final java.lang.Object this$totalGoodwillCreditReversed = this.getTotalGoodwillCreditReversed();
        final java.lang.Object other$totalGoodwillCreditReversed = other.getTotalGoodwillCreditReversed();
        if (this$totalGoodwillCreditReversed == null ? other$totalGoodwillCreditReversed != null : !this$totalGoodwillCreditReversed.equals(other$totalGoodwillCreditReversed)) return false;
        final java.lang.Object this$totalChargeAdjustment = this.getTotalChargeAdjustment();
        final java.lang.Object other$totalChargeAdjustment = other.getTotalChargeAdjustment();
        if (this$totalChargeAdjustment == null ? other$totalChargeAdjustment != null : !this$totalChargeAdjustment.equals(other$totalChargeAdjustment)) return false;
        final java.lang.Object this$totalChargeAdjustmentReversed = this.getTotalChargeAdjustmentReversed();
        final java.lang.Object other$totalChargeAdjustmentReversed = other.getTotalChargeAdjustmentReversed();
        if (this$totalChargeAdjustmentReversed == null ? other$totalChargeAdjustmentReversed != null : !this$totalChargeAdjustmentReversed.equals(other$totalChargeAdjustmentReversed)) return false;
        final java.lang.Object this$totalChargeback = this.getTotalChargeback();
        final java.lang.Object other$totalChargeback = other.getTotalChargeback();
        if (this$totalChargeback == null ? other$totalChargeback != null : !this$totalChargeback.equals(other$totalChargeback)) return false;
        final java.lang.Object this$totalCreditBalanceRefund = this.getTotalCreditBalanceRefund();
        final java.lang.Object other$totalCreditBalanceRefund = other.getTotalCreditBalanceRefund();
        if (this$totalCreditBalanceRefund == null ? other$totalCreditBalanceRefund != null : !this$totalCreditBalanceRefund.equals(other$totalCreditBalanceRefund)) return false;
        final java.lang.Object this$totalCreditBalanceRefundReversed = this.getTotalCreditBalanceRefundReversed();
        final java.lang.Object other$totalCreditBalanceRefundReversed = other.getTotalCreditBalanceRefundReversed();
        if (this$totalCreditBalanceRefundReversed == null ? other$totalCreditBalanceRefundReversed != null : !this$totalCreditBalanceRefundReversed.equals(other$totalCreditBalanceRefundReversed)) return false;
        final java.lang.Object this$totalRepaymentTransaction = this.getTotalRepaymentTransaction();
        final java.lang.Object other$totalRepaymentTransaction = other.getTotalRepaymentTransaction();
        if (this$totalRepaymentTransaction == null ? other$totalRepaymentTransaction != null : !this$totalRepaymentTransaction.equals(other$totalRepaymentTransaction)) return false;
        final java.lang.Object this$totalRepaymentTransactionReversed = this.getTotalRepaymentTransactionReversed();
        final java.lang.Object other$totalRepaymentTransactionReversed = other.getTotalRepaymentTransactionReversed();
        if (this$totalRepaymentTransactionReversed == null ? other$totalRepaymentTransactionReversed != null : !this$totalRepaymentTransactionReversed.equals(other$totalRepaymentTransactionReversed)) return false;
        final java.lang.Object this$totalInterestPaymentWaiver = this.getTotalInterestPaymentWaiver();
        final java.lang.Object other$totalInterestPaymentWaiver = other.getTotalInterestPaymentWaiver();
        if (this$totalInterestPaymentWaiver == null ? other$totalInterestPaymentWaiver != null : !this$totalInterestPaymentWaiver.equals(other$totalInterestPaymentWaiver)) return false;
        final java.lang.Object this$totalInterestRefund = this.getTotalInterestRefund();
        final java.lang.Object other$totalInterestRefund = other.getTotalInterestRefund();
        if (this$totalInterestRefund == null ? other$totalInterestRefund != null : !this$totalInterestRefund.equals(other$totalInterestRefund)) return false;
        final java.lang.Object this$chargeOffReason = this.getChargeOffReason();
        final java.lang.Object other$chargeOffReason = other.getChargeOffReason();
        if (this$chargeOffReason == null ? other$chargeOffReason != null : !this$chargeOffReason.equals(other$chargeOffReason)) return false;
        final java.lang.Object this$totalUnpaidPayableDueInterest = this.getTotalUnpaidPayableDueInterest();
        final java.lang.Object other$totalUnpaidPayableDueInterest = other.getTotalUnpaidPayableDueInterest();
        if (this$totalUnpaidPayableDueInterest == null ? other$totalUnpaidPayableDueInterest != null : !this$totalUnpaidPayableDueInterest.equals(other$totalUnpaidPayableDueInterest)) return false;
        final java.lang.Object this$totalUnpaidPayableNotDueInterest = this.getTotalUnpaidPayableNotDueInterest();
        final java.lang.Object other$totalUnpaidPayableNotDueInterest = other.getTotalUnpaidPayableNotDueInterest();
        if (this$totalUnpaidPayableNotDueInterest == null ? other$totalUnpaidPayableNotDueInterest != null : !this$totalUnpaidPayableNotDueInterest.equals(other$totalUnpaidPayableNotDueInterest)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanSummaryData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $writeoffReasonId = this.getWriteoffReasonId();
        result = result * PRIME + ($writeoffReasonId == null ? 43 : $writeoffReasonId.hashCode());
        final java.lang.Object $chargeOffReasonId = this.getChargeOffReasonId();
        result = result * PRIME + ($chargeOffReasonId == null ? 43 : $chargeOffReasonId.hashCode());
        final java.lang.Object $currency = this.getCurrency();
        result = result * PRIME + ($currency == null ? 43 : $currency.hashCode());
        final java.lang.Object $totalPrincipal = this.getTotalPrincipal();
        result = result * PRIME + ($totalPrincipal == null ? 43 : $totalPrincipal.hashCode());
        final java.lang.Object $totalCapitalizedIncome = this.getTotalCapitalizedIncome();
        result = result * PRIME + ($totalCapitalizedIncome == null ? 43 : $totalCapitalizedIncome.hashCode());
        final java.lang.Object $totalCapitalizedIncomeAdjustment = this.getTotalCapitalizedIncomeAdjustment();
        result = result * PRIME + ($totalCapitalizedIncomeAdjustment == null ? 43 : $totalCapitalizedIncomeAdjustment.hashCode());
        final java.lang.Object $principalDisbursed = this.getPrincipalDisbursed();
        result = result * PRIME + ($principalDisbursed == null ? 43 : $principalDisbursed.hashCode());
        final java.lang.Object $principalAdjustments = this.getPrincipalAdjustments();
        result = result * PRIME + ($principalAdjustments == null ? 43 : $principalAdjustments.hashCode());
        final java.lang.Object $principalPaid = this.getPrincipalPaid();
        result = result * PRIME + ($principalPaid == null ? 43 : $principalPaid.hashCode());
        final java.lang.Object $principalWrittenOff = this.getPrincipalWrittenOff();
        result = result * PRIME + ($principalWrittenOff == null ? 43 : $principalWrittenOff.hashCode());
        final java.lang.Object $principalOutstanding = this.getPrincipalOutstanding();
        result = result * PRIME + ($principalOutstanding == null ? 43 : $principalOutstanding.hashCode());
        final java.lang.Object $principalOverdue = this.getPrincipalOverdue();
        result = result * PRIME + ($principalOverdue == null ? 43 : $principalOverdue.hashCode());
        final java.lang.Object $interestCharged = this.getInterestCharged();
        result = result * PRIME + ($interestCharged == null ? 43 : $interestCharged.hashCode());
        final java.lang.Object $interestPaid = this.getInterestPaid();
        result = result * PRIME + ($interestPaid == null ? 43 : $interestPaid.hashCode());
        final java.lang.Object $interestWaived = this.getInterestWaived();
        result = result * PRIME + ($interestWaived == null ? 43 : $interestWaived.hashCode());
        final java.lang.Object $interestWrittenOff = this.getInterestWrittenOff();
        result = result * PRIME + ($interestWrittenOff == null ? 43 : $interestWrittenOff.hashCode());
        final java.lang.Object $interestOutstanding = this.getInterestOutstanding();
        result = result * PRIME + ($interestOutstanding == null ? 43 : $interestOutstanding.hashCode());
        final java.lang.Object $interestOverdue = this.getInterestOverdue();
        result = result * PRIME + ($interestOverdue == null ? 43 : $interestOverdue.hashCode());
        final java.lang.Object $feeChargesCharged = this.getFeeChargesCharged();
        result = result * PRIME + ($feeChargesCharged == null ? 43 : $feeChargesCharged.hashCode());
        final java.lang.Object $feeAdjustments = this.getFeeAdjustments();
        result = result * PRIME + ($feeAdjustments == null ? 43 : $feeAdjustments.hashCode());
        final java.lang.Object $feeChargesDueAtDisbursementCharged = this.getFeeChargesDueAtDisbursementCharged();
        result = result * PRIME + ($feeChargesDueAtDisbursementCharged == null ? 43 : $feeChargesDueAtDisbursementCharged.hashCode());
        final java.lang.Object $feeChargesPaid = this.getFeeChargesPaid();
        result = result * PRIME + ($feeChargesPaid == null ? 43 : $feeChargesPaid.hashCode());
        final java.lang.Object $feeChargesWaived = this.getFeeChargesWaived();
        result = result * PRIME + ($feeChargesWaived == null ? 43 : $feeChargesWaived.hashCode());
        final java.lang.Object $feeChargesWrittenOff = this.getFeeChargesWrittenOff();
        result = result * PRIME + ($feeChargesWrittenOff == null ? 43 : $feeChargesWrittenOff.hashCode());
        final java.lang.Object $feeChargesOutstanding = this.getFeeChargesOutstanding();
        result = result * PRIME + ($feeChargesOutstanding == null ? 43 : $feeChargesOutstanding.hashCode());
        final java.lang.Object $feeChargesOverdue = this.getFeeChargesOverdue();
        result = result * PRIME + ($feeChargesOverdue == null ? 43 : $feeChargesOverdue.hashCode());
        final java.lang.Object $penaltyChargesCharged = this.getPenaltyChargesCharged();
        result = result * PRIME + ($penaltyChargesCharged == null ? 43 : $penaltyChargesCharged.hashCode());
        final java.lang.Object $penaltyAdjustments = this.getPenaltyAdjustments();
        result = result * PRIME + ($penaltyAdjustments == null ? 43 : $penaltyAdjustments.hashCode());
        final java.lang.Object $penaltyChargesPaid = this.getPenaltyChargesPaid();
        result = result * PRIME + ($penaltyChargesPaid == null ? 43 : $penaltyChargesPaid.hashCode());
        final java.lang.Object $penaltyChargesWaived = this.getPenaltyChargesWaived();
        result = result * PRIME + ($penaltyChargesWaived == null ? 43 : $penaltyChargesWaived.hashCode());
        final java.lang.Object $penaltyChargesWrittenOff = this.getPenaltyChargesWrittenOff();
        result = result * PRIME + ($penaltyChargesWrittenOff == null ? 43 : $penaltyChargesWrittenOff.hashCode());
        final java.lang.Object $penaltyChargesOutstanding = this.getPenaltyChargesOutstanding();
        result = result * PRIME + ($penaltyChargesOutstanding == null ? 43 : $penaltyChargesOutstanding.hashCode());
        final java.lang.Object $penaltyChargesOverdue = this.getPenaltyChargesOverdue();
        result = result * PRIME + ($penaltyChargesOverdue == null ? 43 : $penaltyChargesOverdue.hashCode());
        final java.lang.Object $totalExpectedRepayment = this.getTotalExpectedRepayment();
        result = result * PRIME + ($totalExpectedRepayment == null ? 43 : $totalExpectedRepayment.hashCode());
        final java.lang.Object $totalRepayment = this.getTotalRepayment();
        result = result * PRIME + ($totalRepayment == null ? 43 : $totalRepayment.hashCode());
        final java.lang.Object $totalExpectedCostOfLoan = this.getTotalExpectedCostOfLoan();
        result = result * PRIME + ($totalExpectedCostOfLoan == null ? 43 : $totalExpectedCostOfLoan.hashCode());
        final java.lang.Object $totalCostOfLoan = this.getTotalCostOfLoan();
        result = result * PRIME + ($totalCostOfLoan == null ? 43 : $totalCostOfLoan.hashCode());
        final java.lang.Object $totalWaived = this.getTotalWaived();
        result = result * PRIME + ($totalWaived == null ? 43 : $totalWaived.hashCode());
        final java.lang.Object $totalWrittenOff = this.getTotalWrittenOff();
        result = result * PRIME + ($totalWrittenOff == null ? 43 : $totalWrittenOff.hashCode());
        final java.lang.Object $totalOutstanding = this.getTotalOutstanding();
        result = result * PRIME + ($totalOutstanding == null ? 43 : $totalOutstanding.hashCode());
        final java.lang.Object $totalOverdue = this.getTotalOverdue();
        result = result * PRIME + ($totalOverdue == null ? 43 : $totalOverdue.hashCode());
        final java.lang.Object $totalRecovered = this.getTotalRecovered();
        result = result * PRIME + ($totalRecovered == null ? 43 : $totalRecovered.hashCode());
        final java.lang.Object $overdueSinceDate = this.getOverdueSinceDate();
        result = result * PRIME + ($overdueSinceDate == null ? 43 : $overdueSinceDate.hashCode());
        final java.lang.Object $writeoffReason = this.getWriteoffReason();
        result = result * PRIME + ($writeoffReason == null ? 43 : $writeoffReason.hashCode());
        final java.lang.Object $totalMerchantRefund = this.getTotalMerchantRefund();
        result = result * PRIME + ($totalMerchantRefund == null ? 43 : $totalMerchantRefund.hashCode());
        final java.lang.Object $totalMerchantRefundReversed = this.getTotalMerchantRefundReversed();
        result = result * PRIME + ($totalMerchantRefundReversed == null ? 43 : $totalMerchantRefundReversed.hashCode());
        final java.lang.Object $totalPayoutRefund = this.getTotalPayoutRefund();
        result = result * PRIME + ($totalPayoutRefund == null ? 43 : $totalPayoutRefund.hashCode());
        final java.lang.Object $totalPayoutRefundReversed = this.getTotalPayoutRefundReversed();
        result = result * PRIME + ($totalPayoutRefundReversed == null ? 43 : $totalPayoutRefundReversed.hashCode());
        final java.lang.Object $totalGoodwillCredit = this.getTotalGoodwillCredit();
        result = result * PRIME + ($totalGoodwillCredit == null ? 43 : $totalGoodwillCredit.hashCode());
        final java.lang.Object $totalGoodwillCreditReversed = this.getTotalGoodwillCreditReversed();
        result = result * PRIME + ($totalGoodwillCreditReversed == null ? 43 : $totalGoodwillCreditReversed.hashCode());
        final java.lang.Object $totalChargeAdjustment = this.getTotalChargeAdjustment();
        result = result * PRIME + ($totalChargeAdjustment == null ? 43 : $totalChargeAdjustment.hashCode());
        final java.lang.Object $totalChargeAdjustmentReversed = this.getTotalChargeAdjustmentReversed();
        result = result * PRIME + ($totalChargeAdjustmentReversed == null ? 43 : $totalChargeAdjustmentReversed.hashCode());
        final java.lang.Object $totalChargeback = this.getTotalChargeback();
        result = result * PRIME + ($totalChargeback == null ? 43 : $totalChargeback.hashCode());
        final java.lang.Object $totalCreditBalanceRefund = this.getTotalCreditBalanceRefund();
        result = result * PRIME + ($totalCreditBalanceRefund == null ? 43 : $totalCreditBalanceRefund.hashCode());
        final java.lang.Object $totalCreditBalanceRefundReversed = this.getTotalCreditBalanceRefundReversed();
        result = result * PRIME + ($totalCreditBalanceRefundReversed == null ? 43 : $totalCreditBalanceRefundReversed.hashCode());
        final java.lang.Object $totalRepaymentTransaction = this.getTotalRepaymentTransaction();
        result = result * PRIME + ($totalRepaymentTransaction == null ? 43 : $totalRepaymentTransaction.hashCode());
        final java.lang.Object $totalRepaymentTransactionReversed = this.getTotalRepaymentTransactionReversed();
        result = result * PRIME + ($totalRepaymentTransactionReversed == null ? 43 : $totalRepaymentTransactionReversed.hashCode());
        final java.lang.Object $totalInterestPaymentWaiver = this.getTotalInterestPaymentWaiver();
        result = result * PRIME + ($totalInterestPaymentWaiver == null ? 43 : $totalInterestPaymentWaiver.hashCode());
        final java.lang.Object $totalInterestRefund = this.getTotalInterestRefund();
        result = result * PRIME + ($totalInterestRefund == null ? 43 : $totalInterestRefund.hashCode());
        final java.lang.Object $chargeOffReason = this.getChargeOffReason();
        result = result * PRIME + ($chargeOffReason == null ? 43 : $chargeOffReason.hashCode());
        final java.lang.Object $totalUnpaidPayableDueInterest = this.getTotalUnpaidPayableDueInterest();
        result = result * PRIME + ($totalUnpaidPayableDueInterest == null ? 43 : $totalUnpaidPayableDueInterest.hashCode());
        final java.lang.Object $totalUnpaidPayableNotDueInterest = this.getTotalUnpaidPayableNotDueInterest();
        result = result * PRIME + ($totalUnpaidPayableNotDueInterest == null ? 43 : $totalUnpaidPayableNotDueInterest.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanSummaryData(currency=" + this.getCurrency() + ", totalPrincipal=" + this.getTotalPrincipal() + ", totalCapitalizedIncome=" + this.getTotalCapitalizedIncome() + ", totalCapitalizedIncomeAdjustment=" + this.getTotalCapitalizedIncomeAdjustment() + ", principalDisbursed=" + this.getPrincipalDisbursed() + ", principalAdjustments=" + this.getPrincipalAdjustments() + ", principalPaid=" + this.getPrincipalPaid() + ", principalWrittenOff=" + this.getPrincipalWrittenOff() + ", principalOutstanding=" + this.getPrincipalOutstanding() + ", principalOverdue=" + this.getPrincipalOverdue() + ", interestCharged=" + this.getInterestCharged() + ", interestPaid=" + this.getInterestPaid() + ", interestWaived=" + this.getInterestWaived() + ", interestWrittenOff=" + this.getInterestWrittenOff() + ", interestOutstanding=" + this.getInterestOutstanding() + ", interestOverdue=" + this.getInterestOverdue() + ", feeChargesCharged=" + this.getFeeChargesCharged() + ", feeAdjustments=" + this.getFeeAdjustments() + ", feeChargesDueAtDisbursementCharged=" + this.getFeeChargesDueAtDisbursementCharged() + ", feeChargesPaid=" + this.getFeeChargesPaid() + ", feeChargesWaived=" + this.getFeeChargesWaived() + ", feeChargesWrittenOff=" + this.getFeeChargesWrittenOff() + ", feeChargesOutstanding=" + this.getFeeChargesOutstanding() + ", feeChargesOverdue=" + this.getFeeChargesOverdue() + ", penaltyChargesCharged=" + this.getPenaltyChargesCharged() + ", penaltyAdjustments=" + this.getPenaltyAdjustments() + ", penaltyChargesPaid=" + this.getPenaltyChargesPaid() + ", penaltyChargesWaived=" + this.getPenaltyChargesWaived() + ", penaltyChargesWrittenOff=" + this.getPenaltyChargesWrittenOff() + ", penaltyChargesOutstanding=" + this.getPenaltyChargesOutstanding() + ", penaltyChargesOverdue=" + this.getPenaltyChargesOverdue() + ", totalExpectedRepayment=" + this.getTotalExpectedRepayment() + ", totalRepayment=" + this.getTotalRepayment() + ", totalExpectedCostOfLoan=" + this.getTotalExpectedCostOfLoan() + ", totalCostOfLoan=" + this.getTotalCostOfLoan() + ", totalWaived=" + this.getTotalWaived() + ", totalWrittenOff=" + this.getTotalWrittenOff() + ", totalOutstanding=" + this.getTotalOutstanding() + ", totalOverdue=" + this.getTotalOverdue() + ", totalRecovered=" + this.getTotalRecovered() + ", overdueSinceDate=" + this.getOverdueSinceDate() + ", writeoffReasonId=" + this.getWriteoffReasonId() + ", writeoffReason=" + this.getWriteoffReason() + ", totalMerchantRefund=" + this.getTotalMerchantRefund() + ", totalMerchantRefundReversed=" + this.getTotalMerchantRefundReversed() + ", totalPayoutRefund=" + this.getTotalPayoutRefund() + ", totalPayoutRefundReversed=" + this.getTotalPayoutRefundReversed() + ", totalGoodwillCredit=" + this.getTotalGoodwillCredit() + ", totalGoodwillCreditReversed=" + this.getTotalGoodwillCreditReversed() + ", totalChargeAdjustment=" + this.getTotalChargeAdjustment() + ", totalChargeAdjustmentReversed=" + this.getTotalChargeAdjustmentReversed() + ", totalChargeback=" + this.getTotalChargeback() + ", totalCreditBalanceRefund=" + this.getTotalCreditBalanceRefund() + ", totalCreditBalanceRefundReversed=" + this.getTotalCreditBalanceRefundReversed() + ", totalRepaymentTransaction=" + this.getTotalRepaymentTransaction() + ", totalRepaymentTransactionReversed=" + this.getTotalRepaymentTransactionReversed() + ", totalInterestPaymentWaiver=" + this.getTotalInterestPaymentWaiver() + ", totalInterestRefund=" + this.getTotalInterestRefund() + ", chargeOffReasonId=" + this.getChargeOffReasonId() + ", chargeOffReason=" + this.getChargeOffReason() + ", totalUnpaidPayableDueInterest=" + this.getTotalUnpaidPayableDueInterest() + ", totalUnpaidPayableNotDueInterest=" + this.getTotalUnpaidPayableNotDueInterest() + ")";
    }
}
