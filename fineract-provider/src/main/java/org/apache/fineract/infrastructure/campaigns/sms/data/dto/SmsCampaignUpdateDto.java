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
 * Update-campaign request: shared fields via composition ({@link SmsCampaignDto}) plus
 * update-only {@code recurrence}.
 * <p>
 * See {@link SmsCampaignCreationDto} for Jackson vs Gson serialization notes.
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public final class SmsCampaignUpdateDto implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @JsonUnwrapped
    private SmsCampaignDto campaign = new SmsCampaignDto();

    private String recurrence;

    public SmsCampaignUpdateDto() {}

    @JsonIgnore
    public SmsCampaignDto getCampaign() {
        return campaign;
    }

    public void setCampaign(final SmsCampaignDto campaign) {
        this.campaign = campaign != null ? campaign : new SmsCampaignDto();
    }

    public String getRecurrence() {
        return recurrence;
    }

    public void setRecurrence(final String recurrence) {
        this.recurrence = recurrence;
    }

    /**
     * Flat payload for the legacy Gson command serializer (top-level field names).
     */
    public Map<String, Object> toCommandMap() {
        final Map<String, Object> map = SmsCampaignDto.toCommandMap(campaign);
        if (recurrence != null) {
            map.put("recurrence", recurrence);
        }
        return map;
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
