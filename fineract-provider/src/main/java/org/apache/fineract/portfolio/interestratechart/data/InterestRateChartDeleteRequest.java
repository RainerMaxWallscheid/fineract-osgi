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

import jakarta.validation.constraints.NotNull;
import java.io.Serial;
import java.io.Serializable;

public class InterestRateChartDeleteRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @NotNull(message = "{org.apache.fineract.portfolio.interestratechart.id.not-null}")
    private Long chartId;


    @java.lang.SuppressWarnings("all")
        public static class InterestRateChartDeleteRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long chartId;

        @java.lang.SuppressWarnings("all")
                InterestRateChartDeleteRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartDeleteRequest.InterestRateChartDeleteRequestBuilder chartId(final Long chartId) {
            this.chartId = chartId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public InterestRateChartDeleteRequest build() {
            return new InterestRateChartDeleteRequest(this.chartId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "InterestRateChartDeleteRequest.InterestRateChartDeleteRequestBuilder(chartId=" + this.chartId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static InterestRateChartDeleteRequest.InterestRateChartDeleteRequestBuilder builder() {
        return new InterestRateChartDeleteRequest.InterestRateChartDeleteRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getChartId() {
        return this.chartId;
    }

    @java.lang.SuppressWarnings("all")
        public void setChartId(final Long chartId) {
        this.chartId = chartId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof InterestRateChartDeleteRequest)) return false;
        final InterestRateChartDeleteRequest other = (InterestRateChartDeleteRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$chartId = this.getChartId();
        final java.lang.Object other$chartId = other.getChartId();
        if (this$chartId == null ? other$chartId != null : !this$chartId.equals(other$chartId)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof InterestRateChartDeleteRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $chartId = this.getChartId();
        result = result * PRIME + ($chartId == null ? 43 : $chartId.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "InterestRateChartDeleteRequest(chartId=" + this.getChartId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public InterestRateChartDeleteRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public InterestRateChartDeleteRequest(final Long chartId) {
        this.chartId = chartId;
    }
}
