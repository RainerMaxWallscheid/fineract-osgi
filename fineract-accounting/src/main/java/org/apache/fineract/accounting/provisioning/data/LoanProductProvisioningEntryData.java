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
package org.apache.fineract.accounting.provisioning.data;

import java.math.BigDecimal;

public class LoanProductProvisioningEntryData {
    private Long historyId;
    private Long officeId;
    private String officeName;
    private String currencyCode;
    private Long productId;
    private String productName;
    private Long categoryId;
    private String categoryName;
    private Long overdueInDays;
    private BigDecimal percentage;
    private BigDecimal balance;
    private BigDecimal amountreserved;
    private Long liablityAccount;
    private String liabilityAccountCode;
    private String liabilityAccountName;
    private Long expenseAccount;
    private String expenseAccountCode;
    private String expenseAccountName;
    private Long criteriaId;

    @java.lang.SuppressWarnings("all")
        public Long getHistoryId() {
        return this.historyId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getOfficeName() {
        return this.officeName;
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
        public String getProductName() {
        return this.productName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCategoryId() {
        return this.categoryId;
    }

    @java.lang.SuppressWarnings("all")
        public String getCategoryName() {
        return this.categoryName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOverdueInDays() {
        return this.overdueInDays;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPercentage() {
        return this.percentage;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getBalance() {
        return this.balance;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountreserved() {
        return this.amountreserved;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLiablityAccount() {
        return this.liablityAccount;
    }

    @java.lang.SuppressWarnings("all")
        public String getLiabilityAccountCode() {
        return this.liabilityAccountCode;
    }

    @java.lang.SuppressWarnings("all")
        public String getLiabilityAccountName() {
        return this.liabilityAccountName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getExpenseAccount() {
        return this.expenseAccount;
    }

    @java.lang.SuppressWarnings("all")
        public String getExpenseAccountCode() {
        return this.expenseAccountCode;
    }

    @java.lang.SuppressWarnings("all")
        public String getExpenseAccountName() {
        return this.expenseAccountName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCriteriaId() {
        return this.criteriaId;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setHistoryId(final Long historyId) {
        this.historyId = historyId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setOfficeId(final Long officeId) {
        this.officeId = officeId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setOfficeName(final String officeName) {
        this.officeName = officeName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setCurrencyCode(final String currencyCode) {
        this.currencyCode = currencyCode;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setProductId(final Long productId) {
        this.productId = productId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setProductName(final String productName) {
        this.productName = productName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setCategoryId(final Long categoryId) {
        this.categoryId = categoryId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setCategoryName(final String categoryName) {
        this.categoryName = categoryName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setOverdueInDays(final Long overdueInDays) {
        this.overdueInDays = overdueInDays;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setPercentage(final BigDecimal percentage) {
        this.percentage = percentage;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setBalance(final BigDecimal balance) {
        this.balance = balance;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setAmountreserved(final BigDecimal amountreserved) {
        this.amountreserved = amountreserved;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setLiablityAccount(final Long liablityAccount) {
        this.liablityAccount = liablityAccount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setLiabilityAccountCode(final String liabilityAccountCode) {
        this.liabilityAccountCode = liabilityAccountCode;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setLiabilityAccountName(final String liabilityAccountName) {
        this.liabilityAccountName = liabilityAccountName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setExpenseAccount(final Long expenseAccount) {
        this.expenseAccount = expenseAccount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setExpenseAccountCode(final String expenseAccountCode) {
        this.expenseAccountCode = expenseAccountCode;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setExpenseAccountName(final String expenseAccountName) {
        this.expenseAccountName = expenseAccountName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData setCriteriaId(final Long criteriaId) {
        this.criteriaId = criteriaId;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanProductProvisioningEntryData)) return false;
        final LoanProductProvisioningEntryData other = (LoanProductProvisioningEntryData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$historyId = this.getHistoryId();
        final java.lang.Object other$historyId = other.getHistoryId();
        if (this$historyId == null ? other$historyId != null : !this$historyId.equals(other$historyId)) return false;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$productId = this.getProductId();
        final java.lang.Object other$productId = other.getProductId();
        if (this$productId == null ? other$productId != null : !this$productId.equals(other$productId)) return false;
        final java.lang.Object this$categoryId = this.getCategoryId();
        final java.lang.Object other$categoryId = other.getCategoryId();
        if (this$categoryId == null ? other$categoryId != null : !this$categoryId.equals(other$categoryId)) return false;
        final java.lang.Object this$overdueInDays = this.getOverdueInDays();
        final java.lang.Object other$overdueInDays = other.getOverdueInDays();
        if (this$overdueInDays == null ? other$overdueInDays != null : !this$overdueInDays.equals(other$overdueInDays)) return false;
        final java.lang.Object this$liablityAccount = this.getLiablityAccount();
        final java.lang.Object other$liablityAccount = other.getLiablityAccount();
        if (this$liablityAccount == null ? other$liablityAccount != null : !this$liablityAccount.equals(other$liablityAccount)) return false;
        final java.lang.Object this$expenseAccount = this.getExpenseAccount();
        final java.lang.Object other$expenseAccount = other.getExpenseAccount();
        if (this$expenseAccount == null ? other$expenseAccount != null : !this$expenseAccount.equals(other$expenseAccount)) return false;
        final java.lang.Object this$criteriaId = this.getCriteriaId();
        final java.lang.Object other$criteriaId = other.getCriteriaId();
        if (this$criteriaId == null ? other$criteriaId != null : !this$criteriaId.equals(other$criteriaId)) return false;
        final java.lang.Object this$officeName = this.getOfficeName();
        final java.lang.Object other$officeName = other.getOfficeName();
        if (this$officeName == null ? other$officeName != null : !this$officeName.equals(other$officeName)) return false;
        final java.lang.Object this$currencyCode = this.getCurrencyCode();
        final java.lang.Object other$currencyCode = other.getCurrencyCode();
        if (this$currencyCode == null ? other$currencyCode != null : !this$currencyCode.equals(other$currencyCode)) return false;
        final java.lang.Object this$productName = this.getProductName();
        final java.lang.Object other$productName = other.getProductName();
        if (this$productName == null ? other$productName != null : !this$productName.equals(other$productName)) return false;
        final java.lang.Object this$categoryName = this.getCategoryName();
        final java.lang.Object other$categoryName = other.getCategoryName();
        if (this$categoryName == null ? other$categoryName != null : !this$categoryName.equals(other$categoryName)) return false;
        final java.lang.Object this$percentage = this.getPercentage();
        final java.lang.Object other$percentage = other.getPercentage();
        if (this$percentage == null ? other$percentage != null : !this$percentage.equals(other$percentage)) return false;
        final java.lang.Object this$balance = this.getBalance();
        final java.lang.Object other$balance = other.getBalance();
        if (this$balance == null ? other$balance != null : !this$balance.equals(other$balance)) return false;
        final java.lang.Object this$amountreserved = this.getAmountreserved();
        final java.lang.Object other$amountreserved = other.getAmountreserved();
        if (this$amountreserved == null ? other$amountreserved != null : !this$amountreserved.equals(other$amountreserved)) return false;
        final java.lang.Object this$liabilityAccountCode = this.getLiabilityAccountCode();
        final java.lang.Object other$liabilityAccountCode = other.getLiabilityAccountCode();
        if (this$liabilityAccountCode == null ? other$liabilityAccountCode != null : !this$liabilityAccountCode.equals(other$liabilityAccountCode)) return false;
        final java.lang.Object this$liabilityAccountName = this.getLiabilityAccountName();
        final java.lang.Object other$liabilityAccountName = other.getLiabilityAccountName();
        if (this$liabilityAccountName == null ? other$liabilityAccountName != null : !this$liabilityAccountName.equals(other$liabilityAccountName)) return false;
        final java.lang.Object this$expenseAccountCode = this.getExpenseAccountCode();
        final java.lang.Object other$expenseAccountCode = other.getExpenseAccountCode();
        if (this$expenseAccountCode == null ? other$expenseAccountCode != null : !this$expenseAccountCode.equals(other$expenseAccountCode)) return false;
        final java.lang.Object this$expenseAccountName = this.getExpenseAccountName();
        final java.lang.Object other$expenseAccountName = other.getExpenseAccountName();
        if (this$expenseAccountName == null ? other$expenseAccountName != null : !this$expenseAccountName.equals(other$expenseAccountName)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanProductProvisioningEntryData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $historyId = this.getHistoryId();
        result = result * PRIME + ($historyId == null ? 43 : $historyId.hashCode());
        final java.lang.Object $officeId = this.getOfficeId();
        result = result * PRIME + ($officeId == null ? 43 : $officeId.hashCode());
        final java.lang.Object $productId = this.getProductId();
        result = result * PRIME + ($productId == null ? 43 : $productId.hashCode());
        final java.lang.Object $categoryId = this.getCategoryId();
        result = result * PRIME + ($categoryId == null ? 43 : $categoryId.hashCode());
        final java.lang.Object $overdueInDays = this.getOverdueInDays();
        result = result * PRIME + ($overdueInDays == null ? 43 : $overdueInDays.hashCode());
        final java.lang.Object $liablityAccount = this.getLiablityAccount();
        result = result * PRIME + ($liablityAccount == null ? 43 : $liablityAccount.hashCode());
        final java.lang.Object $expenseAccount = this.getExpenseAccount();
        result = result * PRIME + ($expenseAccount == null ? 43 : $expenseAccount.hashCode());
        final java.lang.Object $criteriaId = this.getCriteriaId();
        result = result * PRIME + ($criteriaId == null ? 43 : $criteriaId.hashCode());
        final java.lang.Object $officeName = this.getOfficeName();
        result = result * PRIME + ($officeName == null ? 43 : $officeName.hashCode());
        final java.lang.Object $currencyCode = this.getCurrencyCode();
        result = result * PRIME + ($currencyCode == null ? 43 : $currencyCode.hashCode());
        final java.lang.Object $productName = this.getProductName();
        result = result * PRIME + ($productName == null ? 43 : $productName.hashCode());
        final java.lang.Object $categoryName = this.getCategoryName();
        result = result * PRIME + ($categoryName == null ? 43 : $categoryName.hashCode());
        final java.lang.Object $percentage = this.getPercentage();
        result = result * PRIME + ($percentage == null ? 43 : $percentage.hashCode());
        final java.lang.Object $balance = this.getBalance();
        result = result * PRIME + ($balance == null ? 43 : $balance.hashCode());
        final java.lang.Object $amountreserved = this.getAmountreserved();
        result = result * PRIME + ($amountreserved == null ? 43 : $amountreserved.hashCode());
        final java.lang.Object $liabilityAccountCode = this.getLiabilityAccountCode();
        result = result * PRIME + ($liabilityAccountCode == null ? 43 : $liabilityAccountCode.hashCode());
        final java.lang.Object $liabilityAccountName = this.getLiabilityAccountName();
        result = result * PRIME + ($liabilityAccountName == null ? 43 : $liabilityAccountName.hashCode());
        final java.lang.Object $expenseAccountCode = this.getExpenseAccountCode();
        result = result * PRIME + ($expenseAccountCode == null ? 43 : $expenseAccountCode.hashCode());
        final java.lang.Object $expenseAccountName = this.getExpenseAccountName();
        result = result * PRIME + ($expenseAccountName == null ? 43 : $expenseAccountName.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanProductProvisioningEntryData(historyId=" + this.getHistoryId() + ", officeId=" + this.getOfficeId() + ", officeName=" + this.getOfficeName() + ", currencyCode=" + this.getCurrencyCode() + ", productId=" + this.getProductId() + ", productName=" + this.getProductName() + ", categoryId=" + this.getCategoryId() + ", categoryName=" + this.getCategoryName() + ", overdueInDays=" + this.getOverdueInDays() + ", percentage=" + this.getPercentage() + ", balance=" + this.getBalance() + ", amountreserved=" + this.getAmountreserved() + ", liablityAccount=" + this.getLiablityAccount() + ", liabilityAccountCode=" + this.getLiabilityAccountCode() + ", liabilityAccountName=" + this.getLiabilityAccountName() + ", expenseAccount=" + this.getExpenseAccount() + ", expenseAccountCode=" + this.getExpenseAccountCode() + ", expenseAccountName=" + this.getExpenseAccountName() + ", criteriaId=" + this.getCriteriaId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanProductProvisioningEntryData() {
    }
}
