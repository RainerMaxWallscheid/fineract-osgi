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
package org.apache.fineract.portfolio.loanaccount.progressiveloan.loanschedule.data;

import java.math.BigDecimal;
import java.time.LocalDate;

public final class LoanSchedulePlanRepaymentPeriod implements LoanSchedulePlanPeriod {
    private final int periodNumber;
    private final LocalDate periodFromDate;
    private final LocalDate periodDueDate;
    private final BigDecimal principalAmount;
    private final BigDecimal interestAmount;
    private final BigDecimal feeAmount;
    private final BigDecimal penaltyAmount;
    private final BigDecimal totalDueAmount;
    private final BigDecimal outstandingLoanBalance;
    private final BigDecimal totalOutstandingLoanBalance;

    @Override
    public Integer periodNumber() {
        return periodNumber;
    }

    @Override
    public LocalDate periodFromDate() {
        return periodFromDate;
    }

    @Override
    public LocalDate periodDueDate() {
        return periodDueDate;
    }

    @java.lang.SuppressWarnings("all")
        public LoanSchedulePlanRepaymentPeriod(final int periodNumber, final LocalDate periodFromDate, final LocalDate periodDueDate, final BigDecimal principalAmount, final BigDecimal interestAmount, final BigDecimal feeAmount, final BigDecimal penaltyAmount, final BigDecimal totalDueAmount, final BigDecimal outstandingLoanBalance, final BigDecimal totalOutstandingLoanBalance) {
        this.periodNumber = periodNumber;
        this.periodFromDate = periodFromDate;
        this.periodDueDate = periodDueDate;
        this.principalAmount = principalAmount;
        this.interestAmount = interestAmount;
        this.feeAmount = feeAmount;
        this.penaltyAmount = penaltyAmount;
        this.totalDueAmount = totalDueAmount;
        this.outstandingLoanBalance = outstandingLoanBalance;
        this.totalOutstandingLoanBalance = totalOutstandingLoanBalance;
    }

    @java.lang.SuppressWarnings("all")
        public int getPeriodNumber() {
        return this.periodNumber;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getPeriodFromDate() {
        return this.periodFromDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getPeriodDueDate() {
        return this.periodDueDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalAmount() {
        return this.principalAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestAmount() {
        return this.interestAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeAmount() {
        return this.feeAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyAmount() {
        return this.penaltyAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalDueAmount() {
        return this.totalDueAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOutstandingLoanBalance() {
        return this.outstandingLoanBalance;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalOutstandingLoanBalance() {
        return this.totalOutstandingLoanBalance;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanSchedulePlanRepaymentPeriod)) return false;
        final LoanSchedulePlanRepaymentPeriod other = (LoanSchedulePlanRepaymentPeriod) o;
        if (this.getPeriodNumber() != other.getPeriodNumber()) return false;
        final java.lang.Object this$periodFromDate = this.getPeriodFromDate();
        final java.lang.Object other$periodFromDate = other.getPeriodFromDate();
        if (this$periodFromDate == null ? other$periodFromDate != null : !this$periodFromDate.equals(other$periodFromDate)) return false;
        final java.lang.Object this$periodDueDate = this.getPeriodDueDate();
        final java.lang.Object other$periodDueDate = other.getPeriodDueDate();
        if (this$periodDueDate == null ? other$periodDueDate != null : !this$periodDueDate.equals(other$periodDueDate)) return false;
        final java.lang.Object this$principalAmount = this.getPrincipalAmount();
        final java.lang.Object other$principalAmount = other.getPrincipalAmount();
        if (this$principalAmount == null ? other$principalAmount != null : !this$principalAmount.equals(other$principalAmount)) return false;
        final java.lang.Object this$interestAmount = this.getInterestAmount();
        final java.lang.Object other$interestAmount = other.getInterestAmount();
        if (this$interestAmount == null ? other$interestAmount != null : !this$interestAmount.equals(other$interestAmount)) return false;
        final java.lang.Object this$feeAmount = this.getFeeAmount();
        final java.lang.Object other$feeAmount = other.getFeeAmount();
        if (this$feeAmount == null ? other$feeAmount != null : !this$feeAmount.equals(other$feeAmount)) return false;
        final java.lang.Object this$penaltyAmount = this.getPenaltyAmount();
        final java.lang.Object other$penaltyAmount = other.getPenaltyAmount();
        if (this$penaltyAmount == null ? other$penaltyAmount != null : !this$penaltyAmount.equals(other$penaltyAmount)) return false;
        final java.lang.Object this$totalDueAmount = this.getTotalDueAmount();
        final java.lang.Object other$totalDueAmount = other.getTotalDueAmount();
        if (this$totalDueAmount == null ? other$totalDueAmount != null : !this$totalDueAmount.equals(other$totalDueAmount)) return false;
        final java.lang.Object this$outstandingLoanBalance = this.getOutstandingLoanBalance();
        final java.lang.Object other$outstandingLoanBalance = other.getOutstandingLoanBalance();
        if (this$outstandingLoanBalance == null ? other$outstandingLoanBalance != null : !this$outstandingLoanBalance.equals(other$outstandingLoanBalance)) return false;
        final java.lang.Object this$totalOutstandingLoanBalance = this.getTotalOutstandingLoanBalance();
        final java.lang.Object other$totalOutstandingLoanBalance = other.getTotalOutstandingLoanBalance();
        if (this$totalOutstandingLoanBalance == null ? other$totalOutstandingLoanBalance != null : !this$totalOutstandingLoanBalance.equals(other$totalOutstandingLoanBalance)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + this.getPeriodNumber();
        final java.lang.Object $periodFromDate = this.getPeriodFromDate();
        result = result * PRIME + ($periodFromDate == null ? 43 : $periodFromDate.hashCode());
        final java.lang.Object $periodDueDate = this.getPeriodDueDate();
        result = result * PRIME + ($periodDueDate == null ? 43 : $periodDueDate.hashCode());
        final java.lang.Object $principalAmount = this.getPrincipalAmount();
        result = result * PRIME + ($principalAmount == null ? 43 : $principalAmount.hashCode());
        final java.lang.Object $interestAmount = this.getInterestAmount();
        result = result * PRIME + ($interestAmount == null ? 43 : $interestAmount.hashCode());
        final java.lang.Object $feeAmount = this.getFeeAmount();
        result = result * PRIME + ($feeAmount == null ? 43 : $feeAmount.hashCode());
        final java.lang.Object $penaltyAmount = this.getPenaltyAmount();
        result = result * PRIME + ($penaltyAmount == null ? 43 : $penaltyAmount.hashCode());
        final java.lang.Object $totalDueAmount = this.getTotalDueAmount();
        result = result * PRIME + ($totalDueAmount == null ? 43 : $totalDueAmount.hashCode());
        final java.lang.Object $outstandingLoanBalance = this.getOutstandingLoanBalance();
        result = result * PRIME + ($outstandingLoanBalance == null ? 43 : $outstandingLoanBalance.hashCode());
        final java.lang.Object $totalOutstandingLoanBalance = this.getTotalOutstandingLoanBalance();
        result = result * PRIME + ($totalOutstandingLoanBalance == null ? 43 : $totalOutstandingLoanBalance.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanSchedulePlanRepaymentPeriod(periodNumber=" + this.getPeriodNumber() + ", periodFromDate=" + this.getPeriodFromDate() + ", periodDueDate=" + this.getPeriodDueDate() + ", principalAmount=" + this.getPrincipalAmount() + ", interestAmount=" + this.getInterestAmount() + ", feeAmount=" + this.getFeeAmount() + ", penaltyAmount=" + this.getPenaltyAmount() + ", totalDueAmount=" + this.getTotalDueAmount() + ", outstandingLoanBalance=" + this.getOutstandingLoanBalance() + ", totalOutstandingLoanBalance=" + this.getTotalOutstandingLoanBalance() + ")";
    }
}
