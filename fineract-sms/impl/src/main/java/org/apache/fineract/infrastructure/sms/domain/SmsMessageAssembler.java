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
package org.apache.fineract.infrastructure.sms.domain;

import com.google.gson.JsonElement;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.serialization.FromJsonHelper;
import org.apache.fineract.infrastructure.sms.SmsApiConstants;
import org.apache.fineract.infrastructure.sms.exception.SmsNotFoundException;
import org.apache.fineract.organisation.staff.exception.StaffNotFoundException;
import org.apache.fineract.organisation.staff.moduleapi.StaffPersistablePort;
import org.apache.fineract.portfolio.client.moduleapi.ClientActivePort;
import org.apache.fineract.portfolio.group.moduleapi.GroupActivePort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class SmsMessageAssembler {

    private final SmsMessageRepository smsMessageRepository;
    private final GroupActivePort groupActivePort;
    private final ClientActivePort clientActivePort;
    private final StaffPersistablePort staffPersistablePort;
    private final FromJsonHelper fromApiJsonHelper;
    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public SmsMessageAssembler(final SmsMessageRepository smsMessageRepository, final GroupActivePort groupActivePort,
            final ClientActivePort clientActivePort, final StaffPersistablePort staffPersistablePort, final FromJsonHelper fromApiJsonHelper,
            final JdbcTemplate jdbcTemplate) {
        this.smsMessageRepository = smsMessageRepository;
        this.groupActivePort = groupActivePort;
        this.clientActivePort = clientActivePort;
        this.staffPersistablePort = staffPersistablePort;
        this.fromApiJsonHelper = fromApiJsonHelper;
        this.jdbcTemplate = jdbcTemplate;
    }

    public SmsMessage assembleFromJson(final JsonCommand command) {

        final JsonElement element = command.parsedJson();

        String mobileNo = null;
        Object group = null;
        String externalId = null;
        if (this.fromApiJsonHelper.parameterExists(SmsApiConstants.groupIdParamName, element)) {
            final Long groupId = this.fromApiJsonHelper.extractLongNamed(SmsApiConstants.groupIdParamName, element);
            group = this.groupActivePort.persistableById(groupId);
        }

        Long campaignId = null;
        boolean isNotification = false;
        if (this.fromApiJsonHelper.parameterExists(SmsApiConstants.campaignIdParamName, element)) {
            campaignId = this.fromApiJsonHelper.extractLongNamed(SmsApiConstants.campaignIdParamName, element);
            isNotification = isCampaignNotification(campaignId);
        }

        Object client = null;
        if (this.fromApiJsonHelper.parameterExists(SmsApiConstants.clientIdParamName, element)) {
            final Long clientId = this.fromApiJsonHelper.extractLongNamed(SmsApiConstants.clientIdParamName, element);
            client = this.clientActivePort.persistableById(clientId);
            mobileNo = this.clientActivePort.mobileNo(clientId);
        }

        Object staff = null;
        if (this.fromApiJsonHelper.parameterExists(SmsApiConstants.staffIdParamName, element)) {
            final Long staffId = this.fromApiJsonHelper.extractLongNamed(SmsApiConstants.staffIdParamName, element);
            staff = this.staffPersistablePort.persistableById(staffId);
            if (staff == null) {
                throw new StaffNotFoundException(staffId);
            }
            mobileNo = this.staffPersistablePort.mobileNo(staffId);
        }

        final String message = this.fromApiJsonHelper.extractStringNamed(SmsApiConstants.messageParamName, element);

        return SmsMessage.pendingSms(externalId, group, client, staff, message, mobileNo, campaignId, isNotification);
    }

    private boolean isCampaignNotification(final Long campaignId) {
        if (campaignId == null) {
            return false;
        }
        try {
            final Boolean value = this.jdbcTemplate.queryForObject("select is_notification from sms_campaign where id = ?", Boolean.class,
                    campaignId);
            return Boolean.TRUE.equals(value);
        } catch (final EmptyResultDataAccessException ex) {
            return false;
        }
    }

    public SmsMessage assembleFromResourceId(final Long resourceId) {
        return this.smsMessageRepository.findById(resourceId).orElseThrow(() -> new SmsNotFoundException(resourceId));
    }
}
