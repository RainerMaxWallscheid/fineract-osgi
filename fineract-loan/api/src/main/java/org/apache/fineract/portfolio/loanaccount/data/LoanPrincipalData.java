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

public class LoanPrincipalData {

    private final BigDecimal principalDisbursed;
    private final BigDecimal principalAdjustments;
    private final BigDecimal principalPaid;
    private final BigDecimal principalWrittenOff;
    private final BigDecimal principalOutstanding;

    @java.lang.SuppressWarnings("all")
    public LoanPrincipalData(final BigDecimal principalDisbursed, final BigDecimal principalAdjustments, final BigDecimal principalPaid,
            final BigDecimal principalWrittenOff, final BigDecimal principalOutstanding) {
        this.principalDisbursed = principalDisbursed;
        this.principalAdjustments = principalAdjustments;
        this.principalPaid = principalPaid;
        this.principalWrittenOff = principalWrittenOff;
        this.principalOutstanding = principalOutstanding;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getPrincipalDisbursed() {
        return this.principalDisbursed;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getPrincipalAdjustments() {
        return this.principalAdjustments;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getPrincipalPaid() {
        return this.principalPaid;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getPrincipalWrittenOff() {
        return this.principalWrittenOff;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getPrincipalOutstanding() {
        return this.principalOutstanding;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanPrincipalData)) return false;
        final LoanPrincipalData other = (LoanPrincipalData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$principalDisbursed = this.getPrincipalDisbursed();
        final java.lang.Object other$principalDisbursed = other.getPrincipalDisbursed();
        if (this$principalDisbursed == null ? other$principalDisbursed != null : !this$principalDisbursed.equals(other$principalDisbursed))
            return false;
        final java.lang.Object this$principalAdjustments = this.getPrincipalAdjustments();
        final java.lang.Object other$principalAdjustments = other.getPrincipalAdjustments();
        if (this$principalAdjustments == null ? other$principalAdjustments != null
                : !this$principalAdjustments.equals(other$principalAdjustments))
            return false;
        final java.lang.Object this$principalPaid = this.getPrincipalPaid();
        final java.lang.Object other$principalPaid = other.getPrincipalPaid();
        if (this$principalPaid == null ? other$principalPaid != null : !this$principalPaid.equals(other$principalPaid)) return false;
        final java.lang.Object this$principalWrittenOff = this.getPrincipalWrittenOff();
        final java.lang.Object other$principalWrittenOff = other.getPrincipalWrittenOff();
        if (this$principalWrittenOff == null ? other$principalWrittenOff != null
                : !this$principalWrittenOff.equals(other$principalWrittenOff))
            return false;
        final java.lang.Object this$principalOutstanding = this.getPrincipalOutstanding();
        final java.lang.Object other$principalOutstanding = other.getPrincipalOutstanding();
        if (this$principalOutstanding == null ? other$principalOutstanding != null
                : !this$principalOutstanding.equals(other$principalOutstanding))
            return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
    protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanPrincipalData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $principalDisbursed = this.getPrincipalDisbursed();
        result = result * PRIME + ($principalDisbursed == null ? 43 : $principalDisbursed.hashCode());
        final java.lang.Object $principalAdjustments = this.getPrincipalAdjustments();
        result = result * PRIME + ($principalAdjustments == null ? 43 : $principalAdjustments.hashCode());
        final java.lang.Object $principalPaid = this.getPrincipalPaid();
        result = result * PRIME + ($principalPaid == null ? 43 : $principalPaid.hashCode());
        final java.lang.Object $principalWrittenOff = this.getPrincipalWrittenOff();
        result = result * PRIME + ($principalWrittenOff == null ? 43 : $principalWrittenOff.hashCode());
        final java.lang.Object $principalOutstanding = this.getPrincipalOutstanding();
        result = result * PRIME + ($principalOutstanding == null ? 43 : $principalOutstanding.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public java.lang.String toString() {
        return "LoanPrincipalData(principalDisbursed=" + this.getPrincipalDisbursed() + ", principalAdjustments="
                + this.getPrincipalAdjustments() + ", principalPaid=" + this.getPrincipalPaid() + ", principalWrittenOff="
                + this.getPrincipalWrittenOff() + ", principalOutstanding=" + this.getPrincipalOutstanding() + ")";
    }
}
