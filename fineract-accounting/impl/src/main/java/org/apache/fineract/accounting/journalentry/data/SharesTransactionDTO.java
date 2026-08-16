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
import org.apache.fineract.shares.shareaccounts.data.ShareAccountTransactionEnumData;

public class SharesTransactionDTO {
    private final Long officeId;
    private final Long paymentTypeId;
    private final String transactionId;
    private final LocalDate transactionDate;
    private final ShareAccountTransactionEnumData transactionType;
    private final ShareAccountTransactionEnumData transactionStatus;
    private final BigDecimal amount;
    /**
     * Breakup of amounts *
     */
    private final BigDecimal chargeAmount;
    /**
     * Breakdowns of fees and penalties this Transaction pays *
     */
    private final List<ChargePaymentDTO> feePayments;

    /**
     * Creates a new {@code SharesTransactionDTO} instance.
     *
     * @param officeId
     * @param paymentTypeId
     * @param transactionId
     * @param transactionDate
     * @param transactionType
     * @param transactionStatus
     * @param amount
     * @param chargeAmount Breakup of amounts *
     * @param feePayments Breakdowns of fees and penalties this Transaction pays *
     */
    @java.lang.SuppressWarnings("all")
        public SharesTransactionDTO(final Long officeId, final Long paymentTypeId, final String transactionId, final LocalDate transactionDate, final ShareAccountTransactionEnumData transactionType, final ShareAccountTransactionEnumData transactionStatus, final BigDecimal amount, final BigDecimal chargeAmount, final List<ChargePaymentDTO> feePayments) {
        this.officeId = officeId;
        this.paymentTypeId = paymentTypeId;
        this.transactionId = transactionId;
        this.transactionDate = transactionDate;
        this.transactionType = transactionType;
        this.transactionStatus = transactionStatus;
        this.amount = amount;
        this.chargeAmount = chargeAmount;
        this.feePayments = feePayments;
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
        public ShareAccountTransactionEnumData getTransactionType() {
        return this.transactionType;
    }

    @java.lang.SuppressWarnings("all")
        public ShareAccountTransactionEnumData getTransactionStatus() {
        return this.transactionStatus;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    /**
     * Breakup of amounts *
     */
    @java.lang.SuppressWarnings("all")
        public BigDecimal getChargeAmount() {
        return this.chargeAmount;
    }

    /**
     * Breakdowns of fees and penalties this Transaction pays *
     */
    @java.lang.SuppressWarnings("all")
        public List<ChargePaymentDTO> getFeePayments() {
        return this.feePayments;
    }
}
