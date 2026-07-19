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
import org.apache.fineract.portfolio.delinquency.data.LoanInstallmentDelinquencyTagData;

public class InstallmentLevelDelinquency {
    private Long rangeId;
    private String classification;
    private Integer minimumAgeDays;
    private Integer maximumAgeDays;
    private BigDecimal delinquentAmount;

    public static InstallmentLevelDelinquency from(LoanInstallmentDelinquencyTagData loanInstallmentDelinquencyTagData) {
        InstallmentLevelDelinquency installmentLevelDelinquency = new InstallmentLevelDelinquency();
        installmentLevelDelinquency.setClassification(loanInstallmentDelinquencyTagData.getDelinquencyRange().getClassification());
        installmentLevelDelinquency.setRangeId(loanInstallmentDelinquencyTagData.getDelinquencyRange().getId());
        installmentLevelDelinquency.setMinimumAgeDays(loanInstallmentDelinquencyTagData.getDelinquencyRange().getMinimumAgeDays());
        installmentLevelDelinquency.setMaximumAgeDays(loanInstallmentDelinquencyTagData.getDelinquencyRange().getMaximumAgeDays());
        installmentLevelDelinquency.setDelinquentAmount(loanInstallmentDelinquencyTagData.getOutstandingAmount());
        return installmentLevelDelinquency;
    }

    @java.lang.SuppressWarnings("all")
        public InstallmentLevelDelinquency() {
    }

    @java.lang.SuppressWarnings("all")
        public Long getRangeId() {
        return this.rangeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getClassification() {
        return this.classification;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getMinimumAgeDays() {
        return this.minimumAgeDays;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getMaximumAgeDays() {
        return this.maximumAgeDays;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDelinquentAmount() {
        return this.delinquentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setRangeId(final Long rangeId) {
        this.rangeId = rangeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setClassification(final String classification) {
        this.classification = classification;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinimumAgeDays(final Integer minimumAgeDays) {
        this.minimumAgeDays = minimumAgeDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setMaximumAgeDays(final Integer maximumAgeDays) {
        this.maximumAgeDays = maximumAgeDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentAmount(final BigDecimal delinquentAmount) {
        this.delinquentAmount = delinquentAmount;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof InstallmentLevelDelinquency)) return false;
        final InstallmentLevelDelinquency other = (InstallmentLevelDelinquency) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$rangeId = this.getRangeId();
        final java.lang.Object other$rangeId = other.getRangeId();
        if (this$rangeId == null ? other$rangeId != null : !this$rangeId.equals(other$rangeId)) return false;
        final java.lang.Object this$minimumAgeDays = this.getMinimumAgeDays();
        final java.lang.Object other$minimumAgeDays = other.getMinimumAgeDays();
        if (this$minimumAgeDays == null ? other$minimumAgeDays != null : !this$minimumAgeDays.equals(other$minimumAgeDays)) return false;
        final java.lang.Object this$maximumAgeDays = this.getMaximumAgeDays();
        final java.lang.Object other$maximumAgeDays = other.getMaximumAgeDays();
        if (this$maximumAgeDays == null ? other$maximumAgeDays != null : !this$maximumAgeDays.equals(other$maximumAgeDays)) return false;
        final java.lang.Object this$classification = this.getClassification();
        final java.lang.Object other$classification = other.getClassification();
        if (this$classification == null ? other$classification != null : !this$classification.equals(other$classification)) return false;
        final java.lang.Object this$delinquentAmount = this.getDelinquentAmount();
        final java.lang.Object other$delinquentAmount = other.getDelinquentAmount();
        if (this$delinquentAmount == null ? other$delinquentAmount != null : !this$delinquentAmount.equals(other$delinquentAmount)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof InstallmentLevelDelinquency;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $rangeId = this.getRangeId();
        result = result * PRIME + ($rangeId == null ? 43 : $rangeId.hashCode());
        final java.lang.Object $minimumAgeDays = this.getMinimumAgeDays();
        result = result * PRIME + ($minimumAgeDays == null ? 43 : $minimumAgeDays.hashCode());
        final java.lang.Object $maximumAgeDays = this.getMaximumAgeDays();
        result = result * PRIME + ($maximumAgeDays == null ? 43 : $maximumAgeDays.hashCode());
        final java.lang.Object $classification = this.getClassification();
        result = result * PRIME + ($classification == null ? 43 : $classification.hashCode());
        final java.lang.Object $delinquentAmount = this.getDelinquentAmount();
        result = result * PRIME + ($delinquentAmount == null ? 43 : $delinquentAmount.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "InstallmentLevelDelinquency(rangeId=" + this.getRangeId() + ", classification=" + this.getClassification() + ", minimumAgeDays=" + this.getMinimumAgeDays() + ", maximumAgeDays=" + this.getMaximumAgeDays() + ", delinquentAmount=" + this.getDelinquentAmount() + ")";
    }
}
