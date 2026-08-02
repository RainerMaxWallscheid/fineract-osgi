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
import java.util.Collection;
import java.util.List;
import org.apache.fineract.accounting.glaccount.data.GLAccountData;
import org.apache.fineract.portfolio.loanproduct.data.LoanProductData;

@SuppressWarnings("unused")
public final class ProvisioningCriteriaData implements Comparable<ProvisioningCriteriaData>, Serializable {
    private static final long serialVersionUID = 1L;
    private Long criteriaId;
    private String criteriaName;
    private String createdBy;
    private Collection<LoanProductData> loanProducts;
    private Collection<LoanProductData> selectedLoanProducts;
    private Collection<ProvisioningCriteriaDefinitionData> definitions;
    private Collection<GLAccountData> glAccounts;

    private ProvisioningCriteriaData(final Long criteriaId, final String criteriaName, final Collection<LoanProductData> loanProducts, Collection<ProvisioningCriteriaDefinitionData> definitions, Collection<GLAccountData> glAccounts, final String createdBy) {
        this.criteriaId = criteriaId;
        this.criteriaName = criteriaName;
        this.loanProducts = loanProducts;
        this.definitions = definitions;
        this.glAccounts = glAccounts;
        this.createdBy = createdBy;
    }

    private ProvisioningCriteriaData(ProvisioningCriteriaData data, final Collection<LoanProductData> loanProducts, Collection<GLAccountData> glAccounts) {
        this.criteriaId = data.criteriaId;
        this.criteriaName = data.criteriaName;
        this.selectedLoanProducts = data.loanProducts;
        this.loanProducts = loanProducts;
        this.loanProducts.removeAll(selectedLoanProducts);
        this.definitions = data.definitions;
        this.glAccounts = glAccounts;
        this.createdBy = data.createdBy;
    }

    public static ProvisioningCriteriaData toLookup(final Long criteriaId, final String criteriaName, final Collection<LoanProductData> loanProducts, final List<ProvisioningCriteriaDefinitionData> definitions) {
        Collection<GLAccountData> glAccounts = null;
        String createdBy = null;
        return new ProvisioningCriteriaData().setCriteriaId(criteriaId).setCriteriaName(criteriaName).setLoanProducts(loanProducts).setDefinitions(definitions).setGlAccounts(glAccounts).setCreatedBy(createdBy);
    }

    public static ProvisioningCriteriaData toLookup(final Long criteriaId, final String criteriaName, String createdBy) {
        Collection<GLAccountData> glAccounts = null;
        Collection<LoanProductData> loanProducts = null;
        List<ProvisioningCriteriaDefinitionData> definitions = null;
        return new ProvisioningCriteriaData().setCriteriaId(criteriaId).setCriteriaName(criteriaName).setLoanProducts(loanProducts).setDefinitions(definitions).setGlAccounts(glAccounts).setCreatedBy(createdBy);
    }

    public static ProvisioningCriteriaData toTemplate(final Collection<ProvisioningCriteriaDefinitionData> definitions, final Collection<LoanProductData> loanProducts, final Collection<GLAccountData> glAccounts) {
        Long criteriaId = null;
        String criteriaName = null;
        String createdBy = null;
        return new ProvisioningCriteriaData().setCriteriaId(criteriaId).setCriteriaName(criteriaName).setLoanProducts(loanProducts).setDefinitions(definitions).setGlAccounts(glAccounts).setCreatedBy(createdBy);
    }

    public static ProvisioningCriteriaData toTemplate(final ProvisioningCriteriaData data, final Collection<ProvisioningCriteriaDefinitionData> definitions, final Collection<LoanProductData> loanProducts, final Collection<GLAccountData> glAccounts) {
        return new ProvisioningCriteriaData(data, loanProducts, glAccounts);
    }

    @Override
    public int compareTo(ProvisioningCriteriaData obj) {
        if (obj == null) {
            return -1;
        }
        return obj.criteriaId.compareTo(this.criteriaId);
    }

    @java.lang.SuppressWarnings("all")
        public Long getCriteriaId() {
        return this.criteriaId;
    }

    @java.lang.SuppressWarnings("all")
        public String getCriteriaName() {
        return this.criteriaName;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreatedBy() {
        return this.createdBy;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LoanProductData> getLoanProducts() {
        return this.loanProducts;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LoanProductData> getSelectedLoanProducts() {
        return this.selectedLoanProducts;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<ProvisioningCriteriaDefinitionData> getDefinitions() {
        return this.definitions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<GLAccountData> getGlAccounts() {
        return this.glAccounts;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaData setCriteriaId(final Long criteriaId) {
        this.criteriaId = criteriaId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaData setCriteriaName(final String criteriaName) {
        this.criteriaName = criteriaName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaData setCreatedBy(final String createdBy) {
        this.createdBy = createdBy;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaData setLoanProducts(final Collection<LoanProductData> loanProducts) {
        this.loanProducts = loanProducts;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaData setSelectedLoanProducts(final Collection<LoanProductData> selectedLoanProducts) {
        this.selectedLoanProducts = selectedLoanProducts;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaData setDefinitions(final Collection<ProvisioningCriteriaDefinitionData> definitions) {
        this.definitions = definitions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaData setGlAccounts(final Collection<GLAccountData> glAccounts) {
        this.glAccounts = glAccounts;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ProvisioningCriteriaData)) return false;
        final ProvisioningCriteriaData other = (ProvisioningCriteriaData) o;
        final java.lang.Object this$criteriaId = this.getCriteriaId();
        final java.lang.Object other$criteriaId = other.getCriteriaId();
        if (this$criteriaId == null ? other$criteriaId != null : !this$criteriaId.equals(other$criteriaId)) return false;
        final java.lang.Object this$criteriaName = this.getCriteriaName();
        final java.lang.Object other$criteriaName = other.getCriteriaName();
        if (this$criteriaName == null ? other$criteriaName != null : !this$criteriaName.equals(other$criteriaName)) return false;
        final java.lang.Object this$createdBy = this.getCreatedBy();
        final java.lang.Object other$createdBy = other.getCreatedBy();
        if (this$createdBy == null ? other$createdBy != null : !this$createdBy.equals(other$createdBy)) return false;
        final java.lang.Object this$loanProducts = this.getLoanProducts();
        final java.lang.Object other$loanProducts = other.getLoanProducts();
        if (this$loanProducts == null ? other$loanProducts != null : !this$loanProducts.equals(other$loanProducts)) return false;
        final java.lang.Object this$selectedLoanProducts = this.getSelectedLoanProducts();
        final java.lang.Object other$selectedLoanProducts = other.getSelectedLoanProducts();
        if (this$selectedLoanProducts == null ? other$selectedLoanProducts != null : !this$selectedLoanProducts.equals(other$selectedLoanProducts)) return false;
        final java.lang.Object this$definitions = this.getDefinitions();
        final java.lang.Object other$definitions = other.getDefinitions();
        if (this$definitions == null ? other$definitions != null : !this$definitions.equals(other$definitions)) return false;
        final java.lang.Object this$glAccounts = this.getGlAccounts();
        final java.lang.Object other$glAccounts = other.getGlAccounts();
        if (this$glAccounts == null ? other$glAccounts != null : !this$glAccounts.equals(other$glAccounts)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $criteriaId = this.getCriteriaId();
        result = result * PRIME + ($criteriaId == null ? 43 : $criteriaId.hashCode());
        final java.lang.Object $criteriaName = this.getCriteriaName();
        result = result * PRIME + ($criteriaName == null ? 43 : $criteriaName.hashCode());
        final java.lang.Object $createdBy = this.getCreatedBy();
        result = result * PRIME + ($createdBy == null ? 43 : $createdBy.hashCode());
        final java.lang.Object $loanProducts = this.getLoanProducts();
        result = result * PRIME + ($loanProducts == null ? 43 : $loanProducts.hashCode());
        final java.lang.Object $selectedLoanProducts = this.getSelectedLoanProducts();
        result = result * PRIME + ($selectedLoanProducts == null ? 43 : $selectedLoanProducts.hashCode());
        final java.lang.Object $definitions = this.getDefinitions();
        result = result * PRIME + ($definitions == null ? 43 : $definitions.hashCode());
        final java.lang.Object $glAccounts = this.getGlAccounts();
        result = result * PRIME + ($glAccounts == null ? 43 : $glAccounts.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ProvisioningCriteriaData(criteriaId=" + this.getCriteriaId() + ", criteriaName=" + this.getCriteriaName() + ", createdBy=" + this.getCreatedBy() + ", loanProducts=" + this.getLoanProducts() + ", selectedLoanProducts=" + this.getSelectedLoanProducts() + ", definitions=" + this.getDefinitions() + ", glAccounts=" + this.getGlAccounts() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ProvisioningCriteriaData() {
    }
}
