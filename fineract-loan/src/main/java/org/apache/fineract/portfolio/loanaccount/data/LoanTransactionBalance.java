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

import java.math.BigDecimal;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransactionType;

public class LoanTransactionBalance {
    private final LoanTransactionType transactionType;
    private final boolean reversed;
    private final boolean manuallyAdjustedOrReversed;
    private final BigDecimal amount;

    @java.lang.SuppressWarnings("all")
        public LoanTransactionBalance(final LoanTransactionType transactionType, final boolean reversed, final boolean manuallyAdjustedOrReversed, final BigDecimal amount) {
        this.transactionType = transactionType;
        this.reversed = reversed;
        this.manuallyAdjustedOrReversed = manuallyAdjustedOrReversed;
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public LoanTransactionType getTransactionType() {
        return this.transactionType;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isReversed() {
        return this.reversed;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isManuallyAdjustedOrReversed() {
        return this.manuallyAdjustedOrReversed;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanTransactionBalance)) return false;
        final LoanTransactionBalance other = (LoanTransactionBalance) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isReversed() != other.isReversed()) return false;
        if (this.isManuallyAdjustedOrReversed() != other.isManuallyAdjustedOrReversed()) return false;
        final java.lang.Object this$transactionType = this.getTransactionType();
        final java.lang.Object other$transactionType = other.getTransactionType();
        if (this$transactionType == null ? other$transactionType != null : !this$transactionType.equals(other$transactionType)) return false;
        final java.lang.Object this$amount = this.getAmount();
        final java.lang.Object other$amount = other.getAmount();
        if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanTransactionBalance;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isReversed() ? 79 : 97);
        result = result * PRIME + (this.isManuallyAdjustedOrReversed() ? 79 : 97);
        final java.lang.Object $transactionType = this.getTransactionType();
        result = result * PRIME + ($transactionType == null ? 43 : $transactionType.hashCode());
        final java.lang.Object $amount = this.getAmount();
        result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanTransactionBalance(transactionType=" + this.getTransactionType() + ", reversed=" + this.isReversed() + ", manuallyAdjustedOrReversed=" + this.isManuallyAdjustedOrReversed() + ", amount=" + this.getAmount() + ")";
    }
}
