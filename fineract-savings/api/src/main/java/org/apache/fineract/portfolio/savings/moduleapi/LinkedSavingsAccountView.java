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
package org.apache.fineract.portfolio.savings.moduleapi;

import java.time.LocalDate;

/**
 * ID-only projection for loan-linked savings validation (ADR-021).
 */
public final class LinkedSavingsAccountView {

    private final Long id;
    private final Long clientId;
    private final boolean active;
    private final LocalDate activationDate;
    private final String accountNumber;
    private final String currencyCode;
    private final int digitsAfterDecimal;
    private final Integer inMultiplesOf;
    private final boolean withdrawalFeeApplicableForTransfer;
    private final LocalDate lastTransactionDate;

    public LinkedSavingsAccountView(final Long id, final Long clientId, final boolean active, final LocalDate activationDate) {
        this(id, clientId, active, activationDate, null, null, 0, null, false, null);
    }

    public LinkedSavingsAccountView(final Long id, final Long clientId, final boolean active, final LocalDate activationDate,
            final String accountNumber, final String currencyCode, final int digitsAfterDecimal, final Integer inMultiplesOf,
            final boolean withdrawalFeeApplicableForTransfer) {
        this(id, clientId, active, activationDate, accountNumber, currencyCode, digitsAfterDecimal, inMultiplesOf,
                withdrawalFeeApplicableForTransfer, null);
    }

    public LinkedSavingsAccountView(final Long id, final Long clientId, final boolean active, final LocalDate activationDate,
            final String accountNumber, final String currencyCode, final int digitsAfterDecimal, final Integer inMultiplesOf,
            final boolean withdrawalFeeApplicableForTransfer, final LocalDate lastTransactionDate) {
        this.id = id;
        this.clientId = clientId;
        this.active = active;
        this.activationDate = activationDate;
        this.accountNumber = accountNumber;
        this.currencyCode = currencyCode;
        this.digitsAfterDecimal = digitsAfterDecimal;
        this.inMultiplesOf = inMultiplesOf;
        this.withdrawalFeeApplicableForTransfer = withdrawalFeeApplicableForTransfer;
        this.lastTransactionDate = lastTransactionDate;
    }

    public Long getId() {
        return this.id;
    }

    public Long getClientId() {
        return this.clientId;
    }

    public boolean isActive() {
        return this.active;
    }

    public LocalDate getActivationDate() {
        return this.activationDate;
    }

    public String getAccountNumber() {
        return this.accountNumber;
    }

    public String getCurrencyCode() {
        return this.currencyCode;
    }

    public int getDigitsAfterDecimal() {
        return this.digitsAfterDecimal;
    }

    public Integer getInMultiplesOf() {
        return this.inMultiplesOf;
    }

    public boolean isWithdrawalFeeApplicableForTransfer() {
        return this.withdrawalFeeApplicableForTransfer;
    }

    public LocalDate getLastTransactionDate() {
        return this.lastTransactionDate;
    }
}
