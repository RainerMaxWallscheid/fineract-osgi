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

public class LoanFeeData {

    private final BigDecimal feeChargesCharged;
    private final BigDecimal feeAdjustments;
    private final BigDecimal feeChargesDueAtDisbursementCharged;
    private final BigDecimal feeChargesPaid;
    private final BigDecimal feeChargesWaived;
    private final BigDecimal feeChargesWrittenOff;
    private final BigDecimal feeChargesOutstanding;

    @java.lang.SuppressWarnings("all")
    public LoanFeeData(final BigDecimal feeChargesCharged, final BigDecimal feeAdjustments,
            final BigDecimal feeChargesDueAtDisbursementCharged, final BigDecimal feeChargesPaid, final BigDecimal feeChargesWaived,
            final BigDecimal feeChargesWrittenOff, final BigDecimal feeChargesOutstanding) {
        this.feeChargesCharged = feeChargesCharged;
        this.feeAdjustments = feeAdjustments;
        this.feeChargesDueAtDisbursementCharged = feeChargesDueAtDisbursementCharged;
        this.feeChargesPaid = feeChargesPaid;
        this.feeChargesWaived = feeChargesWaived;
        this.feeChargesWrittenOff = feeChargesWrittenOff;
        this.feeChargesOutstanding = feeChargesOutstanding;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getFeeChargesCharged() {
        return this.feeChargesCharged;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getFeeAdjustments() {
        return this.feeAdjustments;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getFeeChargesDueAtDisbursementCharged() {
        return this.feeChargesDueAtDisbursementCharged;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getFeeChargesPaid() {
        return this.feeChargesPaid;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getFeeChargesWaived() {
        return this.feeChargesWaived;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getFeeChargesWrittenOff() {
        return this.feeChargesWrittenOff;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getFeeChargesOutstanding() {
        return this.feeChargesOutstanding;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanFeeData)) return false;
        final LoanFeeData other = (LoanFeeData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$feeChargesCharged = this.getFeeChargesCharged();
        final java.lang.Object other$feeChargesCharged = other.getFeeChargesCharged();
        if (this$feeChargesCharged == null ? other$feeChargesCharged != null : !this$feeChargesCharged.equals(other$feeChargesCharged))
            return false;
        final java.lang.Object this$feeAdjustments = this.getFeeAdjustments();
        final java.lang.Object other$feeAdjustments = other.getFeeAdjustments();
        if (this$feeAdjustments == null ? other$feeAdjustments != null : !this$feeAdjustments.equals(other$feeAdjustments)) return false;
        final java.lang.Object this$feeChargesDueAtDisbursementCharged = this.getFeeChargesDueAtDisbursementCharged();
        final java.lang.Object other$feeChargesDueAtDisbursementCharged = other.getFeeChargesDueAtDisbursementCharged();
        if (this$feeChargesDueAtDisbursementCharged == null ? other$feeChargesDueAtDisbursementCharged != null
                : !this$feeChargesDueAtDisbursementCharged.equals(other$feeChargesDueAtDisbursementCharged))
            return false;
        final java.lang.Object this$feeChargesPaid = this.getFeeChargesPaid();
        final java.lang.Object other$feeChargesPaid = other.getFeeChargesPaid();
        if (this$feeChargesPaid == null ? other$feeChargesPaid != null : !this$feeChargesPaid.equals(other$feeChargesPaid)) return false;
        final java.lang.Object this$feeChargesWaived = this.getFeeChargesWaived();
        final java.lang.Object other$feeChargesWaived = other.getFeeChargesWaived();
        if (this$feeChargesWaived == null ? other$feeChargesWaived != null : !this$feeChargesWaived.equals(other$feeChargesWaived))
            return false;
        final java.lang.Object this$feeChargesWrittenOff = this.getFeeChargesWrittenOff();
        final java.lang.Object other$feeChargesWrittenOff = other.getFeeChargesWrittenOff();
        if (this$feeChargesWrittenOff == null ? other$feeChargesWrittenOff != null
                : !this$feeChargesWrittenOff.equals(other$feeChargesWrittenOff))
            return false;
        final java.lang.Object this$feeChargesOutstanding = this.getFeeChargesOutstanding();
        final java.lang.Object other$feeChargesOutstanding = other.getFeeChargesOutstanding();
        if (this$feeChargesOutstanding == null ? other$feeChargesOutstanding != null
                : !this$feeChargesOutstanding.equals(other$feeChargesOutstanding))
            return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
    protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanFeeData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $feeChargesCharged = this.getFeeChargesCharged();
        result = result * PRIME + ($feeChargesCharged == null ? 43 : $feeChargesCharged.hashCode());
        final java.lang.Object $feeAdjustments = this.getFeeAdjustments();
        result = result * PRIME + ($feeAdjustments == null ? 43 : $feeAdjustments.hashCode());
        final java.lang.Object $feeChargesDueAtDisbursementCharged = this.getFeeChargesDueAtDisbursementCharged();
        result = result * PRIME + ($feeChargesDueAtDisbursementCharged == null ? 43 : $feeChargesDueAtDisbursementCharged.hashCode());
        final java.lang.Object $feeChargesPaid = this.getFeeChargesPaid();
        result = result * PRIME + ($feeChargesPaid == null ? 43 : $feeChargesPaid.hashCode());
        final java.lang.Object $feeChargesWaived = this.getFeeChargesWaived();
        result = result * PRIME + ($feeChargesWaived == null ? 43 : $feeChargesWaived.hashCode());
        final java.lang.Object $feeChargesWrittenOff = this.getFeeChargesWrittenOff();
        result = result * PRIME + ($feeChargesWrittenOff == null ? 43 : $feeChargesWrittenOff.hashCode());
        final java.lang.Object $feeChargesOutstanding = this.getFeeChargesOutstanding();
        result = result * PRIME + ($feeChargesOutstanding == null ? 43 : $feeChargesOutstanding.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public java.lang.String toString() {
        return "LoanFeeData(feeChargesCharged=" + this.getFeeChargesCharged() + ", feeAdjustments=" + this.getFeeAdjustments()
                + ", feeChargesDueAtDisbursementCharged=" + this.getFeeChargesDueAtDisbursementCharged() + ", feeChargesPaid="
                + this.getFeeChargesPaid() + ", feeChargesWaived=" + this.getFeeChargesWaived() + ", feeChargesWrittenOff="
                + this.getFeeChargesWrittenOff() + ", feeChargesOutstanding=" + this.getFeeChargesOutstanding() + ")";
    }
}
