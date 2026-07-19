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
package org.apache.fineract.portfolio.address.filter;

public class ClientAddressSearchParam {
    private Long clientId;
    private Long addressTypeId;
    private String status;

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getAddressTypeId() {
        return this.addressTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientId(final Long clientId) {
        this.clientId = clientId;
    }

    @java.lang.SuppressWarnings("all")
        public void setAddressTypeId(final Long addressTypeId) {
        this.addressTypeId = addressTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setStatus(final String status) {
        this.status = status;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ClientAddressSearchParam)) return false;
        final ClientAddressSearchParam other = (ClientAddressSearchParam) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$clientId = this.getClientId();
        final java.lang.Object other$clientId = other.getClientId();
        if (this$clientId == null ? other$clientId != null : !this$clientId.equals(other$clientId)) return false;
        final java.lang.Object this$addressTypeId = this.getAddressTypeId();
        final java.lang.Object other$addressTypeId = other.getAddressTypeId();
        if (this$addressTypeId == null ? other$addressTypeId != null : !this$addressTypeId.equals(other$addressTypeId)) return false;
        final java.lang.Object this$status = this.getStatus();
        final java.lang.Object other$status = other.getStatus();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ClientAddressSearchParam;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $clientId = this.getClientId();
        result = result * PRIME + ($clientId == null ? 43 : $clientId.hashCode());
        final java.lang.Object $addressTypeId = this.getAddressTypeId();
        result = result * PRIME + ($addressTypeId == null ? 43 : $addressTypeId.hashCode());
        final java.lang.Object $status = this.getStatus();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ClientAddressSearchParam(clientId=" + this.getClientId() + ", addressTypeId=" + this.getAddressTypeId() + ", status=" + this.getStatus() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ClientAddressSearchParam(final Long clientId, final Long addressTypeId, final String status) {
        this.clientId = clientId;
        this.addressTypeId = addressTypeId;
        this.status = status;
    }

    @java.lang.SuppressWarnings("all")
        public ClientAddressSearchParam() {
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String clientId = "clientId";
        public static final java.lang.String addressTypeId = "addressTypeId";
        public static final java.lang.String status = "status";
    }
}
