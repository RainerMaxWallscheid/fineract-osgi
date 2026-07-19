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

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;

public class ClientCollateralUpdateResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long resourceId;
    private Long clientId;
    private Changes changes;


    public static class Changes implements Serializable {
        @Serial
        private static final long serialVersionUID = 1L;
        private BigDecimal quantity;
        private String locale;

        @java.lang.SuppressWarnings("all")
                Changes(final BigDecimal quantity, final String locale) {
            this.quantity = quantity;
            this.locale = locale;
        }


        @java.lang.SuppressWarnings("all")
                public static class ChangesBuilder {
            @java.lang.SuppressWarnings("all")
                        private BigDecimal quantity;
            @java.lang.SuppressWarnings("all")
                        private String locale;

            @java.lang.SuppressWarnings("all")
                        ChangesBuilder() {
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public ClientCollateralUpdateResponse.Changes.ChangesBuilder quantity(final BigDecimal quantity) {
                this.quantity = quantity;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public ClientCollateralUpdateResponse.Changes.ChangesBuilder locale(final String locale) {
                this.locale = locale;
                return this;
            }

            @java.lang.SuppressWarnings("all")
                        public ClientCollateralUpdateResponse.Changes build() {
                return new ClientCollateralUpdateResponse.Changes(this.quantity, this.locale);
            }

            @java.lang.Override
            @java.lang.SuppressWarnings("all")
                        public java.lang.String toString() {
                return "ClientCollateralUpdateResponse.Changes.ChangesBuilder(quantity=" + this.quantity + ", locale=" + this.locale + ")";
            }
        }

        @java.lang.SuppressWarnings("all")
                public static ClientCollateralUpdateResponse.Changes.ChangesBuilder builder() {
            return new ClientCollateralUpdateResponse.Changes.ChangesBuilder();
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
            if (!(o instanceof ClientCollateralUpdateResponse.Changes)) return false;
            final ClientCollateralUpdateResponse.Changes other = (ClientCollateralUpdateResponse.Changes) o;
            if (!other.canEqual((java.lang.Object) this)) return false;
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
            return other instanceof ClientCollateralUpdateResponse.Changes;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public int hashCode() {
            final int PRIME = 59;
            int result = 1;
            final java.lang.Object $quantity = this.getQuantity();
            result = result * PRIME + ($quantity == null ? 43 : $quantity.hashCode());
            final java.lang.Object $locale = this.getLocale();
            result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
            return result;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ClientCollateralUpdateResponse.Changes(quantity=" + this.getQuantity() + ", locale=" + this.getLocale() + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        ClientCollateralUpdateResponse(final Long resourceId, final Long clientId, final Changes changes) {
        this.resourceId = resourceId;
        this.clientId = clientId;
        this.changes = changes;
    }


    @java.lang.SuppressWarnings("all")
        public static class ClientCollateralUpdateResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private Long resourceId;
        @java.lang.SuppressWarnings("all")
                private Long clientId;
        @java.lang.SuppressWarnings("all")
                private Changes changes;

        @java.lang.SuppressWarnings("all")
                ClientCollateralUpdateResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientCollateralUpdateResponse.ClientCollateralUpdateResponseBuilder resourceId(final Long resourceId) {
            this.resourceId = resourceId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientCollateralUpdateResponse.ClientCollateralUpdateResponseBuilder clientId(final Long clientId) {
            this.clientId = clientId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientCollateralUpdateResponse.ClientCollateralUpdateResponseBuilder changes(final Changes changes) {
            this.changes = changes;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ClientCollateralUpdateResponse build() {
            return new ClientCollateralUpdateResponse(this.resourceId, this.clientId, this.changes);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ClientCollateralUpdateResponse.ClientCollateralUpdateResponseBuilder(resourceId=" + this.resourceId + ", clientId=" + this.clientId + ", changes=" + this.changes + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ClientCollateralUpdateResponse.ClientCollateralUpdateResponseBuilder builder() {
        return new ClientCollateralUpdateResponse.ClientCollateralUpdateResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getResourceId() {
        return this.resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public Changes getChanges() {
        return this.changes;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceId(final Long resourceId) {
        this.resourceId = resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientId(final Long clientId) {
        this.clientId = clientId;
    }

    @java.lang.SuppressWarnings("all")
        public void setChanges(final Changes changes) {
        this.changes = changes;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ClientCollateralUpdateResponse)) return false;
        final ClientCollateralUpdateResponse other = (ClientCollateralUpdateResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$resourceId = this.getResourceId();
        final java.lang.Object other$resourceId = other.getResourceId();
        if (this$resourceId == null ? other$resourceId != null : !this$resourceId.equals(other$resourceId)) return false;
        final java.lang.Object this$clientId = this.getClientId();
        final java.lang.Object other$clientId = other.getClientId();
        if (this$clientId == null ? other$clientId != null : !this$clientId.equals(other$clientId)) return false;
        final java.lang.Object this$changes = this.getChanges();
        final java.lang.Object other$changes = other.getChanges();
        if (this$changes == null ? other$changes != null : !this$changes.equals(other$changes)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ClientCollateralUpdateResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $resourceId = this.getResourceId();
        result = result * PRIME + ($resourceId == null ? 43 : $resourceId.hashCode());
        final java.lang.Object $clientId = this.getClientId();
        result = result * PRIME + ($clientId == null ? 43 : $clientId.hashCode());
        final java.lang.Object $changes = this.getChanges();
        result = result * PRIME + ($changes == null ? 43 : $changes.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ClientCollateralUpdateResponse(resourceId=" + this.getResourceId() + ", clientId=" + this.getClientId() + ", changes=" + this.getChanges() + ")";
    }
}
