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
package org.apache.fineract.infrastructure.configuration.data;

import java.util.List;

/**
 * Immutable data object for global configuration.
 */
public class GlobalConfigurationData {
    @SuppressWarnings("unused")
    private List<GlobalConfigurationPropertyData> globalConfiguration;

    @java.lang.SuppressWarnings("all")
        public List<GlobalConfigurationPropertyData> getGlobalConfiguration() {
        return this.globalConfiguration;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationData setGlobalConfiguration(final List<GlobalConfigurationPropertyData> globalConfiguration) {
        this.globalConfiguration = globalConfiguration;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof GlobalConfigurationData)) return false;
        final GlobalConfigurationData other = (GlobalConfigurationData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$globalConfiguration = this.getGlobalConfiguration();
        final java.lang.Object other$globalConfiguration = other.getGlobalConfiguration();
        if (this$globalConfiguration == null ? other$globalConfiguration != null : !this$globalConfiguration.equals(other$globalConfiguration)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof GlobalConfigurationData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $globalConfiguration = this.getGlobalConfiguration();
        result = result * PRIME + ($globalConfiguration == null ? 43 : $globalConfiguration.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "GlobalConfigurationData(globalConfiguration=" + this.getGlobalConfiguration() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationData() {
    }
}
