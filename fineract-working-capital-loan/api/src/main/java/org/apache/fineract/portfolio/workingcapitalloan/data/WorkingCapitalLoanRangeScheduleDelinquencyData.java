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
package org.apache.fineract.portfolio.workingcapitalloan.data;

import java.math.BigDecimal;

public class WorkingCapitalLoanRangeScheduleDelinquencyData {
    private Long rangeId;
    private String classification;
    private Integer minimumAgeDays;
    private Integer maximumAgeDays;
    private BigDecimal delinquentAmount;


    @java.lang.SuppressWarnings("all")
        public static class WorkingCapitalLoanRangeScheduleDelinquencyDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long rangeId;
        @java.lang.SuppressWarnings("all")
                private String classification;
        @java.lang.SuppressWarnings("all")
                private Integer minimumAgeDays;
        @java.lang.SuppressWarnings("all")
                private Integer maximumAgeDays;
        @java.lang.SuppressWarnings("all")
                private BigDecimal delinquentAmount;

        @java.lang.SuppressWarnings("all")
                WorkingCapitalLoanRangeScheduleDelinquencyDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanRangeScheduleDelinquencyData.WorkingCapitalLoanRangeScheduleDelinquencyDataBuilder rangeId(final Long rangeId) {
            this.rangeId = rangeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanRangeScheduleDelinquencyData.WorkingCapitalLoanRangeScheduleDelinquencyDataBuilder classification(final String classification) {
            this.classification = classification;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanRangeScheduleDelinquencyData.WorkingCapitalLoanRangeScheduleDelinquencyDataBuilder minimumAgeDays(final Integer minimumAgeDays) {
            this.minimumAgeDays = minimumAgeDays;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanRangeScheduleDelinquencyData.WorkingCapitalLoanRangeScheduleDelinquencyDataBuilder maximumAgeDays(final Integer maximumAgeDays) {
            this.maximumAgeDays = maximumAgeDays;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanRangeScheduleDelinquencyData.WorkingCapitalLoanRangeScheduleDelinquencyDataBuilder delinquentAmount(final BigDecimal delinquentAmount) {
            this.delinquentAmount = delinquentAmount;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanRangeScheduleDelinquencyData build() {
            return new WorkingCapitalLoanRangeScheduleDelinquencyData(this.rangeId, this.classification, this.minimumAgeDays, this.maximumAgeDays, this.delinquentAmount);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "WorkingCapitalLoanRangeScheduleDelinquencyData.WorkingCapitalLoanRangeScheduleDelinquencyDataBuilder(rangeId=" + this.rangeId + ", classification=" + this.classification + ", minimumAgeDays=" + this.minimumAgeDays + ", maximumAgeDays=" + this.maximumAgeDays + ", delinquentAmount=" + this.delinquentAmount + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static WorkingCapitalLoanRangeScheduleDelinquencyData.WorkingCapitalLoanRangeScheduleDelinquencyDataBuilder builder() {
        return new WorkingCapitalLoanRangeScheduleDelinquencyData.WorkingCapitalLoanRangeScheduleDelinquencyDataBuilder();
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
        if (!(o instanceof WorkingCapitalLoanRangeScheduleDelinquencyData)) return false;
        final WorkingCapitalLoanRangeScheduleDelinquencyData other = (WorkingCapitalLoanRangeScheduleDelinquencyData) o;
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
        return other instanceof WorkingCapitalLoanRangeScheduleDelinquencyData;
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
        return "WorkingCapitalLoanRangeScheduleDelinquencyData(rangeId=" + this.getRangeId() + ", classification=" + this.getClassification() + ", minimumAgeDays=" + this.getMinimumAgeDays() + ", maximumAgeDays=" + this.getMaximumAgeDays() + ", delinquentAmount=" + this.getDelinquentAmount() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanRangeScheduleDelinquencyData(final Long rangeId, final String classification, final Integer minimumAgeDays, final Integer maximumAgeDays, final BigDecimal delinquentAmount) {
        this.rangeId = rangeId;
        this.classification = classification;
        this.minimumAgeDays = minimumAgeDays;
        this.maximumAgeDays = maximumAgeDays;
        this.delinquentAmount = delinquentAmount;
    }
}
