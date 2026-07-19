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
package org.apache.fineract.portfolio.loanaccount.loanschedule.data;

import java.math.BigDecimal;
import java.math.MathContext;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.core.service.MathUtil;
import org.apache.fineract.organisation.monetary.domain.MoneyHelper;

/**
 * Immutable data object that represents a period of a loan schedule.
 */
public final class LoanSchedulePeriodData {
    private final Integer period;
    private final LocalDate fromDate;
    private final LocalDate dueDate;
    private final LocalDate obligationsMetOnDate;
    private final Boolean complete;
    private final Integer daysInPeriod;
    private final BigDecimal principalDisbursed;
    private final BigDecimal principalOriginalDue;
    private final BigDecimal principalDue;
    private final BigDecimal principalPaid;
    private final BigDecimal principalWrittenOff;
    private final BigDecimal principalOutstanding;
    private final BigDecimal principalLoanBalanceOutstanding;
    private final BigDecimal interestOriginalDue;
    private final BigDecimal interestDue;
    private final BigDecimal interestPaid;
    private final BigDecimal interestWaived;
    private final BigDecimal interestWrittenOff;
    private final BigDecimal interestOutstanding;
    private final BigDecimal feeChargesDue;
    private final BigDecimal feeChargesPaid;
    private final BigDecimal feeChargesWaived;
    private final BigDecimal feeChargesWrittenOff;
    private final BigDecimal feeChargesOutstanding;
    private final BigDecimal penaltyChargesDue;
    private final BigDecimal penaltyChargesPaid;
    private final BigDecimal penaltyChargesWaived;
    private final BigDecimal penaltyChargesWrittenOff;
    private final BigDecimal penaltyChargesOutstanding;
    private final BigDecimal totalOriginalDueForPeriod;
    private final BigDecimal totalDueForPeriod;
    private final BigDecimal totalPaidForPeriod;
    private final BigDecimal totalPaidInAdvanceForPeriod;
    private final BigDecimal totalPaidLateForPeriod;
    private final BigDecimal totalWaivedForPeriod;
    private final BigDecimal totalWrittenOffForPeriod;
    private final BigDecimal totalOutstandingForPeriod;
    private final BigDecimal totalOverdue;
    private final BigDecimal totalActualCostOfLoanForPeriod;
    private final BigDecimal totalInstallmentAmountForPeriod;
    private final BigDecimal totalCredits;
    private final BigDecimal totalAccruedInterest;
    private final boolean downPaymentPeriod;

    public static LoanSchedulePeriodData disbursementOnlyPeriod(final LocalDate disbursementDate, final BigDecimal principalDisbursed, final BigDecimal feeChargesDueAtTimeOfDisbursement, final boolean isDisbursed) {
        return  //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        builder().dueDate(disbursementDate).principalDisbursed(principalDisbursed).principalLoanBalanceOutstanding(principalDisbursed).feeChargesDue(feeChargesDueAtTimeOfDisbursement).feeChargesPaid(isDisbursed ? feeChargesDueAtTimeOfDisbursement : null).feeChargesOutstanding(isDisbursed ? null : feeChargesDueAtTimeOfDisbursement).totalOriginalDueForPeriod(feeChargesDueAtTimeOfDisbursement).totalDueForPeriod(feeChargesDueAtTimeOfDisbursement).totalPaidForPeriod(isDisbursed ? feeChargesDueAtTimeOfDisbursement : null).totalOutstandingForPeriod(isDisbursed ? null : feeChargesDueAtTimeOfDisbursement).totalActualCostOfLoanForPeriod(feeChargesDueAtTimeOfDisbursement).totalOverdue(DateUtils.isBeforeBusinessDate(disbursementDate) && !isDisbursed ? feeChargesDueAtTimeOfDisbursement : null).build();
    }

    public static LoanSchedulePeriodData repaymentOnlyPeriod(final Integer periodNumber, final LocalDate fromDate, final LocalDate dueDate, final BigDecimal principalDue, final BigDecimal outstandingLoanBalance, final BigDecimal interestDue, final BigDecimal feeDue, final BigDecimal penaltyDue) {
        BigDecimal totalDue = MathUtil.add(principalDue, interestDue, feeDue, penaltyDue);
        BigDecimal totalActualCostOfLoanForPeriod = MathUtil.add(interestDue, feeDue, penaltyDue);
        BigDecimal totalInstallmentAmount = MathUtil.add(principalDue, interestDue);
        return  //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        builder().period(periodNumber).fromDate(fromDate).dueDate(dueDate).daysInPeriod(DateUtils.getExactDifferenceInDays(fromDate, dueDate)).principalDue(principalDue).principalOriginalDue(principalDue).principalOutstanding(principalDue).principalLoanBalanceOutstanding(outstandingLoanBalance).interestDue(interestDue).interestOriginalDue(interestDue).interestOutstanding(interestDue).feeChargesDue(feeDue).feeChargesOutstanding(feeDue).penaltyChargesDue(penaltyDue).penaltyChargesOutstanding(penaltyDue).totalOriginalDueForPeriod(totalDue).totalDueForPeriod(totalDue).totalOutstandingForPeriod(totalDue).totalActualCostOfLoanForPeriod(totalActualCostOfLoanForPeriod).totalInstallmentAmountForPeriod(totalInstallmentAmount).totalOverdue(DateUtils.isBeforeBusinessDate(dueDate) ? totalDue : null).build();
    }

    public static LoanSchedulePeriodData downPaymentOnlyPeriod(final Integer periodNumber, final LocalDate periodDate, final BigDecimal principalDue, final BigDecimal outstandingLoanBalance) {
        return  //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        builder().period(periodNumber).fromDate(periodDate).dueDate(periodDate).principalOriginalDue(principalDue).principalDue(principalDue).principalOutstanding(principalDue).principalLoanBalanceOutstanding(outstandingLoanBalance).totalOriginalDueForPeriod(principalDue).totalDueForPeriod(principalDue).totalOutstandingForPeriod(principalDue).totalInstallmentAmountForPeriod(principalDue).downPaymentPeriod(true).totalOverdue(DateUtils.isBeforeBusinessDate(periodDate) ? principalDue : null).build();
    }

    public static LoanSchedulePeriodData periodWithPayments(final Integer periodNumber, final LocalDate fromDate, final LocalDate dueDate, final LocalDate obligationsMetOnDate, final boolean complete, final BigDecimal principalOriginalDue, final BigDecimal principalPaid, final BigDecimal principalWrittenOff, final BigDecimal principalOutstanding, final BigDecimal outstandingPrincipalBalanceOfLoan, final BigDecimal interestDue, final BigDecimal interestPaid, final BigDecimal interestWaived, final BigDecimal interestWrittenOff, final BigDecimal interestOutstanding, final BigDecimal feeChargesDue, final BigDecimal feeChargesPaid, final BigDecimal feeChargesWaived, final BigDecimal feeChargesWrittenOff, final BigDecimal feeChargesOutstanding, final BigDecimal penaltyChargesDue, final BigDecimal penaltyChargesPaid, final BigDecimal penaltyChargesWaived, final BigDecimal penaltyChargesWrittenOff, final BigDecimal penaltyChargesOutstanding, final BigDecimal totalPaid, final BigDecimal totalPaidInAdvanceForPeriod, final BigDecimal totalPaidLateForPeriod, final BigDecimal totalWaived, final BigDecimal totalWrittenOff, final BigDecimal totalCredits, final boolean isDownPayment, final BigDecimal totalAccruedInterest) {
        final MathContext mc = MoneyHelper.getMathContext();
        BigDecimal totalDue = MathUtil.add(mc, principalOriginalDue, interestDue, feeChargesDue, penaltyChargesDue);
        BigDecimal totalOutstanding = MathUtil.add(mc, principalOutstanding, interestOutstanding, feeChargesOutstanding, penaltyChargesOutstanding);
        BigDecimal totalActualCostOfLoanForPeriod = MathUtil.add(mc, interestDue, feeChargesDue, penaltyChargesDue);
        BigDecimal totalInstallmentAmount = MathUtil.add(mc, principalOriginalDue, interestDue);
        return  //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        builder().period(periodNumber).fromDate(fromDate).dueDate(dueDate).obligationsMetOnDate(obligationsMetOnDate).complete(complete).daysInPeriod(DateUtils.getExactDifferenceInDays(fromDate, dueDate)).principalDue(principalOriginalDue).principalOriginalDue(principalOriginalDue).principalPaid(principalPaid).principalWrittenOff(principalWrittenOff).principalOutstanding(principalOutstanding).principalLoanBalanceOutstanding(outstandingPrincipalBalanceOfLoan).interestDue(interestDue).interestOriginalDue(interestDue).interestPaid(interestPaid).interestWaived(interestWaived).interestWrittenOff(interestWrittenOff).interestOutstanding(interestOutstanding).feeChargesDue(feeChargesDue).feeChargesPaid(feeChargesPaid).feeChargesWaived(feeChargesWaived).feeChargesWrittenOff(feeChargesWrittenOff).feeChargesOutstanding(feeChargesOutstanding).penaltyChargesDue(penaltyChargesDue).penaltyChargesPaid(penaltyChargesPaid).penaltyChargesWaived(penaltyChargesWaived).penaltyChargesWrittenOff(penaltyChargesWrittenOff).penaltyChargesOutstanding(penaltyChargesOutstanding).totalOriginalDueForPeriod(totalDue).totalDueForPeriod(totalDue).totalPaidForPeriod(totalPaid).totalPaidInAdvanceForPeriod(totalPaidInAdvanceForPeriod).totalPaidLateForPeriod(totalPaidLateForPeriod).totalWaivedForPeriod(totalWaived).totalWrittenOffForPeriod(totalWrittenOff).totalOutstandingForPeriod(totalOutstanding).totalActualCostOfLoanForPeriod(totalActualCostOfLoanForPeriod).totalInstallmentAmountForPeriod(totalInstallmentAmount).totalOverdue(DateUtils.isBeforeBusinessDate(dueDate) ? totalOutstanding : null).totalCredits(totalCredits).downPaymentPeriod(isDownPayment).totalAccruedInterest(totalAccruedInterest).build();
    }

    public static LoanSchedulePeriodData withPaidDetail(final LoanSchedulePeriodData loanSchedulePeriodData, final boolean complete, final BigDecimal principalPaid, final BigDecimal interestPaid, final BigDecimal feeChargesPaid, final BigDecimal penaltyChargesPaid) {
        BigDecimal totalOutstanding = MathUtil.subtract(loanSchedulePeriodData.totalDueForPeriod, principalPaid, interestPaid, feeChargesPaid, penaltyChargesPaid);
        return  //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        builder().period(loanSchedulePeriodData.period).fromDate(loanSchedulePeriodData.fromDate).dueDate(loanSchedulePeriodData.dueDate).obligationsMetOnDate(loanSchedulePeriodData.obligationsMetOnDate).complete(complete).daysInPeriod(DateUtils.getExactDifferenceInDays(loanSchedulePeriodData.fromDate, loanSchedulePeriodData.dueDate)).principalDue(loanSchedulePeriodData.principalOriginalDue).principalOriginalDue(loanSchedulePeriodData.principalOriginalDue).principalPaid(principalPaid).principalWrittenOff(loanSchedulePeriodData.principalWrittenOff).principalOutstanding(MathUtil.subtract(loanSchedulePeriodData.principalOriginalDue, principalPaid)).principalLoanBalanceOutstanding(loanSchedulePeriodData.principalLoanBalanceOutstanding).interestDue(loanSchedulePeriodData.interestDue).interestOriginalDue(loanSchedulePeriodData.interestDue).interestPaid(interestPaid).interestWaived(loanSchedulePeriodData.interestWaived).interestWrittenOff(loanSchedulePeriodData.interestWrittenOff).interestOutstanding(MathUtil.subtract(loanSchedulePeriodData.interestDue, interestPaid)).feeChargesDue(loanSchedulePeriodData.feeChargesDue).feeChargesPaid(feeChargesPaid).feeChargesWaived(loanSchedulePeriodData.feeChargesWaived).feeChargesWrittenOff(loanSchedulePeriodData.feeChargesWrittenOff).feeChargesOutstanding(MathUtil.subtract(loanSchedulePeriodData.feeChargesDue, feeChargesPaid)).penaltyChargesDue(loanSchedulePeriodData.penaltyChargesDue).penaltyChargesPaid(penaltyChargesPaid).penaltyChargesWaived(loanSchedulePeriodData.penaltyChargesWaived).penaltyChargesWrittenOff(loanSchedulePeriodData.penaltyChargesWrittenOff).penaltyChargesOutstanding(MathUtil.subtract(loanSchedulePeriodData.penaltyChargesDue, penaltyChargesPaid)).totalOriginalDueForPeriod(loanSchedulePeriodData.totalDueForPeriod).totalDueForPeriod(loanSchedulePeriodData.totalDueForPeriod).totalPaidForPeriod(MathUtil.add(principalPaid, interestPaid, feeChargesPaid, penaltyChargesPaid)).totalPaidInAdvanceForPeriod(loanSchedulePeriodData.totalPaidInAdvanceForPeriod).totalPaidLateForPeriod(loanSchedulePeriodData.totalPaidLateForPeriod).totalWaivedForPeriod(loanSchedulePeriodData.totalWaivedForPeriod).totalWrittenOffForPeriod(loanSchedulePeriodData.totalWrittenOffForPeriod).totalOutstandingForPeriod(totalOutstanding).totalActualCostOfLoanForPeriod(loanSchedulePeriodData.totalActualCostOfLoanForPeriod).totalInstallmentAmountForPeriod(loanSchedulePeriodData.totalInstallmentAmountForPeriod).totalOverdue(DateUtils.isBeforeBusinessDate(loanSchedulePeriodData.dueDate) ? totalOutstanding : null).totalCredits(loanSchedulePeriodData.totalCredits).downPaymentPeriod(loanSchedulePeriodData.isDownPaymentPeriod()).totalAccruedInterest(loanSchedulePeriodData.totalAccruedInterest).build();
    }

    public BigDecimal getPrincipalDisbursed() {
        return MathUtil.nullToDefault(this.principalDisbursed, BigDecimal.ZERO);
    }

    public BigDecimal getPrincipalDue() {
        return MathUtil.nullToDefault(this.principalDue, BigDecimal.ZERO);
    }

    public BigDecimal getPrincipalPaid() {
        return MathUtil.nullToDefault(this.principalPaid, BigDecimal.ZERO);
    }

    public BigDecimal getPrincipalWrittenOff() {
        return MathUtil.nullToDefault(this.principalWrittenOff, BigDecimal.ZERO);
    }

    public BigDecimal getPrincipalOutstanding() {
        return MathUtil.nullToDefault(this.principalOutstanding, BigDecimal.ZERO);
    }

    public BigDecimal getInterestDue() {
        return MathUtil.nullToDefault(this.interestDue, BigDecimal.ZERO);
    }

    public BigDecimal getInterestPaid() {
        return MathUtil.nullToDefault(this.interestPaid, BigDecimal.ZERO);
    }

    public BigDecimal getInterestWaived() {
        return MathUtil.nullToDefault(this.interestWaived, BigDecimal.ZERO);
    }

    public BigDecimal getInterestWrittenOff() {
        return MathUtil.nullToDefault(this.interestWrittenOff, BigDecimal.ZERO);
    }

    public BigDecimal getInterestOutstanding() {
        return MathUtil.nullToDefault(this.interestOutstanding, BigDecimal.ZERO);
    }

    public BigDecimal getFeeChargesDue() {
        return MathUtil.nullToDefault(this.feeChargesDue, BigDecimal.ZERO);
    }

    public BigDecimal getFeeChargesWaived() {
        return MathUtil.nullToDefault(this.feeChargesWaived, BigDecimal.ZERO);
    }

    public BigDecimal getFeeChargesWrittenOff() {
        return MathUtil.nullToDefault(this.feeChargesWrittenOff, BigDecimal.ZERO);
    }

    public BigDecimal getFeeChargesPaid() {
        return MathUtil.nullToDefault(this.feeChargesPaid, BigDecimal.ZERO);
    }

    public BigDecimal getFeeChargesOutstanding() {
        return MathUtil.nullToDefault(this.feeChargesOutstanding, BigDecimal.ZERO);
    }

    public BigDecimal getPenaltyChargesDue() {
        return MathUtil.nullToDefault(this.penaltyChargesDue, BigDecimal.ZERO);
    }

    public BigDecimal getPenaltyChargesWaived() {
        return MathUtil.nullToDefault(this.penaltyChargesWaived, BigDecimal.ZERO);
    }

    public BigDecimal getPenaltyChargesWrittenOff() {
        return MathUtil.nullToDefault(this.penaltyChargesWrittenOff, BigDecimal.ZERO);
    }

    public BigDecimal getPenaltyChargesPaid() {
        return MathUtil.nullToDefault(this.penaltyChargesPaid, BigDecimal.ZERO);
    }

    public BigDecimal getPenaltyChargesOutstanding() {
        return MathUtil.nullToDefault(this.penaltyChargesOutstanding, BigDecimal.ZERO);
    }

    public BigDecimal getTotalOverdue() {
        return MathUtil.nullToDefault(this.totalOverdue, BigDecimal.ZERO);
    }

    public BigDecimal totalOutstandingForPeriod() {
        return MathUtil.nullToDefault(this.totalOutstandingForPeriod, BigDecimal.ZERO);
    }

    @java.lang.SuppressWarnings("all")
        LoanSchedulePeriodData(final Integer period, final LocalDate fromDate, final LocalDate dueDate, final LocalDate obligationsMetOnDate, final Boolean complete, final Integer daysInPeriod, final BigDecimal principalDisbursed, final BigDecimal principalOriginalDue, final BigDecimal principalDue, final BigDecimal principalPaid, final BigDecimal principalWrittenOff, final BigDecimal principalOutstanding, final BigDecimal principalLoanBalanceOutstanding, final BigDecimal interestOriginalDue, final BigDecimal interestDue, final BigDecimal interestPaid, final BigDecimal interestWaived, final BigDecimal interestWrittenOff, final BigDecimal interestOutstanding, final BigDecimal feeChargesDue, final BigDecimal feeChargesPaid, final BigDecimal feeChargesWaived, final BigDecimal feeChargesWrittenOff, final BigDecimal feeChargesOutstanding, final BigDecimal penaltyChargesDue, final BigDecimal penaltyChargesPaid, final BigDecimal penaltyChargesWaived, final BigDecimal penaltyChargesWrittenOff, final BigDecimal penaltyChargesOutstanding, final BigDecimal totalOriginalDueForPeriod, final BigDecimal totalDueForPeriod, final BigDecimal totalPaidForPeriod, final BigDecimal totalPaidInAdvanceForPeriod, final BigDecimal totalPaidLateForPeriod, final BigDecimal totalWaivedForPeriod, final BigDecimal totalWrittenOffForPeriod, final BigDecimal totalOutstandingForPeriod, final BigDecimal totalOverdue, final BigDecimal totalActualCostOfLoanForPeriod, final BigDecimal totalInstallmentAmountForPeriod, final BigDecimal totalCredits, final BigDecimal totalAccruedInterest, final boolean downPaymentPeriod) {
        this.period = period;
        this.fromDate = fromDate;
        this.dueDate = dueDate;
        this.obligationsMetOnDate = obligationsMetOnDate;
        this.complete = complete;
        this.daysInPeriod = daysInPeriod;
        this.principalDisbursed = principalDisbursed;
        this.principalOriginalDue = principalOriginalDue;
        this.principalDue = principalDue;
        this.principalPaid = principalPaid;
        this.principalWrittenOff = principalWrittenOff;
        this.principalOutstanding = principalOutstanding;
        this.principalLoanBalanceOutstanding = principalLoanBalanceOutstanding;
        this.interestOriginalDue = interestOriginalDue;
        this.interestDue = interestDue;
        this.interestPaid = interestPaid;
        this.interestWaived = interestWaived;
        this.interestWrittenOff = interestWrittenOff;
        this.interestOutstanding = interestOutstanding;
        this.feeChargesDue = feeChargesDue;
        this.feeChargesPaid = feeChargesPaid;
        this.feeChargesWaived = feeChargesWaived;
        this.feeChargesWrittenOff = feeChargesWrittenOff;
        this.feeChargesOutstanding = feeChargesOutstanding;
        this.penaltyChargesDue = penaltyChargesDue;
        this.penaltyChargesPaid = penaltyChargesPaid;
        this.penaltyChargesWaived = penaltyChargesWaived;
        this.penaltyChargesWrittenOff = penaltyChargesWrittenOff;
        this.penaltyChargesOutstanding = penaltyChargesOutstanding;
        this.totalOriginalDueForPeriod = totalOriginalDueForPeriod;
        this.totalDueForPeriod = totalDueForPeriod;
        this.totalPaidForPeriod = totalPaidForPeriod;
        this.totalPaidInAdvanceForPeriod = totalPaidInAdvanceForPeriod;
        this.totalPaidLateForPeriod = totalPaidLateForPeriod;
        this.totalWaivedForPeriod = totalWaivedForPeriod;
        this.totalWrittenOffForPeriod = totalWrittenOffForPeriod;
        this.totalOutstandingForPeriod = totalOutstandingForPeriod;
        this.totalOverdue = totalOverdue;
        this.totalActualCostOfLoanForPeriod = totalActualCostOfLoanForPeriod;
        this.totalInstallmentAmountForPeriod = totalInstallmentAmountForPeriod;
        this.totalCredits = totalCredits;
        this.totalAccruedInterest = totalAccruedInterest;
        this.downPaymentPeriod = downPaymentPeriod;
    }


    @java.lang.SuppressWarnings("all")
        public static class LoanSchedulePeriodDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Integer period;
        @java.lang.SuppressWarnings("all")
                private LocalDate fromDate;
        @java.lang.SuppressWarnings("all")
                private LocalDate dueDate;
        @java.lang.SuppressWarnings("all")
                private LocalDate obligationsMetOnDate;
        @java.lang.SuppressWarnings("all")
                private Boolean complete;
        @java.lang.SuppressWarnings("all")
                private Integer daysInPeriod;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalDisbursed;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalOriginalDue;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalDue;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalPaid;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalWrittenOff;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalOutstanding;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalLoanBalanceOutstanding;
        @java.lang.SuppressWarnings("all")
                private BigDecimal interestOriginalDue;
        @java.lang.SuppressWarnings("all")
                private BigDecimal interestDue;
        @java.lang.SuppressWarnings("all")
                private BigDecimal interestPaid;
        @java.lang.SuppressWarnings("all")
                private BigDecimal interestWaived;
        @java.lang.SuppressWarnings("all")
                private BigDecimal interestWrittenOff;
        @java.lang.SuppressWarnings("all")
                private BigDecimal interestOutstanding;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feeChargesDue;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feeChargesPaid;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feeChargesWaived;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feeChargesWrittenOff;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feeChargesOutstanding;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penaltyChargesDue;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penaltyChargesPaid;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penaltyChargesWaived;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penaltyChargesWrittenOff;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penaltyChargesOutstanding;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalOriginalDueForPeriod;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalDueForPeriod;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalPaidForPeriod;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalPaidInAdvanceForPeriod;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalPaidLateForPeriod;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalWaivedForPeriod;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalWrittenOffForPeriod;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalOutstandingForPeriod;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalOverdue;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalActualCostOfLoanForPeriod;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalInstallmentAmountForPeriod;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalCredits;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalAccruedInterest;
        @java.lang.SuppressWarnings("all")
                private boolean downPaymentPeriod;

        @java.lang.SuppressWarnings("all")
                LoanSchedulePeriodDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder period(final Integer period) {
            this.period = period;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder fromDate(final LocalDate fromDate) {
            this.fromDate = fromDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder dueDate(final LocalDate dueDate) {
            this.dueDate = dueDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder obligationsMetOnDate(final LocalDate obligationsMetOnDate) {
            this.obligationsMetOnDate = obligationsMetOnDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder complete(final Boolean complete) {
            this.complete = complete;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder daysInPeriod(final Integer daysInPeriod) {
            this.daysInPeriod = daysInPeriod;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder principalDisbursed(final BigDecimal principalDisbursed) {
            this.principalDisbursed = principalDisbursed;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder principalOriginalDue(final BigDecimal principalOriginalDue) {
            this.principalOriginalDue = principalOriginalDue;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder principalDue(final BigDecimal principalDue) {
            this.principalDue = principalDue;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder principalPaid(final BigDecimal principalPaid) {
            this.principalPaid = principalPaid;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder principalWrittenOff(final BigDecimal principalWrittenOff) {
            this.principalWrittenOff = principalWrittenOff;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder principalOutstanding(final BigDecimal principalOutstanding) {
            this.principalOutstanding = principalOutstanding;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder principalLoanBalanceOutstanding(final BigDecimal principalLoanBalanceOutstanding) {
            this.principalLoanBalanceOutstanding = principalLoanBalanceOutstanding;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder interestOriginalDue(final BigDecimal interestOriginalDue) {
            this.interestOriginalDue = interestOriginalDue;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder interestDue(final BigDecimal interestDue) {
            this.interestDue = interestDue;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder interestPaid(final BigDecimal interestPaid) {
            this.interestPaid = interestPaid;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder interestWaived(final BigDecimal interestWaived) {
            this.interestWaived = interestWaived;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder interestWrittenOff(final BigDecimal interestWrittenOff) {
            this.interestWrittenOff = interestWrittenOff;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder interestOutstanding(final BigDecimal interestOutstanding) {
            this.interestOutstanding = interestOutstanding;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder feeChargesDue(final BigDecimal feeChargesDue) {
            this.feeChargesDue = feeChargesDue;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder feeChargesPaid(final BigDecimal feeChargesPaid) {
            this.feeChargesPaid = feeChargesPaid;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder feeChargesWaived(final BigDecimal feeChargesWaived) {
            this.feeChargesWaived = feeChargesWaived;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder feeChargesWrittenOff(final BigDecimal feeChargesWrittenOff) {
            this.feeChargesWrittenOff = feeChargesWrittenOff;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder feeChargesOutstanding(final BigDecimal feeChargesOutstanding) {
            this.feeChargesOutstanding = feeChargesOutstanding;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder penaltyChargesDue(final BigDecimal penaltyChargesDue) {
            this.penaltyChargesDue = penaltyChargesDue;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder penaltyChargesPaid(final BigDecimal penaltyChargesPaid) {
            this.penaltyChargesPaid = penaltyChargesPaid;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder penaltyChargesWaived(final BigDecimal penaltyChargesWaived) {
            this.penaltyChargesWaived = penaltyChargesWaived;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder penaltyChargesWrittenOff(final BigDecimal penaltyChargesWrittenOff) {
            this.penaltyChargesWrittenOff = penaltyChargesWrittenOff;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder penaltyChargesOutstanding(final BigDecimal penaltyChargesOutstanding) {
            this.penaltyChargesOutstanding = penaltyChargesOutstanding;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder totalOriginalDueForPeriod(final BigDecimal totalOriginalDueForPeriod) {
            this.totalOriginalDueForPeriod = totalOriginalDueForPeriod;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder totalDueForPeriod(final BigDecimal totalDueForPeriod) {
            this.totalDueForPeriod = totalDueForPeriod;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder totalPaidForPeriod(final BigDecimal totalPaidForPeriod) {
            this.totalPaidForPeriod = totalPaidForPeriod;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder totalPaidInAdvanceForPeriod(final BigDecimal totalPaidInAdvanceForPeriod) {
            this.totalPaidInAdvanceForPeriod = totalPaidInAdvanceForPeriod;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder totalPaidLateForPeriod(final BigDecimal totalPaidLateForPeriod) {
            this.totalPaidLateForPeriod = totalPaidLateForPeriod;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder totalWaivedForPeriod(final BigDecimal totalWaivedForPeriod) {
            this.totalWaivedForPeriod = totalWaivedForPeriod;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder totalWrittenOffForPeriod(final BigDecimal totalWrittenOffForPeriod) {
            this.totalWrittenOffForPeriod = totalWrittenOffForPeriod;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder totalOutstandingForPeriod(final BigDecimal totalOutstandingForPeriod) {
            this.totalOutstandingForPeriod = totalOutstandingForPeriod;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder totalOverdue(final BigDecimal totalOverdue) {
            this.totalOverdue = totalOverdue;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder totalActualCostOfLoanForPeriod(final BigDecimal totalActualCostOfLoanForPeriod) {
            this.totalActualCostOfLoanForPeriod = totalActualCostOfLoanForPeriod;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder totalInstallmentAmountForPeriod(final BigDecimal totalInstallmentAmountForPeriod) {
            this.totalInstallmentAmountForPeriod = totalInstallmentAmountForPeriod;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder totalCredits(final BigDecimal totalCredits) {
            this.totalCredits = totalCredits;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder totalAccruedInterest(final BigDecimal totalAccruedInterest) {
            this.totalAccruedInterest = totalAccruedInterest;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder downPaymentPeriod(final boolean downPaymentPeriod) {
            this.downPaymentPeriod = downPaymentPeriod;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public LoanSchedulePeriodData build() {
            return new LoanSchedulePeriodData(this.period, this.fromDate, this.dueDate, this.obligationsMetOnDate, this.complete, this.daysInPeriod, this.principalDisbursed, this.principalOriginalDue, this.principalDue, this.principalPaid, this.principalWrittenOff, this.principalOutstanding, this.principalLoanBalanceOutstanding, this.interestOriginalDue, this.interestDue, this.interestPaid, this.interestWaived, this.interestWrittenOff, this.interestOutstanding, this.feeChargesDue, this.feeChargesPaid, this.feeChargesWaived, this.feeChargesWrittenOff, this.feeChargesOutstanding, this.penaltyChargesDue, this.penaltyChargesPaid, this.penaltyChargesWaived, this.penaltyChargesWrittenOff, this.penaltyChargesOutstanding, this.totalOriginalDueForPeriod, this.totalDueForPeriod, this.totalPaidForPeriod, this.totalPaidInAdvanceForPeriod, this.totalPaidLateForPeriod, this.totalWaivedForPeriod, this.totalWrittenOffForPeriod, this.totalOutstandingForPeriod, this.totalOverdue, this.totalActualCostOfLoanForPeriod, this.totalInstallmentAmountForPeriod, this.totalCredits, this.totalAccruedInterest, this.downPaymentPeriod);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder(period=" + this.period + ", fromDate=" + this.fromDate + ", dueDate=" + this.dueDate + ", obligationsMetOnDate=" + this.obligationsMetOnDate + ", complete=" + this.complete + ", daysInPeriod=" + this.daysInPeriod + ", principalDisbursed=" + this.principalDisbursed + ", principalOriginalDue=" + this.principalOriginalDue + ", principalDue=" + this.principalDue + ", principalPaid=" + this.principalPaid + ", principalWrittenOff=" + this.principalWrittenOff + ", principalOutstanding=" + this.principalOutstanding + ", principalLoanBalanceOutstanding=" + this.principalLoanBalanceOutstanding + ", interestOriginalDue=" + this.interestOriginalDue + ", interestDue=" + this.interestDue + ", interestPaid=" + this.interestPaid + ", interestWaived=" + this.interestWaived + ", interestWrittenOff=" + this.interestWrittenOff + ", interestOutstanding=" + this.interestOutstanding + ", feeChargesDue=" + this.feeChargesDue + ", feeChargesPaid=" + this.feeChargesPaid + ", feeChargesWaived=" + this.feeChargesWaived + ", feeChargesWrittenOff=" + this.feeChargesWrittenOff + ", feeChargesOutstanding=" + this.feeChargesOutstanding + ", penaltyChargesDue=" + this.penaltyChargesDue + ", penaltyChargesPaid=" + this.penaltyChargesPaid + ", penaltyChargesWaived=" + this.penaltyChargesWaived + ", penaltyChargesWrittenOff=" + this.penaltyChargesWrittenOff + ", penaltyChargesOutstanding=" + this.penaltyChargesOutstanding + ", totalOriginalDueForPeriod=" + this.totalOriginalDueForPeriod + ", totalDueForPeriod=" + this.totalDueForPeriod + ", totalPaidForPeriod=" + this.totalPaidForPeriod + ", totalPaidInAdvanceForPeriod=" + this.totalPaidInAdvanceForPeriod + ", totalPaidLateForPeriod=" + this.totalPaidLateForPeriod + ", totalWaivedForPeriod=" + this.totalWaivedForPeriod + ", totalWrittenOffForPeriod=" + this.totalWrittenOffForPeriod + ", totalOutstandingForPeriod=" + this.totalOutstandingForPeriod + ", totalOverdue=" + this.totalOverdue + ", totalActualCostOfLoanForPeriod=" + this.totalActualCostOfLoanForPeriod + ", totalInstallmentAmountForPeriod=" + this.totalInstallmentAmountForPeriod + ", totalCredits=" + this.totalCredits + ", totalAccruedInterest=" + this.totalAccruedInterest + ", downPaymentPeriod=" + this.downPaymentPeriod + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder builder() {
        return new LoanSchedulePeriodData.LoanSchedulePeriodDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Integer getPeriod() {
        return this.period;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getFromDate() {
        return this.fromDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDueDate() {
        return this.dueDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getObligationsMetOnDate() {
        return this.obligationsMetOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getComplete() {
        return this.complete;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getDaysInPeriod() {
        return this.daysInPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalOriginalDue() {
        return this.principalOriginalDue;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalLoanBalanceOutstanding() {
        return this.principalLoanBalanceOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestOriginalDue() {
        return this.interestOriginalDue;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalOriginalDueForPeriod() {
        return this.totalOriginalDueForPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalDueForPeriod() {
        return this.totalDueForPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalPaidForPeriod() {
        return this.totalPaidForPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalPaidInAdvanceForPeriod() {
        return this.totalPaidInAdvanceForPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalPaidLateForPeriod() {
        return this.totalPaidLateForPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalWaivedForPeriod() {
        return this.totalWaivedForPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalWrittenOffForPeriod() {
        return this.totalWrittenOffForPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalOutstandingForPeriod() {
        return this.totalOutstandingForPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalActualCostOfLoanForPeriod() {
        return this.totalActualCostOfLoanForPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalInstallmentAmountForPeriod() {
        return this.totalInstallmentAmountForPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalCredits() {
        return this.totalCredits;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalAccruedInterest() {
        return this.totalAccruedInterest;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isDownPaymentPeriod() {
        return this.downPaymentPeriod;
    }
}
