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
package org.apache.fineract.portfolio.client.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.portfolio.group.domain.Group;
import org.apache.fineract.organisation.office.domain.Office;
import org.apache.fineract.portfolio.client.domain.Client;
import org.apache.fineract.portfolio.client.domain.ClientRepositoryWrapper;
import org.apache.fineract.portfolio.client.exception.ClientNotFoundException;
import org.apache.fineract.portfolio.client.moduleapi.ClientActivePort;
import org.apache.fineract.portfolio.client.moduleapi.ClientIncentiveView;
import org.springframework.stereotype.Service;

@Service
public class ClientActivePortAdapter implements ClientActivePort {

    private final ClientRepositoryWrapper clientRepository;

    public ClientActivePortAdapter(final ClientRepositoryWrapper clientRepository) {
        this.clientRepository = clientRepository;
    }

    @Override
    public boolean isActive(final Long clientId) {
        return !client(clientId).isNotActive();
    }

    @Override
    public boolean exists(final Long clientId) {
        try {
            client(clientId);
            return true;
        } catch (final ClientNotFoundException ex) {
            return false;
        }
    }

    @Override
    public boolean isActivatedAfter(final Long clientId, final LocalDate date) {
        return client(clientId).isActivatedAfter(date);
    }

    @Override
    public LocalDate activationDate(final Long clientId) {
        return client(clientId).getActivationDate();
    }

    @Override
    public LocalDate officeJoiningDate(final Long clientId) {
        return client(clientId).getOfficeJoiningDate();
    }

    @Override
    public Long officeId(final Long clientId) {
        final Office office = client(clientId).getOffice();
        return office == null ? null : office.getId();
    }

    @Override
    public Object office(final Long clientId) {
        return client(clientId).getOffice();
    }

    @Override
    public String displayName(final Long clientId) {
        return client(clientId).getDisplayName();
    }

    @Override
    public String accountNumber(final Long clientId) {
        return client(clientId).getAccountNumber();
    }

    @Override
    public ExternalId externalId(final Long clientId) {
        return client(clientId).getExternalId();
    }

    @Override
    public Long id(final Object client) {
        if (client == null) {
            return null;
        }
        return ((Client) client).getId();
    }

    @Override
    public Object persistableById(final Long clientId) {
        return this.clientRepository.findOneWithNotFoundDetection(clientId);
    }

    @Override
    public ClientIncentiveView incentiveAttributes(final Object client) {
        if (client == null) {
            return null;
        }
        final Client persistable = (Client) client;
        return new ClientIncentiveView(persistable.genderId(), persistable.dateOfBirth(), persistable.clientTypeId(),
                persistable.clientClassificationId());
    }

    @Override
    public List<Long> groupIds(final Long clientId) {
        final Set<Group> groups = client(clientId).getGroups();
        if (groups == null || groups.isEmpty()) {
            return List.of();
        }
        final List<Long> groupIds = new ArrayList<>(groups.size());
        for (final Group group : groups) {
            groupIds.add(group.getId());
        }
        return groupIds;
    }

    private Client client(final Long clientId) {
        return this.clientRepository.findOneWithNotFoundDetection(clientId);
    }
}
