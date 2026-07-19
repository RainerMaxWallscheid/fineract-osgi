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

@com.fasterxml.jackson.databind.annotation.JsonDeserialize(builder = FineractPlatformTenant.FineractPlatformTenantBuilder.class)
public class FineractPlatformTenant implements Serializable {
    private final Long id;
    private final String tenantIdentifier;
    private final String name;
    private final String timezoneId;
    private final FineractPlatformTenantConnection connection;


    @java.lang.SuppressWarnings("all")
        @com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder(withPrefix = "", buildMethodName = "build")
    public static class FineractPlatformTenantBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String tenantIdentifier;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private String timezoneId;
        @java.lang.SuppressWarnings("all")
                private FineractPlatformTenantConnection connection;

        @java.lang.SuppressWarnings("all")
                FineractPlatformTenantBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenant.FineractPlatformTenantBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenant.FineractPlatformTenantBuilder tenantIdentifier(final String tenantIdentifier) {
            this.tenantIdentifier = tenantIdentifier;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenant.FineractPlatformTenantBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenant.FineractPlatformTenantBuilder timezoneId(final String timezoneId) {
            this.timezoneId = timezoneId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenant.FineractPlatformTenantBuilder connection(final FineractPlatformTenantConnection connection) {
            this.connection = connection;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenant build() {
            return new FineractPlatformTenant(this.id, this.tenantIdentifier, this.name, this.timezoneId, this.connection);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "FineractPlatformTenant.FineractPlatformTenantBuilder(id=" + this.id + ", tenantIdentifier=" + this.tenantIdentifier + ", name=" + this.name + ", timezoneId=" + this.timezoneId + ", connection=" + this.connection + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static FineractPlatformTenant.FineractPlatformTenantBuilder builder() {
        return new FineractPlatformTenant.FineractPlatformTenantBuilder();
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof FineractPlatformTenant)) return false;
        final FineractPlatformTenant other = (FineractPlatformTenant) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$tenantIdentifier = this.getTenantIdentifier();
        final java.lang.Object other$tenantIdentifier = other.getTenantIdentifier();
        if (this$tenantIdentifier == null ? other$tenantIdentifier != null : !this$tenantIdentifier.equals(other$tenantIdentifier)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$timezoneId = this.getTimezoneId();
        final java.lang.Object other$timezoneId = other.getTimezoneId();
        if (this$timezoneId == null ? other$timezoneId != null : !this$timezoneId.equals(other$timezoneId)) return false;
        final java.lang.Object this$connection = this.getConnection();
        final java.lang.Object other$connection = other.getConnection();
        if (this$connection == null ? other$connection != null : !this$connection.equals(other$connection)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof FineractPlatformTenant;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $tenantIdentifier = this.getTenantIdentifier();
        result = result * PRIME + ($tenantIdentifier == null ? 43 : $tenantIdentifier.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $timezoneId = this.getTimezoneId();
        result = result * PRIME + ($timezoneId == null ? 43 : $timezoneId.hashCode());
        final java.lang.Object $connection = this.getConnection();
        result = result * PRIME + ($connection == null ? 43 : $connection.hashCode());
        return result;
    }

    @java.lang.SuppressWarnings("all")
        public FineractPlatformTenant(final Long id, final String tenantIdentifier, final String name, final String timezoneId, final FineractPlatformTenantConnection connection) {
        this.id = id;
        this.tenantIdentifier = tenantIdentifier;
        this.name = name;
        this.timezoneId = timezoneId;
        this.connection = connection;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getTenantIdentifier() {
        return this.tenantIdentifier;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getTimezoneId() {
        return this.timezoneId;
    }

    @java.lang.SuppressWarnings("all")
        public FineractPlatformTenantConnection getConnection() {
        return this.connection;
    }
}
