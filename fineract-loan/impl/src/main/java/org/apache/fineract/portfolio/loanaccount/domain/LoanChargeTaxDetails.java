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
import java.math.BigDecimal;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;

@Entity
@Table(name = "m_loan_charge_tax_details")
public class LoanChargeTaxDetails extends AbstractPersistableCustom<Long> {

    @ManyToOne
    @JoinColumn(name = "loan_charge_id", nullable = false)
    private LoanCharge loanCharge;
    /** Catalog tax component id (column tax_component_id). */
    @Column(name = "tax_component_id", nullable = false)
    private Long taxComponentId;
    @Column(name = "amount", scale = 6, precision = 19, nullable = false)
    private BigDecimal amount;

    public LoanChargeTaxDetails() {}

    public LoanChargeTaxDetails(final LoanCharge loanCharge, final Long taxComponentId, final BigDecimal amount) {
        this.loanCharge = loanCharge;
        this.taxComponentId = taxComponentId;
        this.amount = amount;
    }

    public void setLoanCharge(final LoanCharge loanCharge) {
        this.loanCharge = loanCharge;
    }

    public void setTaxComponentId(final Long taxComponentId) {
        this.taxComponentId = taxComponentId;
    }

    public void setAmount(final BigDecimal amount) {
        this.amount = amount;
    }

    public LoanCharge getLoanCharge() {
        return this.loanCharge;
    }

    public Long getTaxComponentId() {
        return this.taxComponentId;
    }

    public BigDecimal getAmount() {
        return this.amount;
    }
}
