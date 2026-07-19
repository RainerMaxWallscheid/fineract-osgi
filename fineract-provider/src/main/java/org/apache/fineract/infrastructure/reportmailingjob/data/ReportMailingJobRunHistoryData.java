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

import java.time.ZonedDateTime;

/**
 * Immutable data object representing report mailing job run history data.
 */
public final class ReportMailingJobRunHistoryData {
    private Long id;
    private Long reportMailingJobId;
    private ZonedDateTime startDateTime;
    private ZonedDateTime endDateTime;
    private String status;
    private String errorMessage;
    private String errorLog;

    /**
     * creates an instance of the ReportMailingJobRunHistoryData class
     *
     * @return ReportMailingJobRunHistoryData object
     */
    public static ReportMailingJobRunHistoryData newInstance(Long id, Long reportMailingJobId, ZonedDateTime startDateTime, ZonedDateTime endDateTime, String status, String errorMessage, String errorLog) {
        return new ReportMailingJobRunHistoryData().setId(id).setReportMailingJobId(reportMailingJobId).setStartDateTime(startDateTime).setEndDateTime(endDateTime).setStatus(status).setErrorMessage(errorMessage).setErrorLog(errorLog);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getReportMailingJobId() {
        return this.reportMailingJobId;
    }

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getStartDateTime() {
        return this.startDateTime;
    }

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getEndDateTime() {
        return this.endDateTime;
    }

    @java.lang.SuppressWarnings("all")
        public String getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public String getErrorMessage() {
        return this.errorMessage;
    }

    @java.lang.SuppressWarnings("all")
        public String getErrorLog() {
        return this.errorLog;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobRunHistoryData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobRunHistoryData setReportMailingJobId(final Long reportMailingJobId) {
        this.reportMailingJobId = reportMailingJobId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobRunHistoryData setStartDateTime(final ZonedDateTime startDateTime) {
        this.startDateTime = startDateTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobRunHistoryData setEndDateTime(final ZonedDateTime endDateTime) {
        this.endDateTime = endDateTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobRunHistoryData setStatus(final String status) {
        this.status = status;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobRunHistoryData setErrorMessage(final String errorMessage) {
        this.errorMessage = errorMessage;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobRunHistoryData setErrorLog(final String errorLog) {
        this.errorLog = errorLog;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ReportMailingJobRunHistoryData)) return false;
        final ReportMailingJobRunHistoryData other = (ReportMailingJobRunHistoryData) o;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$reportMailingJobId = this.getReportMailingJobId();
        final java.lang.Object other$reportMailingJobId = other.getReportMailingJobId();
        if (this$reportMailingJobId == null ? other$reportMailingJobId != null : !this$reportMailingJobId.equals(other$reportMailingJobId)) return false;
        final java.lang.Object this$startDateTime = this.getStartDateTime();
        final java.lang.Object other$startDateTime = other.getStartDateTime();
        if (this$startDateTime == null ? other$startDateTime != null : !this$startDateTime.equals(other$startDateTime)) return false;
        final java.lang.Object this$endDateTime = this.getEndDateTime();
        final java.lang.Object other$endDateTime = other.getEndDateTime();
        if (this$endDateTime == null ? other$endDateTime != null : !this$endDateTime.equals(other$endDateTime)) return false;
        final java.lang.Object this$status = this.getStatus();
        final java.lang.Object other$status = other.getStatus();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        final java.lang.Object this$errorMessage = this.getErrorMessage();
        final java.lang.Object other$errorMessage = other.getErrorMessage();
        if (this$errorMessage == null ? other$errorMessage != null : !this$errorMessage.equals(other$errorMessage)) return false;
        final java.lang.Object this$errorLog = this.getErrorLog();
        final java.lang.Object other$errorLog = other.getErrorLog();
        if (this$errorLog == null ? other$errorLog != null : !this$errorLog.equals(other$errorLog)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $reportMailingJobId = this.getReportMailingJobId();
        result = result * PRIME + ($reportMailingJobId == null ? 43 : $reportMailingJobId.hashCode());
        final java.lang.Object $startDateTime = this.getStartDateTime();
        result = result * PRIME + ($startDateTime == null ? 43 : $startDateTime.hashCode());
        final java.lang.Object $endDateTime = this.getEndDateTime();
        result = result * PRIME + ($endDateTime == null ? 43 : $endDateTime.hashCode());
        final java.lang.Object $status = this.getStatus();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        final java.lang.Object $errorMessage = this.getErrorMessage();
        result = result * PRIME + ($errorMessage == null ? 43 : $errorMessage.hashCode());
        final java.lang.Object $errorLog = this.getErrorLog();
        result = result * PRIME + ($errorLog == null ? 43 : $errorLog.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ReportMailingJobRunHistoryData(id=" + this.getId() + ", reportMailingJobId=" + this.getReportMailingJobId() + ", startDateTime=" + this.getStartDateTime() + ", endDateTime=" + this.getEndDateTime() + ", status=" + this.getStatus() + ", errorMessage=" + this.getErrorMessage() + ", errorLog=" + this.getErrorLog() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ReportMailingJobRunHistoryData() {
    }
}
