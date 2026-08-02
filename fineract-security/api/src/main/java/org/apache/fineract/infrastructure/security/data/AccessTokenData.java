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

public class AccessTokenData {
    private String token;
    private ZonedDateTime validFrom;
    private ZonedDateTime validTo;

    @java.lang.SuppressWarnings("all")
        public String getToken() {
        return this.token;
    }

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getValidFrom() {
        return this.validFrom;
    }

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getValidTo() {
        return this.validTo;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccessTokenData setToken(final String token) {
        this.token = token;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccessTokenData setValidFrom(final ZonedDateTime validFrom) {
        this.validFrom = validFrom;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccessTokenData setValidTo(final ZonedDateTime validTo) {
        this.validTo = validTo;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AccessTokenData)) return false;
        final AccessTokenData other = (AccessTokenData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$token = this.getToken();
        final java.lang.Object other$token = other.getToken();
        if (this$token == null ? other$token != null : !this$token.equals(other$token)) return false;
        final java.lang.Object this$validFrom = this.getValidFrom();
        final java.lang.Object other$validFrom = other.getValidFrom();
        if (this$validFrom == null ? other$validFrom != null : !this$validFrom.equals(other$validFrom)) return false;
        final java.lang.Object this$validTo = this.getValidTo();
        final java.lang.Object other$validTo = other.getValidTo();
        if (this$validTo == null ? other$validTo != null : !this$validTo.equals(other$validTo)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AccessTokenData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $token = this.getToken();
        result = result * PRIME + ($token == null ? 43 : $token.hashCode());
        final java.lang.Object $validFrom = this.getValidFrom();
        result = result * PRIME + ($validFrom == null ? 43 : $validFrom.hashCode());
        final java.lang.Object $validTo = this.getValidTo();
        result = result * PRIME + ($validTo == null ? 43 : $validTo.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AccessTokenData(token=" + this.getToken() + ", validFrom=" + this.getValidFrom() + ", validTo=" + this.getValidTo() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AccessTokenData() {
    }
}
