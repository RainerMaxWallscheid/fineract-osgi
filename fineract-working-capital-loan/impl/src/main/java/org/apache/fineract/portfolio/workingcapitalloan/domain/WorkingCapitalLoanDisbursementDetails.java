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
import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.useradministration.domain.AppUser;

/**
 * Stores expected and actual disbursement details per disbursement. One loan can have multiple disbursement details
 * (e.g. multiple tranches). Expected: date, amount, maturityDate. Actual: date, amount, disbursed by.
 */
@Entity
@Table(name = "m_wc_loan_disbursement_detail")
public class WorkingCapitalLoanDisbursementDetails extends AbstractPersistableCustom<Long> {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "wc_loan_id", nullable = false)
    private WorkingCapitalLoan wcLoan;
    @Column(name = "expected_disburse_date")
    private LocalDate expectedDisbursementDate;
    @Column(name = "expected_amount", scale = 6, precision = 19)
    private BigDecimal expectedAmount;
    @Column(name = "expected_maturity_date")
    private LocalDate expectedMaturityDate;
    @Column(name = "actual_disburse_date")
    private LocalDate actualDisbursementDate;
    @Column(name = "actual_amount", scale = 6, precision = 19)
    private BigDecimal actualAmount;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "disbursedon_userid")
    private AppUser disbursedBy;

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoan getWcLoan() {
        return this.wcLoan;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getExpectedDisbursementDate() {
        return this.expectedDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getExpectedAmount() {
        return this.expectedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getExpectedMaturityDate() {
        return this.expectedMaturityDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getActualDisbursementDate() {
        return this.actualDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getActualAmount() {
        return this.actualAmount;
    }

    @java.lang.SuppressWarnings("all")
        public AppUser getDisbursedBy() {
        return this.disbursedBy;
    }

    @java.lang.SuppressWarnings("all")
        public void setWcLoan(final WorkingCapitalLoan wcLoan) {
        this.wcLoan = wcLoan;
    }

    @java.lang.SuppressWarnings("all")
        public void setExpectedDisbursementDate(final LocalDate expectedDisbursementDate) {
        this.expectedDisbursementDate = expectedDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setExpectedAmount(final BigDecimal expectedAmount) {
        this.expectedAmount = expectedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setExpectedMaturityDate(final LocalDate expectedMaturityDate) {
        this.expectedMaturityDate = expectedMaturityDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setActualDisbursementDate(final LocalDate actualDisbursementDate) {
        this.actualDisbursementDate = actualDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setActualAmount(final BigDecimal actualAmount) {
        this.actualAmount = actualAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setDisbursedBy(final AppUser disbursedBy) {
        this.disbursedBy = disbursedBy;
    }
}
