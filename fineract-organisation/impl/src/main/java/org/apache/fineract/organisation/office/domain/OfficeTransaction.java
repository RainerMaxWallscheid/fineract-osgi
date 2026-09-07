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
package org.apache.fineract.organisation.office.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Embedded;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.organisation.monetary.domain.MonetaryCurrency;
import org.apache.fineract.organisation.monetary.domain.Money;
import org.apache.fineract.organisation.office.moduleapi.OfficeAssociation;

@Entity
@Table(name = "m_office_transaction")
public class OfficeTransaction extends AbstractPersistableCustom<Long> {

    /**
     * From-office id (no JPA association to leftover Office — ADR-021).
     */
    @Column(name = "from_office_id")
    private Long fromOfficeId;

    /**
     * To-office id (no JPA association to leftover Office — ADR-021).
     */
    @Column(name = "to_office_id")
    private Long toOfficeId;

    @Column(name = "transaction_date", nullable = false)
    private LocalDate transactionDate;

    @Embedded
    private MonetaryCurrency currency;

    @Column(name = "transaction_amount", scale = 6, precision = 19, nullable = false)
    private BigDecimal transactionAmount;

    @Column(name = "description", nullable = true, length = 100)
    private String description;

    public static OfficeTransaction fromJson(final Object fromOffice, final Object toOffice, final Money amount,
            final JsonCommand command) {

        final LocalDate transactionLocalDate = command.localDateValueOfParameterNamed("transactionDate");
        final String description = command.stringValueOfParameterNamed("description");

        return new OfficeTransaction(fromOffice, toOffice, transactionLocalDate, amount, description);
    }

    protected OfficeTransaction() {
        this.transactionDate = null;
    }

    private OfficeTransaction(final Object fromOffice, final Object toOffice, final LocalDate transactionLocalDate, final Money amount,
            final String description) {
        this.fromOfficeId = OfficeAssociation.id(fromOffice);
        this.toOfficeId = OfficeAssociation.id(toOffice);
        if (transactionLocalDate != null) {
            this.transactionDate = transactionLocalDate;
        }
        this.currency = amount.getCurrency();
        this.transactionAmount = amount.getAmount();
        this.description = description;
    }
}
