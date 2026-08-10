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
package org.apache.fineract.interoperation.data;

import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.portfolio.savings.SavingsAccountTransactionType;

/**
 * Single savings transaction view for interop. Composes a resource id instead of
 * extending {@code CommandProcessingResult}. Entity mapping lives in interoperation-impl.
 */
public final class InteropTransactionData {

    private final Long resourceId;
    @NotNull
    private final String accountId;
    @NotNull
    private final String savingTransactionId;
    @NotNull
    private final SavingsAccountTransactionType transactionType;
    @NotNull
    private final BigDecimal amount;
    private final BigDecimal chargeAmount;
    @NotNull
    private final String currency;
    @NotNull
    private final BigDecimal accountBalance;
    @NotNull
    private final LocalDate bookingDateTime;
    @NotNull
    private final LocalDate valueDateTime;
    private String note;

    public InteropTransactionData(Long resourceId, String accountId, String transactionId, SavingsAccountTransactionType transactionType,
            BigDecimal amount, BigDecimal chargeAmount, String currency, BigDecimal accountBalance, LocalDate bookingDateTime,
            LocalDate valueDateTime, String note) {
        this.resourceId = resourceId;
        this.accountId = accountId;
        this.savingTransactionId = transactionId;
        this.transactionType = transactionType;
        this.amount = amount;
        this.chargeAmount = chargeAmount;
        this.currency = currency;
        this.accountBalance = accountBalance;
        this.bookingDateTime = bookingDateTime;
        this.valueDateTime = valueDateTime;
        this.note = note;
    }

    public void updateNote(String note) {
        this.note = note;
    }

    public Long getResourceId() {
        return resourceId;
    }

    public String getAccountId() {
        return accountId;
    }

    public String getSavingTransactionId() {
        return savingTransactionId;
    }

    public SavingsAccountTransactionType getTransactionType() {
        return transactionType;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public BigDecimal getChargeAmount() {
        return chargeAmount;
    }

    public String getCurrency() {
        return currency;
    }

    public BigDecimal getAccountBalance() {
        return accountBalance;
    }

    public LocalDate getBookingDateTime() {
        return bookingDateTime;
    }

    public LocalDate getValueDateTime() {
        return valueDateTime;
    }

    public String getNote() {
        return note;
    }
}
