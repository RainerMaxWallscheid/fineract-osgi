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
package org.apache.fineract.infrastructure.cache.data;

import jakarta.validation.constraints.NotNull;
import java.io.Serial;
import java.io.Serializable;

public class CacheSwitchRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @NotNull(message = "{org.apache.fineract.cache.cache-type.not-null}")
    private Integer cacheType;


    @java.lang.SuppressWarnings("all")
        public static class CacheSwitchRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Integer cacheType;

        @java.lang.SuppressWarnings("all")
                CacheSwitchRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CacheSwitchRequest.CacheSwitchRequestBuilder cacheType(final Integer cacheType) {
            this.cacheType = cacheType;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public CacheSwitchRequest build() {
            return new CacheSwitchRequest(this.cacheType);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "CacheSwitchRequest.CacheSwitchRequestBuilder(cacheType=" + this.cacheType + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static CacheSwitchRequest.CacheSwitchRequestBuilder builder() {
        return new CacheSwitchRequest.CacheSwitchRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Integer getCacheType() {
        return this.cacheType;
    }

    @java.lang.SuppressWarnings("all")
        public void setCacheType(final Integer cacheType) {
        this.cacheType = cacheType;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CacheSwitchRequest)) return false;
        final CacheSwitchRequest other = (CacheSwitchRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$cacheType = this.getCacheType();
        final java.lang.Object other$cacheType = other.getCacheType();
        if (this$cacheType == null ? other$cacheType != null : !this$cacheType.equals(other$cacheType)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof CacheSwitchRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $cacheType = this.getCacheType();
        result = result * PRIME + ($cacheType == null ? 43 : $cacheType.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CacheSwitchRequest(cacheType=" + this.getCacheType() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CacheSwitchRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public CacheSwitchRequest(final Integer cacheType) {
        this.cacheType = cacheType;
    }
}
