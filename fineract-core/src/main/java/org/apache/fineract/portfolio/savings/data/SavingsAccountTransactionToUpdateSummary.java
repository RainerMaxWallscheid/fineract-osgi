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
package org.apache.fineract.portfolio.savings.data;

import java.math.BigDecimal;

public class SavingsAccountTransactionToUpdateSummary {
    private final BigDecimal amount;
    private final int typeOf;
    private final boolean isReversalTransaction;
    private final boolean isDepositAndNotReversed;
    private final boolean isDividendPayoutAndNotReversed;
    private final boolean isWithdrawal;
    private final boolean isNotReversed;
    private final boolean isWithdrawalFeeAndNotReversed;
    private final boolean isAnnualFeeAndNotReversed;
    private final boolean isWaiveFeeChargeAndNotReversed;
    private final boolean isWaivePenaltyChargeAndNotReversed;
    private final boolean isFeeChargeAndNotReversed;
    private final boolean isPenaltyChargeAndNotReversed;
    private final boolean isOverdraftInterestAndNotReversed;
    private final boolean isWithHoldTaxAndNotReversed;

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public int getTypeOf() {
        return this.typeOf;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isReversalTransaction() {
        return this.isReversalTransaction;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isDepositAndNotReversed() {
        return this.isDepositAndNotReversed;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isDividendPayoutAndNotReversed() {
        return this.isDividendPayoutAndNotReversed;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isWithdrawal() {
        return this.isWithdrawal;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isNotReversed() {
        return this.isNotReversed;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isWithdrawalFeeAndNotReversed() {
        return this.isWithdrawalFeeAndNotReversed;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isAnnualFeeAndNotReversed() {
        return this.isAnnualFeeAndNotReversed;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isWaiveFeeChargeAndNotReversed() {
        return this.isWaiveFeeChargeAndNotReversed;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isWaivePenaltyChargeAndNotReversed() {
        return this.isWaivePenaltyChargeAndNotReversed;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isFeeChargeAndNotReversed() {
        return this.isFeeChargeAndNotReversed;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isPenaltyChargeAndNotReversed() {
        return this.isPenaltyChargeAndNotReversed;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isOverdraftInterestAndNotReversed() {
        return this.isOverdraftInterestAndNotReversed;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isWithHoldTaxAndNotReversed() {
        return this.isWithHoldTaxAndNotReversed;
    }

    @java.lang.SuppressWarnings("all")
        public SavingsAccountTransactionToUpdateSummary(final BigDecimal amount, final int typeOf, final boolean isReversalTransaction, final boolean isDepositAndNotReversed, final boolean isDividendPayoutAndNotReversed, final boolean isWithdrawal, final boolean isNotReversed, final boolean isWithdrawalFeeAndNotReversed, final boolean isAnnualFeeAndNotReversed, final boolean isWaiveFeeChargeAndNotReversed, final boolean isWaivePenaltyChargeAndNotReversed, final boolean isFeeChargeAndNotReversed, final boolean isPenaltyChargeAndNotReversed, final boolean isOverdraftInterestAndNotReversed, final boolean isWithHoldTaxAndNotReversed) {
        this.amount = amount;
        this.typeOf = typeOf;
        this.isReversalTransaction = isReversalTransaction;
        this.isDepositAndNotReversed = isDepositAndNotReversed;
        this.isDividendPayoutAndNotReversed = isDividendPayoutAndNotReversed;
        this.isWithdrawal = isWithdrawal;
        this.isNotReversed = isNotReversed;
        this.isWithdrawalFeeAndNotReversed = isWithdrawalFeeAndNotReversed;
        this.isAnnualFeeAndNotReversed = isAnnualFeeAndNotReversed;
        this.isWaiveFeeChargeAndNotReversed = isWaiveFeeChargeAndNotReversed;
        this.isWaivePenaltyChargeAndNotReversed = isWaivePenaltyChargeAndNotReversed;
        this.isFeeChargeAndNotReversed = isFeeChargeAndNotReversed;
        this.isPenaltyChargeAndNotReversed = isPenaltyChargeAndNotReversed;
        this.isOverdraftInterestAndNotReversed = isOverdraftInterestAndNotReversed;
        this.isWithHoldTaxAndNotReversed = isWithHoldTaxAndNotReversed;
    }
}
