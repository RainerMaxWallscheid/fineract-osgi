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
import jakarta.persistence.Embedded;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import java.math.BigDecimal;
import org.apache.fineract.organisation.monetary.domain.MonetaryCurrency;
import org.apache.fineract.portfolio.delinquency.domain.DelinquencyBucket;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoan;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoanPeriodFrequencyType;
import org.apache.fineract.portfolio.workingcapitalloanbreach.domain.WorkingCapitalBreach;
import org.apache.fineract.portfolio.workingcapitalloannearbreach.domain.WorkingCapitalNearBreach;

/**
 * WCLoanProductRelatedDetail encapsulates all the details of a {@link WorkingCapitalLoanProduct} that are also used and
 * persisted by a {@link WorkingCapitalLoan}.
 */
@Embeddable
public class WorkingCapitalLoanProductRelatedDetails {
    @Embedded
    private MonetaryCurrency currency;
    @Column(name = "principal_amount", scale = 6, precision = 19)
    private BigDecimal principal;
    @Column(name = "period_payment_rate", scale = 6, precision = 19, nullable = false)
    private BigDecimal periodPaymentRate;
    @Column(name = "repayment_every", nullable = false)
    private Integer repaymentEvery;
    @Enumerated(EnumType.STRING)
    @Column(name = "repayment_frequency_enum", nullable = false)
    private WorkingCapitalLoanPeriodFrequencyType repaymentFrequencyType;
    @Enumerated(EnumType.STRING)
    @Column(name = "amortization_type", nullable = false)
    private WorkingCapitalAmortizationType amortizationType;
    @Column(name = "npv_day_count", nullable = false)
    private Integer npvDayCount;
    @Column(name = "discount", scale = 6, precision = 19)
    private BigDecimal discount;
    @Column(name = "discount_proposed", scale = 6, precision = 19)
    private BigDecimal discountProposed;
    @Column(name = "discount_approved", scale = 6, precision = 19)
    private BigDecimal discountApproved;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "delinquency_bucket_classification_id")
    private DelinquencyBucket delinquencyBucket;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "breach_id")
    private WorkingCapitalBreach breach;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "near_breach_id")
    private WorkingCapitalNearBreach nearBreach;
    @Column(name = "delinquency_grace_days", nullable = false)
    private Integer delinquencyGraceDays = 0;
    @Enumerated(EnumType.STRING)
    @Column(name = "delinquency_start_type", nullable = false)
    private WorkingCapitalLoanDelinquencyStartType delinquencyStartType;
    @Column(name = "breach_grace_days", nullable = true)
    private Integer breachGraceDays;

    @java.lang.SuppressWarnings("all")
        public MonetaryCurrency getCurrency() {
        return this.currency;
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
        public WorkingCapitalAmortizationType getAmortizationType() {
        return this.amortizationType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getNpvDayCount() {
        return this.npvDayCount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDiscount() {
        return this.discount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDiscountProposed() {
        return this.discountProposed;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDiscountApproved() {
        return this.discountApproved;
    }

    @java.lang.SuppressWarnings("all")
        public DelinquencyBucket getDelinquencyBucket() {
        return this.delinquencyBucket;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalBreach getBreach() {
        return this.breach;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalNearBreach getNearBreach() {
        return this.nearBreach;
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
        public void setCurrency(final MonetaryCurrency currency) {
        this.currency = currency;
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
        public void setAmortizationType(final WorkingCapitalAmortizationType amortizationType) {
        this.amortizationType = amortizationType;
    }

    @java.lang.SuppressWarnings("all")
        public void setNpvDayCount(final Integer npvDayCount) {
        this.npvDayCount = npvDayCount;
    }

    @java.lang.SuppressWarnings("all")
        public void setDiscount(final BigDecimal discount) {
        this.discount = discount;
    }

    @java.lang.SuppressWarnings("all")
        public void setDiscountProposed(final BigDecimal discountProposed) {
        this.discountProposed = discountProposed;
    }

    @java.lang.SuppressWarnings("all")
        public void setDiscountApproved(final BigDecimal discountApproved) {
        this.discountApproved = discountApproved;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyBucket(final DelinquencyBucket delinquencyBucket) {
        this.delinquencyBucket = delinquencyBucket;
    }

    @java.lang.SuppressWarnings("all")
        public void setBreach(final WorkingCapitalBreach breach) {
        this.breach = breach;
    }

    @java.lang.SuppressWarnings("all")
        public void setNearBreach(final WorkingCapitalNearBreach nearBreach) {
        this.nearBreach = nearBreach;
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
}
