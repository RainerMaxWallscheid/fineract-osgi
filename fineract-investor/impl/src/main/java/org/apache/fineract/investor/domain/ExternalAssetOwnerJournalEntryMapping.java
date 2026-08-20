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
package org.apache.fineract.investor.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;

@Table(name = "m_external_asset_owner_journal_entry_mapping")
@Entity
public class ExternalAssetOwnerJournalEntryMapping extends AbstractAuditableWithUTCDateTimeCustom<Long> {
    /**
     * Journal entry id (no JPA association to leftover JournalEntry — ADR-021 / charge Step 8).
     */
    @Column(name = "journal_entry_id", nullable = false)
    private Long journalEntryId;
    @ManyToOne
    @JoinColumn(name = "owner_id", nullable = false)
    private ExternalAssetOwner owner;

    @java.lang.SuppressWarnings("all")
        public Long getJournalEntryId() {
        return this.journalEntryId;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalAssetOwner getOwner() {
        return this.owner;
    }

    @java.lang.SuppressWarnings("all")
        public void setJournalEntryId(final Long journalEntryId) {
        this.journalEntryId = journalEntryId;
    }

    @java.lang.SuppressWarnings("all")
        public void setOwner(final ExternalAssetOwner owner) {
        this.owner = owner;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalAssetOwnerJournalEntryMapping() {
    }
}
