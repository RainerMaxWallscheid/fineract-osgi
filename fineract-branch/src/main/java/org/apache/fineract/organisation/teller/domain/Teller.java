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
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import org.apache.fineract.accounting.glaccount.domain.GLAccount;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.organisation.office.domain.Office;

@Entity
@Table(name = "m_tellers", uniqueConstraints = {@UniqueConstraint(name = "ux_tellers_name", columnNames = {"name"})})
public class Teller extends AbstractPersistableCustom<Long> {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "office_id", nullable = false)
    private Office office;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "debit_account_id", nullable = true)
    private GLAccount debitAccount;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "credit_account_id", nullable = true)
    private GLAccount creditAccount;
    @Column(name = "name", nullable = false, length = 100)
    private String name;
    @Column(name = "description", nullable = true, length = 500)
    private String description;
    @Column(name = "valid_from", nullable = true)
    private LocalDate startDate;
    @Column(name = "valid_to", nullable = true)
    private LocalDate endDate;
    @Column(name = "state", nullable = false)
    private Integer status;
    @OneToMany(mappedBy = "teller", fetch = FetchType.LAZY)
    private Set<Cashier> cashiers;

    public static Teller fromJson(final Office tellerOffice, final JsonCommand command) {
        final String name = command.stringValueOfParameterNamed("name");
        final String description = command.stringValueOfParameterNamed("description");
        final LocalDate startDate = command.localDateValueOfParameterNamed("startDate");
        final LocalDate endDate = command.localDateValueOfParameterNamed("endDate");
        final Integer tellerStatusInt = command.integerValueOfParameterNamed("status");
        final TellerStatus status = TellerStatus.fromInt(tellerStatusInt);
        return new Teller().setOffice(tellerOffice).setName(name).setDescription(description).setStartDate(startDate).setEndDate(endDate).setStatus(status.getValue());
    }

    public Map<String, Object> update(Office tellerOffice, final JsonCommand command) {
        final Map<String, Object> actualChanges = new LinkedHashMap<>(7);
        final String dateFormatAsInput = command.dateFormat();
        final String localeAsInput = command.locale();
        final String officeIdParamName = "officeId";
        if (command.isChangeInLongParameterNamed(officeIdParamName, this.officeId())) {
            final long newValue = command.longValueOfParameterNamed(officeIdParamName);
            actualChanges.put(officeIdParamName, newValue);
            this.office = tellerOffice;
        }
        final String nameParamName = "name";
        if (command.isChangeInStringParameterNamed(nameParamName, this.name)) {
            final String newValue = command.stringValueOfParameterNamed(nameParamName);
            actualChanges.put(nameParamName, newValue);
            this.name = newValue;
        }
        final String descriptionParamName = "description";
        if (command.isChangeInStringParameterNamed(descriptionParamName, this.description)) {
            final String newValue = command.stringValueOfParameterNamed(descriptionParamName);
            actualChanges.put(descriptionParamName, newValue);
            this.description = newValue;
        }
        final String startDateParamName = "startDate";
        if (command.isChangeInLocalDateParameterNamed(startDateParamName, this.startDate)) {
            final String valueAsInput = command.stringValueOfParameterNamed(startDateParamName);
            actualChanges.put(startDateParamName, valueAsInput);
            actualChanges.put("dateFormat", dateFormatAsInput);
            actualChanges.put("locale", localeAsInput);
            this.startDate = command.localDateValueOfParameterNamed(startDateParamName);
        }
        final String endDateParamName = "endDate";
        if (command.isChangeInLocalDateParameterNamed(endDateParamName, this.endDate)) {
            final String valueAsInput = command.stringValueOfParameterNamed(endDateParamName);
            actualChanges.put(endDateParamName, valueAsInput);
            actualChanges.put("dateFormat", dateFormatAsInput);
            actualChanges.put("locale", localeAsInput);
            this.endDate = command.localDateValueOfParameterNamed(endDateParamName);
        }
        final String statusParamName = "status";
        if (command.isChangeInIntegerParameterNamed(statusParamName, getStatus())) {
            final Integer valueAsInput = command.integerValueOfParameterNamed(statusParamName);
            actualChanges.put(statusParamName, valueAsInput);
            final Integer newValue = command.integerValueOfParameterNamed(statusParamName);
            final TellerStatus status = TellerStatus.fromInt(newValue);
            if (status != TellerStatus.INVALID) {
                this.status = status.getValue();
            }
        }
        return actualChanges;
    }

    public Long officeId() {
        return this.office.getId();
    }

    public void initializeLazyCollections() {
        this.office.getId();
        this.cashiers.size();
    }

    @java.lang.SuppressWarnings("all")
        public Office getOffice() {
        return this.office;
    }

    @java.lang.SuppressWarnings("all")
        public GLAccount getDebitAccount() {
        return this.debitAccount;
    }

    @java.lang.SuppressWarnings("all")
        public GLAccount getCreditAccount() {
        return this.creditAccount;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
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
        public Integer getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public Set<Cashier> getCashiers() {
        return this.cashiers;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Teller setOffice(final Office office) {
        this.office = office;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Teller setDebitAccount(final GLAccount debitAccount) {
        this.debitAccount = debitAccount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Teller setCreditAccount(final GLAccount creditAccount) {
        this.creditAccount = creditAccount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Teller setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Teller setDescription(final String description) {
        this.description = description;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Teller setStartDate(final LocalDate startDate) {
        this.startDate = startDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Teller setEndDate(final LocalDate endDate) {
        this.endDate = endDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Teller setStatus(final Integer status) {
        this.status = status;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Teller setCashiers(final Set<Cashier> cashiers) {
        this.cashiers = cashiers;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public Teller() {
    }

    @java.lang.SuppressWarnings("all")
        public Teller(final Office office, final GLAccount debitAccount, final GLAccount creditAccount, final String name, final String description, final LocalDate startDate, final LocalDate endDate, final Integer status, final Set<Cashier> cashiers) {
        this.office = office;
        this.debitAccount = debitAccount;
        this.creditAccount = creditAccount;
        this.name = name;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.cashiers = cashiers;
    }
}
