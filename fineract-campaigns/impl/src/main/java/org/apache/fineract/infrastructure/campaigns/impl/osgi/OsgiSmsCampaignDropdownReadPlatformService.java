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
package org.apache.fineract.infrastructure.campaigns.impl.osgi;

import java.util.Collection;
import java.util.List;
import org.apache.fineract.infrastructure.campaigns.sms.data.SmsProviderData;
import org.apache.fineract.infrastructure.campaigns.sms.service.SmsCampaignDropdownReadPlatformService;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;

/**
 * Empty SMS-campaign dropdown catalog for Equinox without Spring/JPA.
 */
final class OsgiSmsCampaignDropdownReadPlatformService implements SmsCampaignDropdownReadPlatformService {

    @Override
    public Collection<EnumOptionData> retrieveCampaignTriggerTypes() {
        return List.of();
    }

    @Override
    public Collection<SmsProviderData> retrieveSmsProviders() {
        return List.of();
    }

    @Override
    public Collection<EnumOptionData> retrieveCampaignTypes() {
        return List.of();
    }

    @Override
    public Collection<EnumOptionData> retrieveWeeks() {
        return List.of();
    }

    @Override
    public Collection<EnumOptionData> retrieveMonths() {
        return List.of();
    }

    @Override
    public Collection<EnumOptionData> retrivePeriodFrequencyTypes() {
        return List.of();
    }
}
