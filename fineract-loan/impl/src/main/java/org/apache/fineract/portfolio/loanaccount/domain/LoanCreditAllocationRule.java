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

// TODO FINERACT-1932-Fineract modularization: Move to fineract-progressive-loan module after refactor of Loan and LoanTransaction classes
import jakarta.persistence.Column;
import jakarta.persistence.Convert;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.util.List;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;
import org.apache.fineract.portfolio.loanproduct.domain.AllocationType;
import org.apache.fineract.portfolio.loanproduct.domain.AllocationTypeListConverter;
import org.apache.fineract.portfolio.loanproduct.domain.CreditAllocationTransactionType;

@Entity
@Table(name = "m_loan_credit_allocation_rule", uniqueConstraints = {
        @UniqueConstraint(columnNames = { "loan_id", "transaction_type" }, name = "uq_m_loan_credit_allocation_rule") })
public class LoanCreditAllocationRule extends AbstractAuditableWithUTCDateTimeCustom<Long> {

    @ManyToOne
    @JoinColumn(name = "loan_id", nullable = false)
    private Loan loan;
    @Column(name = "transaction_type", nullable = false)
    @Enumerated(EnumType.STRING)
    private CreditAllocationTransactionType transactionType;
    @Convert(converter = AllocationTypeListConverter.class)
    @Column(name = "allocation_types", nullable = false)
    private List<AllocationType> allocationTypes;

    @java.lang.SuppressWarnings("all")
    public Loan getLoan() {
        return this.loan;
    }

    @java.lang.SuppressWarnings("all")
    public CreditAllocationTransactionType getTransactionType() {
        return this.transactionType;
    }

    @java.lang.SuppressWarnings("all")
    public List<AllocationType> getAllocationTypes() {
        return this.allocationTypes;
    }

    @java.lang.SuppressWarnings("all")
    public void setLoan(final Loan loan) {
        this.loan = loan;
    }

    @java.lang.SuppressWarnings("all")
    public void setTransactionType(final CreditAllocationTransactionType transactionType) {
        this.transactionType = transactionType;
    }

    @java.lang.SuppressWarnings("all")
    public void setAllocationTypes(final List<AllocationType> allocationTypes) {
        this.allocationTypes = allocationTypes;
    }

    @java.lang.SuppressWarnings("all")
    public LoanCreditAllocationRule(final Loan loan, final CreditAllocationTransactionType transactionType,
            final List<AllocationType> allocationTypes) {
        this.loan = loan;
        this.transactionType = transactionType;
        this.allocationTypes = allocationTypes;
    }

    @java.lang.SuppressWarnings("all")
    protected LoanCreditAllocationRule() {}
}
