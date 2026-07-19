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

public class LoanRefundRequestData {
    private final BigDecimal principal;
    private final BigDecimal interest;
    private final BigDecimal feeCharges;
    private final BigDecimal penaltyCharges;
    private final BigDecimal overpayment;

    public BigDecimal getTotalAmount() {
        return principal.add(interest).add(feeCharges).add(penaltyCharges);
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipal() {
        return this.principal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterest() {
        return this.interest;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeCharges() {
        return this.feeCharges;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyCharges() {
        return this.penaltyCharges;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOverpayment() {
        return this.overpayment;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanRefundRequestData)) return false;
        final LoanRefundRequestData other = (LoanRefundRequestData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$principal = this.getPrincipal();
        final java.lang.Object other$principal = other.getPrincipal();
        if (this$principal == null ? other$principal != null : !this$principal.equals(other$principal)) return false;
        final java.lang.Object this$interest = this.getInterest();
        final java.lang.Object other$interest = other.getInterest();
        if (this$interest == null ? other$interest != null : !this$interest.equals(other$interest)) return false;
        final java.lang.Object this$feeCharges = this.getFeeCharges();
        final java.lang.Object other$feeCharges = other.getFeeCharges();
        if (this$feeCharges == null ? other$feeCharges != null : !this$feeCharges.equals(other$feeCharges)) return false;
        final java.lang.Object this$penaltyCharges = this.getPenaltyCharges();
        final java.lang.Object other$penaltyCharges = other.getPenaltyCharges();
        if (this$penaltyCharges == null ? other$penaltyCharges != null : !this$penaltyCharges.equals(other$penaltyCharges)) return false;
        final java.lang.Object this$overpayment = this.getOverpayment();
        final java.lang.Object other$overpayment = other.getOverpayment();
        if (this$overpayment == null ? other$overpayment != null : !this$overpayment.equals(other$overpayment)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanRefundRequestData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $principal = this.getPrincipal();
        result = result * PRIME + ($principal == null ? 43 : $principal.hashCode());
        final java.lang.Object $interest = this.getInterest();
        result = result * PRIME + ($interest == null ? 43 : $interest.hashCode());
        final java.lang.Object $feeCharges = this.getFeeCharges();
        result = result * PRIME + ($feeCharges == null ? 43 : $feeCharges.hashCode());
        final java.lang.Object $penaltyCharges = this.getPenaltyCharges();
        result = result * PRIME + ($penaltyCharges == null ? 43 : $penaltyCharges.hashCode());
        final java.lang.Object $overpayment = this.getOverpayment();
        result = result * PRIME + ($overpayment == null ? 43 : $overpayment.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanRefundRequestData(principal=" + this.getPrincipal() + ", interest=" + this.getInterest() + ", feeCharges=" + this.getFeeCharges() + ", penaltyCharges=" + this.getPenaltyCharges() + ", overpayment=" + this.getOverpayment() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanRefundRequestData(final BigDecimal principal, final BigDecimal interest, final BigDecimal feeCharges, final BigDecimal penaltyCharges, final BigDecimal overpayment) {
        this.principal = principal;
        this.interest = interest;
        this.feeCharges = feeCharges;
        this.penaltyCharges = penaltyCharges;
        this.overpayment = overpayment;
    }
}
