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
package org.apache.fineract.organisation.staff.service;

import org.apache.fineract.organisation.staff.domain.Staff;
import org.apache.fineract.organisation.staff.domain.StaffRepository;
import org.apache.fineract.organisation.staff.moduleapi.StaffPersistablePort;
import org.springframework.stereotype.Service;

@Service
public class StaffPersistablePortAdapter implements StaffPersistablePort {

    private final StaffRepository staffRepository;

    public StaffPersistablePortAdapter(final StaffRepository staffRepository) {
        this.staffRepository = staffRepository;
    }

    @Override
    public Long id(final Object staff) {
        if (staff instanceof Long staffId) {
            return staffId;
        }
        if (staff == null) {
            return null;
        }
        return ((Staff) staff).getId();
    }

    @Override
    public Object persistableById(final Long staffId) {
        if (staffId == null) {
            return null;
        }
        return this.staffRepository.findById(staffId).orElse(null);
    }
}
