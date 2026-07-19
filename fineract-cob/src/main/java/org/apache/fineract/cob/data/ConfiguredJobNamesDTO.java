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
package org.apache.fineract.cob.data;

import java.util.List;

public class ConfiguredJobNamesDTO {
    private List<String> businessJobs;

    @java.lang.SuppressWarnings("all")
        public List<String> getBusinessJobs() {
        return this.businessJobs;
    }

    @java.lang.SuppressWarnings("all")
        public void setBusinessJobs(final List<String> businessJobs) {
        this.businessJobs = businessJobs;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ConfiguredJobNamesDTO)) return false;
        final ConfiguredJobNamesDTO other = (ConfiguredJobNamesDTO) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$businessJobs = this.getBusinessJobs();
        final java.lang.Object other$businessJobs = other.getBusinessJobs();
        if (this$businessJobs == null ? other$businessJobs != null : !this$businessJobs.equals(other$businessJobs)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ConfiguredJobNamesDTO;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $businessJobs = this.getBusinessJobs();
        result = result * PRIME + ($businessJobs == null ? 43 : $businessJobs.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ConfiguredJobNamesDTO(businessJobs=" + this.getBusinessJobs() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ConfiguredJobNamesDTO(final List<String> businessJobs) {
        this.businessJobs = businessJobs;
    }
}
