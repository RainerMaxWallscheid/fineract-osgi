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
package org.apache.fineract.infrastructure.security.data;

import java.time.ZonedDateTime;

public class OTPMetadata {
    private ZonedDateTime requestTime;
    private int tokenLiveTimeInSec;
    private boolean extendedAccessToken;
    private OTPDeliveryMethod deliveryMethod;

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getRequestTime() {
        return this.requestTime;
    }

    @java.lang.SuppressWarnings("all")
        public int getTokenLiveTimeInSec() {
        return this.tokenLiveTimeInSec;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isExtendedAccessToken() {
        return this.extendedAccessToken;
    }

    @java.lang.SuppressWarnings("all")
        public OTPDeliveryMethod getDeliveryMethod() {
        return this.deliveryMethod;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OTPMetadata setRequestTime(final ZonedDateTime requestTime) {
        this.requestTime = requestTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OTPMetadata setTokenLiveTimeInSec(final int tokenLiveTimeInSec) {
        this.tokenLiveTimeInSec = tokenLiveTimeInSec;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OTPMetadata setExtendedAccessToken(final boolean extendedAccessToken) {
        this.extendedAccessToken = extendedAccessToken;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OTPMetadata setDeliveryMethod(final OTPDeliveryMethod deliveryMethod) {
        this.deliveryMethod = deliveryMethod;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof OTPMetadata)) return false;
        final OTPMetadata other = (OTPMetadata) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.getTokenLiveTimeInSec() != other.getTokenLiveTimeInSec()) return false;
        if (this.isExtendedAccessToken() != other.isExtendedAccessToken()) return false;
        final java.lang.Object this$requestTime = this.getRequestTime();
        final java.lang.Object other$requestTime = other.getRequestTime();
        if (this$requestTime == null ? other$requestTime != null : !this$requestTime.equals(other$requestTime)) return false;
        final java.lang.Object this$deliveryMethod = this.getDeliveryMethod();
        final java.lang.Object other$deliveryMethod = other.getDeliveryMethod();
        if (this$deliveryMethod == null ? other$deliveryMethod != null : !this$deliveryMethod.equals(other$deliveryMethod)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof OTPMetadata;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + this.getTokenLiveTimeInSec();
        result = result * PRIME + (this.isExtendedAccessToken() ? 79 : 97);
        final java.lang.Object $requestTime = this.getRequestTime();
        result = result * PRIME + ($requestTime == null ? 43 : $requestTime.hashCode());
        final java.lang.Object $deliveryMethod = this.getDeliveryMethod();
        result = result * PRIME + ($deliveryMethod == null ? 43 : $deliveryMethod.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "OTPMetadata(requestTime=" + this.getRequestTime() + ", tokenLiveTimeInSec=" + this.getTokenLiveTimeInSec() + ", extendedAccessToken=" + this.isExtendedAccessToken() + ", deliveryMethod=" + this.getDeliveryMethod() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public OTPMetadata() {
    }
}
