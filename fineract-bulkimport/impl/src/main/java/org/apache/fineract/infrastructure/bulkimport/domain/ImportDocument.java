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
package org.apache.fineract.infrastructure.bulkimport.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.useradministration.domain.AppUser;

@Entity
@Table(name = "m_import_document")
public final class ImportDocument extends AbstractPersistableCustom<Long> {
    @Column(name = "document_id")
    private Long documentId;
    @Column(name = "import_time")
    private LocalDateTime importTime;
    @Column(name = "end_time")
    private LocalDateTime endTime;
    @Column(name = "completed", nullable = false)
    private Boolean completed;
    @Column(name = "entity_type")
    private Integer entityType;
    @ManyToOne
    @JoinColumn(name = "createdby_id")
    private AppUser createdBy;
    @Column(name = "total_records", nullable = true)
    private Integer totalRecords;
    @Column(name = "success_count", nullable = true)
    private Integer successCount;
    @Column(name = "failure_count", nullable = true)
    private Integer failureCount;

    public static ImportDocument instance(final Long documentId, final LocalDateTime importTime, final Integer entityType, final AppUser createdBy, final Integer totalRecords) {
        final Boolean completed = Boolean.FALSE;
        final Integer successCount = 0;
        final Integer failureCount = 0;
        final LocalDateTime endTime = DateUtils.getLocalDateTimeOfTenant();
        return new ImportDocument(documentId, importTime, endTime, completed, entityType, createdBy, totalRecords, successCount, failureCount);
    }

    private ImportDocument(final Long documentId, final LocalDateTime importTime, final LocalDateTime endTime, Boolean completed, final Integer entityType, final AppUser createdBy, final Integer totalRecords, final Integer successCount, final Integer failureCount) {
        this.documentId = documentId;
        this.importTime = importTime;
        this.endTime = endTime;
        this.completed = completed;
        this.entityType = entityType;
        this.createdBy = createdBy;
        this.totalRecords = totalRecords;
        this.successCount = successCount;
        this.failureCount = failureCount;
    }

    public void update(final LocalDateTime endTime, final Integer successCount, final Integer errorCount) {
        this.endTime = endTime;
        this.completed = Boolean.TRUE;
        this.successCount = successCount;
        this.failureCount = errorCount;
    }

    @java.lang.SuppressWarnings("all")
        public Long getDocumentId() {
        return this.documentId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDateTime getImportTime() {
        return this.importTime;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDateTime getEndTime() {
        return this.endTime;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getCompleted() {
        return this.completed;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getEntityType() {
        return this.entityType;
    }

    @java.lang.SuppressWarnings("all")
        public AppUser getCreatedBy() {
        return this.createdBy;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getTotalRecords() {
        return this.totalRecords;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getSuccessCount() {
        return this.successCount;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getFailureCount() {
        return this.failureCount;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ImportDocument setDocumentId(final Long documentId) {
        this.documentId = documentId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ImportDocument setImportTime(final LocalDateTime importTime) {
        this.importTime = importTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ImportDocument setEndTime(final LocalDateTime endTime) {
        this.endTime = endTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ImportDocument setCompleted(final Boolean completed) {
        this.completed = completed;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ImportDocument setEntityType(final Integer entityType) {
        this.entityType = entityType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ImportDocument setCreatedBy(final AppUser createdBy) {
        this.createdBy = createdBy;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ImportDocument setTotalRecords(final Integer totalRecords) {
        this.totalRecords = totalRecords;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ImportDocument setSuccessCount(final Integer successCount) {
        this.successCount = successCount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ImportDocument setFailureCount(final Integer failureCount) {
        this.failureCount = failureCount;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public ImportDocument() {
    }
}
