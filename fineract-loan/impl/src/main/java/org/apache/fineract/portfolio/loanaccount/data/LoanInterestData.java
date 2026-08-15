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
import org.apache.fineract.infrastructure.core.config.MapstructMapperConfig;
import org.apache.fineract.portfolio.loanaccount.domain.LoanSummary;
import org.mapstruct.Mapping;

public class LoanInterestData {
    private final BigDecimal interestCharged;
    private final BigDecimal interestPaid;
    private final BigDecimal interestWaived;
    private final BigDecimal interestWrittenOff;
    private final BigDecimal interestOutstanding;


    @org.mapstruct.Mapper(config = MapstructMapperConfig.class)
    public interface Mapper {
        @Mapping(source = "totalInterestCharged", target = "interestCharged")
        @Mapping(source = "totalInterestRepaid", target = "interestPaid")
        @Mapping(source = "totalInterestWaived", target = "interestWaived")
        @Mapping(source = "totalInterestWrittenOff", target = "interestWrittenOff")
        @Mapping(source = "totalInterestOutstanding", target = "interestOutstanding")
        LoanInterestData map(LoanSummary source);
    }

    @java.lang.SuppressWarnings("all")
        public LoanInterestData(final BigDecimal interestCharged, final BigDecimal interestPaid, final BigDecimal interestWaived, final BigDecimal interestWrittenOff, final BigDecimal interestOutstanding) {
        this.interestCharged = interestCharged;
        this.interestPaid = interestPaid;
        this.interestWaived = interestWaived;
        this.interestWrittenOff = interestWrittenOff;
        this.interestOutstanding = interestOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestCharged() {
        return this.interestCharged;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestPaid() {
        return this.interestPaid;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestWaived() {
        return this.interestWaived;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestWrittenOff() {
        return this.interestWrittenOff;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestOutstanding() {
        return this.interestOutstanding;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanInterestData)) return false;
        final LoanInterestData other = (LoanInterestData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$interestCharged = this.getInterestCharged();
        final java.lang.Object other$interestCharged = other.getInterestCharged();
        if (this$interestCharged == null ? other$interestCharged != null : !this$interestCharged.equals(other$interestCharged)) return false;
        final java.lang.Object this$interestPaid = this.getInterestPaid();
        final java.lang.Object other$interestPaid = other.getInterestPaid();
        if (this$interestPaid == null ? other$interestPaid != null : !this$interestPaid.equals(other$interestPaid)) return false;
        final java.lang.Object this$interestWaived = this.getInterestWaived();
        final java.lang.Object other$interestWaived = other.getInterestWaived();
        if (this$interestWaived == null ? other$interestWaived != null : !this$interestWaived.equals(other$interestWaived)) return false;
        final java.lang.Object this$interestWrittenOff = this.getInterestWrittenOff();
        final java.lang.Object other$interestWrittenOff = other.getInterestWrittenOff();
        if (this$interestWrittenOff == null ? other$interestWrittenOff != null : !this$interestWrittenOff.equals(other$interestWrittenOff)) return false;
        final java.lang.Object this$interestOutstanding = this.getInterestOutstanding();
        final java.lang.Object other$interestOutstanding = other.getInterestOutstanding();
        if (this$interestOutstanding == null ? other$interestOutstanding != null : !this$interestOutstanding.equals(other$interestOutstanding)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanInterestData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $interestCharged = this.getInterestCharged();
        result = result * PRIME + ($interestCharged == null ? 43 : $interestCharged.hashCode());
        final java.lang.Object $interestPaid = this.getInterestPaid();
        result = result * PRIME + ($interestPaid == null ? 43 : $interestPaid.hashCode());
        final java.lang.Object $interestWaived = this.getInterestWaived();
        result = result * PRIME + ($interestWaived == null ? 43 : $interestWaived.hashCode());
        final java.lang.Object $interestWrittenOff = this.getInterestWrittenOff();
        result = result * PRIME + ($interestWrittenOff == null ? 43 : $interestWrittenOff.hashCode());
        final java.lang.Object $interestOutstanding = this.getInterestOutstanding();
        result = result * PRIME + ($interestOutstanding == null ? 43 : $interestOutstanding.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanInterestData(interestCharged=" + this.getInterestCharged() + ", interestPaid=" + this.getInterestPaid() + ", interestWaived=" + this.getInterestWaived() + ", interestWrittenOff=" + this.getInterestWrittenOff() + ", interestOutstanding=" + this.getInterestOutstanding() + ")";
    }
}
