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
package org.apache.fineract.portfolio.loanproduct.domain;

// TODO FINERACT-1932-Fineract modularization: Move to fineract-progressive-loan module after refactor of Loan and LoanProduct classes
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

@Entity
@Table(name = "m_loan_product_credit_allocation_rule", uniqueConstraints = {
        @UniqueConstraint(columnNames = { "loan_product_id", "transaction_type" }, name = "uq_m_loan_product_credit_allocation_rule") })
public class LoanProductCreditAllocationRule extends AbstractAuditableWithUTCDateTimeCustom<Long> {

    @ManyToOne
    @JoinColumn(name = "loan_product_id", nullable = false)
    private LoanProduct loanProduct;
    @Column(name = "transaction_type", nullable = false)
    @Enumerated(EnumType.STRING)
    private CreditAllocationTransactionType transactionType;
    @Convert(converter = AllocationTypeListConverter.class)
    @Column(name = "allocation_types", nullable = false)
    private List<AllocationType> allocationTypes;

    @java.lang.SuppressWarnings("all")
    public LoanProduct getLoanProduct() {
        return this.loanProduct;
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
    public void setLoanProduct(final LoanProduct loanProduct) {
        this.loanProduct = loanProduct;
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
    public LoanProductCreditAllocationRule(final LoanProduct loanProduct, final CreditAllocationTransactionType transactionType,
            final List<AllocationType> allocationTypes) {
        this.loanProduct = loanProduct;
        this.transactionType = transactionType;
        this.allocationTypes = allocationTypes;
    }

    @java.lang.SuppressWarnings("all")
    protected LoanProductCreditAllocationRule() {}
}
