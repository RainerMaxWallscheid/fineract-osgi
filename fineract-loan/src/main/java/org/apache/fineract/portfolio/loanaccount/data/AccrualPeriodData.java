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

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import org.apache.fineract.infrastructure.core.service.MathUtil;
import org.apache.fineract.organisation.monetary.domain.Money;

public class AccrualPeriodData {
    private final Integer installmentNumber;
    private final boolean isFirstPeriod;
    private final LocalDate startDate;
    private final LocalDate dueDate;
    private Money interestAmount;
    private Money interestAccruable;
    private Money interestAccrued;
    private Money unrecognizedWaive;
    private Money transactionAccrued;
    private final List<AccrualChargeData> charges = new ArrayList<>();

    public AccrualPeriodData addCharge(final AccrualChargeData charge) {
        charges.add(charge);
        return this;
    }

    public Money getChargeAmount() {
        return charges.stream().map(AccrualChargeData::getChargeAmount).reduce(null, MathUtil::plus);
    }

    public Money getFeeAmount() {
        return charges.stream().filter(charge -> !charge.isPenalty()).map(AccrualChargeData::getChargeAmount).reduce(null, MathUtil::plus);
    }

    public Money getFeeAccrued() {
        return charges.stream().filter(charge -> !charge.isPenalty()).map(AccrualChargeData::getChargeAccrued).reduce(null, MathUtil::plus);
    }

    public Money getPenaltyAccrued() {
        return charges.stream().filter(AccrualChargeData::isPenalty).map(AccrualChargeData::getChargeAccrued).reduce(null, MathUtil::plus);
    }

    public Money getFeeAccruable() {
        return charges.stream().filter(charge -> !charge.isPenalty()).map(AccrualChargeData::getChargeAccruable).reduce(null, MathUtil::plus);
    }

    public Money getPenaltyAccruable() {
        return charges.stream().filter(AccrualChargeData::isPenalty).map(AccrualChargeData::getChargeAccruable).reduce(null, MathUtil::plus);
    }

    @java.lang.SuppressWarnings("all")
        public Integer getInstallmentNumber() {
        return this.installmentNumber;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isFirstPeriod() {
        return this.isFirstPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getStartDate() {
        return this.startDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDueDate() {
        return this.dueDate;
    }

    @java.lang.SuppressWarnings("all")
        public Money getInterestAmount() {
        return this.interestAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Money getInterestAccruable() {
        return this.interestAccruable;
    }

    @java.lang.SuppressWarnings("all")
        public Money getInterestAccrued() {
        return this.interestAccrued;
    }

    @java.lang.SuppressWarnings("all")
        public Money getUnrecognizedWaive() {
        return this.unrecognizedWaive;
    }

    @java.lang.SuppressWarnings("all")
        public Money getTransactionAccrued() {
        return this.transactionAccrued;
    }

    @java.lang.SuppressWarnings("all")
        public List<AccrualChargeData> getCharges() {
        return this.charges;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccrualPeriodData setInterestAmount(final Money interestAmount) {
        this.interestAmount = interestAmount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccrualPeriodData setInterestAccruable(final Money interestAccruable) {
        this.interestAccruable = interestAccruable;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccrualPeriodData setInterestAccrued(final Money interestAccrued) {
        this.interestAccrued = interestAccrued;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccrualPeriodData setUnrecognizedWaive(final Money unrecognizedWaive) {
        this.unrecognizedWaive = unrecognizedWaive;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccrualPeriodData setTransactionAccrued(final Money transactionAccrued) {
        this.transactionAccrued = transactionAccrued;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AccrualPeriodData)) return false;
        final AccrualPeriodData other = (AccrualPeriodData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isFirstPeriod() != other.isFirstPeriod()) return false;
        final java.lang.Object this$installmentNumber = this.getInstallmentNumber();
        final java.lang.Object other$installmentNumber = other.getInstallmentNumber();
        if (this$installmentNumber == null ? other$installmentNumber != null : !this$installmentNumber.equals(other$installmentNumber)) return false;
        final java.lang.Object this$startDate = this.getStartDate();
        final java.lang.Object other$startDate = other.getStartDate();
        if (this$startDate == null ? other$startDate != null : !this$startDate.equals(other$startDate)) return false;
        final java.lang.Object this$dueDate = this.getDueDate();
        final java.lang.Object other$dueDate = other.getDueDate();
        if (this$dueDate == null ? other$dueDate != null : !this$dueDate.equals(other$dueDate)) return false;
        final java.lang.Object this$interestAmount = this.getInterestAmount();
        final java.lang.Object other$interestAmount = other.getInterestAmount();
        if (this$interestAmount == null ? other$interestAmount != null : !this$interestAmount.equals(other$interestAmount)) return false;
        final java.lang.Object this$interestAccruable = this.getInterestAccruable();
        final java.lang.Object other$interestAccruable = other.getInterestAccruable();
        if (this$interestAccruable == null ? other$interestAccruable != null : !this$interestAccruable.equals(other$interestAccruable)) return false;
        final java.lang.Object this$interestAccrued = this.getInterestAccrued();
        final java.lang.Object other$interestAccrued = other.getInterestAccrued();
        if (this$interestAccrued == null ? other$interestAccrued != null : !this$interestAccrued.equals(other$interestAccrued)) return false;
        final java.lang.Object this$unrecognizedWaive = this.getUnrecognizedWaive();
        final java.lang.Object other$unrecognizedWaive = other.getUnrecognizedWaive();
        if (this$unrecognizedWaive == null ? other$unrecognizedWaive != null : !this$unrecognizedWaive.equals(other$unrecognizedWaive)) return false;
        final java.lang.Object this$transactionAccrued = this.getTransactionAccrued();
        final java.lang.Object other$transactionAccrued = other.getTransactionAccrued();
        if (this$transactionAccrued == null ? other$transactionAccrued != null : !this$transactionAccrued.equals(other$transactionAccrued)) return false;
        final java.lang.Object this$charges = this.getCharges();
        final java.lang.Object other$charges = other.getCharges();
        if (this$charges == null ? other$charges != null : !this$charges.equals(other$charges)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AccrualPeriodData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isFirstPeriod() ? 79 : 97);
        final java.lang.Object $installmentNumber = this.getInstallmentNumber();
        result = result * PRIME + ($installmentNumber == null ? 43 : $installmentNumber.hashCode());
        final java.lang.Object $startDate = this.getStartDate();
        result = result * PRIME + ($startDate == null ? 43 : $startDate.hashCode());
        final java.lang.Object $dueDate = this.getDueDate();
        result = result * PRIME + ($dueDate == null ? 43 : $dueDate.hashCode());
        final java.lang.Object $interestAmount = this.getInterestAmount();
        result = result * PRIME + ($interestAmount == null ? 43 : $interestAmount.hashCode());
        final java.lang.Object $interestAccruable = this.getInterestAccruable();
        result = result * PRIME + ($interestAccruable == null ? 43 : $interestAccruable.hashCode());
        final java.lang.Object $interestAccrued = this.getInterestAccrued();
        result = result * PRIME + ($interestAccrued == null ? 43 : $interestAccrued.hashCode());
        final java.lang.Object $unrecognizedWaive = this.getUnrecognizedWaive();
        result = result * PRIME + ($unrecognizedWaive == null ? 43 : $unrecognizedWaive.hashCode());
        final java.lang.Object $transactionAccrued = this.getTransactionAccrued();
        result = result * PRIME + ($transactionAccrued == null ? 43 : $transactionAccrued.hashCode());
        final java.lang.Object $charges = this.getCharges();
        result = result * PRIME + ($charges == null ? 43 : $charges.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AccrualPeriodData(installmentNumber=" + this.getInstallmentNumber() + ", isFirstPeriod=" + this.isFirstPeriod() + ", startDate=" + this.getStartDate() + ", dueDate=" + this.getDueDate() + ", interestAmount=" + this.getInterestAmount() + ", interestAccruable=" + this.getInterestAccruable() + ", interestAccrued=" + this.getInterestAccrued() + ", unrecognizedWaive=" + this.getUnrecognizedWaive() + ", transactionAccrued=" + this.getTransactionAccrued() + ", charges=" + this.getCharges() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AccrualPeriodData(final Integer installmentNumber, final boolean isFirstPeriod, final LocalDate startDate, final LocalDate dueDate) {
        this.installmentNumber = installmentNumber;
        this.isFirstPeriod = isFirstPeriod;
        this.startDate = startDate;
        this.dueDate = dueDate;
    }
}
