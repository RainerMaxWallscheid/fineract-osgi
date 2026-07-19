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
package org.apache.fineract.infrastructure.jobs.data;

import java.util.Date;

public class JobDetailHistoryData {
    @SuppressWarnings("unused")
    private Long id;
    @SuppressWarnings("unused")
    private Long version;
    @SuppressWarnings("unused")
    private Date jobRunStartTime;
    @SuppressWarnings("unused")
    private Date jobRunEndTime;
    @SuppressWarnings("unused")
    private String status;
    @SuppressWarnings("unused")
    private String jobRunErrorMessage;
    @SuppressWarnings("unused")
    private String triggerType;
    @SuppressWarnings("unused")
    private String jobRunErrorLog;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getVersion() {
        return this.version;
    }

    @java.lang.SuppressWarnings("all")
        public Date getJobRunStartTime() {
        return this.jobRunStartTime;
    }

    @java.lang.SuppressWarnings("all")
        public Date getJobRunEndTime() {
        return this.jobRunEndTime;
    }

    @java.lang.SuppressWarnings("all")
        public String getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public String getJobRunErrorMessage() {
        return this.jobRunErrorMessage;
    }

    @java.lang.SuppressWarnings("all")
        public String getTriggerType() {
        return this.triggerType;
    }

    @java.lang.SuppressWarnings("all")
        public String getJobRunErrorLog() {
        return this.jobRunErrorLog;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailHistoryData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailHistoryData setVersion(final Long version) {
        this.version = version;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailHistoryData setJobRunStartTime(final Date jobRunStartTime) {
        this.jobRunStartTime = jobRunStartTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailHistoryData setJobRunEndTime(final Date jobRunEndTime) {
        this.jobRunEndTime = jobRunEndTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailHistoryData setStatus(final String status) {
        this.status = status;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailHistoryData setJobRunErrorMessage(final String jobRunErrorMessage) {
        this.jobRunErrorMessage = jobRunErrorMessage;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailHistoryData setTriggerType(final String triggerType) {
        this.triggerType = triggerType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailHistoryData setJobRunErrorLog(final String jobRunErrorLog) {
        this.jobRunErrorLog = jobRunErrorLog;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof JobDetailHistoryData)) return false;
        final JobDetailHistoryData other = (JobDetailHistoryData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$version = this.getVersion();
        final java.lang.Object other$version = other.getVersion();
        if (this$version == null ? other$version != null : !this$version.equals(other$version)) return false;
        final java.lang.Object this$jobRunStartTime = this.getJobRunStartTime();
        final java.lang.Object other$jobRunStartTime = other.getJobRunStartTime();
        if (this$jobRunStartTime == null ? other$jobRunStartTime != null : !this$jobRunStartTime.equals(other$jobRunStartTime)) return false;
        final java.lang.Object this$jobRunEndTime = this.getJobRunEndTime();
        final java.lang.Object other$jobRunEndTime = other.getJobRunEndTime();
        if (this$jobRunEndTime == null ? other$jobRunEndTime != null : !this$jobRunEndTime.equals(other$jobRunEndTime)) return false;
        final java.lang.Object this$status = this.getStatus();
        final java.lang.Object other$status = other.getStatus();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        final java.lang.Object this$jobRunErrorMessage = this.getJobRunErrorMessage();
        final java.lang.Object other$jobRunErrorMessage = other.getJobRunErrorMessage();
        if (this$jobRunErrorMessage == null ? other$jobRunErrorMessage != null : !this$jobRunErrorMessage.equals(other$jobRunErrorMessage)) return false;
        final java.lang.Object this$triggerType = this.getTriggerType();
        final java.lang.Object other$triggerType = other.getTriggerType();
        if (this$triggerType == null ? other$triggerType != null : !this$triggerType.equals(other$triggerType)) return false;
        final java.lang.Object this$jobRunErrorLog = this.getJobRunErrorLog();
        final java.lang.Object other$jobRunErrorLog = other.getJobRunErrorLog();
        if (this$jobRunErrorLog == null ? other$jobRunErrorLog != null : !this$jobRunErrorLog.equals(other$jobRunErrorLog)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof JobDetailHistoryData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $version = this.getVersion();
        result = result * PRIME + ($version == null ? 43 : $version.hashCode());
        final java.lang.Object $jobRunStartTime = this.getJobRunStartTime();
        result = result * PRIME + ($jobRunStartTime == null ? 43 : $jobRunStartTime.hashCode());
        final java.lang.Object $jobRunEndTime = this.getJobRunEndTime();
        result = result * PRIME + ($jobRunEndTime == null ? 43 : $jobRunEndTime.hashCode());
        final java.lang.Object $status = this.getStatus();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        final java.lang.Object $jobRunErrorMessage = this.getJobRunErrorMessage();
        result = result * PRIME + ($jobRunErrorMessage == null ? 43 : $jobRunErrorMessage.hashCode());
        final java.lang.Object $triggerType = this.getTriggerType();
        result = result * PRIME + ($triggerType == null ? 43 : $triggerType.hashCode());
        final java.lang.Object $jobRunErrorLog = this.getJobRunErrorLog();
        result = result * PRIME + ($jobRunErrorLog == null ? 43 : $jobRunErrorLog.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "JobDetailHistoryData(id=" + this.getId() + ", version=" + this.getVersion() + ", jobRunStartTime=" + this.getJobRunStartTime() + ", jobRunEndTime=" + this.getJobRunEndTime() + ", status=" + this.getStatus() + ", jobRunErrorMessage=" + this.getJobRunErrorMessage() + ", triggerType=" + this.getTriggerType() + ", jobRunErrorLog=" + this.getJobRunErrorLog() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public JobDetailHistoryData() {
    }
}
