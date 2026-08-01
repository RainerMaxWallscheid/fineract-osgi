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
package org.apache.fineract.organisation.teller.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.Map;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.organisation.office.domain.Office;

@Entity
@Table(name = "m_cashier_transactions")
public class CashierTransaction extends AbstractPersistableCustom<Long> {
    @Transient
    private Office office;
    @Transient
    private Teller teller;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cashier_id", nullable = false)
    private Cashier cashier;
    @Column(name = "txn_type", nullable = false)
    private Integer txnType;
    @Column(name = "txn_date", nullable = false)
    private LocalDate txnDate;
    @Column(name = "txn_amount", scale = 6, precision = 19, nullable = false)
    private BigDecimal txnAmount;
    @Column(name = "txn_note", nullable = true)
    private String txnNote;
    @Column(name = "entity_type", nullable = true)
    private String entityType;
    @Column(name = "entity_id", nullable = true)
    private Long entityId;
    @Column(name = "created_date", nullable = false)
    private LocalDateTime createdDate = DateUtils.getLocalDateTimeOfSystem();
    @Column(name = "currency_code", nullable = true)
    private String currencyCode;

    public static CashierTransaction fromJson(final Cashier cashier, final JsonCommand command) {
        final Integer txnType = command.integerValueOfParameterNamed("txnType");
        final BigDecimal txnAmount = command.bigDecimalValueOfParameterNamed("txnAmount");
        final LocalDate txnDate = command.localDateValueOfParameterNamed("txnDate");
        final String entityType = command.stringValueOfParameterNamed("entityType");
        final String txnNote = command.stringValueOfParameterNamed("txnNote");
        final Long entityId = command.longValueOfParameterNamed("entityId");
        final String currencyCode = command.stringValueOfParameterNamed("currencyCode");
        // TODO: get client/loan/savings details
        return new CashierTransaction().setCashier(cashier).setTxnType(txnType).setTxnAmount(txnAmount).setTxnDate(txnDate != null ? txnDate : null).setEntityType(entityType).setEntityId(entityId).setTxnNote(txnNote).setCurrencyCode(currencyCode);
    }

    public Map<String, Object> update(final JsonCommand command) {
        final Map<String, Object> actualChanges = new LinkedHashMap<>(7);
        final String dateFormatAsInput = command.dateFormat();
        final String localeAsInput = command.locale();
        final String txnTypeParamName = "txnType";
        if (command.isChangeInIntegerParameterNamed(txnTypeParamName, this.txnType)) {
            final Integer newValue = command.integerValueOfParameterNamed(txnTypeParamName);
            actualChanges.put(txnTypeParamName, newValue);
            this.txnType = newValue;
        }
        final String txnDateParamName = "txnDate";
        if (command.isChangeInLocalDateParameterNamed(txnDateParamName, this.txnDate)) {
            final String valueAsInput = command.stringValueOfParameterNamed(txnDateParamName);
            actualChanges.put(txnDateParamName, valueAsInput);
            actualChanges.put("dateFormat", dateFormatAsInput);
            actualChanges.put("locale", localeAsInput);
            this.txnDate = command.localDateValueOfParameterNamed(txnDateParamName);
        }
        final String txnAmountParamName = "txnAmount";
        if (command.isChangeInBigDecimalParameterNamed(txnAmountParamName, this.txnAmount)) {
            final BigDecimal newValue = command.bigDecimalValueOfParameterNamed(txnAmountParamName);
            actualChanges.put(txnAmountParamName, newValue);
            this.txnAmount = newValue;
        }
        final String txnNoteParamName = "txnNote";
        if (command.isChangeInStringParameterNamed(txnNoteParamName, this.txnNote)) {
            final String newValue = command.stringValueOfParameterNamed(txnNoteParamName);
            actualChanges.put(txnNoteParamName, newValue);
            this.txnNote = newValue;
        }
        final String currencyCodeParamName = "currencyCode";
        if (command.isChangeInStringParameterNamed(currencyCodeParamName, this.currencyCode)) {
            final String newValue = command.stringValueOfParameterNamed(currencyCodeParamName);
            actualChanges.put(currencyCodeParamName, newValue);
            this.currencyCode = newValue;
        }
        return actualChanges;
    }

    @java.lang.SuppressWarnings("all")
        public Office getOffice() {
        return this.office;
    }

    @java.lang.SuppressWarnings("all")
        public Teller getTeller() {
        return this.teller;
    }

    @java.lang.SuppressWarnings("all")
        public Cashier getCashier() {
        return this.cashier;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getTxnType() {
        return this.txnType;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getTxnDate() {
        return this.txnDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTxnAmount() {
        return this.txnAmount;
    }

    @java.lang.SuppressWarnings("all")
        public String getTxnNote() {
        return this.txnNote;
    }

    @java.lang.SuppressWarnings("all")
        public String getEntityType() {
        return this.entityType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getEntityId() {
        return this.entityId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDateTime getCreatedDate() {
        return this.createdDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getCurrencyCode() {
        return this.currencyCode;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransaction setOffice(final Office office) {
        this.office = office;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransaction setTeller(final Teller teller) {
        this.teller = teller;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransaction setCashier(final Cashier cashier) {
        this.cashier = cashier;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransaction setTxnType(final Integer txnType) {
        this.txnType = txnType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransaction setTxnDate(final LocalDate txnDate) {
        this.txnDate = txnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransaction setTxnAmount(final BigDecimal txnAmount) {
        this.txnAmount = txnAmount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransaction setTxnNote(final String txnNote) {
        this.txnNote = txnNote;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransaction setEntityType(final String entityType) {
        this.entityType = entityType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransaction setEntityId(final Long entityId) {
        this.entityId = entityId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransaction setCreatedDate(final LocalDateTime createdDate) {
        this.createdDate = createdDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierTransaction setCurrencyCode(final String currencyCode) {
        this.currencyCode = currencyCode;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public CashierTransaction() {
    }

    @java.lang.SuppressWarnings("all")
        public CashierTransaction(final Office office, final Teller teller, final Cashier cashier, final Integer txnType, final LocalDate txnDate, final BigDecimal txnAmount, final String txnNote, final String entityType, final Long entityId, final LocalDateTime createdDate, final String currencyCode) {
        this.office = office;
        this.teller = teller;
        this.cashier = cashier;
        this.txnType = txnType;
        this.txnDate = txnDate;
        this.txnAmount = txnAmount;
        this.txnNote = txnNote;
        this.entityType = entityType;
        this.entityId = entityId;
        this.createdDate = createdDate;
        this.currencyCode = currencyCode;
    }
}
