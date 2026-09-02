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
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.portfolio.loanaccount.loanschedule.data.LoanScheduleModelDownPaymentPeriod;
import org.apache.fineract.portfolio.loanaccount.loanschedule.domain.LoanScheduleModel;
import org.apache.fineract.portfolio.loanaccount.loanschedule.domain.LoanScheduleModelDisbursementPeriod;
import org.apache.fineract.portfolio.loanaccount.loanschedule.domain.LoanScheduleModelRepaymentPeriod;

public class LoanSchedulePlan {

    private final List<LoanSchedulePlanPeriod> periods;
    private final CurrencyData currency;
    private final int loanTermInDays;
    private final BigDecimal totalDisbursedAmount;
    private final BigDecimal totalPrincipalAmount;
    private final BigDecimal totalInterestAmount;
    private final BigDecimal totalFeeAmount;
    private final BigDecimal totalPenaltyAmount;
    private final BigDecimal totalRepaymentAmount;
    private final BigDecimal totalOutstandingAmount;

    public static LoanSchedulePlan from(LoanScheduleModel model) {
        List<LoanSchedulePlanPeriod> periods = new ArrayList<>();
        BigDecimal remainingTotalOutstanding = model.getTotalRepaymentExpected();
        AtomicReference<BigDecimal> remainingTotalOutstandingRef = new AtomicReference<>(remainingTotalOutstanding);
        model.getPeriods().forEach(periodModel -> {
            LoanSchedulePlanPeriod periodPlan = null;
            if (periodModel instanceof LoanScheduleModelDisbursementPeriod disbursementPeriod) {
                periodPlan = new LoanSchedulePlanDisbursementPeriod(disbursementPeriod.getDisbursementDate(), //
                        disbursementPeriod.getDisbursementDate(), //
                        disbursementPeriod.getPrincipalDisbursed().getAmount(), //
                        disbursementPeriod.getPrincipalDisbursed().getAmount());//
            } else if (periodModel instanceof LoanScheduleModelDownPaymentPeriod downPaymentPeriod) {
                remainingTotalOutstandingRef
                        .set(remainingTotalOutstandingRef.get().subtract(downPaymentPeriod.getPrincipalDue().getAmount()));
                periodPlan = new LoanSchedulePlanDownPaymentPeriod(downPaymentPeriod.getPeriodNumber(), //
                        downPaymentPeriod.getPeriodDate(), //
                        downPaymentPeriod.getPeriodDate(), //
                        downPaymentPeriod.getPrincipalDue().getAmount(), //
                        downPaymentPeriod.getPrincipalDue().getAmount(), //
                        downPaymentPeriod.getOutstandingLoanBalance().getAmount(), //
                        remainingTotalOutstandingRef.get());//
            } else if (periodModel instanceof LoanScheduleModelRepaymentPeriod repaymentPeriod) {
                remainingTotalOutstandingRef.set(remainingTotalOutstandingRef.get().subtract(repaymentPeriod.getTotalDue().getAmount()));
                periodPlan = new LoanSchedulePlanRepaymentPeriod(repaymentPeriod.getPeriodNumber(), //
                        repaymentPeriod.getFromDate(), //
                        repaymentPeriod.getDueDate(), //
                        repaymentPeriod.getPrincipalDue().getAmount(), //
                        repaymentPeriod.getInterestDue().getAmount(), //
                        repaymentPeriod.getFeeChargesDue().getAmount(), //
                        repaymentPeriod.getPenaltyChargesDue().getAmount(), //
                        repaymentPeriod.getTotalDue().getAmount(), //
                        repaymentPeriod.getOutstandingLoanBalance().getAmount(), //
                        remainingTotalOutstandingRef.get());//
            }
            if (periodPlan != null) {
                periods.add(periodPlan);
            }
        });
        return new LoanSchedulePlan(periods, //
                model.getCurrency(), //
                model.getLoanTermInDays(), //
                model.getTotalPrincipalDisbursed().getAmount(), //
                model.getTotalPrincipalExpected(), //
                model.getTotalInterestCharged(), //
                model.getTotalFeeChargesCharged(), //
                model.getTotalPenaltyChargesCharged(), //
                model.getTotalRepaymentExpected(), //
                model.getTotalOutstanding()//
        );
    }

    @java.lang.SuppressWarnings("all")
    public LoanSchedulePlan(final List<LoanSchedulePlanPeriod> periods, final CurrencyData currency, final int loanTermInDays,
            final BigDecimal totalDisbursedAmount, final BigDecimal totalPrincipalAmount, final BigDecimal totalInterestAmount,
            final BigDecimal totalFeeAmount, final BigDecimal totalPenaltyAmount, final BigDecimal totalRepaymentAmount,
            final BigDecimal totalOutstandingAmount) {
        this.periods = periods;
        this.currency = currency;
        this.loanTermInDays = loanTermInDays;
        this.totalDisbursedAmount = totalDisbursedAmount;
        this.totalPrincipalAmount = totalPrincipalAmount;
        this.totalInterestAmount = totalInterestAmount;
        this.totalFeeAmount = totalFeeAmount;
        this.totalPenaltyAmount = totalPenaltyAmount;
        this.totalRepaymentAmount = totalRepaymentAmount;
        this.totalOutstandingAmount = totalOutstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
    public List<LoanSchedulePlanPeriod> getPeriods() {
        return this.periods;
    }

    @java.lang.SuppressWarnings("all")
    public CurrencyData getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
    public int getLoanTermInDays() {
        return this.loanTermInDays;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getTotalDisbursedAmount() {
        return this.totalDisbursedAmount;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getTotalPrincipalAmount() {
        return this.totalPrincipalAmount;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getTotalInterestAmount() {
        return this.totalInterestAmount;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getTotalFeeAmount() {
        return this.totalFeeAmount;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getTotalPenaltyAmount() {
        return this.totalPenaltyAmount;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getTotalRepaymentAmount() {
        return this.totalRepaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getTotalOutstandingAmount() {
        return this.totalOutstandingAmount;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanSchedulePlan)) return false;
        final LoanSchedulePlan other = (LoanSchedulePlan) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.getLoanTermInDays() != other.getLoanTermInDays()) return false;
        final java.lang.Object this$periods = this.getPeriods();
        final java.lang.Object other$periods = other.getPeriods();
        if (this$periods == null ? other$periods != null : !this$periods.equals(other$periods)) return false;
        final java.lang.Object this$currency = this.getCurrency();
        final java.lang.Object other$currency = other.getCurrency();
        if (this$currency == null ? other$currency != null : !this$currency.equals(other$currency)) return false;
        final java.lang.Object this$totalDisbursedAmount = this.getTotalDisbursedAmount();
        final java.lang.Object other$totalDisbursedAmount = other.getTotalDisbursedAmount();
        if (this$totalDisbursedAmount == null ? other$totalDisbursedAmount != null
                : !this$totalDisbursedAmount.equals(other$totalDisbursedAmount))
            return false;
        final java.lang.Object this$totalPrincipalAmount = this.getTotalPrincipalAmount();
        final java.lang.Object other$totalPrincipalAmount = other.getTotalPrincipalAmount();
        if (this$totalPrincipalAmount == null ? other$totalPrincipalAmount != null
                : !this$totalPrincipalAmount.equals(other$totalPrincipalAmount))
            return false;
        final java.lang.Object this$totalInterestAmount = this.getTotalInterestAmount();
        final java.lang.Object other$totalInterestAmount = other.getTotalInterestAmount();
        if (this$totalInterestAmount == null ? other$totalInterestAmount != null
                : !this$totalInterestAmount.equals(other$totalInterestAmount))
            return false;
        final java.lang.Object this$totalFeeAmount = this.getTotalFeeAmount();
        final java.lang.Object other$totalFeeAmount = other.getTotalFeeAmount();
        if (this$totalFeeAmount == null ? other$totalFeeAmount != null : !this$totalFeeAmount.equals(other$totalFeeAmount)) return false;
        final java.lang.Object this$totalPenaltyAmount = this.getTotalPenaltyAmount();
        final java.lang.Object other$totalPenaltyAmount = other.getTotalPenaltyAmount();
        if (this$totalPenaltyAmount == null ? other$totalPenaltyAmount != null : !this$totalPenaltyAmount.equals(other$totalPenaltyAmount))
            return false;
        final java.lang.Object this$totalRepaymentAmount = this.getTotalRepaymentAmount();
        final java.lang.Object other$totalRepaymentAmount = other.getTotalRepaymentAmount();
        if (this$totalRepaymentAmount == null ? other$totalRepaymentAmount != null
                : !this$totalRepaymentAmount.equals(other$totalRepaymentAmount))
            return false;
        final java.lang.Object this$totalOutstandingAmount = this.getTotalOutstandingAmount();
        final java.lang.Object other$totalOutstandingAmount = other.getTotalOutstandingAmount();
        if (this$totalOutstandingAmount == null ? other$totalOutstandingAmount != null
                : !this$totalOutstandingAmount.equals(other$totalOutstandingAmount))
            return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
    protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanSchedulePlan;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + this.getLoanTermInDays();
        final java.lang.Object $periods = this.getPeriods();
        result = result * PRIME + ($periods == null ? 43 : $periods.hashCode());
        final java.lang.Object $currency = this.getCurrency();
        result = result * PRIME + ($currency == null ? 43 : $currency.hashCode());
        final java.lang.Object $totalDisbursedAmount = this.getTotalDisbursedAmount();
        result = result * PRIME + ($totalDisbursedAmount == null ? 43 : $totalDisbursedAmount.hashCode());
        final java.lang.Object $totalPrincipalAmount = this.getTotalPrincipalAmount();
        result = result * PRIME + ($totalPrincipalAmount == null ? 43 : $totalPrincipalAmount.hashCode());
        final java.lang.Object $totalInterestAmount = this.getTotalInterestAmount();
        result = result * PRIME + ($totalInterestAmount == null ? 43 : $totalInterestAmount.hashCode());
        final java.lang.Object $totalFeeAmount = this.getTotalFeeAmount();
        result = result * PRIME + ($totalFeeAmount == null ? 43 : $totalFeeAmount.hashCode());
        final java.lang.Object $totalPenaltyAmount = this.getTotalPenaltyAmount();
        result = result * PRIME + ($totalPenaltyAmount == null ? 43 : $totalPenaltyAmount.hashCode());
        final java.lang.Object $totalRepaymentAmount = this.getTotalRepaymentAmount();
        result = result * PRIME + ($totalRepaymentAmount == null ? 43 : $totalRepaymentAmount.hashCode());
        final java.lang.Object $totalOutstandingAmount = this.getTotalOutstandingAmount();
        result = result * PRIME + ($totalOutstandingAmount == null ? 43 : $totalOutstandingAmount.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public java.lang.String toString() {
        return "LoanSchedulePlan(periods=" + this.getPeriods() + ", currency=" + this.getCurrency() + ", loanTermInDays="
                + this.getLoanTermInDays() + ", totalDisbursedAmount=" + this.getTotalDisbursedAmount() + ", totalPrincipalAmount="
                + this.getTotalPrincipalAmount() + ", totalInterestAmount=" + this.getTotalInterestAmount() + ", totalFeeAmount="
                + this.getTotalFeeAmount() + ", totalPenaltyAmount=" + this.getTotalPenaltyAmount() + ", totalRepaymentAmount="
                + this.getTotalRepaymentAmount() + ", totalOutstandingAmount=" + this.getTotalOutstandingAmount() + ")";
    }
}
