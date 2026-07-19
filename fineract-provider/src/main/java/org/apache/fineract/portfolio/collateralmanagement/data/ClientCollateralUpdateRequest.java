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
import java.math.BigDecimal;

public class ClientCollateralUpdateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Hidden
    private Long clientId;
    @Hidden
    private Long collateralId;
    private BigDecimal quantity;
    private String locale;


    @java.lang.SuppressWarnings("all")
        public static class ClientCollateralUpdateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long clientId;
        @java.lang.SuppressWarnings("all")
                private Long collateralId;
        @java.lang.SuppressWarnings("all")
                private BigDecimal quantity;
        @java.lang.SuppressWarnings("all")
                private String locale;

        @java.lang.SuppressWarnings("all")
                ClientCollateralUpdateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientCollateralUpdateRequest.ClientCollateralUpdateRequestBuilder clientId(final Long clientId) {
            this.clientId = clientId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientCollateralUpdateRequest.ClientCollateralUpdateRequestBuilder collateralId(final Long collateralId) {
            this.collateralId = collateralId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientCollateralUpdateRequest.ClientCollateralUpdateRequestBuilder quantity(final BigDecimal quantity) {
            this.quantity = quantity;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientCollateralUpdateRequest.ClientCollateralUpdateRequestBuilder locale(final String locale) {
            this.locale = locale;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ClientCollateralUpdateRequest build() {
            return new ClientCollateralUpdateRequest(this.clientId, this.collateralId, this.quantity, this.locale);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ClientCollateralUpdateRequest.ClientCollateralUpdateRequestBuilder(clientId=" + this.clientId + ", collateralId=" + this.collateralId + ", quantity=" + this.quantity + ", locale=" + this.locale + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ClientCollateralUpdateRequest.ClientCollateralUpdateRequestBuilder builder() {
        return new ClientCollateralUpdateRequest.ClientCollateralUpdateRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCollateralId() {
        return this.collateralId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getQuantity() {
        return this.quantity;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientId(final Long clientId) {
        this.clientId = clientId;
    }

    @java.lang.SuppressWarnings("all")
        public void setCollateralId(final Long collateralId) {
        this.collateralId = collateralId;
    }

    @java.lang.SuppressWarnings("all")
        public void setQuantity(final BigDecimal quantity) {
        this.quantity = quantity;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ClientCollateralUpdateRequest)) return false;
        final ClientCollateralUpdateRequest other = (ClientCollateralUpdateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$clientId = this.getClientId();
        final java.lang.Object other$clientId = other.getClientId();
        if (this$clientId == null ? other$clientId != null : !this$clientId.equals(other$clientId)) return false;
        final java.lang.Object this$collateralId = this.getCollateralId();
        final java.lang.Object other$collateralId = other.getCollateralId();
        if (this$collateralId == null ? other$collateralId != null : !this$collateralId.equals(other$collateralId)) return false;
        final java.lang.Object this$quantity = this.getQuantity();
        final java.lang.Object other$quantity = other.getQuantity();
        if (this$quantity == null ? other$quantity != null : !this$quantity.equals(other$quantity)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ClientCollateralUpdateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $clientId = this.getClientId();
        result = result * PRIME + ($clientId == null ? 43 : $clientId.hashCode());
        final java.lang.Object $collateralId = this.getCollateralId();
        result = result * PRIME + ($collateralId == null ? 43 : $collateralId.hashCode());
        final java.lang.Object $quantity = this.getQuantity();
        result = result * PRIME + ($quantity == null ? 43 : $quantity.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ClientCollateralUpdateRequest(clientId=" + this.getClientId() + ", collateralId=" + this.getCollateralId() + ", quantity=" + this.getQuantity() + ", locale=" + this.getLocale() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ClientCollateralUpdateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public ClientCollateralUpdateRequest(final Long clientId, final Long collateralId, final BigDecimal quantity, final String locale) {
        this.clientId = clientId;
        this.collateralId = collateralId;
        this.quantity = quantity;
        this.locale = locale;
    }
}
