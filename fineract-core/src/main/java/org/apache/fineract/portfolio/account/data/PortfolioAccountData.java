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
package org.apache.fineract.portfolio.account.data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Optional;
import org.apache.fineract.organisation.monetary.data.CurrencyData;

/**
 * Immutable data object representing a savings account.
 */
public class PortfolioAccountData implements Serializable {
    private final Long id;
    private final String accountNo;
    private final String externalId;
    private final Long groupId;
    private final String groupName;
    private final Long clientId;
    private final String clientName;
    private final Long productId;
    private final String productName;
    private final Long fieldOfficerId;
    private final String fieldOfficerName;
    private final CurrencyData currency;
    private final BigDecimal amtForTransfer;

    public static PortfolioAccountData lookup(final Long accountId, final String accountNo) {
        return new PortfolioAccountData(accountId, accountNo, null, null, null, null, null, null, null, null, null, null, null);
    }

    public PortfolioAccountData(final Long id, final String accountNo, final String externalId, final Long groupId, final String groupName, final Long clientId, final String clientName, final Long productId, final String productName, final Long fieldOfficerId, final String fieldOfficerName, final CurrencyData currency) {
        this.id = id;
        this.accountNo = accountNo;
        this.externalId = externalId;
        this.groupId = groupId;
        this.groupName = groupName;
        this.clientId = clientId;
        this.clientName = clientName;
        this.productId = productId;
        this.productName = productName;
        this.fieldOfficerId = fieldOfficerId;
        this.fieldOfficerName = fieldOfficerName;
        this.currency = currency;
        this.amtForTransfer = null;
    }

    public String getCurrencyCodeFromCurrency() {
        return Optional.ofNullable(getCurrency()).map(CurrencyData::getCode).orElse(null);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getAccountNo() {
        return this.accountNo;
    }

    @java.lang.SuppressWarnings("all")
        public String getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getGroupId() {
        return this.groupId;
    }

    @java.lang.SuppressWarnings("all")
        public String getGroupName() {
        return this.groupName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public String getClientName() {
        return this.clientName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getProductId() {
        return this.productId;
    }

    @java.lang.SuppressWarnings("all")
        public String getProductName() {
        return this.productName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getFieldOfficerId() {
        return this.fieldOfficerId;
    }

    @java.lang.SuppressWarnings("all")
        public String getFieldOfficerName() {
        return this.fieldOfficerName;
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmtForTransfer() {
        return this.amtForTransfer;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof PortfolioAccountData)) return false;
        final PortfolioAccountData other = (PortfolioAccountData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$groupId = this.getGroupId();
        final java.lang.Object other$groupId = other.getGroupId();
        if (this$groupId == null ? other$groupId != null : !this$groupId.equals(other$groupId)) return false;
        final java.lang.Object this$clientId = this.getClientId();
        final java.lang.Object other$clientId = other.getClientId();
        if (this$clientId == null ? other$clientId != null : !this$clientId.equals(other$clientId)) return false;
        final java.lang.Object this$productId = this.getProductId();
        final java.lang.Object other$productId = other.getProductId();
        if (this$productId == null ? other$productId != null : !this$productId.equals(other$productId)) return false;
        final java.lang.Object this$fieldOfficerId = this.getFieldOfficerId();
        final java.lang.Object other$fieldOfficerId = other.getFieldOfficerId();
        if (this$fieldOfficerId == null ? other$fieldOfficerId != null : !this$fieldOfficerId.equals(other$fieldOfficerId)) return false;
        final java.lang.Object this$accountNo = this.getAccountNo();
        final java.lang.Object other$accountNo = other.getAccountNo();
        if (this$accountNo == null ? other$accountNo != null : !this$accountNo.equals(other$accountNo)) return false;
        final java.lang.Object this$externalId = this.getExternalId();
        final java.lang.Object other$externalId = other.getExternalId();
        if (this$externalId == null ? other$externalId != null : !this$externalId.equals(other$externalId)) return false;
        final java.lang.Object this$groupName = this.getGroupName();
        final java.lang.Object other$groupName = other.getGroupName();
        if (this$groupName == null ? other$groupName != null : !this$groupName.equals(other$groupName)) return false;
        final java.lang.Object this$clientName = this.getClientName();
        final java.lang.Object other$clientName = other.getClientName();
        if (this$clientName == null ? other$clientName != null : !this$clientName.equals(other$clientName)) return false;
        final java.lang.Object this$productName = this.getProductName();
        final java.lang.Object other$productName = other.getProductName();
        if (this$productName == null ? other$productName != null : !this$productName.equals(other$productName)) return false;
        final java.lang.Object this$fieldOfficerName = this.getFieldOfficerName();
        final java.lang.Object other$fieldOfficerName = other.getFieldOfficerName();
        if (this$fieldOfficerName == null ? other$fieldOfficerName != null : !this$fieldOfficerName.equals(other$fieldOfficerName)) return false;
        final java.lang.Object this$currency = this.getCurrency();
        final java.lang.Object other$currency = other.getCurrency();
        if (this$currency == null ? other$currency != null : !this$currency.equals(other$currency)) return false;
        final java.lang.Object this$amtForTransfer = this.getAmtForTransfer();
        final java.lang.Object other$amtForTransfer = other.getAmtForTransfer();
        if (this$amtForTransfer == null ? other$amtForTransfer != null : !this$amtForTransfer.equals(other$amtForTransfer)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof PortfolioAccountData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $groupId = this.getGroupId();
        result = result * PRIME + ($groupId == null ? 43 : $groupId.hashCode());
        final java.lang.Object $clientId = this.getClientId();
        result = result * PRIME + ($clientId == null ? 43 : $clientId.hashCode());
        final java.lang.Object $productId = this.getProductId();
        result = result * PRIME + ($productId == null ? 43 : $productId.hashCode());
        final java.lang.Object $fieldOfficerId = this.getFieldOfficerId();
        result = result * PRIME + ($fieldOfficerId == null ? 43 : $fieldOfficerId.hashCode());
        final java.lang.Object $accountNo = this.getAccountNo();
        result = result * PRIME + ($accountNo == null ? 43 : $accountNo.hashCode());
        final java.lang.Object $externalId = this.getExternalId();
        result = result * PRIME + ($externalId == null ? 43 : $externalId.hashCode());
        final java.lang.Object $groupName = this.getGroupName();
        result = result * PRIME + ($groupName == null ? 43 : $groupName.hashCode());
        final java.lang.Object $clientName = this.getClientName();
        result = result * PRIME + ($clientName == null ? 43 : $clientName.hashCode());
        final java.lang.Object $productName = this.getProductName();
        result = result * PRIME + ($productName == null ? 43 : $productName.hashCode());
        final java.lang.Object $fieldOfficerName = this.getFieldOfficerName();
        result = result * PRIME + ($fieldOfficerName == null ? 43 : $fieldOfficerName.hashCode());
        final java.lang.Object $currency = this.getCurrency();
        result = result * PRIME + ($currency == null ? 43 : $currency.hashCode());
        final java.lang.Object $amtForTransfer = this.getAmtForTransfer();
        result = result * PRIME + ($amtForTransfer == null ? 43 : $amtForTransfer.hashCode());
        return result;
    }

    @java.lang.SuppressWarnings("all")
        public PortfolioAccountData(final Long id, final String accountNo, final String externalId, final Long groupId, final String groupName, final Long clientId, final String clientName, final Long productId, final String productName, final Long fieldOfficerId, final String fieldOfficerName, final CurrencyData currency, final BigDecimal amtForTransfer) {
        this.id = id;
        this.accountNo = accountNo;
        this.externalId = externalId;
        this.groupId = groupId;
        this.groupName = groupName;
        this.clientId = clientId;
        this.clientName = clientName;
        this.productId = productId;
        this.productName = productName;
        this.fieldOfficerId = fieldOfficerId;
        this.fieldOfficerName = fieldOfficerName;
        this.currency = currency;
        this.amtForTransfer = amtForTransfer;
    }
}
