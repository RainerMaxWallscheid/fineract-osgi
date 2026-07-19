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

import java.io.Serializable;
import java.time.LocalDate;
import java.util.HashMap;
import org.apache.fineract.infrastructure.businessdate.domain.BusinessDateType;

@com.fasterxml.jackson.databind.annotation.JsonDeserialize(builder = FineractContext.FineractContextBuilder.class)
public class FineractContext implements Serializable {
    private final String contextHolder;
    private final FineractPlatformTenant tenantContext;
    private final String authTokenContext;
    private final HashMap<BusinessDateType, LocalDate> businessDateContext;
    private final ActionContext actionContext;


    @java.lang.SuppressWarnings("all")
        @com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder(withPrefix = "", buildMethodName = "build")
    public static class FineractContextBuilder {
        @java.lang.SuppressWarnings("all")
                private String contextHolder;
        @java.lang.SuppressWarnings("all")
                private FineractPlatformTenant tenantContext;
        @java.lang.SuppressWarnings("all")
                private String authTokenContext;
        @java.lang.SuppressWarnings("all")
                private HashMap<BusinessDateType, LocalDate> businessDateContext;
        @java.lang.SuppressWarnings("all")
                private ActionContext actionContext;

        @java.lang.SuppressWarnings("all")
                FineractContextBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractContext.FineractContextBuilder contextHolder(final String contextHolder) {
            this.contextHolder = contextHolder;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractContext.FineractContextBuilder tenantContext(final FineractPlatformTenant tenantContext) {
            this.tenantContext = tenantContext;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractContext.FineractContextBuilder authTokenContext(final String authTokenContext) {
            this.authTokenContext = authTokenContext;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractContext.FineractContextBuilder businessDateContext(final HashMap<BusinessDateType, LocalDate> businessDateContext) {
            this.businessDateContext = businessDateContext;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractContext.FineractContextBuilder actionContext(final ActionContext actionContext) {
            this.actionContext = actionContext;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public FineractContext build() {
            return new FineractContext(this.contextHolder, this.tenantContext, this.authTokenContext, this.businessDateContext, this.actionContext);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "FineractContext.FineractContextBuilder(contextHolder=" + this.contextHolder + ", tenantContext=" + this.tenantContext + ", authTokenContext=" + this.authTokenContext + ", businessDateContext=" + this.businessDateContext + ", actionContext=" + this.actionContext + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static FineractContext.FineractContextBuilder builder() {
        return new FineractContext.FineractContextBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public FineractContext(final String contextHolder, final FineractPlatformTenant tenantContext, final String authTokenContext, final HashMap<BusinessDateType, LocalDate> businessDateContext, final ActionContext actionContext) {
        this.contextHolder = contextHolder;
        this.tenantContext = tenantContext;
        this.authTokenContext = authTokenContext;
        this.businessDateContext = businessDateContext;
        this.actionContext = actionContext;
    }

    @java.lang.SuppressWarnings("all")
        public String getContextHolder() {
        return this.contextHolder;
    }

    @java.lang.SuppressWarnings("all")
        public FineractPlatformTenant getTenantContext() {
        return this.tenantContext;
    }

    @java.lang.SuppressWarnings("all")
        public String getAuthTokenContext() {
        return this.authTokenContext;
    }

    @java.lang.SuppressWarnings("all")
        public HashMap<BusinessDateType, LocalDate> getBusinessDateContext() {
        return this.businessDateContext;
    }

    @java.lang.SuppressWarnings("all")
        public ActionContext getActionContext() {
        return this.actionContext;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof FineractContext)) return false;
        final FineractContext other = (FineractContext) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$contextHolder = this.getContextHolder();
        final java.lang.Object other$contextHolder = other.getContextHolder();
        if (this$contextHolder == null ? other$contextHolder != null : !this$contextHolder.equals(other$contextHolder)) return false;
        final java.lang.Object this$tenantContext = this.getTenantContext();
        final java.lang.Object other$tenantContext = other.getTenantContext();
        if (this$tenantContext == null ? other$tenantContext != null : !this$tenantContext.equals(other$tenantContext)) return false;
        final java.lang.Object this$authTokenContext = this.getAuthTokenContext();
        final java.lang.Object other$authTokenContext = other.getAuthTokenContext();
        if (this$authTokenContext == null ? other$authTokenContext != null : !this$authTokenContext.equals(other$authTokenContext)) return false;
        final java.lang.Object this$businessDateContext = this.getBusinessDateContext();
        final java.lang.Object other$businessDateContext = other.getBusinessDateContext();
        if (this$businessDateContext == null ? other$businessDateContext != null : !this$businessDateContext.equals(other$businessDateContext)) return false;
        final java.lang.Object this$actionContext = this.getActionContext();
        final java.lang.Object other$actionContext = other.getActionContext();
        if (this$actionContext == null ? other$actionContext != null : !this$actionContext.equals(other$actionContext)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof FineractContext;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $contextHolder = this.getContextHolder();
        result = result * PRIME + ($contextHolder == null ? 43 : $contextHolder.hashCode());
        final java.lang.Object $tenantContext = this.getTenantContext();
        result = result * PRIME + ($tenantContext == null ? 43 : $tenantContext.hashCode());
        final java.lang.Object $authTokenContext = this.getAuthTokenContext();
        result = result * PRIME + ($authTokenContext == null ? 43 : $authTokenContext.hashCode());
        final java.lang.Object $businessDateContext = this.getBusinessDateContext();
        result = result * PRIME + ($businessDateContext == null ? 43 : $businessDateContext.hashCode());
        final java.lang.Object $actionContext = this.getActionContext();
        result = result * PRIME + ($actionContext == null ? 43 : $actionContext.hashCode());
        return result;
    }
}
