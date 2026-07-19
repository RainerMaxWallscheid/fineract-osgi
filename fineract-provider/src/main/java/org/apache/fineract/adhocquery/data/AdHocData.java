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
package org.apache.fineract.adhocquery.data;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.ZonedDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import org.apache.fineract.adhocquery.domain.ReportRunFrequency;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;

/**
 * Immutable data object represent note or case information AdHocData
 */
public class AdHocData {
    private Long id;
    private String name;
    private String query;
    private String tableName;
    private String tableFields;
    private String email;
    @JsonProperty("isActive")
    private boolean isActive;
    private ZonedDateTime createdOn;
    private Long createdById;
    private Long updatedById;
    private ZonedDateTime updatedOn;
    private String createdBy;
    private List<EnumOptionData> reportRunFrequencies;
    private Long reportRunFrequency;
    private Long reportRunEvery;
    private ZonedDateTime lastRun;

    public static AdHocData template() {
        List<EnumOptionData> reportRunFrequencies = Arrays.stream(ReportRunFrequency.values()).map(rrf -> new EnumOptionData(rrf.getValue(), rrf.getCode(), rrf.getCode())).collect(Collectors.toList());
        return new AdHocData().setReportRunFrequencies(reportRunFrequencies);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getQuery() {
        return this.query;
    }

    @java.lang.SuppressWarnings("all")
        public String getTableName() {
        return this.tableName;
    }

    @java.lang.SuppressWarnings("all")
        public String getTableFields() {
        return this.tableFields;
    }

    @java.lang.SuppressWarnings("all")
        public String getEmail() {
        return this.email;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isActive() {
        return this.isActive;
    }

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getCreatedOn() {
        return this.createdOn;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCreatedById() {
        return this.createdById;
    }

    @java.lang.SuppressWarnings("all")
        public Long getUpdatedById() {
        return this.updatedById;
    }

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getUpdatedOn() {
        return this.updatedOn;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreatedBy() {
        return this.createdBy;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getReportRunFrequencies() {
        return this.reportRunFrequencies;
    }

    @java.lang.SuppressWarnings("all")
        public Long getReportRunFrequency() {
        return this.reportRunFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public Long getReportRunEvery() {
        return this.reportRunEvery;
    }

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getLastRun() {
        return this.lastRun;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdHocData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdHocData setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdHocData setQuery(final String query) {
        this.query = query;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdHocData setTableName(final String tableName) {
        this.tableName = tableName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdHocData setTableFields(final String tableFields) {
        this.tableFields = tableFields;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdHocData setEmail(final String email) {
        this.email = email;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdHocData setActive(final boolean isActive) {
        this.isActive = isActive;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdHocData setCreatedOn(final ZonedDateTime createdOn) {
        this.createdOn = createdOn;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdHocData setCreatedById(final Long createdById) {
        this.createdById = createdById;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdHocData setUpdatedById(final Long updatedById) {
        this.updatedById = updatedById;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdHocData setUpdatedOn(final ZonedDateTime updatedOn) {
        this.updatedOn = updatedOn;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdHocData setCreatedBy(final String createdBy) {
        this.createdBy = createdBy;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdHocData setReportRunFrequencies(final List<EnumOptionData> reportRunFrequencies) {
        this.reportRunFrequencies = reportRunFrequencies;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdHocData setReportRunFrequency(final Long reportRunFrequency) {
        this.reportRunFrequency = reportRunFrequency;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdHocData setReportRunEvery(final Long reportRunEvery) {
        this.reportRunEvery = reportRunEvery;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdHocData setLastRun(final ZonedDateTime lastRun) {
        this.lastRun = lastRun;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AdHocData)) return false;
        final AdHocData other = (AdHocData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isActive() != other.isActive()) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$createdById = this.getCreatedById();
        final java.lang.Object other$createdById = other.getCreatedById();
        if (this$createdById == null ? other$createdById != null : !this$createdById.equals(other$createdById)) return false;
        final java.lang.Object this$updatedById = this.getUpdatedById();
        final java.lang.Object other$updatedById = other.getUpdatedById();
        if (this$updatedById == null ? other$updatedById != null : !this$updatedById.equals(other$updatedById)) return false;
        final java.lang.Object this$reportRunFrequency = this.getReportRunFrequency();
        final java.lang.Object other$reportRunFrequency = other.getReportRunFrequency();
        if (this$reportRunFrequency == null ? other$reportRunFrequency != null : !this$reportRunFrequency.equals(other$reportRunFrequency)) return false;
        final java.lang.Object this$reportRunEvery = this.getReportRunEvery();
        final java.lang.Object other$reportRunEvery = other.getReportRunEvery();
        if (this$reportRunEvery == null ? other$reportRunEvery != null : !this$reportRunEvery.equals(other$reportRunEvery)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$query = this.getQuery();
        final java.lang.Object other$query = other.getQuery();
        if (this$query == null ? other$query != null : !this$query.equals(other$query)) return false;
        final java.lang.Object this$tableName = this.getTableName();
        final java.lang.Object other$tableName = other.getTableName();
        if (this$tableName == null ? other$tableName != null : !this$tableName.equals(other$tableName)) return false;
        final java.lang.Object this$tableFields = this.getTableFields();
        final java.lang.Object other$tableFields = other.getTableFields();
        if (this$tableFields == null ? other$tableFields != null : !this$tableFields.equals(other$tableFields)) return false;
        final java.lang.Object this$email = this.getEmail();
        final java.lang.Object other$email = other.getEmail();
        if (this$email == null ? other$email != null : !this$email.equals(other$email)) return false;
        final java.lang.Object this$createdOn = this.getCreatedOn();
        final java.lang.Object other$createdOn = other.getCreatedOn();
        if (this$createdOn == null ? other$createdOn != null : !this$createdOn.equals(other$createdOn)) return false;
        final java.lang.Object this$updatedOn = this.getUpdatedOn();
        final java.lang.Object other$updatedOn = other.getUpdatedOn();
        if (this$updatedOn == null ? other$updatedOn != null : !this$updatedOn.equals(other$updatedOn)) return false;
        final java.lang.Object this$createdBy = this.getCreatedBy();
        final java.lang.Object other$createdBy = other.getCreatedBy();
        if (this$createdBy == null ? other$createdBy != null : !this$createdBy.equals(other$createdBy)) return false;
        final java.lang.Object this$reportRunFrequencies = this.getReportRunFrequencies();
        final java.lang.Object other$reportRunFrequencies = other.getReportRunFrequencies();
        if (this$reportRunFrequencies == null ? other$reportRunFrequencies != null : !this$reportRunFrequencies.equals(other$reportRunFrequencies)) return false;
        final java.lang.Object this$lastRun = this.getLastRun();
        final java.lang.Object other$lastRun = other.getLastRun();
        if (this$lastRun == null ? other$lastRun != null : !this$lastRun.equals(other$lastRun)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AdHocData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isActive() ? 79 : 97);
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $createdById = this.getCreatedById();
        result = result * PRIME + ($createdById == null ? 43 : $createdById.hashCode());
        final java.lang.Object $updatedById = this.getUpdatedById();
        result = result * PRIME + ($updatedById == null ? 43 : $updatedById.hashCode());
        final java.lang.Object $reportRunFrequency = this.getReportRunFrequency();
        result = result * PRIME + ($reportRunFrequency == null ? 43 : $reportRunFrequency.hashCode());
        final java.lang.Object $reportRunEvery = this.getReportRunEvery();
        result = result * PRIME + ($reportRunEvery == null ? 43 : $reportRunEvery.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $query = this.getQuery();
        result = result * PRIME + ($query == null ? 43 : $query.hashCode());
        final java.lang.Object $tableName = this.getTableName();
        result = result * PRIME + ($tableName == null ? 43 : $tableName.hashCode());
        final java.lang.Object $tableFields = this.getTableFields();
        result = result * PRIME + ($tableFields == null ? 43 : $tableFields.hashCode());
        final java.lang.Object $email = this.getEmail();
        result = result * PRIME + ($email == null ? 43 : $email.hashCode());
        final java.lang.Object $createdOn = this.getCreatedOn();
        result = result * PRIME + ($createdOn == null ? 43 : $createdOn.hashCode());
        final java.lang.Object $updatedOn = this.getUpdatedOn();
        result = result * PRIME + ($updatedOn == null ? 43 : $updatedOn.hashCode());
        final java.lang.Object $createdBy = this.getCreatedBy();
        result = result * PRIME + ($createdBy == null ? 43 : $createdBy.hashCode());
        final java.lang.Object $reportRunFrequencies = this.getReportRunFrequencies();
        result = result * PRIME + ($reportRunFrequencies == null ? 43 : $reportRunFrequencies.hashCode());
        final java.lang.Object $lastRun = this.getLastRun();
        result = result * PRIME + ($lastRun == null ? 43 : $lastRun.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AdHocData(id=" + this.getId() + ", name=" + this.getName() + ", query=" + this.getQuery() + ", tableName=" + this.getTableName() + ", tableFields=" + this.getTableFields() + ", email=" + this.getEmail() + ", isActive=" + this.isActive() + ", createdOn=" + this.getCreatedOn() + ", createdById=" + this.getCreatedById() + ", updatedById=" + this.getUpdatedById() + ", updatedOn=" + this.getUpdatedOn() + ", createdBy=" + this.getCreatedBy() + ", reportRunFrequencies=" + this.getReportRunFrequencies() + ", reportRunFrequency=" + this.getReportRunFrequency() + ", reportRunEvery=" + this.getReportRunEvery() + ", lastRun=" + this.getLastRun() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AdHocData() {
    }
}
