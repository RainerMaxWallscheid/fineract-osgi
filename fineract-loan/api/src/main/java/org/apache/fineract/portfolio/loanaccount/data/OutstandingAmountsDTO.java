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

import org.apache.fineract.organisation.monetary.domain.MonetaryCurrency;
import org.apache.fineract.organisation.monetary.domain.Money;

public class OutstandingAmountsDTO {
    private Money principal;
    private Money interest;
    private Money feeCharges;
    private Money penaltyCharges;

    public OutstandingAmountsDTO(MonetaryCurrency currency) {
        this.principal = Money.zero(currency);
        this.interest = Money.zero(currency);
        this.feeCharges = Money.zero(currency);
        this.penaltyCharges = Money.zero(currency);
    }

    public Money getTotalOutstanding() {
        return  //
        //
        //
        principal().plus(interest()).plus(feeCharges()).plus(penaltyCharges());
    }

    public OutstandingAmountsDTO plusPrincipal(Money principal) {
        this.principal = this.principal.plus(principal);
        return this;
    }

    public OutstandingAmountsDTO plusInterest(Money interest) {
        this.interest = this.interest.plus(interest);
        return this;
    }

    public OutstandingAmountsDTO plusFeeCharges(Money feeCharges) {
        this.feeCharges = this.feeCharges.plus(feeCharges);
        return this;
    }

    public OutstandingAmountsDTO plusPenaltyCharges(Money penaltyCharges) {
        this.penaltyCharges = this.penaltyCharges.plus(penaltyCharges);
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public Money principal() {
        return this.principal;
    }

    @java.lang.SuppressWarnings("all")
        public Money interest() {
        return this.interest;
    }

    @java.lang.SuppressWarnings("all")
        public Money feeCharges() {
        return this.feeCharges;
    }

    @java.lang.SuppressWarnings("all")
        public Money penaltyCharges() {
        return this.penaltyCharges;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OutstandingAmountsDTO principal(final Money principal) {
        this.principal = principal;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OutstandingAmountsDTO interest(final Money interest) {
        this.interest = interest;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OutstandingAmountsDTO feeCharges(final Money feeCharges) {
        this.feeCharges = feeCharges;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OutstandingAmountsDTO penaltyCharges(final Money penaltyCharges) {
        this.penaltyCharges = penaltyCharges;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof OutstandingAmountsDTO)) return false;
        final OutstandingAmountsDTO other = (OutstandingAmountsDTO) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$principal = this.principal();
        final java.lang.Object other$principal = other.principal();
        if (this$principal == null ? other$principal != null : !this$principal.equals(other$principal)) return false;
        final java.lang.Object this$interest = this.interest();
        final java.lang.Object other$interest = other.interest();
        if (this$interest == null ? other$interest != null : !this$interest.equals(other$interest)) return false;
        final java.lang.Object this$feeCharges = this.feeCharges();
        final java.lang.Object other$feeCharges = other.feeCharges();
        if (this$feeCharges == null ? other$feeCharges != null : !this$feeCharges.equals(other$feeCharges)) return false;
        final java.lang.Object this$penaltyCharges = this.penaltyCharges();
        final java.lang.Object other$penaltyCharges = other.penaltyCharges();
        if (this$penaltyCharges == null ? other$penaltyCharges != null : !this$penaltyCharges.equals(other$penaltyCharges)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof OutstandingAmountsDTO;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $principal = this.principal();
        result = result * PRIME + ($principal == null ? 43 : $principal.hashCode());
        final java.lang.Object $interest = this.interest();
        result = result * PRIME + ($interest == null ? 43 : $interest.hashCode());
        final java.lang.Object $feeCharges = this.feeCharges();
        result = result * PRIME + ($feeCharges == null ? 43 : $feeCharges.hashCode());
        final java.lang.Object $penaltyCharges = this.penaltyCharges();
        result = result * PRIME + ($penaltyCharges == null ? 43 : $penaltyCharges.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "OutstandingAmountsDTO(principal=" + this.principal() + ", interest=" + this.interest() + ", feeCharges=" + this.feeCharges() + ", penaltyCharges=" + this.penaltyCharges() + ")";
    }
}
