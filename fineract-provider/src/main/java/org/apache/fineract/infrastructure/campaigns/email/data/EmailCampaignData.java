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
package org.apache.fineract.infrastructure.campaigns.email.data;

import java.time.LocalDate;
import java.time.ZonedDateTime;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;

public final class EmailCampaignData {
    @SuppressWarnings("unused")
    private Long id;
    @SuppressWarnings("unused")
    private String campaignName;
    @SuppressWarnings("unused")
    private Integer campaignType;
    @SuppressWarnings("unused")
    private Long businessRuleId;
    @SuppressWarnings("unused")
    private String paramValue;
    @SuppressWarnings("unused")
    private EnumOptionData campaignStatus;
    @SuppressWarnings("unused")
    private String emailSubject;
    @SuppressWarnings("unused")
    private String emailMessage;
    @SuppressWarnings("unused")
    private String emailAttachmentFileFormat;
    @SuppressWarnings("unused")
    private Long stretchyReportId;
    @SuppressWarnings("unused")
    private String stretchyReportParamMap;
    @SuppressWarnings("unused")
    private ZonedDateTime nextTriggerDate;
    @SuppressWarnings("unused")
    private LocalDate lastTriggerDate;
    @SuppressWarnings("unused")
    private EmailCampaignTimeLine emailCampaignTimeLine;
    @SuppressWarnings("unused")
    private ZonedDateTime recurrenceStartDate;
    private String recurrence;

    public static EmailCampaignData instance(final Long id, final String campaignName, final Integer campaignType, final Long businessRuleId, final String paramValue, final EnumOptionData campaignStatus, final String emailSubject, final String message, final String emailAttachmentFileFormat, final Long stretchyReportId, final String stretchyReportParamMap, final ZonedDateTime nextTriggerDate, final LocalDate lastTriggerDate, final EmailCampaignTimeLine emailCampaignTimeLine, final ZonedDateTime recurrenceStartDate, final String recurrence) {
        return new EmailCampaignData().setId(id).setCampaignName(campaignName).setCampaignType(campaignType).setBusinessRuleId(businessRuleId).setParamValue(paramValue).setCampaignStatus(campaignStatus).setEmailSubject(emailSubject).setEmailMessage(message).setEmailAttachmentFileFormat(emailAttachmentFileFormat).setStretchyReportId(stretchyReportId).setStretchyReportParamMap(stretchyReportParamMap).setNextTriggerDate(nextTriggerDate).setLastTriggerDate(lastTriggerDate).setEmailCampaignTimeLine(emailCampaignTimeLine).setRecurrenceStartDate(recurrenceStartDate).setRecurrence(recurrence);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getCampaignName() {
        return this.campaignName;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getCampaignType() {
        return this.campaignType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getBusinessRuleId() {
        return this.businessRuleId;
    }

    @java.lang.SuppressWarnings("all")
        public String getParamValue() {
        return this.paramValue;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getCampaignStatus() {
        return this.campaignStatus;
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
        public Long getStretchyReportId() {
        return this.stretchyReportId;
    }

    @java.lang.SuppressWarnings("all")
        public String getStretchyReportParamMap() {
        return this.stretchyReportParamMap;
    }

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getNextTriggerDate() {
        return this.nextTriggerDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getLastTriggerDate() {
        return this.lastTriggerDate;
    }

    @java.lang.SuppressWarnings("all")
        public EmailCampaignTimeLine getEmailCampaignTimeLine() {
        return this.emailCampaignTimeLine;
    }

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getRecurrenceStartDate() {
        return this.recurrenceStartDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getRecurrence() {
        return this.recurrence;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignData setCampaignName(final String campaignName) {
        this.campaignName = campaignName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignData setCampaignType(final Integer campaignType) {
        this.campaignType = campaignType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignData setBusinessRuleId(final Long businessRuleId) {
        this.businessRuleId = businessRuleId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignData setParamValue(final String paramValue) {
        this.paramValue = paramValue;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignData setCampaignStatus(final EnumOptionData campaignStatus) {
        this.campaignStatus = campaignStatus;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignData setEmailSubject(final String emailSubject) {
        this.emailSubject = emailSubject;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignData setEmailMessage(final String emailMessage) {
        this.emailMessage = emailMessage;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignData setEmailAttachmentFileFormat(final String emailAttachmentFileFormat) {
        this.emailAttachmentFileFormat = emailAttachmentFileFormat;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignData setStretchyReportId(final Long stretchyReportId) {
        this.stretchyReportId = stretchyReportId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignData setStretchyReportParamMap(final String stretchyReportParamMap) {
        this.stretchyReportParamMap = stretchyReportParamMap;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignData setNextTriggerDate(final ZonedDateTime nextTriggerDate) {
        this.nextTriggerDate = nextTriggerDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignData setLastTriggerDate(final LocalDate lastTriggerDate) {
        this.lastTriggerDate = lastTriggerDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignData setEmailCampaignTimeLine(final EmailCampaignTimeLine emailCampaignTimeLine) {
        this.emailCampaignTimeLine = emailCampaignTimeLine;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignData setRecurrenceStartDate(final ZonedDateTime recurrenceStartDate) {
        this.recurrenceStartDate = recurrenceStartDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignData setRecurrence(final String recurrence) {
        this.recurrence = recurrence;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof EmailCampaignData)) return false;
        final EmailCampaignData other = (EmailCampaignData) o;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$campaignType = this.getCampaignType();
        final java.lang.Object other$campaignType = other.getCampaignType();
        if (this$campaignType == null ? other$campaignType != null : !this$campaignType.equals(other$campaignType)) return false;
        final java.lang.Object this$businessRuleId = this.getBusinessRuleId();
        final java.lang.Object other$businessRuleId = other.getBusinessRuleId();
        if (this$businessRuleId == null ? other$businessRuleId != null : !this$businessRuleId.equals(other$businessRuleId)) return false;
        final java.lang.Object this$stretchyReportId = this.getStretchyReportId();
        final java.lang.Object other$stretchyReportId = other.getStretchyReportId();
        if (this$stretchyReportId == null ? other$stretchyReportId != null : !this$stretchyReportId.equals(other$stretchyReportId)) return false;
        final java.lang.Object this$campaignName = this.getCampaignName();
        final java.lang.Object other$campaignName = other.getCampaignName();
        if (this$campaignName == null ? other$campaignName != null : !this$campaignName.equals(other$campaignName)) return false;
        final java.lang.Object this$paramValue = this.getParamValue();
        final java.lang.Object other$paramValue = other.getParamValue();
        if (this$paramValue == null ? other$paramValue != null : !this$paramValue.equals(other$paramValue)) return false;
        final java.lang.Object this$campaignStatus = this.getCampaignStatus();
        final java.lang.Object other$campaignStatus = other.getCampaignStatus();
        if (this$campaignStatus == null ? other$campaignStatus != null : !this$campaignStatus.equals(other$campaignStatus)) return false;
        final java.lang.Object this$emailSubject = this.getEmailSubject();
        final java.lang.Object other$emailSubject = other.getEmailSubject();
        if (this$emailSubject == null ? other$emailSubject != null : !this$emailSubject.equals(other$emailSubject)) return false;
        final java.lang.Object this$emailMessage = this.getEmailMessage();
        final java.lang.Object other$emailMessage = other.getEmailMessage();
        if (this$emailMessage == null ? other$emailMessage != null : !this$emailMessage.equals(other$emailMessage)) return false;
        final java.lang.Object this$emailAttachmentFileFormat = this.getEmailAttachmentFileFormat();
        final java.lang.Object other$emailAttachmentFileFormat = other.getEmailAttachmentFileFormat();
        if (this$emailAttachmentFileFormat == null ? other$emailAttachmentFileFormat != null : !this$emailAttachmentFileFormat.equals(other$emailAttachmentFileFormat)) return false;
        final java.lang.Object this$stretchyReportParamMap = this.getStretchyReportParamMap();
        final java.lang.Object other$stretchyReportParamMap = other.getStretchyReportParamMap();
        if (this$stretchyReportParamMap == null ? other$stretchyReportParamMap != null : !this$stretchyReportParamMap.equals(other$stretchyReportParamMap)) return false;
        final java.lang.Object this$nextTriggerDate = this.getNextTriggerDate();
        final java.lang.Object other$nextTriggerDate = other.getNextTriggerDate();
        if (this$nextTriggerDate == null ? other$nextTriggerDate != null : !this$nextTriggerDate.equals(other$nextTriggerDate)) return false;
        final java.lang.Object this$lastTriggerDate = this.getLastTriggerDate();
        final java.lang.Object other$lastTriggerDate = other.getLastTriggerDate();
        if (this$lastTriggerDate == null ? other$lastTriggerDate != null : !this$lastTriggerDate.equals(other$lastTriggerDate)) return false;
        final java.lang.Object this$emailCampaignTimeLine = this.getEmailCampaignTimeLine();
        final java.lang.Object other$emailCampaignTimeLine = other.getEmailCampaignTimeLine();
        if (this$emailCampaignTimeLine == null ? other$emailCampaignTimeLine != null : !this$emailCampaignTimeLine.equals(other$emailCampaignTimeLine)) return false;
        final java.lang.Object this$recurrenceStartDate = this.getRecurrenceStartDate();
        final java.lang.Object other$recurrenceStartDate = other.getRecurrenceStartDate();
        if (this$recurrenceStartDate == null ? other$recurrenceStartDate != null : !this$recurrenceStartDate.equals(other$recurrenceStartDate)) return false;
        final java.lang.Object this$recurrence = this.getRecurrence();
        final java.lang.Object other$recurrence = other.getRecurrence();
        if (this$recurrence == null ? other$recurrence != null : !this$recurrence.equals(other$recurrence)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $campaignType = this.getCampaignType();
        result = result * PRIME + ($campaignType == null ? 43 : $campaignType.hashCode());
        final java.lang.Object $businessRuleId = this.getBusinessRuleId();
        result = result * PRIME + ($businessRuleId == null ? 43 : $businessRuleId.hashCode());
        final java.lang.Object $stretchyReportId = this.getStretchyReportId();
        result = result * PRIME + ($stretchyReportId == null ? 43 : $stretchyReportId.hashCode());
        final java.lang.Object $campaignName = this.getCampaignName();
        result = result * PRIME + ($campaignName == null ? 43 : $campaignName.hashCode());
        final java.lang.Object $paramValue = this.getParamValue();
        result = result * PRIME + ($paramValue == null ? 43 : $paramValue.hashCode());
        final java.lang.Object $campaignStatus = this.getCampaignStatus();
        result = result * PRIME + ($campaignStatus == null ? 43 : $campaignStatus.hashCode());
        final java.lang.Object $emailSubject = this.getEmailSubject();
        result = result * PRIME + ($emailSubject == null ? 43 : $emailSubject.hashCode());
        final java.lang.Object $emailMessage = this.getEmailMessage();
        result = result * PRIME + ($emailMessage == null ? 43 : $emailMessage.hashCode());
        final java.lang.Object $emailAttachmentFileFormat = this.getEmailAttachmentFileFormat();
        result = result * PRIME + ($emailAttachmentFileFormat == null ? 43 : $emailAttachmentFileFormat.hashCode());
        final java.lang.Object $stretchyReportParamMap = this.getStretchyReportParamMap();
        result = result * PRIME + ($stretchyReportParamMap == null ? 43 : $stretchyReportParamMap.hashCode());
        final java.lang.Object $nextTriggerDate = this.getNextTriggerDate();
        result = result * PRIME + ($nextTriggerDate == null ? 43 : $nextTriggerDate.hashCode());
        final java.lang.Object $lastTriggerDate = this.getLastTriggerDate();
        result = result * PRIME + ($lastTriggerDate == null ? 43 : $lastTriggerDate.hashCode());
        final java.lang.Object $emailCampaignTimeLine = this.getEmailCampaignTimeLine();
        result = result * PRIME + ($emailCampaignTimeLine == null ? 43 : $emailCampaignTimeLine.hashCode());
        final java.lang.Object $recurrenceStartDate = this.getRecurrenceStartDate();
        result = result * PRIME + ($recurrenceStartDate == null ? 43 : $recurrenceStartDate.hashCode());
        final java.lang.Object $recurrence = this.getRecurrence();
        result = result * PRIME + ($recurrence == null ? 43 : $recurrence.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "EmailCampaignData(id=" + this.getId() + ", campaignName=" + this.getCampaignName() + ", campaignType=" + this.getCampaignType() + ", businessRuleId=" + this.getBusinessRuleId() + ", paramValue=" + this.getParamValue() + ", campaignStatus=" + this.getCampaignStatus() + ", emailSubject=" + this.getEmailSubject() + ", emailMessage=" + this.getEmailMessage() + ", emailAttachmentFileFormat=" + this.getEmailAttachmentFileFormat() + ", stretchyReportId=" + this.getStretchyReportId() + ", stretchyReportParamMap=" + this.getStretchyReportParamMap() + ", nextTriggerDate=" + this.getNextTriggerDate() + ", lastTriggerDate=" + this.getLastTriggerDate() + ", emailCampaignTimeLine=" + this.getEmailCampaignTimeLine() + ", recurrenceStartDate=" + this.getRecurrenceStartDate() + ", recurrence=" + this.getRecurrence() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public EmailCampaignData() {
    }
}
