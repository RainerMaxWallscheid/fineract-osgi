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
package org.apache.fineract.infrastructure.jobs.service.aggregationjob.data;

import java.math.BigDecimal;
import java.time.LocalDate;

public class JournalEntryAggregationSummaryData {
    private Long productId;
    private Long glAccountId;
    private Long office;
    private Long entityTypeEnum;
    private LocalDate submittedOnDate;
    private LocalDate aggregatedOnDate;
    private Long externalOwnerId;
    private String originatorExternalIds;
    private BigDecimal debitAmount;
    private BigDecimal creditAmount;
    private Boolean manualEntry;
    private String currencyCode;
    private Long jobExecutionId;

    @java.lang.SuppressWarnings("all")
        JournalEntryAggregationSummaryData(final Long productId, final Long glAccountId, final Long office, final Long entityTypeEnum, final LocalDate submittedOnDate, final LocalDate aggregatedOnDate, final Long externalOwnerId, final String originatorExternalIds, final BigDecimal debitAmount, final BigDecimal creditAmount, final Boolean manualEntry, final String currencyCode, final Long jobExecutionId) {
        this.productId = productId;
        this.glAccountId = glAccountId;
        this.office = office;
        this.entityTypeEnum = entityTypeEnum;
        this.submittedOnDate = submittedOnDate;
        this.aggregatedOnDate = aggregatedOnDate;
        this.externalOwnerId = externalOwnerId;
        this.originatorExternalIds = originatorExternalIds;
        this.debitAmount = debitAmount;
        this.creditAmount = creditAmount;
        this.manualEntry = manualEntry;
        this.currencyCode = currencyCode;
        this.jobExecutionId = jobExecutionId;
    }


    @java.lang.SuppressWarnings("all")
        public static class JournalEntryAggregationSummaryDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long productId;
        @java.lang.SuppressWarnings("all")
                private Long glAccountId;
        @java.lang.SuppressWarnings("all")
                private Long office;
        @java.lang.SuppressWarnings("all")
                private Long entityTypeEnum;
        @java.lang.SuppressWarnings("all")
                private LocalDate submittedOnDate;
        @java.lang.SuppressWarnings("all")
                private LocalDate aggregatedOnDate;
        @java.lang.SuppressWarnings("all")
                private Long externalOwnerId;
        @java.lang.SuppressWarnings("all")
                private String originatorExternalIds;
        @java.lang.SuppressWarnings("all")
                private BigDecimal debitAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal creditAmount;
        @java.lang.SuppressWarnings("all")
                private Boolean manualEntry;
        @java.lang.SuppressWarnings("all")
                private String currencyCode;
        @java.lang.SuppressWarnings("all")
                private Long jobExecutionId;

        @java.lang.SuppressWarnings("all")
                JournalEntryAggregationSummaryDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder productId(final Long productId) {
            this.productId = productId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder glAccountId(final Long glAccountId) {
            this.glAccountId = glAccountId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder office(final Long office) {
            this.office = office;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder entityTypeEnum(final Long entityTypeEnum) {
            this.entityTypeEnum = entityTypeEnum;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder submittedOnDate(final LocalDate submittedOnDate) {
            this.submittedOnDate = submittedOnDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder aggregatedOnDate(final LocalDate aggregatedOnDate) {
            this.aggregatedOnDate = aggregatedOnDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder externalOwnerId(final Long externalOwnerId) {
            this.externalOwnerId = externalOwnerId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder originatorExternalIds(final String originatorExternalIds) {
            this.originatorExternalIds = originatorExternalIds;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder debitAmount(final BigDecimal debitAmount) {
            this.debitAmount = debitAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder creditAmount(final BigDecimal creditAmount) {
            this.creditAmount = creditAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder manualEntry(final Boolean manualEntry) {
            this.manualEntry = manualEntry;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder currencyCode(final String currencyCode) {
            this.currencyCode = currencyCode;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder jobExecutionId(final Long jobExecutionId) {
            this.jobExecutionId = jobExecutionId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationSummaryData build() {
            return new JournalEntryAggregationSummaryData(this.productId, this.glAccountId, this.office, this.entityTypeEnum, this.submittedOnDate, this.aggregatedOnDate, this.externalOwnerId, this.originatorExternalIds, this.debitAmount, this.creditAmount, this.manualEntry, this.currencyCode, this.jobExecutionId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder(productId=" + this.productId + ", glAccountId=" + this.glAccountId + ", office=" + this.office + ", entityTypeEnum=" + this.entityTypeEnum + ", submittedOnDate=" + this.submittedOnDate + ", aggregatedOnDate=" + this.aggregatedOnDate + ", externalOwnerId=" + this.externalOwnerId + ", originatorExternalIds=" + this.originatorExternalIds + ", debitAmount=" + this.debitAmount + ", creditAmount=" + this.creditAmount + ", manualEntry=" + this.manualEntry + ", currencyCode=" + this.currencyCode + ", jobExecutionId=" + this.jobExecutionId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder builder() {
        return new JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder toBuilder() {
        return new JournalEntryAggregationSummaryData.JournalEntryAggregationSummaryDataBuilder().productId(this.productId).glAccountId(this.glAccountId).office(this.office).entityTypeEnum(this.entityTypeEnum).submittedOnDate(this.submittedOnDate).aggregatedOnDate(this.aggregatedOnDate).externalOwnerId(this.externalOwnerId).originatorExternalIds(this.originatorExternalIds).debitAmount(this.debitAmount).creditAmount(this.creditAmount).manualEntry(this.manualEntry).currencyCode(this.currencyCode).jobExecutionId(this.jobExecutionId);
    }

    @java.lang.SuppressWarnings("all")
        public Long getProductId() {
        return this.productId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getGlAccountId() {
        return this.glAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOffice() {
        return this.office;
    }

    @java.lang.SuppressWarnings("all")
        public Long getEntityTypeEnum() {
        return this.entityTypeEnum;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSubmittedOnDate() {
        return this.submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getAggregatedOnDate() {
        return this.aggregatedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public Long getExternalOwnerId() {
        return this.externalOwnerId;
    }

    @java.lang.SuppressWarnings("all")
        public String getOriginatorExternalIds() {
        return this.originatorExternalIds;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDebitAmount() {
        return this.debitAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getCreditAmount() {
        return this.creditAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getManualEntry() {
        return this.manualEntry;
    }

    @java.lang.SuppressWarnings("all")
        public String getCurrencyCode() {
        return this.currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public Long getJobExecutionId() {
        return this.jobExecutionId;
    }

    @java.lang.SuppressWarnings("all")
        public void setProductId(final Long productId) {
        this.productId = productId;
    }

    @java.lang.SuppressWarnings("all")
        public void setGlAccountId(final Long glAccountId) {
        this.glAccountId = glAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public void setOffice(final Long office) {
        this.office = office;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntityTypeEnum(final Long entityTypeEnum) {
        this.entityTypeEnum = entityTypeEnum;
    }

    @java.lang.SuppressWarnings("all")
        public void setSubmittedOnDate(final LocalDate submittedOnDate) {
        this.submittedOnDate = submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setAggregatedOnDate(final LocalDate aggregatedOnDate) {
        this.aggregatedOnDate = aggregatedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalOwnerId(final Long externalOwnerId) {
        this.externalOwnerId = externalOwnerId;
    }

    @java.lang.SuppressWarnings("all")
        public void setOriginatorExternalIds(final String originatorExternalIds) {
        this.originatorExternalIds = originatorExternalIds;
    }

    @java.lang.SuppressWarnings("all")
        public void setDebitAmount(final BigDecimal debitAmount) {
        this.debitAmount = debitAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreditAmount(final BigDecimal creditAmount) {
        this.creditAmount = creditAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setManualEntry(final Boolean manualEntry) {
        this.manualEntry = manualEntry;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrencyCode(final String currencyCode) {
        this.currencyCode = currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public void setJobExecutionId(final Long jobExecutionId) {
        this.jobExecutionId = jobExecutionId;
    }
}
