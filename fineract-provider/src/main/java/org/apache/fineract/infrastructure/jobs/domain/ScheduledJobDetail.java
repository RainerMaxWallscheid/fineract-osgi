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
package org.apache.fineract.infrastructure.jobs.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.persistence.UniqueConstraint;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.infrastructure.jobs.api.SchedulerJobApiConstants;

@Entity
@Table(name = "job", uniqueConstraints = {@UniqueConstraint(columnNames = {"short_name"}, name = "job_short_name_key")})
public class ScheduledJobDetail extends AbstractPersistableCustom<Long> {
    @Column(name = "name")
    private String jobName;
    @Column(name = "display_name")
    private String jobDisplayName;
    @Column(name = "node_id")
    private Integer nodeId;
    @Column(name = "is_mismatched_job")
    private boolean isMismatchedJob;
    @Column(name = "cron_expression")
    private String cronExpression;
    @Column(name = "create_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createTime;
    @Column(name = "task_priority")
    private Short taskPriority;
    @Column(name = "group_name")
    private String groupName;
    @Column(name = "previous_run_start_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date previousRunStartTime;
    @Column(name = "next_run_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date nextRunTime;
    @Column(name = "job_key")
    private String jobKey;
    @Column(name = "initializing_errorlog")
    private String errorLog;
    @Column(name = "is_active")
    private boolean activeSchedular;
    @Column(name = "currently_running")
    private boolean currentlyRunning;
    @Column(name = "updates_allowed")
    private boolean updatesAllowed;
    @Column(name = "scheduler_group")
    private Short schedulerGroup;
    @Column(name = "is_misfired")
    private boolean triggerMisfired;
    @Column(name = "short_name", nullable = false)
    private String shortName;

    public Map<String, Object> update(final JsonCommand command) {
        final Map<String, Object> actualChanges = new LinkedHashMap<>(9);
        if (command.isChangeInStringParameterNamed(SchedulerJobApiConstants.displayNameParamName, this.jobDisplayName)) {
            final String newValue = command.stringValueOfParameterNamed(SchedulerJobApiConstants.displayNameParamName).trim();
            actualChanges.put(SchedulerJobApiConstants.displayNameParamName, newValue);
            this.jobDisplayName = StringUtils.defaultIfEmpty(newValue, null);
        }
        if (command.isChangeInStringParameterNamed(SchedulerJobApiConstants.cronExpressionParamName, this.cronExpression)) {
            final String newValue = command.stringValueOfParameterNamed(SchedulerJobApiConstants.cronExpressionParamName).trim();
            actualChanges.put(SchedulerJobApiConstants.cronExpressionParamName, newValue);
            this.cronExpression = StringUtils.defaultIfEmpty(newValue, null);
        }
        if (command.isChangeInBooleanParameterNamed(SchedulerJobApiConstants.jobActiveStatusParamName, this.activeSchedular)) {
            final boolean newValue = command.booleanPrimitiveValueOfParameterNamed(SchedulerJobApiConstants.jobActiveStatusParamName);
            actualChanges.put(SchedulerJobApiConstants.jobActiveStatusParamName, newValue);
            this.activeSchedular = newValue;
        }
        return actualChanges;
    }

    @java.lang.SuppressWarnings("all")
        public String getJobName() {
        return this.jobName;
    }

    @java.lang.SuppressWarnings("all")
        public String getJobDisplayName() {
        return this.jobDisplayName;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getNodeId() {
        return this.nodeId;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isMismatchedJob() {
        return this.isMismatchedJob;
    }

    @java.lang.SuppressWarnings("all")
        public String getCronExpression() {
        return this.cronExpression;
    }

    @java.lang.SuppressWarnings("all")
        public Date getCreateTime() {
        return this.createTime;
    }

    @java.lang.SuppressWarnings("all")
        public Short getTaskPriority() {
        return this.taskPriority;
    }

    @java.lang.SuppressWarnings("all")
        public String getGroupName() {
        return this.groupName;
    }

    @java.lang.SuppressWarnings("all")
        public Date getPreviousRunStartTime() {
        return this.previousRunStartTime;
    }

    @java.lang.SuppressWarnings("all")
        public Date getNextRunTime() {
        return this.nextRunTime;
    }

    @java.lang.SuppressWarnings("all")
        public String getJobKey() {
        return this.jobKey;
    }

    @java.lang.SuppressWarnings("all")
        public String getErrorLog() {
        return this.errorLog;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isActiveSchedular() {
        return this.activeSchedular;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isCurrentlyRunning() {
        return this.currentlyRunning;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isUpdatesAllowed() {
        return this.updatesAllowed;
    }

    @java.lang.SuppressWarnings("all")
        public Short getSchedulerGroup() {
        return this.schedulerGroup;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isTriggerMisfired() {
        return this.triggerMisfired;
    }

    @java.lang.SuppressWarnings("all")
        public String getShortName() {
        return this.shortName;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setJobName(final String jobName) {
        this.jobName = jobName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setJobDisplayName(final String jobDisplayName) {
        this.jobDisplayName = jobDisplayName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setNodeId(final Integer nodeId) {
        this.nodeId = nodeId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setMismatchedJob(final boolean isMismatchedJob) {
        this.isMismatchedJob = isMismatchedJob;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setCronExpression(final String cronExpression) {
        this.cronExpression = cronExpression;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setCreateTime(final Date createTime) {
        this.createTime = createTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setTaskPriority(final Short taskPriority) {
        this.taskPriority = taskPriority;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setGroupName(final String groupName) {
        this.groupName = groupName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setPreviousRunStartTime(final Date previousRunStartTime) {
        this.previousRunStartTime = previousRunStartTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setNextRunTime(final Date nextRunTime) {
        this.nextRunTime = nextRunTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setJobKey(final String jobKey) {
        this.jobKey = jobKey;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setErrorLog(final String errorLog) {
        this.errorLog = errorLog;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setActiveSchedular(final boolean activeSchedular) {
        this.activeSchedular = activeSchedular;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setCurrentlyRunning(final boolean currentlyRunning) {
        this.currentlyRunning = currentlyRunning;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setUpdatesAllowed(final boolean updatesAllowed) {
        this.updatesAllowed = updatesAllowed;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setSchedulerGroup(final Short schedulerGroup) {
        this.schedulerGroup = schedulerGroup;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setTriggerMisfired(final boolean triggerMisfired) {
        this.triggerMisfired = triggerMisfired;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail setShortName(final String shortName) {
        this.shortName = shortName;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public ScheduledJobDetail() {
    }
}
