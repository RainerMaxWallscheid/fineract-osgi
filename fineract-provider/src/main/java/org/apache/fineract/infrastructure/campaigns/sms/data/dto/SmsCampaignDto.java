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
package org.apache.fineract.infrastructure.campaigns.sms.data.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import java.io.Serial;
import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
public abstract class SmsCampaignDto implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String campaignName;
    private Long campaignType;
    private Long triggerType;
    private Long runReportId;
    private String message;
    private SmsCampaignParamReq paramValue;
    private String recurrenceStartDate;
    private String submittedOnDate;
    private Boolean isNotification;
    private String locale;
    private String dateFormat;
    private String dateTimeFormat;

    @java.lang.SuppressWarnings("all")
        public String getCampaignName() {
        return this.campaignName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCampaignType() {
        return this.campaignType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getTriggerType() {
        return this.triggerType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getRunReportId() {
        return this.runReportId;
    }

    @java.lang.SuppressWarnings("all")
        public String getMessage() {
        return this.message;
    }

    @java.lang.SuppressWarnings("all")
        public SmsCampaignParamReq getParamValue() {
        return this.paramValue;
    }

    @java.lang.SuppressWarnings("all")
        public String getRecurrenceStartDate() {
        return this.recurrenceStartDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getSubmittedOnDate() {
        return this.submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsNotification() {
        return this.isNotification;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateTimeFormat() {
        return this.dateTimeFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setCampaignName(final String campaignName) {
        this.campaignName = campaignName;
    }

    @java.lang.SuppressWarnings("all")
        public void setCampaignType(final Long campaignType) {
        this.campaignType = campaignType;
    }

    @java.lang.SuppressWarnings("all")
        public void setTriggerType(final Long triggerType) {
        this.triggerType = triggerType;
    }

    @java.lang.SuppressWarnings("all")
        public void setRunReportId(final Long runReportId) {
        this.runReportId = runReportId;
    }

    @java.lang.SuppressWarnings("all")
        public void setMessage(final String message) {
        this.message = message;
    }

    @java.lang.SuppressWarnings("all")
        public void setParamValue(final SmsCampaignParamReq paramValue) {
        this.paramValue = paramValue;
    }

    @java.lang.SuppressWarnings("all")
        public void setRecurrenceStartDate(final String recurrenceStartDate) {
        this.recurrenceStartDate = recurrenceStartDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setSubmittedOnDate(final String submittedOnDate) {
        this.submittedOnDate = submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsNotification(final Boolean isNotification) {
        this.isNotification = isNotification;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateTimeFormat(final String dateTimeFormat) {
        this.dateTimeFormat = dateTimeFormat;
    }

    @java.lang.SuppressWarnings("all")
        public SmsCampaignDto() {
    }
}
