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
import org.apache.fineract.infrastructure.core.service.DateUtils;

public class OTPRequest {
    private String token;
    private OTPMetadata metadata;

    public static OTPRequest create(String token, int tokenLiveTimeInSec, boolean extendedAccessToken, OTPDeliveryMethod deliveryMethod) {
        final OTPMetadata metadata = new OTPMetadata().setRequestTime(DateUtils.getLocalDateTimeOfTenant().atZone(DateUtils.getDateTimeZoneOfTenant())).setTokenLiveTimeInSec(tokenLiveTimeInSec).setExtendedAccessToken(extendedAccessToken).setDeliveryMethod(deliveryMethod);
        return new OTPRequest().setToken(token).setMetadata(metadata);
    }

    public boolean isValid() {
        ZonedDateTime expireTime = metadata.getRequestTime().plusSeconds(metadata.getTokenLiveTimeInSec());
        return ZonedDateTime.now(DateUtils.getDateTimeZoneOfTenant()).isBefore(expireTime);
    }

    @java.lang.SuppressWarnings("all")
        public String getToken() {
        return this.token;
    }

    @java.lang.SuppressWarnings("all")
        public OTPMetadata getMetadata() {
        return this.metadata;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OTPRequest setToken(final String token) {
        this.token = token;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OTPRequest setMetadata(final OTPMetadata metadata) {
        this.metadata = metadata;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof OTPRequest)) return false;
        final OTPRequest other = (OTPRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$token = this.getToken();
        final java.lang.Object other$token = other.getToken();
        if (this$token == null ? other$token != null : !this$token.equals(other$token)) return false;
        final java.lang.Object this$metadata = this.getMetadata();
        final java.lang.Object other$metadata = other.getMetadata();
        if (this$metadata == null ? other$metadata != null : !this$metadata.equals(other$metadata)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof OTPRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $token = this.getToken();
        result = result * PRIME + ($token == null ? 43 : $token.hashCode());
        final java.lang.Object $metadata = this.getMetadata();
        result = result * PRIME + ($metadata == null ? 43 : $metadata.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "OTPRequest(token=" + this.getToken() + ", metadata=" + this.getMetadata() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public OTPRequest() {
    }
}
