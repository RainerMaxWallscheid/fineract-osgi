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
import jakarta.persistence.Version;
import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;

@Entity
@Table(name = "m_wc_loan_delinquency_range_schedule", uniqueConstraints = {@UniqueConstraint(columnNames = {"wc_loan_id", "period_number"}, name = "uc_wc_delinquency_range_schedule_loan_period")})
public class WorkingCapitalLoanDelinquencyRangeSchedule extends AbstractAuditableWithUTCDateTimeCustom<Long> {
    @Version
    @Column(name = "version")
    private Integer version;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "wc_loan_id", nullable = false)
    private WorkingCapitalLoan loan;
    @Column(name = "period_number", nullable = false)
    private Integer periodNumber;
    @Column(name = "from_date", nullable = false)
    private LocalDate fromDate;
    @Column(name = "to_date", nullable = false)
    private LocalDate toDate;
    @Column(name = "expected_amount", scale = 6, precision = 19)
    private BigDecimal expectedAmount;
    @Column(name = "base_expected_amount", scale = 6, precision = 19)
    private BigDecimal baseExpectedAmount;
    @Column(name = "paid_amount", scale = 6, precision = 19)
    private BigDecimal paidAmount;
    @Column(name = "outstanding_amount", scale = 6, precision = 19)
    private BigDecimal outstandingAmount;
    @Column(name = "min_payment_criteria_met")
    private Boolean minPaymentCriteriaMet;
    @Column(name = "delinquent_days")
    private Long delinquentDays;
    @Column(name = "delinquent_amount", scale = 6, precision = 19)
    private BigDecimal delinquentAmount;

    @java.lang.SuppressWarnings("all")
        public Integer getVersion() {
        return this.version;
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
        public BigDecimal getExpectedAmount() {
        return this.expectedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getBaseExpectedAmount() {
        return this.baseExpectedAmount;
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
        public Boolean getMinPaymentCriteriaMet() {
        return this.minPaymentCriteriaMet;
    }

    @java.lang.SuppressWarnings("all")
        public Long getDelinquentDays() {
        return this.delinquentDays;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDelinquentAmount() {
        return this.delinquentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setVersion(final Integer version) {
        this.version = version;
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
        public void setExpectedAmount(final BigDecimal expectedAmount) {
        this.expectedAmount = expectedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setBaseExpectedAmount(final BigDecimal baseExpectedAmount) {
        this.baseExpectedAmount = baseExpectedAmount;
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
        public void setMinPaymentCriteriaMet(final Boolean minPaymentCriteriaMet) {
        this.minPaymentCriteriaMet = minPaymentCriteriaMet;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentDays(final Long delinquentDays) {
        this.delinquentDays = delinquentDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentAmount(final BigDecimal delinquentAmount) {
        this.delinquentAmount = delinquentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanDelinquencyRangeSchedule() {
    }
}
