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

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Map;
import org.junit.jupiter.api.Test;

/**
 * Verifies inheritance → composition for SMS campaign request DTOs:
 * flat JSON still binds, and command maps stay flat for Gson.
 */
class SmsCampaignDtoCompositionTest {

    private final ObjectMapper mapper = new ObjectMapper();

    @Test
    void jacksonBindsFlatJsonOntoComposedCampaign() throws Exception {
        final String json = """
                {
                  "campaignName": "Spring Promo",
                  "campaignType": 1,
                  "triggerType": 2,
                  "runReportId": 10,
                  "message": "Hello",
                  "providerId": 5,
                  "frequency": "1",
                  "locale": "en",
                  "dateFormat": "yyyyMMdd"
                }
                """;

        final SmsCampaignCreationDto dto = mapper.readValue(json, SmsCampaignCreationDto.class);

        assertEquals("Spring Promo", dto.getCampaignName());
        assertEquals(1L, dto.getCampaignType());
        assertEquals(2L, dto.getTriggerType());
        assertEquals(10L, dto.getRunReportId());
        assertEquals("Hello", dto.getMessage());
        assertEquals(5L, dto.getProviderId());
        assertEquals("1", dto.getFrequency());
        assertEquals("en", dto.getLocale());
        assertEquals("yyyyMMdd", dto.getDateFormat());
        assertNotNull(dto.getCampaign());
    }

    @Test
    void creationToCommandMapIsFlat() throws Exception {
        final String json = """
                {
                  "campaignName": "Spring Promo",
                  "campaignType": 1,
                  "message": "Hello",
                  "providerId": 5,
                  "interval": "2"
                }
                """;
        final SmsCampaignCreationDto dto = mapper.readValue(json, SmsCampaignCreationDto.class);
        final Map<String, Object> map = dto.toCommandMap();

        assertEquals("Spring Promo", map.get("campaignName"));
        assertEquals(1L, map.get("campaignType"));
        assertEquals("Hello", map.get("message"));
        assertEquals(5L, map.get("providerId"));
        assertEquals("2", map.get("interval"));
        assertNull(map.get("campaign"));
    }

    @Test
    void updateToCommandMapIncludesRecurrence() throws Exception {
        final String json = """
                {
                  "campaignName": "Updated",
                  "message": "Hi",
                  "recurrence": "FREQ=DAILY"
                }
                """;
        final SmsCampaignUpdateDto dto = mapper.readValue(json, SmsCampaignUpdateDto.class);
        final Map<String, Object> map = dto.toCommandMap();

        assertEquals("Updated", map.get("campaignName"));
        assertEquals("Hi", map.get("message"));
        assertEquals("FREQ=DAILY", map.get("recurrence"));
        assertNull(map.get("campaign"));
    }
}
