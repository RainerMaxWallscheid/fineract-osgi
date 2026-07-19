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

import org.apache.fineract.infrastructure.core.domain.TenantOidcConfig;
import org.apache.fineract.infrastructure.security.domain.OidcFederationType;

/**
 * API response DTO for per-tenant OIDC configuration. The {@code clientSecret} field is intentionally omitted — it is
 * never returned in responses.
 */
public class TenantOidcConfigData {
    private String tenantId;
    private OidcFederationType providerType;
    private String issuerUri;
    private String clientId;
    private String jwksUri;
    private String usernameClaim;
    private String scopes;
    private String postLogoutRedirectUri;
    private boolean enabled;

    public static TenantOidcConfigData from(TenantOidcConfig config) {
        return TenantOidcConfigData.builder().tenantId(config.getTenantId()).providerType(config.getProviderType()).issuerUri(config.getIssuerUri()).clientId(config.getClientId()).jwksUri(config.getJwksUri()).usernameClaim(config.getUsernameClaim()).scopes(config.getScopes()).postLogoutRedirectUri(config.getPostLogoutRedirectUri()).enabled(config.isEnabled()).build();
    }

    @java.lang.SuppressWarnings("all")
        TenantOidcConfigData(final String tenantId, final OidcFederationType providerType, final String issuerUri, final String clientId, final String jwksUri, final String usernameClaim, final String scopes, final String postLogoutRedirectUri, final boolean enabled) {
        this.tenantId = tenantId;
        this.providerType = providerType;
        this.issuerUri = issuerUri;
        this.clientId = clientId;
        this.jwksUri = jwksUri;
        this.usernameClaim = usernameClaim;
        this.scopes = scopes;
        this.postLogoutRedirectUri = postLogoutRedirectUri;
        this.enabled = enabled;
    }


    @java.lang.SuppressWarnings("all")
        public static class TenantOidcConfigDataBuilder {
        @java.lang.SuppressWarnings("all")
                private String tenantId;
        @java.lang.SuppressWarnings("all")
                private OidcFederationType providerType;
        @java.lang.SuppressWarnings("all")
                private String issuerUri;
        @java.lang.SuppressWarnings("all")
                private String clientId;
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
                TenantOidcConfigDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfigData.TenantOidcConfigDataBuilder tenantId(final String tenantId) {
            this.tenantId = tenantId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfigData.TenantOidcConfigDataBuilder providerType(final OidcFederationType providerType) {
            this.providerType = providerType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfigData.TenantOidcConfigDataBuilder issuerUri(final String issuerUri) {
            this.issuerUri = issuerUri;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfigData.TenantOidcConfigDataBuilder clientId(final String clientId) {
            this.clientId = clientId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfigData.TenantOidcConfigDataBuilder jwksUri(final String jwksUri) {
            this.jwksUri = jwksUri;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfigData.TenantOidcConfigDataBuilder usernameClaim(final String usernameClaim) {
            this.usernameClaim = usernameClaim;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfigData.TenantOidcConfigDataBuilder scopes(final String scopes) {
            this.scopes = scopes;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfigData.TenantOidcConfigDataBuilder postLogoutRedirectUri(final String postLogoutRedirectUri) {
            this.postLogoutRedirectUri = postLogoutRedirectUri;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TenantOidcConfigData.TenantOidcConfigDataBuilder enabled(final boolean enabled) {
            this.enabled = enabled;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public TenantOidcConfigData build() {
            return new TenantOidcConfigData(this.tenantId, this.providerType, this.issuerUri, this.clientId, this.jwksUri, this.usernameClaim, this.scopes, this.postLogoutRedirectUri, this.enabled);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "TenantOidcConfigData.TenantOidcConfigDataBuilder(tenantId=" + this.tenantId + ", providerType=" + this.providerType + ", issuerUri=" + this.issuerUri + ", clientId=" + this.clientId + ", jwksUri=" + this.jwksUri + ", usernameClaim=" + this.usernameClaim + ", scopes=" + this.scopes + ", postLogoutRedirectUri=" + this.postLogoutRedirectUri + ", enabled=" + this.enabled + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static TenantOidcConfigData.TenantOidcConfigDataBuilder builder() {
        return new TenantOidcConfigData.TenantOidcConfigDataBuilder();
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
}
