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
package org.apache.fineract.investor.domain.search;

import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.investor.data.ExternalTransferStatus;
import org.apache.fineract.investor.data.ExternalTransferSubStatus;

public class SearchedExternalAssetOwner {
    private final Long transferId;
    private final Long loanId;
    private final ExternalId externalLoanId;
    private final ExternalId owner;
    private final ExternalId transferExternalId;
    private final ExternalId transferExternalGroupId;
    private final ExternalTransferStatus status;
    private final ExternalTransferSubStatus subStatus;
    private final String purchasePriceRatio;
    private final LocalDate settlementDate;
    private final LocalDate effectiveFrom;
    private final LocalDate effectiveTo;
    private final Long detailsId;
    private final BigDecimal totalOutstanding;
    private final BigDecimal principalOutstanding;
    private final BigDecimal interestOutstanding;
    private final BigDecimal feeOutstanding;
    private final BigDecimal penaltyOutstanding;
    private final BigDecimal totalOverpaid;

    @java.lang.SuppressWarnings("all")
        public Long getTransferId() {
        return this.transferId;
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
        public ExternalId getOwner() {
        return this.owner;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getTransferExternalId() {
        return this.transferExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getTransferExternalGroupId() {
        return this.transferExternalGroupId;
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
        public LocalDate getEffectiveFrom() {
        return this.effectiveFrom;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getEffectiveTo() {
        return this.effectiveTo;
    }

    @java.lang.SuppressWarnings("all")
        public Long getDetailsId() {
        return this.detailsId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalOutstanding() {
        return this.totalOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalOutstanding() {
        return this.principalOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestOutstanding() {
        return this.interestOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeOutstanding() {
        return this.feeOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyOutstanding() {
        return this.penaltyOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalOverpaid() {
        return this.totalOverpaid;
    }

    @java.lang.SuppressWarnings("all")
        public SearchedExternalAssetOwner(final Long transferId, final Long loanId, final ExternalId externalLoanId, final ExternalId owner, final ExternalId transferExternalId, final ExternalId transferExternalGroupId, final ExternalTransferStatus status, final ExternalTransferSubStatus subStatus, final String purchasePriceRatio, final LocalDate settlementDate, final LocalDate effectiveFrom, final LocalDate effectiveTo, final Long detailsId, final BigDecimal totalOutstanding, final BigDecimal principalOutstanding, final BigDecimal interestOutstanding, final BigDecimal feeOutstanding, final BigDecimal penaltyOutstanding, final BigDecimal totalOverpaid) {
        this.transferId = transferId;
        this.loanId = loanId;
        this.externalLoanId = externalLoanId;
        this.owner = owner;
        this.transferExternalId = transferExternalId;
        this.transferExternalGroupId = transferExternalGroupId;
        this.status = status;
        this.subStatus = subStatus;
        this.purchasePriceRatio = purchasePriceRatio;
        this.settlementDate = settlementDate;
        this.effectiveFrom = effectiveFrom;
        this.effectiveTo = effectiveTo;
        this.detailsId = detailsId;
        this.totalOutstanding = totalOutstanding;
        this.principalOutstanding = principalOutstanding;
        this.interestOutstanding = interestOutstanding;
        this.feeOutstanding = feeOutstanding;
        this.penaltyOutstanding = penaltyOutstanding;
        this.totalOverpaid = totalOverpaid;
    }
}
