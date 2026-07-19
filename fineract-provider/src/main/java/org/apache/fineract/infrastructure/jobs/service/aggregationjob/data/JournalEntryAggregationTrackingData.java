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

import java.time.LocalDate;

public class JournalEntryAggregationTrackingData {
    private LocalDate aggregatedOnDateFrom;
    private LocalDate aggregatedOnDateTo;
    private LocalDate submittedOnDate;
    private Long jobExecutionId;

    @java.lang.SuppressWarnings("all")
        JournalEntryAggregationTrackingData(final LocalDate aggregatedOnDateFrom, final LocalDate aggregatedOnDateTo, final LocalDate submittedOnDate, final Long jobExecutionId) {
        this.aggregatedOnDateFrom = aggregatedOnDateFrom;
        this.aggregatedOnDateTo = aggregatedOnDateTo;
        this.submittedOnDate = submittedOnDate;
        this.jobExecutionId = jobExecutionId;
    }


    @java.lang.SuppressWarnings("all")
        public static class JournalEntryAggregationTrackingDataBuilder {
        @java.lang.SuppressWarnings("all")
                private LocalDate aggregatedOnDateFrom;
        @java.lang.SuppressWarnings("all")
                private LocalDate aggregatedOnDateTo;
        @java.lang.SuppressWarnings("all")
                private LocalDate submittedOnDate;
        @java.lang.SuppressWarnings("all")
                private Long jobExecutionId;

        @java.lang.SuppressWarnings("all")
                JournalEntryAggregationTrackingDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationTrackingData.JournalEntryAggregationTrackingDataBuilder aggregatedOnDateFrom(final LocalDate aggregatedOnDateFrom) {
            this.aggregatedOnDateFrom = aggregatedOnDateFrom;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationTrackingData.JournalEntryAggregationTrackingDataBuilder aggregatedOnDateTo(final LocalDate aggregatedOnDateTo) {
            this.aggregatedOnDateTo = aggregatedOnDateTo;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationTrackingData.JournalEntryAggregationTrackingDataBuilder submittedOnDate(final LocalDate submittedOnDate) {
            this.submittedOnDate = submittedOnDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationTrackingData.JournalEntryAggregationTrackingDataBuilder jobExecutionId(final Long jobExecutionId) {
            this.jobExecutionId = jobExecutionId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public JournalEntryAggregationTrackingData build() {
            return new JournalEntryAggregationTrackingData(this.aggregatedOnDateFrom, this.aggregatedOnDateTo, this.submittedOnDate, this.jobExecutionId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "JournalEntryAggregationTrackingData.JournalEntryAggregationTrackingDataBuilder(aggregatedOnDateFrom=" + this.aggregatedOnDateFrom + ", aggregatedOnDateTo=" + this.aggregatedOnDateTo + ", submittedOnDate=" + this.submittedOnDate + ", jobExecutionId=" + this.jobExecutionId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static JournalEntryAggregationTrackingData.JournalEntryAggregationTrackingDataBuilder builder() {
        return new JournalEntryAggregationTrackingData.JournalEntryAggregationTrackingDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public JournalEntryAggregationTrackingData.JournalEntryAggregationTrackingDataBuilder toBuilder() {
        return new JournalEntryAggregationTrackingData.JournalEntryAggregationTrackingDataBuilder().aggregatedOnDateFrom(this.aggregatedOnDateFrom).aggregatedOnDateTo(this.aggregatedOnDateTo).submittedOnDate(this.submittedOnDate).jobExecutionId(this.jobExecutionId);
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getAggregatedOnDateFrom() {
        return this.aggregatedOnDateFrom;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getAggregatedOnDateTo() {
        return this.aggregatedOnDateTo;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSubmittedOnDate() {
        return this.submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public Long getJobExecutionId() {
        return this.jobExecutionId;
    }

    @java.lang.SuppressWarnings("all")
        public void setAggregatedOnDateFrom(final LocalDate aggregatedOnDateFrom) {
        this.aggregatedOnDateFrom = aggregatedOnDateFrom;
    }

    @java.lang.SuppressWarnings("all")
        public void setAggregatedOnDateTo(final LocalDate aggregatedOnDateTo) {
        this.aggregatedOnDateTo = aggregatedOnDateTo;
    }

    @java.lang.SuppressWarnings("all")
        public void setSubmittedOnDate(final LocalDate submittedOnDate) {
        this.submittedOnDate = submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setJobExecutionId(final Long jobExecutionId) {
        this.jobExecutionId = jobExecutionId;
    }
}
