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
import java.util.ArrayList;
import java.util.List;
import org.apache.fineract.portfolio.loanaccount.data.LoanChargeData;
import org.apache.fineract.portfolio.loanaccount.data.LoanTransactionEnumData;

public class LoanTransactionDTO {
    private final Long officeId;
    private final Long paymentTypeId;
    private final String transactionId;
    private final LocalDate transactionDate;
    private final LoanTransactionEnumData transactionType;
    private final BigDecimal amount;
    /**
     * Breakup of amounts in case of repayments *
     */
    private final BigDecimal principal;
    private final BigDecimal interest;
    private final BigDecimal fees;
    private final BigDecimal penalties;
    private final BigDecimal overPayment;
    /**
     * Boolean values determines if the transaction is reversed **
     */
    private final boolean reversed;
    /**
     * Breakdowns of fees and penalties this Transaction pays *
     */
    private final List<ChargePaymentDTO> penaltyPayments;
    private final List<ChargePaymentDTO> feePayments;
    private final boolean isAccountTransfer;
    private boolean isLoanToLoanTransfer;
    private final String chargeRefundChargeType;
    private final LoanChargeData loanChargeData;
    /**
     * In case chargeback and overpayment the below field contains the distribution payment *
     */
    private final BigDecimal principalPaid;
    private final BigDecimal feePaid;
    private final BigDecimal penaltyPaid;
    /**
     * Used by accounting processors to split the fee income credit into net income + tax liability entries
     */
    private List<ChargeTaxPaymentDTO> chargeTaxPayments = new ArrayList<>();

    /**
     * Creates a new {@code LoanTransactionDTO} instance.
     *
     * @param officeId
     * @param paymentTypeId
     * @param transactionId
     * @param transactionDate
     * @param transactionType
     * @param amount
     * @param principal Breakup of amounts in case of repayments *
     * @param interest
     * @param fees
     * @param penalties
     * @param overPayment
     * @param reversed Boolean values determines if the transaction is reversed **
     * @param penaltyPayments Breakdowns of fees and penalties this Transaction pays *
     * @param feePayments
     * @param isAccountTransfer
     * @param chargeRefundChargeType
     * @param loanChargeData
     * @param principalPaid In case chargeback and overpayment the below field contains the distribution payment *
     * @param feePaid
     * @param penaltyPaid
     */
    @java.lang.SuppressWarnings("all")
        public LoanTransactionDTO(final Long officeId, final Long paymentTypeId, final String transactionId, final LocalDate transactionDate, final LoanTransactionEnumData transactionType, final BigDecimal amount, final BigDecimal principal, final BigDecimal interest, final BigDecimal fees, final BigDecimal penalties, final BigDecimal overPayment, final boolean reversed, final List<ChargePaymentDTO> penaltyPayments, final List<ChargePaymentDTO> feePayments, final boolean isAccountTransfer, final String chargeRefundChargeType, final LoanChargeData loanChargeData, final BigDecimal principalPaid, final BigDecimal feePaid, final BigDecimal penaltyPaid) {
        this.officeId = officeId;
        this.paymentTypeId = paymentTypeId;
        this.transactionId = transactionId;
        this.transactionDate = transactionDate;
        this.transactionType = transactionType;
        this.amount = amount;
        this.principal = principal;
        this.interest = interest;
        this.fees = fees;
        this.penalties = penalties;
        this.overPayment = overPayment;
        this.reversed = reversed;
        this.penaltyPayments = penaltyPayments;
        this.feePayments = feePayments;
        this.isAccountTransfer = isAccountTransfer;
        this.chargeRefundChargeType = chargeRefundChargeType;
        this.loanChargeData = loanChargeData;
        this.principalPaid = principalPaid;
        this.feePaid = feePaid;
        this.penaltyPaid = penaltyPaid;
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
        public LoanTransactionEnumData getTransactionType() {
        return this.transactionType;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    /**
     * Breakup of amounts in case of repayments *
     */
    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipal() {
        return this.principal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterest() {
        return this.interest;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFees() {
        return this.fees;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenalties() {
        return this.penalties;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOverPayment() {
        return this.overPayment;
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
        public List<ChargePaymentDTO> getPenaltyPayments() {
        return this.penaltyPayments;
    }

    @java.lang.SuppressWarnings("all")
        public List<ChargePaymentDTO> getFeePayments() {
        return this.feePayments;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isAccountTransfer() {
        return this.isAccountTransfer;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isLoanToLoanTransfer() {
        return this.isLoanToLoanTransfer;
    }

    @java.lang.SuppressWarnings("all")
        public String getChargeRefundChargeType() {
        return this.chargeRefundChargeType;
    }

    @java.lang.SuppressWarnings("all")
        public LoanChargeData getLoanChargeData() {
        return this.loanChargeData;
    }

    /**
     * In case chargeback and overpayment the below field contains the distribution payment *
     */
    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalPaid() {
        return this.principalPaid;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeePaid() {
        return this.feePaid;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyPaid() {
        return this.penaltyPaid;
    }

    /**
     * Used by accounting processors to split the fee income credit into net income + tax liability entries
     */
    @java.lang.SuppressWarnings("all")
        public List<ChargeTaxPaymentDTO> getChargeTaxPayments() {
        return this.chargeTaxPayments;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanToLoanTransfer(final boolean isLoanToLoanTransfer) {
        this.isLoanToLoanTransfer = isLoanToLoanTransfer;
    }

    /**
     * Used by accounting processors to split the fee income credit into net income + tax liability entries
     */
    @java.lang.SuppressWarnings("all")
        public void setChargeTaxPayments(final List<ChargeTaxPaymentDTO> chargeTaxPayments) {
        this.chargeTaxPayments = chargeTaxPayments;
    }
}
