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

import jakarta.validation.constraints.NotNull;
import java.io.Serial;
import java.io.Serializable;
import java.util.Map;

public class ExternalEventConfigurationUpdateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @NotNull(message = "{org.apache.fineract.externalevent.configurations.not-null}")
    private Map<String, Boolean> externalEventConfigurations;


    @java.lang.SuppressWarnings("all")
        public static class ExternalEventConfigurationUpdateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Map<String, Boolean> externalEventConfigurations;

        @java.lang.SuppressWarnings("all")
                ExternalEventConfigurationUpdateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ExternalEventConfigurationUpdateRequest.ExternalEventConfigurationUpdateRequestBuilder externalEventConfigurations(final Map<String, Boolean> externalEventConfigurations) {
            this.externalEventConfigurations = externalEventConfigurations;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ExternalEventConfigurationUpdateRequest build() {
            return new ExternalEventConfigurationUpdateRequest(this.externalEventConfigurations);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ExternalEventConfigurationUpdateRequest.ExternalEventConfigurationUpdateRequestBuilder(externalEventConfigurations=" + this.externalEventConfigurations + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ExternalEventConfigurationUpdateRequest.ExternalEventConfigurationUpdateRequestBuilder builder() {
        return new ExternalEventConfigurationUpdateRequest.ExternalEventConfigurationUpdateRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, Boolean> getExternalEventConfigurations() {
        return this.externalEventConfigurations;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalEventConfigurations(final Map<String, Boolean> externalEventConfigurations) {
        this.externalEventConfigurations = externalEventConfigurations;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ExternalEventConfigurationUpdateRequest)) return false;
        final ExternalEventConfigurationUpdateRequest other = (ExternalEventConfigurationUpdateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$externalEventConfigurations = this.getExternalEventConfigurations();
        final java.lang.Object other$externalEventConfigurations = other.getExternalEventConfigurations();
        if (this$externalEventConfigurations == null ? other$externalEventConfigurations != null : !this$externalEventConfigurations.equals(other$externalEventConfigurations)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ExternalEventConfigurationUpdateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $externalEventConfigurations = this.getExternalEventConfigurations();
        result = result * PRIME + ($externalEventConfigurations == null ? 43 : $externalEventConfigurations.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ExternalEventConfigurationUpdateRequest(externalEventConfigurations=" + this.getExternalEventConfigurations() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ExternalEventConfigurationUpdateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public ExternalEventConfigurationUpdateRequest(final Map<String, Boolean> externalEventConfigurations) {
        this.externalEventConfigurations = externalEventConfigurations;
    }
}
