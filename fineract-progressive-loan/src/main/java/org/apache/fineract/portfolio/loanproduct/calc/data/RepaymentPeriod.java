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

import static org.apache.fineract.portfolio.loanaccount.domain.LoanRepaymentScheduleProcessingWrapper.isInPeriod;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.math.MathContext;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.apache.fineract.infrastructure.core.serialization.gson.JsonExclude;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.core.service.MathUtil;
import org.apache.fineract.organisation.monetary.domain.MonetaryCurrency;
import org.apache.fineract.organisation.monetary.domain.Money;
import org.apache.fineract.portfolio.loanproduct.domain.ILoanConfigurationDetails;
import org.apache.fineract.portfolio.util.Memo;

public class RepaymentPeriod {
    @JsonExclude
    private final RepaymentPeriod previous;
    private LocalDate fromDate;
    private LocalDate dueDate;
    private List<InterestPeriod> interestPeriods;
    private Money emi;
    private Money originalEmi;
    private Money paidPrincipal;
    private Money paidInterest;
    private Money futureUnrecognizedInterest;
    @JsonExclude
    private final MathContext mc;
    @JsonExclude
    private Memo<BigDecimal> rateFactorPlus1Calculation;
    @JsonExclude
    private Memo<Money> calculatedDueInterestCalculation;
    @JsonExclude
    private Memo<Money> dueInterestCalculation;
    @JsonExclude
    private Memo<Money> outstandingBalanceCalculation;
    private boolean isInterestMovedUpward = false;
    private boolean interestPaymentGrace = false;
    private Money totalDisbursedAmount;
    private Money totalCapitalizedIncomeAmount;
    @JsonExclude
    private final ILoanConfigurationDetails loanProductRelatedDetail;
    @JsonExclude
    private MonetaryCurrency currency;
    private Money creditedPrincipalMovedDueReAge;
    private Money creditedInterestMovedDueReAge;
    private boolean isInterestMovedDownward;
    private boolean reAged;
    private boolean reAgedEarlyRepaymentHolder;
    private Money fixedInterest;

    protected RepaymentPeriod(RepaymentPeriod previous, LocalDate fromDate, LocalDate dueDate, List<InterestPeriod> interestPeriods, Money emi, Money originalEmi, Money paidPrincipal, Money paidInterest, Money futureUnrecognizedInterest, MathContext mc, ILoanConfigurationDetails loanProductRelatedDetail, boolean isInterestMovedDownward, boolean reAged, boolean reAgedEarlyRepaymentHolder, Money fixedInterest) {
        this.previous = previous;
        this.fromDate = fromDate;
        this.dueDate = dueDate;
        this.interestPeriods = interestPeriods;
        this.emi = emi;
        this.originalEmi = originalEmi;
        this.paidPrincipal = paidPrincipal;
        this.paidInterest = paidInterest;
        this.futureUnrecognizedInterest = futureUnrecognizedInterest;
        this.mc = mc;
        this.loanProductRelatedDetail = loanProductRelatedDetail;
        this.isInterestMovedDownward = isInterestMovedDownward;
        this.reAged = reAged;
        this.reAgedEarlyRepaymentHolder = reAgedEarlyRepaymentHolder;
        this.fixedInterest = fixedInterest;
        this.creditedInterestMovedDueReAge = Money.zero(loanProductRelatedDetail.getCurrencyData(), mc);
        this.creditedInterestMovedDueReAge = Money.zero(loanProductRelatedDetail.getCurrencyData(), mc);
    }

    public static RepaymentPeriod empty(RepaymentPeriod previous, MathContext mc, ILoanConfigurationDetails loanProductRelatedDetail) {
        return new RepaymentPeriod(previous, null, null, new ArrayList<>(), null, null, null, null, null, mc, loanProductRelatedDetail, false, false, false, null);
    }

    public static RepaymentPeriod create(RepaymentPeriod previous, LocalDate fromDate, LocalDate dueDate, Money emi, MathContext mc, ILoanConfigurationDetails loanProductRelatedDetail) {
        final Money zero = emi.zero();
        final RepaymentPeriod newRepaymentPeriod = new RepaymentPeriod(previous, fromDate, dueDate, new ArrayList<>(), emi, emi, zero, zero, zero, mc, loanProductRelatedDetail, false, false, false, zero);
        // There is always at least 1 interest period, by default with same from-due date as repayment period
        newRepaymentPeriod.getInterestPeriods().add(InterestPeriod.withEmptyAmounts(newRepaymentPeriod, fromDate, dueDate));
        return newRepaymentPeriod;
    }

    public static RepaymentPeriod copy(RepaymentPeriod previous, RepaymentPeriod repaymentPeriod, MathContext mc) {
        final RepaymentPeriod newRepaymentPeriod = new RepaymentPeriod(previous, repaymentPeriod.getFromDate(), repaymentPeriod.getDueDate(), new ArrayList<>(), repaymentPeriod.getEmi(), repaymentPeriod.getOriginalEmi(), repaymentPeriod.getPaidPrincipal(), repaymentPeriod.getPaidInterest(), repaymentPeriod.getFutureUnrecognizedInterest(), mc, repaymentPeriod.getLoanProductRelatedDetail(), repaymentPeriod.isInterestMovedDownward(), repaymentPeriod.isReAged(), repaymentPeriod.isReAgedEarlyRepaymentHolder(), repaymentPeriod.getFixedInterest());
        newRepaymentPeriod.setCreditedPrincipalMovedDueReAge(repaymentPeriod.getCreditedPrincipalMovedDueReAge());
        newRepaymentPeriod.setCreditedInterestMovedDueReAge(repaymentPeriod.getCreditedInterestMovedDueReAge());
        newRepaymentPeriod.setTotalDisbursedAmount(repaymentPeriod.getTotalDisbursedAmount());
        newRepaymentPeriod.setTotalCapitalizedIncomeAmount(repaymentPeriod.getTotalCapitalizedIncomeAmount());
        newRepaymentPeriod.setInterestMovedUpward(repaymentPeriod.isInterestMovedUpward());
        newRepaymentPeriod.setInterestPaymentGrace(repaymentPeriod.isInterestPaymentGrace());
        newRepaymentPeriod.setCurrency(repaymentPeriod.getCurrency());
        // There is always at least 1 interest period, by default with same from-due date as repayment period
        for (InterestPeriod interestPeriod : repaymentPeriod.getInterestPeriods()) {
            newRepaymentPeriod.getInterestPeriods().add(InterestPeriod.copy(newRepaymentPeriod, interestPeriod, mc));
        }
        return newRepaymentPeriod;
    }

    public static RepaymentPeriod copyWithoutPaidAmounts(RepaymentPeriod previous, RepaymentPeriod repaymentPeriod, MathContext mc) {
        final Money zero = Money.zero(repaymentPeriod.getCurrency(), mc);
        final RepaymentPeriod newRepaymentPeriod = new RepaymentPeriod(previous, repaymentPeriod.getFromDate(), repaymentPeriod.getDueDate(), new ArrayList<>(), repaymentPeriod.getEmi(), repaymentPeriod.getOriginalEmi(), zero, zero, zero, mc, repaymentPeriod.getLoanProductRelatedDetail(), repaymentPeriod.isInterestMovedDownward(), repaymentPeriod.isReAged(), repaymentPeriod.isReAgedEarlyRepaymentHolder(), repaymentPeriod.getFixedInterest());
        newRepaymentPeriod.setCreditedPrincipalMovedDueReAge(repaymentPeriod.getCreditedPrincipalMovedDueReAge());
        newRepaymentPeriod.setCreditedInterestMovedDueReAge(repaymentPeriod.getCreditedInterestMovedDueReAge());
        if (repaymentPeriod.isInterestMovedDownward()) {
            newRepaymentPeriod.setFixedInterest(repaymentPeriod.getPaidInterest());
        }
        newRepaymentPeriod.setTotalDisbursedAmount(repaymentPeriod.getTotalDisbursedAmount());
        newRepaymentPeriod.setTotalCapitalizedIncomeAmount(repaymentPeriod.getTotalCapitalizedIncomeAmount());
        newRepaymentPeriod.setInterestMovedUpward(repaymentPeriod.isInterestMovedUpward());
        newRepaymentPeriod.setInterestPaymentGrace(repaymentPeriod.isInterestPaymentGrace());
        newRepaymentPeriod.setCurrency(repaymentPeriod.getCurrency());
        // There is always at least 1 interest period, by default with same from-due date as repayment period
        for (InterestPeriod interestPeriod : repaymentPeriod.getInterestPeriods()) {
            var interestPeriodCopy = InterestPeriod.copy(newRepaymentPeriod, interestPeriod);
            if (!interestPeriodCopy.getBalanceCorrectionAmount().isZero()) {
                interestPeriodCopy.addBalanceCorrectionAmount(interestPeriodCopy.getBalanceCorrectionAmount().negated());
            }
            newRepaymentPeriod.getInterestPeriods().add(interestPeriodCopy);
        }
        return newRepaymentPeriod;
    }

    public Optional<RepaymentPeriod> getPrevious() {
        return Optional.ofNullable(previous);
    }

    /**
     * This method gives back sum of (Rate Factor +1) from the interest periods
     *
     * @return
     */
    public BigDecimal getRateFactorPlus1() {
        if (rateFactorPlus1Calculation == null) {
            rateFactorPlus1Calculation = Memo.of(this::calculateRateFactorPlus1, () -> this.interestPeriods);
        }
        return rateFactorPlus1Calculation.get();
    }

    private BigDecimal calculateRateFactorPlus1() {
        return interestPeriods.stream().map(InterestPeriod::getRateFactor).reduce(BigDecimal.ONE, BigDecimal::add);
    }

    /**
     * Gives back calculated due interest + credited interest
     *
     * @return
     */
    @NotNull
    public Money getCalculatedDueInterest() {
        if (calculatedDueInterestCalculation == null) {
            calculatedDueInterestCalculation = Memo.of(this::calculateCalculatedDueInterest, () -> new Object[] {previous, interestPeriods, futureUnrecognizedInterest, isInterestMovedUpward, isInterestMovedDownward, totalDisbursedAmount, fixedInterest, reAged});
        }
        return calculatedDueInterestCalculation.get();
    }

    public Money calculateFixedInterestTillDate() {
        Money calculatedFixedInterest = getZero();
        if (!getFixedInterest().isZero()) {
            long length = DateUtils.getDifferenceInDays(getFromDate(), getDueDate());
            if (length == 0 || getInterestPeriods() == null || getInterestPeriods().isEmpty()) {
                // if the repayment period length is zero. return reAgedInterest.
                calculatedFixedInterest = getFixedInterest();
            } else {
                long interestCalculationLength = DateUtils.getDifferenceInDays(getInterestPeriods().getFirst().getFromDate(), getInterestPeriods().getLast().getDueDate());
                calculatedFixedInterest = Money.of(getZero().getCurrencyData(), BigDecimal.valueOf(interestCalculationLength).divide(BigDecimal.valueOf(length), getMc()).multiply(getFixedInterest().getAmount(), getMc()));
            }
        }
        return calculatedFixedInterest;
    }

    public Money calculateCalculatedDueInterest() {
        Money calculatedDueInterest = getZero();
        if (!isInterestMovedUpward() && !isInterestMovedDownward()) {
            calculatedDueInterest = Money.of(getEmi().getCurrencyData(), getInterestPeriods().stream().map(InterestPeriod::getCalculatedDueInterest).reduce(BigDecimal.ZERO, BigDecimal::add), mc);
        }
        calculatedDueInterest = calculatedDueInterest.add(getFixedInterest());
        calculatedDueInterest = calculatedDueInterest.add(getFutureUnrecognizedInterest(), getMc());
        if (getPrevious().isPresent()) {
            calculatedDueInterest = calculatedDueInterest.add(getPrevious().get().getUnrecognizedInterest(), getMc());
        }
        return MathUtil.negativeToZero(calculatedDueInterest, getMc());
    }

    /**
     * Gives back due interest + credited interest OR paid interest
     *
     * @return
     */
    public Money getDueInterest() {
        if (isInterestPaymentGrace()) {
            return getPaidInterest();
        }
        if (dueInterestCalculation == null) {
            // Due interest might be the maximum paid if there is pay-off or early repayment
            dueInterestCalculation = Memo.of(() -> MathUtil.max(getPaidPrincipal().isGreaterThan(getCalculatedDuePrincipal()) ? getPaidInterest() : MathUtil.min(getCalculatedDueInterest(), getEmiPlusCreditedAmountsPlusFutureUnrecognizedInterest(), false), getPaidInterest(), false), () -> new Object[] {paidPrincipal, paidInterest, interestPeriods, futureUnrecognizedInterest, totalDisbursedAmount, fixedInterest, reAged, emi, interestPaymentGrace});
        }
        return dueInterestCalculation.get();
    }

    /**
     * Gives back an EMI amount which includes credited amounts and future unrecognized interest as well
     *
     * @return
     */
    public Money getEmiPlusCreditedAmountsPlusFutureUnrecognizedInterest() {
        return getEmi().plus(getTotalCreditedAmount(), mc).plus(getFutureUnrecognizedInterest(), getMc()); //
    }

    /**
     * Gives back principal due + charge back principal based on (EMI - Calculated Due Interest)
     *
     * @return
     */
    public Money getCalculatedDuePrincipal() {
        return MathUtil.negativeToZero(getEmiPlusCreditedAmountsPlusFutureUnrecognizedInterest().minus(getCalculatedDueInterest(), getMc()), getMc());
    }

    /**
     * Sum of credited principals
     *
     * @return
     */
    public Money getCreditedPrincipal() {
        return MathUtil.negativeToZero( //
        //
        getInterestPeriods().stream().map(InterestPeriod::getCreditedPrincipal).reduce(getZero(), (value, previous) -> value.plus(previous, getMc())), getMc()); //
    }

    /**
     * Sum of credited interests
     *
     * @return
     */
    public Money getCreditedInterest() {
        return MathUtil.negativeToZero( //
        //
        getInterestPeriods().stream().map(InterestPeriod::getCreditedInterest).reduce(getZero(), (value, previous) -> value.plus(previous, getMc())), getMc()); //
    }

    /**
     * Sum of capitalized income principals
     *
     * @return
     */
    public Money getCapitalizedIncomePrincipal() {
        return MathUtil.negativeToZero( //
        //
        getInterestPeriods().stream().map(InterestPeriod::getCapitalizedIncomePrincipal).reduce(getZero(), (value, previous) -> value.plus(previous, getMc())), getMc()); //
    }

    /**
     * Gives back due principal + credited principal or paid principal
     *
     * @return
     */
    public Money getDuePrincipal() {
        // Due principal might be the maximum paid if there is pay-off or early repayment
        return MathUtil.max(MathUtil.negativeToZero(getEmiPlusCreditedAmountsPlusFutureUnrecognizedInterest().minus(getDueInterest(), getMc()), getMc()), getPaidPrincipal(), false);
    }

    /**
     * Gives back sum of all credited principal + credited interest
     *
     * @return
     */
    public Money getTotalCreditedAmount() {
        return getCreditedPrincipal().plus(getCreditedInterest(), getMc()).minus(getCreditedInterestMovedDueReAge(), getMc()).minus(getCreditedPrincipalMovedDueReAge(), getMc());
    }

    /**
     * Total paid amounts has everything: paid principal + paid interest + paid charge principal + paid charge interest
     *
     * @return
     */
    public Money getTotalPaidAmount() {
        return getPaidPrincipal().plus(getPaidInterest(), getMc());
    }

    public boolean isFullyPaid() {
        return getEmiPlusCreditedAmountsPlusFutureUnrecognizedInterest().isEqualTo(getTotalPaidAmount());
    }

    /**
     * This method counts those interest amounts when there is no place in EMI. Which typically can happen if there is a
     * not full paid early repayment. In this case we can count in the next repayment period.
     *
     * @return
     */
    public Money getUnrecognizedInterest() {
        return MathUtil.negativeToZero(getCalculatedDueInterest().minus(getDueInterest(), getMc()), getMc());
    }

    public Money getCreditedAmounts() {
        return interestPeriods.stream().map(InterestPeriod::getCreditedAmounts).reduce(getZero(), (m1, m2) -> m1.plus(m2, getMc()));
    }

    public Money getOutstandingLoanBalance() {
        if (outstandingBalanceCalculation == null) {
            outstandingBalanceCalculation = Memo.of(() -> {
                InterestPeriod lastInterestPeriod = getInterestPeriods().getLast();
                Money calculatedOutStandingLoanBalance =  //
                //
                //
                //
                //
                lastInterestPeriod.getOutstandingLoanBalance().plus(lastInterestPeriod.getBalanceCorrectionAmount(), getMc()).plus(lastInterestPeriod.getCapitalizedIncomePrincipal(), getMc()).plus(lastInterestPeriod.getDisbursementAmount(), getMc()).plus(getPaidPrincipal(), getMc()).minus(getDuePrincipal(), getMc()); //
                return MathUtil.negativeToZero(calculatedOutStandingLoanBalance, getMc());
            }, () -> new Object[] {paidPrincipal, paidInterest, interestPeriods, totalDisbursedAmount});
        }
        return outstandingBalanceCalculation.get();
    }

    public void addPaidPrincipalAmount(Money paidPrincipal) {
        this.paidPrincipal = MathUtil.plus(this.getPaidPrincipal(), paidPrincipal, getMc());
    }

    public void addPaidInterestAmount(Money paidInterest) {
        this.paidInterest = MathUtil.plus(this.getPaidInterest(), paidInterest, getMc());
    }

    public Money getInitialBalanceForEmiRecalculation() {
        Money initialBalance;
        if (getPrevious().isPresent()) {
            initialBalance = getPrevious().get().getOutstandingLoanBalance();
        } else {
            initialBalance = getZero();
        }
        Money totalDisbursedAmount =  //
        //
        getInterestPeriods().stream().map(InterestPeriod::getDisbursementAmount).reduce(getZero(), (m1, m2) -> m1.plus(m2, getMc())); //
        Money totalCapitalizedIncomeAmount =  //
        //
        getInterestPeriods().stream().map(InterestPeriod::getCapitalizedIncomePrincipal).reduce(getZero(), (m1, m2) -> m1.plus(m2, getMc())); //
        return initialBalance.add(totalDisbursedAmount, getMc()).add(totalCapitalizedIncomeAmount, getMc());
    }

    public Money getZero() {
        return Money.zero(getCurrency(), getMc());
    }

    public InterestPeriod getFirstInterestPeriod() {
        return getInterestPeriods().getFirst();
    }

    public InterestPeriod getLastInterestPeriod() {
        List<InterestPeriod> interestPeriods = getInterestPeriods();
        return interestPeriods.getLast();
    }

    public Optional<InterestPeriod> findInterestPeriod(@NotNull LocalDate transactionDate) {
        return  //
        //
        interestPeriods.stream().filter(interestPeriod -> isInPeriod(transactionDate, interestPeriod.getFromDate(), interestPeriod.getDueDate(), isFirstRepaymentPeriod() && interestPeriod.isFirstInterestPeriod())).reduce((one, two) -> two);
    }

    public boolean isFirstRepaymentPeriod() {
        return previous == null;
    }

    /**
     * Gives back getDueInterest minus paid interest
     *
     * @return
     */
    public Money getOutstandingInterest() {
        return MathUtil.negativeToZero(getDueInterest().minus(getPaidInterest()), getMc());
    }

    public Money getOutstandingPrincipal() {
        return MathUtil.negativeToZero(getDuePrincipal().minus(getPaidPrincipal()), getMc());
    }

    public void resetDerivedComponents() {
        this.paidInterest = paidInterest.zero();
        this.paidPrincipal = paidPrincipal.zero();
    }

    /**
     * @param tillPeriod
     *            can be null. if null it calculates total disbursement including last interest period.
     * @return disbursed and capitalized income amount till interest period.
     */
    public Money calculateTotalDisbursedAndCapitalizedIncomeAmountTillGivenPeriod(InterestPeriod tillPeriod) {
        Money res = MathUtil.plus(getMc(), getTotalDisbursedAmount(), getTotalCapitalizedIncomeAmount());
        for (InterestPeriod interestPeriod : this.getInterestPeriods()) {
            if (interestPeriod.equals(tillPeriod)) {
                break;
            }
            if (!interestPeriod.getDueDate().equals(getFromDate())) {
                if (interestPeriod.getDisbursementAmount() != null) {
                    res = res.plus(interestPeriod.getDisbursementAmount(), getMc());
                }
                if (interestPeriod.getCapitalizedIncomePrincipal() != null) {
                    res = res.plus(interestPeriod.getCapitalizedIncomePrincipal(), getMc());
                }
            }
        }
        return res;
    }

    public MonetaryCurrency getCurrency() {
        if (currency == null) {
            currency = MonetaryCurrency.fromCurrencyData(loanProductRelatedDetail.getCurrencyData());
        }
        return currency;
    }

    public Money getEmi() {
        return MathUtil.nullToZero(emi, getCurrency(), getMc());
    }

    public Money getOriginalEmi() {
        return MathUtil.nullToZero(originalEmi, getCurrency(), getMc());
    }

    public Money getPaidPrincipal() {
        return MathUtil.nullToZero(paidPrincipal, getCurrency(), getMc());
    }

    public Money getPaidInterest() {
        return MathUtil.nullToZero(paidInterest, getCurrency(), getMc());
    }

    public Money getFutureUnrecognizedInterest() {
        return MathUtil.nullToZero(futureUnrecognizedInterest, getCurrency(), getMc());
    }

    public Money getTotalDisbursedAmount() {
        return MathUtil.nullToZero(totalDisbursedAmount, getCurrency(), getMc());
    }

    public Money getTotalCapitalizedIncomeAmount() {
        return MathUtil.nullToZero(totalCapitalizedIncomeAmount, getCurrency(), getMc());
    }

    public Money getFixedInterest() {
        return MathUtil.nullToZero(fixedInterest, getCurrency(), getMc());
    }

    public void moveOutstandingDueToReAging() {
        setCreditedPrincipalMovedDueReAge(getCreditedPrincipal());
        setCreditedInterestMovedDueReAge(getCreditedInterest());
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "RepaymentPeriod(fromDate=" + this.getFromDate() + ", dueDate=" + this.getDueDate() + ", interestPeriods=" + this.getInterestPeriods() + ", emi=" + this.getEmi() + ", originalEmi=" + this.getOriginalEmi() + ", paidPrincipal=" + this.getPaidPrincipal() + ", paidInterest=" + this.getPaidInterest() + ", futureUnrecognizedInterest=" + this.getFutureUnrecognizedInterest() + ", mc=" + this.getMc() + ", rateFactorPlus1Calculation=" + this.rateFactorPlus1Calculation + ", calculatedDueInterestCalculation=" + this.calculatedDueInterestCalculation + ", dueInterestCalculation=" + this.dueInterestCalculation + ", outstandingBalanceCalculation=" + this.outstandingBalanceCalculation + ", isInterestMovedUpward=" + this.isInterestMovedUpward() + ", interestPaymentGrace=" + this.isInterestPaymentGrace() + ", totalDisbursedAmount=" + this.getTotalDisbursedAmount() + ", totalCapitalizedIncomeAmount=" + this.getTotalCapitalizedIncomeAmount() + ", loanProductRelatedDetail=" + this.getLoanProductRelatedDetail() + ", currency=" + this.getCurrency() + ", creditedPrincipalMovedDueReAge=" + this.getCreditedPrincipalMovedDueReAge() + ", creditedInterestMovedDueReAge=" + this.getCreditedInterestMovedDueReAge() + ", isInterestMovedDownward=" + this.isInterestMovedDownward() + ", reAged=" + this.isReAged() + ", reAgedEarlyRepaymentHolder=" + this.isReAgedEarlyRepaymentHolder() + ", fixedInterest=" + this.getFixedInterest() + ")";
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof RepaymentPeriod)) return false;
        final RepaymentPeriod other = (RepaymentPeriod) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isInterestMovedUpward() != other.isInterestMovedUpward()) return false;
        if (this.isInterestPaymentGrace() != other.isInterestPaymentGrace()) return false;
        if (this.isInterestMovedDownward() != other.isInterestMovedDownward()) return false;
        if (this.isReAged() != other.isReAged()) return false;
        if (this.isReAgedEarlyRepaymentHolder() != other.isReAgedEarlyRepaymentHolder()) return false;
        final java.lang.Object this$fromDate = this.getFromDate();
        final java.lang.Object other$fromDate = other.getFromDate();
        if (this$fromDate == null ? other$fromDate != null : !this$fromDate.equals(other$fromDate)) return false;
        final java.lang.Object this$dueDate = this.getDueDate();
        final java.lang.Object other$dueDate = other.getDueDate();
        if (this$dueDate == null ? other$dueDate != null : !this$dueDate.equals(other$dueDate)) return false;
        final java.lang.Object this$interestPeriods = this.getInterestPeriods();
        final java.lang.Object other$interestPeriods = other.getInterestPeriods();
        if (this$interestPeriods == null ? other$interestPeriods != null : !this$interestPeriods.equals(other$interestPeriods)) return false;
        final java.lang.Object this$emi = this.getEmi();
        final java.lang.Object other$emi = other.getEmi();
        if (this$emi == null ? other$emi != null : !this$emi.equals(other$emi)) return false;
        final java.lang.Object this$originalEmi = this.getOriginalEmi();
        final java.lang.Object other$originalEmi = other.getOriginalEmi();
        if (this$originalEmi == null ? other$originalEmi != null : !this$originalEmi.equals(other$originalEmi)) return false;
        final java.lang.Object this$paidPrincipal = this.getPaidPrincipal();
        final java.lang.Object other$paidPrincipal = other.getPaidPrincipal();
        if (this$paidPrincipal == null ? other$paidPrincipal != null : !this$paidPrincipal.equals(other$paidPrincipal)) return false;
        final java.lang.Object this$paidInterest = this.getPaidInterest();
        final java.lang.Object other$paidInterest = other.getPaidInterest();
        if (this$paidInterest == null ? other$paidInterest != null : !this$paidInterest.equals(other$paidInterest)) return false;
        final java.lang.Object this$futureUnrecognizedInterest = this.getFutureUnrecognizedInterest();
        final java.lang.Object other$futureUnrecognizedInterest = other.getFutureUnrecognizedInterest();
        if (this$futureUnrecognizedInterest == null ? other$futureUnrecognizedInterest != null : !this$futureUnrecognizedInterest.equals(other$futureUnrecognizedInterest)) return false;
        final java.lang.Object this$mc = this.getMc();
        final java.lang.Object other$mc = other.getMc();
        if (this$mc == null ? other$mc != null : !this$mc.equals(other$mc)) return false;
        final java.lang.Object this$rateFactorPlus1Calculation = this.rateFactorPlus1Calculation;
        final java.lang.Object other$rateFactorPlus1Calculation = other.rateFactorPlus1Calculation;
        if (this$rateFactorPlus1Calculation == null ? other$rateFactorPlus1Calculation != null : !this$rateFactorPlus1Calculation.equals(other$rateFactorPlus1Calculation)) return false;
        final java.lang.Object this$calculatedDueInterestCalculation = this.calculatedDueInterestCalculation;
        final java.lang.Object other$calculatedDueInterestCalculation = other.calculatedDueInterestCalculation;
        if (this$calculatedDueInterestCalculation == null ? other$calculatedDueInterestCalculation != null : !this$calculatedDueInterestCalculation.equals(other$calculatedDueInterestCalculation)) return false;
        final java.lang.Object this$dueInterestCalculation = this.dueInterestCalculation;
        final java.lang.Object other$dueInterestCalculation = other.dueInterestCalculation;
        if (this$dueInterestCalculation == null ? other$dueInterestCalculation != null : !this$dueInterestCalculation.equals(other$dueInterestCalculation)) return false;
        final java.lang.Object this$outstandingBalanceCalculation = this.outstandingBalanceCalculation;
        final java.lang.Object other$outstandingBalanceCalculation = other.outstandingBalanceCalculation;
        if (this$outstandingBalanceCalculation == null ? other$outstandingBalanceCalculation != null : !this$outstandingBalanceCalculation.equals(other$outstandingBalanceCalculation)) return false;
        final java.lang.Object this$totalDisbursedAmount = this.getTotalDisbursedAmount();
        final java.lang.Object other$totalDisbursedAmount = other.getTotalDisbursedAmount();
        if (this$totalDisbursedAmount == null ? other$totalDisbursedAmount != null : !this$totalDisbursedAmount.equals(other$totalDisbursedAmount)) return false;
        final java.lang.Object this$totalCapitalizedIncomeAmount = this.getTotalCapitalizedIncomeAmount();
        final java.lang.Object other$totalCapitalizedIncomeAmount = other.getTotalCapitalizedIncomeAmount();
        if (this$totalCapitalizedIncomeAmount == null ? other$totalCapitalizedIncomeAmount != null : !this$totalCapitalizedIncomeAmount.equals(other$totalCapitalizedIncomeAmount)) return false;
        final java.lang.Object this$loanProductRelatedDetail = this.getLoanProductRelatedDetail();
        final java.lang.Object other$loanProductRelatedDetail = other.getLoanProductRelatedDetail();
        if (this$loanProductRelatedDetail == null ? other$loanProductRelatedDetail != null : !this$loanProductRelatedDetail.equals(other$loanProductRelatedDetail)) return false;
        final java.lang.Object this$currency = this.getCurrency();
        final java.lang.Object other$currency = other.getCurrency();
        if (this$currency == null ? other$currency != null : !this$currency.equals(other$currency)) return false;
        final java.lang.Object this$creditedPrincipalMovedDueReAge = this.getCreditedPrincipalMovedDueReAge();
        final java.lang.Object other$creditedPrincipalMovedDueReAge = other.getCreditedPrincipalMovedDueReAge();
        if (this$creditedPrincipalMovedDueReAge == null ? other$creditedPrincipalMovedDueReAge != null : !this$creditedPrincipalMovedDueReAge.equals(other$creditedPrincipalMovedDueReAge)) return false;
        final java.lang.Object this$creditedInterestMovedDueReAge = this.getCreditedInterestMovedDueReAge();
        final java.lang.Object other$creditedInterestMovedDueReAge = other.getCreditedInterestMovedDueReAge();
        if (this$creditedInterestMovedDueReAge == null ? other$creditedInterestMovedDueReAge != null : !this$creditedInterestMovedDueReAge.equals(other$creditedInterestMovedDueReAge)) return false;
        final java.lang.Object this$fixedInterest = this.getFixedInterest();
        final java.lang.Object other$fixedInterest = other.getFixedInterest();
        if (this$fixedInterest == null ? other$fixedInterest != null : !this$fixedInterest.equals(other$fixedInterest)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof RepaymentPeriod;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isInterestMovedUpward() ? 79 : 97);
        result = result * PRIME + (this.isInterestPaymentGrace() ? 79 : 97);
        result = result * PRIME + (this.isInterestMovedDownward() ? 79 : 97);
        result = result * PRIME + (this.isReAged() ? 79 : 97);
        result = result * PRIME + (this.isReAgedEarlyRepaymentHolder() ? 79 : 97);
        final java.lang.Object $fromDate = this.getFromDate();
        result = result * PRIME + ($fromDate == null ? 43 : $fromDate.hashCode());
        final java.lang.Object $dueDate = this.getDueDate();
        result = result * PRIME + ($dueDate == null ? 43 : $dueDate.hashCode());
        final java.lang.Object $interestPeriods = this.getInterestPeriods();
        result = result * PRIME + ($interestPeriods == null ? 43 : $interestPeriods.hashCode());
        final java.lang.Object $emi = this.getEmi();
        result = result * PRIME + ($emi == null ? 43 : $emi.hashCode());
        final java.lang.Object $originalEmi = this.getOriginalEmi();
        result = result * PRIME + ($originalEmi == null ? 43 : $originalEmi.hashCode());
        final java.lang.Object $paidPrincipal = this.getPaidPrincipal();
        result = result * PRIME + ($paidPrincipal == null ? 43 : $paidPrincipal.hashCode());
        final java.lang.Object $paidInterest = this.getPaidInterest();
        result = result * PRIME + ($paidInterest == null ? 43 : $paidInterest.hashCode());
        final java.lang.Object $futureUnrecognizedInterest = this.getFutureUnrecognizedInterest();
        result = result * PRIME + ($futureUnrecognizedInterest == null ? 43 : $futureUnrecognizedInterest.hashCode());
        final java.lang.Object $mc = this.getMc();
        result = result * PRIME + ($mc == null ? 43 : $mc.hashCode());
        final java.lang.Object $rateFactorPlus1Calculation = this.rateFactorPlus1Calculation;
        result = result * PRIME + ($rateFactorPlus1Calculation == null ? 43 : $rateFactorPlus1Calculation.hashCode());
        final java.lang.Object $calculatedDueInterestCalculation = this.calculatedDueInterestCalculation;
        result = result * PRIME + ($calculatedDueInterestCalculation == null ? 43 : $calculatedDueInterestCalculation.hashCode());
        final java.lang.Object $dueInterestCalculation = this.dueInterestCalculation;
        result = result * PRIME + ($dueInterestCalculation == null ? 43 : $dueInterestCalculation.hashCode());
        final java.lang.Object $outstandingBalanceCalculation = this.outstandingBalanceCalculation;
        result = result * PRIME + ($outstandingBalanceCalculation == null ? 43 : $outstandingBalanceCalculation.hashCode());
        final java.lang.Object $totalDisbursedAmount = this.getTotalDisbursedAmount();
        result = result * PRIME + ($totalDisbursedAmount == null ? 43 : $totalDisbursedAmount.hashCode());
        final java.lang.Object $totalCapitalizedIncomeAmount = this.getTotalCapitalizedIncomeAmount();
        result = result * PRIME + ($totalCapitalizedIncomeAmount == null ? 43 : $totalCapitalizedIncomeAmount.hashCode());
        final java.lang.Object $loanProductRelatedDetail = this.getLoanProductRelatedDetail();
        result = result * PRIME + ($loanProductRelatedDetail == null ? 43 : $loanProductRelatedDetail.hashCode());
        final java.lang.Object $currency = this.getCurrency();
        result = result * PRIME + ($currency == null ? 43 : $currency.hashCode());
        final java.lang.Object $creditedPrincipalMovedDueReAge = this.getCreditedPrincipalMovedDueReAge();
        result = result * PRIME + ($creditedPrincipalMovedDueReAge == null ? 43 : $creditedPrincipalMovedDueReAge.hashCode());
        final java.lang.Object $creditedInterestMovedDueReAge = this.getCreditedInterestMovedDueReAge();
        result = result * PRIME + ($creditedInterestMovedDueReAge == null ? 43 : $creditedInterestMovedDueReAge.hashCode());
        final java.lang.Object $fixedInterest = this.getFixedInterest();
        result = result * PRIME + ($fixedInterest == null ? 43 : $fixedInterest.hashCode());
        return result;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromDate(final LocalDate fromDate) {
        this.fromDate = fromDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getFromDate() {
        return this.fromDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setDueDate(final LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDueDate() {
        return this.dueDate;
    }

    @java.lang.SuppressWarnings("all")
        public List<InterestPeriod> getInterestPeriods() {
        return this.interestPeriods;
    }

    @java.lang.SuppressWarnings("all")
        public void setInterestPeriods(final List<InterestPeriod> interestPeriods) {
        this.interestPeriods = interestPeriods;
    }

    @java.lang.SuppressWarnings("all")
        public void setEmi(final Money emi) {
        this.emi = emi;
    }

    @java.lang.SuppressWarnings("all")
        public void setOriginalEmi(final Money originalEmi) {
        this.originalEmi = originalEmi;
    }

    @java.lang.SuppressWarnings("all")
        public void setFutureUnrecognizedInterest(final Money futureUnrecognizedInterest) {
        this.futureUnrecognizedInterest = futureUnrecognizedInterest;
    }

    @java.lang.SuppressWarnings("all")
        public MathContext getMc() {
        return this.mc;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isInterestMovedUpward() {
        return this.isInterestMovedUpward;
    }

    @java.lang.SuppressWarnings("all")
        public void setInterestMovedUpward(final boolean isInterestMovedUpward) {
        this.isInterestMovedUpward = isInterestMovedUpward;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isInterestPaymentGrace() {
        return this.interestPaymentGrace;
    }

    @java.lang.SuppressWarnings("all")
        public void setInterestPaymentGrace(final boolean interestPaymentGrace) {
        this.interestPaymentGrace = interestPaymentGrace;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalDisbursedAmount(final Money totalDisbursedAmount) {
        this.totalDisbursedAmount = totalDisbursedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalCapitalizedIncomeAmount(final Money totalCapitalizedIncomeAmount) {
        this.totalCapitalizedIncomeAmount = totalCapitalizedIncomeAmount;
    }

    @java.lang.SuppressWarnings("all")
        public ILoanConfigurationDetails getLoanProductRelatedDetail() {
        return this.loanProductRelatedDetail;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrency(final MonetaryCurrency currency) {
        this.currency = currency;
    }

    @java.lang.SuppressWarnings("all")
        public Money getCreditedPrincipalMovedDueReAge() {
        return this.creditedPrincipalMovedDueReAge;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreditedPrincipalMovedDueReAge(final Money creditedPrincipalMovedDueReAge) {
        this.creditedPrincipalMovedDueReAge = creditedPrincipalMovedDueReAge;
    }

    @java.lang.SuppressWarnings("all")
        public Money getCreditedInterestMovedDueReAge() {
        return this.creditedInterestMovedDueReAge;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreditedInterestMovedDueReAge(final Money creditedInterestMovedDueReAge) {
        this.creditedInterestMovedDueReAge = creditedInterestMovedDueReAge;
    }

    @java.lang.SuppressWarnings("all")
        public void setInterestMovedDownward(final boolean isInterestMovedDownward) {
        this.isInterestMovedDownward = isInterestMovedDownward;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isInterestMovedDownward() {
        return this.isInterestMovedDownward;
    }

    @java.lang.SuppressWarnings("all")
        public void setReAged(final boolean reAged) {
        this.reAged = reAged;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isReAged() {
        return this.reAged;
    }

    @java.lang.SuppressWarnings("all")
        public void setReAgedEarlyRepaymentHolder(final boolean reAgedEarlyRepaymentHolder) {
        this.reAgedEarlyRepaymentHolder = reAgedEarlyRepaymentHolder;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isReAgedEarlyRepaymentHolder() {
        return this.reAgedEarlyRepaymentHolder;
    }

    @java.lang.SuppressWarnings("all")
        public void setFixedInterest(final Money fixedInterest) {
        this.fixedInterest = fixedInterest;
    }
}
