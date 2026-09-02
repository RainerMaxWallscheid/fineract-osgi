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
package org.apache.fineract.portfolio.loanaccount.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Version;
import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;

@Entity
@Table(name = "m_loan_buy_down_fee_balance")
public class LoanBuyDownFeeBalance extends AbstractAuditableWithUTCDateTimeCustom<Long> {

    @Version
    private Long version;
    @ManyToOne
    @JoinColumn(name = "loan_id", nullable = false)
    private Loan loan;
    @ManyToOne
    @JoinColumn(name = "loan_transaction_id", nullable = false)
    private LoanTransaction loanTransaction;
    @Column(name = "amount", scale = 6, precision = 19, nullable = false)
    private BigDecimal amount;
    @Column(name = "date", nullable = false)
    private LocalDate date;
    @Column(name = "unrecognized_amount", scale = 6, precision = 19, nullable = false)
    private BigDecimal unrecognizedAmount;
    @Column(name = "charged_off_amount", scale = 6, precision = 19)
    private BigDecimal chargedOffAmount;
    @Column(name = "amount_adjustment", scale = 6, precision = 19)
    private BigDecimal amountAdjustment;
    @Column(name = "is_deleted", nullable = false)
    private boolean deleted = false;
    @Column(name = "is_closed", nullable = false)
    private boolean closed = false;

    @java.lang.SuppressWarnings("all")
    public Long getVersion() {
        return this.version;
    }

    @java.lang.SuppressWarnings("all")
    public Loan getLoan() {
        return this.loan;
    }

    @java.lang.SuppressWarnings("all")
    public LoanTransaction getLoanTransaction() {
        return this.loanTransaction;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
    public LocalDate getDate() {
        return this.date;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getUnrecognizedAmount() {
        return this.unrecognizedAmount;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getChargedOffAmount() {
        return this.chargedOffAmount;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getAmountAdjustment() {
        return this.amountAdjustment;
    }

    @java.lang.SuppressWarnings("all")
    public boolean isDeleted() {
        return this.deleted;
    }

    @java.lang.SuppressWarnings("all")
    public boolean isClosed() {
        return this.closed;
    }

    @java.lang.SuppressWarnings("all")
    public void setVersion(final Long version) {
        this.version = version;
    }

    @java.lang.SuppressWarnings("all")
    public void setLoan(final Loan loan) {
        this.loan = loan;
    }

    @java.lang.SuppressWarnings("all")
    public void setLoanTransaction(final LoanTransaction loanTransaction) {
        this.loanTransaction = loanTransaction;
    }

    @java.lang.SuppressWarnings("all")
    public void setAmount(final BigDecimal amount) {
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
    public void setDate(final LocalDate date) {
        this.date = date;
    }

    @java.lang.SuppressWarnings("all")
    public void setUnrecognizedAmount(final BigDecimal unrecognizedAmount) {
        this.unrecognizedAmount = unrecognizedAmount;
    }

    @java.lang.SuppressWarnings("all")
    public void setChargedOffAmount(final BigDecimal chargedOffAmount) {
        this.chargedOffAmount = chargedOffAmount;
    }

    @java.lang.SuppressWarnings("all")
    public void setAmountAdjustment(final BigDecimal amountAdjustment) {
        this.amountAdjustment = amountAdjustment;
    }

    @java.lang.SuppressWarnings("all")
    public void setDeleted(final boolean deleted) {
        this.deleted = deleted;
    }

    @java.lang.SuppressWarnings("all")
    public void setClosed(final boolean closed) {
        this.closed = closed;
    }
}
