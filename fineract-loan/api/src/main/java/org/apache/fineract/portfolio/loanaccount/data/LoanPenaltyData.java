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

public class LoanPenaltyData {

    private final BigDecimal penaltyChargesCharged;
    private final BigDecimal penaltyAdjustments;
    private final BigDecimal penaltyChargesPaid;
    private final BigDecimal penaltyChargesWaived;
    private final BigDecimal penaltyChargesWrittenOff;
    private final BigDecimal penaltyChargesOutstanding;

    @java.lang.SuppressWarnings("all")
    public LoanPenaltyData(final BigDecimal penaltyChargesCharged, final BigDecimal penaltyAdjustments, final BigDecimal penaltyChargesPaid,
            final BigDecimal penaltyChargesWaived, final BigDecimal penaltyChargesWrittenOff, final BigDecimal penaltyChargesOutstanding) {
        this.penaltyChargesCharged = penaltyChargesCharged;
        this.penaltyAdjustments = penaltyAdjustments;
        this.penaltyChargesPaid = penaltyChargesPaid;
        this.penaltyChargesWaived = penaltyChargesWaived;
        this.penaltyChargesWrittenOff = penaltyChargesWrittenOff;
        this.penaltyChargesOutstanding = penaltyChargesOutstanding;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getPenaltyChargesCharged() {
        return this.penaltyChargesCharged;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getPenaltyAdjustments() {
        return this.penaltyAdjustments;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getPenaltyChargesPaid() {
        return this.penaltyChargesPaid;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getPenaltyChargesWaived() {
        return this.penaltyChargesWaived;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getPenaltyChargesWrittenOff() {
        return this.penaltyChargesWrittenOff;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getPenaltyChargesOutstanding() {
        return this.penaltyChargesOutstanding;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanPenaltyData)) return false;
        final LoanPenaltyData other = (LoanPenaltyData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$penaltyChargesCharged = this.getPenaltyChargesCharged();
        final java.lang.Object other$penaltyChargesCharged = other.getPenaltyChargesCharged();
        if (this$penaltyChargesCharged == null ? other$penaltyChargesCharged != null
                : !this$penaltyChargesCharged.equals(other$penaltyChargesCharged))
            return false;
        final java.lang.Object this$penaltyAdjustments = this.getPenaltyAdjustments();
        final java.lang.Object other$penaltyAdjustments = other.getPenaltyAdjustments();
        if (this$penaltyAdjustments == null ? other$penaltyAdjustments != null : !this$penaltyAdjustments.equals(other$penaltyAdjustments))
            return false;
        final java.lang.Object this$penaltyChargesPaid = this.getPenaltyChargesPaid();
        final java.lang.Object other$penaltyChargesPaid = other.getPenaltyChargesPaid();
        if (this$penaltyChargesPaid == null ? other$penaltyChargesPaid != null : !this$penaltyChargesPaid.equals(other$penaltyChargesPaid))
            return false;
        final java.lang.Object this$penaltyChargesWaived = this.getPenaltyChargesWaived();
        final java.lang.Object other$penaltyChargesWaived = other.getPenaltyChargesWaived();
        if (this$penaltyChargesWaived == null ? other$penaltyChargesWaived != null
                : !this$penaltyChargesWaived.equals(other$penaltyChargesWaived))
            return false;
        final java.lang.Object this$penaltyChargesWrittenOff = this.getPenaltyChargesWrittenOff();
        final java.lang.Object other$penaltyChargesWrittenOff = other.getPenaltyChargesWrittenOff();
        if (this$penaltyChargesWrittenOff == null ? other$penaltyChargesWrittenOff != null
                : !this$penaltyChargesWrittenOff.equals(other$penaltyChargesWrittenOff))
            return false;
        final java.lang.Object this$penaltyChargesOutstanding = this.getPenaltyChargesOutstanding();
        final java.lang.Object other$penaltyChargesOutstanding = other.getPenaltyChargesOutstanding();
        if (this$penaltyChargesOutstanding == null ? other$penaltyChargesOutstanding != null
                : !this$penaltyChargesOutstanding.equals(other$penaltyChargesOutstanding))
            return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
    protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanPenaltyData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $penaltyChargesCharged = this.getPenaltyChargesCharged();
        result = result * PRIME + ($penaltyChargesCharged == null ? 43 : $penaltyChargesCharged.hashCode());
        final java.lang.Object $penaltyAdjustments = this.getPenaltyAdjustments();
        result = result * PRIME + ($penaltyAdjustments == null ? 43 : $penaltyAdjustments.hashCode());
        final java.lang.Object $penaltyChargesPaid = this.getPenaltyChargesPaid();
        result = result * PRIME + ($penaltyChargesPaid == null ? 43 : $penaltyChargesPaid.hashCode());
        final java.lang.Object $penaltyChargesWaived = this.getPenaltyChargesWaived();
        result = result * PRIME + ($penaltyChargesWaived == null ? 43 : $penaltyChargesWaived.hashCode());
        final java.lang.Object $penaltyChargesWrittenOff = this.getPenaltyChargesWrittenOff();
        result = result * PRIME + ($penaltyChargesWrittenOff == null ? 43 : $penaltyChargesWrittenOff.hashCode());
        final java.lang.Object $penaltyChargesOutstanding = this.getPenaltyChargesOutstanding();
        result = result * PRIME + ($penaltyChargesOutstanding == null ? 43 : $penaltyChargesOutstanding.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public java.lang.String toString() {
        return "LoanPenaltyData(penaltyChargesCharged=" + this.getPenaltyChargesCharged() + ", penaltyAdjustments="
                + this.getPenaltyAdjustments() + ", penaltyChargesPaid=" + this.getPenaltyChargesPaid() + ", penaltyChargesWaived="
                + this.getPenaltyChargesWaived() + ", penaltyChargesWrittenOff=" + this.getPenaltyChargesWrittenOff()
                + ", penaltyChargesOutstanding=" + this.getPenaltyChargesOutstanding() + ")";
    }
}
