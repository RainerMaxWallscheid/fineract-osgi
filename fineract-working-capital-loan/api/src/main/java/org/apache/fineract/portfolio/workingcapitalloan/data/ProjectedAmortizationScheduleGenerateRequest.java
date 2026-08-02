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

public class ProjectedAmortizationScheduleGenerateRequest {
    private BigDecimal discountFeeAmount;
    private BigDecimal netDisbursementAmount;
    private BigDecimal totalPaymentVolume;
    private BigDecimal periodPaymentRate;
    private int npvDayCount;
    private LocalDate expectedDisbursementDate;

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
        public void setDiscountFeeAmount(final BigDecimal discountFeeAmount) {
        this.discountFeeAmount = discountFeeAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setNetDisbursementAmount(final BigDecimal netDisbursementAmount) {
        this.netDisbursementAmount = netDisbursementAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalPaymentVolume(final BigDecimal totalPaymentVolume) {
        this.totalPaymentVolume = totalPaymentVolume;
    }

    @java.lang.SuppressWarnings("all")
        public void setPeriodPaymentRate(final BigDecimal periodPaymentRate) {
        this.periodPaymentRate = periodPaymentRate;
    }

    @java.lang.SuppressWarnings("all")
        public void setNpvDayCount(final int npvDayCount) {
        this.npvDayCount = npvDayCount;
    }

    @java.lang.SuppressWarnings("all")
        public void setExpectedDisbursementDate(final LocalDate expectedDisbursementDate) {
        this.expectedDisbursementDate = expectedDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public ProjectedAmortizationScheduleGenerateRequest() {
    }
}
