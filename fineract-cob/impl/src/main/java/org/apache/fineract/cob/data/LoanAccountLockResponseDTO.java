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

import java.io.Serial;
import java.io.Serializable;
import java.util.List;
import org.apache.fineract.cob.domain.LoanAccountLock;

public class LoanAccountLockResponseDTO implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private int page;
    private int limit;
    private List<LoanAccountLock> content;

    @java.lang.SuppressWarnings("all")
        public int getPage() {
        return this.page;
    }

    @java.lang.SuppressWarnings("all")
        public int getLimit() {
        return this.limit;
    }

    @java.lang.SuppressWarnings("all")
        public List<LoanAccountLock> getContent() {
        return this.content;
    }

    @java.lang.SuppressWarnings("all")
        public void setPage(final int page) {
        this.page = page;
    }

    @java.lang.SuppressWarnings("all")
        public void setLimit(final int limit) {
        this.limit = limit;
    }

    @java.lang.SuppressWarnings("all")
        public void setContent(final List<LoanAccountLock> content) {
        this.content = content;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanAccountLockResponseDTO)) return false;
        final LoanAccountLockResponseDTO other = (LoanAccountLockResponseDTO) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.getPage() != other.getPage()) return false;
        if (this.getLimit() != other.getLimit()) return false;
        final java.lang.Object this$content = this.getContent();
        final java.lang.Object other$content = other.getContent();
        if (this$content == null ? other$content != null : !this$content.equals(other$content)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanAccountLockResponseDTO;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + this.getPage();
        result = result * PRIME + this.getLimit();
        final java.lang.Object $content = this.getContent();
        result = result * PRIME + ($content == null ? 43 : $content.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanAccountLockResponseDTO(page=" + this.getPage() + ", limit=" + this.getLimit() + ", content=" + this.getContent() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanAccountLockResponseDTO(final int page, final int limit, final List<LoanAccountLock> content) {
        this.page = page;
        this.limit = limit;
        this.content = content;
    }

    @java.lang.SuppressWarnings("all")
        public LoanAccountLockResponseDTO() {
    }
}
