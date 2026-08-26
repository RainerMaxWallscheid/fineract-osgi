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
package org.apache.fineract.portfolio.calendar.service;

import java.util.Collection;
import java.util.List;
import org.apache.fineract.portfolio.calendar.domain.CalendarInstance;
import org.apache.fineract.portfolio.calendar.domain.CalendarInstanceRepository;
import org.springframework.stereotype.Service;

@Service
public class CalendarInstanceLookupPortAdapter implements CalendarInstanceLookupPort {

    private final CalendarInstanceRepository calendarInstanceRepository;

    public CalendarInstanceLookupPortAdapter(final CalendarInstanceRepository calendarInstanceRepository) {
        this.calendarInstanceRepository = calendarInstanceRepository;
    }

    @Override
    public CalendarInstance findCalendarInstanceByEntityId(final Long entityId, final Integer entityTypeId) {
        return this.calendarInstanceRepository.findCalendarInstanceByEntityId(entityId, entityTypeId);
    }

    @Override
    public CalendarInstance findByCalendarIdAndEntityIdAndEntityTypeId(final Long calendarId, final Long entityId,
            final Integer entityTypeId) {
        return this.calendarInstanceRepository.findByCalendarIdAndEntityIdAndEntityTypeId(calendarId, entityId, entityTypeId);
    }

    @Override
    public Collection<CalendarInstance> findByEntityIdAndEntityTypeId(final Long entityId, final Integer entityTypeId) {
        return this.calendarInstanceRepository.findByEntityIdAndEntityTypeId(entityId, entityTypeId);
    }

    @Override
    public CalendarInstance findByEntityIdAndEntityTypeIdAndCalendarTypeId(final Long entityId, final Integer entityTypeId,
            final Integer calendarTypeId) {
        return this.calendarInstanceRepository.findByEntityIdAndEntityTypeIdAndCalendarTypeId(entityId, entityTypeId, calendarTypeId);
    }

    @Override
    public List<CalendarInstance> findCalendarInstancesForLoansByGroupIdAndClientIdAndStatuses(final Long groupId, final Long clientId) {
        return this.calendarInstanceRepository.findCalendarInstancesForLoansByGroupIdAndClientIdAndStatuses(groupId, clientId);
    }

    @Override
    public CalendarInstance save(final CalendarInstance calendarInstance) {
        return this.calendarInstanceRepository.save(calendarInstance);
    }

    @Override
    public CalendarInstance saveAndFlush(final CalendarInstance calendarInstance) {
        return this.calendarInstanceRepository.saveAndFlush(calendarInstance);
    }

    @Override
    public void delete(final CalendarInstance calendarInstance) {
        this.calendarInstanceRepository.delete(calendarInstance);
    }
}
