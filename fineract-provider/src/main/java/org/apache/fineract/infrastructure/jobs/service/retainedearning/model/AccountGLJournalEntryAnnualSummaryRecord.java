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
package org.apache.fineract.infrastructure.jobs.service.retainedearning.model;

import java.math.BigDecimal;
import org.apache.fineract.infrastructure.core.domain.ExternalId;

public class AccountGLJournalEntryAnnualSummaryRecord {
    private String postingDate;
    private String product;
    private String glAcct;
    private ExternalId assetOwner;
    private BigDecimal endingBalance;

    @java.lang.SuppressWarnings("all")
        AccountGLJournalEntryAnnualSummaryRecord(final String postingDate, final String product, final String glAcct, final ExternalId assetOwner, final BigDecimal endingBalance) {
        this.postingDate = postingDate;
        this.product = product;
        this.glAcct = glAcct;
        this.assetOwner = assetOwner;
        this.endingBalance = endingBalance;
    }


    @java.lang.SuppressWarnings("all")
        public static class AccountGLJournalEntryAnnualSummaryRecordBuilder {
        @java.lang.SuppressWarnings("all")
                private String postingDate;
        @java.lang.SuppressWarnings("all")
                private String product;
        @java.lang.SuppressWarnings("all")
                private String glAcct;
        @java.lang.SuppressWarnings("all")
                private ExternalId assetOwner;
        @java.lang.SuppressWarnings("all")
                private BigDecimal endingBalance;

        @java.lang.SuppressWarnings("all")
                AccountGLJournalEntryAnnualSummaryRecordBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryRecord.AccountGLJournalEntryAnnualSummaryRecordBuilder postingDate(final String postingDate) {
            this.postingDate = postingDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryRecord.AccountGLJournalEntryAnnualSummaryRecordBuilder product(final String product) {
            this.product = product;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryRecord.AccountGLJournalEntryAnnualSummaryRecordBuilder glAcct(final String glAcct) {
            this.glAcct = glAcct;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryRecord.AccountGLJournalEntryAnnualSummaryRecordBuilder assetOwner(final ExternalId assetOwner) {
            this.assetOwner = assetOwner;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryRecord.AccountGLJournalEntryAnnualSummaryRecordBuilder endingBalance(final BigDecimal endingBalance) {
            this.endingBalance = endingBalance;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryRecord build() {
            return new AccountGLJournalEntryAnnualSummaryRecord(this.postingDate, this.product, this.glAcct, this.assetOwner, this.endingBalance);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "AccountGLJournalEntryAnnualSummaryRecord.AccountGLJournalEntryAnnualSummaryRecordBuilder(postingDate=" + this.postingDate + ", product=" + this.product + ", glAcct=" + this.glAcct + ", assetOwner=" + this.assetOwner + ", endingBalance=" + this.endingBalance + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static AccountGLJournalEntryAnnualSummaryRecord.AccountGLJournalEntryAnnualSummaryRecordBuilder builder() {
        return new AccountGLJournalEntryAnnualSummaryRecord.AccountGLJournalEntryAnnualSummaryRecordBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getPostingDate() {
        return this.postingDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getProduct() {
        return this.product;
    }

    @java.lang.SuppressWarnings("all")
        public String getGlAcct() {
        return this.glAcct;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getAssetOwner() {
        return this.assetOwner;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getEndingBalance() {
        return this.endingBalance;
    }
}
