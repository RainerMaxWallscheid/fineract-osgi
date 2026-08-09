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
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Shared SMS campaign request fields. Used by composition (not inheritance) in
 * {@link SmsCampaignCreationDto} and {@link SmsCampaignUpdateDto}; Jackson flattens this
 * via {@code @JsonUnwrapped} so the public JSON shape stays flat.
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public final class SmsCampaignDto implements Serializable {

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

    public SmsCampaignDto() {}

    /**
     * Flat field map for Gson command serialization (no nested {@code campaign} object).
     */
    public static Map<String, Object> toCommandMap(final SmsCampaignDto campaign) {
        final Map<String, Object> map = new LinkedHashMap<>();
        if (campaign == null) {
            return map;
        }
        putIfPresent(map, "campaignName", campaign.getCampaignName());
        putIfPresent(map, "campaignType", campaign.getCampaignType());
        putIfPresent(map, "triggerType", campaign.getTriggerType());
        putIfPresent(map, "runReportId", campaign.getRunReportId());
        putIfPresent(map, "message", campaign.getMessage());
        putIfPresent(map, "paramValue", campaign.getParamValue());
        putIfPresent(map, "recurrenceStartDate", campaign.getRecurrenceStartDate());
        putIfPresent(map, "submittedOnDate", campaign.getSubmittedOnDate());
        putIfPresent(map, "isNotification", campaign.getIsNotification());
        putIfPresent(map, "locale", campaign.getLocale());
        putIfPresent(map, "dateFormat", campaign.getDateFormat());
        putIfPresent(map, "dateTimeFormat", campaign.getDateTimeFormat());
        return map;
    }

    private static void putIfPresent(final Map<String, Object> map, final String key, final Object value) {
        if (value != null) {
            map.put(key, value);
        }
    }

    public String getCampaignName() {
        return campaignName;
    }

    public void setCampaignName(final String campaignName) {
        this.campaignName = campaignName;
    }

    public Long getCampaignType() {
        return campaignType;
    }

    public void setCampaignType(final Long campaignType) {
        this.campaignType = campaignType;
    }

    public Long getTriggerType() {
        return triggerType;
    }

    public void setTriggerType(final Long triggerType) {
        this.triggerType = triggerType;
    }

    public Long getRunReportId() {
        return runReportId;
    }

    public void setRunReportId(final Long runReportId) {
        this.runReportId = runReportId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(final String message) {
        this.message = message;
    }

    public SmsCampaignParamReq getParamValue() {
        return paramValue;
    }

    public void setParamValue(final SmsCampaignParamReq paramValue) {
        this.paramValue = paramValue;
    }

    public String getRecurrenceStartDate() {
        return recurrenceStartDate;
    }

    public void setRecurrenceStartDate(final String recurrenceStartDate) {
        this.recurrenceStartDate = recurrenceStartDate;
    }

    public String getSubmittedOnDate() {
        return submittedOnDate;
    }

    public void setSubmittedOnDate(final String submittedOnDate) {
        this.submittedOnDate = submittedOnDate;
    }

    public Boolean getIsNotification() {
        return isNotification;
    }

    public void setIsNotification(final Boolean isNotification) {
        this.isNotification = isNotification;
    }

    public String getLocale() {
        return locale;
    }

    public void setLocale(final String locale) {
        this.locale = locale;
    }

    public String getDateFormat() {
        return dateFormat;
    }

    public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    public String getDateTimeFormat() {
        return dateTimeFormat;
    }

    public void setDateTimeFormat(final String dateTimeFormat) {
        this.dateTimeFormat = dateTimeFormat;
    }
}
