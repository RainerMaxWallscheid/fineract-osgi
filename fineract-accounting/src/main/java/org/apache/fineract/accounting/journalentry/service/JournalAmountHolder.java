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
package org.apache.fineract.accounting.journalentry.service;

import java.math.BigDecimal;

public class JournalAmountHolder {
    private Integer accountType;
    private BigDecimal amount;

    @java.lang.SuppressWarnings("all")
        public Integer getAccountType() {
        return this.accountType;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public void setAccountType(final Integer accountType) {
        this.accountType = accountType;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmount(final BigDecimal amount) {
        this.amount = amount;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof JournalAmountHolder)) return false;
        final JournalAmountHolder other = (JournalAmountHolder) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$accountType = this.getAccountType();
        final java.lang.Object other$accountType = other.getAccountType();
        if (this$accountType == null ? other$accountType != null : !this$accountType.equals(other$accountType)) return false;
        final java.lang.Object this$amount = this.getAmount();
        final java.lang.Object other$amount = other.getAmount();
        if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof JournalAmountHolder;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $accountType = this.getAccountType();
        result = result * PRIME + ($accountType == null ? 43 : $accountType.hashCode());
        final java.lang.Object $amount = this.getAmount();
        result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "JournalAmountHolder(accountType=" + this.getAccountType() + ", amount=" + this.getAmount() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public JournalAmountHolder(final Integer accountType, final BigDecimal amount) {
        this.accountType = accountType;
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public JournalAmountHolder() {
    }
}
