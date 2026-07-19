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
package org.apache.fineract.infrastructure.core.domain;

import org.apache.fineract.infrastructure.security.domain.OidcFederationType;

/**
 * Holds the per-tenant OIDC/IdP configuration stored in the master database (m_tenant_oidc_config). One record per
 * tenant; the issuerUri is the resolution key matched against the JWT 'iss' claim.
 */
public class TenantOidcConfig {
    private Long id;
    private String tenantId;
    private OidcFederationType providerType;
    private String issuerUri;
    private String clientId;
    /**
     * Stored AES-256-GCM encrypted; never exposed in API responses.
     */
    private String clientSecret;
    /**
     * Optional: if null, derived from issuerUri via OIDC discovery.
     */
    private String jwksUri;
    private String usernameClaim;
    private String scopes;
    private String postLogoutRedirectUri;
    private boolean enabled;

    /**
     * Creates a new {@code TenantOidcConfig} instance.
     *
     * @param id
     * @param tenantId
     * @param providerType
     * @param issuerUri
     * @param clientId
     * @param clientSecret Stored AES-256-GCM encrypted; never exposed in API responses.
     * @param jwksUri Optional: if null, derived from issuerUri via OIDC discovery.
     * @param usernameClaim
     * @param scopes
     * @param postLogoutRedirectUri
     * @param enabled
     */
    @java.lang.SuppressWarnings("all")
        TenantOidcConfig(final Long id, final String tenantId, final OidcFederationType providerType, final String issuerUri, final String clientId, final String clientSecret, final String jwksUri, final String usernameClaim, final String scopes, final String postLogoutRedirectUri, final boolean enabled) {
        this.id = id;
        this.tenantId = tenantId;
        this.providerType = providerType;
        this.issuerUri = issuerUri;
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.jwksUri = jwksUri;
        this.usernameClaim = usernameClaim;
        this.scopes = scopes;
        this.postLogoutRedirectUri = postLogoutRedirectUri;
        this.enabled = enabled;
    }


    @java.lang.SuppressWarnings("all")
        public static class TenantOidcConfigBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String tenantId;
        @java.lang.SuppressWarnings("all")
                private OidcFederationType providerType;
        @java.lang.SuppressWarnings("all")
                private String issuerUri;
        @java.lang.SuppressWarnings("all")
                private String clientId;
        @java.lang.SuppressWarnings("all")
                private String clientSecret;
        @java.lang.SuppressWarnings("all")
                private String jwksUri;
        @java.lang.SuppressWarnings("all")
                private String usernameClaim;
        @java.lang.SuppressWarnings("all")
                private String scopes;
        @java.lang.SuppressWarnings("all")
                private String postLogoutRedirectUri;
        @java.lang.SuppressWarnings("all")
                private boolean enabled;

        @java.lang.SuppressWarnings("all")
                TenantOidcConfigBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfig.TenantOidcConfigBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfig.TenantOidcConfigBuilder tenantId(final String tenantId) {
            this.tenantId = tenantId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfig.TenantOidcConfigBuilder providerType(final OidcFederationType providerType) {
            this.providerType = providerType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfig.TenantOidcConfigBuilder issuerUri(final String issuerUri) {
            this.issuerUri = issuerUri;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfig.TenantOidcConfigBuilder clientId(final String clientId) {
            this.clientId = clientId;
            return this;
        }

        /**
         * Stored AES-256-GCM encrypted; never exposed in API responses.
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfig.TenantOidcConfigBuilder clientSecret(final String clientSecret) {
            this.clientSecret = clientSecret;
            return this;
        }

        /**
         * Optional: if null, derived from issuerUri via OIDC discovery.
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfig.TenantOidcConfigBuilder jwksUri(final String jwksUri) {
            this.jwksUri = jwksUri;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfig.TenantOidcConfigBuilder usernameClaim(final String usernameClaim) {
            this.usernameClaim = usernameClaim;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfig.TenantOidcConfigBuilder scopes(final String scopes) {
            this.scopes = scopes;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfig.TenantOidcConfigBuilder postLogoutRedirectUri(final String postLogoutRedirectUri) {
            this.postLogoutRedirectUri = postLogoutRedirectUri;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfig.TenantOidcConfigBuilder enabled(final boolean enabled) {
            this.enabled = enabled;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public TenantOidcConfig build() {
            return new TenantOidcConfig(this.id, this.tenantId, this.providerType, this.issuerUri, this.clientId, this.clientSecret, this.jwksUri, this.usernameClaim, this.scopes, this.postLogoutRedirectUri, this.enabled);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "TenantOidcConfig.TenantOidcConfigBuilder(id=" + this.id + ", tenantId=" + this.tenantId + ", providerType=" + this.providerType + ", issuerUri=" + this.issuerUri + ", clientId=" + this.clientId + ", clientSecret=" + this.clientSecret + ", jwksUri=" + this.jwksUri + ", usernameClaim=" + this.usernameClaim + ", scopes=" + this.scopes + ", postLogoutRedirectUri=" + this.postLogoutRedirectUri + ", enabled=" + this.enabled + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static TenantOidcConfig.TenantOidcConfigBuilder builder() {
        return new TenantOidcConfig.TenantOidcConfigBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getTenantId() {
        return this.tenantId;
    }

    @java.lang.SuppressWarnings("all")
        public OidcFederationType getProviderType() {
        return this.providerType;
    }

    @java.lang.SuppressWarnings("all")
        public String getIssuerUri() {
        return this.issuerUri;
    }

    @java.lang.SuppressWarnings("all")
        public String getClientId() {
        return this.clientId;
    }

    /**
     * Stored AES-256-GCM encrypted; never exposed in API responses.
     */
    @java.lang.SuppressWarnings("all")
        public String getClientSecret() {
        return this.clientSecret;
    }

    /**
     * Optional: if null, derived from issuerUri via OIDC discovery.
     */
    @java.lang.SuppressWarnings("all")
        public String getJwksUri() {
        return this.jwksUri;
    }

    @java.lang.SuppressWarnings("all")
        public String getUsernameClaim() {
        return this.usernameClaim;
    }

    @java.lang.SuppressWarnings("all")
        public String getScopes() {
        return this.scopes;
    }

    @java.lang.SuppressWarnings("all")
        public String getPostLogoutRedirectUri() {
        return this.postLogoutRedirectUri;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isEnabled() {
        return this.enabled;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setTenantId(final String tenantId) {
        this.tenantId = tenantId;
    }

    @java.lang.SuppressWarnings("all")
        public void setProviderType(final OidcFederationType providerType) {
        this.providerType = providerType;
    }

    @java.lang.SuppressWarnings("all")
        public void setIssuerUri(final String issuerUri) {
        this.issuerUri = issuerUri;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientId(final String clientId) {
        this.clientId = clientId;
    }

    /**
     * Stored AES-256-GCM encrypted; never exposed in API responses.
     */
    @java.lang.SuppressWarnings("all")
        public void setClientSecret(final String clientSecret) {
        this.clientSecret = clientSecret;
    }

    /**
     * Optional: if null, derived from issuerUri via OIDC discovery.
     */
    @java.lang.SuppressWarnings("all")
        public void setJwksUri(final String jwksUri) {
        this.jwksUri = jwksUri;
    }

    @java.lang.SuppressWarnings("all")
        public void setUsernameClaim(final String usernameClaim) {
        this.usernameClaim = usernameClaim;
    }

    @java.lang.SuppressWarnings("all")
        public void setScopes(final String scopes) {
        this.scopes = scopes;
    }

    @java.lang.SuppressWarnings("all")
        public void setPostLogoutRedirectUri(final String postLogoutRedirectUri) {
        this.postLogoutRedirectUri = postLogoutRedirectUri;
    }

    @java.lang.SuppressWarnings("all")
        public void setEnabled(final boolean enabled) {
        this.enabled = enabled;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof TenantOidcConfig)) return false;
        final TenantOidcConfig other = (TenantOidcConfig) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$issuerUri = this.getIssuerUri();
        final java.lang.Object other$issuerUri = other.getIssuerUri();
        if (this$issuerUri == null ? other$issuerUri != null : !this$issuerUri.equals(other$issuerUri)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof TenantOidcConfig;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $issuerUri = this.getIssuerUri();
        result = result * PRIME + ($issuerUri == null ? 43 : $issuerUri.hashCode());
        return result;
    }
}
