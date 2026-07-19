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

public class JobDetailData {
    @SuppressWarnings("unused")
    private Long jobId;
    @SuppressWarnings("unused")
    private String displayName;
    @SuppressWarnings("unused")
    private String shortName;
    @SuppressWarnings("unused")
    private Date nextRunTime;
    @SuppressWarnings("unused")
    private String initializingError;
    private String cronExpression;
    @SuppressWarnings("unused")
    private boolean active;
    @SuppressWarnings("unused")
    private boolean currentlyRunning;
    @SuppressWarnings("unused")
    private JobDetailHistoryData lastRunHistory;

    public JobDetailData(Long jobId, String displayName, String shortName, Date nextRunTime, String initializingError, String cronExpression, boolean active, boolean currentlyRunning, Long version, Date jobRunStartTime, Date jobRunEndTime, String status, String jobRunErrorMessage, String triggerType, String jobRunErrorLog) {
        this.jobId = jobId;
        this.displayName = displayName;
        this.shortName = shortName;
        this.nextRunTime = nextRunTime;
        this.initializingError = initializingError;
        this.cronExpression = cronExpression;
        this.active = active;
        this.currentlyRunning = currentlyRunning;
        if (version != null) {
            this.lastRunHistory = new JobDetailHistoryData().setVersion(version).setJobRunStartTime(jobRunStartTime).setJobRunEndTime(jobRunEndTime).setStatus(status).setJobRunErrorMessage(jobRunErrorMessage).setTriggerType(triggerType).setJobRunErrorLog(jobRunErrorLog);
        }
    }

    @java.lang.SuppressWarnings("all")
        public Long getJobId() {
        return this.jobId;
    }

    @java.lang.SuppressWarnings("all")
        public String getDisplayName() {
        return this.displayName;
    }

    @java.lang.SuppressWarnings("all")
        public String getShortName() {
        return this.shortName;
    }

    @java.lang.SuppressWarnings("all")
        public Date getNextRunTime() {
        return this.nextRunTime;
    }

    @java.lang.SuppressWarnings("all")
        public String getInitializingError() {
        return this.initializingError;
    }

    @java.lang.SuppressWarnings("all")
        public String getCronExpression() {
        return this.cronExpression;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isActive() {
        return this.active;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isCurrentlyRunning() {
        return this.currentlyRunning;
    }

    @java.lang.SuppressWarnings("all")
        public JobDetailHistoryData getLastRunHistory() {
        return this.lastRunHistory;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailData setJobId(final Long jobId) {
        this.jobId = jobId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailData setDisplayName(final String displayName) {
        this.displayName = displayName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailData setShortName(final String shortName) {
        this.shortName = shortName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailData setNextRunTime(final Date nextRunTime) {
        this.nextRunTime = nextRunTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailData setInitializingError(final String initializingError) {
        this.initializingError = initializingError;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailData setCronExpression(final String cronExpression) {
        this.cronExpression = cronExpression;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailData setActive(final boolean active) {
        this.active = active;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailData setCurrentlyRunning(final boolean currentlyRunning) {
        this.currentlyRunning = currentlyRunning;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public JobDetailData setLastRunHistory(final JobDetailHistoryData lastRunHistory) {
        this.lastRunHistory = lastRunHistory;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof JobDetailData)) return false;
        final JobDetailData other = (JobDetailData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isActive() != other.isActive()) return false;
        if (this.isCurrentlyRunning() != other.isCurrentlyRunning()) return false;
        final java.lang.Object this$jobId = this.getJobId();
        final java.lang.Object other$jobId = other.getJobId();
        if (this$jobId == null ? other$jobId != null : !this$jobId.equals(other$jobId)) return false;
        final java.lang.Object this$displayName = this.getDisplayName();
        final java.lang.Object other$displayName = other.getDisplayName();
        if (this$displayName == null ? other$displayName != null : !this$displayName.equals(other$displayName)) return false;
        final java.lang.Object this$shortName = this.getShortName();
        final java.lang.Object other$shortName = other.getShortName();
        if (this$shortName == null ? other$shortName != null : !this$shortName.equals(other$shortName)) return false;
        final java.lang.Object this$nextRunTime = this.getNextRunTime();
        final java.lang.Object other$nextRunTime = other.getNextRunTime();
        if (this$nextRunTime == null ? other$nextRunTime != null : !this$nextRunTime.equals(other$nextRunTime)) return false;
        final java.lang.Object this$initializingError = this.getInitializingError();
        final java.lang.Object other$initializingError = other.getInitializingError();
        if (this$initializingError == null ? other$initializingError != null : !this$initializingError.equals(other$initializingError)) return false;
        final java.lang.Object this$cronExpression = this.getCronExpression();
        final java.lang.Object other$cronExpression = other.getCronExpression();
        if (this$cronExpression == null ? other$cronExpression != null : !this$cronExpression.equals(other$cronExpression)) return false;
        final java.lang.Object this$lastRunHistory = this.getLastRunHistory();
        final java.lang.Object other$lastRunHistory = other.getLastRunHistory();
        if (this$lastRunHistory == null ? other$lastRunHistory != null : !this$lastRunHistory.equals(other$lastRunHistory)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof JobDetailData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isActive() ? 79 : 97);
        result = result * PRIME + (this.isCurrentlyRunning() ? 79 : 97);
        final java.lang.Object $jobId = this.getJobId();
        result = result * PRIME + ($jobId == null ? 43 : $jobId.hashCode());
        final java.lang.Object $displayName = this.getDisplayName();
        result = result * PRIME + ($displayName == null ? 43 : $displayName.hashCode());
        final java.lang.Object $shortName = this.getShortName();
        result = result * PRIME + ($shortName == null ? 43 : $shortName.hashCode());
        final java.lang.Object $nextRunTime = this.getNextRunTime();
        result = result * PRIME + ($nextRunTime == null ? 43 : $nextRunTime.hashCode());
        final java.lang.Object $initializingError = this.getInitializingError();
        result = result * PRIME + ($initializingError == null ? 43 : $initializingError.hashCode());
        final java.lang.Object $cronExpression = this.getCronExpression();
        result = result * PRIME + ($cronExpression == null ? 43 : $cronExpression.hashCode());
        final java.lang.Object $lastRunHistory = this.getLastRunHistory();
        result = result * PRIME + ($lastRunHistory == null ? 43 : $lastRunHistory.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "JobDetailData(jobId=" + this.getJobId() + ", displayName=" + this.getDisplayName() + ", shortName=" + this.getShortName() + ", nextRunTime=" + this.getNextRunTime() + ", initializingError=" + this.getInitializingError() + ", cronExpression=" + this.getCronExpression() + ", active=" + this.isActive() + ", currentlyRunning=" + this.isCurrentlyRunning() + ", lastRunHistory=" + this.getLastRunHistory() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public JobDetailData() {
    }
}
