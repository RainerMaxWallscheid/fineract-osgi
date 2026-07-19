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
package org.apache.fineract.command.jdbc;

import java.io.Serial;
import java.io.Serializable;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "fineract.command.jdbc")
public final class JdbcCommandProperties implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Boolean enabled;
    private Boolean fileDeadLetterQueueEnabled;
    private String fileDeadLetterQueuePath;

    @java.lang.SuppressWarnings("all")
        private static Boolean $default$enabled() {
        return false;
    }

    @java.lang.SuppressWarnings("all")
        private static Boolean $default$fileDeadLetterQueueEnabled() {
        return false;
    }

    @java.lang.SuppressWarnings("all")
        private static String $default$fileDeadLetterQueuePath() {
        return "/tmp/fineract/dlq";
    }


    @java.lang.SuppressWarnings("all")
        public static class JdbcCommandPropertiesBuilder {
        @java.lang.SuppressWarnings("all")
                private boolean enabled$set;
        @java.lang.SuppressWarnings("all")
                private Boolean enabled$value;
        @java.lang.SuppressWarnings("all")
                private boolean fileDeadLetterQueueEnabled$set;
        @java.lang.SuppressWarnings("all")
                private Boolean fileDeadLetterQueueEnabled$value;
        @java.lang.SuppressWarnings("all")
                private boolean fileDeadLetterQueuePath$set;
        @java.lang.SuppressWarnings("all")
                private String fileDeadLetterQueuePath$value;

        @java.lang.SuppressWarnings("all")
                JdbcCommandPropertiesBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JdbcCommandProperties.JdbcCommandPropertiesBuilder enabled(final Boolean enabled) {
            this.enabled$value = enabled;
            enabled$set = true;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JdbcCommandProperties.JdbcCommandPropertiesBuilder fileDeadLetterQueueEnabled(final Boolean fileDeadLetterQueueEnabled) {
            this.fileDeadLetterQueueEnabled$value = fileDeadLetterQueueEnabled;
            fileDeadLetterQueueEnabled$set = true;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JdbcCommandProperties.JdbcCommandPropertiesBuilder fileDeadLetterQueuePath(final String fileDeadLetterQueuePath) {
            this.fileDeadLetterQueuePath$value = fileDeadLetterQueuePath;
            fileDeadLetterQueuePath$set = true;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public JdbcCommandProperties build() {
            Boolean enabled$value = this.enabled$value;
            if (!this.enabled$set) enabled$value = JdbcCommandProperties.$default$enabled();
            Boolean fileDeadLetterQueueEnabled$value = this.fileDeadLetterQueueEnabled$value;
            if (!this.fileDeadLetterQueueEnabled$set) fileDeadLetterQueueEnabled$value = JdbcCommandProperties.$default$fileDeadLetterQueueEnabled();
            String fileDeadLetterQueuePath$value = this.fileDeadLetterQueuePath$value;
            if (!this.fileDeadLetterQueuePath$set) fileDeadLetterQueuePath$value = JdbcCommandProperties.$default$fileDeadLetterQueuePath();
            return new JdbcCommandProperties(enabled$value, fileDeadLetterQueueEnabled$value, fileDeadLetterQueuePath$value);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "JdbcCommandProperties.JdbcCommandPropertiesBuilder(enabled$value=" + this.enabled$value + ", fileDeadLetterQueueEnabled$value=" + this.fileDeadLetterQueueEnabled$value + ", fileDeadLetterQueuePath$value=" + this.fileDeadLetterQueuePath$value + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static JdbcCommandProperties.JdbcCommandPropertiesBuilder builder() {
        return new JdbcCommandProperties.JdbcCommandPropertiesBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getEnabled() {
        return this.enabled;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getFileDeadLetterQueueEnabled() {
        return this.fileDeadLetterQueueEnabled;
    }

    @java.lang.SuppressWarnings("all")
        public String getFileDeadLetterQueuePath() {
        return this.fileDeadLetterQueuePath;
    }

    @java.lang.SuppressWarnings("all")
        public void setEnabled(final Boolean enabled) {
        this.enabled = enabled;
    }

    @java.lang.SuppressWarnings("all")
        public void setFileDeadLetterQueueEnabled(final Boolean fileDeadLetterQueueEnabled) {
        this.fileDeadLetterQueueEnabled = fileDeadLetterQueueEnabled;
    }

    @java.lang.SuppressWarnings("all")
        public void setFileDeadLetterQueuePath(final String fileDeadLetterQueuePath) {
        this.fileDeadLetterQueuePath = fileDeadLetterQueuePath;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof JdbcCommandProperties)) return false;
        final JdbcCommandProperties other = (JdbcCommandProperties) o;
        final java.lang.Object this$enabled = this.getEnabled();
        final java.lang.Object other$enabled = other.getEnabled();
        if (this$enabled == null ? other$enabled != null : !this$enabled.equals(other$enabled)) return false;
        final java.lang.Object this$fileDeadLetterQueueEnabled = this.getFileDeadLetterQueueEnabled();
        final java.lang.Object other$fileDeadLetterQueueEnabled = other.getFileDeadLetterQueueEnabled();
        if (this$fileDeadLetterQueueEnabled == null ? other$fileDeadLetterQueueEnabled != null : !this$fileDeadLetterQueueEnabled.equals(other$fileDeadLetterQueueEnabled)) return false;
        final java.lang.Object this$fileDeadLetterQueuePath = this.getFileDeadLetterQueuePath();
        final java.lang.Object other$fileDeadLetterQueuePath = other.getFileDeadLetterQueuePath();
        if (this$fileDeadLetterQueuePath == null ? other$fileDeadLetterQueuePath != null : !this$fileDeadLetterQueuePath.equals(other$fileDeadLetterQueuePath)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $enabled = this.getEnabled();
        result = result * PRIME + ($enabled == null ? 43 : $enabled.hashCode());
        final java.lang.Object $fileDeadLetterQueueEnabled = this.getFileDeadLetterQueueEnabled();
        result = result * PRIME + ($fileDeadLetterQueueEnabled == null ? 43 : $fileDeadLetterQueueEnabled.hashCode());
        final java.lang.Object $fileDeadLetterQueuePath = this.getFileDeadLetterQueuePath();
        result = result * PRIME + ($fileDeadLetterQueuePath == null ? 43 : $fileDeadLetterQueuePath.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "JdbcCommandProperties(enabled=" + this.getEnabled() + ", fileDeadLetterQueueEnabled=" + this.getFileDeadLetterQueueEnabled() + ", fileDeadLetterQueuePath=" + this.getFileDeadLetterQueuePath() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public JdbcCommandProperties() {
        this.enabled = JdbcCommandProperties.$default$enabled();
        this.fileDeadLetterQueueEnabled = JdbcCommandProperties.$default$fileDeadLetterQueueEnabled();
        this.fileDeadLetterQueuePath = JdbcCommandProperties.$default$fileDeadLetterQueuePath();
    }

    @java.lang.SuppressWarnings("all")
        public JdbcCommandProperties(final Boolean enabled, final Boolean fileDeadLetterQueueEnabled, final String fileDeadLetterQueuePath) {
        this.enabled = enabled;
        this.fileDeadLetterQueueEnabled = fileDeadLetterQueueEnabled;
        this.fileDeadLetterQueuePath = fileDeadLetterQueuePath;
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String enabled = "enabled";
        public static final java.lang.String fileDeadLetterQueueEnabled = "fileDeadLetterQueueEnabled";
        public static final java.lang.String fileDeadLetterQueuePath = "fileDeadLetterQueuePath";
    }
}
