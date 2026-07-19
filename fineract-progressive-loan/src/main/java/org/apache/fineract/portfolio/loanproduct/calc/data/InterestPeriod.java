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
package org.apache.fineract.portfolio.loanproduct.calc.data;

import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.math.MathContext;
import java.time.LocalDate;
import java.util.Optional;
import org.apache.fineract.infrastructure.core.serialization.gson.JsonExclude;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.core.service.MathUtil;
import org.apache.fineract.organisation.monetary.domain.MonetaryCurrency;
import org.apache.fineract.organisation.monetary.domain.Money;
import org.apache.fineract.portfolio.loanproduct.domain.InterestMethod;

public class InterestPeriod implements Comparable<InterestPeriod> {
    @JsonExclude
    private final RepaymentPeriod repaymentPeriod;
    @NotNull
    private LocalDate fromDate;
    @NotNull
    private LocalDate dueDate;
    private BigDecimal rateFactor;
    private BigDecimal rateFactorTillPeriodDueDate;
    /**
     * Stores credited principals. Related transactions: Chargeback or Credit Balance Refound
     */
    private Money creditedPrincipal;
    /**
     * Stores credited interest. Related transaction: Chargeback
     */
    private Money creditedInterest;
    private Money disbursementAmount;
    private Money balanceCorrectionAmount;
    private Money outstandingLoanBalance;
    private Money capitalizedIncomePrincipal;
    @JsonExclude
    private final MathContext mc;
    private boolean isPaused;

    public static InterestPeriod copy(@NotNull RepaymentPeriod repaymentPeriod, @NotNull InterestPeriod interestPeriod, MathContext mc) {
        return new InterestPeriod(repaymentPeriod, interestPeriod.getFromDate(), interestPeriod.getDueDate(), interestPeriod.getRateFactor(), interestPeriod.getRateFactorTillPeriodDueDate(), interestPeriod.getCreditedPrincipal(), interestPeriod.getCreditedInterest(), interestPeriod.getDisbursementAmount(), interestPeriod.getBalanceCorrectionAmount(), interestPeriod.getOutstandingLoanBalance(), interestPeriod.getCapitalizedIncomePrincipal(), mc, interestPeriod.isPaused());
    }

    public static InterestPeriod empty(@NotNull RepaymentPeriod repaymentPeriod, MathContext mc) {
        return new InterestPeriod(repaymentPeriod, null, null, null, null, null, null, null, null, null, null, mc, false);
    }

    public static InterestPeriod copy(@NotNull RepaymentPeriod repaymentPeriod, @NotNull InterestPeriod interestPeriod) {
        return new InterestPeriod(repaymentPeriod, interestPeriod.getFromDate(), interestPeriod.getDueDate(), interestPeriod.getRateFactor(), interestPeriod.getRateFactorTillPeriodDueDate(), interestPeriod.getCreditedPrincipal(), interestPeriod.getCreditedInterest(), interestPeriod.getDisbursementAmount(), interestPeriod.getBalanceCorrectionAmount(), interestPeriod.getOutstandingLoanBalance(), interestPeriod.getCapitalizedIncomePrincipal(), interestPeriod.getMc(), interestPeriod.isPaused());
    }

    public static InterestPeriod withEmptyAmounts(@NotNull RepaymentPeriod repaymentPeriod, @NotNull LocalDate fromDate, LocalDate dueDate) {
        final Money zero = repaymentPeriod.getZero();
        return new InterestPeriod(repaymentPeriod, fromDate, dueDate, BigDecimal.ZERO, BigDecimal.ZERO, zero, zero, zero, zero, zero, zero, zero.getMc(), false);
    }

    public static InterestPeriod withEmptyAmounts(@NotNull RepaymentPeriod repaymentPeriod, @NotNull LocalDate fromDate, LocalDate dueDate, boolean isPaused) {
        final Money zero = repaymentPeriod.getZero();
        return new InterestPeriod(repaymentPeriod, fromDate, dueDate, BigDecimal.ZERO, BigDecimal.ZERO, zero, zero, zero, zero, zero, zero, zero.getMc(), isPaused);
    }

    @Override
    public int compareTo(@NotNull InterestPeriod o) {
        return getDueDate().compareTo(o.getDueDate());
    }

    public void addBalanceCorrectionAmount(final Money additionalBalanceCorrectionAmount) {
        this.balanceCorrectionAmount = MathUtil.plus(this.getBalanceCorrectionAmount(), additionalBalanceCorrectionAmount);
    }

    public void addDisbursementAmount(final Money additionalDisbursementAmount) {
        this.disbursementAmount = MathUtil.plus(this.getDisbursementAmount(), additionalDisbursementAmount, getMc());
    }

    public void addCreditedPrincipalAmount(final Money additionalCreditedPrincipal) {
        this.creditedPrincipal = MathUtil.plus(this.getCreditedPrincipal(), additionalCreditedPrincipal, getMc());
    }

    public void addCreditedInterestAmount(final Money additionalCreditedInterest) {
        this.creditedInterest = MathUtil.plus(this.getCreditedInterest(), additionalCreditedInterest, getMc());
    }

    public void addCapitalizedIncomePrincipalAmount(final Money additionalCapitalizedIncomePrincipal) {
        this.capitalizedIncomePrincipal = MathUtil.plus(this.getCapitalizedIncomePrincipal(), additionalCapitalizedIncomePrincipal, getMc());
    }

    public BigDecimal getCalculatedDueInterest() {
        if (isPaused() || getRepaymentPeriod().isReAged()) {
            return getCreditedInterest().getAmount();
        }
        long lengthTillPeriodDueDate = getLengthTillPeriodDueDate();
        final BigDecimal interestDueTillRepaymentDueDate = getCalculatedDueInterest(getRepaymentPeriod().getLoanProductRelatedDetail().getInterestMethod(), lengthTillPeriodDueDate); //
        return MathUtil.negativeToZero(MathUtil.add(getMc(), getCreditedInterest().getAmount(), interestDueTillRepaymentDueDate));
    }

    public BigDecimal getCalculatedDueInterest(InterestMethod method, long lengthTillPeriodDueDate) {
        if (lengthTillPeriodDueDate == 0) {
            return BigDecimal.ZERO;
        }
        BigDecimal baseAmount = switch (method) {
            case FLAT -> getRepaymentPeriod().calculateTotalDisbursedAndCapitalizedIncomeAmountTillGivenPeriod(this).getAmount();
            case DECLINING_BALANCE -> getOutstandingLoanBalance().getAmount();
            default -> throw new UnsupportedOperationException("Method not implemented: " + method);
        };
        return  //
        //
        //
        baseAmount.multiply(getRateFactorTillPeriodDueDate(), getMc()).divide(BigDecimal.valueOf(lengthTillPeriodDueDate), getMc()).multiply(BigDecimal.valueOf(getLength()), getMc());
    }

    public long getLength() {
        return DateUtils.getDifferenceInDays(getFromDate(), getDueDate());
    }

    public long getLengthTillPeriodDueDate() {
        return DateUtils.getDifferenceInDays(getFromDate(), getRepaymentPeriod().getDueDate());
    }

    public void updateOutstandingLoanBalance() {
        if (isFirstInterestPeriod()) {
            Optional<RepaymentPeriod> previousRepaymentPeriod = getRepaymentPeriod().getPrevious();
            if (previousRepaymentPeriod.isPresent()) {
                InterestPeriod previousInterestPeriod = previousRepaymentPeriod.get().getLastInterestPeriod();
                this.outstandingLoanBalance = MathUtil.negativeToZero(//
                //
                //
                //
                //
                previousInterestPeriod.getOutstandingLoanBalance().plus(previousInterestPeriod.getDisbursementAmount(), getMc()).plus(previousInterestPeriod.getCapitalizedIncomePrincipal(), getMc()).plus(previousInterestPeriod.getBalanceCorrectionAmount(), getMc()).minus(previousRepaymentPeriod.get().getDuePrincipal(), getMc()).plus(previousRepaymentPeriod.get().getPaidPrincipal(), getMc()), getMc());//
            }
        } else {
            int index = getRepaymentPeriod().getInterestPeriods().indexOf(this);
            InterestPeriod previousInterestPeriod = getRepaymentPeriod().getInterestPeriods().get(index - 1);
            this.outstandingLoanBalance = MathUtil.negativeToZero( //
            //
            //
            previousInterestPeriod.getOutstandingLoanBalance().plus(previousInterestPeriod.getBalanceCorrectionAmount(), getMc()).plus(previousInterestPeriod.getCapitalizedIncomePrincipal(), getMc()).plus(previousInterestPeriod.getDisbursementAmount(), getMc())); //
        }
    }

    /**
     * Include principal like amounts (all disbursement amount + credited principal)
     */
    public Money getCreditedAmounts() {
        return MathUtil.plus(mc, getDisbursementAmount(), getCreditedPrincipal(), getCapitalizedIncomePrincipal());
    }

    public boolean isFirstInterestPeriod() {
        return this.equals(getRepaymentPeriod().getFirstInterestPeriod());
    }

    private MonetaryCurrency getCurrency() {
        return getRepaymentPeriod().getCurrency();
    }

    public Money getCreditedPrincipal() {
        return MathUtil.nullToZero(creditedPrincipal, getCurrency(), getMc());
    }

    public Money getCreditedInterest() {
        return MathUtil.nullToZero(creditedInterest, getCurrency(), getMc());
    }

    public Money getDisbursementAmount() {
        return MathUtil.nullToZero(disbursementAmount, getCurrency(), getMc());
    }

    public Money getBalanceCorrectionAmount() {
        return MathUtil.nullToZero(balanceCorrectionAmount, getCurrency(), getMc());
    }

    public Money getOutstandingLoanBalance() {
        return MathUtil.nullToZero(outstandingLoanBalance, getCurrency(), getMc());
    }

    public Money getCapitalizedIncomePrincipal() {
        return MathUtil.nullToZero(capitalizedIncomePrincipal, getCurrency(), getMc());
    }

    public BigDecimal getRateFactor() {
        return MathUtil.nullToZero(rateFactor);
    }

    public BigDecimal getRateFactorTillPeriodDueDate() {
        return MathUtil.nullToZero(rateFactorTillPeriodDueDate);
    }

    @java.lang.SuppressWarnings("all")
        public RepaymentPeriod getRepaymentPeriod() {
        return this.repaymentPeriod;
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
        public boolean isPaused() {
        return this.isPaused;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "InterestPeriod(fromDate=" + this.getFromDate() + ", dueDate=" + this.getDueDate() + ", rateFactor=" + this.getRateFactor() + ", rateFactorTillPeriodDueDate=" + this.getRateFactorTillPeriodDueDate() + ", creditedPrincipal=" + this.getCreditedPrincipal() + ", creditedInterest=" + this.getCreditedInterest() + ", disbursementAmount=" + this.getDisbursementAmount() + ", balanceCorrectionAmount=" + this.getBalanceCorrectionAmount() + ", outstandingLoanBalance=" + this.getOutstandingLoanBalance() + ", capitalizedIncomePrincipal=" + this.getCapitalizedIncomePrincipal() + ", mc=" + this.getMc() + ", isPaused=" + this.isPaused() + ")";
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof InterestPeriod)) return false;
        final InterestPeriod other = (InterestPeriod) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isPaused() != other.isPaused()) return false;
        final java.lang.Object this$fromDate = this.getFromDate();
        final java.lang.Object other$fromDate = other.getFromDate();
        if (this$fromDate == null ? other$fromDate != null : !this$fromDate.equals(other$fromDate)) return false;
        final java.lang.Object this$dueDate = this.getDueDate();
        final java.lang.Object other$dueDate = other.getDueDate();
        if (this$dueDate == null ? other$dueDate != null : !this$dueDate.equals(other$dueDate)) return false;
        final java.lang.Object this$rateFactor = this.getRateFactor();
        final java.lang.Object other$rateFactor = other.getRateFactor();
        if (this$rateFactor == null ? other$rateFactor != null : !this$rateFactor.equals(other$rateFactor)) return false;
        final java.lang.Object this$rateFactorTillPeriodDueDate = this.getRateFactorTillPeriodDueDate();
        final java.lang.Object other$rateFactorTillPeriodDueDate = other.getRateFactorTillPeriodDueDate();
        if (this$rateFactorTillPeriodDueDate == null ? other$rateFactorTillPeriodDueDate != null : !this$rateFactorTillPeriodDueDate.equals(other$rateFactorTillPeriodDueDate)) return false;
        final java.lang.Object this$creditedPrincipal = this.getCreditedPrincipal();
        final java.lang.Object other$creditedPrincipal = other.getCreditedPrincipal();
        if (this$creditedPrincipal == null ? other$creditedPrincipal != null : !this$creditedPrincipal.equals(other$creditedPrincipal)) return false;
        final java.lang.Object this$creditedInterest = this.getCreditedInterest();
        final java.lang.Object other$creditedInterest = other.getCreditedInterest();
        if (this$creditedInterest == null ? other$creditedInterest != null : !this$creditedInterest.equals(other$creditedInterest)) return false;
        final java.lang.Object this$disbursementAmount = this.getDisbursementAmount();
        final java.lang.Object other$disbursementAmount = other.getDisbursementAmount();
        if (this$disbursementAmount == null ? other$disbursementAmount != null : !this$disbursementAmount.equals(other$disbursementAmount)) return false;
        final java.lang.Object this$balanceCorrectionAmount = this.getBalanceCorrectionAmount();
        final java.lang.Object other$balanceCorrectionAmount = other.getBalanceCorrectionAmount();
        if (this$balanceCorrectionAmount == null ? other$balanceCorrectionAmount != null : !this$balanceCorrectionAmount.equals(other$balanceCorrectionAmount)) return false;
        final java.lang.Object this$outstandingLoanBalance = this.getOutstandingLoanBalance();
        final java.lang.Object other$outstandingLoanBalance = other.getOutstandingLoanBalance();
        if (this$outstandingLoanBalance == null ? other$outstandingLoanBalance != null : !this$outstandingLoanBalance.equals(other$outstandingLoanBalance)) return false;
        final java.lang.Object this$capitalizedIncomePrincipal = this.getCapitalizedIncomePrincipal();
        final java.lang.Object other$capitalizedIncomePrincipal = other.getCapitalizedIncomePrincipal();
        if (this$capitalizedIncomePrincipal == null ? other$capitalizedIncomePrincipal != null : !this$capitalizedIncomePrincipal.equals(other$capitalizedIncomePrincipal)) return false;
        final java.lang.Object this$mc = this.getMc();
        final java.lang.Object other$mc = other.getMc();
        if (this$mc == null ? other$mc != null : !this$mc.equals(other$mc)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof InterestPeriod;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isPaused() ? 79 : 97);
        final java.lang.Object $fromDate = this.getFromDate();
        result = result * PRIME + ($fromDate == null ? 43 : $fromDate.hashCode());
        final java.lang.Object $dueDate = this.getDueDate();
        result = result * PRIME + ($dueDate == null ? 43 : $dueDate.hashCode());
        final java.lang.Object $rateFactor = this.getRateFactor();
        result = result * PRIME + ($rateFactor == null ? 43 : $rateFactor.hashCode());
        final java.lang.Object $rateFactorTillPeriodDueDate = this.getRateFactorTillPeriodDueDate();
        result = result * PRIME + ($rateFactorTillPeriodDueDate == null ? 43 : $rateFactorTillPeriodDueDate.hashCode());
        final java.lang.Object $creditedPrincipal = this.getCreditedPrincipal();
        result = result * PRIME + ($creditedPrincipal == null ? 43 : $creditedPrincipal.hashCode());
        final java.lang.Object $creditedInterest = this.getCreditedInterest();
        result = result * PRIME + ($creditedInterest == null ? 43 : $creditedInterest.hashCode());
        final java.lang.Object $disbursementAmount = this.getDisbursementAmount();
        result = result * PRIME + ($disbursementAmount == null ? 43 : $disbursementAmount.hashCode());
        final java.lang.Object $balanceCorrectionAmount = this.getBalanceCorrectionAmount();
        result = result * PRIME + ($balanceCorrectionAmount == null ? 43 : $balanceCorrectionAmount.hashCode());
        final java.lang.Object $outstandingLoanBalance = this.getOutstandingLoanBalance();
        result = result * PRIME + ($outstandingLoanBalance == null ? 43 : $outstandingLoanBalance.hashCode());
        final java.lang.Object $capitalizedIncomePrincipal = this.getCapitalizedIncomePrincipal();
        result = result * PRIME + ($capitalizedIncomePrincipal == null ? 43 : $capitalizedIncomePrincipal.hashCode());
        final java.lang.Object $mc = this.getMc();
        result = result * PRIME + ($mc == null ? 43 : $mc.hashCode());
        return result;
    }

    /**
     * Creates a new {@code InterestPeriod} instance.
     *
     * @param repaymentPeriod
     * @param fromDate
     * @param dueDate
     * @param rateFactor
     * @param rateFactorTillPeriodDueDate
     * @param creditedPrincipal Stores credited principals. Related transactions: Chargeback or Credit Balance Refound
     * @param creditedInterest Stores credited interest. Related transaction: Chargeback
     * @param disbursementAmount
     * @param balanceCorrectionAmount
     * @param outstandingLoanBalance
     * @param capitalizedIncomePrincipal
     * @param mc
     * @param isPaused
     */
    @java.lang.SuppressWarnings("all")
        protected InterestPeriod(final RepaymentPeriod repaymentPeriod, final LocalDate fromDate, final LocalDate dueDate, final BigDecimal rateFactor, final BigDecimal rateFactorTillPeriodDueDate, final Money creditedPrincipal, final Money creditedInterest, final Money disbursementAmount, final Money balanceCorrectionAmount, final Money outstandingLoanBalance, final Money capitalizedIncomePrincipal, final MathContext mc, final boolean isPaused) {
        this.repaymentPeriod = repaymentPeriod;
        this.fromDate = fromDate;
        this.dueDate = dueDate;
        this.rateFactor = rateFactor;
        this.rateFactorTillPeriodDueDate = rateFactorTillPeriodDueDate;
        this.creditedPrincipal = creditedPrincipal;
        this.creditedInterest = creditedInterest;
        this.disbursementAmount = disbursementAmount;
        this.balanceCorrectionAmount = balanceCorrectionAmount;
        this.outstandingLoanBalance = outstandingLoanBalance;
        this.capitalizedIncomePrincipal = capitalizedIncomePrincipal;
        this.mc = mc;
        this.isPaused = isPaused;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromDate(final LocalDate fromDate) {
        this.fromDate = fromDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setDueDate(final LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setRateFactor(final BigDecimal rateFactor) {
        this.rateFactor = rateFactor;
    }

    @java.lang.SuppressWarnings("all")
        public void setRateFactorTillPeriodDueDate(final BigDecimal rateFactorTillPeriodDueDate) {
        this.rateFactorTillPeriodDueDate = rateFactorTillPeriodDueDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setDisbursementAmount(final Money disbursementAmount) {
        this.disbursementAmount = disbursementAmount;
    }

    @java.lang.SuppressWarnings("all")
        public MathContext getMc() {
        return this.mc;
    }

    @java.lang.SuppressWarnings("all")
        public void setPaused(final boolean isPaused) {
        this.isPaused = isPaused;
    }
}
