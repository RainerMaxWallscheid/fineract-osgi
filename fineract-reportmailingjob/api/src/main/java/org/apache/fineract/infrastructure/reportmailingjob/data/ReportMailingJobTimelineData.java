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
package org.apache.fineract.infrastructure.reportmailingjob.data;

import java.time.LocalDate;

/**
 * Immutable data object represent the timeline events of a report mailing job (creation)
 */
@SuppressWarnings("unused")
public class ReportMailingJobTimelineData {
    private LocalDate createdOnDate;
    private String createdByUsername;
    private String createdByFirstname;
    private String createdByLastname;
    private LocalDate updatedOnDate;
    private String updatedByUsername;
    private String updatedByFirstname;
    private String updatedByLastname;

    @java.lang.SuppressWarnings("all")
        public LocalDate getCreatedOnDate() {
        return this.createdOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreatedByUsername() {
        return this.createdByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreatedByFirstname() {
        return this.createdByFirstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreatedByLastname() {
        return this.createdByLastname;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getUpdatedOnDate() {
        return this.updatedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getUpdatedByUsername() {
        return this.updatedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getUpdatedByFirstname() {
        return this.updatedByFirstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getUpdatedByLastname() {
        return this.updatedByLastname;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobTimelineData setCreatedOnDate(final LocalDate createdOnDate) {
        this.createdOnDate = createdOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobTimelineData setCreatedByUsername(final String createdByUsername) {
        this.createdByUsername = createdByUsername;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobTimelineData setCreatedByFirstname(final String createdByFirstname) {
        this.createdByFirstname = createdByFirstname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobTimelineData setCreatedByLastname(final String createdByLastname) {
        this.createdByLastname = createdByLastname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobTimelineData setUpdatedOnDate(final LocalDate updatedOnDate) {
        this.updatedOnDate = updatedOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobTimelineData setUpdatedByUsername(final String updatedByUsername) {
        this.updatedByUsername = updatedByUsername;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobTimelineData setUpdatedByFirstname(final String updatedByFirstname) {
        this.updatedByFirstname = updatedByFirstname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobTimelineData setUpdatedByLastname(final String updatedByLastname) {
        this.updatedByLastname = updatedByLastname;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ReportMailingJobTimelineData)) return false;
        final ReportMailingJobTimelineData other = (ReportMailingJobTimelineData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$createdOnDate = this.getCreatedOnDate();
        final java.lang.Object other$createdOnDate = other.getCreatedOnDate();
        if (this$createdOnDate == null ? other$createdOnDate != null : !this$createdOnDate.equals(other$createdOnDate)) return false;
        final java.lang.Object this$createdByUsername = this.getCreatedByUsername();
        final java.lang.Object other$createdByUsername = other.getCreatedByUsername();
        if (this$createdByUsername == null ? other$createdByUsername != null : !this$createdByUsername.equals(other$createdByUsername)) return false;
        final java.lang.Object this$createdByFirstname = this.getCreatedByFirstname();
        final java.lang.Object other$createdByFirstname = other.getCreatedByFirstname();
        if (this$createdByFirstname == null ? other$createdByFirstname != null : !this$createdByFirstname.equals(other$createdByFirstname)) return false;
        final java.lang.Object this$createdByLastname = this.getCreatedByLastname();
        final java.lang.Object other$createdByLastname = other.getCreatedByLastname();
        if (this$createdByLastname == null ? other$createdByLastname != null : !this$createdByLastname.equals(other$createdByLastname)) return false;
        final java.lang.Object this$updatedOnDate = this.getUpdatedOnDate();
        final java.lang.Object other$updatedOnDate = other.getUpdatedOnDate();
        if (this$updatedOnDate == null ? other$updatedOnDate != null : !this$updatedOnDate.equals(other$updatedOnDate)) return false;
        final java.lang.Object this$updatedByUsername = this.getUpdatedByUsername();
        final java.lang.Object other$updatedByUsername = other.getUpdatedByUsername();
        if (this$updatedByUsername == null ? other$updatedByUsername != null : !this$updatedByUsername.equals(other$updatedByUsername)) return false;
        final java.lang.Object this$updatedByFirstname = this.getUpdatedByFirstname();
        final java.lang.Object other$updatedByFirstname = other.getUpdatedByFirstname();
        if (this$updatedByFirstname == null ? other$updatedByFirstname != null : !this$updatedByFirstname.equals(other$updatedByFirstname)) return false;
        final java.lang.Object this$updatedByLastname = this.getUpdatedByLastname();
        final java.lang.Object other$updatedByLastname = other.getUpdatedByLastname();
        if (this$updatedByLastname == null ? other$updatedByLastname != null : !this$updatedByLastname.equals(other$updatedByLastname)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ReportMailingJobTimelineData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $createdOnDate = this.getCreatedOnDate();
        result = result * PRIME + ($createdOnDate == null ? 43 : $createdOnDate.hashCode());
        final java.lang.Object $createdByUsername = this.getCreatedByUsername();
        result = result * PRIME + ($createdByUsername == null ? 43 : $createdByUsername.hashCode());
        final java.lang.Object $createdByFirstname = this.getCreatedByFirstname();
        result = result * PRIME + ($createdByFirstname == null ? 43 : $createdByFirstname.hashCode());
        final java.lang.Object $createdByLastname = this.getCreatedByLastname();
        result = result * PRIME + ($createdByLastname == null ? 43 : $createdByLastname.hashCode());
        final java.lang.Object $updatedOnDate = this.getUpdatedOnDate();
        result = result * PRIME + ($updatedOnDate == null ? 43 : $updatedOnDate.hashCode());
        final java.lang.Object $updatedByUsername = this.getUpdatedByUsername();
        result = result * PRIME + ($updatedByUsername == null ? 43 : $updatedByUsername.hashCode());
        final java.lang.Object $updatedByFirstname = this.getUpdatedByFirstname();
        result = result * PRIME + ($updatedByFirstname == null ? 43 : $updatedByFirstname.hashCode());
        final java.lang.Object $updatedByLastname = this.getUpdatedByLastname();
        result = result * PRIME + ($updatedByLastname == null ? 43 : $updatedByLastname.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ReportMailingJobTimelineData(createdOnDate=" + this.getCreatedOnDate() + ", createdByUsername=" + this.getCreatedByUsername() + ", createdByFirstname=" + this.getCreatedByFirstname() + ", createdByLastname=" + this.getCreatedByLastname() + ", updatedOnDate=" + this.getUpdatedOnDate() + ", updatedByUsername=" + this.getUpdatedByUsername() + ", updatedByFirstname=" + this.getUpdatedByFirstname() + ", updatedByLastname=" + this.getUpdatedByLastname() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ReportMailingJobTimelineData() {
    }
}
