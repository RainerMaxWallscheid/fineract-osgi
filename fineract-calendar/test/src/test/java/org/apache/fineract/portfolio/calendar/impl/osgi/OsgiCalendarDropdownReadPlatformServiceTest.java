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
package org.apache.fineract.portfolio.calendar.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.Test;

class OsgiCalendarDropdownReadPlatformServiceTest {

    private final OsgiCalendarDropdownReadPlatformService port = new OsgiCalendarDropdownReadPlatformService();

    @Test
    void emptyCatalogHasNoDropdownOptions() {
        assertTrue(port.retrieveCalendarEntityTypeOptions().isEmpty());
        assertTrue(port.retrieveCalendarTypeOptions().isEmpty());
        assertTrue(port.retrieveCalendarRemindByOptions().isEmpty());
        assertTrue(port.retrieveCalendarFrequencyTypeOptions().isEmpty());
        assertTrue(port.retrieveCalendarWeekDaysTypeOptions().isEmpty());
        assertTrue(port.retrieveCalendarFrequencyNthDayTypeOptions().isEmpty());
    }

    @Test
    void dsComponentDescriptorIsOnClasspath() {
        assertNotNull(OsgiCalendarDropdownReadPlatformService.class.getResource("/OSGI-INF/calendar.xml"));
    }
}
