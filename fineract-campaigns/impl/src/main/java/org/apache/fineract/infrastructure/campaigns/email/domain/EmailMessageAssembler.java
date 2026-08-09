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
package org.apache.fineract.infrastructure.campaigns.email.domain;

import com.google.gson.JsonElement;
import org.apache.fineract.infrastructure.campaigns.email.EmailApiConstants;
import org.apache.fineract.infrastructure.campaigns.email.exception.EmailNotFoundException;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.serialization.FromJsonHelper;
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
import org.springframework.stereotype.Component;

@Component
public class EmailMessageAssembler {

    private final EmailMessageRepository emailMessageRepository;
    private final GroupRepository groupRepository;
    private final ClientRepository clientRepository;
    private final StaffRepository staffRepository;
    private final FromJsonHelper fromApiJsonHelper;

    @Autowired
    public EmailMessageAssembler(final EmailMessageRepository emailMessageRepository, final GroupRepository groupRepository,
            final ClientRepository clientRepository, final StaffRepository staffRepository, final FromJsonHelper fromApiJsonHelper) {
        this.emailMessageRepository = emailMessageRepository;
        this.groupRepository = groupRepository;
        this.clientRepository = clientRepository;
        this.staffRepository = staffRepository;
        this.fromApiJsonHelper = fromApiJsonHelper;
    }

    public EmailMessage assembleFromJson(final JsonCommand command) {

        final JsonElement element = command.parsedJson();

        String emailAddress = null;

        Group group = null;
        if (this.fromApiJsonHelper.parameterExists(EmailApiConstants.groupIdParamName, element)) {
            final Long groupId = this.fromApiJsonHelper.extractLongNamed(EmailApiConstants.groupIdParamName, element);
            group = this.groupRepository.findById(groupId).orElseThrow(() -> new GroupNotFoundException(groupId));
        }

        Client client = null;
        if (this.fromApiJsonHelper.parameterExists(EmailApiConstants.clientIdParamName, element)) {
            final Long clientId = this.fromApiJsonHelper.extractLongNamed(EmailApiConstants.clientIdParamName, element);
            client = this.clientRepository.findById(clientId).orElseThrow(() -> new ClientNotFoundException(clientId));
            emailAddress = client.emailAddress();
        }

        Staff staff = null;
        if (this.fromApiJsonHelper.parameterExists(EmailApiConstants.staffIdParamName, element)) {
            final Long staffId = this.fromApiJsonHelper.extractLongNamed(EmailApiConstants.staffIdParamName, element);
            staff = this.staffRepository.findById(staffId).orElseThrow(() -> new StaffNotFoundException(staffId));
            emailAddress = staff.getEmailAddress();
        }

        final String message = this.fromApiJsonHelper.extractStringNamed(EmailApiConstants.messageParamName, element);
        final String emailSubject = this.fromApiJsonHelper.extractStringNamed(EmailApiConstants.subjectParamName, element);

        return EmailMessage.pendingEmail(group, client, staff, null, emailSubject, message, emailAddress, null);
    }

    public EmailMessage assembleFromResourceId(final Long resourceId) {
        return this.emailMessageRepository.findById(resourceId).orElseThrow(() -> new EmailNotFoundException(resourceId));
    }
}
