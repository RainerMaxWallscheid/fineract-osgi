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
import org.apache.fineract.organisation.staff.domain.Staff;
import org.apache.fineract.organisation.staff.domain.StaffRepository;
import org.apache.fineract.organisation.staff.exception.StaffNotFoundException;
import org.apache.fineract.portfolio.client.domain.Client;
import org.apache.fineract.portfolio.client.domain.ClientRepository;
import org.apache.fineract.portfolio.client.exception.ClientNotFoundException;
import org.apache.fineract.portfolio.group.domain.Group;
import org.apache.fineract.portfolio.group.domain.GroupRepository;
import org.apache.fineract.portfolio.group.exception.GroupNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class SmsMessageAssembler {

    private final SmsMessageRepository smsMessageRepository;
    private final GroupRepository groupRepository;
    private final ClientRepository clientRepository;
    private final StaffRepository staffRepository;
    private final FromJsonHelper fromApiJsonHelper;
    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public SmsMessageAssembler(final SmsMessageRepository smsMessageRepository, final GroupRepository groupRepository,
            final ClientRepository clientRepository, final StaffRepository staffRepository, final FromJsonHelper fromApiJsonHelper,
            final JdbcTemplate jdbcTemplate) {
        this.smsMessageRepository = smsMessageRepository;
        this.groupRepository = groupRepository;
        this.clientRepository = clientRepository;
        this.staffRepository = staffRepository;
        this.fromApiJsonHelper = fromApiJsonHelper;
        this.jdbcTemplate = jdbcTemplate;
    }

    public SmsMessage assembleFromJson(final JsonCommand command) {

        final JsonElement element = command.parsedJson();

        String mobileNo = null;
        Group group = null;
        String externalId = null;
        if (this.fromApiJsonHelper.parameterExists(SmsApiConstants.groupIdParamName, element)) {
            final Long groupId = this.fromApiJsonHelper.extractLongNamed(SmsApiConstants.groupIdParamName, element);
            group = this.groupRepository.findById(groupId).orElseThrow(() -> new GroupNotFoundException(groupId));
        }

        Long campaignId = null;
        boolean isNotification = false;
        if (this.fromApiJsonHelper.parameterExists(SmsApiConstants.campaignIdParamName, element)) {
            campaignId = this.fromApiJsonHelper.extractLongNamed(SmsApiConstants.campaignIdParamName, element);
            isNotification = isCampaignNotification(campaignId);
        }

        Client client = null;
        if (this.fromApiJsonHelper.parameterExists(SmsApiConstants.clientIdParamName, element)) {
            final Long clientId = this.fromApiJsonHelper.extractLongNamed(SmsApiConstants.clientIdParamName, element);
            client = this.clientRepository.findById(clientId).orElseThrow(() -> new ClientNotFoundException(clientId));
            mobileNo = client.mobileNo();
        }

        Staff staff = null;
        if (this.fromApiJsonHelper.parameterExists(SmsApiConstants.staffIdParamName, element)) {
            final Long staffId = this.fromApiJsonHelper.extractLongNamed(SmsApiConstants.staffIdParamName, element);
            staff = this.staffRepository.findById(staffId).orElseThrow(() -> new StaffNotFoundException(staffId));
            mobileNo = staff.getMobileNo();
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
