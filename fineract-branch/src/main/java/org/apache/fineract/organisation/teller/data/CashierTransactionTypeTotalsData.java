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
package org.apache.fineract.organisation.teller.data;

import java.io.Serializable;
import java.math.BigDecimal;

public final class CashierTransactionTypeTotalsData implements Serializable {
    private Integer cashierTxnType;
    private BigDecimal cashTotal;

    public static CashierTransactionTypeTotalsData instance(final Integer cashierTxnType, final BigDecimal cashTotal) {
        return new CashierTransactionTypeTotalsData().setCashierTxnType(cashierTxnType).setCashTotal(cashTotal);
    }

    @java.lang.SuppressWarnings("all")
        public Integer getCashierTxnType() {
        return this.cashierTxnType;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getCashTotal() {
        return this.cashTotal;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionTypeTotalsData setCashierTxnType(final Integer cashierTxnType) {
        this.cashierTxnType = cashierTxnType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionTypeTotalsData setCashTotal(final BigDecimal cashTotal) {
        this.cashTotal = cashTotal;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CashierTransactionTypeTotalsData)) return false;
        final CashierTransactionTypeTotalsData other = (CashierTransactionTypeTotalsData) o;
        final java.lang.Object this$cashierTxnType = this.getCashierTxnType();
        final java.lang.Object other$cashierTxnType = other.getCashierTxnType();
        if (this$cashierTxnType == null ? other$cashierTxnType != null : !this$cashierTxnType.equals(other$cashierTxnType)) return false;
        final java.lang.Object this$cashTotal = this.getCashTotal();
        final java.lang.Object other$cashTotal = other.getCashTotal();
        if (this$cashTotal == null ? other$cashTotal != null : !this$cashTotal.equals(other$cashTotal)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $cashierTxnType = this.getCashierTxnType();
        result = result * PRIME + ($cashierTxnType == null ? 43 : $cashierTxnType.hashCode());
        final java.lang.Object $cashTotal = this.getCashTotal();
        result = result * PRIME + ($cashTotal == null ? 43 : $cashTotal.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CashierTransactionTypeTotalsData(cashierTxnType=" + this.getCashierTxnType() + ", cashTotal=" + this.getCashTotal() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CashierTransactionTypeTotalsData() {
    }

    @java.lang.SuppressWarnings("all")
        public CashierTransactionTypeTotalsData(final Integer cashierTxnType, final BigDecimal cashTotal) {
        this.cashierTxnType = cashierTxnType;
        this.cashTotal = cashTotal;
    }
}
