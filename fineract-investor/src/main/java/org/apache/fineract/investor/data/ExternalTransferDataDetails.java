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
package org.apache.fineract.investor.data;

import java.math.BigDecimal;

public class ExternalTransferDataDetails {
    private Long detailsId;
    private BigDecimal totalOutstanding;
    private BigDecimal totalPrincipalOutstanding;
    private BigDecimal totalInterestOutstanding;
    private BigDecimal totalFeeChargesOutstanding;
    private BigDecimal totalPenaltyChargesOutstanding;
    private BigDecimal totalOverpaid;

    @java.lang.SuppressWarnings("all")
        public Long getDetailsId() {
        return this.detailsId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalOutstanding() {
        return this.totalOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalPrincipalOutstanding() {
        return this.totalPrincipalOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalInterestOutstanding() {
        return this.totalInterestOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalFeeChargesOutstanding() {
        return this.totalFeeChargesOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalPenaltyChargesOutstanding() {
        return this.totalPenaltyChargesOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalOverpaid() {
        return this.totalOverpaid;
    }

    @java.lang.SuppressWarnings("all")
        public void setDetailsId(final Long detailsId) {
        this.detailsId = detailsId;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalOutstanding(final BigDecimal totalOutstanding) {
        this.totalOutstanding = totalOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalPrincipalOutstanding(final BigDecimal totalPrincipalOutstanding) {
        this.totalPrincipalOutstanding = totalPrincipalOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalInterestOutstanding(final BigDecimal totalInterestOutstanding) {
        this.totalInterestOutstanding = totalInterestOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalFeeChargesOutstanding(final BigDecimal totalFeeChargesOutstanding) {
        this.totalFeeChargesOutstanding = totalFeeChargesOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalPenaltyChargesOutstanding(final BigDecimal totalPenaltyChargesOutstanding) {
        this.totalPenaltyChargesOutstanding = totalPenaltyChargesOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalOverpaid(final BigDecimal totalOverpaid) {
        this.totalOverpaid = totalOverpaid;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ExternalTransferDataDetails)) return false;
        final ExternalTransferDataDetails other = (ExternalTransferDataDetails) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$detailsId = this.getDetailsId();
        final java.lang.Object other$detailsId = other.getDetailsId();
        if (this$detailsId == null ? other$detailsId != null : !this$detailsId.equals(other$detailsId)) return false;
        final java.lang.Object this$totalOutstanding = this.getTotalOutstanding();
        final java.lang.Object other$totalOutstanding = other.getTotalOutstanding();
        if (this$totalOutstanding == null ? other$totalOutstanding != null : !this$totalOutstanding.equals(other$totalOutstanding)) return false;
        final java.lang.Object this$totalPrincipalOutstanding = this.getTotalPrincipalOutstanding();
        final java.lang.Object other$totalPrincipalOutstanding = other.getTotalPrincipalOutstanding();
        if (this$totalPrincipalOutstanding == null ? other$totalPrincipalOutstanding != null : !this$totalPrincipalOutstanding.equals(other$totalPrincipalOutstanding)) return false;
        final java.lang.Object this$totalInterestOutstanding = this.getTotalInterestOutstanding();
        final java.lang.Object other$totalInterestOutstanding = other.getTotalInterestOutstanding();
        if (this$totalInterestOutstanding == null ? other$totalInterestOutstanding != null : !this$totalInterestOutstanding.equals(other$totalInterestOutstanding)) return false;
        final java.lang.Object this$totalFeeChargesOutstanding = this.getTotalFeeChargesOutstanding();
        final java.lang.Object other$totalFeeChargesOutstanding = other.getTotalFeeChargesOutstanding();
        if (this$totalFeeChargesOutstanding == null ? other$totalFeeChargesOutstanding != null : !this$totalFeeChargesOutstanding.equals(other$totalFeeChargesOutstanding)) return false;
        final java.lang.Object this$totalPenaltyChargesOutstanding = this.getTotalPenaltyChargesOutstanding();
        final java.lang.Object other$totalPenaltyChargesOutstanding = other.getTotalPenaltyChargesOutstanding();
        if (this$totalPenaltyChargesOutstanding == null ? other$totalPenaltyChargesOutstanding != null : !this$totalPenaltyChargesOutstanding.equals(other$totalPenaltyChargesOutstanding)) return false;
        final java.lang.Object this$totalOverpaid = this.getTotalOverpaid();
        final java.lang.Object other$totalOverpaid = other.getTotalOverpaid();
        if (this$totalOverpaid == null ? other$totalOverpaid != null : !this$totalOverpaid.equals(other$totalOverpaid)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ExternalTransferDataDetails;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $detailsId = this.getDetailsId();
        result = result * PRIME + ($detailsId == null ? 43 : $detailsId.hashCode());
        final java.lang.Object $totalOutstanding = this.getTotalOutstanding();
        result = result * PRIME + ($totalOutstanding == null ? 43 : $totalOutstanding.hashCode());
        final java.lang.Object $totalPrincipalOutstanding = this.getTotalPrincipalOutstanding();
        result = result * PRIME + ($totalPrincipalOutstanding == null ? 43 : $totalPrincipalOutstanding.hashCode());
        final java.lang.Object $totalInterestOutstanding = this.getTotalInterestOutstanding();
        result = result * PRIME + ($totalInterestOutstanding == null ? 43 : $totalInterestOutstanding.hashCode());
        final java.lang.Object $totalFeeChargesOutstanding = this.getTotalFeeChargesOutstanding();
        result = result * PRIME + ($totalFeeChargesOutstanding == null ? 43 : $totalFeeChargesOutstanding.hashCode());
        final java.lang.Object $totalPenaltyChargesOutstanding = this.getTotalPenaltyChargesOutstanding();
        result = result * PRIME + ($totalPenaltyChargesOutstanding == null ? 43 : $totalPenaltyChargesOutstanding.hashCode());
        final java.lang.Object $totalOverpaid = this.getTotalOverpaid();
        result = result * PRIME + ($totalOverpaid == null ? 43 : $totalOverpaid.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ExternalTransferDataDetails(detailsId=" + this.getDetailsId() + ", totalOutstanding=" + this.getTotalOutstanding() + ", totalPrincipalOutstanding=" + this.getTotalPrincipalOutstanding() + ", totalInterestOutstanding=" + this.getTotalInterestOutstanding() + ", totalFeeChargesOutstanding=" + this.getTotalFeeChargesOutstanding() + ", totalPenaltyChargesOutstanding=" + this.getTotalPenaltyChargesOutstanding() + ", totalOverpaid=" + this.getTotalOverpaid() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ExternalTransferDataDetails(final Long detailsId, final BigDecimal totalOutstanding, final BigDecimal totalPrincipalOutstanding, final BigDecimal totalInterestOutstanding, final BigDecimal totalFeeChargesOutstanding, final BigDecimal totalPenaltyChargesOutstanding, final BigDecimal totalOverpaid) {
        this.detailsId = detailsId;
        this.totalOutstanding = totalOutstanding;
        this.totalPrincipalOutstanding = totalPrincipalOutstanding;
        this.totalInterestOutstanding = totalInterestOutstanding;
        this.totalFeeChargesOutstanding = totalFeeChargesOutstanding;
        this.totalPenaltyChargesOutstanding = totalPenaltyChargesOutstanding;
        this.totalOverpaid = totalOverpaid;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalTransferDataDetails() {
    }
}
