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

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * Single savings transaction view for interop. Composes a resource id instead of extending
 * {@code CommandProcessingResult}. Entity mapping lives in interoperation-impl.
 * <p>
 * Leftover {@code SavingsAccountTransactionType} is Object-typed — unpublished in savings-api-exported packages
 * (ADR-021).
 */
public final class InteropTransactionData {

    private final Long resourceId;
    private final String accountId;
    private final String savingTransactionId;
    private final Object transactionType;
    private final BigDecimal amount;
    private final BigDecimal chargeAmount;
    private final String currency;
    private final BigDecimal accountBalance;
    private final LocalDate bookingDateTime;
    private final LocalDate valueDateTime;
    private String note;

    public InteropTransactionData(Long resourceId, String accountId, String transactionId, Object transactionType, BigDecimal amount,
            BigDecimal chargeAmount, String currency, BigDecimal accountBalance, LocalDate bookingDateTime, LocalDate valueDateTime,
            String note) {
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

    public Object getTransactionType() {
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
