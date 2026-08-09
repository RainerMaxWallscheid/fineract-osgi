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
package org.apache.fineract.infrastructure.jobs.service.retainedearning.data;

import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.domain.ExternalId;

public class AccountGLJournalEntryAnnualSummaryData {
    private Long productId;
    private String productName;
    private String glAccountCode;
    private Long officeId;
    private ExternalId ownerExternalId;
    private Boolean manualEntry;
    private BigDecimal openingBalanceAmount;
    private BigDecimal endingBalanceAmount;
    private LocalDate yearEndDate;
    private String currencyCode;

    @java.lang.SuppressWarnings("all")
        AccountGLJournalEntryAnnualSummaryData(final Long productId, final String productName, final String glAccountCode, final Long officeId, final ExternalId ownerExternalId, final Boolean manualEntry, final BigDecimal openingBalanceAmount, final BigDecimal endingBalanceAmount, final LocalDate yearEndDate, final String currencyCode) {
        this.productId = productId;
        this.productName = productName;
        this.glAccountCode = glAccountCode;
        this.officeId = officeId;
        this.ownerExternalId = ownerExternalId;
        this.manualEntry = manualEntry;
        this.openingBalanceAmount = openingBalanceAmount;
        this.endingBalanceAmount = endingBalanceAmount;
        this.yearEndDate = yearEndDate;
        this.currencyCode = currencyCode;
    }


    @java.lang.SuppressWarnings("all")
        public static class AccountGLJournalEntryAnnualSummaryDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long productId;
        @java.lang.SuppressWarnings("all")
                private String productName;
        @java.lang.SuppressWarnings("all")
                private String glAccountCode;
        @java.lang.SuppressWarnings("all")
                private Long officeId;
        @java.lang.SuppressWarnings("all")
                private ExternalId ownerExternalId;
        @java.lang.SuppressWarnings("all")
                private Boolean manualEntry;
        @java.lang.SuppressWarnings("all")
                private BigDecimal openingBalanceAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal endingBalanceAmount;
        @java.lang.SuppressWarnings("all")
                private LocalDate yearEndDate;
        @java.lang.SuppressWarnings("all")
                private String currencyCode;

        @java.lang.SuppressWarnings("all")
                AccountGLJournalEntryAnnualSummaryDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryData.AccountGLJournalEntryAnnualSummaryDataBuilder productId(final Long productId) {
            this.productId = productId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryData.AccountGLJournalEntryAnnualSummaryDataBuilder productName(final String productName) {
            this.productName = productName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryData.AccountGLJournalEntryAnnualSummaryDataBuilder glAccountCode(final String glAccountCode) {
            this.glAccountCode = glAccountCode;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryData.AccountGLJournalEntryAnnualSummaryDataBuilder officeId(final Long officeId) {
            this.officeId = officeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryData.AccountGLJournalEntryAnnualSummaryDataBuilder ownerExternalId(final ExternalId ownerExternalId) {
            this.ownerExternalId = ownerExternalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryData.AccountGLJournalEntryAnnualSummaryDataBuilder manualEntry(final Boolean manualEntry) {
            this.manualEntry = manualEntry;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryData.AccountGLJournalEntryAnnualSummaryDataBuilder openingBalanceAmount(final BigDecimal openingBalanceAmount) {
            this.openingBalanceAmount = openingBalanceAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryData.AccountGLJournalEntryAnnualSummaryDataBuilder endingBalanceAmount(final BigDecimal endingBalanceAmount) {
            this.endingBalanceAmount = endingBalanceAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryData.AccountGLJournalEntryAnnualSummaryDataBuilder yearEndDate(final LocalDate yearEndDate) {
            this.yearEndDate = yearEndDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryData.AccountGLJournalEntryAnnualSummaryDataBuilder currencyCode(final String currencyCode) {
            this.currencyCode = currencyCode;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public AccountGLJournalEntryAnnualSummaryData build() {
            return new AccountGLJournalEntryAnnualSummaryData(this.productId, this.productName, this.glAccountCode, this.officeId, this.ownerExternalId, this.manualEntry, this.openingBalanceAmount, this.endingBalanceAmount, this.yearEndDate, this.currencyCode);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "AccountGLJournalEntryAnnualSummaryData.AccountGLJournalEntryAnnualSummaryDataBuilder(productId=" + this.productId + ", productName=" + this.productName + ", glAccountCode=" + this.glAccountCode + ", officeId=" + this.officeId + ", ownerExternalId=" + this.ownerExternalId + ", manualEntry=" + this.manualEntry + ", openingBalanceAmount=" + this.openingBalanceAmount + ", endingBalanceAmount=" + this.endingBalanceAmount + ", yearEndDate=" + this.yearEndDate + ", currencyCode=" + this.currencyCode + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static AccountGLJournalEntryAnnualSummaryData.AccountGLJournalEntryAnnualSummaryDataBuilder builder() {
        return new AccountGLJournalEntryAnnualSummaryData.AccountGLJournalEntryAnnualSummaryDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public AccountGLJournalEntryAnnualSummaryData.AccountGLJournalEntryAnnualSummaryDataBuilder toBuilder() {
        return new AccountGLJournalEntryAnnualSummaryData.AccountGLJournalEntryAnnualSummaryDataBuilder().productId(this.productId).productName(this.productName).glAccountCode(this.glAccountCode).officeId(this.officeId).ownerExternalId(this.ownerExternalId).manualEntry(this.manualEntry).openingBalanceAmount(this.openingBalanceAmount).endingBalanceAmount(this.endingBalanceAmount).yearEndDate(this.yearEndDate).currencyCode(this.currencyCode);
    }

    @java.lang.SuppressWarnings("all")
        public Long getProductId() {
        return this.productId;
    }

    @java.lang.SuppressWarnings("all")
        public String getProductName() {
        return this.productName;
    }

    @java.lang.SuppressWarnings("all")
        public String getGlAccountCode() {
        return this.glAccountCode;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getOwnerExternalId() {
        return this.ownerExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getManualEntry() {
        return this.manualEntry;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOpeningBalanceAmount() {
        return this.openingBalanceAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getEndingBalanceAmount() {
        return this.endingBalanceAmount;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getYearEndDate() {
        return this.yearEndDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getCurrencyCode() {
        return this.currencyCode;
    }
}
