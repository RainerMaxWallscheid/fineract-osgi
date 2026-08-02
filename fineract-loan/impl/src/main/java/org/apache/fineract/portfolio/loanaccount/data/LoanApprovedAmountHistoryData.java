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
package org.apache.fineract.portfolio.loanaccount.data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.OffsetDateTime;
import org.apache.fineract.infrastructure.core.domain.ExternalId;

/**
 * Immutable object representing an Approved Amount change operation on a Loan
 *
 * Note: no getter/setters required as google-gson will produce json from fields of object.
 */
public class LoanApprovedAmountHistoryData implements Serializable {
    private Long loanId;
    private ExternalId externalLoanId;
    private BigDecimal newApprovedAmount;
    private BigDecimal oldApprovedAmount;
    private OffsetDateTime dateOfChange;

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getExternalLoanId() {
        return this.externalLoanId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getNewApprovedAmount() {
        return this.newApprovedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOldApprovedAmount() {
        return this.oldApprovedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public OffsetDateTime getDateOfChange() {
        return this.dateOfChange;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApprovedAmountHistoryData setLoanId(final Long loanId) {
        this.loanId = loanId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApprovedAmountHistoryData setExternalLoanId(final ExternalId externalLoanId) {
        this.externalLoanId = externalLoanId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApprovedAmountHistoryData setNewApprovedAmount(final BigDecimal newApprovedAmount) {
        this.newApprovedAmount = newApprovedAmount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApprovedAmountHistoryData setOldApprovedAmount(final BigDecimal oldApprovedAmount) {
        this.oldApprovedAmount = oldApprovedAmount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApprovedAmountHistoryData setDateOfChange(final OffsetDateTime dateOfChange) {
        this.dateOfChange = dateOfChange;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanApprovedAmountHistoryData)) return false;
        final LoanApprovedAmountHistoryData other = (LoanApprovedAmountHistoryData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$loanId = this.getLoanId();
        final java.lang.Object other$loanId = other.getLoanId();
        if (this$loanId == null ? other$loanId != null : !this$loanId.equals(other$loanId)) return false;
        final java.lang.Object this$externalLoanId = this.getExternalLoanId();
        final java.lang.Object other$externalLoanId = other.getExternalLoanId();
        if (this$externalLoanId == null ? other$externalLoanId != null : !this$externalLoanId.equals(other$externalLoanId)) return false;
        final java.lang.Object this$newApprovedAmount = this.getNewApprovedAmount();
        final java.lang.Object other$newApprovedAmount = other.getNewApprovedAmount();
        if (this$newApprovedAmount == null ? other$newApprovedAmount != null : !this$newApprovedAmount.equals(other$newApprovedAmount)) return false;
        final java.lang.Object this$oldApprovedAmount = this.getOldApprovedAmount();
        final java.lang.Object other$oldApprovedAmount = other.getOldApprovedAmount();
        if (this$oldApprovedAmount == null ? other$oldApprovedAmount != null : !this$oldApprovedAmount.equals(other$oldApprovedAmount)) return false;
        final java.lang.Object this$dateOfChange = this.getDateOfChange();
        final java.lang.Object other$dateOfChange = other.getDateOfChange();
        if (this$dateOfChange == null ? other$dateOfChange != null : !this$dateOfChange.equals(other$dateOfChange)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanApprovedAmountHistoryData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $loanId = this.getLoanId();
        result = result * PRIME + ($loanId == null ? 43 : $loanId.hashCode());
        final java.lang.Object $externalLoanId = this.getExternalLoanId();
        result = result * PRIME + ($externalLoanId == null ? 43 : $externalLoanId.hashCode());
        final java.lang.Object $newApprovedAmount = this.getNewApprovedAmount();
        result = result * PRIME + ($newApprovedAmount == null ? 43 : $newApprovedAmount.hashCode());
        final java.lang.Object $oldApprovedAmount = this.getOldApprovedAmount();
        result = result * PRIME + ($oldApprovedAmount == null ? 43 : $oldApprovedAmount.hashCode());
        final java.lang.Object $dateOfChange = this.getDateOfChange();
        result = result * PRIME + ($dateOfChange == null ? 43 : $dateOfChange.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanApprovedAmountHistoryData(loanId=" + this.getLoanId() + ", externalLoanId=" + this.getExternalLoanId() + ", newApprovedAmount=" + this.getNewApprovedAmount() + ", oldApprovedAmount=" + this.getOldApprovedAmount() + ", dateOfChange=" + this.getDateOfChange() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanApprovedAmountHistoryData() {
    }

    @java.lang.SuppressWarnings("all")
        public LoanApprovedAmountHistoryData(final Long loanId, final ExternalId externalLoanId, final BigDecimal newApprovedAmount, final BigDecimal oldApprovedAmount, final OffsetDateTime dateOfChange) {
        this.loanId = loanId;
        this.externalLoanId = externalLoanId;
        this.newApprovedAmount = newApprovedAmount;
        this.oldApprovedAmount = oldApprovedAmount;
        this.dateOfChange = dateOfChange;
    }
}
