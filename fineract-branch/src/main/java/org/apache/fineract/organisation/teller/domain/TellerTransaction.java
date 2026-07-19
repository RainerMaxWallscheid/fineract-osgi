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
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.organisation.office.domain.Office;
import org.apache.fineract.portfolio.client.domain.Client;

@Entity
@Table(name = "m_teller_transactions")
public class TellerTransaction extends AbstractPersistableCustom<Long> {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "office_id", nullable = false)
    private Office office;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "teller_id", nullable = false)
    private Teller teller;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cashier_id", nullable = false)
    private Cashier cashier;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "client_id", nullable = false)
    private Client client;
    @Column(name = "type", nullable = false)
    private Integer type;
    @Column(name = "amount", nullable = false)
    private Double amount;
    @Column(name = "posting_date", nullable = false)
    private LocalDate postingDate;

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
        public Client getClient() {
        return this.client;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getType() {
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
        public TellerTransaction setOffice(final Office office) {
        this.office = office;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerTransaction setTeller(final Teller teller) {
        this.teller = teller;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerTransaction setCashier(final Cashier cashier) {
        this.cashier = cashier;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerTransaction setClient(final Client client) {
        this.client = client;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerTransaction setType(final Integer type) {
        this.type = type;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerTransaction setAmount(final Double amount) {
        this.amount = amount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerTransaction setPostingDate(final LocalDate postingDate) {
        this.postingDate = postingDate;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public TellerTransaction() {
    }

    @java.lang.SuppressWarnings("all")
        public TellerTransaction(final Office office, final Teller teller, final Cashier cashier, final Client client, final Integer type, final Double amount, final LocalDate postingDate) {
        this.office = office;
        this.teller = teller;
        this.cashier = cashier;
        this.client = client;
        this.type = type;
        this.amount = amount;
        this.postingDate = postingDate;
    }
}
