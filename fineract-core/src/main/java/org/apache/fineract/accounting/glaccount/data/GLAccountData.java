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
package org.apache.fineract.accounting.glaccount.data;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import org.apache.fineract.accounting.common.AccountingEnumerations;
import org.apache.fineract.accounting.glaccount.domain.GLAccountType;
import org.apache.fineract.accounting.glaccount.domain.GLAccountUsage;
import org.apache.fineract.infrastructure.codes.data.CodeValueData;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;

/**
 * Immutable object representing a General Ledger Account
 *
 * Note: no getter/setters required as google-gson will produce json from fields of object.
 */
public class GLAccountData implements Serializable {
    private Long id;
    private String name;
    private Long parentId;
    private String glCode;
    private Boolean disabled;
    private Boolean manualEntriesAllowed;
    private EnumOptionData type;
    private EnumOptionData usage;
    private String description;
    private String nameDecorated;
    private CodeValueData tagId;
    private Long organizationRunningBalance;
    // templates
    private List<EnumOptionData> accountTypeOptions;
    private List<EnumOptionData> usageOptions;
    private List<GLAccountData> assetHeaderAccountOptions;
    private List<GLAccountData> liabilityHeaderAccountOptions;
    private List<GLAccountData> equityHeaderAccountOptions;
    private List<GLAccountData> incomeHeaderAccountOptions;
    private List<GLAccountData> expenseHeaderAccountOptions;
    private Collection<CodeValueData> allowedAssetsTagOptions;
    private Collection<CodeValueData> allowedLiabilitiesTagOptions;
    private Collection<CodeValueData> allowedEquityTagOptions;
    private Collection<CodeValueData> allowedIncomeTagOptions;
    private Collection<CodeValueData> allowedExpensesTagOptions;
    // import fields
    private transient Integer rowIndex;

    public static GLAccountData importInstance(String name, Long parentId, String glCode, Boolean manualEntriesAllowed, EnumOptionData type, EnumOptionData usage, String description, CodeValueData tagId, Integer rowIndex) {
        return new GLAccountData().setName(name).setParentId(parentId).setGlCode(glCode).setManualEntriesAllowed(manualEntriesAllowed).setType(type).setUsage(usage).setDescription(description).setTagId(tagId).setRowIndex(rowIndex);
    }

    public static GLAccountData createFrom(final Long id) {
        return new GLAccountData().setId(id);
    }

    public static GLAccountData sensibleDefaultsForNewGLAccountCreation(final Integer glAccType) {
        final boolean disabled = false;
        final boolean manualEntriesAllowed = true;
        final EnumOptionData type;
        if (glAccType != null && glAccType >= GLAccountType.getMinValue() && glAccType <= GLAccountType.getMaxValue()) {
            type = AccountingEnumerations.gLAccountType(glAccType);
        } else {
            type = AccountingEnumerations.gLAccountType(GLAccountType.ASSET);
        }
        final EnumOptionData usage = AccountingEnumerations.gLAccountUsage(GLAccountUsage.DETAIL);
        return new GLAccountData().setDisabled(disabled).setManualEntriesAllowed(manualEntriesAllowed).setType(type).setUsage(usage);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public Long getParentId() {
        return this.parentId;
    }

    @java.lang.SuppressWarnings("all")
        public String getGlCode() {
        return this.glCode;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getDisabled() {
        return this.disabled;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getManualEntriesAllowed() {
        return this.manualEntriesAllowed;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getUsage() {
        return this.usage;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public String getNameDecorated() {
        return this.nameDecorated;
    }

    @java.lang.SuppressWarnings("all")
        public CodeValueData getTagId() {
        return this.tagId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOrganizationRunningBalance() {
        return this.organizationRunningBalance;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getAccountTypeOptions() {
        return this.accountTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getUsageOptions() {
        return this.usageOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<GLAccountData> getAssetHeaderAccountOptions() {
        return this.assetHeaderAccountOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<GLAccountData> getLiabilityHeaderAccountOptions() {
        return this.liabilityHeaderAccountOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<GLAccountData> getEquityHeaderAccountOptions() {
        return this.equityHeaderAccountOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<GLAccountData> getIncomeHeaderAccountOptions() {
        return this.incomeHeaderAccountOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<GLAccountData> getExpenseHeaderAccountOptions() {
        return this.expenseHeaderAccountOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getAllowedAssetsTagOptions() {
        return this.allowedAssetsTagOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getAllowedLiabilitiesTagOptions() {
        return this.allowedLiabilitiesTagOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getAllowedEquityTagOptions() {
        return this.allowedEquityTagOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getAllowedIncomeTagOptions() {
        return this.allowedIncomeTagOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getAllowedExpensesTagOptions() {
        return this.allowedExpensesTagOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRowIndex() {
        return this.rowIndex;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setParentId(final Long parentId) {
        this.parentId = parentId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setGlCode(final String glCode) {
        this.glCode = glCode;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setDisabled(final Boolean disabled) {
        this.disabled = disabled;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setManualEntriesAllowed(final Boolean manualEntriesAllowed) {
        this.manualEntriesAllowed = manualEntriesAllowed;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setType(final EnumOptionData type) {
        this.type = type;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setUsage(final EnumOptionData usage) {
        this.usage = usage;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setDescription(final String description) {
        this.description = description;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setNameDecorated(final String nameDecorated) {
        this.nameDecorated = nameDecorated;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setTagId(final CodeValueData tagId) {
        this.tagId = tagId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setOrganizationRunningBalance(final Long organizationRunningBalance) {
        this.organizationRunningBalance = organizationRunningBalance;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setAccountTypeOptions(final List<EnumOptionData> accountTypeOptions) {
        this.accountTypeOptions = accountTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setUsageOptions(final List<EnumOptionData> usageOptions) {
        this.usageOptions = usageOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setAssetHeaderAccountOptions(final List<GLAccountData> assetHeaderAccountOptions) {
        this.assetHeaderAccountOptions = assetHeaderAccountOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setLiabilityHeaderAccountOptions(final List<GLAccountData> liabilityHeaderAccountOptions) {
        this.liabilityHeaderAccountOptions = liabilityHeaderAccountOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setEquityHeaderAccountOptions(final List<GLAccountData> equityHeaderAccountOptions) {
        this.equityHeaderAccountOptions = equityHeaderAccountOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setIncomeHeaderAccountOptions(final List<GLAccountData> incomeHeaderAccountOptions) {
        this.incomeHeaderAccountOptions = incomeHeaderAccountOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setExpenseHeaderAccountOptions(final List<GLAccountData> expenseHeaderAccountOptions) {
        this.expenseHeaderAccountOptions = expenseHeaderAccountOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setAllowedAssetsTagOptions(final Collection<CodeValueData> allowedAssetsTagOptions) {
        this.allowedAssetsTagOptions = allowedAssetsTagOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setAllowedLiabilitiesTagOptions(final Collection<CodeValueData> allowedLiabilitiesTagOptions) {
        this.allowedLiabilitiesTagOptions = allowedLiabilitiesTagOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setAllowedEquityTagOptions(final Collection<CodeValueData> allowedEquityTagOptions) {
        this.allowedEquityTagOptions = allowedEquityTagOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setAllowedIncomeTagOptions(final Collection<CodeValueData> allowedIncomeTagOptions) {
        this.allowedIncomeTagOptions = allowedIncomeTagOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setAllowedExpensesTagOptions(final Collection<CodeValueData> allowedExpensesTagOptions) {
        this.allowedExpensesTagOptions = allowedExpensesTagOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GLAccountData setRowIndex(final Integer rowIndex) {
        this.rowIndex = rowIndex;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof GLAccountData)) return false;
        final GLAccountData other = (GLAccountData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$parentId = this.getParentId();
        final java.lang.Object other$parentId = other.getParentId();
        if (this$parentId == null ? other$parentId != null : !this$parentId.equals(other$parentId)) return false;
        final java.lang.Object this$disabled = this.getDisabled();
        final java.lang.Object other$disabled = other.getDisabled();
        if (this$disabled == null ? other$disabled != null : !this$disabled.equals(other$disabled)) return false;
        final java.lang.Object this$manualEntriesAllowed = this.getManualEntriesAllowed();
        final java.lang.Object other$manualEntriesAllowed = other.getManualEntriesAllowed();
        if (this$manualEntriesAllowed == null ? other$manualEntriesAllowed != null : !this$manualEntriesAllowed.equals(other$manualEntriesAllowed)) return false;
        final java.lang.Object this$organizationRunningBalance = this.getOrganizationRunningBalance();
        final java.lang.Object other$organizationRunningBalance = other.getOrganizationRunningBalance();
        if (this$organizationRunningBalance == null ? other$organizationRunningBalance != null : !this$organizationRunningBalance.equals(other$organizationRunningBalance)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$glCode = this.getGlCode();
        final java.lang.Object other$glCode = other.getGlCode();
        if (this$glCode == null ? other$glCode != null : !this$glCode.equals(other$glCode)) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final java.lang.Object this$usage = this.getUsage();
        final java.lang.Object other$usage = other.getUsage();
        if (this$usage == null ? other$usage != null : !this$usage.equals(other$usage)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        final java.lang.Object this$nameDecorated = this.getNameDecorated();
        final java.lang.Object other$nameDecorated = other.getNameDecorated();
        if (this$nameDecorated == null ? other$nameDecorated != null : !this$nameDecorated.equals(other$nameDecorated)) return false;
        final java.lang.Object this$tagId = this.getTagId();
        final java.lang.Object other$tagId = other.getTagId();
        if (this$tagId == null ? other$tagId != null : !this$tagId.equals(other$tagId)) return false;
        final java.lang.Object this$accountTypeOptions = this.getAccountTypeOptions();
        final java.lang.Object other$accountTypeOptions = other.getAccountTypeOptions();
        if (this$accountTypeOptions == null ? other$accountTypeOptions != null : !this$accountTypeOptions.equals(other$accountTypeOptions)) return false;
        final java.lang.Object this$usageOptions = this.getUsageOptions();
        final java.lang.Object other$usageOptions = other.getUsageOptions();
        if (this$usageOptions == null ? other$usageOptions != null : !this$usageOptions.equals(other$usageOptions)) return false;
        final java.lang.Object this$assetHeaderAccountOptions = this.getAssetHeaderAccountOptions();
        final java.lang.Object other$assetHeaderAccountOptions = other.getAssetHeaderAccountOptions();
        if (this$assetHeaderAccountOptions == null ? other$assetHeaderAccountOptions != null : !this$assetHeaderAccountOptions.equals(other$assetHeaderAccountOptions)) return false;
        final java.lang.Object this$liabilityHeaderAccountOptions = this.getLiabilityHeaderAccountOptions();
        final java.lang.Object other$liabilityHeaderAccountOptions = other.getLiabilityHeaderAccountOptions();
        if (this$liabilityHeaderAccountOptions == null ? other$liabilityHeaderAccountOptions != null : !this$liabilityHeaderAccountOptions.equals(other$liabilityHeaderAccountOptions)) return false;
        final java.lang.Object this$equityHeaderAccountOptions = this.getEquityHeaderAccountOptions();
        final java.lang.Object other$equityHeaderAccountOptions = other.getEquityHeaderAccountOptions();
        if (this$equityHeaderAccountOptions == null ? other$equityHeaderAccountOptions != null : !this$equityHeaderAccountOptions.equals(other$equityHeaderAccountOptions)) return false;
        final java.lang.Object this$incomeHeaderAccountOptions = this.getIncomeHeaderAccountOptions();
        final java.lang.Object other$incomeHeaderAccountOptions = other.getIncomeHeaderAccountOptions();
        if (this$incomeHeaderAccountOptions == null ? other$incomeHeaderAccountOptions != null : !this$incomeHeaderAccountOptions.equals(other$incomeHeaderAccountOptions)) return false;
        final java.lang.Object this$expenseHeaderAccountOptions = this.getExpenseHeaderAccountOptions();
        final java.lang.Object other$expenseHeaderAccountOptions = other.getExpenseHeaderAccountOptions();
        if (this$expenseHeaderAccountOptions == null ? other$expenseHeaderAccountOptions != null : !this$expenseHeaderAccountOptions.equals(other$expenseHeaderAccountOptions)) return false;
        final java.lang.Object this$allowedAssetsTagOptions = this.getAllowedAssetsTagOptions();
        final java.lang.Object other$allowedAssetsTagOptions = other.getAllowedAssetsTagOptions();
        if (this$allowedAssetsTagOptions == null ? other$allowedAssetsTagOptions != null : !this$allowedAssetsTagOptions.equals(other$allowedAssetsTagOptions)) return false;
        final java.lang.Object this$allowedLiabilitiesTagOptions = this.getAllowedLiabilitiesTagOptions();
        final java.lang.Object other$allowedLiabilitiesTagOptions = other.getAllowedLiabilitiesTagOptions();
        if (this$allowedLiabilitiesTagOptions == null ? other$allowedLiabilitiesTagOptions != null : !this$allowedLiabilitiesTagOptions.equals(other$allowedLiabilitiesTagOptions)) return false;
        final java.lang.Object this$allowedEquityTagOptions = this.getAllowedEquityTagOptions();
        final java.lang.Object other$allowedEquityTagOptions = other.getAllowedEquityTagOptions();
        if (this$allowedEquityTagOptions == null ? other$allowedEquityTagOptions != null : !this$allowedEquityTagOptions.equals(other$allowedEquityTagOptions)) return false;
        final java.lang.Object this$allowedIncomeTagOptions = this.getAllowedIncomeTagOptions();
        final java.lang.Object other$allowedIncomeTagOptions = other.getAllowedIncomeTagOptions();
        if (this$allowedIncomeTagOptions == null ? other$allowedIncomeTagOptions != null : !this$allowedIncomeTagOptions.equals(other$allowedIncomeTagOptions)) return false;
        final java.lang.Object this$allowedExpensesTagOptions = this.getAllowedExpensesTagOptions();
        final java.lang.Object other$allowedExpensesTagOptions = other.getAllowedExpensesTagOptions();
        if (this$allowedExpensesTagOptions == null ? other$allowedExpensesTagOptions != null : !this$allowedExpensesTagOptions.equals(other$allowedExpensesTagOptions)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof GLAccountData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $parentId = this.getParentId();
        result = result * PRIME + ($parentId == null ? 43 : $parentId.hashCode());
        final java.lang.Object $disabled = this.getDisabled();
        result = result * PRIME + ($disabled == null ? 43 : $disabled.hashCode());
        final java.lang.Object $manualEntriesAllowed = this.getManualEntriesAllowed();
        result = result * PRIME + ($manualEntriesAllowed == null ? 43 : $manualEntriesAllowed.hashCode());
        final java.lang.Object $organizationRunningBalance = this.getOrganizationRunningBalance();
        result = result * PRIME + ($organizationRunningBalance == null ? 43 : $organizationRunningBalance.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $glCode = this.getGlCode();
        result = result * PRIME + ($glCode == null ? 43 : $glCode.hashCode());
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final java.lang.Object $usage = this.getUsage();
        result = result * PRIME + ($usage == null ? 43 : $usage.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        final java.lang.Object $nameDecorated = this.getNameDecorated();
        result = result * PRIME + ($nameDecorated == null ? 43 : $nameDecorated.hashCode());
        final java.lang.Object $tagId = this.getTagId();
        result = result * PRIME + ($tagId == null ? 43 : $tagId.hashCode());
        final java.lang.Object $accountTypeOptions = this.getAccountTypeOptions();
        result = result * PRIME + ($accountTypeOptions == null ? 43 : $accountTypeOptions.hashCode());
        final java.lang.Object $usageOptions = this.getUsageOptions();
        result = result * PRIME + ($usageOptions == null ? 43 : $usageOptions.hashCode());
        final java.lang.Object $assetHeaderAccountOptions = this.getAssetHeaderAccountOptions();
        result = result * PRIME + ($assetHeaderAccountOptions == null ? 43 : $assetHeaderAccountOptions.hashCode());
        final java.lang.Object $liabilityHeaderAccountOptions = this.getLiabilityHeaderAccountOptions();
        result = result * PRIME + ($liabilityHeaderAccountOptions == null ? 43 : $liabilityHeaderAccountOptions.hashCode());
        final java.lang.Object $equityHeaderAccountOptions = this.getEquityHeaderAccountOptions();
        result = result * PRIME + ($equityHeaderAccountOptions == null ? 43 : $equityHeaderAccountOptions.hashCode());
        final java.lang.Object $incomeHeaderAccountOptions = this.getIncomeHeaderAccountOptions();
        result = result * PRIME + ($incomeHeaderAccountOptions == null ? 43 : $incomeHeaderAccountOptions.hashCode());
        final java.lang.Object $expenseHeaderAccountOptions = this.getExpenseHeaderAccountOptions();
        result = result * PRIME + ($expenseHeaderAccountOptions == null ? 43 : $expenseHeaderAccountOptions.hashCode());
        final java.lang.Object $allowedAssetsTagOptions = this.getAllowedAssetsTagOptions();
        result = result * PRIME + ($allowedAssetsTagOptions == null ? 43 : $allowedAssetsTagOptions.hashCode());
        final java.lang.Object $allowedLiabilitiesTagOptions = this.getAllowedLiabilitiesTagOptions();
        result = result * PRIME + ($allowedLiabilitiesTagOptions == null ? 43 : $allowedLiabilitiesTagOptions.hashCode());
        final java.lang.Object $allowedEquityTagOptions = this.getAllowedEquityTagOptions();
        result = result * PRIME + ($allowedEquityTagOptions == null ? 43 : $allowedEquityTagOptions.hashCode());
        final java.lang.Object $allowedIncomeTagOptions = this.getAllowedIncomeTagOptions();
        result = result * PRIME + ($allowedIncomeTagOptions == null ? 43 : $allowedIncomeTagOptions.hashCode());
        final java.lang.Object $allowedExpensesTagOptions = this.getAllowedExpensesTagOptions();
        result = result * PRIME + ($allowedExpensesTagOptions == null ? 43 : $allowedExpensesTagOptions.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "GLAccountData(id=" + this.getId() + ", name=" + this.getName() + ", parentId=" + this.getParentId() + ", glCode=" + this.getGlCode() + ", disabled=" + this.getDisabled() + ", manualEntriesAllowed=" + this.getManualEntriesAllowed() + ", type=" + this.getType() + ", usage=" + this.getUsage() + ", description=" + this.getDescription() + ", nameDecorated=" + this.getNameDecorated() + ", tagId=" + this.getTagId() + ", organizationRunningBalance=" + this.getOrganizationRunningBalance() + ", accountTypeOptions=" + this.getAccountTypeOptions() + ", usageOptions=" + this.getUsageOptions() + ", assetHeaderAccountOptions=" + this.getAssetHeaderAccountOptions() + ", liabilityHeaderAccountOptions=" + this.getLiabilityHeaderAccountOptions() + ", equityHeaderAccountOptions=" + this.getEquityHeaderAccountOptions() + ", incomeHeaderAccountOptions=" + this.getIncomeHeaderAccountOptions() + ", expenseHeaderAccountOptions=" + this.getExpenseHeaderAccountOptions() + ", allowedAssetsTagOptions=" + this.getAllowedAssetsTagOptions() + ", allowedLiabilitiesTagOptions=" + this.getAllowedLiabilitiesTagOptions() + ", allowedEquityTagOptions=" + this.getAllowedEquityTagOptions() + ", allowedIncomeTagOptions=" + this.getAllowedIncomeTagOptions() + ", allowedExpensesTagOptions=" + this.getAllowedExpensesTagOptions() + ", rowIndex=" + this.getRowIndex() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public GLAccountData() {
    }
}
