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
import org.apache.fineract.infrastructure.core.data.EnumOptionData;

public final class CacheData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @SuppressWarnings("unused")
    private EnumOptionData cacheType;
    @SuppressWarnings("unused")
    private boolean enabled;


    @java.lang.SuppressWarnings("all")
        public static class CacheDataBuilder {
        @java.lang.SuppressWarnings("all")
                private EnumOptionData cacheType;
        @java.lang.SuppressWarnings("all")
                private boolean enabled;

        @java.lang.SuppressWarnings("all")
                CacheDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CacheData.CacheDataBuilder cacheType(final EnumOptionData cacheType) {
            this.cacheType = cacheType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CacheData.CacheDataBuilder enabled(final boolean enabled) {
            this.enabled = enabled;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public CacheData build() {
            return new CacheData(this.cacheType, this.enabled);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "CacheData.CacheDataBuilder(cacheType=" + this.cacheType + ", enabled=" + this.enabled + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static CacheData.CacheDataBuilder builder() {
        return new CacheData.CacheDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getCacheType() {
        return this.cacheType;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isEnabled() {
        return this.enabled;
    }

    @java.lang.SuppressWarnings("all")
        public void setCacheType(final EnumOptionData cacheType) {
        this.cacheType = cacheType;
    }

    @java.lang.SuppressWarnings("all")
        public void setEnabled(final boolean enabled) {
        this.enabled = enabled;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CacheData)) return false;
        final CacheData other = (CacheData) o;
        if (this.isEnabled() != other.isEnabled()) return false;
        final java.lang.Object this$cacheType = this.getCacheType();
        final java.lang.Object other$cacheType = other.getCacheType();
        if (this$cacheType == null ? other$cacheType != null : !this$cacheType.equals(other$cacheType)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isEnabled() ? 79 : 97);
        final java.lang.Object $cacheType = this.getCacheType();
        result = result * PRIME + ($cacheType == null ? 43 : $cacheType.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CacheData(cacheType=" + this.getCacheType() + ", enabled=" + this.isEnabled() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CacheData() {
    }

    @java.lang.SuppressWarnings("all")
        public CacheData(final EnumOptionData cacheType, final boolean enabled) {
        this.cacheType = cacheType;
        this.enabled = enabled;
    }
}
