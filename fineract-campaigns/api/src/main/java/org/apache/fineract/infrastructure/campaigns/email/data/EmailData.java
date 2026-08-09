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
import java.util.List;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.infrastructure.dataqueries.data.ReportData;

/**
 * Immutable data object representing a SMS message.
 */
public final class EmailData {
    private Long id;
    private Long groupId;
    private Long clientId;
    private Long staffId;
    private EnumOptionData status;
    private String emailAddress;
    private String emailSubject;
    private String emailMessage;
    private EnumOptionData emailAttachmentFileFormat;
    private ReportData stretchyReport;
    private String stretchyReportParamMap;
    private List<EnumOptionData> emailAttachmentFileFormatOptions;
    private List<EnumOptionData> stretchyReportParamDateOptions;
    private String campaignName;
    private LocalDate sentDate;
    private String errorMessage;

    public static EmailData instance(final Long id, final Long groupId, final Long clientId, final Long staffId, final EnumOptionData status, final String emailAddress, final String emailSubject, final String message, final EnumOptionData emailAttachmentFileFormat, final ReportData stretchyReport, final String stretchyReportParamMap, final List<EnumOptionData> emailAttachmentFileFormatOptions, final List<EnumOptionData> stretchyReportParamDateOptions, final String campaignName, final LocalDate sentDate, final String errorMessage) {
        return new EmailData().setId(id).setGroupId(groupId).setClientId(clientId).setStaffId(staffId).setStatus(status).setEmailAddress(emailAddress).setEmailSubject(emailSubject).setEmailMessage(message).setEmailAttachmentFileFormat(emailAttachmentFileFormat).setStretchyReport(stretchyReport).setStretchyReportParamMap(stretchyReportParamMap).setEmailAttachmentFileFormatOptions(emailAttachmentFileFormatOptions).setStretchyReportParamDateOptions(stretchyReportParamDateOptions).setCampaignName(campaignName).setSentDate(sentDate).setErrorMessage(errorMessage);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getGroupId() {
        return this.groupId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getStaffId() {
        return this.staffId;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public String getEmailAddress() {
        return this.emailAddress;
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
        public List<EnumOptionData> getEmailAttachmentFileFormatOptions() {
        return this.emailAttachmentFileFormatOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getStretchyReportParamDateOptions() {
        return this.stretchyReportParamDateOptions;
    }

    @java.lang.SuppressWarnings("all")
        public String getCampaignName() {
        return this.campaignName;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSentDate() {
        return this.sentDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getErrorMessage() {
        return this.errorMessage;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailData setGroupId(final Long groupId) {
        this.groupId = groupId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailData setClientId(final Long clientId) {
        this.clientId = clientId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailData setStaffId(final Long staffId) {
        this.staffId = staffId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailData setStatus(final EnumOptionData status) {
        this.status = status;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailData setEmailAddress(final String emailAddress) {
        this.emailAddress = emailAddress;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailData setEmailSubject(final String emailSubject) {
        this.emailSubject = emailSubject;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailData setEmailMessage(final String emailMessage) {
        this.emailMessage = emailMessage;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailData setEmailAttachmentFileFormat(final EnumOptionData emailAttachmentFileFormat) {
        this.emailAttachmentFileFormat = emailAttachmentFileFormat;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailData setStretchyReport(final ReportData stretchyReport) {
        this.stretchyReport = stretchyReport;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailData setStretchyReportParamMap(final String stretchyReportParamMap) {
        this.stretchyReportParamMap = stretchyReportParamMap;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailData setEmailAttachmentFileFormatOptions(final List<EnumOptionData> emailAttachmentFileFormatOptions) {
        this.emailAttachmentFileFormatOptions = emailAttachmentFileFormatOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailData setStretchyReportParamDateOptions(final List<EnumOptionData> stretchyReportParamDateOptions) {
        this.stretchyReportParamDateOptions = stretchyReportParamDateOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailData setCampaignName(final String campaignName) {
        this.campaignName = campaignName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailData setSentDate(final LocalDate sentDate) {
        this.sentDate = sentDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailData setErrorMessage(final String errorMessage) {
        this.errorMessage = errorMessage;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof EmailData)) return false;
        final EmailData other = (EmailData) o;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$groupId = this.getGroupId();
        final java.lang.Object other$groupId = other.getGroupId();
        if (this$groupId == null ? other$groupId != null : !this$groupId.equals(other$groupId)) return false;
        final java.lang.Object this$clientId = this.getClientId();
        final java.lang.Object other$clientId = other.getClientId();
        if (this$clientId == null ? other$clientId != null : !this$clientId.equals(other$clientId)) return false;
        final java.lang.Object this$staffId = this.getStaffId();
        final java.lang.Object other$staffId = other.getStaffId();
        if (this$staffId == null ? other$staffId != null : !this$staffId.equals(other$staffId)) return false;
        final java.lang.Object this$status = this.getStatus();
        final java.lang.Object other$status = other.getStatus();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        final java.lang.Object this$emailAddress = this.getEmailAddress();
        final java.lang.Object other$emailAddress = other.getEmailAddress();
        if (this$emailAddress == null ? other$emailAddress != null : !this$emailAddress.equals(other$emailAddress)) return false;
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
        final java.lang.Object this$emailAttachmentFileFormatOptions = this.getEmailAttachmentFileFormatOptions();
        final java.lang.Object other$emailAttachmentFileFormatOptions = other.getEmailAttachmentFileFormatOptions();
        if (this$emailAttachmentFileFormatOptions == null ? other$emailAttachmentFileFormatOptions != null : !this$emailAttachmentFileFormatOptions.equals(other$emailAttachmentFileFormatOptions)) return false;
        final java.lang.Object this$stretchyReportParamDateOptions = this.getStretchyReportParamDateOptions();
        final java.lang.Object other$stretchyReportParamDateOptions = other.getStretchyReportParamDateOptions();
        if (this$stretchyReportParamDateOptions == null ? other$stretchyReportParamDateOptions != null : !this$stretchyReportParamDateOptions.equals(other$stretchyReportParamDateOptions)) return false;
        final java.lang.Object this$campaignName = this.getCampaignName();
        final java.lang.Object other$campaignName = other.getCampaignName();
        if (this$campaignName == null ? other$campaignName != null : !this$campaignName.equals(other$campaignName)) return false;
        final java.lang.Object this$sentDate = this.getSentDate();
        final java.lang.Object other$sentDate = other.getSentDate();
        if (this$sentDate == null ? other$sentDate != null : !this$sentDate.equals(other$sentDate)) return false;
        final java.lang.Object this$errorMessage = this.getErrorMessage();
        final java.lang.Object other$errorMessage = other.getErrorMessage();
        if (this$errorMessage == null ? other$errorMessage != null : !this$errorMessage.equals(other$errorMessage)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $groupId = this.getGroupId();
        result = result * PRIME + ($groupId == null ? 43 : $groupId.hashCode());
        final java.lang.Object $clientId = this.getClientId();
        result = result * PRIME + ($clientId == null ? 43 : $clientId.hashCode());
        final java.lang.Object $staffId = this.getStaffId();
        result = result * PRIME + ($staffId == null ? 43 : $staffId.hashCode());
        final java.lang.Object $status = this.getStatus();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        final java.lang.Object $emailAddress = this.getEmailAddress();
        result = result * PRIME + ($emailAddress == null ? 43 : $emailAddress.hashCode());
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
        final java.lang.Object $emailAttachmentFileFormatOptions = this.getEmailAttachmentFileFormatOptions();
        result = result * PRIME + ($emailAttachmentFileFormatOptions == null ? 43 : $emailAttachmentFileFormatOptions.hashCode());
        final java.lang.Object $stretchyReportParamDateOptions = this.getStretchyReportParamDateOptions();
        result = result * PRIME + ($stretchyReportParamDateOptions == null ? 43 : $stretchyReportParamDateOptions.hashCode());
        final java.lang.Object $campaignName = this.getCampaignName();
        result = result * PRIME + ($campaignName == null ? 43 : $campaignName.hashCode());
        final java.lang.Object $sentDate = this.getSentDate();
        result = result * PRIME + ($sentDate == null ? 43 : $sentDate.hashCode());
        final java.lang.Object $errorMessage = this.getErrorMessage();
        result = result * PRIME + ($errorMessage == null ? 43 : $errorMessage.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "EmailData(id=" + this.getId() + ", groupId=" + this.getGroupId() + ", clientId=" + this.getClientId() + ", staffId=" + this.getStaffId() + ", status=" + this.getStatus() + ", emailAddress=" + this.getEmailAddress() + ", emailSubject=" + this.getEmailSubject() + ", emailMessage=" + this.getEmailMessage() + ", emailAttachmentFileFormat=" + this.getEmailAttachmentFileFormat() + ", stretchyReport=" + this.getStretchyReport() + ", stretchyReportParamMap=" + this.getStretchyReportParamMap() + ", emailAttachmentFileFormatOptions=" + this.getEmailAttachmentFileFormatOptions() + ", stretchyReportParamDateOptions=" + this.getStretchyReportParamDateOptions() + ", campaignName=" + this.getCampaignName() + ", sentDate=" + this.getSentDate() + ", errorMessage=" + this.getErrorMessage() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public EmailData() {
    }
}
