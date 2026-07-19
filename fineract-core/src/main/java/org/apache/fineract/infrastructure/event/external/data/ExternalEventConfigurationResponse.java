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
import java.util.List;

public class ExternalEventConfigurationResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    // TODO: why wrap things in this useless class?!? Just more boilerplate! Keeping for compatibility...
    private List<ExternalEventConfigurationItemResponse> externalEventConfiguration;


    @java.lang.SuppressWarnings("all")
        public static class ExternalEventConfigurationResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private List<ExternalEventConfigurationItemResponse> externalEventConfiguration;

        @java.lang.SuppressWarnings("all")
                ExternalEventConfigurationResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ExternalEventConfigurationResponse.ExternalEventConfigurationResponseBuilder externalEventConfiguration(final List<ExternalEventConfigurationItemResponse> externalEventConfiguration) {
            this.externalEventConfiguration = externalEventConfiguration;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ExternalEventConfigurationResponse build() {
            return new ExternalEventConfigurationResponse(this.externalEventConfiguration);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ExternalEventConfigurationResponse.ExternalEventConfigurationResponseBuilder(externalEventConfiguration=" + this.externalEventConfiguration + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ExternalEventConfigurationResponse.ExternalEventConfigurationResponseBuilder builder() {
        return new ExternalEventConfigurationResponse.ExternalEventConfigurationResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public List<ExternalEventConfigurationItemResponse> getExternalEventConfiguration() {
        return this.externalEventConfiguration;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalEventConfiguration(final List<ExternalEventConfigurationItemResponse> externalEventConfiguration) {
        this.externalEventConfiguration = externalEventConfiguration;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ExternalEventConfigurationResponse)) return false;
        final ExternalEventConfigurationResponse other = (ExternalEventConfigurationResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$externalEventConfiguration = this.getExternalEventConfiguration();
        final java.lang.Object other$externalEventConfiguration = other.getExternalEventConfiguration();
        if (this$externalEventConfiguration == null ? other$externalEventConfiguration != null : !this$externalEventConfiguration.equals(other$externalEventConfiguration)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ExternalEventConfigurationResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $externalEventConfiguration = this.getExternalEventConfiguration();
        result = result * PRIME + ($externalEventConfiguration == null ? 43 : $externalEventConfiguration.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ExternalEventConfigurationResponse(externalEventConfiguration=" + this.getExternalEventConfiguration() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ExternalEventConfigurationResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public ExternalEventConfigurationResponse(final List<ExternalEventConfigurationItemResponse> externalEventConfiguration) {
        this.externalEventConfiguration = externalEventConfiguration;
    }
}
