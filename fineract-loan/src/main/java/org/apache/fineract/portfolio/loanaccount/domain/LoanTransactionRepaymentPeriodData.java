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
package org.apache.fineract.portfolio.loanaccount.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.portfolio.loanaccount.data.LoanPrincipalRelatedDataHolder;

/**
 * Immutable data object representing a subset of loan transaction data.
 */
public class LoanTransactionRepaymentPeriodData implements LoanPrincipalRelatedDataHolder, Serializable {
    private final Long transactionId;
    private final Long loanId;
    private final LocalDate date;
    private final boolean reversed;
    private final BigDecimal amount;
    private final BigDecimal unrecognizedAmount;
    private final BigDecimal feeChargesPortion;

    public LoanTransactionRepaymentPeriodData(Long transactionId, Long loanId, LocalDate date, boolean reversed, BigDecimal amount, BigDecimal unrecognizedAmount, BigDecimal feeChargesPortion) {
        this.transactionId = transactionId;
        this.loanId = loanId;
        this.date = date;
        this.reversed = reversed;
        this.amount = amount;
        this.unrecognizedAmount = unrecognizedAmount;
        this.feeChargesPortion = feeChargesPortion;
    }

    @java.lang.SuppressWarnings("all")
        public Long getTransactionId() {
        return this.transactionId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDate() {
        return this.date;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isReversed() {
        return this.reversed;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getUnrecognizedAmount() {
        return this.unrecognizedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeChargesPortion() {
        return this.feeChargesPortion;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanTransactionRepaymentPeriodData)) return false;
        final LoanTransactionRepaymentPeriodData other = (LoanTransactionRepaymentPeriodData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isReversed() != other.isReversed()) return false;
        final java.lang.Object this$transactionId = this.getTransactionId();
        final java.lang.Object other$transactionId = other.getTransactionId();
        if (this$transactionId == null ? other$transactionId != null : !this$transactionId.equals(other$transactionId)) return false;
        final java.lang.Object this$loanId = this.getLoanId();
        final java.lang.Object other$loanId = other.getLoanId();
        if (this$loanId == null ? other$loanId != null : !this$loanId.equals(other$loanId)) return false;
        final java.lang.Object this$date = this.getDate();
        final java.lang.Object other$date = other.getDate();
        if (this$date == null ? other$date != null : !this$date.equals(other$date)) return false;
        final java.lang.Object this$amount = this.getAmount();
        final java.lang.Object other$amount = other.getAmount();
        if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
        final java.lang.Object this$unrecognizedAmount = this.getUnrecognizedAmount();
        final java.lang.Object other$unrecognizedAmount = other.getUnrecognizedAmount();
        if (this$unrecognizedAmount == null ? other$unrecognizedAmount != null : !this$unrecognizedAmount.equals(other$unrecognizedAmount)) return false;
        final java.lang.Object this$feeChargesPortion = this.getFeeChargesPortion();
        final java.lang.Object other$feeChargesPortion = other.getFeeChargesPortion();
        if (this$feeChargesPortion == null ? other$feeChargesPortion != null : !this$feeChargesPortion.equals(other$feeChargesPortion)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanTransactionRepaymentPeriodData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isReversed() ? 79 : 97);
        final java.lang.Object $transactionId = this.getTransactionId();
        result = result * PRIME + ($transactionId == null ? 43 : $transactionId.hashCode());
        final java.lang.Object $loanId = this.getLoanId();
        result = result * PRIME + ($loanId == null ? 43 : $loanId.hashCode());
        final java.lang.Object $date = this.getDate();
        result = result * PRIME + ($date == null ? 43 : $date.hashCode());
        final java.lang.Object $amount = this.getAmount();
        result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
        final java.lang.Object $unrecognizedAmount = this.getUnrecognizedAmount();
        result = result * PRIME + ($unrecognizedAmount == null ? 43 : $unrecognizedAmount.hashCode());
        final java.lang.Object $feeChargesPortion = this.getFeeChargesPortion();
        result = result * PRIME + ($feeChargesPortion == null ? 43 : $feeChargesPortion.hashCode());
        return result;
    }
}
