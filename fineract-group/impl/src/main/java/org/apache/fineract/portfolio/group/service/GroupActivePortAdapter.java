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
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.apache.fineract.portfolio.group.domain.Group;
import org.apache.fineract.portfolio.group.domain.GroupRepository;
import org.apache.fineract.portfolio.group.domain.GroupRepositoryWrapper;
import org.apache.fineract.portfolio.group.moduleapi.GroupActivePort;
import org.springframework.stereotype.Service;

@Service
public class GroupActivePortAdapter implements GroupActivePort {

    private final GroupRepositoryWrapper groupRepository;
    private final GroupRepository groupRepositoryDirect;

    public GroupActivePortAdapter(final GroupRepositoryWrapper groupRepository, final GroupRepository groupRepositoryDirect) {
        this.groupRepository = groupRepository;
        this.groupRepositoryDirect = groupRepositoryDirect;
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
    public boolean isGroup(final Long groupId) {
        return group(groupId).isGroup();
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
    public List<Long> childIds(final Long parentId) {
        final Collection<Group> children = this.groupRepositoryDirect.findByParentId(parentId);
        if (children == null || children.isEmpty()) {
            return List.of();
        }
        final List<Long> ids = new ArrayList<>(children.size());
        for (final Group child : children) {
            ids.add(child.getId());
        }
        return ids;
    }

    @Override
    public Long parentId(final Long groupId) {
        final Group parent = group(groupId).getParent();
        return parent == null ? null : parent.getId();
    }

    @Override
    public Long id(final Object group) {
        if (group == null) {
            return null;
        }
        return ((Group) group).getId();
    }

    @Override
    public Object persistableById(final Long groupId) {
        return this.groupRepository.findOneWithNotFoundDetection(groupId);
    }

    private Group group(final Long groupId) {
        return this.groupRepository.findOneWithNotFoundDetection(groupId);
    }
}
