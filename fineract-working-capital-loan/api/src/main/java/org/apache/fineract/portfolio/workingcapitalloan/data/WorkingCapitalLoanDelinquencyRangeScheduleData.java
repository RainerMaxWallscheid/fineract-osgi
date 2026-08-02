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

public class WorkingCapitalLoanDelinquencyRangeScheduleData {
    private Long id;
    private Long loanId;
    private Integer periodNumber;
    private LocalDate fromDate;
    private LocalDate toDate;
    private BigDecimal expectedAmount;
    private BigDecimal paidAmount;
    private BigDecimal outstandingAmount;
    private Boolean minPaymentCriteriaMet;
    private Long delinquentDays;
    private BigDecimal delinquentAmount;

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanDelinquencyRangeScheduleData(final Long id, final Long loanId, final Integer periodNumber, final LocalDate fromDate, final LocalDate toDate, final BigDecimal expectedAmount, final BigDecimal paidAmount, final BigDecimal outstandingAmount, final Boolean minPaymentCriteriaMet, final Long delinquentDays, final BigDecimal delinquentAmount) {
        this.id = id;
        this.loanId = loanId;
        this.periodNumber = periodNumber;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.expectedAmount = expectedAmount;
        this.paidAmount = paidAmount;
        this.outstandingAmount = outstandingAmount;
        this.minPaymentCriteriaMet = minPaymentCriteriaMet;
        this.delinquentDays = delinquentDays;
        this.delinquentAmount = delinquentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getPeriodNumber() {
        return this.periodNumber;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getFromDate() {
        return this.fromDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getToDate() {
        return this.toDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getExpectedAmount() {
        return this.expectedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPaidAmount() {
        return this.paidAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOutstandingAmount() {
        return this.outstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getMinPaymentCriteriaMet() {
        return this.minPaymentCriteriaMet;
    }

    @java.lang.SuppressWarnings("all")
        public Long getDelinquentDays() {
        return this.delinquentDays;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDelinquentAmount() {
        return this.delinquentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanId(final Long loanId) {
        this.loanId = loanId;
    }

    @java.lang.SuppressWarnings("all")
        public void setPeriodNumber(final Integer periodNumber) {
        this.periodNumber = periodNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromDate(final LocalDate fromDate) {
        this.fromDate = fromDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setToDate(final LocalDate toDate) {
        this.toDate = toDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setExpectedAmount(final BigDecimal expectedAmount) {
        this.expectedAmount = expectedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setPaidAmount(final BigDecimal paidAmount) {
        this.paidAmount = paidAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setOutstandingAmount(final BigDecimal outstandingAmount) {
        this.outstandingAmount = outstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinPaymentCriteriaMet(final Boolean minPaymentCriteriaMet) {
        this.minPaymentCriteriaMet = minPaymentCriteriaMet;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentDays(final Long delinquentDays) {
        this.delinquentDays = delinquentDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentAmount(final BigDecimal delinquentAmount) {
        this.delinquentAmount = delinquentAmount;
    }
}
