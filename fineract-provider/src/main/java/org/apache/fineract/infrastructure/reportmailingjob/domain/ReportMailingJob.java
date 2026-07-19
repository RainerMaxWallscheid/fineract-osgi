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
package org.apache.fineract.infrastructure.reportmailingjob.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableCustom;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.dataqueries.domain.Report;
import org.apache.fineract.infrastructure.reportmailingjob.ReportMailingJobConstants;
import org.apache.fineract.infrastructure.reportmailingjob.data.ReportMailingJobEmailAttachmentFileFormat;
import org.apache.fineract.useradministration.domain.AppUser;

@Entity
@Table(name = "m_report_mailing_job", uniqueConstraints = {@UniqueConstraint(columnNames = {"name"}, name = "unique_name")})
public class ReportMailingJob extends AbstractAuditableCustom {
    private static final long serialVersionUID = -2197602941230009227L;
    @Column(name = "name", nullable = false)
    private String name;
    @Column(name = "description", nullable = true)
    private String description;
    @Column(name = "start_datetime", nullable = false)
    private LocalDateTime startDateTime;
    @Column(name = "recurrence", nullable = true)
    private String recurrence;
    @Column(name = "email_recipients", nullable = false)
    private String emailRecipients;
    @Column(name = "email_subject", nullable = false)
    private String emailSubject;
    @Column(name = "email_message", nullable = false)
    private String emailMessage;
    @Column(name = "email_attachment_file_format", nullable = false)
    private String emailAttachmentFileFormat;
    @ManyToOne
    @JoinColumn(name = "stretchy_report_id", nullable = false)
    private Report stretchyReport;
    @Column(name = "stretchy_report_param_map", nullable = true)
    private String stretchyReportParamMap;
    @Column(name = "previous_run_datetime", nullable = true)
    private LocalDateTime previousRunDateTime;
    @Column(name = "next_run_datetime", nullable = true)
    private LocalDateTime nextRunDateTime;
    @Column(name = "previous_run_status", nullable = true)
    private String previousRunStatus;
    @Column(name = "previous_run_error_log", nullable = true)
    private String previousRunErrorLog;
    @Column(name = "previous_run_error_message", nullable = true)
    private String previousRunErrorMessage;
    @Column(name = "number_of_runs", nullable = false)
    private Integer numberOfRuns;
    @Column(name = "is_active", nullable = false)
    private boolean isActive;
    @Column(name = "is_deleted", nullable = false)
    private boolean isDeleted;
    @ManyToOne(optional = false)
    @JoinColumn(name = "run_as_userid", nullable = false)
    private AppUser runAsUser;

    /**
     * create a new instance of the ReportMailingJob for a new entry
     *
     * @return ReportMailingJob object
     */
    public static ReportMailingJob newInstance(final String name, final String description, final LocalDateTime startDateTime, final String recurrence, final String emailRecipients, final String emailSubject, final String emailMessage, final ReportMailingJobEmailAttachmentFileFormat emailAttachmentFileFormat, final Report stretchyReport, final String stretchyReportParamMap, final boolean isActive, final AppUser runAsUser) {
        return new ReportMailingJob().setName(name).setDescription(description).setStartDateTime(startDateTime).setRecurrence(recurrence).setEmailRecipients(emailRecipients).setEmailSubject(emailSubject).setEmailMessage(emailMessage).setEmailAttachmentFileFormat(emailAttachmentFileFormat.getValue()).setStretchyReport(stretchyReport).setStretchyReportParamMap(stretchyReportParamMap).setActive(isActive).setDeleted(false).setRunAsUser(runAsUser);
    }

    /**
     * create a new instance of the ReportmailingJob for a new entry
     *
     * @return ReportMailingJob object
     */
    public static ReportMailingJob newInstance(JsonCommand jsonCommand, final Report stretchyReport, final AppUser runAsUser) {
        final String name = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.NAME_PARAM_NAME);
        final String description = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.DESCRIPTION_PARAM_NAME);
        final String recurrence = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.RECURRENCE_PARAM_NAME);
        final boolean isActive = jsonCommand.booleanPrimitiveValueOfParameterNamed(ReportMailingJobConstants.IS_ACTIVE_PARAM_NAME);
        final String emailRecipients = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.EMAIL_RECIPIENTS_PARAM_NAME);
        final String emailSubject = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.EMAIL_SUBJECT_PARAM_NAME);
        final String emailMessage = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.EMAIL_MESSAGE_PARAM_NAME);
        final String stretchyReportParamMap = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.STRETCHY_REPORT_PARAM_MAP_PARAM_NAME);
        final Integer emailAttachmentFileFormatId = jsonCommand.integerValueOfParameterNamed(ReportMailingJobConstants.EMAIL_ATTACHMENT_FILE_FORMAT_ID_PARAM_NAME);
        final ReportMailingJobEmailAttachmentFileFormat emailAttachmentFileFormat = ReportMailingJobEmailAttachmentFileFormat.newInstance(emailAttachmentFileFormatId);
        LocalDateTime startDateTime = LocalDateTime.now(DateUtils.getDateTimeZoneOfTenant());
        if (jsonCommand.hasParameter(ReportMailingJobConstants.START_DATE_TIME_PARAM_NAME)) {
            final String startDateTimeString = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.START_DATE_TIME_PARAM_NAME);
            if (startDateTimeString != null) {
                final DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern(jsonCommand.dateFormat()).withLocale(jsonCommand.extractLocale());
                startDateTime = LocalDateTime.parse(startDateTimeString, dateTimeFormatter);
            }
        }
        return new ReportMailingJob().setName(name).setDescription(description).setStartDateTime(startDateTime).setRecurrence(recurrence).setEmailRecipients(emailRecipients).setEmailSubject(emailSubject).setEmailMessage(emailMessage).setEmailAttachmentFileFormat(emailAttachmentFileFormat.getValue()).setStretchyReport(stretchyReport).setStretchyReportParamMap(stretchyReportParamMap).setNextRunDateTime(startDateTime).setActive(isActive).setDeleted(false).setRunAsUser(runAsUser);
    }

    /**
     * Update the ReportMailingJob entity
     *
     * @param jsonCommand
     *            JsonCommand object
     * @return map of string to object
     */
    public Map<String, Object> update(final JsonCommand jsonCommand) {
        final Map<String, Object> actualChanges = new LinkedHashMap<>();
        if (jsonCommand.isChangeInStringParameterNamed(ReportMailingJobConstants.NAME_PARAM_NAME, this.name)) {
            final String name = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.NAME_PARAM_NAME);
            actualChanges.put(ReportMailingJobConstants.NAME_PARAM_NAME, name);
            this.name = name;
        }
        if (jsonCommand.isChangeInStringParameterNamed(ReportMailingJobConstants.DESCRIPTION_PARAM_NAME, this.description)) {
            final String description = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.DESCRIPTION_PARAM_NAME);
            actualChanges.put(ReportMailingJobConstants.DESCRIPTION_PARAM_NAME, description);
            this.description = description;
        }
        if (jsonCommand.isChangeInStringParameterNamed(ReportMailingJobConstants.RECURRENCE_PARAM_NAME, this.recurrence)) {
            final String recurrence = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.RECURRENCE_PARAM_NAME);
            actualChanges.put(ReportMailingJobConstants.RECURRENCE_PARAM_NAME, recurrence);
            this.recurrence = recurrence;
        }
        if (jsonCommand.isChangeInBooleanParameterNamed(ReportMailingJobConstants.IS_ACTIVE_PARAM_NAME, this.isActive)) {
            final boolean isActive = jsonCommand.booleanPrimitiveValueOfParameterNamed(ReportMailingJobConstants.IS_ACTIVE_PARAM_NAME);
            actualChanges.put(ReportMailingJobConstants.IS_ACTIVE_PARAM_NAME, isActive);
            this.isActive = isActive;
        }
        if (jsonCommand.isChangeInStringParameterNamed(ReportMailingJobConstants.EMAIL_RECIPIENTS_PARAM_NAME, this.emailRecipients)) {
            final String emailRecipients = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.EMAIL_RECIPIENTS_PARAM_NAME);
            actualChanges.put(ReportMailingJobConstants.EMAIL_RECIPIENTS_PARAM_NAME, emailRecipients);
            this.emailRecipients = emailRecipients;
        }
        if (jsonCommand.isChangeInStringParameterNamed(ReportMailingJobConstants.EMAIL_SUBJECT_PARAM_NAME, this.emailSubject)) {
            final String emailSubject = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.EMAIL_SUBJECT_PARAM_NAME);
            actualChanges.put(ReportMailingJobConstants.EMAIL_SUBJECT_PARAM_NAME, emailSubject);
            this.emailSubject = emailSubject;
        }
        if (jsonCommand.isChangeInStringParameterNamed(ReportMailingJobConstants.EMAIL_MESSAGE_PARAM_NAME, this.emailMessage)) {
            final String emailMessage = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.EMAIL_MESSAGE_PARAM_NAME);
            actualChanges.put(ReportMailingJobConstants.EMAIL_MESSAGE_PARAM_NAME, emailMessage);
            this.emailMessage = emailMessage;
        }
        if (jsonCommand.isChangeInStringParameterNamed(ReportMailingJobConstants.STRETCHY_REPORT_PARAM_MAP_PARAM_NAME, this.stretchyReportParamMap)) {
            final String stretchyReportParamMap = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.STRETCHY_REPORT_PARAM_MAP_PARAM_NAME);
            actualChanges.put(ReportMailingJobConstants.STRETCHY_REPORT_PARAM_MAP_PARAM_NAME, stretchyReportParamMap);
            this.stretchyReportParamMap = stretchyReportParamMap;
        }
        final ReportMailingJobEmailAttachmentFileFormat emailAttachmentFileFormat = ReportMailingJobEmailAttachmentFileFormat.newInstance(this.emailAttachmentFileFormat);
        if (jsonCommand.isChangeInIntegerParameterNamed(ReportMailingJobConstants.EMAIL_ATTACHMENT_FILE_FORMAT_ID_PARAM_NAME, emailAttachmentFileFormat.getId())) {
            final Integer emailAttachmentFileFormatId = jsonCommand.integerValueOfParameterNamed(ReportMailingJobConstants.EMAIL_ATTACHMENT_FILE_FORMAT_ID_PARAM_NAME);
            actualChanges.put(ReportMailingJobConstants.EMAIL_ATTACHMENT_FILE_FORMAT_ID_PARAM_NAME, emailAttachmentFileFormatId);
            final ReportMailingJobEmailAttachmentFileFormat newEmailAttachmentFileFormat = ReportMailingJobEmailAttachmentFileFormat.newInstance(emailAttachmentFileFormatId);
            this.emailAttachmentFileFormat = newEmailAttachmentFileFormat.getValue();
        }
        final String newStartDateTimeString = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.START_DATE_TIME_PARAM_NAME);
        if (!StringUtils.isEmpty(newStartDateTimeString)) {
            final DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern(jsonCommand.dateFormat()).withLocale(jsonCommand.extractLocale());
            final LocalDateTime newStartDateTime = LocalDateTime.parse(newStartDateTimeString, dateTimeFormatter);
            final LocalDateTime oldStartDateTime = this.startDateTime;
            if ((oldStartDateTime != null) && !newStartDateTime.equals(oldStartDateTime)) {
                actualChanges.put(ReportMailingJobConstants.START_DATE_TIME_PARAM_NAME, newStartDateTimeString);
                this.startDateTime = newStartDateTime;
            }
        }
        Long currentStretchyReportId = null;
        if (this.stretchyReport != null) {
            currentStretchyReportId = this.stretchyReport.getId();
        }
        if (jsonCommand.isChangeInLongParameterNamed(ReportMailingJobConstants.STRETCHY_REPORT_ID_PARAM_NAME, currentStretchyReportId)) {
            final Long updatedStretchyReportId = jsonCommand.longValueOfParameterNamed(ReportMailingJobConstants.STRETCHY_REPORT_ID_PARAM_NAME);
            actualChanges.put(ReportMailingJobConstants.STRETCHY_REPORT_ID_PARAM_NAME, updatedStretchyReportId);
        }
        return actualChanges;
    }

    /**
     * delete the report mailing job, set the isDeleted property to 1 and alter the name
     */
    public void delete() {
        this.isDeleted = true;
        this.isActive = false;
        this.name = this.name + "_deleted_" + this.getId();
    }

    /**
     * increase the numberOfRuns by 1
     */
    public void increaseNumberOfRunsByOne() {
        this.numberOfRuns++;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDateTime getStartDateTime() {
        return this.startDateTime;
    }

    @java.lang.SuppressWarnings("all")
        public String getRecurrence() {
        return this.recurrence;
    }

    @java.lang.SuppressWarnings("all")
        public String getEmailRecipients() {
        return this.emailRecipients;
    }

    @java.lang.SuppressWarnings("all")
        public String getEmailSubject() {
        return this.emailSubject;
    }

    @java.lang.SuppressWarnings("all")
        public String getEmailMessage() {
        return this.emailMessage;
    }

    @java.lang.SuppressWarnings("all")
        public String getEmailAttachmentFileFormat() {
        return this.emailAttachmentFileFormat;
    }

    @java.lang.SuppressWarnings("all")
        public Report getStretchyReport() {
        return this.stretchyReport;
    }

    @java.lang.SuppressWarnings("all")
        public String getStretchyReportParamMap() {
        return this.stretchyReportParamMap;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDateTime getPreviousRunDateTime() {
        return this.previousRunDateTime;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDateTime getNextRunDateTime() {
        return this.nextRunDateTime;
    }

    @java.lang.SuppressWarnings("all")
        public String getPreviousRunStatus() {
        return this.previousRunStatus;
    }

    @java.lang.SuppressWarnings("all")
        public String getPreviousRunErrorLog() {
        return this.previousRunErrorLog;
    }

    @java.lang.SuppressWarnings("all")
        public String getPreviousRunErrorMessage() {
        return this.previousRunErrorMessage;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getNumberOfRuns() {
        return this.numberOfRuns;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isActive() {
        return this.isActive;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isDeleted() {
        return this.isDeleted;
    }

    @java.lang.SuppressWarnings("all")
        public AppUser getRunAsUser() {
        return this.runAsUser;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setDescription(final String description) {
        this.description = description;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setStartDateTime(final LocalDateTime startDateTime) {
        this.startDateTime = startDateTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setRecurrence(final String recurrence) {
        this.recurrence = recurrence;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setEmailRecipients(final String emailRecipients) {
        this.emailRecipients = emailRecipients;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setEmailSubject(final String emailSubject) {
        this.emailSubject = emailSubject;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setEmailMessage(final String emailMessage) {
        this.emailMessage = emailMessage;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setEmailAttachmentFileFormat(final String emailAttachmentFileFormat) {
        this.emailAttachmentFileFormat = emailAttachmentFileFormat;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setStretchyReport(final Report stretchyReport) {
        this.stretchyReport = stretchyReport;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setStretchyReportParamMap(final String stretchyReportParamMap) {
        this.stretchyReportParamMap = stretchyReportParamMap;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setPreviousRunDateTime(final LocalDateTime previousRunDateTime) {
        this.previousRunDateTime = previousRunDateTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setNextRunDateTime(final LocalDateTime nextRunDateTime) {
        this.nextRunDateTime = nextRunDateTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setPreviousRunStatus(final String previousRunStatus) {
        this.previousRunStatus = previousRunStatus;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setPreviousRunErrorLog(final String previousRunErrorLog) {
        this.previousRunErrorLog = previousRunErrorLog;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setPreviousRunErrorMessage(final String previousRunErrorMessage) {
        this.previousRunErrorMessage = previousRunErrorMessage;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setNumberOfRuns(final Integer numberOfRuns) {
        this.numberOfRuns = numberOfRuns;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setActive(final boolean isActive) {
        this.isActive = isActive;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setDeleted(final boolean isDeleted) {
        this.isDeleted = isDeleted;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJob setRunAsUser(final AppUser runAsUser) {
        this.runAsUser = runAsUser;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public ReportMailingJob() {
    }
}
