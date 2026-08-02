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
package org.apache.fineract.cob.data;

import com.fasterxml.jackson.annotation.JsonTypeInfo;

@JsonTypeInfo(use = JsonTypeInfo.Id.CLASS)
public class COBParameter {
    private Long minAccountId;
    private Long maxAccountId;

    @java.lang.SuppressWarnings("all")
        public COBParameter(final Long minAccountId, final Long maxAccountId) {
        this.minAccountId = minAccountId;
        this.maxAccountId = maxAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getMinAccountId() {
        return this.minAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getMaxAccountId() {
        return this.maxAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public COBParameter() {
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof COBParameter)) return false;
        final COBParameter other = (COBParameter) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$minAccountId = this.getMinAccountId();
        final java.lang.Object other$minAccountId = other.getMinAccountId();
        if (this$minAccountId == null ? other$minAccountId != null : !this$minAccountId.equals(other$minAccountId)) return false;
        final java.lang.Object this$maxAccountId = this.getMaxAccountId();
        final java.lang.Object other$maxAccountId = other.getMaxAccountId();
        if (this$maxAccountId == null ? other$maxAccountId != null : !this$maxAccountId.equals(other$maxAccountId)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof COBParameter;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $minAccountId = this.getMinAccountId();
        result = result * PRIME + ($minAccountId == null ? 43 : $minAccountId.hashCode());
        final java.lang.Object $maxAccountId = this.getMaxAccountId();
        result = result * PRIME + ($maxAccountId == null ? 43 : $maxAccountId.hashCode());
        return result;
    }
}
