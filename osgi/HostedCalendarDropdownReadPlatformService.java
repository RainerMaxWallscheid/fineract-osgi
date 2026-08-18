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

import java.util.List;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.portfolio.calendar.service.CalendarDropdownReadPlatformService;

/** Composition-root hosted calendar dropdowns for the Equinox bridge smoke. */
final class HostedCalendarDropdownReadPlatformService implements CalendarDropdownReadPlatformService {

    static final long HOSTED_ID = 1L;

    private final List<EnumOptionData> hosted = List.of(new EnumOptionData(HOSTED_ID, "hosted", "hosted"));

    @Override
    public List<EnumOptionData> retrieveCalendarEntityTypeOptions() {
        return hosted;
    }

    @Override
    public List<EnumOptionData> retrieveCalendarTypeOptions() {
        return hosted;
    }

    @Override
    public List<EnumOptionData> retrieveCalendarRemindByOptions() {
        return hosted;
    }

    @Override
    public List<EnumOptionData> retrieveCalendarFrequencyTypeOptions() {
        return hosted;
    }

    @Override
    public List<EnumOptionData> retrieveCalendarWeekDaysTypeOptions() {
        return hosted;
    }

    @Override
    public List<EnumOptionData> retrieveCalendarFrequencyNthDayTypeOptions() {
        return hosted;
    }
}
