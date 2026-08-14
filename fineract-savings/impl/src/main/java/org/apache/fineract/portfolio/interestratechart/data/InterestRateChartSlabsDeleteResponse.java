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

public class InterestRateChartSlabsDeleteResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long resourceId;


    @java.lang.SuppressWarnings("all")
        public static class InterestRateChartSlabsDeleteResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private Long resourceId;

        @java.lang.SuppressWarnings("all")
                InterestRateChartSlabsDeleteResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsDeleteResponse.InterestRateChartSlabsDeleteResponseBuilder resourceId(final Long resourceId) {
            this.resourceId = resourceId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsDeleteResponse build() {
            return new InterestRateChartSlabsDeleteResponse(this.resourceId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "InterestRateChartSlabsDeleteResponse.InterestRateChartSlabsDeleteResponseBuilder(resourceId=" + this.resourceId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static InterestRateChartSlabsDeleteResponse.InterestRateChartSlabsDeleteResponseBuilder builder() {
        return new InterestRateChartSlabsDeleteResponse.InterestRateChartSlabsDeleteResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getResourceId() {
        return this.resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceId(final Long resourceId) {
        this.resourceId = resourceId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof InterestRateChartSlabsDeleteResponse)) return false;
        final InterestRateChartSlabsDeleteResponse other = (InterestRateChartSlabsDeleteResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$resourceId = this.getResourceId();
        final java.lang.Object other$resourceId = other.getResourceId();
        if (this$resourceId == null ? other$resourceId != null : !this$resourceId.equals(other$resourceId)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof InterestRateChartSlabsDeleteResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $resourceId = this.getResourceId();
        result = result * PRIME + ($resourceId == null ? 43 : $resourceId.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "InterestRateChartSlabsDeleteResponse(resourceId=" + this.getResourceId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public InterestRateChartSlabsDeleteResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public InterestRateChartSlabsDeleteResponse(final Long resourceId) {
        this.resourceId = resourceId;
    }
}
