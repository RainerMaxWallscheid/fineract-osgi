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
package org.apache.fineract.investor.data;

import org.apache.fineract.accounting.journalentry.data.JournalEntryData;
import org.springframework.data.domain.Page;

public class ExternalOwnerJournalEntryData {
    private ExternalTransferOwnerData ownerData;
    private Page<JournalEntryData> journalEntryData;

    @java.lang.SuppressWarnings("all")
        public ExternalOwnerJournalEntryData() {
    }

    @java.lang.SuppressWarnings("all")
        public ExternalTransferOwnerData getOwnerData() {
        return this.ownerData;
    }

    @java.lang.SuppressWarnings("all")
        public Page<JournalEntryData> getJournalEntryData() {
        return this.journalEntryData;
    }

    @java.lang.SuppressWarnings("all")
        public void setOwnerData(final ExternalTransferOwnerData ownerData) {
        this.ownerData = ownerData;
    }

    @java.lang.SuppressWarnings("all")
        public void setJournalEntryData(final Page<JournalEntryData> journalEntryData) {
        this.journalEntryData = journalEntryData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ExternalOwnerJournalEntryData)) return false;
        final ExternalOwnerJournalEntryData other = (ExternalOwnerJournalEntryData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$ownerData = this.getOwnerData();
        final java.lang.Object other$ownerData = other.getOwnerData();
        if (this$ownerData == null ? other$ownerData != null : !this$ownerData.equals(other$ownerData)) return false;
        final java.lang.Object this$journalEntryData = this.getJournalEntryData();
        final java.lang.Object other$journalEntryData = other.getJournalEntryData();
        if (this$journalEntryData == null ? other$journalEntryData != null : !this$journalEntryData.equals(other$journalEntryData)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ExternalOwnerJournalEntryData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $ownerData = this.getOwnerData();
        result = result * PRIME + ($ownerData == null ? 43 : $ownerData.hashCode());
        final java.lang.Object $journalEntryData = this.getJournalEntryData();
        result = result * PRIME + ($journalEntryData == null ? 43 : $journalEntryData.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ExternalOwnerJournalEntryData(ownerData=" + this.getOwnerData() + ", journalEntryData=" + this.getJournalEntryData() + ")";
    }
}
