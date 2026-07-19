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
package org.apache.fineract.portfolio.workingcapitalloan.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;

@Entity
@Table(name = "m_wc_loan_breach_schedule", uniqueConstraints = {@UniqueConstraint(columnNames = {"wc_loan_id", "period_number"}, name = "uc_wc_breach_schedule_loan_period")})
public class WorkingCapitalLoanBreachSchedule extends AbstractAuditableWithUTCDateTimeCustom<Long> {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "wc_loan_id", nullable = false)
    private WorkingCapitalLoan loan;
    @Column(name = "period_number", nullable = false)
    private Integer periodNumber;
    @Column(name = "from_date", nullable = false)
    private LocalDate fromDate;
    @Column(name = "to_date", nullable = false)
    private LocalDate toDate;
    @Column(name = "number_of_days")
    private Integer numberOfDays;
    @Column(name = "min_payment_amount", scale = 6, precision = 19)
    private BigDecimal minPaymentAmount;
    @Column(name = "paid_amount", scale = 6, precision = 19)
    private BigDecimal paidAmount;
    @Column(name = "outstanding_amount", scale = 6, precision = 19)
    private BigDecimal outstandingAmount;
    @Column(name = "near_breach")
    private Boolean nearBreach;
    @Column(name = "breach")
    private Boolean breach;
    @Column(name = "reset", nullable = false)
    private boolean reset;

    public void reset() {
        this.reset = true;
        this.breach = null;
        this.nearBreach = null;
        this.outstandingAmount = null;
        this.paidAmount = null;
    }

    public BigDecimal getMinPaymentAmount() {
        return reset ? null : this.minPaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoan getLoan() {
        return this.loan;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getPeriodNumber() {
        return this.periodNumber;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getFromDate() {
        return this.fromDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getToDate() {
        return this.toDate;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getNumberOfDays() {
        return this.numberOfDays;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPaidAmount() {
        return this.paidAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOutstandingAmount() {
        return this.outstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getNearBreach() {
        return this.nearBreach;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getBreach() {
        return this.breach;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isReset() {
        return this.reset;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoan(final WorkingCapitalLoan loan) {
        this.loan = loan;
    }

    @java.lang.SuppressWarnings("all")
        public void setPeriodNumber(final Integer periodNumber) {
        this.periodNumber = periodNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromDate(final LocalDate fromDate) {
        this.fromDate = fromDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setToDate(final LocalDate toDate) {
        this.toDate = toDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setNumberOfDays(final Integer numberOfDays) {
        this.numberOfDays = numberOfDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinPaymentAmount(final BigDecimal minPaymentAmount) {
        this.minPaymentAmount = minPaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setPaidAmount(final BigDecimal paidAmount) {
        this.paidAmount = paidAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setOutstandingAmount(final BigDecimal outstandingAmount) {
        this.outstandingAmount = outstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setNearBreach(final Boolean nearBreach) {
        this.nearBreach = nearBreach;
    }

    @java.lang.SuppressWarnings("all")
        public void setBreach(final Boolean breach) {
        this.breach = breach;
    }

    @java.lang.SuppressWarnings("all")
        public void setReset(final boolean reset) {
        this.reset = reset;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanBreachSchedule() {
    }
}
