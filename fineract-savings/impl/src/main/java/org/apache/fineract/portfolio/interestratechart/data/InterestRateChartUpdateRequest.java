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

import io.swagger.v3.oas.annotations.Hidden;
import java.io.Serial;
import java.io.Serializable;

public class InterestRateChartUpdateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Hidden
    private Long id;
    private String name;
    private String description;


    @java.lang.SuppressWarnings("all")
        public static class InterestRateChartUpdateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private String description;

        @java.lang.SuppressWarnings("all")
                InterestRateChartUpdateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartUpdateRequest.InterestRateChartUpdateRequestBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartUpdateRequest.InterestRateChartUpdateRequestBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartUpdateRequest.InterestRateChartUpdateRequestBuilder description(final String description) {
            this.description = description;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public InterestRateChartUpdateRequest build() {
            return new InterestRateChartUpdateRequest(this.id, this.name, this.description);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "InterestRateChartUpdateRequest.InterestRateChartUpdateRequestBuilder(id=" + this.id + ", name=" + this.name + ", description=" + this.description + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static InterestRateChartUpdateRequest.InterestRateChartUpdateRequestBuilder builder() {
        return new InterestRateChartUpdateRequest.InterestRateChartUpdateRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setDescription(final String description) {
        this.description = description;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof InterestRateChartUpdateRequest)) return false;
        final InterestRateChartUpdateRequest other = (InterestRateChartUpdateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof InterestRateChartUpdateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "InterestRateChartUpdateRequest(id=" + this.getId() + ", name=" + this.getName() + ", description=" + this.getDescription() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public InterestRateChartUpdateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public InterestRateChartUpdateRequest(final Long id, final String name, final String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }
}
