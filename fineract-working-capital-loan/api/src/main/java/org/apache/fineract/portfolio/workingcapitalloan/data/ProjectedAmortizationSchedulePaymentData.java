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

import java.math.BigDecimal;
import java.time.LocalDate;

public class ProjectedAmortizationSchedulePaymentData {
    private final int paymentNo;
    private final LocalDate paymentDate;
    private final BigDecimal expectedPaymentAmount;
    private final BigDecimal expectedBalance;
    private final BigDecimal actualBalance;
    private final BigDecimal expectedAmortizationAmount;
    private final BigDecimal actualPaymentAmount;
    private final BigDecimal actualAmortizationAmount;
    private final BigDecimal expectedDiscountFeeBalance;
    private final BigDecimal actualDiscountFeeBalance;


    @java.lang.SuppressWarnings("all")
        public static class ProjectedAmortizationSchedulePaymentDataBuilder {
        @java.lang.SuppressWarnings("all")
                private int paymentNo;
        @java.lang.SuppressWarnings("all")
                private LocalDate paymentDate;
        @java.lang.SuppressWarnings("all")
                private BigDecimal expectedPaymentAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal expectedBalance;
        @java.lang.SuppressWarnings("all")
                private BigDecimal actualBalance;
        @java.lang.SuppressWarnings("all")
                private BigDecimal expectedAmortizationAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal actualPaymentAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal actualAmortizationAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal expectedDiscountFeeBalance;
        @java.lang.SuppressWarnings("all")
                private BigDecimal actualDiscountFeeBalance;

        @java.lang.SuppressWarnings("all")
                ProjectedAmortizationSchedulePaymentDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationSchedulePaymentData.ProjectedAmortizationSchedulePaymentDataBuilder paymentNo(final int paymentNo) {
            this.paymentNo = paymentNo;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationSchedulePaymentData.ProjectedAmortizationSchedulePaymentDataBuilder paymentDate(final LocalDate paymentDate) {
            this.paymentDate = paymentDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationSchedulePaymentData.ProjectedAmortizationSchedulePaymentDataBuilder expectedPaymentAmount(final BigDecimal expectedPaymentAmount) {
            this.expectedPaymentAmount = expectedPaymentAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationSchedulePaymentData.ProjectedAmortizationSchedulePaymentDataBuilder expectedBalance(final BigDecimal expectedBalance) {
            this.expectedBalance = expectedBalance;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationSchedulePaymentData.ProjectedAmortizationSchedulePaymentDataBuilder actualBalance(final BigDecimal actualBalance) {
            this.actualBalance = actualBalance;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationSchedulePaymentData.ProjectedAmortizationSchedulePaymentDataBuilder expectedAmortizationAmount(final BigDecimal expectedAmortizationAmount) {
            this.expectedAmortizationAmount = expectedAmortizationAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationSchedulePaymentData.ProjectedAmortizationSchedulePaymentDataBuilder actualPaymentAmount(final BigDecimal actualPaymentAmount) {
            this.actualPaymentAmount = actualPaymentAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationSchedulePaymentData.ProjectedAmortizationSchedulePaymentDataBuilder actualAmortizationAmount(final BigDecimal actualAmortizationAmount) {
            this.actualAmortizationAmount = actualAmortizationAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationSchedulePaymentData.ProjectedAmortizationSchedulePaymentDataBuilder expectedDiscountFeeBalance(final BigDecimal expectedDiscountFeeBalance) {
            this.expectedDiscountFeeBalance = expectedDiscountFeeBalance;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationSchedulePaymentData.ProjectedAmortizationSchedulePaymentDataBuilder actualDiscountFeeBalance(final BigDecimal actualDiscountFeeBalance) {
            this.actualDiscountFeeBalance = actualDiscountFeeBalance;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationSchedulePaymentData build() {
            return new ProjectedAmortizationSchedulePaymentData(this.paymentNo, this.paymentDate, this.expectedPaymentAmount, this.expectedBalance, this.actualBalance, this.expectedAmortizationAmount, this.actualPaymentAmount, this.actualAmortizationAmount, this.expectedDiscountFeeBalance, this.actualDiscountFeeBalance);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ProjectedAmortizationSchedulePaymentData.ProjectedAmortizationSchedulePaymentDataBuilder(paymentNo=" + this.paymentNo + ", paymentDate=" + this.paymentDate + ", expectedPaymentAmount=" + this.expectedPaymentAmount + ", expectedBalance=" + this.expectedBalance + ", actualBalance=" + this.actualBalance + ", expectedAmortizationAmount=" + this.expectedAmortizationAmount + ", actualPaymentAmount=" + this.actualPaymentAmount + ", actualAmortizationAmount=" + this.actualAmortizationAmount + ", expectedDiscountFeeBalance=" + this.expectedDiscountFeeBalance + ", actualDiscountFeeBalance=" + this.actualDiscountFeeBalance + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ProjectedAmortizationSchedulePaymentData.ProjectedAmortizationSchedulePaymentDataBuilder builder() {
        return new ProjectedAmortizationSchedulePaymentData.ProjectedAmortizationSchedulePaymentDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public int getPaymentNo() {
        return this.paymentNo;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getPaymentDate() {
        return this.paymentDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getExpectedPaymentAmount() {
        return this.expectedPaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getExpectedBalance() {
        return this.expectedBalance;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getActualBalance() {
        return this.actualBalance;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getExpectedAmortizationAmount() {
        return this.expectedAmortizationAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getActualPaymentAmount() {
        return this.actualPaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getActualAmortizationAmount() {
        return this.actualAmortizationAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getExpectedDiscountFeeBalance() {
        return this.expectedDiscountFeeBalance;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getActualDiscountFeeBalance() {
        return this.actualDiscountFeeBalance;
    }

    @java.lang.SuppressWarnings("all")
        public ProjectedAmortizationSchedulePaymentData(final int paymentNo, final LocalDate paymentDate, final BigDecimal expectedPaymentAmount, final BigDecimal expectedBalance, final BigDecimal actualBalance, final BigDecimal expectedAmortizationAmount, final BigDecimal actualPaymentAmount, final BigDecimal actualAmortizationAmount, final BigDecimal expectedDiscountFeeBalance, final BigDecimal actualDiscountFeeBalance) {
        this.paymentNo = paymentNo;
        this.paymentDate = paymentDate;
        this.expectedPaymentAmount = expectedPaymentAmount;
        this.expectedBalance = expectedBalance;
        this.actualBalance = actualBalance;
        this.expectedAmortizationAmount = expectedAmortizationAmount;
        this.actualPaymentAmount = actualPaymentAmount;
        this.actualAmortizationAmount = actualAmortizationAmount;
        this.expectedDiscountFeeBalance = expectedDiscountFeeBalance;
        this.actualDiscountFeeBalance = actualDiscountFeeBalance;
    }
}
