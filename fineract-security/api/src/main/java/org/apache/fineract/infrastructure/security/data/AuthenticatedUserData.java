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

import java.util.Collection;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.useradministration.data.RoleData;

/**
 * Immutable data object for authentication.
 */
public class AuthenticatedUserData {
    @SuppressWarnings("unused")
    private String username;
    @SuppressWarnings("unused")
    private Long userId;
    @SuppressWarnings("unused")
    private String base64EncodedAuthenticationKey;
    @SuppressWarnings("unused")
    private boolean authenticated;
    @SuppressWarnings("unused")
    private Long officeId;
    @SuppressWarnings("unused")
    private String officeName;
    @SuppressWarnings("unused")
    private Long staffId;
    @SuppressWarnings("unused")
    private String staffDisplayName;
    @SuppressWarnings("unused")
    private EnumOptionData organisationalRole;
    @SuppressWarnings("unused")
    private Collection<RoleData> roles;
    @SuppressWarnings("unused")
    private Collection<String> permissions;
    @SuppressWarnings("unused")
    private boolean shouldRenewPassword;
    @SuppressWarnings("unused")
    private boolean isTwoFactorAuthenticationRequired;

    @java.lang.SuppressWarnings("all")
        public String getUsername() {
        return this.username;
    }

    @java.lang.SuppressWarnings("all")
        public Long getUserId() {
        return this.userId;
    }

    @java.lang.SuppressWarnings("all")
        public String getBase64EncodedAuthenticationKey() {
        return this.base64EncodedAuthenticationKey;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isAuthenticated() {
        return this.authenticated;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getOfficeName() {
        return this.officeName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getStaffId() {
        return this.staffId;
    }

    @java.lang.SuppressWarnings("all")
        public String getStaffDisplayName() {
        return this.staffDisplayName;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getOrganisationalRole() {
        return this.organisationalRole;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<RoleData> getRoles() {
        return this.roles;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<String> getPermissions() {
        return this.permissions;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isShouldRenewPassword() {
        return this.shouldRenewPassword;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isTwoFactorAuthenticationRequired() {
        return this.isTwoFactorAuthenticationRequired;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AuthenticatedUserData setUsername(final String username) {
        this.username = username;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AuthenticatedUserData setUserId(final Long userId) {
        this.userId = userId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AuthenticatedUserData setBase64EncodedAuthenticationKey(final String base64EncodedAuthenticationKey) {
        this.base64EncodedAuthenticationKey = base64EncodedAuthenticationKey;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AuthenticatedUserData setAuthenticated(final boolean authenticated) {
        this.authenticated = authenticated;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AuthenticatedUserData setOfficeId(final Long officeId) {
        this.officeId = officeId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AuthenticatedUserData setOfficeName(final String officeName) {
        this.officeName = officeName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AuthenticatedUserData setStaffId(final Long staffId) {
        this.staffId = staffId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AuthenticatedUserData setStaffDisplayName(final String staffDisplayName) {
        this.staffDisplayName = staffDisplayName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AuthenticatedUserData setOrganisationalRole(final EnumOptionData organisationalRole) {
        this.organisationalRole = organisationalRole;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AuthenticatedUserData setRoles(final Collection<RoleData> roles) {
        this.roles = roles;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AuthenticatedUserData setPermissions(final Collection<String> permissions) {
        this.permissions = permissions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AuthenticatedUserData setShouldRenewPassword(final boolean shouldRenewPassword) {
        this.shouldRenewPassword = shouldRenewPassword;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AuthenticatedUserData setTwoFactorAuthenticationRequired(final boolean isTwoFactorAuthenticationRequired) {
        this.isTwoFactorAuthenticationRequired = isTwoFactorAuthenticationRequired;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AuthenticatedUserData)) return false;
        final AuthenticatedUserData other = (AuthenticatedUserData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isAuthenticated() != other.isAuthenticated()) return false;
        if (this.isShouldRenewPassword() != other.isShouldRenewPassword()) return false;
        if (this.isTwoFactorAuthenticationRequired() != other.isTwoFactorAuthenticationRequired()) return false;
        final java.lang.Object this$userId = this.getUserId();
        final java.lang.Object other$userId = other.getUserId();
        if (this$userId == null ? other$userId != null : !this$userId.equals(other$userId)) return false;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$staffId = this.getStaffId();
        final java.lang.Object other$staffId = other.getStaffId();
        if (this$staffId == null ? other$staffId != null : !this$staffId.equals(other$staffId)) return false;
        final java.lang.Object this$username = this.getUsername();
        final java.lang.Object other$username = other.getUsername();
        if (this$username == null ? other$username != null : !this$username.equals(other$username)) return false;
        final java.lang.Object this$base64EncodedAuthenticationKey = this.getBase64EncodedAuthenticationKey();
        final java.lang.Object other$base64EncodedAuthenticationKey = other.getBase64EncodedAuthenticationKey();
        if (this$base64EncodedAuthenticationKey == null ? other$base64EncodedAuthenticationKey != null : !this$base64EncodedAuthenticationKey.equals(other$base64EncodedAuthenticationKey)) return false;
        final java.lang.Object this$officeName = this.getOfficeName();
        final java.lang.Object other$officeName = other.getOfficeName();
        if (this$officeName == null ? other$officeName != null : !this$officeName.equals(other$officeName)) return false;
        final java.lang.Object this$staffDisplayName = this.getStaffDisplayName();
        final java.lang.Object other$staffDisplayName = other.getStaffDisplayName();
        if (this$staffDisplayName == null ? other$staffDisplayName != null : !this$staffDisplayName.equals(other$staffDisplayName)) return false;
        final java.lang.Object this$organisationalRole = this.getOrganisationalRole();
        final java.lang.Object other$organisationalRole = other.getOrganisationalRole();
        if (this$organisationalRole == null ? other$organisationalRole != null : !this$organisationalRole.equals(other$organisationalRole)) return false;
        final java.lang.Object this$roles = this.getRoles();
        final java.lang.Object other$roles = other.getRoles();
        if (this$roles == null ? other$roles != null : !this$roles.equals(other$roles)) return false;
        final java.lang.Object this$permissions = this.getPermissions();
        final java.lang.Object other$permissions = other.getPermissions();
        if (this$permissions == null ? other$permissions != null : !this$permissions.equals(other$permissions)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AuthenticatedUserData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isAuthenticated() ? 79 : 97);
        result = result * PRIME + (this.isShouldRenewPassword() ? 79 : 97);
        result = result * PRIME + (this.isTwoFactorAuthenticationRequired() ? 79 : 97);
        final java.lang.Object $userId = this.getUserId();
        result = result * PRIME + ($userId == null ? 43 : $userId.hashCode());
        final java.lang.Object $officeId = this.getOfficeId();
        result = result * PRIME + ($officeId == null ? 43 : $officeId.hashCode());
        final java.lang.Object $staffId = this.getStaffId();
        result = result * PRIME + ($staffId == null ? 43 : $staffId.hashCode());
        final java.lang.Object $username = this.getUsername();
        result = result * PRIME + ($username == null ? 43 : $username.hashCode());
        final java.lang.Object $base64EncodedAuthenticationKey = this.getBase64EncodedAuthenticationKey();
        result = result * PRIME + ($base64EncodedAuthenticationKey == null ? 43 : $base64EncodedAuthenticationKey.hashCode());
        final java.lang.Object $officeName = this.getOfficeName();
        result = result * PRIME + ($officeName == null ? 43 : $officeName.hashCode());
        final java.lang.Object $staffDisplayName = this.getStaffDisplayName();
        result = result * PRIME + ($staffDisplayName == null ? 43 : $staffDisplayName.hashCode());
        final java.lang.Object $organisationalRole = this.getOrganisationalRole();
        result = result * PRIME + ($organisationalRole == null ? 43 : $organisationalRole.hashCode());
        final java.lang.Object $roles = this.getRoles();
        result = result * PRIME + ($roles == null ? 43 : $roles.hashCode());
        final java.lang.Object $permissions = this.getPermissions();
        result = result * PRIME + ($permissions == null ? 43 : $permissions.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AuthenticatedUserData(username=" + this.getUsername() + ", userId=" + this.getUserId() + ", base64EncodedAuthenticationKey=" + this.getBase64EncodedAuthenticationKey() + ", authenticated=" + this.isAuthenticated() + ", officeId=" + this.getOfficeId() + ", officeName=" + this.getOfficeName() + ", staffId=" + this.getStaffId() + ", staffDisplayName=" + this.getStaffDisplayName() + ", organisationalRole=" + this.getOrganisationalRole() + ", roles=" + this.getRoles() + ", permissions=" + this.getPermissions() + ", shouldRenewPassword=" + this.isShouldRenewPassword() + ", isTwoFactorAuthenticationRequired=" + this.isTwoFactorAuthenticationRequired() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AuthenticatedUserData() {
    }
}
