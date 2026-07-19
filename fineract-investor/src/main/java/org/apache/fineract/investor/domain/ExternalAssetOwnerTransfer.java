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
package org.apache.fineract.investor.domain;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.investor.data.ExternalTransferStatus;
import org.apache.fineract.investor.data.ExternalTransferSubStatus;

@Table(name = "m_external_asset_owner_transfer")
@Entity
public class ExternalAssetOwnerTransfer extends AbstractAuditableWithUTCDateTimeCustom<Long> {
    @ManyToOne
    @JoinColumn(name = "owner_id", nullable = false)
    private ExternalAssetOwner owner;
    @OneToOne(mappedBy = "externalAssetOwnerTransfer", cascade = CascadeType.ALL)
    private ExternalAssetOwnerTransferDetails externalAssetOwnerTransferDetails;
    @Column(name = "external_id", length = 100, nullable = false)
    private ExternalId externalId;
    @Column(name = "status", length = 50, nullable = false)
    @Enumerated(EnumType.STRING)
    private ExternalTransferStatus status;
    @Column(name = "sub_status", length = 50)
    @Enumerated(EnumType.STRING)
    private ExternalTransferSubStatus subStatus;
    @Column(name = "purchase_price_ratio", length = 50, nullable = false)
    private String purchasePriceRatio;
    @Column(name = "settlement_date", nullable = false)
    private LocalDate settlementDate;
    @Column(name = "effective_date_from", nullable = false)
    private LocalDate effectiveDateFrom;
    @Column(name = "effective_date_to", nullable = false)
    private LocalDate effectiveDateTo;
    @Column(name = "loan_id", nullable = false)
    private Long loanId;
    @Column(name = "external_loan_id", length = 100)
    private ExternalId externalLoanId;
    @Column(name = "external_group_id", length = 100)
    private ExternalId externalGroupId;
    @ManyToOne
    @JoinColumn(name = "previous_owner_id")
    private ExternalAssetOwner previousOwner;

    @java.lang.SuppressWarnings("all")
        public ExternalAssetOwner getOwner() {
        return this.owner;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalAssetOwnerTransferDetails getExternalAssetOwnerTransferDetails() {
        return this.externalAssetOwnerTransferDetails;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getExternalId() {
        return this.externalId;
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
        public String getPurchasePriceRatio() {
        return this.purchasePriceRatio;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSettlementDate() {
        return this.settlementDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getEffectiveDateFrom() {
        return this.effectiveDateFrom;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getEffectiveDateTo() {
        return this.effectiveDateTo;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getExternalLoanId() {
        return this.externalLoanId;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getExternalGroupId() {
        return this.externalGroupId;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalAssetOwner getPreviousOwner() {
        return this.previousOwner;
    }

    @java.lang.SuppressWarnings("all")
        public void setOwner(final ExternalAssetOwner owner) {
        this.owner = owner;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalAssetOwnerTransferDetails(final ExternalAssetOwnerTransferDetails externalAssetOwnerTransferDetails) {
        this.externalAssetOwnerTransferDetails = externalAssetOwnerTransferDetails;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalId(final ExternalId externalId) {
        this.externalId = externalId;
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
        public void setPurchasePriceRatio(final String purchasePriceRatio) {
        this.purchasePriceRatio = purchasePriceRatio;
    }

    @java.lang.SuppressWarnings("all")
        public void setSettlementDate(final LocalDate settlementDate) {
        this.settlementDate = settlementDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setEffectiveDateFrom(final LocalDate effectiveDateFrom) {
        this.effectiveDateFrom = effectiveDateFrom;
    }

    @java.lang.SuppressWarnings("all")
        public void setEffectiveDateTo(final LocalDate effectiveDateTo) {
        this.effectiveDateTo = effectiveDateTo;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanId(final Long loanId) {
        this.loanId = loanId;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalLoanId(final ExternalId externalLoanId) {
        this.externalLoanId = externalLoanId;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalGroupId(final ExternalId externalGroupId) {
        this.externalGroupId = externalGroupId;
    }

    @java.lang.SuppressWarnings("all")
        public void setPreviousOwner(final ExternalAssetOwner previousOwner) {
        this.previousOwner = previousOwner;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalAssetOwnerTransfer() {
    }
}
