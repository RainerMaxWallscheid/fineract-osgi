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

public class COBPartition {
    private Long minId;
    private Long maxId;
    private Long pageNo;
    private Long count;

    @java.lang.SuppressWarnings("all")
        public Long getMinId() {
        return this.minId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getMaxId() {
        return this.maxId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getPageNo() {
        return this.pageNo;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCount() {
        return this.count;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinId(final Long minId) {
        this.minId = minId;
    }

    @java.lang.SuppressWarnings("all")
        public void setMaxId(final Long maxId) {
        this.maxId = maxId;
    }

    @java.lang.SuppressWarnings("all")
        public void setPageNo(final Long pageNo) {
        this.pageNo = pageNo;
    }

    @java.lang.SuppressWarnings("all")
        public void setCount(final Long count) {
        this.count = count;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof COBPartition)) return false;
        final COBPartition other = (COBPartition) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$minId = this.getMinId();
        final java.lang.Object other$minId = other.getMinId();
        if (this$minId == null ? other$minId != null : !this$minId.equals(other$minId)) return false;
        final java.lang.Object this$maxId = this.getMaxId();
        final java.lang.Object other$maxId = other.getMaxId();
        if (this$maxId == null ? other$maxId != null : !this$maxId.equals(other$maxId)) return false;
        final java.lang.Object this$pageNo = this.getPageNo();
        final java.lang.Object other$pageNo = other.getPageNo();
        if (this$pageNo == null ? other$pageNo != null : !this$pageNo.equals(other$pageNo)) return false;
        final java.lang.Object this$count = this.getCount();
        final java.lang.Object other$count = other.getCount();
        if (this$count == null ? other$count != null : !this$count.equals(other$count)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof COBPartition;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $minId = this.getMinId();
        result = result * PRIME + ($minId == null ? 43 : $minId.hashCode());
        final java.lang.Object $maxId = this.getMaxId();
        result = result * PRIME + ($maxId == null ? 43 : $maxId.hashCode());
        final java.lang.Object $pageNo = this.getPageNo();
        result = result * PRIME + ($pageNo == null ? 43 : $pageNo.hashCode());
        final java.lang.Object $count = this.getCount();
        result = result * PRIME + ($count == null ? 43 : $count.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "COBPartition(minId=" + this.getMinId() + ", maxId=" + this.getMaxId() + ", pageNo=" + this.getPageNo() + ", count=" + this.getCount() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public COBPartition(final Long minId, final Long maxId, final Long pageNo, final Long count) {
        this.minId = minId;
        this.maxId = maxId;
        this.pageNo = pageNo;
        this.count = count;
    }
}
