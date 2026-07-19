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
package org.apache.fineract.infrastructure.event.external.data;

import java.io.Serial;
import java.io.Serializable;

public class ExternalEventConfigurationItemResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String type;
    private boolean enabled;


    @java.lang.SuppressWarnings("all")
        public static class ExternalEventConfigurationItemResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private String type;
        @java.lang.SuppressWarnings("all")
                private boolean enabled;

        @java.lang.SuppressWarnings("all")
                ExternalEventConfigurationItemResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ExternalEventConfigurationItemResponse.ExternalEventConfigurationItemResponseBuilder type(final String type) {
            this.type = type;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ExternalEventConfigurationItemResponse.ExternalEventConfigurationItemResponseBuilder enabled(final boolean enabled) {
            this.enabled = enabled;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ExternalEventConfigurationItemResponse build() {
            return new ExternalEventConfigurationItemResponse(this.type, this.enabled);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ExternalEventConfigurationItemResponse.ExternalEventConfigurationItemResponseBuilder(type=" + this.type + ", enabled=" + this.enabled + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ExternalEventConfigurationItemResponse.ExternalEventConfigurationItemResponseBuilder builder() {
        return new ExternalEventConfigurationItemResponse.ExternalEventConfigurationItemResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isEnabled() {
        return this.enabled;
    }

    @java.lang.SuppressWarnings("all")
        public void setType(final String type) {
        this.type = type;
    }

    @java.lang.SuppressWarnings("all")
        public void setEnabled(final boolean enabled) {
        this.enabled = enabled;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ExternalEventConfigurationItemResponse)) return false;
        final ExternalEventConfigurationItemResponse other = (ExternalEventConfigurationItemResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isEnabled() != other.isEnabled()) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ExternalEventConfigurationItemResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isEnabled() ? 79 : 97);
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ExternalEventConfigurationItemResponse(type=" + this.getType() + ", enabled=" + this.isEnabled() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ExternalEventConfigurationItemResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public ExternalEventConfigurationItemResponse(final String type, final boolean enabled) {
        this.type = type;
        this.enabled = enabled;
    }
}
