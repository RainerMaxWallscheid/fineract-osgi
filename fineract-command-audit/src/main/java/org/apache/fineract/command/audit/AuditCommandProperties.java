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
package org.apache.fineract.command.audit;

import java.io.Serial;
import java.io.Serializable;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "fineract.command.audit")
public final class AuditCommandProperties implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Boolean enabled;

    @java.lang.SuppressWarnings("all")
        private static Boolean $default$enabled() {
        return false;
    }


    @java.lang.SuppressWarnings("all")
        public static class AuditCommandPropertiesBuilder {
        @java.lang.SuppressWarnings("all")
                private boolean enabled$set;
        @java.lang.SuppressWarnings("all")
                private Boolean enabled$value;

        @java.lang.SuppressWarnings("all")
                AuditCommandPropertiesBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AuditCommandProperties.AuditCommandPropertiesBuilder enabled(final Boolean enabled) {
            this.enabled$value = enabled;
            enabled$set = true;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public AuditCommandProperties build() {
            Boolean enabled$value = this.enabled$value;
            if (!this.enabled$set) enabled$value = AuditCommandProperties.$default$enabled();
            return new AuditCommandProperties(enabled$value);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "AuditCommandProperties.AuditCommandPropertiesBuilder(enabled$value=" + this.enabled$value + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static AuditCommandProperties.AuditCommandPropertiesBuilder builder() {
        return new AuditCommandProperties.AuditCommandPropertiesBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getEnabled() {
        return this.enabled;
    }

    @java.lang.SuppressWarnings("all")
        public void setEnabled(final Boolean enabled) {
        this.enabled = enabled;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AuditCommandProperties)) return false;
        final AuditCommandProperties other = (AuditCommandProperties) o;
        final java.lang.Object this$enabled = this.getEnabled();
        final java.lang.Object other$enabled = other.getEnabled();
        if (this$enabled == null ? other$enabled != null : !this$enabled.equals(other$enabled)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $enabled = this.getEnabled();
        result = result * PRIME + ($enabled == null ? 43 : $enabled.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AuditCommandProperties(enabled=" + this.getEnabled() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AuditCommandProperties() {
        this.enabled = AuditCommandProperties.$default$enabled();
    }

    @java.lang.SuppressWarnings("all")
        public AuditCommandProperties(final Boolean enabled) {
        this.enabled = enabled;
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String enabled = "enabled";
    }
}
