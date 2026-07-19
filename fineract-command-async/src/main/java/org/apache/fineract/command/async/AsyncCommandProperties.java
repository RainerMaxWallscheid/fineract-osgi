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
package org.apache.fineract.command.async;

import java.io.Serial;
import java.io.Serializable;
import java.time.Duration;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "fineract.command.async")
public final class AsyncCommandProperties implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Boolean enabled;
    private Duration timeout;

    @java.lang.SuppressWarnings("all")
        private static Boolean $default$enabled() {
        return false;
    }

    @java.lang.SuppressWarnings("all")
        private static Duration $default$timeout() {
        return Duration.ofSeconds(3L);
    }


    @java.lang.SuppressWarnings("all")
        public static class AsyncCommandPropertiesBuilder {
        @java.lang.SuppressWarnings("all")
                private boolean enabled$set;
        @java.lang.SuppressWarnings("all")
                private Boolean enabled$value;
        @java.lang.SuppressWarnings("all")
                private boolean timeout$set;
        @java.lang.SuppressWarnings("all")
                private Duration timeout$value;

        @java.lang.SuppressWarnings("all")
                AsyncCommandPropertiesBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AsyncCommandProperties.AsyncCommandPropertiesBuilder enabled(final Boolean enabled) {
            this.enabled$value = enabled;
            enabled$set = true;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AsyncCommandProperties.AsyncCommandPropertiesBuilder timeout(final Duration timeout) {
            this.timeout$value = timeout;
            timeout$set = true;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public AsyncCommandProperties build() {
            Boolean enabled$value = this.enabled$value;
            if (!this.enabled$set) enabled$value = AsyncCommandProperties.$default$enabled();
            Duration timeout$value = this.timeout$value;
            if (!this.timeout$set) timeout$value = AsyncCommandProperties.$default$timeout();
            return new AsyncCommandProperties(enabled$value, timeout$value);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "AsyncCommandProperties.AsyncCommandPropertiesBuilder(enabled$value=" + this.enabled$value + ", timeout$value=" + this.timeout$value + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static AsyncCommandProperties.AsyncCommandPropertiesBuilder builder() {
        return new AsyncCommandProperties.AsyncCommandPropertiesBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getEnabled() {
        return this.enabled;
    }

    @java.lang.SuppressWarnings("all")
        public Duration getTimeout() {
        return this.timeout;
    }

    @java.lang.SuppressWarnings("all")
        public void setEnabled(final Boolean enabled) {
        this.enabled = enabled;
    }

    @java.lang.SuppressWarnings("all")
        public void setTimeout(final Duration timeout) {
        this.timeout = timeout;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AsyncCommandProperties)) return false;
        final AsyncCommandProperties other = (AsyncCommandProperties) o;
        final java.lang.Object this$enabled = this.getEnabled();
        final java.lang.Object other$enabled = other.getEnabled();
        if (this$enabled == null ? other$enabled != null : !this$enabled.equals(other$enabled)) return false;
        final java.lang.Object this$timeout = this.getTimeout();
        final java.lang.Object other$timeout = other.getTimeout();
        if (this$timeout == null ? other$timeout != null : !this$timeout.equals(other$timeout)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $enabled = this.getEnabled();
        result = result * PRIME + ($enabled == null ? 43 : $enabled.hashCode());
        final java.lang.Object $timeout = this.getTimeout();
        result = result * PRIME + ($timeout == null ? 43 : $timeout.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AsyncCommandProperties(enabled=" + this.getEnabled() + ", timeout=" + this.getTimeout() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AsyncCommandProperties() {
        this.enabled = AsyncCommandProperties.$default$enabled();
        this.timeout = AsyncCommandProperties.$default$timeout();
    }

    @java.lang.SuppressWarnings("all")
        public AsyncCommandProperties(final Boolean enabled, final Duration timeout) {
        this.enabled = enabled;
        this.timeout = timeout;
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String enabled = "enabled";
        public static final java.lang.String timeout = "timeout";
    }
}
