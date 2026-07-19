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

public class ExternalOwnerTransferJournalEntryData {
    private ExternalTransferData transferData;
    private Page<JournalEntryData> journalEntryData;

    @java.lang.SuppressWarnings("all")
        public ExternalOwnerTransferJournalEntryData() {
    }

    @java.lang.SuppressWarnings("all")
        public ExternalTransferData getTransferData() {
        return this.transferData;
    }

    @java.lang.SuppressWarnings("all")
        public Page<JournalEntryData> getJournalEntryData() {
        return this.journalEntryData;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransferData(final ExternalTransferData transferData) {
        this.transferData = transferData;
    }

    @java.lang.SuppressWarnings("all")
        public void setJournalEntryData(final Page<JournalEntryData> journalEntryData) {
        this.journalEntryData = journalEntryData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ExternalOwnerTransferJournalEntryData)) return false;
        final ExternalOwnerTransferJournalEntryData other = (ExternalOwnerTransferJournalEntryData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$transferData = this.getTransferData();
        final java.lang.Object other$transferData = other.getTransferData();
        if (this$transferData == null ? other$transferData != null : !this$transferData.equals(other$transferData)) return false;
        final java.lang.Object this$journalEntryData = this.getJournalEntryData();
        final java.lang.Object other$journalEntryData = other.getJournalEntryData();
        if (this$journalEntryData == null ? other$journalEntryData != null : !this$journalEntryData.equals(other$journalEntryData)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ExternalOwnerTransferJournalEntryData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $transferData = this.getTransferData();
        result = result * PRIME + ($transferData == null ? 43 : $transferData.hashCode());
        final java.lang.Object $journalEntryData = this.getJournalEntryData();
        result = result * PRIME + ($journalEntryData == null ? 43 : $journalEntryData.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ExternalOwnerTransferJournalEntryData(transferData=" + this.getTransferData() + ", journalEntryData=" + this.getJournalEntryData() + ")";
    }
}
