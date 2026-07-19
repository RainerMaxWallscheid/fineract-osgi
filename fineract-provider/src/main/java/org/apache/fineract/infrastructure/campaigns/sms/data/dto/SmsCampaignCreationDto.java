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

@JsonInclude(JsonInclude.Include.NON_NULL)
public class SmsCampaignCreationDto extends SmsCampaignDto {
    private Long providerId;
    private String frequency;
    private String interval;
    private String repeatsOnDay;

    @java.lang.SuppressWarnings("all")
        public Long getProviderId() {
        return this.providerId;
    }

    @java.lang.SuppressWarnings("all")
        public String getFrequency() {
        return this.frequency;
    }

    @java.lang.SuppressWarnings("all")
        public String getInterval() {
        return this.interval;
    }

    @java.lang.SuppressWarnings("all")
        public String getRepeatsOnDay() {
        return this.repeatsOnDay;
    }

    @java.lang.SuppressWarnings("all")
        public void setProviderId(final Long providerId) {
        this.providerId = providerId;
    }

    @java.lang.SuppressWarnings("all")
        public void setFrequency(final String frequency) {
        this.frequency = frequency;
    }

    @java.lang.SuppressWarnings("all")
        public void setInterval(final String interval) {
        this.interval = interval;
    }

    @java.lang.SuppressWarnings("all")
        public void setRepeatsOnDay(final String repeatsOnDay) {
        this.repeatsOnDay = repeatsOnDay;
    }

    @java.lang.SuppressWarnings("all")
        public SmsCampaignCreationDto() {
    }
}
