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
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;

@Entity
@Table(name = "m_wc_loan_near_breach_action")
public class WorkingCapitalLoanNearBreachAction extends AbstractAuditableWithUTCDateTimeCustom<Long> {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "wc_loan_id", nullable = false)
    private WorkingCapitalLoan workingCapitalLoan;
    @Enumerated(EnumType.STRING)
    @Column(name = "action", nullable = false)
    private NearBreachActionType action;
    @Column(name = "threshold", scale = 6, precision = 19)
    private BigDecimal threshold;
    @Column(name = "frequency")
    private Integer frequency;
    @Enumerated(EnumType.STRING)
    @Column(name = "frequency_type")
    private WorkingCapitalLoanPeriodFrequencyType frequencyType;

    public static WorkingCapitalLoanNearBreachAction create(final WorkingCapitalLoan loan, final NearBreachActionType action, final BigDecimal threshold, final Integer frequency, final WorkingCapitalLoanPeriodFrequencyType frequencyType) {
        final WorkingCapitalLoanNearBreachAction entity = new WorkingCapitalLoanNearBreachAction();
        entity.workingCapitalLoan = loan;
        entity.action = action;
        entity.threshold = threshold;
        entity.frequency = frequency;
        entity.frequencyType = frequencyType;
        return entity;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoan getWorkingCapitalLoan() {
        return this.workingCapitalLoan;
    }

    @java.lang.SuppressWarnings("all")
        public NearBreachActionType getAction() {
        return this.action;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getThreshold() {
        return this.threshold;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getFrequency() {
        return this.frequency;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanPeriodFrequencyType getFrequencyType() {
        return this.frequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public void setWorkingCapitalLoan(final WorkingCapitalLoan workingCapitalLoan) {
        this.workingCapitalLoan = workingCapitalLoan;
    }

    @java.lang.SuppressWarnings("all")
        public void setAction(final NearBreachActionType action) {
        this.action = action;
    }

    @java.lang.SuppressWarnings("all")
        public void setThreshold(final BigDecimal threshold) {
        this.threshold = threshold;
    }

    @java.lang.SuppressWarnings("all")
        public void setFrequency(final Integer frequency) {
        this.frequency = frequency;
    }

    @java.lang.SuppressWarnings("all")
        public void setFrequencyType(final WorkingCapitalLoanPeriodFrequencyType frequencyType) {
        this.frequencyType = frequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanNearBreachAction() {
    }
}
