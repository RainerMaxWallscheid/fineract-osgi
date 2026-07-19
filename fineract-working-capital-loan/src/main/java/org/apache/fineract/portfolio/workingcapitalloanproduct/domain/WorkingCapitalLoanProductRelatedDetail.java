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
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import java.math.BigDecimal;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoanPeriodFrequencyType;

/**
 * WorkingCapitalLoanProductRelatedDetail encapsulates the core product parameters of a
 * {@link WorkingCapitalLoanProduct} that define repayment and amortization behaviour (aligned with
 * {@link org.apache.fineract.portfolio.loanproduct.domain.LoanProductRelatedDetail} by functionality).
 */
@Embeddable
public class WorkingCapitalLoanProductRelatedDetail {
    @Enumerated(EnumType.STRING)
    @Column(name = "amortization_type", nullable = false)
    private WorkingCapitalAmortizationType amortizationType;
    @Column(name = "npv_day_count", nullable = false)
    private Integer npvDayCount;
    @Column(name = "principal_amount", scale = 6, precision = 19, nullable = false)
    private BigDecimal principal;
    @Column(name = "period_payment_rate", scale = 6, precision = 19, nullable = false)
    private BigDecimal periodPaymentRate;
    @Column(name = "repayment_every", nullable = false)
    private Integer repaymentEvery;
    @Enumerated(EnumType.STRING)
    @Column(name = "repayment_frequency_enum", nullable = false)
    private WorkingCapitalLoanPeriodFrequencyType repaymentFrequencyType;
    @Column(name = "discount", scale = 6, precision = 19)
    private BigDecimal discount;
    @Column(name = "delinquency_grace_days", nullable = false)
    private Integer delinquencyGraceDays = 0;
    @Enumerated(EnumType.STRING)
    @Column(name = "delinquency_start_type", nullable = false)
    private WorkingCapitalLoanDelinquencyStartType delinquencyStartType;
    @Column(name = "breach_grace_days", nullable = true)
    private Integer breachGraceDays;

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalAmortizationType getAmortizationType() {
        return this.amortizationType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getNpvDayCount() {
        return this.npvDayCount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipal() {
        return this.principal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPeriodPaymentRate() {
        return this.periodPaymentRate;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRepaymentEvery() {
        return this.repaymentEvery;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanPeriodFrequencyType getRepaymentFrequencyType() {
        return this.repaymentFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDiscount() {
        return this.discount;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getDelinquencyGraceDays() {
        return this.delinquencyGraceDays;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanDelinquencyStartType getDelinquencyStartType() {
        return this.delinquencyStartType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getBreachGraceDays() {
        return this.breachGraceDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmortizationType(final WorkingCapitalAmortizationType amortizationType) {
        this.amortizationType = amortizationType;
    }

    @java.lang.SuppressWarnings("all")
        public void setNpvDayCount(final Integer npvDayCount) {
        this.npvDayCount = npvDayCount;
    }

    @java.lang.SuppressWarnings("all")
        public void setPrincipal(final BigDecimal principal) {
        this.principal = principal;
    }

    @java.lang.SuppressWarnings("all")
        public void setPeriodPaymentRate(final BigDecimal periodPaymentRate) {
        this.periodPaymentRate = periodPaymentRate;
    }

    @java.lang.SuppressWarnings("all")
        public void setRepaymentEvery(final Integer repaymentEvery) {
        this.repaymentEvery = repaymentEvery;
    }

    @java.lang.SuppressWarnings("all")
        public void setRepaymentFrequencyType(final WorkingCapitalLoanPeriodFrequencyType repaymentFrequencyType) {
        this.repaymentFrequencyType = repaymentFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public void setDiscount(final BigDecimal discount) {
        this.discount = discount;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyGraceDays(final Integer delinquencyGraceDays) {
        this.delinquencyGraceDays = delinquencyGraceDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyStartType(final WorkingCapitalLoanDelinquencyStartType delinquencyStartType) {
        this.delinquencyStartType = delinquencyStartType;
    }

    @java.lang.SuppressWarnings("all")
        public void setBreachGraceDays(final Integer breachGraceDays) {
        this.breachGraceDays = breachGraceDays;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanProductRelatedDetail(final WorkingCapitalAmortizationType amortizationType, final Integer npvDayCount, final BigDecimal principal, final BigDecimal periodPaymentRate, final Integer repaymentEvery, final WorkingCapitalLoanPeriodFrequencyType repaymentFrequencyType, final BigDecimal discount, final Integer delinquencyGraceDays, final WorkingCapitalLoanDelinquencyStartType delinquencyStartType, final Integer breachGraceDays) {
        this.amortizationType = amortizationType;
        this.npvDayCount = npvDayCount;
        this.principal = principal;
        this.periodPaymentRate = periodPaymentRate;
        this.repaymentEvery = repaymentEvery;
        this.repaymentFrequencyType = repaymentFrequencyType;
        this.discount = discount;
        this.delinquencyGraceDays = delinquencyGraceDays;
        this.delinquencyStartType = delinquencyStartType;
        this.breachGraceDays = breachGraceDays;
    }

    @java.lang.SuppressWarnings("all")
        protected WorkingCapitalLoanProductRelatedDetail() {
    }
}
