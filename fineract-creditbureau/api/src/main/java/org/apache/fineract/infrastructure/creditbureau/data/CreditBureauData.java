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

public final class CreditBureauData {
    private long creditBureauId;
    private String creditBureauName;
    private String country;
    private String productName;
    private String creditBureauSummary;
    private long implementationKey;

    public static CreditBureauData instance(final long creditBureauId, final String creditBureauName, final String country, final String productName, final String creditBureauSummary, final long implementationKey) {
        return new CreditBureauData().setCreditBureauId(creditBureauId).setCreditBureauName(creditBureauName).setCountry(country).setProductName(productName).setCreditBureauSummary(creditBureauSummary).setImplementationKey(implementationKey);
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
        public String getCountry() {
        return this.country;
    }

    @java.lang.SuppressWarnings("all")
        public String getProductName() {
        return this.productName;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreditBureauSummary() {
        return this.creditBureauSummary;
    }

    @java.lang.SuppressWarnings("all")
        public long getImplementationKey() {
        return this.implementationKey;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauData setCreditBureauId(final long creditBureauId) {
        this.creditBureauId = creditBureauId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauData setCreditBureauName(final String creditBureauName) {
        this.creditBureauName = creditBureauName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauData setCountry(final String country) {
        this.country = country;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauData setProductName(final String productName) {
        this.productName = productName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauData setCreditBureauSummary(final String creditBureauSummary) {
        this.creditBureauSummary = creditBureauSummary;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauData setImplementationKey(final long implementationKey) {
        this.implementationKey = implementationKey;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CreditBureauData)) return false;
        final CreditBureauData other = (CreditBureauData) o;
        if (this.getCreditBureauId() != other.getCreditBureauId()) return false;
        if (this.getImplementationKey() != other.getImplementationKey()) return false;
        final java.lang.Object this$creditBureauName = this.getCreditBureauName();
        final java.lang.Object other$creditBureauName = other.getCreditBureauName();
        if (this$creditBureauName == null ? other$creditBureauName != null : !this$creditBureauName.equals(other$creditBureauName)) return false;
        final java.lang.Object this$country = this.getCountry();
        final java.lang.Object other$country = other.getCountry();
        if (this$country == null ? other$country != null : !this$country.equals(other$country)) return false;
        final java.lang.Object this$productName = this.getProductName();
        final java.lang.Object other$productName = other.getProductName();
        if (this$productName == null ? other$productName != null : !this$productName.equals(other$productName)) return false;
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
        final long $creditBureauId = this.getCreditBureauId();
        result = result * PRIME + (int) ($creditBureauId >>> 32 ^ $creditBureauId);
        final long $implementationKey = this.getImplementationKey();
        result = result * PRIME + (int) ($implementationKey >>> 32 ^ $implementationKey);
        final java.lang.Object $creditBureauName = this.getCreditBureauName();
        result = result * PRIME + ($creditBureauName == null ? 43 : $creditBureauName.hashCode());
        final java.lang.Object $country = this.getCountry();
        result = result * PRIME + ($country == null ? 43 : $country.hashCode());
        final java.lang.Object $productName = this.getProductName();
        result = result * PRIME + ($productName == null ? 43 : $productName.hashCode());
        final java.lang.Object $creditBureauSummary = this.getCreditBureauSummary();
        result = result * PRIME + ($creditBureauSummary == null ? 43 : $creditBureauSummary.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CreditBureauData(creditBureauId=" + this.getCreditBureauId() + ", creditBureauName=" + this.getCreditBureauName() + ", country=" + this.getCountry() + ", productName=" + this.getProductName() + ", creditBureauSummary=" + this.getCreditBureauSummary() + ", implementationKey=" + this.getImplementationKey() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CreditBureauData() {
    }
}
