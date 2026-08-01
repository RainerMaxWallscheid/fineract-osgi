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
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.Collection;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.organisation.teller.moduleapi.CashierTxnType;

public final class CashierTransactionData implements Serializable {
    private Long id;
    private Long cashierId;
    private CashierTxnType txnType;
    private BigDecimal txnAmount;
    private LocalDate txnDate;
    private Long entityId;
    private String entityType;
    private String txnNote;
    private OffsetDateTime createdDate;
    // Template fields
    private Long officeId;
    private String officeName;
    private Long tellerId;
    private String tellerName;
    private String cashierName;
    private CashierData cashierData;
    private LocalDate startDate;
    private LocalDate endDate;
    private Collection<CurrencyData> currencyOptions;

    public static CashierTransactionData instance(final Long id, final Long cashierId, CashierTxnType txnType, final BigDecimal txnAmount, final LocalDate txnDate, final String txnNote, final String entityType, final Long entityId, final OffsetDateTime createdDate, final Long officeId, final String officeName, final Long tellerId, final String tellerName, final String cashierName, final CashierData cashierData, LocalDate startDate, LocalDate endDate) {
        return new CashierTransactionData().setId(id).setCashierId(cashierId).setTxnType(txnType).setTxnAmount(txnAmount).setTxnDate(txnDate).setTxnNote(txnNote).setEntityType(entityType).setEntityId(entityId).setCreatedDate(createdDate).setOfficeId(officeId).setOfficeName(officeName).setTellerId(tellerId).setTellerName(tellerName).setCashierName(cashierName).setCashierData(cashierData).setStartDate(startDate).setEndDate(endDate);
    }

    public static CashierTransactionData template(final Long cashierId, final Long tellerId, final String tellerName, final Long officeId, final String officeName, final String cashierName, final CashierData cashierData, LocalDate startDate, LocalDate endDate, final Collection<CurrencyData> currencyOptions) {
        return new CashierTransactionData().setCashierId(cashierId).setOfficeId(officeId).setOfficeName(officeName).setTellerId(tellerId).setTellerName(tellerName).setCashierName(cashierName).setCashierData(cashierData).setStartDate(startDate).setEndDate(endDate).setCurrencyOptions(currencyOptions);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCashierId() {
        return this.cashierId;
    }

    @java.lang.SuppressWarnings("all")
        public CashierTxnType getTxnType() {
        return this.txnType;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTxnAmount() {
        return this.txnAmount;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getTxnDate() {
        return this.txnDate;
    }

    @java.lang.SuppressWarnings("all")
        public Long getEntityId() {
        return this.entityId;
    }

    @java.lang.SuppressWarnings("all")
        public String getEntityType() {
        return this.entityType;
    }

    @java.lang.SuppressWarnings("all")
        public String getTxnNote() {
        return this.txnNote;
    }

    @java.lang.SuppressWarnings("all")
        public OffsetDateTime getCreatedDate() {
        return this.createdDate;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getOfficeName() {
        return this.officeName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getTellerId() {
        return this.tellerId;
    }

    @java.lang.SuppressWarnings("all")
        public String getTellerName() {
        return this.tellerName;
    }

    @java.lang.SuppressWarnings("all")
        public String getCashierName() {
        return this.cashierName;
    }

    @java.lang.SuppressWarnings("all")
        public CashierData getCashierData() {
        return this.cashierData;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getStartDate() {
        return this.startDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getEndDate() {
        return this.endDate;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CurrencyData> getCurrencyOptions() {
        return this.currencyOptions;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setCashierId(final Long cashierId) {
        this.cashierId = cashierId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setTxnType(final CashierTxnType txnType) {
        this.txnType = txnType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setTxnAmount(final BigDecimal txnAmount) {
        this.txnAmount = txnAmount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setTxnDate(final LocalDate txnDate) {
        this.txnDate = txnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setEntityId(final Long entityId) {
        this.entityId = entityId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setEntityType(final String entityType) {
        this.entityType = entityType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setTxnNote(final String txnNote) {
        this.txnNote = txnNote;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setCreatedDate(final OffsetDateTime createdDate) {
        this.createdDate = createdDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setOfficeId(final Long officeId) {
        this.officeId = officeId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setOfficeName(final String officeName) {
        this.officeName = officeName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setTellerId(final Long tellerId) {
        this.tellerId = tellerId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setTellerName(final String tellerName) {
        this.tellerName = tellerName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setCashierName(final String cashierName) {
        this.cashierName = cashierName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setCashierData(final CashierData cashierData) {
        this.cashierData = cashierData;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setStartDate(final LocalDate startDate) {
        this.startDate = startDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setEndDate(final LocalDate endDate) {
        this.endDate = endDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransactionData setCurrencyOptions(final Collection<CurrencyData> currencyOptions) {
        this.currencyOptions = currencyOptions;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CashierTransactionData)) return false;
        final CashierTransactionData other = (CashierTransactionData) o;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$cashierId = this.getCashierId();
        final java.lang.Object other$cashierId = other.getCashierId();
        if (this$cashierId == null ? other$cashierId != null : !this$cashierId.equals(other$cashierId)) return false;
        final java.lang.Object this$entityId = this.getEntityId();
        final java.lang.Object other$entityId = other.getEntityId();
        if (this$entityId == null ? other$entityId != null : !this$entityId.equals(other$entityId)) return false;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$tellerId = this.getTellerId();
        final java.lang.Object other$tellerId = other.getTellerId();
        if (this$tellerId == null ? other$tellerId != null : !this$tellerId.equals(other$tellerId)) return false;
        final java.lang.Object this$txnType = this.getTxnType();
        final java.lang.Object other$txnType = other.getTxnType();
        if (this$txnType == null ? other$txnType != null : !this$txnType.equals(other$txnType)) return false;
        final java.lang.Object this$txnAmount = this.getTxnAmount();
        final java.lang.Object other$txnAmount = other.getTxnAmount();
        if (this$txnAmount == null ? other$txnAmount != null : !this$txnAmount.equals(other$txnAmount)) return false;
        final java.lang.Object this$txnDate = this.getTxnDate();
        final java.lang.Object other$txnDate = other.getTxnDate();
        if (this$txnDate == null ? other$txnDate != null : !this$txnDate.equals(other$txnDate)) return false;
        final java.lang.Object this$entityType = this.getEntityType();
        final java.lang.Object other$entityType = other.getEntityType();
        if (this$entityType == null ? other$entityType != null : !this$entityType.equals(other$entityType)) return false;
        final java.lang.Object this$txnNote = this.getTxnNote();
        final java.lang.Object other$txnNote = other.getTxnNote();
        if (this$txnNote == null ? other$txnNote != null : !this$txnNote.equals(other$txnNote)) return false;
        final java.lang.Object this$createdDate = this.getCreatedDate();
        final java.lang.Object other$createdDate = other.getCreatedDate();
        if (this$createdDate == null ? other$createdDate != null : !this$createdDate.equals(other$createdDate)) return false;
        final java.lang.Object this$officeName = this.getOfficeName();
        final java.lang.Object other$officeName = other.getOfficeName();
        if (this$officeName == null ? other$officeName != null : !this$officeName.equals(other$officeName)) return false;
        final java.lang.Object this$tellerName = this.getTellerName();
        final java.lang.Object other$tellerName = other.getTellerName();
        if (this$tellerName == null ? other$tellerName != null : !this$tellerName.equals(other$tellerName)) return false;
        final java.lang.Object this$cashierName = this.getCashierName();
        final java.lang.Object other$cashierName = other.getCashierName();
        if (this$cashierName == null ? other$cashierName != null : !this$cashierName.equals(other$cashierName)) return false;
        final java.lang.Object this$cashierData = this.getCashierData();
        final java.lang.Object other$cashierData = other.getCashierData();
        if (this$cashierData == null ? other$cashierData != null : !this$cashierData.equals(other$cashierData)) return false;
        final java.lang.Object this$startDate = this.getStartDate();
        final java.lang.Object other$startDate = other.getStartDate();
        if (this$startDate == null ? other$startDate != null : !this$startDate.equals(other$startDate)) return false;
        final java.lang.Object this$endDate = this.getEndDate();
        final java.lang.Object other$endDate = other.getEndDate();
        if (this$endDate == null ? other$endDate != null : !this$endDate.equals(other$endDate)) return false;
        final java.lang.Object this$currencyOptions = this.getCurrencyOptions();
        final java.lang.Object other$currencyOptions = other.getCurrencyOptions();
        if (this$currencyOptions == null ? other$currencyOptions != null : !this$currencyOptions.equals(other$currencyOptions)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $cashierId = this.getCashierId();
        result = result * PRIME + ($cashierId == null ? 43 : $cashierId.hashCode());
        final java.lang.Object $entityId = this.getEntityId();
        result = result * PRIME + ($entityId == null ? 43 : $entityId.hashCode());
        final java.lang.Object $officeId = this.getOfficeId();
        result = result * PRIME + ($officeId == null ? 43 : $officeId.hashCode());
        final java.lang.Object $tellerId = this.getTellerId();
        result = result * PRIME + ($tellerId == null ? 43 : $tellerId.hashCode());
        final java.lang.Object $txnType = this.getTxnType();
        result = result * PRIME + ($txnType == null ? 43 : $txnType.hashCode());
        final java.lang.Object $txnAmount = this.getTxnAmount();
        result = result * PRIME + ($txnAmount == null ? 43 : $txnAmount.hashCode());
        final java.lang.Object $txnDate = this.getTxnDate();
        result = result * PRIME + ($txnDate == null ? 43 : $txnDate.hashCode());
        final java.lang.Object $entityType = this.getEntityType();
        result = result * PRIME + ($entityType == null ? 43 : $entityType.hashCode());
        final java.lang.Object $txnNote = this.getTxnNote();
        result = result * PRIME + ($txnNote == null ? 43 : $txnNote.hashCode());
        final java.lang.Object $createdDate = this.getCreatedDate();
        result = result * PRIME + ($createdDate == null ? 43 : $createdDate.hashCode());
        final java.lang.Object $officeName = this.getOfficeName();
        result = result * PRIME + ($officeName == null ? 43 : $officeName.hashCode());
        final java.lang.Object $tellerName = this.getTellerName();
        result = result * PRIME + ($tellerName == null ? 43 : $tellerName.hashCode());
        final java.lang.Object $cashierName = this.getCashierName();
        result = result * PRIME + ($cashierName == null ? 43 : $cashierName.hashCode());
        final java.lang.Object $cashierData = this.getCashierData();
        result = result * PRIME + ($cashierData == null ? 43 : $cashierData.hashCode());
        final java.lang.Object $startDate = this.getStartDate();
        result = result * PRIME + ($startDate == null ? 43 : $startDate.hashCode());
        final java.lang.Object $endDate = this.getEndDate();
        result = result * PRIME + ($endDate == null ? 43 : $endDate.hashCode());
        final java.lang.Object $currencyOptions = this.getCurrencyOptions();
        result = result * PRIME + ($currencyOptions == null ? 43 : $currencyOptions.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CashierTransactionData(id=" + this.getId() + ", cashierId=" + this.getCashierId() + ", txnType=" + this.getTxnType() + ", txnAmount=" + this.getTxnAmount() + ", txnDate=" + this.getTxnDate() + ", entityId=" + this.getEntityId() + ", entityType=" + this.getEntityType() + ", txnNote=" + this.getTxnNote() + ", createdDate=" + this.getCreatedDate() + ", officeId=" + this.getOfficeId() + ", officeName=" + this.getOfficeName() + ", tellerId=" + this.getTellerId() + ", tellerName=" + this.getTellerName() + ", cashierName=" + this.getCashierName() + ", cashierData=" + this.getCashierData() + ", startDate=" + this.getStartDate() + ", endDate=" + this.getEndDate() + ", currencyOptions=" + this.getCurrencyOptions() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CashierTransactionData() {
    }

    @java.lang.SuppressWarnings("all")
        public CashierTransactionData(final Long id, final Long cashierId, final CashierTxnType txnType, final BigDecimal txnAmount, final LocalDate txnDate, final Long entityId, final String entityType, final String txnNote, final OffsetDateTime createdDate, final Long officeId, final String officeName, final Long tellerId, final String tellerName, final String cashierName, final CashierData cashierData, final LocalDate startDate, final LocalDate endDate, final Collection<CurrencyData> currencyOptions) {
        this.id = id;
        this.cashierId = cashierId;
        this.txnType = txnType;
        this.txnAmount = txnAmount;
        this.txnDate = txnDate;
        this.entityId = entityId;
        this.entityType = entityType;
        this.txnNote = txnNote;
        this.createdDate = createdDate;
        this.officeId = officeId;
        this.officeName = officeName;
        this.tellerId = tellerId;
        this.tellerName = tellerName;
        this.cashierName = cashierName;
        this.cashierData = cashierData;
        this.startDate = startDate;
        this.endDate = endDate;
        this.currencyOptions = currencyOptions;
    }
}
