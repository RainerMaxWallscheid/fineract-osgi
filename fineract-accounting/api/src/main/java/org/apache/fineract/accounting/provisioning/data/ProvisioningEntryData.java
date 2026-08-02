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
package org.apache.fineract.accounting.provisioning.data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Collection;

@SuppressWarnings("unused")
public class ProvisioningEntryData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private Boolean journalEntry;
    private Long createdById;
    private String createdUser;
    private LocalDate createdDate;
    private Long modifiedById;
    private String modifiedUser;
    private BigDecimal reservedAmount;
    private Collection<LoanProductProvisioningEntryData> provisioningEntries;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getJournalEntry() {
        return this.journalEntry;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCreatedById() {
        return this.createdById;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreatedUser() {
        return this.createdUser;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getCreatedDate() {
        return this.createdDate;
    }

    @java.lang.SuppressWarnings("all")
        public Long getModifiedById() {
        return this.modifiedById;
    }

    @java.lang.SuppressWarnings("all")
        public String getModifiedUser() {
        return this.modifiedUser;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getReservedAmount() {
        return this.reservedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LoanProductProvisioningEntryData> getProvisioningEntries() {
        return this.provisioningEntries;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningEntryData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningEntryData setJournalEntry(final Boolean journalEntry) {
        this.journalEntry = journalEntry;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningEntryData setCreatedById(final Long createdById) {
        this.createdById = createdById;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningEntryData setCreatedUser(final String createdUser) {
        this.createdUser = createdUser;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningEntryData setCreatedDate(final LocalDate createdDate) {
        this.createdDate = createdDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningEntryData setModifiedById(final Long modifiedById) {
        this.modifiedById = modifiedById;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningEntryData setModifiedUser(final String modifiedUser) {
        this.modifiedUser = modifiedUser;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningEntryData setReservedAmount(final BigDecimal reservedAmount) {
        this.reservedAmount = reservedAmount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningEntryData setProvisioningEntries(final Collection<LoanProductProvisioningEntryData> provisioningEntries) {
        this.provisioningEntries = provisioningEntries;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ProvisioningEntryData)) return false;
        final ProvisioningEntryData other = (ProvisioningEntryData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$journalEntry = this.getJournalEntry();
        final java.lang.Object other$journalEntry = other.getJournalEntry();
        if (this$journalEntry == null ? other$journalEntry != null : !this$journalEntry.equals(other$journalEntry)) return false;
        final java.lang.Object this$createdById = this.getCreatedById();
        final java.lang.Object other$createdById = other.getCreatedById();
        if (this$createdById == null ? other$createdById != null : !this$createdById.equals(other$createdById)) return false;
        final java.lang.Object this$modifiedById = this.getModifiedById();
        final java.lang.Object other$modifiedById = other.getModifiedById();
        if (this$modifiedById == null ? other$modifiedById != null : !this$modifiedById.equals(other$modifiedById)) return false;
        final java.lang.Object this$createdUser = this.getCreatedUser();
        final java.lang.Object other$createdUser = other.getCreatedUser();
        if (this$createdUser == null ? other$createdUser != null : !this$createdUser.equals(other$createdUser)) return false;
        final java.lang.Object this$createdDate = this.getCreatedDate();
        final java.lang.Object other$createdDate = other.getCreatedDate();
        if (this$createdDate == null ? other$createdDate != null : !this$createdDate.equals(other$createdDate)) return false;
        final java.lang.Object this$modifiedUser = this.getModifiedUser();
        final java.lang.Object other$modifiedUser = other.getModifiedUser();
        if (this$modifiedUser == null ? other$modifiedUser != null : !this$modifiedUser.equals(other$modifiedUser)) return false;
        final java.lang.Object this$reservedAmount = this.getReservedAmount();
        final java.lang.Object other$reservedAmount = other.getReservedAmount();
        if (this$reservedAmount == null ? other$reservedAmount != null : !this$reservedAmount.equals(other$reservedAmount)) return false;
        final java.lang.Object this$provisioningEntries = this.getProvisioningEntries();
        final java.lang.Object other$provisioningEntries = other.getProvisioningEntries();
        if (this$provisioningEntries == null ? other$provisioningEntries != null : !this$provisioningEntries.equals(other$provisioningEntries)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ProvisioningEntryData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $journalEntry = this.getJournalEntry();
        result = result * PRIME + ($journalEntry == null ? 43 : $journalEntry.hashCode());
        final java.lang.Object $createdById = this.getCreatedById();
        result = result * PRIME + ($createdById == null ? 43 : $createdById.hashCode());
        final java.lang.Object $modifiedById = this.getModifiedById();
        result = result * PRIME + ($modifiedById == null ? 43 : $modifiedById.hashCode());
        final java.lang.Object $createdUser = this.getCreatedUser();
        result = result * PRIME + ($createdUser == null ? 43 : $createdUser.hashCode());
        final java.lang.Object $createdDate = this.getCreatedDate();
        result = result * PRIME + ($createdDate == null ? 43 : $createdDate.hashCode());
        final java.lang.Object $modifiedUser = this.getModifiedUser();
        result = result * PRIME + ($modifiedUser == null ? 43 : $modifiedUser.hashCode());
        final java.lang.Object $reservedAmount = this.getReservedAmount();
        result = result * PRIME + ($reservedAmount == null ? 43 : $reservedAmount.hashCode());
        final java.lang.Object $provisioningEntries = this.getProvisioningEntries();
        result = result * PRIME + ($provisioningEntries == null ? 43 : $provisioningEntries.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ProvisioningEntryData(id=" + this.getId() + ", journalEntry=" + this.getJournalEntry() + ", createdById=" + this.getCreatedById() + ", createdUser=" + this.getCreatedUser() + ", createdDate=" + this.getCreatedDate() + ", modifiedById=" + this.getModifiedById() + ", modifiedUser=" + this.getModifiedUser() + ", reservedAmount=" + this.getReservedAmount() + ", provisioningEntries=" + this.getProvisioningEntries() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ProvisioningEntryData() {
    }
}
