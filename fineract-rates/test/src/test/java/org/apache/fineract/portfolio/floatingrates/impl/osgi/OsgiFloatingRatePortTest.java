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
package org.apache.fineract.portfolio.floatingrates.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.apache.fineract.portfolio.floatingrates.data.FloatingRateDTO;
import org.apache.fineract.portfolio.floatingrates.exception.FloatingRateNotFoundException;
import org.junit.jupiter.api.Test;

class OsgiFloatingRatePortTest {

    private final OsgiFloatingRatePort port = new OsgiFloatingRatePort();

    @Test
    void emptyCatalogHasNoRates() {
        assertTrue(port.findFloatingRate(1L).isEmpty());
        assertTrue(port.findBaseLendingRate().isEmpty());
        assertTrue(port.fetchInterestRates(null, null).isEmpty());
    }

    @Test
    void getAndFetchThrowNotFound() {
        assertThrows(FloatingRateNotFoundException.class, () -> port.getFloatingRate(1L));
        assertThrows(FloatingRateNotFoundException.class, () -> port.fetchInterestRates(1L, new FloatingRateDTO(false, null, null, null)));
    }
}
