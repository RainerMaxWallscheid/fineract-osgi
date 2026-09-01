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

public class LoanTotalAmountData {

    private final BigDecimal totalExpectedRepayment;
    private final BigDecimal totalRepayment;
    private final BigDecimal totalExpectedCostOfLoan;
    private final BigDecimal totalCostOfLoan;
    private final BigDecimal totalWaived;
    private final BigDecimal totalWrittenOff;
    private final BigDecimal totalOutstanding;

    @java.lang.SuppressWarnings("all")
    public LoanTotalAmountData(final BigDecimal totalExpectedRepayment, final BigDecimal totalRepayment,
            final BigDecimal totalExpectedCostOfLoan, final BigDecimal totalCostOfLoan, final BigDecimal totalWaived,
            final BigDecimal totalWrittenOff, final BigDecimal totalOutstanding) {
        this.totalExpectedRepayment = totalExpectedRepayment;
        this.totalRepayment = totalRepayment;
        this.totalExpectedCostOfLoan = totalExpectedCostOfLoan;
        this.totalCostOfLoan = totalCostOfLoan;
        this.totalWaived = totalWaived;
        this.totalWrittenOff = totalWrittenOff;
        this.totalOutstanding = totalOutstanding;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getTotalExpectedRepayment() {
        return this.totalExpectedRepayment;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getTotalRepayment() {
        return this.totalRepayment;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getTotalExpectedCostOfLoan() {
        return this.totalExpectedCostOfLoan;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getTotalCostOfLoan() {
        return this.totalCostOfLoan;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getTotalWaived() {
        return this.totalWaived;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getTotalWrittenOff() {
        return this.totalWrittenOff;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getTotalOutstanding() {
        return this.totalOutstanding;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanTotalAmountData)) return false;
        final LoanTotalAmountData other = (LoanTotalAmountData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$totalExpectedRepayment = this.getTotalExpectedRepayment();
        final java.lang.Object other$totalExpectedRepayment = other.getTotalExpectedRepayment();
        if (this$totalExpectedRepayment == null ? other$totalExpectedRepayment != null
                : !this$totalExpectedRepayment.equals(other$totalExpectedRepayment))
            return false;
        final java.lang.Object this$totalRepayment = this.getTotalRepayment();
        final java.lang.Object other$totalRepayment = other.getTotalRepayment();
        if (this$totalRepayment == null ? other$totalRepayment != null : !this$totalRepayment.equals(other$totalRepayment)) return false;
        final java.lang.Object this$totalExpectedCostOfLoan = this.getTotalExpectedCostOfLoan();
        final java.lang.Object other$totalExpectedCostOfLoan = other.getTotalExpectedCostOfLoan();
        if (this$totalExpectedCostOfLoan == null ? other$totalExpectedCostOfLoan != null
                : !this$totalExpectedCostOfLoan.equals(other$totalExpectedCostOfLoan))
            return false;
        final java.lang.Object this$totalCostOfLoan = this.getTotalCostOfLoan();
        final java.lang.Object other$totalCostOfLoan = other.getTotalCostOfLoan();
        if (this$totalCostOfLoan == null ? other$totalCostOfLoan != null : !this$totalCostOfLoan.equals(other$totalCostOfLoan))
            return false;
        final java.lang.Object this$totalWaived = this.getTotalWaived();
        final java.lang.Object other$totalWaived = other.getTotalWaived();
        if (this$totalWaived == null ? other$totalWaived != null : !this$totalWaived.equals(other$totalWaived)) return false;
        final java.lang.Object this$totalWrittenOff = this.getTotalWrittenOff();
        final java.lang.Object other$totalWrittenOff = other.getTotalWrittenOff();
        if (this$totalWrittenOff == null ? other$totalWrittenOff != null : !this$totalWrittenOff.equals(other$totalWrittenOff))
            return false;
        final java.lang.Object this$totalOutstanding = this.getTotalOutstanding();
        final java.lang.Object other$totalOutstanding = other.getTotalOutstanding();
        if (this$totalOutstanding == null ? other$totalOutstanding != null : !this$totalOutstanding.equals(other$totalOutstanding))
            return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
    protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanTotalAmountData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $totalExpectedRepayment = this.getTotalExpectedRepayment();
        result = result * PRIME + ($totalExpectedRepayment == null ? 43 : $totalExpectedRepayment.hashCode());
        final java.lang.Object $totalRepayment = this.getTotalRepayment();
        result = result * PRIME + ($totalRepayment == null ? 43 : $totalRepayment.hashCode());
        final java.lang.Object $totalExpectedCostOfLoan = this.getTotalExpectedCostOfLoan();
        result = result * PRIME + ($totalExpectedCostOfLoan == null ? 43 : $totalExpectedCostOfLoan.hashCode());
        final java.lang.Object $totalCostOfLoan = this.getTotalCostOfLoan();
        result = result * PRIME + ($totalCostOfLoan == null ? 43 : $totalCostOfLoan.hashCode());
        final java.lang.Object $totalWaived = this.getTotalWaived();
        result = result * PRIME + ($totalWaived == null ? 43 : $totalWaived.hashCode());
        final java.lang.Object $totalWrittenOff = this.getTotalWrittenOff();
        result = result * PRIME + ($totalWrittenOff == null ? 43 : $totalWrittenOff.hashCode());
        final java.lang.Object $totalOutstanding = this.getTotalOutstanding();
        result = result * PRIME + ($totalOutstanding == null ? 43 : $totalOutstanding.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public java.lang.String toString() {
        return "LoanTotalAmountData(totalExpectedRepayment=" + this.getTotalExpectedRepayment() + ", totalRepayment="
                + this.getTotalRepayment() + ", totalExpectedCostOfLoan=" + this.getTotalExpectedCostOfLoan() + ", totalCostOfLoan="
                + this.getTotalCostOfLoan() + ", totalWaived=" + this.getTotalWaived() + ", totalWrittenOff=" + this.getTotalWrittenOff()
                + ", totalOutstanding=" + this.getTotalOutstanding() + ")";
    }
}
