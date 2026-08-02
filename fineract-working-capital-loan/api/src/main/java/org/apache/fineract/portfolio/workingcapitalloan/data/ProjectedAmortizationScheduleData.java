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
import java.util.List;

public class ProjectedAmortizationScheduleData {
    private final BigDecimal discountFeeAmount;
    private final BigDecimal netDisbursementAmount;
    private final BigDecimal totalPaymentVolume;
    private final BigDecimal periodPaymentRate;
    private final int npvDayCount;
    private final LocalDate expectedDisbursementDate;
    private final BigDecimal expectedPaymentAmount;
    private final int originalPaymentNumber;
    private final BigDecimal effectiveInterestRate;
    private final List<ProjectedAmortizationSchedulePaymentData> payments;


    @java.lang.SuppressWarnings("all")
        public static class ProjectedAmortizationScheduleDataBuilder {
        @java.lang.SuppressWarnings("all")
                private BigDecimal discountFeeAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal netDisbursementAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalPaymentVolume;
        @java.lang.SuppressWarnings("all")
                private BigDecimal periodPaymentRate;
        @java.lang.SuppressWarnings("all")
                private int npvDayCount;
        @java.lang.SuppressWarnings("all")
                private LocalDate expectedDisbursementDate;
        @java.lang.SuppressWarnings("all")
                private BigDecimal expectedPaymentAmount;
        @java.lang.SuppressWarnings("all")
                private int originalPaymentNumber;
        @java.lang.SuppressWarnings("all")
                private BigDecimal effectiveInterestRate;
        @java.lang.SuppressWarnings("all")
                private List<ProjectedAmortizationSchedulePaymentData> payments;

        @java.lang.SuppressWarnings("all")
                ProjectedAmortizationScheduleDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationScheduleData.ProjectedAmortizationScheduleDataBuilder discountFeeAmount(final BigDecimal discountFeeAmount) {
            this.discountFeeAmount = discountFeeAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationScheduleData.ProjectedAmortizationScheduleDataBuilder netDisbursementAmount(final BigDecimal netDisbursementAmount) {
            this.netDisbursementAmount = netDisbursementAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationScheduleData.ProjectedAmortizationScheduleDataBuilder totalPaymentVolume(final BigDecimal totalPaymentVolume) {
            this.totalPaymentVolume = totalPaymentVolume;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationScheduleData.ProjectedAmortizationScheduleDataBuilder periodPaymentRate(final BigDecimal periodPaymentRate) {
            this.periodPaymentRate = periodPaymentRate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationScheduleData.ProjectedAmortizationScheduleDataBuilder npvDayCount(final int npvDayCount) {
            this.npvDayCount = npvDayCount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationScheduleData.ProjectedAmortizationScheduleDataBuilder expectedDisbursementDate(final LocalDate expectedDisbursementDate) {
            this.expectedDisbursementDate = expectedDisbursementDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationScheduleData.ProjectedAmortizationScheduleDataBuilder expectedPaymentAmount(final BigDecimal expectedPaymentAmount) {
            this.expectedPaymentAmount = expectedPaymentAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationScheduleData.ProjectedAmortizationScheduleDataBuilder originalPaymentNumber(final int originalPaymentNumber) {
            this.originalPaymentNumber = originalPaymentNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationScheduleData.ProjectedAmortizationScheduleDataBuilder effectiveInterestRate(final BigDecimal effectiveInterestRate) {
            this.effectiveInterestRate = effectiveInterestRate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationScheduleData.ProjectedAmortizationScheduleDataBuilder payments(final List<ProjectedAmortizationSchedulePaymentData> payments) {
            this.payments = payments;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ProjectedAmortizationScheduleData build() {
            return new ProjectedAmortizationScheduleData(this.discountFeeAmount, this.netDisbursementAmount, this.totalPaymentVolume, this.periodPaymentRate, this.npvDayCount, this.expectedDisbursementDate, this.expectedPaymentAmount, this.originalPaymentNumber, this.effectiveInterestRate, this.payments);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ProjectedAmortizationScheduleData.ProjectedAmortizationScheduleDataBuilder(discountFeeAmount=" + this.discountFeeAmount + ", netDisbursementAmount=" + this.netDisbursementAmount + ", totalPaymentVolume=" + this.totalPaymentVolume + ", periodPaymentRate=" + this.periodPaymentRate + ", npvDayCount=" + this.npvDayCount + ", expectedDisbursementDate=" + this.expectedDisbursementDate + ", expectedPaymentAmount=" + this.expectedPaymentAmount + ", originalPaymentNumber=" + this.originalPaymentNumber + ", effectiveInterestRate=" + this.effectiveInterestRate + ", payments=" + this.payments + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ProjectedAmortizationScheduleData.ProjectedAmortizationScheduleDataBuilder builder() {
        return new ProjectedAmortizationScheduleData.ProjectedAmortizationScheduleDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDiscountFeeAmount() {
        return this.discountFeeAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getNetDisbursementAmount() {
        return this.netDisbursementAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalPaymentVolume() {
        return this.totalPaymentVolume;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPeriodPaymentRate() {
        return this.periodPaymentRate;
    }

    @java.lang.SuppressWarnings("all")
        public int getNpvDayCount() {
        return this.npvDayCount;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getExpectedDisbursementDate() {
        return this.expectedDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getExpectedPaymentAmount() {
        return this.expectedPaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public int getOriginalPaymentNumber() {
        return this.originalPaymentNumber;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getEffectiveInterestRate() {
        return this.effectiveInterestRate;
    }

    @java.lang.SuppressWarnings("all")
        public List<ProjectedAmortizationSchedulePaymentData> getPayments() {
        return this.payments;
    }

    @java.lang.SuppressWarnings("all")
        public ProjectedAmortizationScheduleData(final BigDecimal discountFeeAmount, final BigDecimal netDisbursementAmount, final BigDecimal totalPaymentVolume, final BigDecimal periodPaymentRate, final int npvDayCount, final LocalDate expectedDisbursementDate, final BigDecimal expectedPaymentAmount, final int originalPaymentNumber, final BigDecimal effectiveInterestRate, final List<ProjectedAmortizationSchedulePaymentData> payments) {
        this.discountFeeAmount = discountFeeAmount;
        this.netDisbursementAmount = netDisbursementAmount;
        this.totalPaymentVolume = totalPaymentVolume;
        this.periodPaymentRate = periodPaymentRate;
        this.npvDayCount = npvDayCount;
        this.expectedDisbursementDate = expectedDisbursementDate;
        this.expectedPaymentAmount = expectedPaymentAmount;
        this.originalPaymentNumber = originalPaymentNumber;
        this.effectiveInterestRate = effectiveInterestRate;
        this.payments = payments;
    }
}
