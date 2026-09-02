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
package org.apache.fineract.portfolio.loanaccount.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;

@Entity
@Table(name = "m_loan_approved_amount_history")
public class LoanApprovedAmountHistory extends AbstractAuditableWithUTCDateTimeCustom<Long> {

    @Column(name = "loan_id", nullable = false)
    private Long loanId;
    @Column(name = "new_approved_amount", scale = 6, precision = 19, nullable = false)
    private BigDecimal newApprovedAmount;
    @Column(name = "old_approved_amount", scale = 6, precision = 19, nullable = false)
    private BigDecimal oldApprovedAmount;

    @java.lang.SuppressWarnings("all")
    public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getNewApprovedAmount() {
        return this.newApprovedAmount;
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getOldApprovedAmount() {
        return this.oldApprovedAmount;
    }

    @java.lang.SuppressWarnings("all")
    public void setLoanId(final Long loanId) {
        this.loanId = loanId;
    }

    @java.lang.SuppressWarnings("all")
    public void setNewApprovedAmount(final BigDecimal newApprovedAmount) {
        this.newApprovedAmount = newApprovedAmount;
    }

    @java.lang.SuppressWarnings("all")
    public void setOldApprovedAmount(final BigDecimal oldApprovedAmount) {
        this.oldApprovedAmount = oldApprovedAmount;
    }

    @java.lang.SuppressWarnings("all")
    public LoanApprovedAmountHistory() {}

    @java.lang.SuppressWarnings("all")
    public LoanApprovedAmountHistory(final Long loanId, final BigDecimal newApprovedAmount, final BigDecimal oldApprovedAmount) {
        this.loanId = loanId;
        this.newApprovedAmount = newApprovedAmount;
        this.oldApprovedAmount = oldApprovedAmount;
    }
}
