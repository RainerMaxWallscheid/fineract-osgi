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
package org.apache.fineract.infrastructure.creditbureau.data;

public final class OrganisationCreditBureauData {
    private long organisationCreditBureauId;
    private String alias;
    private long creditBureauId;
    private String creditBureauName;
    private String creditBureauProduct;
    private String creditBureauCountry;
    private String creditBureauSummary;
    private boolean active;

    public static OrganisationCreditBureauData instance(final long organisationCreditBureauId, final String alias, final long creditBureauId, final String creditBureauName, final String creditBureauProduct, final String creditBureauCountry, final String creditBureauSummary, final boolean active) {
        return new OrganisationCreditBureauData().setOrganisationCreditBureauId(organisationCreditBureauId).setAlias(alias).setCreditBureauId(creditBureauId).setCreditBureauName(creditBureauName).setCreditBureauProduct(creditBureauProduct).setCreditBureauCountry(creditBureauCountry).setCreditBureauSummary(creditBureauSummary).setActive(active);
    }

    @java.lang.SuppressWarnings("all")
        public long getOrganisationCreditBureauId() {
        return this.organisationCreditBureauId;
    }

    @java.lang.SuppressWarnings("all")
        public String getAlias() {
        return this.alias;
    }

    @java.lang.SuppressWarnings("all")
        public long getCreditBureauId() {
        return this.creditBureauId;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreditBureauName() {
        return this.creditBureauName;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreditBureauProduct() {
        return this.creditBureauProduct;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreditBureauCountry() {
        return this.creditBureauCountry;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreditBureauSummary() {
        return this.creditBureauSummary;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isActive() {
        return this.active;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OrganisationCreditBureauData setOrganisationCreditBureauId(final long organisationCreditBureauId) {
        this.organisationCreditBureauId = organisationCreditBureauId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OrganisationCreditBureauData setAlias(final String alias) {
        this.alias = alias;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OrganisationCreditBureauData setCreditBureauId(final long creditBureauId) {
        this.creditBureauId = creditBureauId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OrganisationCreditBureauData setCreditBureauName(final String creditBureauName) {
        this.creditBureauName = creditBureauName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OrganisationCreditBureauData setCreditBureauProduct(final String creditBureauProduct) {
        this.creditBureauProduct = creditBureauProduct;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OrganisationCreditBureauData setCreditBureauCountry(final String creditBureauCountry) {
        this.creditBureauCountry = creditBureauCountry;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OrganisationCreditBureauData setCreditBureauSummary(final String creditBureauSummary) {
        this.creditBureauSummary = creditBureauSummary;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public OrganisationCreditBureauData setActive(final boolean active) {
        this.active = active;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof OrganisationCreditBureauData)) return false;
        final OrganisationCreditBureauData other = (OrganisationCreditBureauData) o;
        if (this.getOrganisationCreditBureauId() != other.getOrganisationCreditBureauId()) return false;
        if (this.getCreditBureauId() != other.getCreditBureauId()) return false;
        if (this.isActive() != other.isActive()) return false;
        final java.lang.Object this$alias = this.getAlias();
        final java.lang.Object other$alias = other.getAlias();
        if (this$alias == null ? other$alias != null : !this$alias.equals(other$alias)) return false;
        final java.lang.Object this$creditBureauName = this.getCreditBureauName();
        final java.lang.Object other$creditBureauName = other.getCreditBureauName();
        if (this$creditBureauName == null ? other$creditBureauName != null : !this$creditBureauName.equals(other$creditBureauName)) return false;
        final java.lang.Object this$creditBureauProduct = this.getCreditBureauProduct();
        final java.lang.Object other$creditBureauProduct = other.getCreditBureauProduct();
        if (this$creditBureauProduct == null ? other$creditBureauProduct != null : !this$creditBureauProduct.equals(other$creditBureauProduct)) return false;
        final java.lang.Object this$creditBureauCountry = this.getCreditBureauCountry();
        final java.lang.Object other$creditBureauCountry = other.getCreditBureauCountry();
        if (this$creditBureauCountry == null ? other$creditBureauCountry != null : !this$creditBureauCountry.equals(other$creditBureauCountry)) return false;
        final java.lang.Object this$creditBureauSummary = this.getCreditBureauSummary();
        final java.lang.Object other$creditBureauSummary = other.getCreditBureauSummary();
        if (this$creditBureauSummary == null ? other$creditBureauSummary != null : !this$creditBureauSummary.equals(other$creditBureauSummary)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final long $organisationCreditBureauId = this.getOrganisationCreditBureauId();
        result = result * PRIME + (int) ($organisationCreditBureauId >>> 32 ^ $organisationCreditBureauId);
        final long $creditBureauId = this.getCreditBureauId();
        result = result * PRIME + (int) ($creditBureauId >>> 32 ^ $creditBureauId);
        result = result * PRIME + (this.isActive() ? 79 : 97);
        final java.lang.Object $alias = this.getAlias();
        result = result * PRIME + ($alias == null ? 43 : $alias.hashCode());
        final java.lang.Object $creditBureauName = this.getCreditBureauName();
        result = result * PRIME + ($creditBureauName == null ? 43 : $creditBureauName.hashCode());
        final java.lang.Object $creditBureauProduct = this.getCreditBureauProduct();
        result = result * PRIME + ($creditBureauProduct == null ? 43 : $creditBureauProduct.hashCode());
        final java.lang.Object $creditBureauCountry = this.getCreditBureauCountry();
        result = result * PRIME + ($creditBureauCountry == null ? 43 : $creditBureauCountry.hashCode());
        final java.lang.Object $creditBureauSummary = this.getCreditBureauSummary();
        result = result * PRIME + ($creditBureauSummary == null ? 43 : $creditBureauSummary.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "OrganisationCreditBureauData(organisationCreditBureauId=" + this.getOrganisationCreditBureauId() + ", alias=" + this.getAlias() + ", creditBureauId=" + this.getCreditBureauId() + ", creditBureauName=" + this.getCreditBureauName() + ", creditBureauProduct=" + this.getCreditBureauProduct() + ", creditBureauCountry=" + this.getCreditBureauCountry() + ", creditBureauSummary=" + this.getCreditBureauSummary() + ", active=" + this.isActive() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public OrganisationCreditBureauData() {
    }
}
