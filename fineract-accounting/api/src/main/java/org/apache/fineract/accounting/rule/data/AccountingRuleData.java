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
package org.apache.fineract.accounting.rule.data;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.apache.fineract.accounting.glaccount.data.GLAccountData;
import org.apache.fineract.accounting.glaccount.data.GLAccountDataForLookup;
import org.apache.fineract.infrastructure.codes.data.CodeValueData;
import org.apache.fineract.organisation.office.data.OfficeData;

/**
 * Immutable object representing a General Ledger Account
 *
 * Note: no getter/setters required as google-gson will produce json from fields of object.
 */
public class AccountingRuleData {
    private Long id;
    private Long officeId;
    private String officeName;
    private String name;
    private String description;
    private boolean systemDefined;
    private boolean allowMultipleDebitEntries;
    private boolean allowMultipleCreditEntries;
    private List<AccountingTagRuleData> creditTags;
    private List<AccountingTagRuleData> debitTags;
    // template
    @SuppressWarnings("unused")
    private List<OfficeData> allowedOffices = new ArrayList<>();
    @SuppressWarnings("unused")
    private List<GLAccountData> allowedAccounts = new ArrayList<>();
    @SuppressWarnings("unused")
    private Collection<CodeValueData> allowedCreditTagOptions;
    @SuppressWarnings("unused")
    private Collection<CodeValueData> allowedDebitTagOptions;
    private List<GLAccountDataForLookup> creditAccounts;
    private List<GLAccountDataForLookup> debitAccounts;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
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
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isSystemDefined() {
        return this.systemDefined;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isAllowMultipleDebitEntries() {
        return this.allowMultipleDebitEntries;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isAllowMultipleCreditEntries() {
        return this.allowMultipleCreditEntries;
    }

    @java.lang.SuppressWarnings("all")
        public List<AccountingTagRuleData> getCreditTags() {
        return this.creditTags;
    }

    @java.lang.SuppressWarnings("all")
        public List<AccountingTagRuleData> getDebitTags() {
        return this.debitTags;
    }

    @java.lang.SuppressWarnings("all")
        public List<OfficeData> getAllowedOffices() {
        return this.allowedOffices;
    }

    @java.lang.SuppressWarnings("all")
        public List<GLAccountData> getAllowedAccounts() {
        return this.allowedAccounts;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getAllowedCreditTagOptions() {
        return this.allowedCreditTagOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getAllowedDebitTagOptions() {
        return this.allowedDebitTagOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<GLAccountDataForLookup> getCreditAccounts() {
        return this.creditAccounts;
    }

    @java.lang.SuppressWarnings("all")
        public List<GLAccountDataForLookup> getDebitAccounts() {
        return this.debitAccounts;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingRuleData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingRuleData setOfficeId(final Long officeId) {
        this.officeId = officeId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingRuleData setOfficeName(final String officeName) {
        this.officeName = officeName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingRuleData setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingRuleData setDescription(final String description) {
        this.description = description;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingRuleData setSystemDefined(final boolean systemDefined) {
        this.systemDefined = systemDefined;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingRuleData setAllowMultipleDebitEntries(final boolean allowMultipleDebitEntries) {
        this.allowMultipleDebitEntries = allowMultipleDebitEntries;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingRuleData setAllowMultipleCreditEntries(final boolean allowMultipleCreditEntries) {
        this.allowMultipleCreditEntries = allowMultipleCreditEntries;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingRuleData setCreditTags(final List<AccountingTagRuleData> creditTags) {
        this.creditTags = creditTags;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingRuleData setDebitTags(final List<AccountingTagRuleData> debitTags) {
        this.debitTags = debitTags;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingRuleData setAllowedOffices(final List<OfficeData> allowedOffices) {
        this.allowedOffices = allowedOffices;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingRuleData setAllowedAccounts(final List<GLAccountData> allowedAccounts) {
        this.allowedAccounts = allowedAccounts;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingRuleData setAllowedCreditTagOptions(final Collection<CodeValueData> allowedCreditTagOptions) {
        this.allowedCreditTagOptions = allowedCreditTagOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingRuleData setAllowedDebitTagOptions(final Collection<CodeValueData> allowedDebitTagOptions) {
        this.allowedDebitTagOptions = allowedDebitTagOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingRuleData setCreditAccounts(final List<GLAccountDataForLookup> creditAccounts) {
        this.creditAccounts = creditAccounts;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingRuleData setDebitAccounts(final List<GLAccountDataForLookup> debitAccounts) {
        this.debitAccounts = debitAccounts;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AccountingRuleData)) return false;
        final AccountingRuleData other = (AccountingRuleData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isSystemDefined() != other.isSystemDefined()) return false;
        if (this.isAllowMultipleDebitEntries() != other.isAllowMultipleDebitEntries()) return false;
        if (this.isAllowMultipleCreditEntries() != other.isAllowMultipleCreditEntries()) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$officeName = this.getOfficeName();
        final java.lang.Object other$officeName = other.getOfficeName();
        if (this$officeName == null ? other$officeName != null : !this$officeName.equals(other$officeName)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        final java.lang.Object this$creditTags = this.getCreditTags();
        final java.lang.Object other$creditTags = other.getCreditTags();
        if (this$creditTags == null ? other$creditTags != null : !this$creditTags.equals(other$creditTags)) return false;
        final java.lang.Object this$debitTags = this.getDebitTags();
        final java.lang.Object other$debitTags = other.getDebitTags();
        if (this$debitTags == null ? other$debitTags != null : !this$debitTags.equals(other$debitTags)) return false;
        final java.lang.Object this$allowedOffices = this.getAllowedOffices();
        final java.lang.Object other$allowedOffices = other.getAllowedOffices();
        if (this$allowedOffices == null ? other$allowedOffices != null : !this$allowedOffices.equals(other$allowedOffices)) return false;
        final java.lang.Object this$allowedAccounts = this.getAllowedAccounts();
        final java.lang.Object other$allowedAccounts = other.getAllowedAccounts();
        if (this$allowedAccounts == null ? other$allowedAccounts != null : !this$allowedAccounts.equals(other$allowedAccounts)) return false;
        final java.lang.Object this$allowedCreditTagOptions = this.getAllowedCreditTagOptions();
        final java.lang.Object other$allowedCreditTagOptions = other.getAllowedCreditTagOptions();
        if (this$allowedCreditTagOptions == null ? other$allowedCreditTagOptions != null : !this$allowedCreditTagOptions.equals(other$allowedCreditTagOptions)) return false;
        final java.lang.Object this$allowedDebitTagOptions = this.getAllowedDebitTagOptions();
        final java.lang.Object other$allowedDebitTagOptions = other.getAllowedDebitTagOptions();
        if (this$allowedDebitTagOptions == null ? other$allowedDebitTagOptions != null : !this$allowedDebitTagOptions.equals(other$allowedDebitTagOptions)) return false;
        final java.lang.Object this$creditAccounts = this.getCreditAccounts();
        final java.lang.Object other$creditAccounts = other.getCreditAccounts();
        if (this$creditAccounts == null ? other$creditAccounts != null : !this$creditAccounts.equals(other$creditAccounts)) return false;
        final java.lang.Object this$debitAccounts = this.getDebitAccounts();
        final java.lang.Object other$debitAccounts = other.getDebitAccounts();
        if (this$debitAccounts == null ? other$debitAccounts != null : !this$debitAccounts.equals(other$debitAccounts)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AccountingRuleData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isSystemDefined() ? 79 : 97);
        result = result * PRIME + (this.isAllowMultipleDebitEntries() ? 79 : 97);
        result = result * PRIME + (this.isAllowMultipleCreditEntries() ? 79 : 97);
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $officeId = this.getOfficeId();
        result = result * PRIME + ($officeId == null ? 43 : $officeId.hashCode());
        final java.lang.Object $officeName = this.getOfficeName();
        result = result * PRIME + ($officeName == null ? 43 : $officeName.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        final java.lang.Object $creditTags = this.getCreditTags();
        result = result * PRIME + ($creditTags == null ? 43 : $creditTags.hashCode());
        final java.lang.Object $debitTags = this.getDebitTags();
        result = result * PRIME + ($debitTags == null ? 43 : $debitTags.hashCode());
        final java.lang.Object $allowedOffices = this.getAllowedOffices();
        result = result * PRIME + ($allowedOffices == null ? 43 : $allowedOffices.hashCode());
        final java.lang.Object $allowedAccounts = this.getAllowedAccounts();
        result = result * PRIME + ($allowedAccounts == null ? 43 : $allowedAccounts.hashCode());
        final java.lang.Object $allowedCreditTagOptions = this.getAllowedCreditTagOptions();
        result = result * PRIME + ($allowedCreditTagOptions == null ? 43 : $allowedCreditTagOptions.hashCode());
        final java.lang.Object $allowedDebitTagOptions = this.getAllowedDebitTagOptions();
        result = result * PRIME + ($allowedDebitTagOptions == null ? 43 : $allowedDebitTagOptions.hashCode());
        final java.lang.Object $creditAccounts = this.getCreditAccounts();
        result = result * PRIME + ($creditAccounts == null ? 43 : $creditAccounts.hashCode());
        final java.lang.Object $debitAccounts = this.getDebitAccounts();
        result = result * PRIME + ($debitAccounts == null ? 43 : $debitAccounts.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AccountingRuleData(id=" + this.getId() + ", officeId=" + this.getOfficeId() + ", officeName=" + this.getOfficeName() + ", name=" + this.getName() + ", description=" + this.getDescription() + ", systemDefined=" + this.isSystemDefined() + ", allowMultipleDebitEntries=" + this.isAllowMultipleDebitEntries() + ", allowMultipleCreditEntries=" + this.isAllowMultipleCreditEntries() + ", creditTags=" + this.getCreditTags() + ", debitTags=" + this.getDebitTags() + ", allowedOffices=" + this.getAllowedOffices() + ", allowedAccounts=" + this.getAllowedAccounts() + ", allowedCreditTagOptions=" + this.getAllowedCreditTagOptions() + ", allowedDebitTagOptions=" + this.getAllowedDebitTagOptions() + ", creditAccounts=" + this.getCreditAccounts() + ", debitAccounts=" + this.getDebitAccounts() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AccountingRuleData() {
    }
}
