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
package org.apache.fineract.accounting.glaccount.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Objects;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.infrastructure.core.service.DateUtils;

@Entity
@Table(name = "m_trial_balance")
public class TrialBalance extends AbstractPersistableCustom<Long> {
    @Column(name = "office_id", nullable = false)
    private Long officeId;
    @Column(name = "account_id", nullable = false)
    private Long glAccountId;
    @Column(name = "amount", nullable = false)
    private BigDecimal amount;
    @Column(name = "entry_date", nullable = false)
    private LocalDate entryDate;
    @Column(name = "created_date", nullable = true)
    private LocalDate transactionDate;
    @Column(name = "closing_balance", nullable = false)
    private BigDecimal closingBalance;

    public static TrialBalance getInstance(final Long officeId, final Long glAccountId, final BigDecimal amount, final LocalDate entryDate, final LocalDate transactionDate) {
        return new TrialBalance().setOfficeId(officeId).setGlAccountId(glAccountId).setAmount(amount).setEntryDate(entryDate).setTransactionDate(transactionDate);
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof TrialBalance)) {
            return false;
        }
        TrialBalance other = (TrialBalance) obj;
        return Objects.equals(other.officeId, officeId) && Objects.equals(other.glAccountId, glAccountId) && Objects.equals(other.amount, amount) && DateUtils.isEqual(other.entryDate, entryDate) && DateUtils.isEqual(other.transactionDate, transactionDate) && Objects.equals(other.closingBalance, closingBalance);
    }

    @Override
    public int hashCode() {
        return Objects.hash(officeId, glAccountId, amount, entryDate, transactionDate, closingBalance);
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getGlAccountId() {
        return this.glAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getEntryDate() {
        return this.entryDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getTransactionDate() {
        return this.transactionDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getClosingBalance() {
        return this.closingBalance;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TrialBalance setOfficeId(final Long officeId) {
        this.officeId = officeId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TrialBalance setGlAccountId(final Long glAccountId) {
        this.glAccountId = glAccountId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TrialBalance setAmount(final BigDecimal amount) {
        this.amount = amount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TrialBalance setEntryDate(final LocalDate entryDate) {
        this.entryDate = entryDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TrialBalance setTransactionDate(final LocalDate transactionDate) {
        this.transactionDate = transactionDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TrialBalance setClosingBalance(final BigDecimal closingBalance) {
        this.closingBalance = closingBalance;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public TrialBalance() {
    }
}
