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
package org.apache.fineract.infrastructure.sms.data;

import com.google.gson.Gson;
import java.util.List;

/**
 * Immutable data object representing the API request body sent in the POST request to the "/report" resource
 */
public class SmsMessageApiReportResourceData {
    private List<Long> externalIds;
    private String mifosTenantIdentifier;

    /**
     * @return new instance of the SmsMessageApiReportResourceData class
     */
    public static final SmsMessageApiReportResourceData instance(List<Long> externalIds, String mifosTenantIdentifier) {
        return new SmsMessageApiReportResourceData().setExternalIds(externalIds).setMifosTenantIdentifier(mifosTenantIdentifier);
    }

    /**
     * @return JSON representation of the object
     */
    public String toJsonString() {
        Gson gson = new Gson();
        return gson.toJson(this);
    }

    @java.lang.SuppressWarnings("all")
        public List<Long> getExternalIds() {
        return this.externalIds;
    }

    @java.lang.SuppressWarnings("all")
        public String getMifosTenantIdentifier() {
        return this.mifosTenantIdentifier;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageApiReportResourceData setExternalIds(final List<Long> externalIds) {
        this.externalIds = externalIds;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageApiReportResourceData setMifosTenantIdentifier(final String mifosTenantIdentifier) {
        this.mifosTenantIdentifier = mifosTenantIdentifier;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof SmsMessageApiReportResourceData)) return false;
        final SmsMessageApiReportResourceData other = (SmsMessageApiReportResourceData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$externalIds = this.getExternalIds();
        final java.lang.Object other$externalIds = other.getExternalIds();
        if (this$externalIds == null ? other$externalIds != null : !this$externalIds.equals(other$externalIds)) return false;
        final java.lang.Object this$mifosTenantIdentifier = this.getMifosTenantIdentifier();
        final java.lang.Object other$mifosTenantIdentifier = other.getMifosTenantIdentifier();
        if (this$mifosTenantIdentifier == null ? other$mifosTenantIdentifier != null : !this$mifosTenantIdentifier.equals(other$mifosTenantIdentifier)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof SmsMessageApiReportResourceData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $externalIds = this.getExternalIds();
        result = result * PRIME + ($externalIds == null ? 43 : $externalIds.hashCode());
        final java.lang.Object $mifosTenantIdentifier = this.getMifosTenantIdentifier();
        result = result * PRIME + ($mifosTenantIdentifier == null ? 43 : $mifosTenantIdentifier.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "SmsMessageApiReportResourceData(externalIds=" + this.getExternalIds() + ", mifosTenantIdentifier=" + this.getMifosTenantIdentifier() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public SmsMessageApiReportResourceData() {
    }
}
