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

public class ExternalTransferData {
    private Long transferId;
    private ExternalTransferOwnerData owner;
    private ExternalTransferOwnerData previousOwner;
    private ExternalTransferLoanData loan;
    private ExternalTransferDataDetails details;
    private String transferExternalId;
    private String transferExternalGroupId;
    private String purchasePriceRatio;
    private LocalDate settlementDate;
    private ExternalTransferStatus status;
    private ExternalTransferSubStatus subStatus;
    private LocalDate effectiveFrom;
    private LocalDate effectiveTo;

    @java.lang.SuppressWarnings("all")
        public ExternalTransferData() {
    }

    @java.lang.SuppressWarnings("all")
        public Long getTransferId() {
        return this.transferId;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalTransferOwnerData getOwner() {
        return this.owner;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalTransferOwnerData getPreviousOwner() {
        return this.previousOwner;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalTransferLoanData getLoan() {
        return this.loan;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalTransferDataDetails getDetails() {
        return this.details;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransferExternalId() {
        return this.transferExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransferExternalGroupId() {
        return this.transferExternalGroupId;
    }

    @java.lang.SuppressWarnings("all")
        public String getPurchasePriceRatio() {
        return this.purchasePriceRatio;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSettlementDate() {
        return this.settlementDate;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalTransferStatus getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalTransferSubStatus getSubStatus() {
        return this.subStatus;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getEffectiveFrom() {
        return this.effectiveFrom;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getEffectiveTo() {
        return this.effectiveTo;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransferId(final Long transferId) {
        this.transferId = transferId;
    }

    @java.lang.SuppressWarnings("all")
        public void setOwner(final ExternalTransferOwnerData owner) {
        this.owner = owner;
    }

    @java.lang.SuppressWarnings("all")
        public void setPreviousOwner(final ExternalTransferOwnerData previousOwner) {
        this.previousOwner = previousOwner;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoan(final ExternalTransferLoanData loan) {
        this.loan = loan;
    }

    @java.lang.SuppressWarnings("all")
        public void setDetails(final ExternalTransferDataDetails details) {
        this.details = details;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransferExternalId(final String transferExternalId) {
        this.transferExternalId = transferExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransferExternalGroupId(final String transferExternalGroupId) {
        this.transferExternalGroupId = transferExternalGroupId;
    }

    @java.lang.SuppressWarnings("all")
        public void setPurchasePriceRatio(final String purchasePriceRatio) {
        this.purchasePriceRatio = purchasePriceRatio;
    }

    @java.lang.SuppressWarnings("all")
        public void setSettlementDate(final LocalDate settlementDate) {
        this.settlementDate = settlementDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setStatus(final ExternalTransferStatus status) {
        this.status = status;
    }

    @java.lang.SuppressWarnings("all")
        public void setSubStatus(final ExternalTransferSubStatus subStatus) {
        this.subStatus = subStatus;
    }

    @java.lang.SuppressWarnings("all")
        public void setEffectiveFrom(final LocalDate effectiveFrom) {
        this.effectiveFrom = effectiveFrom;
    }

    @java.lang.SuppressWarnings("all")
        public void setEffectiveTo(final LocalDate effectiveTo) {
        this.effectiveTo = effectiveTo;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ExternalTransferData)) return false;
        final ExternalTransferData other = (ExternalTransferData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$transferId = this.getTransferId();
        final java.lang.Object other$transferId = other.getTransferId();
        if (this$transferId == null ? other$transferId != null : !this$transferId.equals(other$transferId)) return false;
        final java.lang.Object this$owner = this.getOwner();
        final java.lang.Object other$owner = other.getOwner();
        if (this$owner == null ? other$owner != null : !this$owner.equals(other$owner)) return false;
        final java.lang.Object this$previousOwner = this.getPreviousOwner();
        final java.lang.Object other$previousOwner = other.getPreviousOwner();
        if (this$previousOwner == null ? other$previousOwner != null : !this$previousOwner.equals(other$previousOwner)) return false;
        final java.lang.Object this$loan = this.getLoan();
        final java.lang.Object other$loan = other.getLoan();
        if (this$loan == null ? other$loan != null : !this$loan.equals(other$loan)) return false;
        final java.lang.Object this$details = this.getDetails();
        final java.lang.Object other$details = other.getDetails();
        if (this$details == null ? other$details != null : !this$details.equals(other$details)) return false;
        final java.lang.Object this$transferExternalId = this.getTransferExternalId();
        final java.lang.Object other$transferExternalId = other.getTransferExternalId();
        if (this$transferExternalId == null ? other$transferExternalId != null : !this$transferExternalId.equals(other$transferExternalId)) return false;
        final java.lang.Object this$transferExternalGroupId = this.getTransferExternalGroupId();
        final java.lang.Object other$transferExternalGroupId = other.getTransferExternalGroupId();
        if (this$transferExternalGroupId == null ? other$transferExternalGroupId != null : !this$transferExternalGroupId.equals(other$transferExternalGroupId)) return false;
        final java.lang.Object this$purchasePriceRatio = this.getPurchasePriceRatio();
        final java.lang.Object other$purchasePriceRatio = other.getPurchasePriceRatio();
        if (this$purchasePriceRatio == null ? other$purchasePriceRatio != null : !this$purchasePriceRatio.equals(other$purchasePriceRatio)) return false;
        final java.lang.Object this$settlementDate = this.getSettlementDate();
        final java.lang.Object other$settlementDate = other.getSettlementDate();
        if (this$settlementDate == null ? other$settlementDate != null : !this$settlementDate.equals(other$settlementDate)) return false;
        final java.lang.Object this$status = this.getStatus();
        final java.lang.Object other$status = other.getStatus();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        final java.lang.Object this$subStatus = this.getSubStatus();
        final java.lang.Object other$subStatus = other.getSubStatus();
        if (this$subStatus == null ? other$subStatus != null : !this$subStatus.equals(other$subStatus)) return false;
        final java.lang.Object this$effectiveFrom = this.getEffectiveFrom();
        final java.lang.Object other$effectiveFrom = other.getEffectiveFrom();
        if (this$effectiveFrom == null ? other$effectiveFrom != null : !this$effectiveFrom.equals(other$effectiveFrom)) return false;
        final java.lang.Object this$effectiveTo = this.getEffectiveTo();
        final java.lang.Object other$effectiveTo = other.getEffectiveTo();
        if (this$effectiveTo == null ? other$effectiveTo != null : !this$effectiveTo.equals(other$effectiveTo)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ExternalTransferData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $transferId = this.getTransferId();
        result = result * PRIME + ($transferId == null ? 43 : $transferId.hashCode());
        final java.lang.Object $owner = this.getOwner();
        result = result * PRIME + ($owner == null ? 43 : $owner.hashCode());
        final java.lang.Object $previousOwner = this.getPreviousOwner();
        result = result * PRIME + ($previousOwner == null ? 43 : $previousOwner.hashCode());
        final java.lang.Object $loan = this.getLoan();
        result = result * PRIME + ($loan == null ? 43 : $loan.hashCode());
        final java.lang.Object $details = this.getDetails();
        result = result * PRIME + ($details == null ? 43 : $details.hashCode());
        final java.lang.Object $transferExternalId = this.getTransferExternalId();
        result = result * PRIME + ($transferExternalId == null ? 43 : $transferExternalId.hashCode());
        final java.lang.Object $transferExternalGroupId = this.getTransferExternalGroupId();
        result = result * PRIME + ($transferExternalGroupId == null ? 43 : $transferExternalGroupId.hashCode());
        final java.lang.Object $purchasePriceRatio = this.getPurchasePriceRatio();
        result = result * PRIME + ($purchasePriceRatio == null ? 43 : $purchasePriceRatio.hashCode());
        final java.lang.Object $settlementDate = this.getSettlementDate();
        result = result * PRIME + ($settlementDate == null ? 43 : $settlementDate.hashCode());
        final java.lang.Object $status = this.getStatus();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        final java.lang.Object $subStatus = this.getSubStatus();
        result = result * PRIME + ($subStatus == null ? 43 : $subStatus.hashCode());
        final java.lang.Object $effectiveFrom = this.getEffectiveFrom();
        result = result * PRIME + ($effectiveFrom == null ? 43 : $effectiveFrom.hashCode());
        final java.lang.Object $effectiveTo = this.getEffectiveTo();
        result = result * PRIME + ($effectiveTo == null ? 43 : $effectiveTo.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ExternalTransferData(transferId=" + this.getTransferId() + ", owner=" + this.getOwner() + ", previousOwner=" + this.getPreviousOwner() + ", loan=" + this.getLoan() + ", details=" + this.getDetails() + ", transferExternalId=" + this.getTransferExternalId() + ", transferExternalGroupId=" + this.getTransferExternalGroupId() + ", purchasePriceRatio=" + this.getPurchasePriceRatio() + ", settlementDate=" + this.getSettlementDate() + ", status=" + this.getStatus() + ", subStatus=" + this.getSubStatus() + ", effectiveFrom=" + this.getEffectiveFrom() + ", effectiveTo=" + this.getEffectiveTo() + ")";
    }
}
