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
package org.apache.fineract.accounting.provisioning.domain;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import java.time.LocalDate;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.useradministration.domain.AppUser;

@Entity
@Table(name = "m_provisioning_history")
public class ProvisioningEntry extends AbstractPersistableCustom<Long> {
    @Column(name = "journal_entry_created")
    private Boolean isJournalEntryCreated;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "entry", orphanRemoval = true, fetch = FetchType.EAGER)
    private Set<LoanProductProvisioningEntry> provisioningEntries = new HashSet<>();
    @OneToOne
    @JoinColumn(name = "createdby_id")
    private AppUser createdBy;
    @Column(name = "created_date")
    private LocalDate createdDate;
    @OneToOne
    @JoinColumn(name = "lastmodifiedby_id")
    private AppUser lastModifiedBy;
    @Column(name = "lastmodified_date")
    private LocalDate lastModifiedDate;

    public void setProvisioningEntries(Collection<LoanProductProvisioningEntry> provisioningEntries) {
        if (this.provisioningEntries == null) {
            this.provisioningEntries = new HashSet<>();
        }
        this.provisioningEntries.addAll(provisioningEntries);
    }

    public Collection<LoanProductProvisioningEntry> getLoanProductProvisioningEntries() {
        return this.provisioningEntries;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsJournalEntryCreated() {
        return this.isJournalEntryCreated;
    }

    @java.lang.SuppressWarnings("all")
        public Set<LoanProductProvisioningEntry> getProvisioningEntries() {
        return this.provisioningEntries;
    }

    @java.lang.SuppressWarnings("all")
        public AppUser getCreatedBy() {
        return this.createdBy;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getCreatedDate() {
        return this.createdDate;
    }

    @java.lang.SuppressWarnings("all")
        public AppUser getLastModifiedBy() {
        return this.lastModifiedBy;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getLastModifiedDate() {
        return this.lastModifiedDate;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningEntry setIsJournalEntryCreated(final Boolean isJournalEntryCreated) {
        this.isJournalEntryCreated = isJournalEntryCreated;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningEntry setCreatedBy(final AppUser createdBy) {
        this.createdBy = createdBy;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningEntry setCreatedDate(final LocalDate createdDate) {
        this.createdDate = createdDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningEntry setLastModifiedBy(final AppUser lastModifiedBy) {
        this.lastModifiedBy = lastModifiedBy;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningEntry setLastModifiedDate(final LocalDate lastModifiedDate) {
        this.lastModifiedDate = lastModifiedDate;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public ProvisioningEntry() {
    }
}
