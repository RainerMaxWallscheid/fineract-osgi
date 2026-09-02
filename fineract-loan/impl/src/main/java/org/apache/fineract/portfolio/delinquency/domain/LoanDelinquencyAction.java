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
package org.apache.fineract.portfolio.delinquency.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;

@Entity
@Table(name = "m_loan_delinquency_action")
public class LoanDelinquencyAction extends AbstractAuditableWithUTCDateTimeCustom<Long> {

    @ManyToOne
    @JoinColumn(name = "loan_id", nullable = false)
    private Loan loan;
    @Enumerated(EnumType.STRING)
    @Column(name = "action", nullable = false)
    private DelinquencyAction action;
    @Column(name = "start_date", nullable = false)
    private LocalDate startDate;
    @Column(name = "end_date", nullable = true)
    private LocalDate endDate;

    public LoanDelinquencyAction(Loan loan, DelinquencyAction action, LocalDate startDate, LocalDate endDate) {
        this.loan = loan;
        this.action = action;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    @java.lang.SuppressWarnings("all")
    public Loan getLoan() {
        return this.loan;
    }

    @java.lang.SuppressWarnings("all")
    public DelinquencyAction getAction() {
        return this.action;
    }

    @java.lang.SuppressWarnings("all")
    public LocalDate getStartDate() {
        return this.startDate;
    }

    @java.lang.SuppressWarnings("all")
    public LocalDate getEndDate() {
        return this.endDate;
    }

    @java.lang.SuppressWarnings("all")
    public void setLoan(final Loan loan) {
        this.loan = loan;
    }

    @java.lang.SuppressWarnings("all")
    public void setAction(final DelinquencyAction action) {
        this.action = action;
    }

    @java.lang.SuppressWarnings("all")
    public void setStartDate(final LocalDate startDate) {
        this.startDate = startDate;
    }

    @java.lang.SuppressWarnings("all")
    public void setEndDate(final LocalDate endDate) {
        this.endDate = endDate;
    }

    @java.lang.SuppressWarnings("all")
    public LoanDelinquencyAction() {}
}
