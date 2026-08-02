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
package org.apache.fineract.portfolio.workingcapitalloanproduct.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import java.math.BigDecimal;

/**
 * WorkingCapitalLoanProductMinMaxConstraints encapsulates the min/max bounds for principal and period payment rate of a
 * {@link WorkingCapitalLoanProduct} (aligned with
 * {@link org.apache.fineract.portfolio.loanproduct.domain.LoanProductMinMaxConstraints} by functionality).
 */
@Embeddable
public class WorkingCapitalLoanProductMinMaxConstraints {
    @Column(name = "min_principal_amount", scale = 6, precision = 19)
    private BigDecimal minPrincipal;
    @Column(name = "max_principal_amount", scale = 6, precision = 19)
    private BigDecimal maxPrincipal;
    @Column(name = "min_period_payment_rate", scale = 6, precision = 19)
    private BigDecimal minPeriodPaymentRate;
    @Column(name = "max_period_payment_rate", scale = 6, precision = 19)
    private BigDecimal maxPeriodPaymentRate;

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMinPrincipal() {
        return this.minPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMaxPrincipal() {
        return this.maxPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMinPeriodPaymentRate() {
        return this.minPeriodPaymentRate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMaxPeriodPaymentRate() {
        return this.maxPeriodPaymentRate;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinPrincipal(final BigDecimal minPrincipal) {
        this.minPrincipal = minPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public void setMaxPrincipal(final BigDecimal maxPrincipal) {
        this.maxPrincipal = maxPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinPeriodPaymentRate(final BigDecimal minPeriodPaymentRate) {
        this.minPeriodPaymentRate = minPeriodPaymentRate;
    }

    @java.lang.SuppressWarnings("all")
        public void setMaxPeriodPaymentRate(final BigDecimal maxPeriodPaymentRate) {
        this.maxPeriodPaymentRate = maxPeriodPaymentRate;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanProductMinMaxConstraints(final BigDecimal minPrincipal, final BigDecimal maxPrincipal, final BigDecimal minPeriodPaymentRate, final BigDecimal maxPeriodPaymentRate) {
        this.minPrincipal = minPrincipal;
        this.maxPrincipal = maxPrincipal;
        this.minPeriodPaymentRate = minPeriodPaymentRate;
        this.maxPeriodPaymentRate = maxPeriodPaymentRate;
    }

    @java.lang.SuppressWarnings("all")
        protected WorkingCapitalLoanProductMinMaxConstraints() {
    }
}
