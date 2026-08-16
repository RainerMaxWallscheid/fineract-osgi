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

import java.io.Serial;
import java.io.Serializable;
import java.util.Map;

public class CacheSwitchResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Integer cacheType;
    private Map<String, Object> changes;


    @java.lang.SuppressWarnings("all")
        public static class CacheSwitchResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private Integer cacheType;
        @java.lang.SuppressWarnings("all")
                private Map<String, Object> changes;

        @java.lang.SuppressWarnings("all")
                CacheSwitchResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CacheSwitchResponse.CacheSwitchResponseBuilder cacheType(final Integer cacheType) {
            this.cacheType = cacheType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CacheSwitchResponse.CacheSwitchResponseBuilder changes(final Map<String, Object> changes) {
            this.changes = changes;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public CacheSwitchResponse build() {
            return new CacheSwitchResponse(this.cacheType, this.changes);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "CacheSwitchResponse.CacheSwitchResponseBuilder(cacheType=" + this.cacheType + ", changes=" + this.changes + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static CacheSwitchResponse.CacheSwitchResponseBuilder builder() {
        return new CacheSwitchResponse.CacheSwitchResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Integer getCacheType() {
        return this.cacheType;
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, Object> getChanges() {
        return this.changes;
    }

    @java.lang.SuppressWarnings("all")
        public void setCacheType(final Integer cacheType) {
        this.cacheType = cacheType;
    }

    @java.lang.SuppressWarnings("all")
        public void setChanges(final Map<String, Object> changes) {
        this.changes = changes;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CacheSwitchResponse)) return false;
        final CacheSwitchResponse other = (CacheSwitchResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$cacheType = this.getCacheType();
        final java.lang.Object other$cacheType = other.getCacheType();
        if (this$cacheType == null ? other$cacheType != null : !this$cacheType.equals(other$cacheType)) return false;
        final java.lang.Object this$changes = this.getChanges();
        final java.lang.Object other$changes = other.getChanges();
        if (this$changes == null ? other$changes != null : !this$changes.equals(other$changes)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof CacheSwitchResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $cacheType = this.getCacheType();
        result = result * PRIME + ($cacheType == null ? 43 : $cacheType.hashCode());
        final java.lang.Object $changes = this.getChanges();
        result = result * PRIME + ($changes == null ? 43 : $changes.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CacheSwitchResponse(cacheType=" + this.getCacheType() + ", changes=" + this.getChanges() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CacheSwitchResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public CacheSwitchResponse(final Integer cacheType, final Map<String, Object> changes) {
        this.cacheType = cacheType;
        this.changes = changes;
    }
}
