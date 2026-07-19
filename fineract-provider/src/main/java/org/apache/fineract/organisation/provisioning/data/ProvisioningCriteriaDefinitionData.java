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
package org.apache.fineract.organisation.provisioning.data;

import java.io.Serializable;
import java.math.BigDecimal;

public final class ProvisioningCriteriaDefinitionData implements Comparable<ProvisioningCriteriaDefinitionData>, Serializable {
    private static final long serialVersionUID = 1L;
    private Long id;
    private Long categoryId;
    private String categoryName;
    private Long minAge;
    private Long maxAge;
    private BigDecimal provisioningPercentage;
    private Long liabilityAccount;
    private String liabilityCode;
    private String liabilityName;
    private Long expenseAccount;
    private String expenseCode;
    private String expenseName;

    public static ProvisioningCriteriaDefinitionData template(Long categoryId, String categoryName) {
        return new ProvisioningCriteriaDefinitionData().setCategoryId(categoryId).setCategoryName(categoryName);
    }

    @Override
    public int compareTo(ProvisioningCriteriaDefinitionData obj) {
        if (obj == null) {
            return -1;
        }
        return obj.id.compareTo(this.id);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
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
        public Long getMinAge() {
        return this.minAge;
    }

    @java.lang.SuppressWarnings("all")
        public Long getMaxAge() {
        return this.maxAge;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getProvisioningPercentage() {
        return this.provisioningPercentage;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLiabilityAccount() {
        return this.liabilityAccount;
    }

    @java.lang.SuppressWarnings("all")
        public String getLiabilityCode() {
        return this.liabilityCode;
    }

    @java.lang.SuppressWarnings("all")
        public String getLiabilityName() {
        return this.liabilityName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getExpenseAccount() {
        return this.expenseAccount;
    }

    @java.lang.SuppressWarnings("all")
        public String getExpenseCode() {
        return this.expenseCode;
    }

    @java.lang.SuppressWarnings("all")
        public String getExpenseName() {
        return this.expenseName;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaDefinitionData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaDefinitionData setCategoryId(final Long categoryId) {
        this.categoryId = categoryId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaDefinitionData setCategoryName(final String categoryName) {
        this.categoryName = categoryName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaDefinitionData setMinAge(final Long minAge) {
        this.minAge = minAge;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaDefinitionData setMaxAge(final Long maxAge) {
        this.maxAge = maxAge;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaDefinitionData setProvisioningPercentage(final BigDecimal provisioningPercentage) {
        this.provisioningPercentage = provisioningPercentage;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaDefinitionData setLiabilityAccount(final Long liabilityAccount) {
        this.liabilityAccount = liabilityAccount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaDefinitionData setLiabilityCode(final String liabilityCode) {
        this.liabilityCode = liabilityCode;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaDefinitionData setLiabilityName(final String liabilityName) {
        this.liabilityName = liabilityName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaDefinitionData setExpenseAccount(final Long expenseAccount) {
        this.expenseAccount = expenseAccount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaDefinitionData setExpenseCode(final String expenseCode) {
        this.expenseCode = expenseCode;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaDefinitionData setExpenseName(final String expenseName) {
        this.expenseName = expenseName;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ProvisioningCriteriaDefinitionData)) return false;
        final ProvisioningCriteriaDefinitionData other = (ProvisioningCriteriaDefinitionData) o;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$categoryId = this.getCategoryId();
        final java.lang.Object other$categoryId = other.getCategoryId();
        if (this$categoryId == null ? other$categoryId != null : !this$categoryId.equals(other$categoryId)) return false;
        final java.lang.Object this$minAge = this.getMinAge();
        final java.lang.Object other$minAge = other.getMinAge();
        if (this$minAge == null ? other$minAge != null : !this$minAge.equals(other$minAge)) return false;
        final java.lang.Object this$maxAge = this.getMaxAge();
        final java.lang.Object other$maxAge = other.getMaxAge();
        if (this$maxAge == null ? other$maxAge != null : !this$maxAge.equals(other$maxAge)) return false;
        final java.lang.Object this$liabilityAccount = this.getLiabilityAccount();
        final java.lang.Object other$liabilityAccount = other.getLiabilityAccount();
        if (this$liabilityAccount == null ? other$liabilityAccount != null : !this$liabilityAccount.equals(other$liabilityAccount)) return false;
        final java.lang.Object this$expenseAccount = this.getExpenseAccount();
        final java.lang.Object other$expenseAccount = other.getExpenseAccount();
        if (this$expenseAccount == null ? other$expenseAccount != null : !this$expenseAccount.equals(other$expenseAccount)) return false;
        final java.lang.Object this$categoryName = this.getCategoryName();
        final java.lang.Object other$categoryName = other.getCategoryName();
        if (this$categoryName == null ? other$categoryName != null : !this$categoryName.equals(other$categoryName)) return false;
        final java.lang.Object this$provisioningPercentage = this.getProvisioningPercentage();
        final java.lang.Object other$provisioningPercentage = other.getProvisioningPercentage();
        if (this$provisioningPercentage == null ? other$provisioningPercentage != null : !this$provisioningPercentage.equals(other$provisioningPercentage)) return false;
        final java.lang.Object this$liabilityCode = this.getLiabilityCode();
        final java.lang.Object other$liabilityCode = other.getLiabilityCode();
        if (this$liabilityCode == null ? other$liabilityCode != null : !this$liabilityCode.equals(other$liabilityCode)) return false;
        final java.lang.Object this$liabilityName = this.getLiabilityName();
        final java.lang.Object other$liabilityName = other.getLiabilityName();
        if (this$liabilityName == null ? other$liabilityName != null : !this$liabilityName.equals(other$liabilityName)) return false;
        final java.lang.Object this$expenseCode = this.getExpenseCode();
        final java.lang.Object other$expenseCode = other.getExpenseCode();
        if (this$expenseCode == null ? other$expenseCode != null : !this$expenseCode.equals(other$expenseCode)) return false;
        final java.lang.Object this$expenseName = this.getExpenseName();
        final java.lang.Object other$expenseName = other.getExpenseName();
        if (this$expenseName == null ? other$expenseName != null : !this$expenseName.equals(other$expenseName)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $categoryId = this.getCategoryId();
        result = result * PRIME + ($categoryId == null ? 43 : $categoryId.hashCode());
        final java.lang.Object $minAge = this.getMinAge();
        result = result * PRIME + ($minAge == null ? 43 : $minAge.hashCode());
        final java.lang.Object $maxAge = this.getMaxAge();
        result = result * PRIME + ($maxAge == null ? 43 : $maxAge.hashCode());
        final java.lang.Object $liabilityAccount = this.getLiabilityAccount();
        result = result * PRIME + ($liabilityAccount == null ? 43 : $liabilityAccount.hashCode());
        final java.lang.Object $expenseAccount = this.getExpenseAccount();
        result = result * PRIME + ($expenseAccount == null ? 43 : $expenseAccount.hashCode());
        final java.lang.Object $categoryName = this.getCategoryName();
        result = result * PRIME + ($categoryName == null ? 43 : $categoryName.hashCode());
        final java.lang.Object $provisioningPercentage = this.getProvisioningPercentage();
        result = result * PRIME + ($provisioningPercentage == null ? 43 : $provisioningPercentage.hashCode());
        final java.lang.Object $liabilityCode = this.getLiabilityCode();
        result = result * PRIME + ($liabilityCode == null ? 43 : $liabilityCode.hashCode());
        final java.lang.Object $liabilityName = this.getLiabilityName();
        result = result * PRIME + ($liabilityName == null ? 43 : $liabilityName.hashCode());
        final java.lang.Object $expenseCode = this.getExpenseCode();
        result = result * PRIME + ($expenseCode == null ? 43 : $expenseCode.hashCode());
        final java.lang.Object $expenseName = this.getExpenseName();
        result = result * PRIME + ($expenseName == null ? 43 : $expenseName.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ProvisioningCriteriaDefinitionData(id=" + this.getId() + ", categoryId=" + this.getCategoryId() + ", categoryName=" + this.getCategoryName() + ", minAge=" + this.getMinAge() + ", maxAge=" + this.getMaxAge() + ", provisioningPercentage=" + this.getProvisioningPercentage() + ", liabilityAccount=" + this.getLiabilityAccount() + ", liabilityCode=" + this.getLiabilityCode() + ", liabilityName=" + this.getLiabilityName() + ", expenseAccount=" + this.getExpenseAccount() + ", expenseCode=" + this.getExpenseCode() + ", expenseName=" + this.getExpenseName() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaDefinitionData() {
    }
}
