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

public final class CreditBureauProduct {
    private long creditBureauProductId;
    private String creditBureauProductName;
    private long creditBureauMasterId;

    public static CreditBureauProduct instance(final long creditBureauProductId, final String creditBureauProductName, final long creditBureauMasterId) {
        return new CreditBureauProduct().setCreditBureauProductId(creditBureauProductId).setCreditBureauProductName(creditBureauProductName).setCreditBureauMasterId(creditBureauMasterId);
    }

    @java.lang.SuppressWarnings("all")
        public long getCreditBureauProductId() {
        return this.creditBureauProductId;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreditBureauProductName() {
        return this.creditBureauProductName;
    }

    @java.lang.SuppressWarnings("all")
        public long getCreditBureauMasterId() {
        return this.creditBureauMasterId;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauProduct setCreditBureauProductId(final long creditBureauProductId) {
        this.creditBureauProductId = creditBureauProductId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauProduct setCreditBureauProductName(final String creditBureauProductName) {
        this.creditBureauProductName = creditBureauProductName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauProduct setCreditBureauMasterId(final long creditBureauMasterId) {
        this.creditBureauMasterId = creditBureauMasterId;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CreditBureauProduct)) return false;
        final CreditBureauProduct other = (CreditBureauProduct) o;
        if (this.getCreditBureauProductId() != other.getCreditBureauProductId()) return false;
        if (this.getCreditBureauMasterId() != other.getCreditBureauMasterId()) return false;
        final java.lang.Object this$creditBureauProductName = this.getCreditBureauProductName();
        final java.lang.Object other$creditBureauProductName = other.getCreditBureauProductName();
        if (this$creditBureauProductName == null ? other$creditBureauProductName != null : !this$creditBureauProductName.equals(other$creditBureauProductName)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final long $creditBureauProductId = this.getCreditBureauProductId();
        result = result * PRIME + (int) ($creditBureauProductId >>> 32 ^ $creditBureauProductId);
        final long $creditBureauMasterId = this.getCreditBureauMasterId();
        result = result * PRIME + (int) ($creditBureauMasterId >>> 32 ^ $creditBureauMasterId);
        final java.lang.Object $creditBureauProductName = this.getCreditBureauProductName();
        result = result * PRIME + ($creditBureauProductName == null ? 43 : $creditBureauProductName.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CreditBureauProduct(creditBureauProductId=" + this.getCreditBureauProductId() + ", creditBureauProductName=" + this.getCreditBureauProductName() + ", creditBureauMasterId=" + this.getCreditBureauMasterId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CreditBureauProduct() {
    }
}
