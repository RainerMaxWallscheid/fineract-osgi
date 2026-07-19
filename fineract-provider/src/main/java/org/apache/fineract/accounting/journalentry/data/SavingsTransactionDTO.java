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
package org.apache.fineract.accounting.journalentry.data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import org.apache.fineract.portfolio.savings.data.SavingsAccountTransactionEnumData;

public class SavingsTransactionDTO {
    private final Long officeId;
    private final Long paymentTypeId;
    private final String transactionId;
    private final LocalDate transactionDate;
    private final SavingsAccountTransactionEnumData transactionType;
    private final BigDecimal amount;
    /**
     * Boolean values determines if the transaction is reversed **
     */
    private final boolean reversed;
    /**
     * Breakdowns of fees and penalties this Transaction pays *
     */
    private final List<ChargePaymentDTO> feePayments;
    private final List<ChargePaymentDTO> penaltyPayments;
    private final BigDecimal overdraftAmount;
    private final boolean isAccountTransfer;
    private final List<TaxPaymentDTO> taxPayments;

    public boolean isOverdraftTransaction() {
        return this.overdraftAmount != null && this.overdraftAmount.doubleValue() > 0;
    }

    /**
     * Creates a new {@code SavingsTransactionDTO} instance.
     *
     * @param officeId
     * @param paymentTypeId
     * @param transactionId
     * @param transactionDate
     * @param transactionType
     * @param amount
     * @param reversed Boolean values determines if the transaction is reversed **
     * @param feePayments Breakdowns of fees and penalties this Transaction pays *
     * @param penaltyPayments
     * @param overdraftAmount
     * @param isAccountTransfer
     * @param taxPayments
     */
    @java.lang.SuppressWarnings("all")
        public SavingsTransactionDTO(final Long officeId, final Long paymentTypeId, final String transactionId, final LocalDate transactionDate, final SavingsAccountTransactionEnumData transactionType, final BigDecimal amount, final boolean reversed, final List<ChargePaymentDTO> feePayments, final List<ChargePaymentDTO> penaltyPayments, final BigDecimal overdraftAmount, final boolean isAccountTransfer, final List<TaxPaymentDTO> taxPayments) {
        this.officeId = officeId;
        this.paymentTypeId = paymentTypeId;
        this.transactionId = transactionId;
        this.transactionDate = transactionDate;
        this.transactionType = transactionType;
        this.amount = amount;
        this.reversed = reversed;
        this.feePayments = feePayments;
        this.penaltyPayments = penaltyPayments;
        this.overdraftAmount = overdraftAmount;
        this.isAccountTransfer = isAccountTransfer;
        this.taxPayments = taxPayments;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getPaymentTypeId() {
        return this.paymentTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransactionId() {
        return this.transactionId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getTransactionDate() {
        return this.transactionDate;
    }

    @java.lang.SuppressWarnings("all")
        public SavingsAccountTransactionEnumData getTransactionType() {
        return this.transactionType;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    /**
     * Boolean values determines if the transaction is reversed **
     */
    @java.lang.SuppressWarnings("all")
        public boolean isReversed() {
        return this.reversed;
    }

    /**
     * Breakdowns of fees and penalties this Transaction pays *
     */
    @java.lang.SuppressWarnings("all")
        public List<ChargePaymentDTO> getFeePayments() {
        return this.feePayments;
    }

    @java.lang.SuppressWarnings("all")
        public List<ChargePaymentDTO> getPenaltyPayments() {
        return this.penaltyPayments;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOverdraftAmount() {
        return this.overdraftAmount;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isAccountTransfer() {
        return this.isAccountTransfer;
    }

    @java.lang.SuppressWarnings("all")
        public List<TaxPaymentDTO> getTaxPayments() {
        return this.taxPayments;
    }
}
