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
package org.apache.fineract.organisation.office.service;

import org.apache.fineract.organisation.office.domain.Office;
import org.apache.fineract.organisation.office.domain.OfficeRepository;
import org.apache.fineract.organisation.office.moduleapi.OfficePersistablePort;
import org.springframework.stereotype.Service;

@Service
public class OfficePersistablePortAdapter implements OfficePersistablePort {

    private final OfficeRepository officeRepository;

    public OfficePersistablePortAdapter(final OfficeRepository officeRepository) {
        this.officeRepository = officeRepository;
    }

    @Override
    public Long id(final Object office) {
        if (office instanceof Long officeId) {
            return officeId;
        }
        if (office == null) {
            return null;
        }
        return ((Office) office).getId();
    }

    @Override
    public Object persistableById(final Long officeId) {
        if (officeId == null) {
            return null;
        }
        return this.officeRepository.findById(officeId).orElse(null);
    }

    @Override
    public String name(final Long officeId) {
        final Object persistable = persistableById(officeId);
        return persistable instanceof Office office ? office.getName() : null;
    }
}
