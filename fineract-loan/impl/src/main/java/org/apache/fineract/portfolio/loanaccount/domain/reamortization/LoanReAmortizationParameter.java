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
package org.apache.fineract.portfolio.loanaccount.domain.reamortization;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import org.apache.fineract.infrastructure.codes.moduleapi.CodeValueAssociation;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransaction;

@Entity
@Table(name = "m_loan_reamortization_parameter")
public class LoanReAmortizationParameter extends AbstractAuditableWithUTCDateTimeCustom<Long> {

    @OneToOne
    @JoinColumn(name = "loan_transaction_id", nullable = false)
    private LoanTransaction loanTransaction;
    @Enumerated(EnumType.STRING)
    @Column(name = "interest_handling_type")
    private LoanReAmortizationInterestHandlingType interestHandlingType;
    /**
     * Code-value id (no JPA association to leftover CodeValue — ADR-021).
     */
    @Column(name = "reamortization_reason_code_value_id")
    private Long reamortizationReasonId;

    // for JPA, don't use
    protected LoanReAmortizationParameter() {}

    public LoanReAmortizationParameter getCopy(LoanTransaction loanTransaction) {
        return new LoanReAmortizationParameter(loanTransaction, interestHandlingType, reamortizationReasonId);
    }

    @java.lang.SuppressWarnings("all")
    public LoanReAmortizationParameter(final LoanTransaction loanTransaction,
            final LoanReAmortizationInterestHandlingType interestHandlingType, final Object reamortizationReason) {
        this.loanTransaction = loanTransaction;
        this.interestHandlingType = interestHandlingType;
        this.reamortizationReasonId = CodeValueAssociation.id(reamortizationReason);
    }

    @java.lang.SuppressWarnings("all")
    public LoanTransaction getLoanTransaction() {
        return this.loanTransaction;
    }

    @java.lang.SuppressWarnings("all")
    public LoanReAmortizationInterestHandlingType getInterestHandlingType() {
        return this.interestHandlingType;
    }

    @java.lang.SuppressWarnings("all")
    public Long getReamortizationReasonId() {
        return this.reamortizationReasonId;
    }
}
