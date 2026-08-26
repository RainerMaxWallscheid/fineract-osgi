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

/**
 * Calendar-instance lookup/write for residual peels without depending on calendar-impl
 * ({@code CalendarInstanceRepository} stays there: leftover Loan native SQL).
 */
public interface CalendarInstanceLookupPort {

    CalendarInstance findCalendarInstanceByEntityId(Long entityId, Integer entityTypeId);

    CalendarInstance findByCalendarIdAndEntityIdAndEntityTypeId(Long calendarId, Long entityId, Integer entityTypeId);

    Collection<CalendarInstance> findByEntityIdAndEntityTypeId(Long entityId, Integer entityTypeId);

    CalendarInstance findByEntityIdAndEntityTypeIdAndCalendarTypeId(Long entityId, Integer entityTypeId, Integer calendarTypeId);

    List<CalendarInstance> findCalendarInstancesForLoansByGroupIdAndClientIdAndStatuses(Long groupId, Long clientId);

    CalendarInstance save(CalendarInstance calendarInstance);

    CalendarInstance saveAndFlush(CalendarInstance calendarInstance);

    void delete(CalendarInstance calendarInstance);
}
