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
import java.io.Serial;
import java.io.Serializable;

public class ClientCollateralDeleteRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Hidden
    private Long collateralId;
    @Hidden
    private Long clientId;


    @java.lang.SuppressWarnings("all")
        public static class ClientCollateralDeleteRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long collateralId;
        @java.lang.SuppressWarnings("all")
                private Long clientId;

        @java.lang.SuppressWarnings("all")
                ClientCollateralDeleteRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientCollateralDeleteRequest.ClientCollateralDeleteRequestBuilder collateralId(final Long collateralId) {
            this.collateralId = collateralId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientCollateralDeleteRequest.ClientCollateralDeleteRequestBuilder clientId(final Long clientId) {
            this.clientId = clientId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ClientCollateralDeleteRequest build() {
            return new ClientCollateralDeleteRequest(this.collateralId, this.clientId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ClientCollateralDeleteRequest.ClientCollateralDeleteRequestBuilder(collateralId=" + this.collateralId + ", clientId=" + this.clientId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ClientCollateralDeleteRequest.ClientCollateralDeleteRequestBuilder builder() {
        return new ClientCollateralDeleteRequest.ClientCollateralDeleteRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getCollateralId() {
        return this.collateralId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public void setCollateralId(final Long collateralId) {
        this.collateralId = collateralId;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientId(final Long clientId) {
        this.clientId = clientId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ClientCollateralDeleteRequest)) return false;
        final ClientCollateralDeleteRequest other = (ClientCollateralDeleteRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$collateralId = this.getCollateralId();
        final java.lang.Object other$collateralId = other.getCollateralId();
        if (this$collateralId == null ? other$collateralId != null : !this$collateralId.equals(other$collateralId)) return false;
        final java.lang.Object this$clientId = this.getClientId();
        final java.lang.Object other$clientId = other.getClientId();
        if (this$clientId == null ? other$clientId != null : !this$clientId.equals(other$clientId)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ClientCollateralDeleteRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $collateralId = this.getCollateralId();
        result = result * PRIME + ($collateralId == null ? 43 : $collateralId.hashCode());
        final java.lang.Object $clientId = this.getClientId();
        result = result * PRIME + ($clientId == null ? 43 : $clientId.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ClientCollateralDeleteRequest(collateralId=" + this.getCollateralId() + ", clientId=" + this.getClientId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ClientCollateralDeleteRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public ClientCollateralDeleteRequest(final Long collateralId, final Long clientId) {
        this.collateralId = collateralId;
        this.clientId = clientId;
    }
}
