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

/**
 * Immutable data object representing an outbound SMS message delivery report data
 */
public class SmsMessageDeliveryReportData {
    private Long id;
    private String externalId;
    private String addedOnDate;
    private String deliveredOnDate;
    private Integer deliveryStatus;
    private Boolean hasError;
    private String errorMessage;

    /**
     * @return an instance of the SmsMessageDeliveryReportData class
     */
    public static SmsMessageDeliveryReportData getInstance(Long id, String externalId, String addedOnDate, String deliveredOnDate, Integer deliveryStatus, Boolean hasError, String errorMessage) {
        return new SmsMessageDeliveryReportData().setId(id).setExternalId(externalId).setAddedOnDate(addedOnDate).setDeliveredOnDate(deliveredOnDate).setDeliveryStatus(deliveryStatus).setHasError(hasError).setErrorMessage(errorMessage);
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
        public String getAddedOnDate() {
        return this.addedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getDeliveredOnDate() {
        return this.deliveredOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getDeliveryStatus() {
        return this.deliveryStatus;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getHasError() {
        return this.hasError;
    }

    @java.lang.SuppressWarnings("all")
        public String getErrorMessage() {
        return this.errorMessage;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageDeliveryReportData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageDeliveryReportData setExternalId(final String externalId) {
        this.externalId = externalId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageDeliveryReportData setAddedOnDate(final String addedOnDate) {
        this.addedOnDate = addedOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageDeliveryReportData setDeliveredOnDate(final String deliveredOnDate) {
        this.deliveredOnDate = deliveredOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageDeliveryReportData setDeliveryStatus(final Integer deliveryStatus) {
        this.deliveryStatus = deliveryStatus;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageDeliveryReportData setHasError(final Boolean hasError) {
        this.hasError = hasError;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageDeliveryReportData setErrorMessage(final String errorMessage) {
        this.errorMessage = errorMessage;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof SmsMessageDeliveryReportData)) return false;
        final SmsMessageDeliveryReportData other = (SmsMessageDeliveryReportData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$deliveryStatus = this.getDeliveryStatus();
        final java.lang.Object other$deliveryStatus = other.getDeliveryStatus();
        if (this$deliveryStatus == null ? other$deliveryStatus != null : !this$deliveryStatus.equals(other$deliveryStatus)) return false;
        final java.lang.Object this$hasError = this.getHasError();
        final java.lang.Object other$hasError = other.getHasError();
        if (this$hasError == null ? other$hasError != null : !this$hasError.equals(other$hasError)) return false;
        final java.lang.Object this$externalId = this.getExternalId();
        final java.lang.Object other$externalId = other.getExternalId();
        if (this$externalId == null ? other$externalId != null : !this$externalId.equals(other$externalId)) return false;
        final java.lang.Object this$addedOnDate = this.getAddedOnDate();
        final java.lang.Object other$addedOnDate = other.getAddedOnDate();
        if (this$addedOnDate == null ? other$addedOnDate != null : !this$addedOnDate.equals(other$addedOnDate)) return false;
        final java.lang.Object this$deliveredOnDate = this.getDeliveredOnDate();
        final java.lang.Object other$deliveredOnDate = other.getDeliveredOnDate();
        if (this$deliveredOnDate == null ? other$deliveredOnDate != null : !this$deliveredOnDate.equals(other$deliveredOnDate)) return false;
        final java.lang.Object this$errorMessage = this.getErrorMessage();
        final java.lang.Object other$errorMessage = other.getErrorMessage();
        if (this$errorMessage == null ? other$errorMessage != null : !this$errorMessage.equals(other$errorMessage)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof SmsMessageDeliveryReportData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $deliveryStatus = this.getDeliveryStatus();
        result = result * PRIME + ($deliveryStatus == null ? 43 : $deliveryStatus.hashCode());
        final java.lang.Object $hasError = this.getHasError();
        result = result * PRIME + ($hasError == null ? 43 : $hasError.hashCode());
        final java.lang.Object $externalId = this.getExternalId();
        result = result * PRIME + ($externalId == null ? 43 : $externalId.hashCode());
        final java.lang.Object $addedOnDate = this.getAddedOnDate();
        result = result * PRIME + ($addedOnDate == null ? 43 : $addedOnDate.hashCode());
        final java.lang.Object $deliveredOnDate = this.getDeliveredOnDate();
        result = result * PRIME + ($deliveredOnDate == null ? 43 : $deliveredOnDate.hashCode());
        final java.lang.Object $errorMessage = this.getErrorMessage();
        result = result * PRIME + ($errorMessage == null ? 43 : $errorMessage.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "SmsMessageDeliveryReportData(id=" + this.getId() + ", externalId=" + this.getExternalId() + ", addedOnDate=" + this.getAddedOnDate() + ", deliveredOnDate=" + this.getDeliveredOnDate() + ", deliveryStatus=" + this.getDeliveryStatus() + ", hasError=" + this.getHasError() + ", errorMessage=" + this.getErrorMessage() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public SmsMessageDeliveryReportData() {
    }
}
