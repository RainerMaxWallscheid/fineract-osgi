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
package org.apache.fineract.organisation.teller.domain.model.request;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;

public class CashierTransactionRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    public String currencyCode;
    public BigDecimal txnAmount;
    public String txnNote;
    public String locale;
    public String dateFormat;
    public String txnDate;

    @java.lang.SuppressWarnings("all")
        public String getCurrencyCode() {
        return this.currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTxnAmount() {
        return this.txnAmount;
    }

    @java.lang.SuppressWarnings("all")
        public String getTxnNote() {
        return this.txnNote;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getTxnDate() {
        return this.txnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrencyCode(final String currencyCode) {
        this.currencyCode = currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public void setTxnAmount(final BigDecimal txnAmount) {
        this.txnAmount = txnAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setTxnNote(final String txnNote) {
        this.txnNote = txnNote;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setTxnDate(final String txnDate) {
        this.txnDate = txnDate;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CashierTransactionRequest)) return false;
        final CashierTransactionRequest other = (CashierTransactionRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$currencyCode = this.getCurrencyCode();
        final java.lang.Object other$currencyCode = other.getCurrencyCode();
        if (this$currencyCode == null ? other$currencyCode != null : !this$currencyCode.equals(other$currencyCode)) return false;
        final java.lang.Object this$txnAmount = this.getTxnAmount();
        final java.lang.Object other$txnAmount = other.getTxnAmount();
        if (this$txnAmount == null ? other$txnAmount != null : !this$txnAmount.equals(other$txnAmount)) return false;
        final java.lang.Object this$txnNote = this.getTxnNote();
        final java.lang.Object other$txnNote = other.getTxnNote();
        if (this$txnNote == null ? other$txnNote != null : !this$txnNote.equals(other$txnNote)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$txnDate = this.getTxnDate();
        final java.lang.Object other$txnDate = other.getTxnDate();
        if (this$txnDate == null ? other$txnDate != null : !this$txnDate.equals(other$txnDate)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof CashierTransactionRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $currencyCode = this.getCurrencyCode();
        result = result * PRIME + ($currencyCode == null ? 43 : $currencyCode.hashCode());
        final java.lang.Object $txnAmount = this.getTxnAmount();
        result = result * PRIME + ($txnAmount == null ? 43 : $txnAmount.hashCode());
        final java.lang.Object $txnNote = this.getTxnNote();
        result = result * PRIME + ($txnNote == null ? 43 : $txnNote.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $txnDate = this.getTxnDate();
        result = result * PRIME + ($txnDate == null ? 43 : $txnDate.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CashierTransactionRequest(currencyCode=" + this.getCurrencyCode() + ", txnAmount=" + this.getTxnAmount() + ", txnNote=" + this.getTxnNote() + ", locale=" + this.getLocale() + ", dateFormat=" + this.getDateFormat() + ", txnDate=" + this.getTxnDate() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CashierTransactionRequest() {
    }
}
