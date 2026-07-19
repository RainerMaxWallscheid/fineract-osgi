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
package org.apache.fineract.portfolio.loanorigination.data;

import java.util.List;
import java.util.Set;
import org.apache.fineract.infrastructure.codes.data.CodeValueData;

public class LoanOriginatorTemplateData {
    private final String externalId;
    private final Set<String> statusOptions;
    private final List<CodeValueData> originatorTypeOptions;
    private final List<CodeValueData> channelTypeOptions;

    @java.lang.SuppressWarnings("all")
        public String getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public Set<String> getStatusOptions() {
        return this.statusOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<CodeValueData> getOriginatorTypeOptions() {
        return this.originatorTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<CodeValueData> getChannelTypeOptions() {
        return this.channelTypeOptions;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanOriginatorTemplateData)) return false;
        final LoanOriginatorTemplateData other = (LoanOriginatorTemplateData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$externalId = this.getExternalId();
        final java.lang.Object other$externalId = other.getExternalId();
        if (this$externalId == null ? other$externalId != null : !this$externalId.equals(other$externalId)) return false;
        final java.lang.Object this$statusOptions = this.getStatusOptions();
        final java.lang.Object other$statusOptions = other.getStatusOptions();
        if (this$statusOptions == null ? other$statusOptions != null : !this$statusOptions.equals(other$statusOptions)) return false;
        final java.lang.Object this$originatorTypeOptions = this.getOriginatorTypeOptions();
        final java.lang.Object other$originatorTypeOptions = other.getOriginatorTypeOptions();
        if (this$originatorTypeOptions == null ? other$originatorTypeOptions != null : !this$originatorTypeOptions.equals(other$originatorTypeOptions)) return false;
        final java.lang.Object this$channelTypeOptions = this.getChannelTypeOptions();
        final java.lang.Object other$channelTypeOptions = other.getChannelTypeOptions();
        if (this$channelTypeOptions == null ? other$channelTypeOptions != null : !this$channelTypeOptions.equals(other$channelTypeOptions)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanOriginatorTemplateData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $externalId = this.getExternalId();
        result = result * PRIME + ($externalId == null ? 43 : $externalId.hashCode());
        final java.lang.Object $statusOptions = this.getStatusOptions();
        result = result * PRIME + ($statusOptions == null ? 43 : $statusOptions.hashCode());
        final java.lang.Object $originatorTypeOptions = this.getOriginatorTypeOptions();
        result = result * PRIME + ($originatorTypeOptions == null ? 43 : $originatorTypeOptions.hashCode());
        final java.lang.Object $channelTypeOptions = this.getChannelTypeOptions();
        result = result * PRIME + ($channelTypeOptions == null ? 43 : $channelTypeOptions.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanOriginatorTemplateData(externalId=" + this.getExternalId() + ", statusOptions=" + this.getStatusOptions() + ", originatorTypeOptions=" + this.getOriginatorTypeOptions() + ", channelTypeOptions=" + this.getChannelTypeOptions() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanOriginatorTemplateData(final String externalId, final Set<String> statusOptions, final List<CodeValueData> originatorTypeOptions, final List<CodeValueData> channelTypeOptions) {
        this.externalId = externalId;
        this.statusOptions = statusOptions;
        this.originatorTypeOptions = originatorTypeOptions;
        this.channelTypeOptions = channelTypeOptions;
    }
}
