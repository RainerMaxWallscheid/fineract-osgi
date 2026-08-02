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
package org.apache.fineract.portfolio.loanaccount.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Version;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;

@Entity
@Table(name = "m_loan_progressive_model")
public class ProgressiveLoanModel extends AbstractPersistableCustom<Long> {
    @Version
    int version;
    @OneToOne
    @JoinColumn(name = "loan_id", nullable = false)
    private Loan loan;
    @Column(name = "json_model", columnDefinition = "text", nullable = false)
    private String jsonModel;
    @Column(name = "business_date", nullable = false)
    private LocalDate businessDate;
    @Column(name = "last_modified_on_utc", nullable = false)
    private OffsetDateTime lastModifiedDate;
    @Column(name = "json_model_version", nullable = false)
    private String jsonModelVersion;

    @java.lang.SuppressWarnings("all")
        public int getVersion() {
        return this.version;
    }

    @java.lang.SuppressWarnings("all")
        public Loan getLoan() {
        return this.loan;
    }

    @java.lang.SuppressWarnings("all")
        public String getJsonModel() {
        return this.jsonModel;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getBusinessDate() {
        return this.businessDate;
    }

    @java.lang.SuppressWarnings("all")
        public OffsetDateTime getLastModifiedDate() {
        return this.lastModifiedDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getJsonModelVersion() {
        return this.jsonModelVersion;
    }

    @java.lang.SuppressWarnings("all")
        public void setVersion(final int version) {
        this.version = version;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoan(final Loan loan) {
        this.loan = loan;
    }

    @java.lang.SuppressWarnings("all")
        public void setJsonModel(final String jsonModel) {
        this.jsonModel = jsonModel;
    }

    @java.lang.SuppressWarnings("all")
        public void setBusinessDate(final LocalDate businessDate) {
        this.businessDate = businessDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setLastModifiedDate(final OffsetDateTime lastModifiedDate) {
        this.lastModifiedDate = lastModifiedDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setJsonModelVersion(final String jsonModelVersion) {
        this.jsonModelVersion = jsonModelVersion;
    }
}
