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

import java.util.List;

/**
 * Immutable data object representing an outbound SMS message API response data
 */
public class SmsMessageApiResponseData {
    private Integer httpStatusCode;
    private List<SmsMessageDeliveryReportData> data;

    /**
     * @return an instance of the SmsMessageApiResponseData class
     */
    public static SmsMessageApiResponseData getInstance(Integer httpStatusCode, List<SmsMessageDeliveryReportData> data) {
        return new SmsMessageApiResponseData().setHttpStatusCode(httpStatusCode).setData(data);
    }

    @java.lang.SuppressWarnings("all")
        public Integer getHttpStatusCode() {
        return this.httpStatusCode;
    }

    @java.lang.SuppressWarnings("all")
        public List<SmsMessageDeliveryReportData> getData() {
        return this.data;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageApiResponseData setHttpStatusCode(final Integer httpStatusCode) {
        this.httpStatusCode = httpStatusCode;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessageApiResponseData setData(final List<SmsMessageDeliveryReportData> data) {
        this.data = data;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof SmsMessageApiResponseData)) return false;
        final SmsMessageApiResponseData other = (SmsMessageApiResponseData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$httpStatusCode = this.getHttpStatusCode();
        final java.lang.Object other$httpStatusCode = other.getHttpStatusCode();
        if (this$httpStatusCode == null ? other$httpStatusCode != null : !this$httpStatusCode.equals(other$httpStatusCode)) return false;
        final java.lang.Object this$data = this.getData();
        final java.lang.Object other$data = other.getData();
        if (this$data == null ? other$data != null : !this$data.equals(other$data)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof SmsMessageApiResponseData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $httpStatusCode = this.getHttpStatusCode();
        result = result * PRIME + ($httpStatusCode == null ? 43 : $httpStatusCode.hashCode());
        final java.lang.Object $data = this.getData();
        result = result * PRIME + ($data == null ? 43 : $data.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "SmsMessageApiResponseData(httpStatusCode=" + this.getHttpStatusCode() + ", data=" + this.getData() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public SmsMessageApiResponseData() {
    }
}
