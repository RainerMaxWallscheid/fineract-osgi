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
package org.apache.fineract.infrastructure.bulkimport.data;

import java.time.LocalDate;

public final class ImportData {
    @SuppressWarnings("unused")
    private Long importId;
    @SuppressWarnings("unused")
    private Long documentId;
    @SuppressWarnings("unused")
    private Integer entityType;
    @SuppressWarnings("unused")
    private String name;
    @SuppressWarnings("unused")
    private LocalDate importTime;
    @SuppressWarnings("unused")
    private LocalDate endTime;
    @SuppressWarnings("unused")
    private Boolean completed;
    @SuppressWarnings("unused")
    private Long createdBy;
    @SuppressWarnings("unused")
    private Integer totalRecords;
    @SuppressWarnings("unused")
    private Integer successCount;
    @SuppressWarnings("unused")
    private Integer failureCount;

    public static ImportData instance(final Long importId, final Long documentId, final LocalDate importTime, final LocalDate endTime, final Boolean completed, final String name, final Long createdBy, final Integer totalRecords, final Integer successCount, final Integer failureCount) {
        return new ImportData(importId, documentId, importTime, endTime, completed, name, createdBy, totalRecords, successCount, failureCount);
    }

    public static ImportData instance(final Long importId) {
        return new ImportData(importId, null, null, null, null, null, null, null, null, null);
    }

    private ImportData(final Long importId, final Long documentId, final LocalDate importTime, final LocalDate endTime, final Boolean completed, final String name, final Long createdBy, final Integer totalRecords, final Integer successCount, final Integer failureCount) {
        this.importId = importId;
        this.documentId = documentId;
        this.name = name;
        this.importTime = importTime;
        this.endTime = endTime;
        this.completed = completed;
        this.createdBy = createdBy;
        this.totalRecords = totalRecords;
        this.successCount = successCount;
        this.failureCount = failureCount;
    }

    @java.lang.SuppressWarnings("all")
        public ImportData(final Long importId, final Long documentId, final Integer entityType, final String name, final LocalDate importTime, final LocalDate endTime, final Boolean completed, final Long createdBy, final Integer totalRecords, final Integer successCount, final Integer failureCount) {
        this.importId = importId;
        this.documentId = documentId;
        this.entityType = entityType;
        this.name = name;
        this.importTime = importTime;
        this.endTime = endTime;
        this.completed = completed;
        this.createdBy = createdBy;
        this.totalRecords = totalRecords;
        this.successCount = successCount;
        this.failureCount = failureCount;
    }

    @java.lang.SuppressWarnings("all")
        public ImportData() {
    }

    @java.lang.SuppressWarnings("all")
        public Long getImportId() {
        return this.importId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getDocumentId() {
        return this.documentId;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getEntityType() {
        return this.entityType;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getImportTime() {
        return this.importTime;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getEndTime() {
        return this.endTime;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getCompleted() {
        return this.completed;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCreatedBy() {
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

    @java.lang.SuppressWarnings("all")
        public void setImportId(final Long importId) {
        this.importId = importId;
    }

    @java.lang.SuppressWarnings("all")
        public void setDocumentId(final Long documentId) {
        this.documentId = documentId;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntityType(final Integer entityType) {
        this.entityType = entityType;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setImportTime(final LocalDate importTime) {
        this.importTime = importTime;
    }

    @java.lang.SuppressWarnings("all")
        public void setEndTime(final LocalDate endTime) {
        this.endTime = endTime;
    }

    @java.lang.SuppressWarnings("all")
        public void setCompleted(final Boolean completed) {
        this.completed = completed;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreatedBy(final Long createdBy) {
        this.createdBy = createdBy;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalRecords(final Integer totalRecords) {
        this.totalRecords = totalRecords;
    }

    @java.lang.SuppressWarnings("all")
        public void setSuccessCount(final Integer successCount) {
        this.successCount = successCount;
    }

    @java.lang.SuppressWarnings("all")
        public void setFailureCount(final Integer failureCount) {
        this.failureCount = failureCount;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ImportData)) return false;
        final ImportData other = (ImportData) o;
        final java.lang.Object this$importId = this.getImportId();
        final java.lang.Object other$importId = other.getImportId();
        if (this$importId == null ? other$importId != null : !this$importId.equals(other$importId)) return false;
        final java.lang.Object this$documentId = this.getDocumentId();
        final java.lang.Object other$documentId = other.getDocumentId();
        if (this$documentId == null ? other$documentId != null : !this$documentId.equals(other$documentId)) return false;
        final java.lang.Object this$entityType = this.getEntityType();
        final java.lang.Object other$entityType = other.getEntityType();
        if (this$entityType == null ? other$entityType != null : !this$entityType.equals(other$entityType)) return false;
        final java.lang.Object this$completed = this.getCompleted();
        final java.lang.Object other$completed = other.getCompleted();
        if (this$completed == null ? other$completed != null : !this$completed.equals(other$completed)) return false;
        final java.lang.Object this$createdBy = this.getCreatedBy();
        final java.lang.Object other$createdBy = other.getCreatedBy();
        if (this$createdBy == null ? other$createdBy != null : !this$createdBy.equals(other$createdBy)) return false;
        final java.lang.Object this$totalRecords = this.getTotalRecords();
        final java.lang.Object other$totalRecords = other.getTotalRecords();
        if (this$totalRecords == null ? other$totalRecords != null : !this$totalRecords.equals(other$totalRecords)) return false;
        final java.lang.Object this$successCount = this.getSuccessCount();
        final java.lang.Object other$successCount = other.getSuccessCount();
        if (this$successCount == null ? other$successCount != null : !this$successCount.equals(other$successCount)) return false;
        final java.lang.Object this$failureCount = this.getFailureCount();
        final java.lang.Object other$failureCount = other.getFailureCount();
        if (this$failureCount == null ? other$failureCount != null : !this$failureCount.equals(other$failureCount)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$importTime = this.getImportTime();
        final java.lang.Object other$importTime = other.getImportTime();
        if (this$importTime == null ? other$importTime != null : !this$importTime.equals(other$importTime)) return false;
        final java.lang.Object this$endTime = this.getEndTime();
        final java.lang.Object other$endTime = other.getEndTime();
        if (this$endTime == null ? other$endTime != null : !this$endTime.equals(other$endTime)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $importId = this.getImportId();
        result = result * PRIME + ($importId == null ? 43 : $importId.hashCode());
        final java.lang.Object $documentId = this.getDocumentId();
        result = result * PRIME + ($documentId == null ? 43 : $documentId.hashCode());
        final java.lang.Object $entityType = this.getEntityType();
        result = result * PRIME + ($entityType == null ? 43 : $entityType.hashCode());
        final java.lang.Object $completed = this.getCompleted();
        result = result * PRIME + ($completed == null ? 43 : $completed.hashCode());
        final java.lang.Object $createdBy = this.getCreatedBy();
        result = result * PRIME + ($createdBy == null ? 43 : $createdBy.hashCode());
        final java.lang.Object $totalRecords = this.getTotalRecords();
        result = result * PRIME + ($totalRecords == null ? 43 : $totalRecords.hashCode());
        final java.lang.Object $successCount = this.getSuccessCount();
        result = result * PRIME + ($successCount == null ? 43 : $successCount.hashCode());
        final java.lang.Object $failureCount = this.getFailureCount();
        result = result * PRIME + ($failureCount == null ? 43 : $failureCount.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $importTime = this.getImportTime();
        result = result * PRIME + ($importTime == null ? 43 : $importTime.hashCode());
        final java.lang.Object $endTime = this.getEndTime();
        result = result * PRIME + ($endTime == null ? 43 : $endTime.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ImportData(importId=" + this.getImportId() + ", documentId=" + this.getDocumentId() + ", entityType=" + this.getEntityType() + ", name=" + this.getName() + ", importTime=" + this.getImportTime() + ", endTime=" + this.getEndTime() + ", completed=" + this.getCompleted() + ", createdBy=" + this.getCreatedBy() + ", totalRecords=" + this.getTotalRecords() + ", successCount=" + this.getSuccessCount() + ", failureCount=" + this.getFailureCount() + ")";
    }
}
