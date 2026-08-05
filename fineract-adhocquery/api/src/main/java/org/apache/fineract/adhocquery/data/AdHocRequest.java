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

import java.io.Serial;
import java.io.Serializable;

public class AdHocRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private String name;
    private String query;
    private String tableName;
    private String tableFields;
    private String email;
    private Long reportRunFrequency;
    private Long reportRunEvery;
    private Boolean isActive;

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
        public Long getReportRunFrequency() {
        return this.reportRunFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public Long getReportRunEvery() {
        return this.reportRunEvery;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsActive() {
        return this.isActive;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setQuery(final String query) {
        this.query = query;
    }

    @java.lang.SuppressWarnings("all")
        public void setTableName(final String tableName) {
        this.tableName = tableName;
    }

    @java.lang.SuppressWarnings("all")
        public void setTableFields(final String tableFields) {
        this.tableFields = tableFields;
    }

    @java.lang.SuppressWarnings("all")
        public void setEmail(final String email) {
        this.email = email;
    }

    @java.lang.SuppressWarnings("all")
        public void setReportRunFrequency(final Long reportRunFrequency) {
        this.reportRunFrequency = reportRunFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public void setReportRunEvery(final Long reportRunEvery) {
        this.reportRunEvery = reportRunEvery;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsActive(final Boolean isActive) {
        this.isActive = isActive;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AdHocRequest)) return false;
        final AdHocRequest other = (AdHocRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$reportRunFrequency = this.getReportRunFrequency();
        final java.lang.Object other$reportRunFrequency = other.getReportRunFrequency();
        if (this$reportRunFrequency == null ? other$reportRunFrequency != null : !this$reportRunFrequency.equals(other$reportRunFrequency)) return false;
        final java.lang.Object this$reportRunEvery = this.getReportRunEvery();
        final java.lang.Object other$reportRunEvery = other.getReportRunEvery();
        if (this$reportRunEvery == null ? other$reportRunEvery != null : !this$reportRunEvery.equals(other$reportRunEvery)) return false;
        final java.lang.Object this$isActive = this.getIsActive();
        final java.lang.Object other$isActive = other.getIsActive();
        if (this$isActive == null ? other$isActive != null : !this$isActive.equals(other$isActive)) return false;
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
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AdHocRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $reportRunFrequency = this.getReportRunFrequency();
        result = result * PRIME + ($reportRunFrequency == null ? 43 : $reportRunFrequency.hashCode());
        final java.lang.Object $reportRunEvery = this.getReportRunEvery();
        result = result * PRIME + ($reportRunEvery == null ? 43 : $reportRunEvery.hashCode());
        final java.lang.Object $isActive = this.getIsActive();
        result = result * PRIME + ($isActive == null ? 43 : $isActive.hashCode());
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
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AdHocRequest(id=" + this.getId() + ", name=" + this.getName() + ", query=" + this.getQuery() + ", tableName=" + this.getTableName() + ", tableFields=" + this.getTableFields() + ", email=" + this.getEmail() + ", reportRunFrequency=" + this.getReportRunFrequency() + ", reportRunEvery=" + this.getReportRunEvery() + ", isActive=" + this.getIsActive() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AdHocRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public AdHocRequest(final Long id, final String name, final String query, final String tableName, final String tableFields, final String email, final Long reportRunFrequency, final Long reportRunEvery, final Boolean isActive) {
        this.id = id;
        this.name = name;
        this.query = query;
        this.tableName = tableName;
        this.tableFields = tableFields;
        this.email = email;
        this.reportRunFrequency = reportRunFrequency;
        this.reportRunEvery = reportRunEvery;
        this.isActive = isActive;
    }
}
