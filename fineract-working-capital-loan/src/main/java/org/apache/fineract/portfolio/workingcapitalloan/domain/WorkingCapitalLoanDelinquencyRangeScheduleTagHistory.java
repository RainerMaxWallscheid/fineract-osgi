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
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Version;
import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;
import org.apache.fineract.portfolio.delinquency.domain.DelinquencyRange;

@Entity
@Table(name = "m_wc_loan_range_delinquency_tag")
public class WorkingCapitalLoanDelinquencyRangeScheduleTagHistory extends AbstractAuditableWithUTCDateTimeCustom<Long> {
    @ManyToOne
    @JoinColumn(name = "delinquency_range_id", nullable = false)
    private DelinquencyRange delinquencyRange;
    @ManyToOne
    @JoinColumn(name = "loan_id", nullable = false)
    private WorkingCapitalLoan loan;
    @ManyToOne
    @JoinColumn(name = "range_id", nullable = false)
    private WorkingCapitalLoanDelinquencyRangeSchedule rangeSchedule;
    @Column(name = "addedon_date", nullable = false)
    private LocalDate addedOnDate;
    @Column(name = "liftedon_date", nullable = true)
    private LocalDate liftedOnDate;
    @Column(name = "outstanding_amount", scale = 6, precision = 19)
    private BigDecimal outstandingAmount;
    @Version
    private Long version;

    public WorkingCapitalLoanDelinquencyRangeScheduleTagHistory(DelinquencyRange delinquencyRange, WorkingCapitalLoan loan, WorkingCapitalLoanDelinquencyRangeSchedule rangeSchedule, LocalDate addedOnDate, LocalDate liftedOnDate, BigDecimal outstandingAmount) {
        this.delinquencyRange = delinquencyRange;
        this.loan = loan;
        this.rangeSchedule = rangeSchedule;
        this.addedOnDate = addedOnDate;
        this.liftedOnDate = liftedOnDate;
        this.outstandingAmount = outstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
        public DelinquencyRange getDelinquencyRange() {
        return this.delinquencyRange;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoan getLoan() {
        return this.loan;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanDelinquencyRangeSchedule getRangeSchedule() {
        return this.rangeSchedule;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getAddedOnDate() {
        return this.addedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getLiftedOnDate() {
        return this.liftedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOutstandingAmount() {
        return this.outstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Long getVersion() {
        return this.version;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyRange(final DelinquencyRange delinquencyRange) {
        this.delinquencyRange = delinquencyRange;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoan(final WorkingCapitalLoan loan) {
        this.loan = loan;
    }

    @java.lang.SuppressWarnings("all")
        public void setRangeSchedule(final WorkingCapitalLoanDelinquencyRangeSchedule rangeSchedule) {
        this.rangeSchedule = rangeSchedule;
    }

    @java.lang.SuppressWarnings("all")
        public void setAddedOnDate(final LocalDate addedOnDate) {
        this.addedOnDate = addedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setLiftedOnDate(final LocalDate liftedOnDate) {
        this.liftedOnDate = liftedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setOutstandingAmount(final BigDecimal outstandingAmount) {
        this.outstandingAmount = outstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setVersion(final Long version) {
        this.version = version;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanDelinquencyRangeScheduleTagHistory() {
    }
}
