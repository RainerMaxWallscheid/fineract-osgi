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
package org.apache.fineract.portfolio.interestratechart.data;

import java.io.Serial;
import java.io.Serializable;

public class InterestRateChartSlabsUpdateResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long resourceId;
    private InterestRateChartSlabsUpdateChanges changes;


    public static class InterestRateChartSlabsUpdateChanges implements Serializable {
        @Serial
        private static final long serialVersionUID = 1L;
        private Double annualInterestRate;
        private String description;


        @java.lang.SuppressWarnings("all")
                public static class InterestRateChartSlabsUpdateChangesBuilder {
            @java.lang.SuppressWarnings("all")
                        private Double annualInterestRate;
            @java.lang.SuppressWarnings("all")
                        private String description;

            @java.lang.SuppressWarnings("all")
                        InterestRateChartSlabsUpdateChangesBuilder() {
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateChanges.InterestRateChartSlabsUpdateChangesBuilder annualInterestRate(final Double annualInterestRate) {
                this.annualInterestRate = annualInterestRate;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateChanges.InterestRateChartSlabsUpdateChangesBuilder description(final String description) {
                this.description = description;
                return this;
            }

            @java.lang.SuppressWarnings("all")
                        public InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateChanges build() {
                return new InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateChanges(this.annualInterestRate, this.description);
            }

            @java.lang.Override
            @java.lang.SuppressWarnings("all")
                        public java.lang.String toString() {
                return "InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateChanges.InterestRateChartSlabsUpdateChangesBuilder(annualInterestRate=" + this.annualInterestRate + ", description=" + this.description + ")";
            }
        }

        @java.lang.SuppressWarnings("all")
                public static InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateChanges.InterestRateChartSlabsUpdateChangesBuilder builder() {
            return new InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateChanges.InterestRateChartSlabsUpdateChangesBuilder();
        }

        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateChanges(final Double annualInterestRate, final String description) {
            this.annualInterestRate = annualInterestRate;
            this.description = description;
        }

        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateChanges() {
        }

        @java.lang.SuppressWarnings("all")
                public Double getAnnualInterestRate() {
            return this.annualInterestRate;
        }

        @java.lang.SuppressWarnings("all")
                public String getDescription() {
            return this.description;
        }

        @java.lang.SuppressWarnings("all")
                public void setAnnualInterestRate(final Double annualInterestRate) {
            this.annualInterestRate = annualInterestRate;
        }

        @java.lang.SuppressWarnings("all")
                public void setDescription(final String description) {
            this.description = description;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public boolean equals(final java.lang.Object o) {
            if (o == this) return true;
            if (!(o instanceof InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateChanges)) return false;
            final InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateChanges other = (InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateChanges) o;
            if (!other.canEqual((java.lang.Object) this)) return false;
            final java.lang.Object this$annualInterestRate = this.getAnnualInterestRate();
            final java.lang.Object other$annualInterestRate = other.getAnnualInterestRate();
            if (this$annualInterestRate == null ? other$annualInterestRate != null : !this$annualInterestRate.equals(other$annualInterestRate)) return false;
            final java.lang.Object this$description = this.getDescription();
            final java.lang.Object other$description = other.getDescription();
            if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
            return true;
        }

        @java.lang.SuppressWarnings("all")
                protected boolean canEqual(final java.lang.Object other) {
            return other instanceof InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateChanges;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public int hashCode() {
            final int PRIME = 59;
            int result = 1;
            final java.lang.Object $annualInterestRate = this.getAnnualInterestRate();
            result = result * PRIME + ($annualInterestRate == null ? 43 : $annualInterestRate.hashCode());
            final java.lang.Object $description = this.getDescription();
            result = result * PRIME + ($description == null ? 43 : $description.hashCode());
            return result;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateChanges(annualInterestRate=" + this.getAnnualInterestRate() + ", description=" + this.getDescription() + ")";
        }
    }


    @java.lang.SuppressWarnings("all")
        public static class InterestRateChartSlabsUpdateResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private Long resourceId;
        @java.lang.SuppressWarnings("all")
                private InterestRateChartSlabsUpdateChanges changes;

        @java.lang.SuppressWarnings("all")
                InterestRateChartSlabsUpdateResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateResponseBuilder resourceId(final Long resourceId) {
            this.resourceId = resourceId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateResponseBuilder changes(final InterestRateChartSlabsUpdateChanges changes) {
            this.changes = changes;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateResponse build() {
            return new InterestRateChartSlabsUpdateResponse(this.resourceId, this.changes);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateResponseBuilder(resourceId=" + this.resourceId + ", changes=" + this.changes + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateResponseBuilder builder() {
        return new InterestRateChartSlabsUpdateResponse.InterestRateChartSlabsUpdateResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public InterestRateChartSlabsUpdateResponse(final Long resourceId, final InterestRateChartSlabsUpdateChanges changes) {
        this.resourceId = resourceId;
        this.changes = changes;
    }

    @java.lang.SuppressWarnings("all")
        public InterestRateChartSlabsUpdateResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public Long getResourceId() {
        return this.resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public InterestRateChartSlabsUpdateChanges getChanges() {
        return this.changes;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceId(final Long resourceId) {
        this.resourceId = resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public void setChanges(final InterestRateChartSlabsUpdateChanges changes) {
        this.changes = changes;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof InterestRateChartSlabsUpdateResponse)) return false;
        final InterestRateChartSlabsUpdateResponse other = (InterestRateChartSlabsUpdateResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$resourceId = this.getResourceId();
        final java.lang.Object other$resourceId = other.getResourceId();
        if (this$resourceId == null ? other$resourceId != null : !this$resourceId.equals(other$resourceId)) return false;
        final java.lang.Object this$changes = this.getChanges();
        final java.lang.Object other$changes = other.getChanges();
        if (this$changes == null ? other$changes != null : !this$changes.equals(other$changes)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof InterestRateChartSlabsUpdateResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $resourceId = this.getResourceId();
        result = result * PRIME + ($resourceId == null ? 43 : $resourceId.hashCode());
        final java.lang.Object $changes = this.getChanges();
        result = result * PRIME + ($changes == null ? 43 : $changes.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "InterestRateChartSlabsUpdateResponse(resourceId=" + this.getResourceId() + ", changes=" + this.getChanges() + ")";
    }
}
