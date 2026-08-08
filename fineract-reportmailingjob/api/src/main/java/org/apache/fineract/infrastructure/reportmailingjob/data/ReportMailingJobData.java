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
import java.util.List;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.infrastructure.dataqueries.data.ReportData;

/**
 * Immutable data object representing report mailing job data.
 */
public final class ReportMailingJobData {
    private Long id;
    private String name;
    private String description;
    private ZonedDateTime startDateTime;
    private String recurrence;
    private ReportMailingJobTimelineData timeline;
    private String emailRecipients;
    private String emailSubject;
    private String emailMessage;
    private EnumOptionData emailAttachmentFileFormat;
    private ReportData stretchyReport;
    private String stretchyReportParamMap;
    private ZonedDateTime previousRunDateTime;
    private ZonedDateTime nextRunDateTime;
    private String previousRunStatus;
    private String previousRunErrorLog;
    private String previousRunErrorMessage;
    private Integer numberOfRuns;
    private boolean isActive;
    private List<EnumOptionData> emailAttachmentFileFormatOptions;
    private List<EnumOptionData> stretchyReportParamDateOptions;
    private Long runAsUserId;

    /**
     * @return an instance of the ReportMailingJobData class
     */
    public static ReportMailingJobData newInstance(final Long id, final String name, final String description, final ZonedDateTime startDateTime, final String recurrence, final ReportMailingJobTimelineData timeline, final String emailRecipients, final String emailSubject, final String emailMessage, final EnumOptionData emailAttachmentFileFormat, final ReportData stretchyReport, final String stretchyReportParamMap, final ZonedDateTime previousRunDateTime, final ZonedDateTime nextRunDateTime, final String previousRunStatus, final String previousRunErrorLog, final String previousRunErrorMessage, final Integer numberOfRuns, final boolean isActive, final Long runAsUserId) {
        return new ReportMailingJobData().setId(id).setName(name).setDescription(description).setStartDateTime(startDateTime).setRecurrence(recurrence).setTimeline(timeline).setEmailRecipients(emailRecipients).setEmailSubject(emailSubject).setEmailMessage(emailMessage).setEmailAttachmentFileFormat(emailAttachmentFileFormat).setStretchyReport(stretchyReport).setStretchyReportParamMap(stretchyReportParamMap).setPreviousRunDateTime(previousRunDateTime).setNextRunDateTime(nextRunDateTime).setPreviousRunStatus(previousRunStatus).setPreviousRunErrorLog(previousRunErrorLog).setPreviousRunErrorMessage(previousRunErrorMessage).setNumberOfRuns(numberOfRuns).setActive(isActive).setRunAsUserId(runAsUserId);
    }

    /**
     * @return an instance of the ReportMailingJobData class
     */
    public static ReportMailingJobData newInstance(final List<EnumOptionData> emailAttachmentFileFormatOptions, final List<EnumOptionData> stretchyReportParamDateOptions) {
        return new ReportMailingJobData().setEmailAttachmentFileFormatOptions(emailAttachmentFileFormatOptions).setStretchyReportParamDateOptions(stretchyReportParamDateOptions);
    }

    /**
     * @return an instance of the ReportMailingJobData class
     */
    public static ReportMailingJobData newInstance(final ReportMailingJobData dataWithoutEnumOptions, final ReportMailingJobData dataWithEnumOptions) {
        return new ReportMailingJobData().setId(dataWithoutEnumOptions.id).setName(dataWithoutEnumOptions.name).setDescription(dataWithoutEnumOptions.description).setStartDateTime(dataWithoutEnumOptions.startDateTime).setRecurrence(dataWithoutEnumOptions.recurrence).setTimeline(dataWithoutEnumOptions.timeline).setEmailRecipients(dataWithoutEnumOptions.emailRecipients).setEmailSubject(dataWithoutEnumOptions.emailSubject).setEmailMessage(dataWithoutEnumOptions.emailMessage).setEmailAttachmentFileFormat(dataWithoutEnumOptions.emailAttachmentFileFormat).setStretchyReport(dataWithoutEnumOptions.stretchyReport).setStretchyReportParamMap(dataWithoutEnumOptions.stretchyReportParamMap).setPreviousRunDateTime(dataWithoutEnumOptions.previousRunDateTime).setNextRunDateTime(dataWithoutEnumOptions.nextRunDateTime).setPreviousRunStatus(dataWithoutEnumOptions.previousRunStatus).setPreviousRunErrorLog(dataWithoutEnumOptions.previousRunErrorLog).setPreviousRunErrorMessage(dataWithoutEnumOptions.previousRunErrorMessage).setNumberOfRuns(dataWithoutEnumOptions.numberOfRuns).setActive(dataWithoutEnumOptions.isActive).setEmailAttachmentFileFormatOptions(dataWithEnumOptions.emailAttachmentFileFormatOptions).setStretchyReportParamDateOptions(dataWithEnumOptions.stretchyReportParamDateOptions).setRunAsUserId(dataWithoutEnumOptions.runAsUserId);
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
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getStartDateTime() {
        return this.startDateTime;
    }

    @java.lang.SuppressWarnings("all")
        public String getRecurrence() {
        return this.recurrence;
    }

    @java.lang.SuppressWarnings("all")
        public ReportMailingJobTimelineData getTimeline() {
        return this.timeline;
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
        public EnumOptionData getEmailAttachmentFileFormat() {
        return this.emailAttachmentFileFormat;
    }

    @java.lang.SuppressWarnings("all")
        public ReportData getStretchyReport() {
        return this.stretchyReport;
    }

    @java.lang.SuppressWarnings("all")
        public String getStretchyReportParamMap() {
        return this.stretchyReportParamMap;
    }

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getPreviousRunDateTime() {
        return this.previousRunDateTime;
    }

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getNextRunDateTime() {
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
        public List<EnumOptionData> getEmailAttachmentFileFormatOptions() {
        return this.emailAttachmentFileFormatOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getStretchyReportParamDateOptions() {
        return this.stretchyReportParamDateOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Long getRunAsUserId() {
        return this.runAsUserId;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setDescription(final String description) {
        this.description = description;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setStartDateTime(final ZonedDateTime startDateTime) {
        this.startDateTime = startDateTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setRecurrence(final String recurrence) {
        this.recurrence = recurrence;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setTimeline(final ReportMailingJobTimelineData timeline) {
        this.timeline = timeline;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setEmailRecipients(final String emailRecipients) {
        this.emailRecipients = emailRecipients;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setEmailSubject(final String emailSubject) {
        this.emailSubject = emailSubject;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setEmailMessage(final String emailMessage) {
        this.emailMessage = emailMessage;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setEmailAttachmentFileFormat(final EnumOptionData emailAttachmentFileFormat) {
        this.emailAttachmentFileFormat = emailAttachmentFileFormat;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setStretchyReport(final ReportData stretchyReport) {
        this.stretchyReport = stretchyReport;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setStretchyReportParamMap(final String stretchyReportParamMap) {
        this.stretchyReportParamMap = stretchyReportParamMap;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setPreviousRunDateTime(final ZonedDateTime previousRunDateTime) {
        this.previousRunDateTime = previousRunDateTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setNextRunDateTime(final ZonedDateTime nextRunDateTime) {
        this.nextRunDateTime = nextRunDateTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setPreviousRunStatus(final String previousRunStatus) {
        this.previousRunStatus = previousRunStatus;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setPreviousRunErrorLog(final String previousRunErrorLog) {
        this.previousRunErrorLog = previousRunErrorLog;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setPreviousRunErrorMessage(final String previousRunErrorMessage) {
        this.previousRunErrorMessage = previousRunErrorMessage;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setNumberOfRuns(final Integer numberOfRuns) {
        this.numberOfRuns = numberOfRuns;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setActive(final boolean isActive) {
        this.isActive = isActive;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setEmailAttachmentFileFormatOptions(final List<EnumOptionData> emailAttachmentFileFormatOptions) {
        this.emailAttachmentFileFormatOptions = emailAttachmentFileFormatOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setStretchyReportParamDateOptions(final List<EnumOptionData> stretchyReportParamDateOptions) {
        this.stretchyReportParamDateOptions = stretchyReportParamDateOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData setRunAsUserId(final Long runAsUserId) {
        this.runAsUserId = runAsUserId;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ReportMailingJobData)) return false;
        final ReportMailingJobData other = (ReportMailingJobData) o;
        if (this.isActive() != other.isActive()) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$numberOfRuns = this.getNumberOfRuns();
        final java.lang.Object other$numberOfRuns = other.getNumberOfRuns();
        if (this$numberOfRuns == null ? other$numberOfRuns != null : !this$numberOfRuns.equals(other$numberOfRuns)) return false;
        final java.lang.Object this$runAsUserId = this.getRunAsUserId();
        final java.lang.Object other$runAsUserId = other.getRunAsUserId();
        if (this$runAsUserId == null ? other$runAsUserId != null : !this$runAsUserId.equals(other$runAsUserId)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        final java.lang.Object this$startDateTime = this.getStartDateTime();
        final java.lang.Object other$startDateTime = other.getStartDateTime();
        if (this$startDateTime == null ? other$startDateTime != null : !this$startDateTime.equals(other$startDateTime)) return false;
        final java.lang.Object this$recurrence = this.getRecurrence();
        final java.lang.Object other$recurrence = other.getRecurrence();
        if (this$recurrence == null ? other$recurrence != null : !this$recurrence.equals(other$recurrence)) return false;
        final java.lang.Object this$timeline = this.getTimeline();
        final java.lang.Object other$timeline = other.getTimeline();
        if (this$timeline == null ? other$timeline != null : !this$timeline.equals(other$timeline)) return false;
        final java.lang.Object this$emailRecipients = this.getEmailRecipients();
        final java.lang.Object other$emailRecipients = other.getEmailRecipients();
        if (this$emailRecipients == null ? other$emailRecipients != null : !this$emailRecipients.equals(other$emailRecipients)) return false;
        final java.lang.Object this$emailSubject = this.getEmailSubject();
        final java.lang.Object other$emailSubject = other.getEmailSubject();
        if (this$emailSubject == null ? other$emailSubject != null : !this$emailSubject.equals(other$emailSubject)) return false;
        final java.lang.Object this$emailMessage = this.getEmailMessage();
        final java.lang.Object other$emailMessage = other.getEmailMessage();
        if (this$emailMessage == null ? other$emailMessage != null : !this$emailMessage.equals(other$emailMessage)) return false;
        final java.lang.Object this$emailAttachmentFileFormat = this.getEmailAttachmentFileFormat();
        final java.lang.Object other$emailAttachmentFileFormat = other.getEmailAttachmentFileFormat();
        if (this$emailAttachmentFileFormat == null ? other$emailAttachmentFileFormat != null : !this$emailAttachmentFileFormat.equals(other$emailAttachmentFileFormat)) return false;
        final java.lang.Object this$stretchyReport = this.getStretchyReport();
        final java.lang.Object other$stretchyReport = other.getStretchyReport();
        if (this$stretchyReport == null ? other$stretchyReport != null : !this$stretchyReport.equals(other$stretchyReport)) return false;
        final java.lang.Object this$stretchyReportParamMap = this.getStretchyReportParamMap();
        final java.lang.Object other$stretchyReportParamMap = other.getStretchyReportParamMap();
        if (this$stretchyReportParamMap == null ? other$stretchyReportParamMap != null : !this$stretchyReportParamMap.equals(other$stretchyReportParamMap)) return false;
        final java.lang.Object this$previousRunDateTime = this.getPreviousRunDateTime();
        final java.lang.Object other$previousRunDateTime = other.getPreviousRunDateTime();
        if (this$previousRunDateTime == null ? other$previousRunDateTime != null : !this$previousRunDateTime.equals(other$previousRunDateTime)) return false;
        final java.lang.Object this$nextRunDateTime = this.getNextRunDateTime();
        final java.lang.Object other$nextRunDateTime = other.getNextRunDateTime();
        if (this$nextRunDateTime == null ? other$nextRunDateTime != null : !this$nextRunDateTime.equals(other$nextRunDateTime)) return false;
        final java.lang.Object this$previousRunStatus = this.getPreviousRunStatus();
        final java.lang.Object other$previousRunStatus = other.getPreviousRunStatus();
        if (this$previousRunStatus == null ? other$previousRunStatus != null : !this$previousRunStatus.equals(other$previousRunStatus)) return false;
        final java.lang.Object this$previousRunErrorLog = this.getPreviousRunErrorLog();
        final java.lang.Object other$previousRunErrorLog = other.getPreviousRunErrorLog();
        if (this$previousRunErrorLog == null ? other$previousRunErrorLog != null : !this$previousRunErrorLog.equals(other$previousRunErrorLog)) return false;
        final java.lang.Object this$previousRunErrorMessage = this.getPreviousRunErrorMessage();
        final java.lang.Object other$previousRunErrorMessage = other.getPreviousRunErrorMessage();
        if (this$previousRunErrorMessage == null ? other$previousRunErrorMessage != null : !this$previousRunErrorMessage.equals(other$previousRunErrorMessage)) return false;
        final java.lang.Object this$emailAttachmentFileFormatOptions = this.getEmailAttachmentFileFormatOptions();
        final java.lang.Object other$emailAttachmentFileFormatOptions = other.getEmailAttachmentFileFormatOptions();
        if (this$emailAttachmentFileFormatOptions == null ? other$emailAttachmentFileFormatOptions != null : !this$emailAttachmentFileFormatOptions.equals(other$emailAttachmentFileFormatOptions)) return false;
        final java.lang.Object this$stretchyReportParamDateOptions = this.getStretchyReportParamDateOptions();
        final java.lang.Object other$stretchyReportParamDateOptions = other.getStretchyReportParamDateOptions();
        if (this$stretchyReportParamDateOptions == null ? other$stretchyReportParamDateOptions != null : !this$stretchyReportParamDateOptions.equals(other$stretchyReportParamDateOptions)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isActive() ? 79 : 97);
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $numberOfRuns = this.getNumberOfRuns();
        result = result * PRIME + ($numberOfRuns == null ? 43 : $numberOfRuns.hashCode());
        final java.lang.Object $runAsUserId = this.getRunAsUserId();
        result = result * PRIME + ($runAsUserId == null ? 43 : $runAsUserId.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        final java.lang.Object $startDateTime = this.getStartDateTime();
        result = result * PRIME + ($startDateTime == null ? 43 : $startDateTime.hashCode());
        final java.lang.Object $recurrence = this.getRecurrence();
        result = result * PRIME + ($recurrence == null ? 43 : $recurrence.hashCode());
        final java.lang.Object $timeline = this.getTimeline();
        result = result * PRIME + ($timeline == null ? 43 : $timeline.hashCode());
        final java.lang.Object $emailRecipients = this.getEmailRecipients();
        result = result * PRIME + ($emailRecipients == null ? 43 : $emailRecipients.hashCode());
        final java.lang.Object $emailSubject = this.getEmailSubject();
        result = result * PRIME + ($emailSubject == null ? 43 : $emailSubject.hashCode());
        final java.lang.Object $emailMessage = this.getEmailMessage();
        result = result * PRIME + ($emailMessage == null ? 43 : $emailMessage.hashCode());
        final java.lang.Object $emailAttachmentFileFormat = this.getEmailAttachmentFileFormat();
        result = result * PRIME + ($emailAttachmentFileFormat == null ? 43 : $emailAttachmentFileFormat.hashCode());
        final java.lang.Object $stretchyReport = this.getStretchyReport();
        result = result * PRIME + ($stretchyReport == null ? 43 : $stretchyReport.hashCode());
        final java.lang.Object $stretchyReportParamMap = this.getStretchyReportParamMap();
        result = result * PRIME + ($stretchyReportParamMap == null ? 43 : $stretchyReportParamMap.hashCode());
        final java.lang.Object $previousRunDateTime = this.getPreviousRunDateTime();
        result = result * PRIME + ($previousRunDateTime == null ? 43 : $previousRunDateTime.hashCode());
        final java.lang.Object $nextRunDateTime = this.getNextRunDateTime();
        result = result * PRIME + ($nextRunDateTime == null ? 43 : $nextRunDateTime.hashCode());
        final java.lang.Object $previousRunStatus = this.getPreviousRunStatus();
        result = result * PRIME + ($previousRunStatus == null ? 43 : $previousRunStatus.hashCode());
        final java.lang.Object $previousRunErrorLog = this.getPreviousRunErrorLog();
        result = result * PRIME + ($previousRunErrorLog == null ? 43 : $previousRunErrorLog.hashCode());
        final java.lang.Object $previousRunErrorMessage = this.getPreviousRunErrorMessage();
        result = result * PRIME + ($previousRunErrorMessage == null ? 43 : $previousRunErrorMessage.hashCode());
        final java.lang.Object $emailAttachmentFileFormatOptions = this.getEmailAttachmentFileFormatOptions();
        result = result * PRIME + ($emailAttachmentFileFormatOptions == null ? 43 : $emailAttachmentFileFormatOptions.hashCode());
        final java.lang.Object $stretchyReportParamDateOptions = this.getStretchyReportParamDateOptions();
        result = result * PRIME + ($stretchyReportParamDateOptions == null ? 43 : $stretchyReportParamDateOptions.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ReportMailingJobData(id=" + this.getId() + ", name=" + this.getName() + ", description=" + this.getDescription() + ", startDateTime=" + this.getStartDateTime() + ", recurrence=" + this.getRecurrence() + ", timeline=" + this.getTimeline() + ", emailRecipients=" + this.getEmailRecipients() + ", emailSubject=" + this.getEmailSubject() + ", emailMessage=" + this.getEmailMessage() + ", emailAttachmentFileFormat=" + this.getEmailAttachmentFileFormat() + ", stretchyReport=" + this.getStretchyReport() + ", stretchyReportParamMap=" + this.getStretchyReportParamMap() + ", previousRunDateTime=" + this.getPreviousRunDateTime() + ", nextRunDateTime=" + this.getNextRunDateTime() + ", previousRunStatus=" + this.getPreviousRunStatus() + ", previousRunErrorLog=" + this.getPreviousRunErrorLog() + ", previousRunErrorMessage=" + this.getPreviousRunErrorMessage() + ", numberOfRuns=" + this.getNumberOfRuns() + ", isActive=" + this.isActive() + ", emailAttachmentFileFormatOptions=" + this.getEmailAttachmentFileFormatOptions() + ", stretchyReportParamDateOptions=" + this.getStretchyReportParamDateOptions() + ", runAsUserId=" + this.getRunAsUserId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ReportMailingJobData() {
    }
}
