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

import org.apache.fineract.organisation.monetary.domain.Money;

public class AccrualChargeData {
    private final Long loanChargeId;
    private final Long loanInstallmentChargeId;
    private final boolean isPenalty;
    private Money chargeAmount;
    private Money chargeAccruable;
    private Money chargeAccrued;
    private Money transactionAccrued;

    @java.lang.SuppressWarnings("all")
        public Long getLoanChargeId() {
        return this.loanChargeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanInstallmentChargeId() {
        return this.loanInstallmentChargeId;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isPenalty() {
        return this.isPenalty;
    }

    @java.lang.SuppressWarnings("all")
        public Money getChargeAmount() {
        return this.chargeAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Money getChargeAccruable() {
        return this.chargeAccruable;
    }

    @java.lang.SuppressWarnings("all")
        public Money getChargeAccrued() {
        return this.chargeAccrued;
    }

    @java.lang.SuppressWarnings("all")
        public Money getTransactionAccrued() {
        return this.transactionAccrued;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccrualChargeData setChargeAmount(final Money chargeAmount) {
        this.chargeAmount = chargeAmount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccrualChargeData setChargeAccruable(final Money chargeAccruable) {
        this.chargeAccruable = chargeAccruable;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccrualChargeData setChargeAccrued(final Money chargeAccrued) {
        this.chargeAccrued = chargeAccrued;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccrualChargeData setTransactionAccrued(final Money transactionAccrued) {
        this.transactionAccrued = transactionAccrued;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AccrualChargeData)) return false;
        final AccrualChargeData other = (AccrualChargeData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isPenalty() != other.isPenalty()) return false;
        final java.lang.Object this$loanChargeId = this.getLoanChargeId();
        final java.lang.Object other$loanChargeId = other.getLoanChargeId();
        if (this$loanChargeId == null ? other$loanChargeId != null : !this$loanChargeId.equals(other$loanChargeId)) return false;
        final java.lang.Object this$loanInstallmentChargeId = this.getLoanInstallmentChargeId();
        final java.lang.Object other$loanInstallmentChargeId = other.getLoanInstallmentChargeId();
        if (this$loanInstallmentChargeId == null ? other$loanInstallmentChargeId != null : !this$loanInstallmentChargeId.equals(other$loanInstallmentChargeId)) return false;
        final java.lang.Object this$chargeAmount = this.getChargeAmount();
        final java.lang.Object other$chargeAmount = other.getChargeAmount();
        if (this$chargeAmount == null ? other$chargeAmount != null : !this$chargeAmount.equals(other$chargeAmount)) return false;
        final java.lang.Object this$chargeAccruable = this.getChargeAccruable();
        final java.lang.Object other$chargeAccruable = other.getChargeAccruable();
        if (this$chargeAccruable == null ? other$chargeAccruable != null : !this$chargeAccruable.equals(other$chargeAccruable)) return false;
        final java.lang.Object this$chargeAccrued = this.getChargeAccrued();
        final java.lang.Object other$chargeAccrued = other.getChargeAccrued();
        if (this$chargeAccrued == null ? other$chargeAccrued != null : !this$chargeAccrued.equals(other$chargeAccrued)) return false;
        final java.lang.Object this$transactionAccrued = this.getTransactionAccrued();
        final java.lang.Object other$transactionAccrued = other.getTransactionAccrued();
        if (this$transactionAccrued == null ? other$transactionAccrued != null : !this$transactionAccrued.equals(other$transactionAccrued)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AccrualChargeData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isPenalty() ? 79 : 97);
        final java.lang.Object $loanChargeId = this.getLoanChargeId();
        result = result * PRIME + ($loanChargeId == null ? 43 : $loanChargeId.hashCode());
        final java.lang.Object $loanInstallmentChargeId = this.getLoanInstallmentChargeId();
        result = result * PRIME + ($loanInstallmentChargeId == null ? 43 : $loanInstallmentChargeId.hashCode());
        final java.lang.Object $chargeAmount = this.getChargeAmount();
        result = result * PRIME + ($chargeAmount == null ? 43 : $chargeAmount.hashCode());
        final java.lang.Object $chargeAccruable = this.getChargeAccruable();
        result = result * PRIME + ($chargeAccruable == null ? 43 : $chargeAccruable.hashCode());
        final java.lang.Object $chargeAccrued = this.getChargeAccrued();
        result = result * PRIME + ($chargeAccrued == null ? 43 : $chargeAccrued.hashCode());
        final java.lang.Object $transactionAccrued = this.getTransactionAccrued();
        result = result * PRIME + ($transactionAccrued == null ? 43 : $transactionAccrued.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AccrualChargeData(loanChargeId=" + this.getLoanChargeId() + ", loanInstallmentChargeId=" + this.getLoanInstallmentChargeId() + ", isPenalty=" + this.isPenalty() + ", chargeAmount=" + this.getChargeAmount() + ", chargeAccruable=" + this.getChargeAccruable() + ", chargeAccrued=" + this.getChargeAccrued() + ", transactionAccrued=" + this.getTransactionAccrued() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AccrualChargeData(final Long loanChargeId, final Long loanInstallmentChargeId, final boolean isPenalty) {
        this.loanChargeId = loanChargeId;
        this.loanInstallmentChargeId = loanInstallmentChargeId;
        this.isPenalty = isPenalty;
    }
}
