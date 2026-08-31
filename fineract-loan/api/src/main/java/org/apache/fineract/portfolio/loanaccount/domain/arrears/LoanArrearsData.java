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
package org.apache.fineract.portfolio.loanaccount.domain.arrears;

import java.math.BigDecimal;
import java.time.LocalDate;

public class LoanArrearsData {
    private BigDecimal principalOverdue;
    private BigDecimal interestOverdue;
    private BigDecimal feeOverdue;
    private BigDecimal penaltyOverdue;
    private BigDecimal totalOverdue;
    private LocalDate overDueSince;
    private boolean isOverdue;

    @java.lang.SuppressWarnings("all")
        public LoanArrearsData() {
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalOverdue() {
        return this.principalOverdue;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestOverdue() {
        return this.interestOverdue;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeOverdue() {
        return this.feeOverdue;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyOverdue() {
        return this.penaltyOverdue;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalOverdue() {
        return this.totalOverdue;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getOverDueSince() {
        return this.overDueSince;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isOverdue() {
        return this.isOverdue;
    }

    @java.lang.SuppressWarnings("all")
        public void setPrincipalOverdue(final BigDecimal principalOverdue) {
        this.principalOverdue = principalOverdue;
    }

    @java.lang.SuppressWarnings("all")
        public void setInterestOverdue(final BigDecimal interestOverdue) {
        this.interestOverdue = interestOverdue;
    }

    @java.lang.SuppressWarnings("all")
        public void setFeeOverdue(final BigDecimal feeOverdue) {
        this.feeOverdue = feeOverdue;
    }

    @java.lang.SuppressWarnings("all")
        public void setPenaltyOverdue(final BigDecimal penaltyOverdue) {
        this.penaltyOverdue = penaltyOverdue;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalOverdue(final BigDecimal totalOverdue) {
        this.totalOverdue = totalOverdue;
    }

    @java.lang.SuppressWarnings("all")
        public void setOverDueSince(final LocalDate overDueSince) {
        this.overDueSince = overDueSince;
    }

    @java.lang.SuppressWarnings("all")
        public void setOverdue(final boolean isOverdue) {
        this.isOverdue = isOverdue;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanArrearsData)) return false;
        final LoanArrearsData other = (LoanArrearsData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isOverdue() != other.isOverdue()) return false;
        final java.lang.Object this$principalOverdue = this.getPrincipalOverdue();
        final java.lang.Object other$principalOverdue = other.getPrincipalOverdue();
        if (this$principalOverdue == null ? other$principalOverdue != null : !this$principalOverdue.equals(other$principalOverdue)) return false;
        final java.lang.Object this$interestOverdue = this.getInterestOverdue();
        final java.lang.Object other$interestOverdue = other.getInterestOverdue();
        if (this$interestOverdue == null ? other$interestOverdue != null : !this$interestOverdue.equals(other$interestOverdue)) return false;
        final java.lang.Object this$feeOverdue = this.getFeeOverdue();
        final java.lang.Object other$feeOverdue = other.getFeeOverdue();
        if (this$feeOverdue == null ? other$feeOverdue != null : !this$feeOverdue.equals(other$feeOverdue)) return false;
        final java.lang.Object this$penaltyOverdue = this.getPenaltyOverdue();
        final java.lang.Object other$penaltyOverdue = other.getPenaltyOverdue();
        if (this$penaltyOverdue == null ? other$penaltyOverdue != null : !this$penaltyOverdue.equals(other$penaltyOverdue)) return false;
        final java.lang.Object this$totalOverdue = this.getTotalOverdue();
        final java.lang.Object other$totalOverdue = other.getTotalOverdue();
        if (this$totalOverdue == null ? other$totalOverdue != null : !this$totalOverdue.equals(other$totalOverdue)) return false;
        final java.lang.Object this$overDueSince = this.getOverDueSince();
        final java.lang.Object other$overDueSince = other.getOverDueSince();
        if (this$overDueSince == null ? other$overDueSince != null : !this$overDueSince.equals(other$overDueSince)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanArrearsData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isOverdue() ? 79 : 97);
        final java.lang.Object $principalOverdue = this.getPrincipalOverdue();
        result = result * PRIME + ($principalOverdue == null ? 43 : $principalOverdue.hashCode());
        final java.lang.Object $interestOverdue = this.getInterestOverdue();
        result = result * PRIME + ($interestOverdue == null ? 43 : $interestOverdue.hashCode());
        final java.lang.Object $feeOverdue = this.getFeeOverdue();
        result = result * PRIME + ($feeOverdue == null ? 43 : $feeOverdue.hashCode());
        final java.lang.Object $penaltyOverdue = this.getPenaltyOverdue();
        result = result * PRIME + ($penaltyOverdue == null ? 43 : $penaltyOverdue.hashCode());
        final java.lang.Object $totalOverdue = this.getTotalOverdue();
        result = result * PRIME + ($totalOverdue == null ? 43 : $totalOverdue.hashCode());
        final java.lang.Object $overDueSince = this.getOverDueSince();
        result = result * PRIME + ($overDueSince == null ? 43 : $overDueSince.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanArrearsData(principalOverdue=" + this.getPrincipalOverdue() + ", interestOverdue=" + this.getInterestOverdue() + ", feeOverdue=" + this.getFeeOverdue() + ", penaltyOverdue=" + this.getPenaltyOverdue() + ", totalOverdue=" + this.getTotalOverdue() + ", overDueSince=" + this.getOverDueSince() + ", isOverdue=" + this.isOverdue() + ")";
    }
}
