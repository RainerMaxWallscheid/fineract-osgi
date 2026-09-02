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

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;

@Entity
@Table(name = "m_product_loan_variable_installment_config")
public class LoanProductVariableInstallmentConfig extends AbstractPersistableCustom<Long> {

    @OneToOne
    @JoinColumn(name = "loan_product_id", nullable = false)
    private LoanProduct loanProduct;
    @Column(name = "minimum_gap")
    private Integer minimumGap;
    @Column(name = "maximum_gap")
    private Integer maximumGap;

    @java.lang.SuppressWarnings("all")
    public LoanProduct getLoanProduct() {
        return this.loanProduct;
    }

    @java.lang.SuppressWarnings("all")
    public Integer getMinimumGap() {
        return this.minimumGap;
    }

    @java.lang.SuppressWarnings("all")
    public Integer getMaximumGap() {
        return this.maximumGap;
    }

    @java.lang.SuppressWarnings("all")
    public void setMinimumGap(final Integer minimumGap) {
        this.minimumGap = minimumGap;
    }

    @java.lang.SuppressWarnings("all")
    public void setMaximumGap(final Integer maximumGap) {
        this.maximumGap = maximumGap;
    }

    @java.lang.SuppressWarnings("all")
    public LoanProductVariableInstallmentConfig() {}

    @java.lang.SuppressWarnings("all")
    public LoanProductVariableInstallmentConfig(final LoanProduct loanProduct, final Integer minimumGap, final Integer maximumGap) {
        this.loanProduct = loanProduct;
        this.minimumGap = minimumGap;
        this.maximumGap = maximumGap;
    }

    @java.lang.SuppressWarnings("all")
    public void setLoanProduct(final LoanProduct loanProduct) {
        this.loanProduct = loanProduct;
    }
}
