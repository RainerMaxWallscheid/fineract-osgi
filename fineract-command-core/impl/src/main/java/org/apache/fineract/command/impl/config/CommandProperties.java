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
package org.apache.fineract.command.impl.config;

import java.io.Serial;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "fineract.command")
public final class CommandProperties implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Boolean enabled;
    private Map<String, Boolean> hooks;
    private String idemPotencyKeyHeaderName;

    @java.lang.SuppressWarnings("all")
        private static Boolean $default$enabled() {
        return true;
    }

    @java.lang.SuppressWarnings("all")
        private static Map<String, Boolean> $default$hooks() {
        return new HashMap<>();
    }

    @java.lang.SuppressWarnings("all")
        private static String $default$idemPotencyKeyHeaderName() {
        return "Idempotency-Key";
    }


    @java.lang.SuppressWarnings("all")
        public static class CommandPropertiesBuilder {
        @java.lang.SuppressWarnings("all")
                private boolean enabled$set;
        @java.lang.SuppressWarnings("all")
                private Boolean enabled$value;
        @java.lang.SuppressWarnings("all")
                private boolean hooks$set;
        @java.lang.SuppressWarnings("all")
                private Map<String, Boolean> hooks$value;
        @java.lang.SuppressWarnings("all")
                private boolean idemPotencyKeyHeaderName$set;
        @java.lang.SuppressWarnings("all")
                private String idemPotencyKeyHeaderName$value;

        @java.lang.SuppressWarnings("all")
                CommandPropertiesBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandProperties.CommandPropertiesBuilder enabled(final Boolean enabled) {
            this.enabled$value = enabled;
            enabled$set = true;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandProperties.CommandPropertiesBuilder hooks(final Map<String, Boolean> hooks) {
            this.hooks$value = hooks;
            hooks$set = true;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandProperties.CommandPropertiesBuilder idemPotencyKeyHeaderName(final String idemPotencyKeyHeaderName) {
            this.idemPotencyKeyHeaderName$value = idemPotencyKeyHeaderName;
            idemPotencyKeyHeaderName$set = true;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public CommandProperties build() {
            Boolean enabled$value = this.enabled$value;
            if (!this.enabled$set) enabled$value = CommandProperties.$default$enabled();
            Map<String, Boolean> hooks$value = this.hooks$value;
            if (!this.hooks$set) hooks$value = CommandProperties.$default$hooks();
            String idemPotencyKeyHeaderName$value = this.idemPotencyKeyHeaderName$value;
            if (!this.idemPotencyKeyHeaderName$set) idemPotencyKeyHeaderName$value = CommandProperties.$default$idemPotencyKeyHeaderName();
            return new CommandProperties(enabled$value, hooks$value, idemPotencyKeyHeaderName$value);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "CommandProperties.CommandPropertiesBuilder(enabled$value=" + this.enabled$value + ", hooks$value=" + this.hooks$value + ", idemPotencyKeyHeaderName$value=" + this.idemPotencyKeyHeaderName$value + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static CommandProperties.CommandPropertiesBuilder builder() {
        return new CommandProperties.CommandPropertiesBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getEnabled() {
        return this.enabled;
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, Boolean> getHooks() {
        return this.hooks;
    }

    @java.lang.SuppressWarnings("all")
        public String getIdemPotencyKeyHeaderName() {
        return this.idemPotencyKeyHeaderName;
    }

    @java.lang.SuppressWarnings("all")
        public void setEnabled(final Boolean enabled) {
        this.enabled = enabled;
    }

    @java.lang.SuppressWarnings("all")
        public void setHooks(final Map<String, Boolean> hooks) {
        this.hooks = hooks;
    }

    @java.lang.SuppressWarnings("all")
        public void setIdemPotencyKeyHeaderName(final String idemPotencyKeyHeaderName) {
        this.idemPotencyKeyHeaderName = idemPotencyKeyHeaderName;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CommandProperties)) return false;
        final CommandProperties other = (CommandProperties) o;
        final java.lang.Object this$enabled = this.getEnabled();
        final java.lang.Object other$enabled = other.getEnabled();
        if (this$enabled == null ? other$enabled != null : !this$enabled.equals(other$enabled)) return false;
        final java.lang.Object this$hooks = this.getHooks();
        final java.lang.Object other$hooks = other.getHooks();
        if (this$hooks == null ? other$hooks != null : !this$hooks.equals(other$hooks)) return false;
        final java.lang.Object this$idemPotencyKeyHeaderName = this.getIdemPotencyKeyHeaderName();
        final java.lang.Object other$idemPotencyKeyHeaderName = other.getIdemPotencyKeyHeaderName();
        if (this$idemPotencyKeyHeaderName == null ? other$idemPotencyKeyHeaderName != null : !this$idemPotencyKeyHeaderName.equals(other$idemPotencyKeyHeaderName)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $enabled = this.getEnabled();
        result = result * PRIME + ($enabled == null ? 43 : $enabled.hashCode());
        final java.lang.Object $hooks = this.getHooks();
        result = result * PRIME + ($hooks == null ? 43 : $hooks.hashCode());
        final java.lang.Object $idemPotencyKeyHeaderName = this.getIdemPotencyKeyHeaderName();
        result = result * PRIME + ($idemPotencyKeyHeaderName == null ? 43 : $idemPotencyKeyHeaderName.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CommandProperties(enabled=" + this.getEnabled() + ", hooks=" + this.getHooks() + ", idemPotencyKeyHeaderName=" + this.getIdemPotencyKeyHeaderName() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CommandProperties() {
        this.enabled = CommandProperties.$default$enabled();
        this.hooks = CommandProperties.$default$hooks();
        this.idemPotencyKeyHeaderName = CommandProperties.$default$idemPotencyKeyHeaderName();
    }

    @java.lang.SuppressWarnings("all")
        public CommandProperties(final Boolean enabled, final Map<String, Boolean> hooks, final String idemPotencyKeyHeaderName) {
        this.enabled = enabled;
        this.hooks = hooks;
        this.idemPotencyKeyHeaderName = idemPotencyKeyHeaderName;
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String enabled = "enabled";
        public static final java.lang.String hooks = "hooks";
        public static final java.lang.String idemPotencyKeyHeaderName = "idemPotencyKeyHeaderName";
    }
}
