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
import java.util.ArrayList;
import java.util.List;

public class LoanChargePaidByDTO {
    private Long chargeId;
    private Boolean isPenalty;
    private Long loanChargeId;
    private BigDecimal amount;
    private Integer installmentNumber;
    private List<ChargeTaxDetailDTO> taxDetails = new ArrayList<>();

    @java.lang.SuppressWarnings("all")
        public Long getChargeId() {
        return this.chargeId;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsPenalty() {
        return this.isPenalty;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanChargeId() {
        return this.loanChargeId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getInstallmentNumber() {
        return this.installmentNumber;
    }

    @java.lang.SuppressWarnings("all")
        public List<ChargeTaxDetailDTO> getTaxDetails() {
        return this.taxDetails;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargeId(final Long chargeId) {
        this.chargeId = chargeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsPenalty(final Boolean isPenalty) {
        this.isPenalty = isPenalty;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanChargeId(final Long loanChargeId) {
        this.loanChargeId = loanChargeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmount(final BigDecimal amount) {
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public void setInstallmentNumber(final Integer installmentNumber) {
        this.installmentNumber = installmentNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setTaxDetails(final List<ChargeTaxDetailDTO> taxDetails) {
        this.taxDetails = taxDetails;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanChargePaidByDTO)) return false;
        final LoanChargePaidByDTO other = (LoanChargePaidByDTO) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$chargeId = this.getChargeId();
        final java.lang.Object other$chargeId = other.getChargeId();
        if (this$chargeId == null ? other$chargeId != null : !this$chargeId.equals(other$chargeId)) return false;
        final java.lang.Object this$isPenalty = this.getIsPenalty();
        final java.lang.Object other$isPenalty = other.getIsPenalty();
        if (this$isPenalty == null ? other$isPenalty != null : !this$isPenalty.equals(other$isPenalty)) return false;
        final java.lang.Object this$loanChargeId = this.getLoanChargeId();
        final java.lang.Object other$loanChargeId = other.getLoanChargeId();
        if (this$loanChargeId == null ? other$loanChargeId != null : !this$loanChargeId.equals(other$loanChargeId)) return false;
        final java.lang.Object this$installmentNumber = this.getInstallmentNumber();
        final java.lang.Object other$installmentNumber = other.getInstallmentNumber();
        if (this$installmentNumber == null ? other$installmentNumber != null : !this$installmentNumber.equals(other$installmentNumber)) return false;
        final java.lang.Object this$amount = this.getAmount();
        final java.lang.Object other$amount = other.getAmount();
        if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
        final java.lang.Object this$taxDetails = this.getTaxDetails();
        final java.lang.Object other$taxDetails = other.getTaxDetails();
        if (this$taxDetails == null ? other$taxDetails != null : !this$taxDetails.equals(other$taxDetails)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanChargePaidByDTO;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $chargeId = this.getChargeId();
        result = result * PRIME + ($chargeId == null ? 43 : $chargeId.hashCode());
        final java.lang.Object $isPenalty = this.getIsPenalty();
        result = result * PRIME + ($isPenalty == null ? 43 : $isPenalty.hashCode());
        final java.lang.Object $loanChargeId = this.getLoanChargeId();
        result = result * PRIME + ($loanChargeId == null ? 43 : $loanChargeId.hashCode());
        final java.lang.Object $installmentNumber = this.getInstallmentNumber();
        result = result * PRIME + ($installmentNumber == null ? 43 : $installmentNumber.hashCode());
        final java.lang.Object $amount = this.getAmount();
        result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
        final java.lang.Object $taxDetails = this.getTaxDetails();
        result = result * PRIME + ($taxDetails == null ? 43 : $taxDetails.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanChargePaidByDTO(chargeId=" + this.getChargeId() + ", isPenalty=" + this.getIsPenalty() + ", loanChargeId=" + this.getLoanChargeId() + ", amount=" + this.getAmount() + ", installmentNumber=" + this.getInstallmentNumber() + ", taxDetails=" + this.getTaxDetails() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanChargePaidByDTO() {
    }

    @java.lang.SuppressWarnings("all")
        public LoanChargePaidByDTO(final Long chargeId, final Boolean isPenalty, final Long loanChargeId, final BigDecimal amount, final Integer installmentNumber, final List<ChargeTaxDetailDTO> taxDetails) {
        this.chargeId = chargeId;
        this.isPenalty = isPenalty;
        this.loanChargeId = loanChargeId;
        this.amount = amount;
        this.installmentNumber = installmentNumber;
        this.taxDetails = taxDetails;
    }
}
