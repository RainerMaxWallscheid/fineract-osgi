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
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;

@Entity
@Table(name = "m_wc_loan_breach_reset_history")
public class WorkingCapitalLoanBreachResetHistory extends AbstractAuditableWithUTCDateTimeCustom<Long> {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "breach_action_id", nullable = false)
    private WorkingCapitalLoanBreachAction breachAction;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "breach_schedule_id", nullable = false)
    private WorkingCapitalLoanBreachSchedule breachSchedule;
    @Column(name = "min_payment_amount", scale = 6, precision = 19)
    private BigDecimal minPaymentAmount;
    @Column(name = "outstanding_amount", scale = 6, precision = 19)
    private BigDecimal outstandingAmount;
    @Column(name = "breach")
    private Boolean breach;
    @Column(name = "near_breach")
    private Boolean nearBreach;

    public WorkingCapitalLoanBreachResetHistory(WorkingCapitalLoanBreachAction resetAction, WorkingCapitalLoanBreachSchedule period) {
        setBreachAction(resetAction);
        setBreachSchedule(period);
        setOutstandingAmount(period.getOutstandingAmount());
        setBreach(period.getBreach());
        setNearBreach(period.getNearBreach());
        setMinPaymentAmount(period.getMinPaymentAmount());
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanBreachAction getBreachAction() {
        return this.breachAction;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanBreachSchedule getBreachSchedule() {
        return this.breachSchedule;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMinPaymentAmount() {
        return this.minPaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOutstandingAmount() {
        return this.outstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getBreach() {
        return this.breach;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getNearBreach() {
        return this.nearBreach;
    }

    @java.lang.SuppressWarnings("all")
        public void setBreachAction(final WorkingCapitalLoanBreachAction breachAction) {
        this.breachAction = breachAction;
    }

    @java.lang.SuppressWarnings("all")
        public void setBreachSchedule(final WorkingCapitalLoanBreachSchedule breachSchedule) {
        this.breachSchedule = breachSchedule;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinPaymentAmount(final BigDecimal minPaymentAmount) {
        this.minPaymentAmount = minPaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setOutstandingAmount(final BigDecimal outstandingAmount) {
        this.outstandingAmount = outstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setBreach(final Boolean breach) {
        this.breach = breach;
    }

    @java.lang.SuppressWarnings("all")
        public void setNearBreach(final Boolean nearBreach) {
        this.nearBreach = nearBreach;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanBreachResetHistory() {
    }
}
