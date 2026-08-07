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
package org.apache.fineract.portfolio.collateralmanagement.data;

import io.swagger.v3.oas.annotations.Hidden;
import jakarta.validation.constraints.NotNull;
import java.io.Serial;
import java.io.Serializable;

public class CollateralProductDeleteRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Hidden
    @NotNull
    private Long collateralId;


    @java.lang.SuppressWarnings("all")
        public static class CollateralProductDeleteRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long collateralId;

        @java.lang.SuppressWarnings("all")
                CollateralProductDeleteRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollateralProductDeleteRequest.CollateralProductDeleteRequestBuilder collateralId(final Long collateralId) {
            this.collateralId = collateralId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public CollateralProductDeleteRequest build() {
            return new CollateralProductDeleteRequest(this.collateralId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "CollateralProductDeleteRequest.CollateralProductDeleteRequestBuilder(collateralId=" + this.collateralId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static CollateralProductDeleteRequest.CollateralProductDeleteRequestBuilder builder() {
        return new CollateralProductDeleteRequest.CollateralProductDeleteRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getCollateralId() {
        return this.collateralId;
    }

    @java.lang.SuppressWarnings("all")
        public void setCollateralId(final Long collateralId) {
        this.collateralId = collateralId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CollateralProductDeleteRequest)) return false;
        final CollateralProductDeleteRequest other = (CollateralProductDeleteRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$collateralId = this.getCollateralId();
        final java.lang.Object other$collateralId = other.getCollateralId();
        if (this$collateralId == null ? other$collateralId != null : !this$collateralId.equals(other$collateralId)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof CollateralProductDeleteRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $collateralId = this.getCollateralId();
        result = result * PRIME + ($collateralId == null ? 43 : $collateralId.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CollateralProductDeleteRequest(collateralId=" + this.getCollateralId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CollateralProductDeleteRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public CollateralProductDeleteRequest(final Long collateralId) {
        this.collateralId = collateralId;
    }
}
