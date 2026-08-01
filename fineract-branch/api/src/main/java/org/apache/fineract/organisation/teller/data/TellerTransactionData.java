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
package org.apache.fineract.organisation.teller.data;

import java.io.Serializable;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;

/**
 * {@code TellerTransactionData} represents an immutable data object for a transction.
 *
 * @version 1.0.0
 *
 * @since 2.0.0
 * @see java.io.Serializable
 * @since 2.0.0
 */
public final class TellerTransactionData implements Serializable {
    private Long id;
    private Long officeId;
    private Long tellerId;
    private Long cashierId;
    private Long clientId;
    private EnumOptionData type;
    private Double amount;
    private LocalDate postingDate;

    /**
     * Creates a new teller transaction data object.
     *
     * @param id
     *            - id of the transaction
     * @param officeId
     *            - id of the related office
     * @param tellerId
     *            - id of the related teller
     * @param cashierId
     *            - id of the cashier
     * @param clientId
     *            - id of the client
     * @param type
     *            - type of transaction (eg receipt, payment, open, close, settle)
     * @param amount
     *            - amount of the transaction
     * @param postingDate
     *            - posting date of the transaction
     * @return the new created {@code TellerTransactionData}
     */
    public static TellerTransactionData instance(final Long id, final Long officeId, final Long tellerId, final Long cashierId, final Long clientId, final EnumOptionData type, final Double amount, final LocalDate postingDate) {
        return new TellerTransactionData().setId(id).setOfficeId(officeId).setTellerId(tellerId).setCashierId(cashierId).setClientId(clientId).setType(type).setAmount(amount).setPostingDate(postingDate);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getTellerId() {
        return this.tellerId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCashierId() {
        return this.cashierId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public Double getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getPostingDate() {
        return this.postingDate;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerTransactionData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerTransactionData setOfficeId(final Long officeId) {
        this.officeId = officeId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerTransactionData setTellerId(final Long tellerId) {
        this.tellerId = tellerId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerTransactionData setCashierId(final Long cashierId) {
        this.cashierId = cashierId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerTransactionData setClientId(final Long clientId) {
        this.clientId = clientId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerTransactionData setType(final EnumOptionData type) {
        this.type = type;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerTransactionData setAmount(final Double amount) {
        this.amount = amount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerTransactionData setPostingDate(final LocalDate postingDate) {
        this.postingDate = postingDate;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof TellerTransactionData)) return false;
        final TellerTransactionData other = (TellerTransactionData) o;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$tellerId = this.getTellerId();
        final java.lang.Object other$tellerId = other.getTellerId();
        if (this$tellerId == null ? other$tellerId != null : !this$tellerId.equals(other$tellerId)) return false;
        final java.lang.Object this$cashierId = this.getCashierId();
        final java.lang.Object other$cashierId = other.getCashierId();
        if (this$cashierId == null ? other$cashierId != null : !this$cashierId.equals(other$cashierId)) return false;
        final java.lang.Object this$clientId = this.getClientId();
        final java.lang.Object other$clientId = other.getClientId();
        if (this$clientId == null ? other$clientId != null : !this$clientId.equals(other$clientId)) return false;
        final java.lang.Object this$amount = this.getAmount();
        final java.lang.Object other$amount = other.getAmount();
        if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final java.lang.Object this$postingDate = this.getPostingDate();
        final java.lang.Object other$postingDate = other.getPostingDate();
        if (this$postingDate == null ? other$postingDate != null : !this$postingDate.equals(other$postingDate)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $officeId = this.getOfficeId();
        result = result * PRIME + ($officeId == null ? 43 : $officeId.hashCode());
        final java.lang.Object $tellerId = this.getTellerId();
        result = result * PRIME + ($tellerId == null ? 43 : $tellerId.hashCode());
        final java.lang.Object $cashierId = this.getCashierId();
        result = result * PRIME + ($cashierId == null ? 43 : $cashierId.hashCode());
        final java.lang.Object $clientId = this.getClientId();
        result = result * PRIME + ($clientId == null ? 43 : $clientId.hashCode());
        final java.lang.Object $amount = this.getAmount();
        result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final java.lang.Object $postingDate = this.getPostingDate();
        result = result * PRIME + ($postingDate == null ? 43 : $postingDate.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "TellerTransactionData(id=" + this.getId() + ", officeId=" + this.getOfficeId() + ", tellerId=" + this.getTellerId() + ", cashierId=" + this.getCashierId() + ", clientId=" + this.getClientId() + ", type=" + this.getType() + ", amount=" + this.getAmount() + ", postingDate=" + this.getPostingDate() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public TellerTransactionData() {
    }

    @java.lang.SuppressWarnings("all")
        public TellerTransactionData(final Long id, final Long officeId, final Long tellerId, final Long cashierId, final Long clientId, final EnumOptionData type, final Double amount, final LocalDate postingDate) {
        this.id = id;
        this.officeId = officeId;
        this.tellerId = tellerId;
        this.cashierId = cashierId;
        this.clientId = clientId;
        this.type = type;
        this.amount = amount;
        this.postingDate = postingDate;
    }
}
