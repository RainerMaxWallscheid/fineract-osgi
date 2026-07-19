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

public class LoanApplicationOriginatorData {
    private Long id;
    private String externalId;
    private String name;
    private Long typeId;
    private Long channelTypeId;

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
        public Long getTypeId() {
        return this.typeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getChannelTypeId() {
        return this.channelTypeId;
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
        public void setTypeId(final Long typeId) {
        this.typeId = typeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setChannelTypeId(final Long channelTypeId) {
        this.channelTypeId = channelTypeId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanApplicationOriginatorData)) return false;
        final LoanApplicationOriginatorData other = (LoanApplicationOriginatorData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$typeId = this.getTypeId();
        final java.lang.Object other$typeId = other.getTypeId();
        if (this$typeId == null ? other$typeId != null : !this$typeId.equals(other$typeId)) return false;
        final java.lang.Object this$channelTypeId = this.getChannelTypeId();
        final java.lang.Object other$channelTypeId = other.getChannelTypeId();
        if (this$channelTypeId == null ? other$channelTypeId != null : !this$channelTypeId.equals(other$channelTypeId)) return false;
        final java.lang.Object this$externalId = this.getExternalId();
        final java.lang.Object other$externalId = other.getExternalId();
        if (this$externalId == null ? other$externalId != null : !this$externalId.equals(other$externalId)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanApplicationOriginatorData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $typeId = this.getTypeId();
        result = result * PRIME + ($typeId == null ? 43 : $typeId.hashCode());
        final java.lang.Object $channelTypeId = this.getChannelTypeId();
        result = result * PRIME + ($channelTypeId == null ? 43 : $channelTypeId.hashCode());
        final java.lang.Object $externalId = this.getExternalId();
        result = result * PRIME + ($externalId == null ? 43 : $externalId.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanApplicationOriginatorData(id=" + this.getId() + ", externalId=" + this.getExternalId() + ", name=" + this.getName() + ", typeId=" + this.getTypeId() + ", channelTypeId=" + this.getChannelTypeId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanApplicationOriginatorData() {
    }

    @java.lang.SuppressWarnings("all")
        public LoanApplicationOriginatorData(final Long id, final String externalId, final String name, final Long typeId, final Long channelTypeId) {
        this.id = id;
        this.externalId = externalId;
        this.name = name;
        this.typeId = typeId;
        this.channelTypeId = channelTypeId;
    }
}
