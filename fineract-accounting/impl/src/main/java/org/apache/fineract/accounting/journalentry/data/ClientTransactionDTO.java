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
import org.apache.fineract.infrastructure.core.data.EnumOptionData;

public class ClientTransactionDTO {

    /** Published {@code ClientTransactionType.PAY_CHARGE} value (kernel leftover enum). */
    private static final int PAY_CHARGE = 1;
    private final Long clientId;
    private final Long officeId;
    private final Long paymentTypeId;
    private final Long transactionId;
    private final LocalDate transactionDate;
    private final EnumOptionData transactionType;
    private final String currencyCode;
    private final BigDecimal amount;
    /**
     * Boolean values determines if the transaction is reversed **
     */
    private final boolean reversed;
    private final boolean accountingEnabled;
    /**
     * Breakdowns of fees this Transaction pays *
     */
    private final List<ClientChargePaymentDTO> chargePayments;

    public boolean isChargePayment() {
        return this.transactionType.getId().intValue() == PAY_CHARGE;
    }

    /**
     * Creates a new {@code ClientTransactionDTO} instance.
     *
     * @param clientId
     * @param officeId
     * @param paymentTypeId
     * @param transactionId
     * @param transactionDate
     * @param transactionType
     * @param currencyCode
     * @param amount
     * @param reversed Boolean values determines if the transaction is reversed **
     * @param accountingEnabled
     * @param chargePayments Breakdowns of fees this Transaction pays *
     */
    @java.lang.SuppressWarnings("all")
        public ClientTransactionDTO(final Long clientId, final Long officeId, final Long paymentTypeId, final Long transactionId, final LocalDate transactionDate, final EnumOptionData transactionType, final String currencyCode, final BigDecimal amount, final boolean reversed, final boolean accountingEnabled, final List<ClientChargePaymentDTO> chargePayments) {
        this.clientId = clientId;
        this.officeId = officeId;
        this.paymentTypeId = paymentTypeId;
        this.transactionId = transactionId;
        this.transactionDate = transactionDate;
        this.transactionType = transactionType;
        this.currencyCode = currencyCode;
        this.amount = amount;
        this.reversed = reversed;
        this.accountingEnabled = accountingEnabled;
        this.chargePayments = chargePayments;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
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
        public Long getTransactionId() {
        return this.transactionId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getTransactionDate() {
        return this.transactionDate;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getTransactionType() {
        return this.transactionType;
    }

    @java.lang.SuppressWarnings("all")
        public String getCurrencyCode() {
        return this.currencyCode;
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

    @java.lang.SuppressWarnings("all")
        public boolean isAccountingEnabled() {
        return this.accountingEnabled;
    }

    /**
     * Breakdowns of fees this Transaction pays *
     */
    @java.lang.SuppressWarnings("all")
        public List<ClientChargePaymentDTO> getChargePayments() {
        return this.chargePayments;
    }
}
