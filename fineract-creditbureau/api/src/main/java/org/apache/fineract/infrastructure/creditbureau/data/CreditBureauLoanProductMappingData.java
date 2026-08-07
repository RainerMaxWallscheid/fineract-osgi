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

public final class CreditBureauLoanProductMappingData {
    private long creditbureauLoanProductMappingId;
    private long organisationCreditBureauId;
    private String alias;
    private String creditbureauSummary;
    private String loanProductName;
    private long loanProductId;
    private boolean isCreditCheckMandatory;
    private boolean skipCrediCheckInFailure;
    private long stalePeriod;
    private boolean active;

    public static CreditBureauLoanProductMappingData instance(final long creditbureauLoanProductMappingId, final long organisationCreditBureauId, final String alias, final String creditbureauSummary, final String loanProductName, final long loanProductId, final boolean isCreditCheckMandatory, final boolean skipCrediCheckInFailure, final long stalePeriod, final boolean active) {
        return new CreditBureauLoanProductMappingData().setCreditbureauLoanProductMappingId(creditbureauLoanProductMappingId).setOrganisationCreditBureauId(organisationCreditBureauId).setAlias(alias).setCreditbureauSummary(creditbureauSummary).setLoanProductName(loanProductName).setLoanProductId(loanProductId).setCreditCheckMandatory(isCreditCheckMandatory).setSkipCrediCheckInFailure(skipCrediCheckInFailure).setStalePeriod(stalePeriod).setActive(active);
    }

    public static CreditBureauLoanProductMappingData instance1(final String loanProductName, final long loanProductId) {
        return new CreditBureauLoanProductMappingData().setCreditbureauLoanProductMappingId(0).setOrganisationCreditBureauId(0).setAlias("").setCreditbureauSummary("").setLoanProductName(loanProductName).setLoanProductId(loanProductId).setCreditCheckMandatory(false).setSkipCrediCheckInFailure(false).setStalePeriod(0).setActive(false);
    }

    @java.lang.SuppressWarnings("all")
        public long getCreditbureauLoanProductMappingId() {
        return this.creditbureauLoanProductMappingId;
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
        public String getCreditbureauSummary() {
        return this.creditbureauSummary;
    }

    @java.lang.SuppressWarnings("all")
        public String getLoanProductName() {
        return this.loanProductName;
    }

    @java.lang.SuppressWarnings("all")
        public long getLoanProductId() {
        return this.loanProductId;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isCreditCheckMandatory() {
        return this.isCreditCheckMandatory;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isSkipCrediCheckInFailure() {
        return this.skipCrediCheckInFailure;
    }

    @java.lang.SuppressWarnings("all")
        public long getStalePeriod() {
        return this.stalePeriod;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isActive() {
        return this.active;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMappingData setCreditbureauLoanProductMappingId(final long creditbureauLoanProductMappingId) {
        this.creditbureauLoanProductMappingId = creditbureauLoanProductMappingId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMappingData setOrganisationCreditBureauId(final long organisationCreditBureauId) {
        this.organisationCreditBureauId = organisationCreditBureauId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMappingData setAlias(final String alias) {
        this.alias = alias;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMappingData setCreditbureauSummary(final String creditbureauSummary) {
        this.creditbureauSummary = creditbureauSummary;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMappingData setLoanProductName(final String loanProductName) {
        this.loanProductName = loanProductName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMappingData setLoanProductId(final long loanProductId) {
        this.loanProductId = loanProductId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMappingData setCreditCheckMandatory(final boolean isCreditCheckMandatory) {
        this.isCreditCheckMandatory = isCreditCheckMandatory;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMappingData setSkipCrediCheckInFailure(final boolean skipCrediCheckInFailure) {
        this.skipCrediCheckInFailure = skipCrediCheckInFailure;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMappingData setStalePeriod(final long stalePeriod) {
        this.stalePeriod = stalePeriod;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMappingData setActive(final boolean active) {
        this.active = active;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CreditBureauLoanProductMappingData)) return false;
        final CreditBureauLoanProductMappingData other = (CreditBureauLoanProductMappingData) o;
        if (this.getCreditbureauLoanProductMappingId() != other.getCreditbureauLoanProductMappingId()) return false;
        if (this.getOrganisationCreditBureauId() != other.getOrganisationCreditBureauId()) return false;
        if (this.getLoanProductId() != other.getLoanProductId()) return false;
        if (this.isCreditCheckMandatory() != other.isCreditCheckMandatory()) return false;
        if (this.isSkipCrediCheckInFailure() != other.isSkipCrediCheckInFailure()) return false;
        if (this.getStalePeriod() != other.getStalePeriod()) return false;
        if (this.isActive() != other.isActive()) return false;
        final java.lang.Object this$alias = this.getAlias();
        final java.lang.Object other$alias = other.getAlias();
        if (this$alias == null ? other$alias != null : !this$alias.equals(other$alias)) return false;
        final java.lang.Object this$creditbureauSummary = this.getCreditbureauSummary();
        final java.lang.Object other$creditbureauSummary = other.getCreditbureauSummary();
        if (this$creditbureauSummary == null ? other$creditbureauSummary != null : !this$creditbureauSummary.equals(other$creditbureauSummary)) return false;
        final java.lang.Object this$loanProductName = this.getLoanProductName();
        final java.lang.Object other$loanProductName = other.getLoanProductName();
        if (this$loanProductName == null ? other$loanProductName != null : !this$loanProductName.equals(other$loanProductName)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final long $creditbureauLoanProductMappingId = this.getCreditbureauLoanProductMappingId();
        result = result * PRIME + (int) ($creditbureauLoanProductMappingId >>> 32 ^ $creditbureauLoanProductMappingId);
        final long $organisationCreditBureauId = this.getOrganisationCreditBureauId();
        result = result * PRIME + (int) ($organisationCreditBureauId >>> 32 ^ $organisationCreditBureauId);
        final long $loanProductId = this.getLoanProductId();
        result = result * PRIME + (int) ($loanProductId >>> 32 ^ $loanProductId);
        result = result * PRIME + (this.isCreditCheckMandatory() ? 79 : 97);
        result = result * PRIME + (this.isSkipCrediCheckInFailure() ? 79 : 97);
        final long $stalePeriod = this.getStalePeriod();
        result = result * PRIME + (int) ($stalePeriod >>> 32 ^ $stalePeriod);
        result = result * PRIME + (this.isActive() ? 79 : 97);
        final java.lang.Object $alias = this.getAlias();
        result = result * PRIME + ($alias == null ? 43 : $alias.hashCode());
        final java.lang.Object $creditbureauSummary = this.getCreditbureauSummary();
        result = result * PRIME + ($creditbureauSummary == null ? 43 : $creditbureauSummary.hashCode());
        final java.lang.Object $loanProductName = this.getLoanProductName();
        result = result * PRIME + ($loanProductName == null ? 43 : $loanProductName.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CreditBureauLoanProductMappingData(creditbureauLoanProductMappingId=" + this.getCreditbureauLoanProductMappingId() + ", organisationCreditBureauId=" + this.getOrganisationCreditBureauId() + ", alias=" + this.getAlias() + ", creditbureauSummary=" + this.getCreditbureauSummary() + ", loanProductName=" + this.getLoanProductName() + ", loanProductId=" + this.getLoanProductId() + ", isCreditCheckMandatory=" + this.isCreditCheckMandatory() + ", skipCrediCheckInFailure=" + this.isSkipCrediCheckInFailure() + ", stalePeriod=" + this.getStalePeriod() + ", active=" + this.isActive() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMappingData() {
    }
}
