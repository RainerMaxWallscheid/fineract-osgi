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
import java.math.BigDecimal;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;

/**
 * Loan product floating-rate linkage. Stores catalog floating rate id only (no JPA association to rates-impl).
 */
@Entity
@Table(name = "m_product_loan_floating_rates")
public class LoanProductFloatingRates extends AbstractPersistableCustom<Long> {

    @OneToOne
    @JoinColumn(name = "loan_product_id", nullable = false)
    private LoanProduct loanProduct;
    /** Catalog floating rate definition id (column floating_rates_id). */
    @Column(name = "floating_rates_id", nullable = false)
    private Long floatingRateId;
    @Column(name = "interest_rate_differential", nullable = false)
    private BigDecimal interestRateDifferential;
    @Column(name = "min_differential_lending_rate", nullable = false)
    private BigDecimal minDifferentialLendingRate;
    @Column(name = "default_differential_lending_rate", nullable = false)
    private BigDecimal defaultDifferentialLendingRate;
    @Column(name = "max_differential_lending_rate", nullable = false)
    private BigDecimal maxDifferentialLendingRate;
    @Column(name = "is_floating_interest_rate_calculation_allowed", nullable = false)
    private boolean isFloatingInterestRateCalculationAllowed;

    public LoanProductFloatingRates() {}

    public LoanProductFloatingRates(Long floatingRateId, LoanProduct loanProduct, BigDecimal interestRateDifferential,
            BigDecimal minDifferentialLendingRate, BigDecimal maxDifferentialLendingRate, BigDecimal defaultDifferentialLendingRate,
            boolean isFloatingInterestRateCalculationAllowed) {
        this.floatingRateId = floatingRateId;
        this.loanProduct = loanProduct;
        this.interestRateDifferential = interestRateDifferential;
        this.minDifferentialLendingRate = minDifferentialLendingRate;
        this.maxDifferentialLendingRate = maxDifferentialLendingRate;
        this.defaultDifferentialLendingRate = defaultDifferentialLendingRate;
        this.isFloatingInterestRateCalculationAllowed = isFloatingInterestRateCalculationAllowed;
    }

    public void setLoanProduct(final LoanProduct loanProduct) {
        this.loanProduct = loanProduct;
    }

    public void setFloatingRateId(final Long floatingRateId) {
        this.floatingRateId = floatingRateId;
    }

    public void setInterestRateDifferential(final BigDecimal interestRateDifferential) {
        this.interestRateDifferential = interestRateDifferential;
    }

    public void setMinDifferentialLendingRate(final BigDecimal minDifferentialLendingRate) {
        this.minDifferentialLendingRate = minDifferentialLendingRate;
    }

    public void setDefaultDifferentialLendingRate(final BigDecimal defaultDifferentialLendingRate) {
        this.defaultDifferentialLendingRate = defaultDifferentialLendingRate;
    }

    public void setMaxDifferentialLendingRate(final BigDecimal maxDifferentialLendingRate) {
        this.maxDifferentialLendingRate = maxDifferentialLendingRate;
    }

    public void setFloatingInterestRateCalculationAllowed(final boolean isFloatingInterestRateCalculationAllowed) {
        this.isFloatingInterestRateCalculationAllowed = isFloatingInterestRateCalculationAllowed;
    }

    public LoanProduct getLoanProduct() {
        return this.loanProduct;
    }

    public Long getFloatingRateId() {
        return this.floatingRateId;
    }

    public BigDecimal getInterestRateDifferential() {
        return this.interestRateDifferential;
    }

    public BigDecimal getMinDifferentialLendingRate() {
        return this.minDifferentialLendingRate;
    }

    public BigDecimal getDefaultDifferentialLendingRate() {
        return this.defaultDifferentialLendingRate;
    }

    public BigDecimal getMaxDifferentialLendingRate() {
        return this.maxDifferentialLendingRate;
    }

    public boolean isFloatingInterestRateCalculationAllowed() {
        return this.isFloatingInterestRateCalculationAllowed;
    }
}
