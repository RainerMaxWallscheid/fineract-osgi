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
package org.apache.fineract.infrastructure.security.data;

public class TenantAuthenticationDetails {
    private String userName;
    private String tenantId;
    private String password;

    @java.lang.SuppressWarnings("all")
        public String getUserName() {
        return this.userName;
    }

    @java.lang.SuppressWarnings("all")
        public String getTenantId() {
        return this.tenantId;
    }

    @java.lang.SuppressWarnings("all")
        public String getPassword() {
        return this.password;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TenantAuthenticationDetails setUserName(final String userName) {
        this.userName = userName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TenantAuthenticationDetails setTenantId(final String tenantId) {
        this.tenantId = tenantId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TenantAuthenticationDetails setPassword(final String password) {
        this.password = password;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof TenantAuthenticationDetails)) return false;
        final TenantAuthenticationDetails other = (TenantAuthenticationDetails) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$userName = this.getUserName();
        final java.lang.Object other$userName = other.getUserName();
        if (this$userName == null ? other$userName != null : !this$userName.equals(other$userName)) return false;
        final java.lang.Object this$tenantId = this.getTenantId();
        final java.lang.Object other$tenantId = other.getTenantId();
        if (this$tenantId == null ? other$tenantId != null : !this$tenantId.equals(other$tenantId)) return false;
        final java.lang.Object this$password = this.getPassword();
        final java.lang.Object other$password = other.getPassword();
        if (this$password == null ? other$password != null : !this$password.equals(other$password)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof TenantAuthenticationDetails;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $userName = this.getUserName();
        result = result * PRIME + ($userName == null ? 43 : $userName.hashCode());
        final java.lang.Object $tenantId = this.getTenantId();
        result = result * PRIME + ($tenantId == null ? 43 : $tenantId.hashCode());
        final java.lang.Object $password = this.getPassword();
        result = result * PRIME + ($password == null ? 43 : $password.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "TenantAuthenticationDetails(userName=" + this.getUserName() + ", tenantId=" + this.getTenantId() + ", password=" + this.getPassword() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public TenantAuthenticationDetails(final String userName, final String tenantId, final String password) {
        this.userName = userName;
        this.tenantId = tenantId;
        this.password = password;
    }
}
