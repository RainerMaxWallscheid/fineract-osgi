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
package org.apache.fineract.accounting.provisioning.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.util.Objects;
import org.apache.fineract.accounting.glaccount.domain.GLAccount;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.organisation.office.domain.Office;

@Entity
@Table(name = "m_loanproduct_provisioning_entry")
public class LoanProductProvisioningEntry extends AbstractPersistableCustom<Long> {
    @ManyToOne(optional = false)
    @JoinColumn(name = "history_id", referencedColumnName = "id", nullable = false)
    private ProvisioningEntry entry;
    @Column(name = "criteria_id", nullable = false)
    private Long criteriaId;
    @ManyToOne
    @JoinColumn(name = "office_id", nullable = false)
    private Office office;
    @Column(name = "currency_code", length = 3)
    private String currencyCode;
    /**
     * Loan product id (no JPA association to leftover LoanProduct — ADR-021 / charge Step 8).
     */
    @Column(name = "product_id", nullable = false)
    private Long productId;
    /**
     * Provision category id (no JPA association to leftover ProvisioningCategory — ADR-021 / charge Step 8).
     */
    @Column(name = "category_id", nullable = false)
    private Long categoryId;
    @Column(name = "overdue_in_days", nullable = false)
    private Long overdueInDays;
    @Column(name = "reseve_amount", nullable = false)
    private BigDecimal reservedAmount;
    @ManyToOne
    @JoinColumn(name = "liability_account", nullable = false)
    private GLAccount liabilityAccount;
    @ManyToOne
    @JoinColumn(name = "expense_account", nullable = false)
    private GLAccount expenseAccount;

    // TODO Note that this domain class does equals() & hashCode() on getId()
    // for @JoinColumn attributes, which not all other classes do...
    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof LoanProductProvisioningEntry)) {
            return false;
        }
        LoanProductProvisioningEntry other = (LoanProductProvisioningEntry) obj;
        return Objects.equals(other.entry.getId(), this.entry.getId()) && Objects.equals(other.criteriaId, this.criteriaId) && Objects.equals(other.office.getId(), this.office.getId()) && Objects.equals(other.currencyCode, this.currencyCode) && Objects.equals(other.productId, this.productId) && Objects.equals(other.categoryId, this.categoryId) && Objects.equals(other.overdueInDays, this.overdueInDays) && Objects.equals(other.reservedAmount, this.reservedAmount) && Objects.equals(other.liabilityAccount.getId(), this.liabilityAccount.getId()) && Objects.equals(other.expenseAccount.getId(), this.expenseAccount.getId());
    }

    @Override
    public int hashCode() {
        // NOT return Objects.hash(entry, criteriaId, office, currencyCode,
        // productId, categoryId, overdueInDays, reservedAmount,
        // liabilityAccount, expenseAccount);
        // to remain consistent with the implementation in equals(), also use
        // getId() here.
        return Objects.hash(entry.getId(), criteriaId, office.getId(), currencyCode, productId, categoryId, overdueInDays, reservedAmount, liabilityAccount.getId(), expenseAccount.getId());
    }

    public int partialHashCode() {
        // this is used to group together all the entries that have similar parameters (excluding the amount reserved)
        // rather than a check for if the objects are the same based on their values, this tells if they are similar
        return Objects.hash(entry.getId(), criteriaId, office.getId(), currencyCode, productId, categoryId, overdueInDays, liabilityAccount.getId(), expenseAccount.getId());
    }

    @java.lang.SuppressWarnings("all")
        public ProvisioningEntry getEntry() {
        return this.entry;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCriteriaId() {
        return this.criteriaId;
    }

    @java.lang.SuppressWarnings("all")
        public Office getOffice() {
        return this.office;
    }

    @java.lang.SuppressWarnings("all")
        public String getCurrencyCode() {
        return this.currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public Long getProductId() {
        return this.productId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCategoryId() {
        return this.categoryId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOverdueInDays() {
        return this.overdueInDays;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getReservedAmount() {
        return this.reservedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public GLAccount getLiabilityAccount() {
        return this.liabilityAccount;
    }

    @java.lang.SuppressWarnings("all")
        public GLAccount getExpenseAccount() {
        return this.expenseAccount;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntry setEntry(final ProvisioningEntry entry) {
        this.entry = entry;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntry setCriteriaId(final Long criteriaId) {
        this.criteriaId = criteriaId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntry setOffice(final Office office) {
        this.office = office;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntry setCurrencyCode(final String currencyCode) {
        this.currencyCode = currencyCode;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntry setProductId(final Long productId) {
        this.productId = productId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntry setCategoryId(final Long categoryId) {
        this.categoryId = categoryId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntry setOverdueInDays(final Long overdueInDays) {
        this.overdueInDays = overdueInDays;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntry setReservedAmount(final BigDecimal reservedAmount) {
        this.reservedAmount = reservedAmount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntry setLiabilityAccount(final GLAccount liabilityAccount) {
        this.liabilityAccount = liabilityAccount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntry setExpenseAccount(final GLAccount expenseAccount) {
        this.expenseAccount = expenseAccount;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntry() {
    }
}
