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
package org.apache.fineract.portfolio.workingcapitalloan.data;

import java.io.Serializable;
import java.math.BigDecimal;
import org.apache.fineract.organisation.monetary.data.CurrencyData;

public class WorkingCapitalLoanSummaryData implements Serializable {
    private CurrencyData currency;
    // Principal
    private BigDecimal principal;
    private BigDecimal principalPaid;
    private BigDecimal principalOutstanding;
    // Fee
    private BigDecimal fee;
    private BigDecimal feePaid;
    private BigDecimal feeOutstanding;
    // Penalty
    private BigDecimal penalty;
    private BigDecimal penaltyPaid;
    private BigDecimal penaltyOutstanding;
    // Income recognition
    private BigDecimal realizedIncomeFromDiscountFee;
    private BigDecimal unrealizedIncomeFromDiscountFee;
    // Overpayment
    private BigDecimal overpayment;
    // Aggregates
    private BigDecimal totalDisbursement;
    private BigDecimal totalDiscountFee;
    private BigDecimal totalDiscountFeeAdjustment;
    private BigDecimal totalExpectedRepayment;
    private BigDecimal totalRepayment;
    private BigDecimal totalOutstanding;


    @java.lang.SuppressWarnings("all")
        public static class WorkingCapitalLoanSummaryDataBuilder {
        @java.lang.SuppressWarnings("all")
                private CurrencyData currency;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principal;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalPaid;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalOutstanding;
        @java.lang.SuppressWarnings("all")
                private BigDecimal fee;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feePaid;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feeOutstanding;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penalty;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penaltyPaid;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penaltyOutstanding;
        @java.lang.SuppressWarnings("all")
                private BigDecimal realizedIncomeFromDiscountFee;
        @java.lang.SuppressWarnings("all")
                private BigDecimal unrealizedIncomeFromDiscountFee;
        @java.lang.SuppressWarnings("all")
                private BigDecimal overpayment;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalDisbursement;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalDiscountFee;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalDiscountFeeAdjustment;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalExpectedRepayment;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalRepayment;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalOutstanding;

        @java.lang.SuppressWarnings("all")
                WorkingCapitalLoanSummaryDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder currency(final CurrencyData currency) {
            this.currency = currency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder principal(final BigDecimal principal) {
            this.principal = principal;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder principalPaid(final BigDecimal principalPaid) {
            this.principalPaid = principalPaid;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder principalOutstanding(final BigDecimal principalOutstanding) {
            this.principalOutstanding = principalOutstanding;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder fee(final BigDecimal fee) {
            this.fee = fee;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder feePaid(final BigDecimal feePaid) {
            this.feePaid = feePaid;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder feeOutstanding(final BigDecimal feeOutstanding) {
            this.feeOutstanding = feeOutstanding;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder penalty(final BigDecimal penalty) {
            this.penalty = penalty;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder penaltyPaid(final BigDecimal penaltyPaid) {
            this.penaltyPaid = penaltyPaid;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder penaltyOutstanding(final BigDecimal penaltyOutstanding) {
            this.penaltyOutstanding = penaltyOutstanding;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder realizedIncomeFromDiscountFee(final BigDecimal realizedIncomeFromDiscountFee) {
            this.realizedIncomeFromDiscountFee = realizedIncomeFromDiscountFee;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder unrealizedIncomeFromDiscountFee(final BigDecimal unrealizedIncomeFromDiscountFee) {
            this.unrealizedIncomeFromDiscountFee = unrealizedIncomeFromDiscountFee;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder overpayment(final BigDecimal overpayment) {
            this.overpayment = overpayment;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder totalDisbursement(final BigDecimal totalDisbursement) {
            this.totalDisbursement = totalDisbursement;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder totalDiscountFee(final BigDecimal totalDiscountFee) {
            this.totalDiscountFee = totalDiscountFee;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder totalDiscountFeeAdjustment(final BigDecimal totalDiscountFeeAdjustment) {
            this.totalDiscountFeeAdjustment = totalDiscountFeeAdjustment;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder totalExpectedRepayment(final BigDecimal totalExpectedRepayment) {
            this.totalExpectedRepayment = totalExpectedRepayment;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder totalRepayment(final BigDecimal totalRepayment) {
            this.totalRepayment = totalRepayment;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder totalOutstanding(final BigDecimal totalOutstanding) {
            this.totalOutstanding = totalOutstanding;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanSummaryData build() {
            return new WorkingCapitalLoanSummaryData(this.currency, this.principal, this.principalPaid, this.principalOutstanding, this.fee, this.feePaid, this.feeOutstanding, this.penalty, this.penaltyPaid, this.penaltyOutstanding, this.realizedIncomeFromDiscountFee, this.unrealizedIncomeFromDiscountFee, this.overpayment, this.totalDisbursement, this.totalDiscountFee, this.totalDiscountFeeAdjustment, this.totalExpectedRepayment, this.totalRepayment, this.totalOutstanding);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder(currency=" + this.currency + ", principal=" + this.principal + ", principalPaid=" + this.principalPaid + ", principalOutstanding=" + this.principalOutstanding + ", fee=" + this.fee + ", feePaid=" + this.feePaid + ", feeOutstanding=" + this.feeOutstanding + ", penalty=" + this.penalty + ", penaltyPaid=" + this.penaltyPaid + ", penaltyOutstanding=" + this.penaltyOutstanding + ", realizedIncomeFromDiscountFee=" + this.realizedIncomeFromDiscountFee + ", unrealizedIncomeFromDiscountFee=" + this.unrealizedIncomeFromDiscountFee + ", overpayment=" + this.overpayment + ", totalDisbursement=" + this.totalDisbursement + ", totalDiscountFee=" + this.totalDiscountFee + ", totalDiscountFeeAdjustment=" + this.totalDiscountFeeAdjustment + ", totalExpectedRepayment=" + this.totalExpectedRepayment + ", totalRepayment=" + this.totalRepayment + ", totalOutstanding=" + this.totalOutstanding + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder builder() {
        return new WorkingCapitalLoanSummaryData.WorkingCapitalLoanSummaryDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
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
        public BigDecimal getPrincipalOutstanding() {
        return this.principalOutstanding;
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
        public BigDecimal getFeeOutstanding() {
        return this.feeOutstanding;
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
        public BigDecimal getPenaltyOutstanding() {
        return this.penaltyOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getRealizedIncomeFromDiscountFee() {
        return this.realizedIncomeFromDiscountFee;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getUnrealizedIncomeFromDiscountFee() {
        return this.unrealizedIncomeFromDiscountFee;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOverpayment() {
        return this.overpayment;
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
        public BigDecimal getTotalExpectedRepayment() {
        return this.totalExpectedRepayment;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalRepayment() {
        return this.totalRepayment;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalOutstanding() {
        return this.totalOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrency(final CurrencyData currency) {
        this.currency = currency;
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
        public void setPrincipalOutstanding(final BigDecimal principalOutstanding) {
        this.principalOutstanding = principalOutstanding;
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
        public void setFeeOutstanding(final BigDecimal feeOutstanding) {
        this.feeOutstanding = feeOutstanding;
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
        public void setPenaltyOutstanding(final BigDecimal penaltyOutstanding) {
        this.penaltyOutstanding = penaltyOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public void setRealizedIncomeFromDiscountFee(final BigDecimal realizedIncomeFromDiscountFee) {
        this.realizedIncomeFromDiscountFee = realizedIncomeFromDiscountFee;
    }

    @java.lang.SuppressWarnings("all")
        public void setUnrealizedIncomeFromDiscountFee(final BigDecimal unrealizedIncomeFromDiscountFee) {
        this.unrealizedIncomeFromDiscountFee = unrealizedIncomeFromDiscountFee;
    }

    @java.lang.SuppressWarnings("all")
        public void setOverpayment(final BigDecimal overpayment) {
        this.overpayment = overpayment;
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

    @java.lang.SuppressWarnings("all")
        public void setTotalExpectedRepayment(final BigDecimal totalExpectedRepayment) {
        this.totalExpectedRepayment = totalExpectedRepayment;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalRepayment(final BigDecimal totalRepayment) {
        this.totalRepayment = totalRepayment;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalOutstanding(final BigDecimal totalOutstanding) {
        this.totalOutstanding = totalOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanSummaryData() {
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanSummaryData(final CurrencyData currency, final BigDecimal principal, final BigDecimal principalPaid, final BigDecimal principalOutstanding, final BigDecimal fee, final BigDecimal feePaid, final BigDecimal feeOutstanding, final BigDecimal penalty, final BigDecimal penaltyPaid, final BigDecimal penaltyOutstanding, final BigDecimal realizedIncomeFromDiscountFee, final BigDecimal unrealizedIncomeFromDiscountFee, final BigDecimal overpayment, final BigDecimal totalDisbursement, final BigDecimal totalDiscountFee, final BigDecimal totalDiscountFeeAdjustment, final BigDecimal totalExpectedRepayment, final BigDecimal totalRepayment, final BigDecimal totalOutstanding) {
        this.currency = currency;
        this.principal = principal;
        this.principalPaid = principalPaid;
        this.principalOutstanding = principalOutstanding;
        this.fee = fee;
        this.feePaid = feePaid;
        this.feeOutstanding = feeOutstanding;
        this.penalty = penalty;
        this.penaltyPaid = penaltyPaid;
        this.penaltyOutstanding = penaltyOutstanding;
        this.realizedIncomeFromDiscountFee = realizedIncomeFromDiscountFee;
        this.unrealizedIncomeFromDiscountFee = unrealizedIncomeFromDiscountFee;
        this.overpayment = overpayment;
        this.totalDisbursement = totalDisbursement;
        this.totalDiscountFee = totalDiscountFee;
        this.totalDiscountFeeAdjustment = totalDiscountFeeAdjustment;
        this.totalExpectedRepayment = totalExpectedRepayment;
        this.totalRepayment = totalRepayment;
        this.totalOutstanding = totalOutstanding;
    }
}
