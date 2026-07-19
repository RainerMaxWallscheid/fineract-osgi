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
import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;

@Entity
@Table(name = "m_journal_entry_aggregation_summary")
public class JournalEntrySummary extends AbstractAuditableWithUTCDateTimeCustom<Long> {
    @Column(name = "product_id", nullable = false)
    private Long product;
    @Column(name = "gl_account_id", nullable = false)
    private Long glAccountId;
    @Column(name = "office_id", nullable = false)
    private Long office;
    @Column(name = "entity_type_enum", nullable = false)
    private Long entityTypeEnum;
    @Column(name = "aggregated_on_date", nullable = false)
    private LocalDate aggregatedOnDate;
    @Column(name = "submitted_on_date", nullable = false)
    private LocalDate submittedOnDate;
    @Column(name = "external_owner_id", nullable = false)
    private Long externalOwnerId;
    @Column(name = "originator_external_ids")
    private String originatorExternalIds;
    @Column(name = "debit_amount")
    private BigDecimal debitAmount;
    @Column(name = "credit_amount")
    private BigDecimal creditAmount;
    @Column(name = "manual_entry", nullable = false)
    private Boolean manualEntry = false;
    @Column(name = "job_execution_id", nullable = false)
    private Long jobExecutionId;

    @java.lang.SuppressWarnings("all")
        public Long getProduct() {
        return this.product;
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
        public LocalDate getAggregatedOnDate() {
        return this.aggregatedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSubmittedOnDate() {
        return this.submittedOnDate;
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
        public Long getJobExecutionId() {
        return this.jobExecutionId;
    }

    @java.lang.SuppressWarnings("all")
        public void setProduct(final Long product) {
        this.product = product;
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
        public void setAggregatedOnDate(final LocalDate aggregatedOnDate) {
        this.aggregatedOnDate = aggregatedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setSubmittedOnDate(final LocalDate submittedOnDate) {
        this.submittedOnDate = submittedOnDate;
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
        public void setJobExecutionId(final Long jobExecutionId) {
        this.jobExecutionId = jobExecutionId;
    }
}
