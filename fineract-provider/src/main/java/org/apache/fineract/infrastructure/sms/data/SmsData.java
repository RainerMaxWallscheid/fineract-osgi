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

import org.apache.fineract.infrastructure.core.data.EnumOptionData;

/**
 * Immutable data object representing a SMS message.
 */
public final class SmsData {
    private Long id;
    private Long groupId;
    private Long clientId;
    private Long staffId;
    private EnumOptionData status;
    private String mobileNo;
    private String message;
    private Long providerId;
    private String campaignName;

    public static SmsData instance(final Long id, final Long groupId, final Long clientId, final Long staffId, final EnumOptionData status, final String mobileNo, final String message, final Long providerId, final String camapignName) {
        return new SmsData().setId(id).setGroupId(groupId).setClientId(clientId).setStaffId(staffId).setStatus(status).setMobileNo(mobileNo).setMessage(message).setProviderId(providerId).setCampaignName(camapignName);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getGroupId() {
        return this.groupId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getStaffId() {
        return this.staffId;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public String getMobileNo() {
        return this.mobileNo;
    }

    @java.lang.SuppressWarnings("all")
        public String getMessage() {
        return this.message;
    }

    @java.lang.SuppressWarnings("all")
        public Long getProviderId() {
        return this.providerId;
    }

    @java.lang.SuppressWarnings("all")
        public String getCampaignName() {
        return this.campaignName;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsData setGroupId(final Long groupId) {
        this.groupId = groupId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsData setClientId(final Long clientId) {
        this.clientId = clientId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsData setStaffId(final Long staffId) {
        this.staffId = staffId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsData setStatus(final EnumOptionData status) {
        this.status = status;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsData setMobileNo(final String mobileNo) {
        this.mobileNo = mobileNo;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsData setMessage(final String message) {
        this.message = message;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsData setProviderId(final Long providerId) {
        this.providerId = providerId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsData setCampaignName(final String campaignName) {
        this.campaignName = campaignName;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof SmsData)) return false;
        final SmsData other = (SmsData) o;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$groupId = this.getGroupId();
        final java.lang.Object other$groupId = other.getGroupId();
        if (this$groupId == null ? other$groupId != null : !this$groupId.equals(other$groupId)) return false;
        final java.lang.Object this$clientId = this.getClientId();
        final java.lang.Object other$clientId = other.getClientId();
        if (this$clientId == null ? other$clientId != null : !this$clientId.equals(other$clientId)) return false;
        final java.lang.Object this$staffId = this.getStaffId();
        final java.lang.Object other$staffId = other.getStaffId();
        if (this$staffId == null ? other$staffId != null : !this$staffId.equals(other$staffId)) return false;
        final java.lang.Object this$providerId = this.getProviderId();
        final java.lang.Object other$providerId = other.getProviderId();
        if (this$providerId == null ? other$providerId != null : !this$providerId.equals(other$providerId)) return false;
        final java.lang.Object this$status = this.getStatus();
        final java.lang.Object other$status = other.getStatus();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        final java.lang.Object this$mobileNo = this.getMobileNo();
        final java.lang.Object other$mobileNo = other.getMobileNo();
        if (this$mobileNo == null ? other$mobileNo != null : !this$mobileNo.equals(other$mobileNo)) return false;
        final java.lang.Object this$message = this.getMessage();
        final java.lang.Object other$message = other.getMessage();
        if (this$message == null ? other$message != null : !this$message.equals(other$message)) return false;
        final java.lang.Object this$campaignName = this.getCampaignName();
        final java.lang.Object other$campaignName = other.getCampaignName();
        if (this$campaignName == null ? other$campaignName != null : !this$campaignName.equals(other$campaignName)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $groupId = this.getGroupId();
        result = result * PRIME + ($groupId == null ? 43 : $groupId.hashCode());
        final java.lang.Object $clientId = this.getClientId();
        result = result * PRIME + ($clientId == null ? 43 : $clientId.hashCode());
        final java.lang.Object $staffId = this.getStaffId();
        result = result * PRIME + ($staffId == null ? 43 : $staffId.hashCode());
        final java.lang.Object $providerId = this.getProviderId();
        result = result * PRIME + ($providerId == null ? 43 : $providerId.hashCode());
        final java.lang.Object $status = this.getStatus();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        final java.lang.Object $mobileNo = this.getMobileNo();
        result = result * PRIME + ($mobileNo == null ? 43 : $mobileNo.hashCode());
        final java.lang.Object $message = this.getMessage();
        result = result * PRIME + ($message == null ? 43 : $message.hashCode());
        final java.lang.Object $campaignName = this.getCampaignName();
        result = result * PRIME + ($campaignName == null ? 43 : $campaignName.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "SmsData(id=" + this.getId() + ", groupId=" + this.getGroupId() + ", clientId=" + this.getClientId() + ", staffId=" + this.getStaffId() + ", status=" + this.getStatus() + ", mobileNo=" + this.getMobileNo() + ", message=" + this.getMessage() + ", providerId=" + this.getProviderId() + ", campaignName=" + this.getCampaignName() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public SmsData() {
    }
}
