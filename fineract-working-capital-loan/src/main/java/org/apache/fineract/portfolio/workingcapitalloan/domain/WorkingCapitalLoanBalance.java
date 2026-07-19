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
package org.apache.fineract.portfolio.workingcapitalloan.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import jakarta.persistence.Version;
import java.math.BigDecimal;
import java.util.Optional;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;
import org.apache.fineract.infrastructure.core.service.MathUtil;
import org.apache.fineract.portfolio.workingcapitalloanproduct.domain.WorkingCapitalLoanProductRelatedDetails;

/**
 * Stores all balances of a working capital loan (one row per loan). Updated from allocations; accounting depends on
 * this.
 */
@Entity
@Table(name = "m_wc_loan_balance", uniqueConstraints = {@UniqueConstraint(columnNames = {"wc_loan_id"}, name = "uq_m_wc_loan_balance_loan_id")})
public class WorkingCapitalLoanBalance extends AbstractAuditableWithUTCDateTimeCustom<Long> {
    @OneToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "wc_loan_id", nullable = false, unique = true)
    private WorkingCapitalLoan wcLoan;
    @Column(name = "principal", scale = 6, precision = 19, nullable = false)
    private BigDecimal principal = BigDecimal.ZERO;
    @Column(name = "principal_paid", scale = 6, precision = 19, nullable = false)
    private BigDecimal principalPaid = BigDecimal.ZERO;
    @Column(name = "fee", scale = 6, precision = 19, nullable = false)
    private BigDecimal fee = BigDecimal.ZERO;
    @Column(name = "fee_paid", scale = 6, precision = 19, nullable = false)
    private BigDecimal feePaid = BigDecimal.ZERO;
    @Column(name = "penalty", scale = 6, precision = 19, nullable = false)
    private BigDecimal penalty = BigDecimal.ZERO;
    @Column(name = "penalty_paid", scale = 6, precision = 19, nullable = false)
    private BigDecimal penaltyPaid = BigDecimal.ZERO;
    @Column(name = "realized_income_from_discount_fee", scale = 6, precision = 19, nullable = false)
    private BigDecimal realizedIncomeFromDiscountFee = BigDecimal.ZERO;
    @Column(name = "overpayment_amount", scale = 6, precision = 19, nullable = false)
    private BigDecimal overpaymentAmount = BigDecimal.ZERO;
    @Column(name = "total_disbursement", scale = 6, precision = 19, nullable = false)
    private BigDecimal totalDisbursement = BigDecimal.ZERO;
    @Column(name = "total_discount_fee", scale = 6, precision = 19, nullable = false)
    private BigDecimal totalDiscountFee = BigDecimal.ZERO;
    @Column(name = "total_discount_fee_adjustment", scale = 6, precision = 19, nullable = false)
    private BigDecimal totalDiscountFeeAdjustment = BigDecimal.ZERO;
    @Version
    @Column(name = "version")
    private Integer version;

    protected WorkingCapitalLoanBalance() {
    }

    public static WorkingCapitalLoanBalance createFor(final WorkingCapitalLoan loan) {
        final WorkingCapitalLoanBalance balance = new WorkingCapitalLoanBalance();
        balance.wcLoan = loan;
        return balance;
    }

    public void applyDisbursement(final BigDecimal disbursedAmount) {
        final BigDecimal discount = Optional.ofNullable(wcLoan.getLoanProductRelatedDetails()).map(WorkingCapitalLoanProductRelatedDetails::getDiscount).orElse(BigDecimal.ZERO);
        this.totalDiscountFee = discount;
        this.principal = disbursedAmount.add(discount);
        this.overpaymentAmount = BigDecimal.ZERO;
    }

    public BigDecimal getPrincipalOutstanding() {
        return MathUtil.subtract(getPrincipal(), getPrincipalPaid()).max(BigDecimal.ZERO);
    }

    public BigDecimal getFeeOutstanding() {
        return MathUtil.subtract(getFee(), getFeePaid()).max(BigDecimal.ZERO);
    }

    public BigDecimal getPenaltyOutstanding() {
        return MathUtil.subtract(getPenalty(), getPenaltyPaid()).max(BigDecimal.ZERO);
    }

    public BigDecimal getTotalOutstanding() {
        return MathUtil.add(getPrincipalOutstanding()).add(getFeeOutstanding()).add(getPenaltyOutstanding());
    }

    public BigDecimal getTotalExpectedRepayment() {
        return MathUtil.add(getPrincipal()).add(getPenalty()).add(getFee());
    }

    public BigDecimal getTotalRepayment() {
        return MathUtil.add(getPrincipalPaid()).add(getFeePaid()).add(getPenaltyPaid());
    }

    public BigDecimal getUnrealizedIncomeFromDiscountFee() {
        return MathUtil.subtract(MathUtil.subtract(getTotalDiscountFee(), getTotalDiscountFeeAdjustment()), getRealizedIncomeFromDiscountFee()).max(BigDecimal.ZERO);
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoan getWcLoan() {
        return this.wcLoan;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipal() {
        return this.principal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalPaid() {
        return this.principalPaid;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFee() {
        return this.fee;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeePaid() {
        return this.feePaid;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenalty() {
        return this.penalty;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyPaid() {
        return this.penaltyPaid;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getRealizedIncomeFromDiscountFee() {
        return this.realizedIncomeFromDiscountFee;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOverpaymentAmount() {
        return this.overpaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalDisbursement() {
        return this.totalDisbursement;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalDiscountFee() {
        return this.totalDiscountFee;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalDiscountFeeAdjustment() {
        return this.totalDiscountFeeAdjustment;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getVersion() {
        return this.version;
    }

    @java.lang.SuppressWarnings("all")
        public void setPrincipal(final BigDecimal principal) {
        this.principal = principal;
    }

    @java.lang.SuppressWarnings("all")
        public void setPrincipalPaid(final BigDecimal principalPaid) {
        this.principalPaid = principalPaid;
    }

    @java.lang.SuppressWarnings("all")
        public void setFee(final BigDecimal fee) {
        this.fee = fee;
    }

    @java.lang.SuppressWarnings("all")
        public void setFeePaid(final BigDecimal feePaid) {
        this.feePaid = feePaid;
    }

    @java.lang.SuppressWarnings("all")
        public void setPenalty(final BigDecimal penalty) {
        this.penalty = penalty;
    }

    @java.lang.SuppressWarnings("all")
        public void setPenaltyPaid(final BigDecimal penaltyPaid) {
        this.penaltyPaid = penaltyPaid;
    }

    @java.lang.SuppressWarnings("all")
        public void setRealizedIncomeFromDiscountFee(final BigDecimal realizedIncomeFromDiscountFee) {
        this.realizedIncomeFromDiscountFee = realizedIncomeFromDiscountFee;
    }

    @java.lang.SuppressWarnings("all")
        public void setOverpaymentAmount(final BigDecimal overpaymentAmount) {
        this.overpaymentAmount = overpaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalDisbursement(final BigDecimal totalDisbursement) {
        this.totalDisbursement = totalDisbursement;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalDiscountFee(final BigDecimal totalDiscountFee) {
        this.totalDiscountFee = totalDiscountFee;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalDiscountFeeAdjustment(final BigDecimal totalDiscountFeeAdjustment) {
        this.totalDiscountFeeAdjustment = totalDiscountFeeAdjustment;
    }
}
