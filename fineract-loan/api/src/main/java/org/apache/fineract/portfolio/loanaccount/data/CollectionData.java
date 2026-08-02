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
import java.util.Collection;

public final class CollectionData {
    private BigDecimal availableDisbursementAmount;
    private BigDecimal availableDisbursementAmountWithOverApplied;
    private Long pastDueDays;
    private LocalDate pastDueDate;
    private LocalDate nextPaymentDueDate;
    private BigDecimal nextPaymentAmount;
    private Long delinquentDays;
    private LocalDate delinquentDate;
    private BigDecimal delinquentAmount;
    private LocalDate lastPaymentDate;
    private BigDecimal lastPaymentAmount;
    private LocalDate lastRepaymentDate;
    private BigDecimal lastRepaymentAmount;
    public Collection<DelinquencyPausePeriod> delinquencyPausePeriods;
    public Collection<InstallmentLevelDelinquency> installmentLevelDelinquency;
    private BigDecimal delinquentPrincipal;
    private BigDecimal delinquentInterest;
    private BigDecimal delinquentFee;
    private BigDecimal delinquentPenalty;

    public static CollectionData template() {
        final BigDecimal zero = BigDecimal.ZERO;
        return new CollectionData(zero, zero, 0L, null, null, zero, 0L, null, zero, null, zero, null, zero, null, null, zero, zero, zero, zero);
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAvailableDisbursementAmount() {
        return this.availableDisbursementAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAvailableDisbursementAmountWithOverApplied() {
        return this.availableDisbursementAmountWithOverApplied;
    }

    @java.lang.SuppressWarnings("all")
        public Long getPastDueDays() {
        return this.pastDueDays;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getPastDueDate() {
        return this.pastDueDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getNextPaymentDueDate() {
        return this.nextPaymentDueDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getNextPaymentAmount() {
        return this.nextPaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Long getDelinquentDays() {
        return this.delinquentDays;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDelinquentDate() {
        return this.delinquentDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDelinquentAmount() {
        return this.delinquentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getLastPaymentDate() {
        return this.lastPaymentDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getLastPaymentAmount() {
        return this.lastPaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getLastRepaymentDate() {
        return this.lastRepaymentDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getLastRepaymentAmount() {
        return this.lastRepaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<DelinquencyPausePeriod> getDelinquencyPausePeriods() {
        return this.delinquencyPausePeriods;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<InstallmentLevelDelinquency> getInstallmentLevelDelinquency() {
        return this.installmentLevelDelinquency;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDelinquentPrincipal() {
        return this.delinquentPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDelinquentInterest() {
        return this.delinquentInterest;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDelinquentFee() {
        return this.delinquentFee;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDelinquentPenalty() {
        return this.delinquentPenalty;
    }

    @java.lang.SuppressWarnings("all")
        public void setAvailableDisbursementAmount(final BigDecimal availableDisbursementAmount) {
        this.availableDisbursementAmount = availableDisbursementAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setAvailableDisbursementAmountWithOverApplied(final BigDecimal availableDisbursementAmountWithOverApplied) {
        this.availableDisbursementAmountWithOverApplied = availableDisbursementAmountWithOverApplied;
    }

    @java.lang.SuppressWarnings("all")
        public void setPastDueDays(final Long pastDueDays) {
        this.pastDueDays = pastDueDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setPastDueDate(final LocalDate pastDueDate) {
        this.pastDueDate = pastDueDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setNextPaymentDueDate(final LocalDate nextPaymentDueDate) {
        this.nextPaymentDueDate = nextPaymentDueDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setNextPaymentAmount(final BigDecimal nextPaymentAmount) {
        this.nextPaymentAmount = nextPaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentDays(final Long delinquentDays) {
        this.delinquentDays = delinquentDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentDate(final LocalDate delinquentDate) {
        this.delinquentDate = delinquentDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentAmount(final BigDecimal delinquentAmount) {
        this.delinquentAmount = delinquentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setLastPaymentDate(final LocalDate lastPaymentDate) {
        this.lastPaymentDate = lastPaymentDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setLastPaymentAmount(final BigDecimal lastPaymentAmount) {
        this.lastPaymentAmount = lastPaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setLastRepaymentDate(final LocalDate lastRepaymentDate) {
        this.lastRepaymentDate = lastRepaymentDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setLastRepaymentAmount(final BigDecimal lastRepaymentAmount) {
        this.lastRepaymentAmount = lastRepaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyPausePeriods(final Collection<DelinquencyPausePeriod> delinquencyPausePeriods) {
        this.delinquencyPausePeriods = delinquencyPausePeriods;
    }

    @java.lang.SuppressWarnings("all")
        public void setInstallmentLevelDelinquency(final Collection<InstallmentLevelDelinquency> installmentLevelDelinquency) {
        this.installmentLevelDelinquency = installmentLevelDelinquency;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentPrincipal(final BigDecimal delinquentPrincipal) {
        this.delinquentPrincipal = delinquentPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentInterest(final BigDecimal delinquentInterest) {
        this.delinquentInterest = delinquentInterest;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentFee(final BigDecimal delinquentFee) {
        this.delinquentFee = delinquentFee;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentPenalty(final BigDecimal delinquentPenalty) {
        this.delinquentPenalty = delinquentPenalty;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CollectionData)) return false;
        final CollectionData other = (CollectionData) o;
        final java.lang.Object this$pastDueDays = this.getPastDueDays();
        final java.lang.Object other$pastDueDays = other.getPastDueDays();
        if (this$pastDueDays == null ? other$pastDueDays != null : !this$pastDueDays.equals(other$pastDueDays)) return false;
        final java.lang.Object this$delinquentDays = this.getDelinquentDays();
        final java.lang.Object other$delinquentDays = other.getDelinquentDays();
        if (this$delinquentDays == null ? other$delinquentDays != null : !this$delinquentDays.equals(other$delinquentDays)) return false;
        final java.lang.Object this$availableDisbursementAmount = this.getAvailableDisbursementAmount();
        final java.lang.Object other$availableDisbursementAmount = other.getAvailableDisbursementAmount();
        if (this$availableDisbursementAmount == null ? other$availableDisbursementAmount != null : !this$availableDisbursementAmount.equals(other$availableDisbursementAmount)) return false;
        final java.lang.Object this$availableDisbursementAmountWithOverApplied = this.getAvailableDisbursementAmountWithOverApplied();
        final java.lang.Object other$availableDisbursementAmountWithOverApplied = other.getAvailableDisbursementAmountWithOverApplied();
        if (this$availableDisbursementAmountWithOverApplied == null ? other$availableDisbursementAmountWithOverApplied != null : !this$availableDisbursementAmountWithOverApplied.equals(other$availableDisbursementAmountWithOverApplied)) return false;
        final java.lang.Object this$pastDueDate = this.getPastDueDate();
        final java.lang.Object other$pastDueDate = other.getPastDueDate();
        if (this$pastDueDate == null ? other$pastDueDate != null : !this$pastDueDate.equals(other$pastDueDate)) return false;
        final java.lang.Object this$nextPaymentDueDate = this.getNextPaymentDueDate();
        final java.lang.Object other$nextPaymentDueDate = other.getNextPaymentDueDate();
        if (this$nextPaymentDueDate == null ? other$nextPaymentDueDate != null : !this$nextPaymentDueDate.equals(other$nextPaymentDueDate)) return false;
        final java.lang.Object this$nextPaymentAmount = this.getNextPaymentAmount();
        final java.lang.Object other$nextPaymentAmount = other.getNextPaymentAmount();
        if (this$nextPaymentAmount == null ? other$nextPaymentAmount != null : !this$nextPaymentAmount.equals(other$nextPaymentAmount)) return false;
        final java.lang.Object this$delinquentDate = this.getDelinquentDate();
        final java.lang.Object other$delinquentDate = other.getDelinquentDate();
        if (this$delinquentDate == null ? other$delinquentDate != null : !this$delinquentDate.equals(other$delinquentDate)) return false;
        final java.lang.Object this$delinquentAmount = this.getDelinquentAmount();
        final java.lang.Object other$delinquentAmount = other.getDelinquentAmount();
        if (this$delinquentAmount == null ? other$delinquentAmount != null : !this$delinquentAmount.equals(other$delinquentAmount)) return false;
        final java.lang.Object this$lastPaymentDate = this.getLastPaymentDate();
        final java.lang.Object other$lastPaymentDate = other.getLastPaymentDate();
        if (this$lastPaymentDate == null ? other$lastPaymentDate != null : !this$lastPaymentDate.equals(other$lastPaymentDate)) return false;
        final java.lang.Object this$lastPaymentAmount = this.getLastPaymentAmount();
        final java.lang.Object other$lastPaymentAmount = other.getLastPaymentAmount();
        if (this$lastPaymentAmount == null ? other$lastPaymentAmount != null : !this$lastPaymentAmount.equals(other$lastPaymentAmount)) return false;
        final java.lang.Object this$lastRepaymentDate = this.getLastRepaymentDate();
        final java.lang.Object other$lastRepaymentDate = other.getLastRepaymentDate();
        if (this$lastRepaymentDate == null ? other$lastRepaymentDate != null : !this$lastRepaymentDate.equals(other$lastRepaymentDate)) return false;
        final java.lang.Object this$lastRepaymentAmount = this.getLastRepaymentAmount();
        final java.lang.Object other$lastRepaymentAmount = other.getLastRepaymentAmount();
        if (this$lastRepaymentAmount == null ? other$lastRepaymentAmount != null : !this$lastRepaymentAmount.equals(other$lastRepaymentAmount)) return false;
        final java.lang.Object this$delinquencyPausePeriods = this.getDelinquencyPausePeriods();
        final java.lang.Object other$delinquencyPausePeriods = other.getDelinquencyPausePeriods();
        if (this$delinquencyPausePeriods == null ? other$delinquencyPausePeriods != null : !this$delinquencyPausePeriods.equals(other$delinquencyPausePeriods)) return false;
        final java.lang.Object this$installmentLevelDelinquency = this.getInstallmentLevelDelinquency();
        final java.lang.Object other$installmentLevelDelinquency = other.getInstallmentLevelDelinquency();
        if (this$installmentLevelDelinquency == null ? other$installmentLevelDelinquency != null : !this$installmentLevelDelinquency.equals(other$installmentLevelDelinquency)) return false;
        final java.lang.Object this$delinquentPrincipal = this.getDelinquentPrincipal();
        final java.lang.Object other$delinquentPrincipal = other.getDelinquentPrincipal();
        if (this$delinquentPrincipal == null ? other$delinquentPrincipal != null : !this$delinquentPrincipal.equals(other$delinquentPrincipal)) return false;
        final java.lang.Object this$delinquentInterest = this.getDelinquentInterest();
        final java.lang.Object other$delinquentInterest = other.getDelinquentInterest();
        if (this$delinquentInterest == null ? other$delinquentInterest != null : !this$delinquentInterest.equals(other$delinquentInterest)) return false;
        final java.lang.Object this$delinquentFee = this.getDelinquentFee();
        final java.lang.Object other$delinquentFee = other.getDelinquentFee();
        if (this$delinquentFee == null ? other$delinquentFee != null : !this$delinquentFee.equals(other$delinquentFee)) return false;
        final java.lang.Object this$delinquentPenalty = this.getDelinquentPenalty();
        final java.lang.Object other$delinquentPenalty = other.getDelinquentPenalty();
        if (this$delinquentPenalty == null ? other$delinquentPenalty != null : !this$delinquentPenalty.equals(other$delinquentPenalty)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $pastDueDays = this.getPastDueDays();
        result = result * PRIME + ($pastDueDays == null ? 43 : $pastDueDays.hashCode());
        final java.lang.Object $delinquentDays = this.getDelinquentDays();
        result = result * PRIME + ($delinquentDays == null ? 43 : $delinquentDays.hashCode());
        final java.lang.Object $availableDisbursementAmount = this.getAvailableDisbursementAmount();
        result = result * PRIME + ($availableDisbursementAmount == null ? 43 : $availableDisbursementAmount.hashCode());
        final java.lang.Object $availableDisbursementAmountWithOverApplied = this.getAvailableDisbursementAmountWithOverApplied();
        result = result * PRIME + ($availableDisbursementAmountWithOverApplied == null ? 43 : $availableDisbursementAmountWithOverApplied.hashCode());
        final java.lang.Object $pastDueDate = this.getPastDueDate();
        result = result * PRIME + ($pastDueDate == null ? 43 : $pastDueDate.hashCode());
        final java.lang.Object $nextPaymentDueDate = this.getNextPaymentDueDate();
        result = result * PRIME + ($nextPaymentDueDate == null ? 43 : $nextPaymentDueDate.hashCode());
        final java.lang.Object $nextPaymentAmount = this.getNextPaymentAmount();
        result = result * PRIME + ($nextPaymentAmount == null ? 43 : $nextPaymentAmount.hashCode());
        final java.lang.Object $delinquentDate = this.getDelinquentDate();
        result = result * PRIME + ($delinquentDate == null ? 43 : $delinquentDate.hashCode());
        final java.lang.Object $delinquentAmount = this.getDelinquentAmount();
        result = result * PRIME + ($delinquentAmount == null ? 43 : $delinquentAmount.hashCode());
        final java.lang.Object $lastPaymentDate = this.getLastPaymentDate();
        result = result * PRIME + ($lastPaymentDate == null ? 43 : $lastPaymentDate.hashCode());
        final java.lang.Object $lastPaymentAmount = this.getLastPaymentAmount();
        result = result * PRIME + ($lastPaymentAmount == null ? 43 : $lastPaymentAmount.hashCode());
        final java.lang.Object $lastRepaymentDate = this.getLastRepaymentDate();
        result = result * PRIME + ($lastRepaymentDate == null ? 43 : $lastRepaymentDate.hashCode());
        final java.lang.Object $lastRepaymentAmount = this.getLastRepaymentAmount();
        result = result * PRIME + ($lastRepaymentAmount == null ? 43 : $lastRepaymentAmount.hashCode());
        final java.lang.Object $delinquencyPausePeriods = this.getDelinquencyPausePeriods();
        result = result * PRIME + ($delinquencyPausePeriods == null ? 43 : $delinquencyPausePeriods.hashCode());
        final java.lang.Object $installmentLevelDelinquency = this.getInstallmentLevelDelinquency();
        result = result * PRIME + ($installmentLevelDelinquency == null ? 43 : $installmentLevelDelinquency.hashCode());
        final java.lang.Object $delinquentPrincipal = this.getDelinquentPrincipal();
        result = result * PRIME + ($delinquentPrincipal == null ? 43 : $delinquentPrincipal.hashCode());
        final java.lang.Object $delinquentInterest = this.getDelinquentInterest();
        result = result * PRIME + ($delinquentInterest == null ? 43 : $delinquentInterest.hashCode());
        final java.lang.Object $delinquentFee = this.getDelinquentFee();
        result = result * PRIME + ($delinquentFee == null ? 43 : $delinquentFee.hashCode());
        final java.lang.Object $delinquentPenalty = this.getDelinquentPenalty();
        result = result * PRIME + ($delinquentPenalty == null ? 43 : $delinquentPenalty.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CollectionData(availableDisbursementAmount=" + this.getAvailableDisbursementAmount() + ", availableDisbursementAmountWithOverApplied=" + this.getAvailableDisbursementAmountWithOverApplied() + ", pastDueDays=" + this.getPastDueDays() + ", pastDueDate=" + this.getPastDueDate() + ", nextPaymentDueDate=" + this.getNextPaymentDueDate() + ", nextPaymentAmount=" + this.getNextPaymentAmount() + ", delinquentDays=" + this.getDelinquentDays() + ", delinquentDate=" + this.getDelinquentDate() + ", delinquentAmount=" + this.getDelinquentAmount() + ", lastPaymentDate=" + this.getLastPaymentDate() + ", lastPaymentAmount=" + this.getLastPaymentAmount() + ", lastRepaymentDate=" + this.getLastRepaymentDate() + ", lastRepaymentAmount=" + this.getLastRepaymentAmount() + ", delinquencyPausePeriods=" + this.getDelinquencyPausePeriods() + ", installmentLevelDelinquency=" + this.getInstallmentLevelDelinquency() + ", delinquentPrincipal=" + this.getDelinquentPrincipal() + ", delinquentInterest=" + this.getDelinquentInterest() + ", delinquentFee=" + this.getDelinquentFee() + ", delinquentPenalty=" + this.getDelinquentPenalty() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CollectionData(final BigDecimal availableDisbursementAmount, final BigDecimal availableDisbursementAmountWithOverApplied, final Long pastDueDays, final LocalDate pastDueDate, final LocalDate nextPaymentDueDate, final BigDecimal nextPaymentAmount, final Long delinquentDays, final LocalDate delinquentDate, final BigDecimal delinquentAmount, final LocalDate lastPaymentDate, final BigDecimal lastPaymentAmount, final LocalDate lastRepaymentDate, final BigDecimal lastRepaymentAmount, final Collection<DelinquencyPausePeriod> delinquencyPausePeriods, final Collection<InstallmentLevelDelinquency> installmentLevelDelinquency, final BigDecimal delinquentPrincipal, final BigDecimal delinquentInterest, final BigDecimal delinquentFee, final BigDecimal delinquentPenalty) {
        this.availableDisbursementAmount = availableDisbursementAmount;
        this.availableDisbursementAmountWithOverApplied = availableDisbursementAmountWithOverApplied;
        this.pastDueDays = pastDueDays;
        this.pastDueDate = pastDueDate;
        this.nextPaymentDueDate = nextPaymentDueDate;
        this.nextPaymentAmount = nextPaymentAmount;
        this.delinquentDays = delinquentDays;
        this.delinquentDate = delinquentDate;
        this.delinquentAmount = delinquentAmount;
        this.lastPaymentDate = lastPaymentDate;
        this.lastPaymentAmount = lastPaymentAmount;
        this.lastRepaymentDate = lastRepaymentDate;
        this.lastRepaymentAmount = lastRepaymentAmount;
        this.delinquencyPausePeriods = delinquencyPausePeriods;
        this.installmentLevelDelinquency = installmentLevelDelinquency;
        this.delinquentPrincipal = delinquentPrincipal;
        this.delinquentInterest = delinquentInterest;
        this.delinquentFee = delinquentFee;
        this.delinquentPenalty = delinquentPenalty;
    }
}
