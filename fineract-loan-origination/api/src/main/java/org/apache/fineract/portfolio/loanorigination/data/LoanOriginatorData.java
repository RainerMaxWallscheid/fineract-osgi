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

import java.io.Serial;
import java.io.Serializable;
import org.apache.fineract.infrastructure.codes.data.CodeValueData;

public class LoanOriginatorData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private String externalId;
    private String name;
    private String status;
    private CodeValueData originatorType;
    private CodeValueData channelType;


    @java.lang.SuppressWarnings("all")
        public static class LoanOriginatorDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String externalId;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private String status;
        @java.lang.SuppressWarnings("all")
                private CodeValueData originatorType;
        @java.lang.SuppressWarnings("all")
                private CodeValueData channelType;

        @java.lang.SuppressWarnings("all")
                LoanOriginatorDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanOriginatorData.LoanOriginatorDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanOriginatorData.LoanOriginatorDataBuilder externalId(final String externalId) {
            this.externalId = externalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanOriginatorData.LoanOriginatorDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanOriginatorData.LoanOriginatorDataBuilder status(final String status) {
            this.status = status;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanOriginatorData.LoanOriginatorDataBuilder originatorType(final CodeValueData originatorType) {
            this.originatorType = originatorType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanOriginatorData.LoanOriginatorDataBuilder channelType(final CodeValueData channelType) {
            this.channelType = channelType;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public LoanOriginatorData build() {
            return new LoanOriginatorData(this.id, this.externalId, this.name, this.status, this.originatorType, this.channelType);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "LoanOriginatorData.LoanOriginatorDataBuilder(id=" + this.id + ", externalId=" + this.externalId + ", name=" + this.name + ", status=" + this.status + ", originatorType=" + this.originatorType + ", channelType=" + this.channelType + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static LoanOriginatorData.LoanOriginatorDataBuilder builder() {
        return new LoanOriginatorData.LoanOriginatorDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
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
        public CodeValueData getOriginatorType() {
        return this.originatorType;
    }

    @java.lang.SuppressWarnings("all")
        public CodeValueData getChannelType() {
        return this.channelType;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
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
        public void setOriginatorType(final CodeValueData originatorType) {
        this.originatorType = originatorType;
    }

    @java.lang.SuppressWarnings("all")
        public void setChannelType(final CodeValueData channelType) {
        this.channelType = channelType;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanOriginatorData)) return false;
        final LoanOriginatorData other = (LoanOriginatorData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$externalId = this.getExternalId();
        final java.lang.Object other$externalId = other.getExternalId();
        if (this$externalId == null ? other$externalId != null : !this$externalId.equals(other$externalId)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$status = this.getStatus();
        final java.lang.Object other$status = other.getStatus();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        final java.lang.Object this$originatorType = this.getOriginatorType();
        final java.lang.Object other$originatorType = other.getOriginatorType();
        if (this$originatorType == null ? other$originatorType != null : !this$originatorType.equals(other$originatorType)) return false;
        final java.lang.Object this$channelType = this.getChannelType();
        final java.lang.Object other$channelType = other.getChannelType();
        if (this$channelType == null ? other$channelType != null : !this$channelType.equals(other$channelType)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanOriginatorData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $externalId = this.getExternalId();
        result = result * PRIME + ($externalId == null ? 43 : $externalId.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $status = this.getStatus();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        final java.lang.Object $originatorType = this.getOriginatorType();
        result = result * PRIME + ($originatorType == null ? 43 : $originatorType.hashCode());
        final java.lang.Object $channelType = this.getChannelType();
        result = result * PRIME + ($channelType == null ? 43 : $channelType.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanOriginatorData(id=" + this.getId() + ", externalId=" + this.getExternalId() + ", name=" + this.getName() + ", status=" + this.getStatus() + ", originatorType=" + this.getOriginatorType() + ", channelType=" + this.getChannelType() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanOriginatorData() {
    }

    @java.lang.SuppressWarnings("all")
        public LoanOriginatorData(final Long id, final String externalId, final String name, final String status, final CodeValueData originatorType, final CodeValueData channelType) {
        this.id = id;
        this.externalId = externalId;
        this.name = name;
        this.status = status;
        this.originatorType = originatorType;
        this.channelType = channelType;
    }
}
