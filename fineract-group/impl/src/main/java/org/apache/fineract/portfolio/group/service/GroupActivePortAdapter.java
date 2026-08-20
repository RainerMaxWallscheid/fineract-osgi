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
package org.apache.fineract.portfolio.group.service;

import java.time.LocalDate;
import org.apache.fineract.portfolio.group.domain.Group;
import org.apache.fineract.portfolio.group.domain.GroupRepositoryWrapper;
import org.apache.fineract.portfolio.group.moduleapi.GroupActivePort;
import org.springframework.stereotype.Service;

@Service
public class GroupActivePortAdapter implements GroupActivePort {

    private final GroupRepositoryWrapper groupRepository;

    public GroupActivePortAdapter(final GroupRepositoryWrapper groupRepository) {
        this.groupRepository = groupRepository;
    }

    @Override
    public boolean isActive(final Long groupId) {
        return !group(groupId).isNotActive();
    }

    @Override
    public boolean isCenter(final Long groupId) {
        return group(groupId).isCenter();
    }

    @Override
    public boolean isActivatedAfter(final Long groupId, final LocalDate date) {
        return group(groupId).isActivatedAfter(date);
    }

    @Override
    public LocalDate activationDate(final Long groupId) {
        return group(groupId).getActivationDate();
    }

    @Override
    public Long officeId(final Long groupId) {
        return group(groupId).getOffice().getId();
    }

    @Override
    public Object office(final Long groupId) {
        return group(groupId).getOffice();
    }

    @Override
    public boolean hasClientAsMember(final Long groupId, final Long clientId) {
        return group(groupId).isChildClient(clientId);
    }

    @Override
    public Long id(final Object group) {
        if (group == null) {
            return null;
        }
        return ((Group) group).getId();
    }

    private Group group(final Long groupId) {
        return this.groupRepository.findOneWithNotFoundDetection(groupId);
    }
}
