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

import java.time.LocalDate;
import java.util.List;

public class OldestCOBProcessedLoanDTO {
    private List<Long> loanIds;
    private LocalDate cobProcessedDate;
    private LocalDate cobBusinessDate;

    @java.lang.SuppressWarnings("all")
        public OldestCOBProcessedLoanDTO() {
    }

    @java.lang.SuppressWarnings("all")
        public List<Long> getLoanIds() {
        return this.loanIds;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getCobProcessedDate() {
        return this.cobProcessedDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getCobBusinessDate() {
        return this.cobBusinessDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanIds(final List<Long> loanIds) {
        this.loanIds = loanIds;
    }

    @java.lang.SuppressWarnings("all")
        public void setCobProcessedDate(final LocalDate cobProcessedDate) {
        this.cobProcessedDate = cobProcessedDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setCobBusinessDate(final LocalDate cobBusinessDate) {
        this.cobBusinessDate = cobBusinessDate;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof OldestCOBProcessedLoanDTO)) return false;
        final OldestCOBProcessedLoanDTO other = (OldestCOBProcessedLoanDTO) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$loanIds = this.getLoanIds();
        final java.lang.Object other$loanIds = other.getLoanIds();
        if (this$loanIds == null ? other$loanIds != null : !this$loanIds.equals(other$loanIds)) return false;
        final java.lang.Object this$cobProcessedDate = this.getCobProcessedDate();
        final java.lang.Object other$cobProcessedDate = other.getCobProcessedDate();
        if (this$cobProcessedDate == null ? other$cobProcessedDate != null : !this$cobProcessedDate.equals(other$cobProcessedDate)) return false;
        final java.lang.Object this$cobBusinessDate = this.getCobBusinessDate();
        final java.lang.Object other$cobBusinessDate = other.getCobBusinessDate();
        if (this$cobBusinessDate == null ? other$cobBusinessDate != null : !this$cobBusinessDate.equals(other$cobBusinessDate)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof OldestCOBProcessedLoanDTO;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $loanIds = this.getLoanIds();
        result = result * PRIME + ($loanIds == null ? 43 : $loanIds.hashCode());
        final java.lang.Object $cobProcessedDate = this.getCobProcessedDate();
        result = result * PRIME + ($cobProcessedDate == null ? 43 : $cobProcessedDate.hashCode());
        final java.lang.Object $cobBusinessDate = this.getCobBusinessDate();
        result = result * PRIME + ($cobBusinessDate == null ? 43 : $cobBusinessDate.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "OldestCOBProcessedLoanDTO(loanIds=" + this.getLoanIds() + ", cobProcessedDate=" + this.getCobProcessedDate() + ", cobBusinessDate=" + this.getCobBusinessDate() + ")";
    }
}
