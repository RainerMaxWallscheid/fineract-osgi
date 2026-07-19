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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonUnwrapped;
import java.io.Serial;
import java.io.Serializable;
import java.util.Map;

/**
 * Create-campaign request: shared fields via composition ({@link SmsCampaignDto}) plus
 * create-only scheduling attributes.
 * <p>
 * Jackson binds a flat JSON body onto the nested {@code campaign} via {@link JsonUnwrapped}.
 * The command pipeline re-serializes with Gson, which does not understand {@code JsonUnwrapped};
 * use {@link #toCommandMap()} for a flat map before Gson serialization.
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public final class SmsCampaignCreationDto implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @JsonUnwrapped
    private SmsCampaignDto campaign = new SmsCampaignDto();

    private Long providerId;
    private String frequency;
    private String interval;
    private String repeatsOnDay;

    public SmsCampaignCreationDto() {}

    @JsonIgnore
    public SmsCampaignDto getCampaign() {
        return campaign;
    }

    public void setCampaign(final SmsCampaignDto campaign) {
        this.campaign = campaign != null ? campaign : new SmsCampaignDto();
    }

    public Long getProviderId() {
        return providerId;
    }

    public void setProviderId(final Long providerId) {
        this.providerId = providerId;
    }

    public String getFrequency() {
        return frequency;
    }

    public void setFrequency(final String frequency) {
        this.frequency = frequency;
    }

    public String getInterval() {
        return interval;
    }

    public void setInterval(final String interval) {
        this.interval = interval;
    }

    public String getRepeatsOnDay() {
        return repeatsOnDay;
    }

    public void setRepeatsOnDay(final String repeatsOnDay) {
        this.repeatsOnDay = repeatsOnDay;
    }

    /**
     * Flat payload for the legacy Gson command serializer (top-level field names).
     */
    public Map<String, Object> toCommandMap() {
        final Map<String, Object> map = SmsCampaignDto.toCommandMap(campaign);
        putIfPresent(map, "providerId", providerId);
        putIfPresent(map, "frequency", frequency);
        putIfPresent(map, "interval", interval);
        putIfPresent(map, "repeatsOnDay", repeatsOnDay);
        return map;
    }

    private static void putIfPresent(final Map<String, Object> map, final String key, final Object value) {
        if (value != null) {
            map.put(key, value);
        }
    }

    // --- convenience accessors (delegate to composed campaign) ---

    public String getCampaignName() {
        return campaign.getCampaignName();
    }

    public Long getCampaignType() {
        return campaign.getCampaignType();
    }

    public Long getTriggerType() {
        return campaign.getTriggerType();
    }

    public Long getRunReportId() {
        return campaign.getRunReportId();
    }

    public String getMessage() {
        return campaign.getMessage();
    }

    public SmsCampaignParamReq getParamValue() {
        return campaign.getParamValue();
    }

    public String getRecurrenceStartDate() {
        return campaign.getRecurrenceStartDate();
    }

    public String getSubmittedOnDate() {
        return campaign.getSubmittedOnDate();
    }

    public Boolean getIsNotification() {
        return campaign.getIsNotification();
    }

    public String getLocale() {
        return campaign.getLocale();
    }

    public String getDateFormat() {
        return campaign.getDateFormat();
    }

    public String getDateTimeFormat() {
        return campaign.getDateTimeFormat();
    }
}
