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
package org.apache.fineract.investor.data;

import java.time.LocalDate;

public class ExternalTransferChangedData {
    private LocalDate settlementDate;
    private String transferExternalId;
    private String ownerExternalId;
    private String purchasePriceRatio;

    @java.lang.SuppressWarnings("all")
        public ExternalTransferChangedData() {
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSettlementDate() {
        return this.settlementDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransferExternalId() {
        return this.transferExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public String getOwnerExternalId() {
        return this.ownerExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public String getPurchasePriceRatio() {
        return this.purchasePriceRatio;
    }

    @java.lang.SuppressWarnings("all")
        public void setSettlementDate(final LocalDate settlementDate) {
        this.settlementDate = settlementDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransferExternalId(final String transferExternalId) {
        this.transferExternalId = transferExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setOwnerExternalId(final String ownerExternalId) {
        this.ownerExternalId = ownerExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setPurchasePriceRatio(final String purchasePriceRatio) {
        this.purchasePriceRatio = purchasePriceRatio;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ExternalTransferChangedData)) return false;
        final ExternalTransferChangedData other = (ExternalTransferChangedData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$settlementDate = this.getSettlementDate();
        final java.lang.Object other$settlementDate = other.getSettlementDate();
        if (this$settlementDate == null ? other$settlementDate != null : !this$settlementDate.equals(other$settlementDate)) return false;
        final java.lang.Object this$transferExternalId = this.getTransferExternalId();
        final java.lang.Object other$transferExternalId = other.getTransferExternalId();
        if (this$transferExternalId == null ? other$transferExternalId != null : !this$transferExternalId.equals(other$transferExternalId)) return false;
        final java.lang.Object this$ownerExternalId = this.getOwnerExternalId();
        final java.lang.Object other$ownerExternalId = other.getOwnerExternalId();
        if (this$ownerExternalId == null ? other$ownerExternalId != null : !this$ownerExternalId.equals(other$ownerExternalId)) return false;
        final java.lang.Object this$purchasePriceRatio = this.getPurchasePriceRatio();
        final java.lang.Object other$purchasePriceRatio = other.getPurchasePriceRatio();
        if (this$purchasePriceRatio == null ? other$purchasePriceRatio != null : !this$purchasePriceRatio.equals(other$purchasePriceRatio)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ExternalTransferChangedData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $settlementDate = this.getSettlementDate();
        result = result * PRIME + ($settlementDate == null ? 43 : $settlementDate.hashCode());
        final java.lang.Object $transferExternalId = this.getTransferExternalId();
        result = result * PRIME + ($transferExternalId == null ? 43 : $transferExternalId.hashCode());
        final java.lang.Object $ownerExternalId = this.getOwnerExternalId();
        result = result * PRIME + ($ownerExternalId == null ? 43 : $ownerExternalId.hashCode());
        final java.lang.Object $purchasePriceRatio = this.getPurchasePriceRatio();
        result = result * PRIME + ($purchasePriceRatio == null ? 43 : $purchasePriceRatio.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ExternalTransferChangedData(settlementDate=" + this.getSettlementDate() + ", transferExternalId=" + this.getTransferExternalId() + ", ownerExternalId=" + this.getOwnerExternalId() + ", purchasePriceRatio=" + this.getPurchasePriceRatio() + ")";
    }
}
