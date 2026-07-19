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
package org.apache.fineract.portfolio.loanaccount.data;

import java.math.BigDecimal;

/**
 * Carries the pro-rated tax amount for a single TaxComponent when a LoanCharge is (partially) paid. Used to propagate
 * tax details from the domain layer to the accounting bridge.
 */
public class ChargeTaxDetailDTO {
    /**
     * GL account to credit (tax liability account from TaxComponent.creditAccount).
     */
    private Long creditAccountId;
    /**
     * Pro-rated tax amount for this component in this payment.
     */
    private BigDecimal amount;

    /**
     * GL account to credit (tax liability account from TaxComponent.creditAccount).
     */
    @java.lang.SuppressWarnings("all")
        public Long getCreditAccountId() {
        return this.creditAccountId;
    }

    /**
     * Pro-rated tax amount for this component in this payment.
     */
    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    /**
     * GL account to credit (tax liability account from TaxComponent.creditAccount).
     */
    @java.lang.SuppressWarnings("all")
        public void setCreditAccountId(final Long creditAccountId) {
        this.creditAccountId = creditAccountId;
    }

    /**
     * Pro-rated tax amount for this component in this payment.
     */
    @java.lang.SuppressWarnings("all")
        public void setAmount(final BigDecimal amount) {
        this.amount = amount;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ChargeTaxDetailDTO)) return false;
        final ChargeTaxDetailDTO other = (ChargeTaxDetailDTO) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$creditAccountId = this.getCreditAccountId();
        final java.lang.Object other$creditAccountId = other.getCreditAccountId();
        if (this$creditAccountId == null ? other$creditAccountId != null : !this$creditAccountId.equals(other$creditAccountId)) return false;
        final java.lang.Object this$amount = this.getAmount();
        final java.lang.Object other$amount = other.getAmount();
        if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ChargeTaxDetailDTO;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $creditAccountId = this.getCreditAccountId();
        result = result * PRIME + ($creditAccountId == null ? 43 : $creditAccountId.hashCode());
        final java.lang.Object $amount = this.getAmount();
        result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ChargeTaxDetailDTO(creditAccountId=" + this.getCreditAccountId() + ", amount=" + this.getAmount() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ChargeTaxDetailDTO() {
    }

    /**
     * Creates a new {@code ChargeTaxDetailDTO} instance.
     *
     * @param creditAccountId GL account to credit (tax liability account from TaxComponent.creditAccount).
     * @param amount Pro-rated tax amount for this component in this payment.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeTaxDetailDTO(final Long creditAccountId, final BigDecimal amount) {
        this.creditAccountId = creditAccountId;
        this.amount = amount;
    }
}
