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
package org.apache.fineract.infrastructure.jobs.service.aggregationjob.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;

@Entity
@Table(name = "m_journal_entry_aggregation_tracking")
public class JournalEntryAggregationTracking extends AbstractAuditableWithUTCDateTimeCustom<Long> {
    @Column(name = "aggregated_on_date_from", nullable = false)
    private LocalDate aggregatedOnDateFrom;
    @Column(name = "aggregated_on_date_to", nullable = false)
    private LocalDate aggregatedOnDateTo;
    @Column(name = "submitted_on_date", nullable = false)
    private LocalDate submittedOnDate;
    @Column(name = "job_execution_id", nullable = false)
    private Long jobExecutionId;

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
