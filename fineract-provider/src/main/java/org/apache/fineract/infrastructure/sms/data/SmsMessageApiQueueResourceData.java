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
import java.util.Collection;

/**
 * Immutable data object representing the API request body sent in the POST request to the "/queue" resource
 */
public class SmsMessageApiQueueResourceData {
    private Long internalId;
    private String tenantId;
    private String createdOnDate;
    private String sourceAddress;
    private String mobileNumber;
    private String message;
    private Long providerId;

    /**
     * @return a new instance of the SmsMessageApiQueueResourceData class
     */
    public static final SmsMessageApiQueueResourceData instance(Long internalId, String mifosTenantIdentifier, String createdOnDate, String sourceAddress, String mobileNumber, String message, Long providerId) {
        return new SmsMessageApiQueueResourceData().setInternalId(internalId).setTenantId(mifosTenantIdentifier).setCreatedOnDate(createdOnDate).setSourceAddress(sourceAddress).setMobileNumber(mobileNumber).setMessage(message).setProviderId(providerId);
    }

    /**
     * Returns the JSOPN representation of the current object.
     *
     * @return the JSON representation of the current object
     */
    public String toJsonString() {
        Gson gson = new Gson();
        return gson.toJson(this);
    }

    /**
     * @return JSON representation of the object
     */
    public static String toJsonString(Collection<SmsMessageApiQueueResourceData> smsResourceData) {
        Gson gson = new Gson();
        return gson.toJson(smsResourceData);
    }

    @java.lang.SuppressWarnings("all")
        public Long getInternalId() {
        return this.internalId;
    }

    @java.lang.SuppressWarnings("all")
        public String getTenantId() {
        return this.tenantId;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreatedOnDate() {
        return this.createdOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getSourceAddress() {
        return this.sourceAddress;
    }

    @java.lang.SuppressWarnings("all")
        public String getMobileNumber() {
        return this.mobileNumber;
    }

    @java.lang.SuppressWarnings("all")
        public String getMessage() {
        return this.message;
    }

    @java.lang.SuppressWarnings("all")
        public Long getProviderId() {
        return this.providerId;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageApiQueueResourceData setInternalId(final Long internalId) {
        this.internalId = internalId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageApiQueueResourceData setTenantId(final String tenantId) {
        this.tenantId = tenantId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageApiQueueResourceData setCreatedOnDate(final String createdOnDate) {
        this.createdOnDate = createdOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageApiQueueResourceData setSourceAddress(final String sourceAddress) {
        this.sourceAddress = sourceAddress;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageApiQueueResourceData setMobileNumber(final String mobileNumber) {
        this.mobileNumber = mobileNumber;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageApiQueueResourceData setMessage(final String message) {
        this.message = message;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageApiQueueResourceData setProviderId(final Long providerId) {
        this.providerId = providerId;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof SmsMessageApiQueueResourceData)) return false;
        final SmsMessageApiQueueResourceData other = (SmsMessageApiQueueResourceData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$internalId = this.getInternalId();
        final java.lang.Object other$internalId = other.getInternalId();
        if (this$internalId == null ? other$internalId != null : !this$internalId.equals(other$internalId)) return false;
        final java.lang.Object this$providerId = this.getProviderId();
        final java.lang.Object other$providerId = other.getProviderId();
        if (this$providerId == null ? other$providerId != null : !this$providerId.equals(other$providerId)) return false;
        final java.lang.Object this$tenantId = this.getTenantId();
        final java.lang.Object other$tenantId = other.getTenantId();
        if (this$tenantId == null ? other$tenantId != null : !this$tenantId.equals(other$tenantId)) return false;
        final java.lang.Object this$createdOnDate = this.getCreatedOnDate();
        final java.lang.Object other$createdOnDate = other.getCreatedOnDate();
        if (this$createdOnDate == null ? other$createdOnDate != null : !this$createdOnDate.equals(other$createdOnDate)) return false;
        final java.lang.Object this$sourceAddress = this.getSourceAddress();
        final java.lang.Object other$sourceAddress = other.getSourceAddress();
        if (this$sourceAddress == null ? other$sourceAddress != null : !this$sourceAddress.equals(other$sourceAddress)) return false;
        final java.lang.Object this$mobileNumber = this.getMobileNumber();
        final java.lang.Object other$mobileNumber = other.getMobileNumber();
        if (this$mobileNumber == null ? other$mobileNumber != null : !this$mobileNumber.equals(other$mobileNumber)) return false;
        final java.lang.Object this$message = this.getMessage();
        final java.lang.Object other$message = other.getMessage();
        if (this$message == null ? other$message != null : !this$message.equals(other$message)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof SmsMessageApiQueueResourceData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $internalId = this.getInternalId();
        result = result * PRIME + ($internalId == null ? 43 : $internalId.hashCode());
        final java.lang.Object $providerId = this.getProviderId();
        result = result * PRIME + ($providerId == null ? 43 : $providerId.hashCode());
        final java.lang.Object $tenantId = this.getTenantId();
        result = result * PRIME + ($tenantId == null ? 43 : $tenantId.hashCode());
        final java.lang.Object $createdOnDate = this.getCreatedOnDate();
        result = result * PRIME + ($createdOnDate == null ? 43 : $createdOnDate.hashCode());
        final java.lang.Object $sourceAddress = this.getSourceAddress();
        result = result * PRIME + ($sourceAddress == null ? 43 : $sourceAddress.hashCode());
        final java.lang.Object $mobileNumber = this.getMobileNumber();
        result = result * PRIME + ($mobileNumber == null ? 43 : $mobileNumber.hashCode());
        final java.lang.Object $message = this.getMessage();
        result = result * PRIME + ($message == null ? 43 : $message.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "SmsMessageApiQueueResourceData(internalId=" + this.getInternalId() + ", tenantId=" + this.getTenantId() + ", createdOnDate=" + this.getCreatedOnDate() + ", sourceAddress=" + this.getSourceAddress() + ", mobileNumber=" + this.getMobileNumber() + ", message=" + this.getMessage() + ", providerId=" + this.getProviderId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public SmsMessageApiQueueResourceData() {
    }
}
