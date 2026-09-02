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
package org.apache.fineract.portfolio.loanaccount.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Collection;
import java.util.Optional;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.portfolio.loanaccount.data.LoanSummaryData;
import org.apache.fineract.portfolio.loanaccount.data.LoanTransactionBalanceView;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransactionType;
import org.apache.fineract.portfolio.loanaccount.loanschedule.data.LoanScheduleData;
import org.apache.fineract.portfolio.loanaccount.loanschedule.data.LoanSchedulePeriodData;

public abstract class CommonLoanSummaryDataProvider implements LoanSummaryDataProvider {

    @Override
    public LoanSummaryData withTransactionAmountsSummary(Loan loan, LoanSummaryData defaultSummaryData, LoanScheduleData repaymentSchedule,
            Collection<? extends LoanTransactionBalanceView> loanTransactionBalances) {
        final LocalDate businessDate = DateUtils.getBusinessLocalDate();

        BigDecimal totalMerchantRefund = BigDecimal.ZERO;
        BigDecimal totalMerchantRefundReversed = BigDecimal.ZERO;
        BigDecimal totalPayoutRefund = BigDecimal.ZERO;
        BigDecimal totalPayoutRefundReversed = BigDecimal.ZERO;
        BigDecimal totalGoodwillCredit = BigDecimal.ZERO;
        BigDecimal totalGoodwillCreditReversed = BigDecimal.ZERO;
        BigDecimal totalChargeAdjustment = BigDecimal.ZERO;
        BigDecimal totalChargeAdjustmentReversed = BigDecimal.ZERO;
        BigDecimal totalChargeback = BigDecimal.ZERO;
        BigDecimal totalCreditBalanceRefund = BigDecimal.ZERO;
        BigDecimal totalCreditBalanceRefundReversed = BigDecimal.ZERO;
        BigDecimal totalRepaymentTransaction = BigDecimal.ZERO;
        BigDecimal totalRepaymentTransactionReversed = BigDecimal.ZERO;
        BigDecimal totalInterestPaymentWaiver = BigDecimal.ZERO;
        BigDecimal totalInterestRefund = BigDecimal.ZERO;
        BigDecimal totalUnpaidPayableDueInterest = BigDecimal.ZERO;
        BigDecimal totalUnpaidPayableNotDueInterest = BigDecimal.ZERO;

        totalChargeAdjustment = fetchLoanTransactionBalanceViewByType(loanTransactionBalances, LoanTransactionType.CHARGE_ADJUSTMENT);
        totalChargeAdjustmentReversed = fetchLoanTransactionBalanceViewReversedByType(loanTransactionBalances,
                LoanTransactionType.CHARGE_ADJUSTMENT);

        totalChargeback = fetchLoanTransactionBalanceViewByType(loanTransactionBalances, LoanTransactionType.CHARGEBACK);

        totalCreditBalanceRefund = fetchLoanTransactionBalanceViewByType(loanTransactionBalances,
                LoanTransactionType.CREDIT_BALANCE_REFUND);
        totalCreditBalanceRefundReversed = fetchLoanTransactionBalanceViewReversedByType(loanTransactionBalances,
                LoanTransactionType.CREDIT_BALANCE_REFUND);

        totalGoodwillCredit = fetchLoanTransactionBalanceViewByType(loanTransactionBalances, LoanTransactionType.GOODWILL_CREDIT);
        totalGoodwillCreditReversed = fetchLoanTransactionBalanceViewReversedByType(loanTransactionBalances,
                LoanTransactionType.GOODWILL_CREDIT);

        totalInterestRefund = fetchLoanTransactionBalanceViewByType(loanTransactionBalances, LoanTransactionType.INTEREST_REFUND);

        totalInterestPaymentWaiver = fetchLoanTransactionBalanceViewByType(loanTransactionBalances,
                LoanTransactionType.INTEREST_PAYMENT_WAIVER);

        totalMerchantRefund = fetchLoanTransactionBalanceViewByType(loanTransactionBalances, LoanTransactionType.MERCHANT_ISSUED_REFUND);
        totalMerchantRefundReversed = fetchLoanTransactionBalanceViewReversedByType(loanTransactionBalances,
                LoanTransactionType.MERCHANT_ISSUED_REFUND);

        totalPayoutRefund = fetchLoanTransactionBalanceViewByType(loanTransactionBalances, LoanTransactionType.PAYOUT_REFUND);
        totalPayoutRefundReversed = fetchLoanTransactionBalanceViewReversedByType(loanTransactionBalances,
                LoanTransactionType.PAYOUT_REFUND);

        totalRepaymentTransaction = fetchLoanTransactionBalanceViewByType(loanTransactionBalances, LoanTransactionType.REPAYMENT)
                .add(fetchLoanTransactionBalanceViewByType(loanTransactionBalances, LoanTransactionType.DOWN_PAYMENT));
        totalRepaymentTransactionReversed = fetchLoanTransactionBalanceViewReversedByType(loanTransactionBalances,
                LoanTransactionType.REPAYMENT);

        if (repaymentSchedule != null && defaultSummaryData.getInterestCharged().compareTo(BigDecimal.ZERO) > 0) {
            // Outstanding Interest on Past due installments
            totalUnpaidPayableDueInterest = computeTotalUnpaidPayableDueInterestAmount(repaymentSchedule.getPeriods(), businessDate);

            // Accumulated daily interest of the current Installment period
            totalUnpaidPayableNotDueInterest = computeTotalUnpaidPayableNotDueInterestAmountOnActualPeriod(loan,
                    repaymentSchedule.getPeriods(), businessDate, defaultSummaryData.getCurrency(), totalUnpaidPayableDueInterest);
        }

        return LoanSummaryData.builder().currency(defaultSummaryData.getCurrency())
                .principalDisbursed(defaultSummaryData.getPrincipalDisbursed()).totalPrincipal(defaultSummaryData.getTotalPrincipal())
                .totalCapitalizedIncome(defaultSummaryData.getTotalCapitalizedIncome())
                .totalCapitalizedIncomeAdjustment(defaultSummaryData.getTotalCapitalizedIncomeAdjustment())
                .principalAdjustments(defaultSummaryData.getPrincipalAdjustments()).principalPaid(defaultSummaryData.getPrincipalPaid())
                .principalWrittenOff(defaultSummaryData.getPrincipalWrittenOff())
                .principalOutstanding(defaultSummaryData.getPrincipalOutstanding())
                .principalOverdue(defaultSummaryData.getPrincipalOverdue()).interestCharged(defaultSummaryData.getInterestCharged())
                .interestPaid(defaultSummaryData.getInterestPaid()).interestWaived(defaultSummaryData.getInterestWaived())
                .interestWrittenOff(defaultSummaryData.getInterestWrittenOff())
                .interestOutstanding(defaultSummaryData.getInterestOutstanding()).interestOverdue(defaultSummaryData.getInterestOverdue())
                .feeChargesCharged(defaultSummaryData.getFeeChargesCharged()).feeAdjustments(defaultSummaryData.getFeeAdjustments())
                .feeChargesDueAtDisbursementCharged(defaultSummaryData.getFeeChargesDueAtDisbursementCharged())
                .feeChargesPaid(defaultSummaryData.getFeeChargesPaid()).feeChargesWaived(defaultSummaryData.getFeeChargesWaived())
                .feeChargesWrittenOff(defaultSummaryData.getFeeChargesWrittenOff())
                .feeChargesOutstanding(defaultSummaryData.getFeeChargesOutstanding())
                .feeChargesOverdue(defaultSummaryData.getFeeChargesOverdue())
                .penaltyChargesCharged(defaultSummaryData.getPenaltyChargesCharged())
                .penaltyAdjustments(defaultSummaryData.getPenaltyAdjustments())
                .penaltyChargesPaid(defaultSummaryData.getPenaltyChargesPaid())
                .penaltyChargesWaived(defaultSummaryData.getPenaltyChargesWaived())
                .penaltyChargesWrittenOff(defaultSummaryData.getPenaltyChargesWrittenOff())
                .penaltyChargesOutstanding(defaultSummaryData.getPenaltyChargesOutstanding())
                .penaltyChargesOverdue(defaultSummaryData.getPenaltyChargesOverdue())
                .totalExpectedRepayment(defaultSummaryData.getTotalExpectedRepayment())
                .totalRepayment(defaultSummaryData.getTotalRepayment())
                .totalExpectedCostOfLoan(defaultSummaryData.getTotalExpectedCostOfLoan())
                .totalCostOfLoan(defaultSummaryData.getTotalCostOfLoan()).totalWaived(defaultSummaryData.getTotalWaived())
                .totalWrittenOff(defaultSummaryData.getTotalWrittenOff()).totalOutstanding(defaultSummaryData.getTotalOutstanding())
                .totalOverdue(defaultSummaryData.getTotalOverdue()).overdueSinceDate(defaultSummaryData.getOverdueSinceDate())
                .writeoffReasonId(defaultSummaryData.getWriteoffReasonId()).writeoffReason(defaultSummaryData.getWriteoffReason())
                .totalRecovered(defaultSummaryData.getTotalRecovered()).chargeOffReasonId(defaultSummaryData.getChargeOffReasonId())
                .chargeOffReason(defaultSummaryData.getChargeOffReason()).totalMerchantRefund(totalMerchantRefund)
                .totalMerchantRefundReversed(totalMerchantRefundReversed).totalPayoutRefund(totalPayoutRefund)
                .totalPayoutRefundReversed(totalPayoutRefundReversed).totalGoodwillCredit(totalGoodwillCredit)
                .totalGoodwillCreditReversed(totalGoodwillCreditReversed).totalChargeAdjustment(totalChargeAdjustment)
                .totalChargeAdjustmentReversed(totalChargeAdjustmentReversed).totalChargeback(totalChargeback)
                .totalCreditBalanceRefund(totalCreditBalanceRefund).totalCreditBalanceRefundReversed(totalCreditBalanceRefundReversed)
                .totalRepaymentTransaction(totalRepaymentTransaction).totalRepaymentTransactionReversed(totalRepaymentTransactionReversed)
                .totalInterestPaymentWaiver(totalInterestPaymentWaiver).totalUnpaidPayableDueInterest(totalUnpaidPayableDueInterest)
                .totalUnpaidPayableNotDueInterest(totalUnpaidPayableNotDueInterest).totalInterestRefund(totalInterestRefund).build();
    }

    private static BigDecimal fetchLoanTransactionBalanceViewByType(
            final Collection<? extends LoanTransactionBalanceView> loanTransactionBalances, final LoanTransactionType transactionType) {
        final Optional<? extends LoanTransactionBalanceView> optLoanTransactionBalanceView = loanTransactionBalances.stream()
                .filter(balance -> balance.getTransactionType().equals(transactionType) && !balance.isReversed()).findFirst();
        return optLoanTransactionBalanceView.isPresent() ? optLoanTransactionBalanceView.get().getAmount() : BigDecimal.ZERO;
    }

    private static BigDecimal fetchLoanTransactionBalanceViewReversedByType(
            final Collection<? extends LoanTransactionBalanceView> loanTransactionBalances, final LoanTransactionType transactionType) {
        final Optional<? extends LoanTransactionBalanceView> optLoanTransactionBalanceView = loanTransactionBalances.stream()
                .filter(balance -> balance.getTransactionType().equals(transactionType) && balance.isReversed()
                        && balance.isManuallyAdjustedOrReversed())
                .findFirst();
        return optLoanTransactionBalanceView.isPresent() ? optLoanTransactionBalanceView.get().getAmount() : BigDecimal.ZERO;
    }

    @Override
    public BigDecimal computeTotalUnpaidPayableDueInterestAmount(Collection<LoanSchedulePeriodData> periods, final LocalDate businessDate) {
        return periods.stream().filter(period -> !period.isDownPaymentPeriod() && !businessDate.isBefore(period.getDueDate()))
                .map(LoanSchedulePeriodData::getInterestOutstanding).reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    @Override
    public LoanSummaryData withOnlyCurrencyData(CurrencyData currencyData) {
        return LoanSummaryData.builder().currency(currencyData).build();
    }
}
