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

import io.swagger.v3.oas.annotations.media.Schema;
import java.io.Serial;
import java.io.Serializable;

@Schema(description = "Loan Originator request payload")
public class LoanOriginatorRequestData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Schema(description = "Unique external identifier (Revenue Share ID)", example = "REV-SHARE-001", requiredMode = Schema.RequiredMode.REQUIRED)
    private String externalId;
    @Schema(description = "Originator name", example = "Acme Merchant")
    private String name;
    @Schema(description = "Originator status", example = "ACTIVE", allowableValues = {"ACTIVE", "PENDING", "INACTIVE"})
    private String status;
    @Schema(description = "Code value ID for originator type (from LoanOriginatorType code)", example = "1")
    private Long originatorTypeId;
    @Schema(description = "Code value ID for channel type (from LoanOriginationChannelType code)", example = "2")
    private Long channelTypeId;


    @java.lang.SuppressWarnings("all")
        public static class LoanOriginatorRequestDataBuilder {
        @java.lang.SuppressWarnings("all")
                private String externalId;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private String status;
        @java.lang.SuppressWarnings("all")
                private Long originatorTypeId;
        @java.lang.SuppressWarnings("all")
                private Long channelTypeId;

        @java.lang.SuppressWarnings("all")
                LoanOriginatorRequestDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanOriginatorRequestData.LoanOriginatorRequestDataBuilder externalId(final String externalId) {
            this.externalId = externalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanOriginatorRequestData.LoanOriginatorRequestDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanOriginatorRequestData.LoanOriginatorRequestDataBuilder status(final String status) {
            this.status = status;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanOriginatorRequestData.LoanOriginatorRequestDataBuilder originatorTypeId(final Long originatorTypeId) {
            this.originatorTypeId = originatorTypeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanOriginatorRequestData.LoanOriginatorRequestDataBuilder channelTypeId(final Long channelTypeId) {
            this.channelTypeId = channelTypeId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public LoanOriginatorRequestData build() {
            return new LoanOriginatorRequestData(this.externalId, this.name, this.status, this.originatorTypeId, this.channelTypeId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "LoanOriginatorRequestData.LoanOriginatorRequestDataBuilder(externalId=" + this.externalId + ", name=" + this.name + ", status=" + this.status + ", originatorTypeId=" + this.originatorTypeId + ", channelTypeId=" + this.channelTypeId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static LoanOriginatorRequestData.LoanOriginatorRequestDataBuilder builder() {
        return new LoanOriginatorRequestData.LoanOriginatorRequestDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOriginatorTypeId() {
        return this.originatorTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getChannelTypeId() {
        return this.channelTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalId(final String externalId) {
        this.externalId = externalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setStatus(final String status) {
        this.status = status;
    }

    @java.lang.SuppressWarnings("all")
        public void setOriginatorTypeId(final Long originatorTypeId) {
        this.originatorTypeId = originatorTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setChannelTypeId(final Long channelTypeId) {
        this.channelTypeId = channelTypeId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanOriginatorRequestData)) return false;
        final LoanOriginatorRequestData other = (LoanOriginatorRequestData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$originatorTypeId = this.getOriginatorTypeId();
        final java.lang.Object other$originatorTypeId = other.getOriginatorTypeId();
        if (this$originatorTypeId == null ? other$originatorTypeId != null : !this$originatorTypeId.equals(other$originatorTypeId)) return false;
        final java.lang.Object this$channelTypeId = this.getChannelTypeId();
        final java.lang.Object other$channelTypeId = other.getChannelTypeId();
        if (this$channelTypeId == null ? other$channelTypeId != null : !this$channelTypeId.equals(other$channelTypeId)) return false;
        final java.lang.Object this$externalId = this.getExternalId();
        final java.lang.Object other$externalId = other.getExternalId();
        if (this$externalId == null ? other$externalId != null : !this$externalId.equals(other$externalId)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$status = this.getStatus();
        final java.lang.Object other$status = other.getStatus();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanOriginatorRequestData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $originatorTypeId = this.getOriginatorTypeId();
        result = result * PRIME + ($originatorTypeId == null ? 43 : $originatorTypeId.hashCode());
        final java.lang.Object $channelTypeId = this.getChannelTypeId();
        result = result * PRIME + ($channelTypeId == null ? 43 : $channelTypeId.hashCode());
        final java.lang.Object $externalId = this.getExternalId();
        result = result * PRIME + ($externalId == null ? 43 : $externalId.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $status = this.getStatus();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanOriginatorRequestData(externalId=" + this.getExternalId() + ", name=" + this.getName() + ", status=" + this.getStatus() + ", originatorTypeId=" + this.getOriginatorTypeId() + ", channelTypeId=" + this.getChannelTypeId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanOriginatorRequestData() {
    }

    @java.lang.SuppressWarnings("all")
        public LoanOriginatorRequestData(final String externalId, final String name, final String status, final Long originatorTypeId, final Long channelTypeId) {
        this.externalId = externalId;
        this.name = name;
        this.status = status;
        this.originatorTypeId = originatorTypeId;
        this.channelTypeId = channelTypeId;
    }
}
