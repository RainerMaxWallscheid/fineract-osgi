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
package org.apache.fineract.portfolio.floatingrates.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.util.Optional;
import org.apache.fineract.portfolio.floatingrates.domain.FloatingRate;
import org.apache.fineract.portfolio.floatingrates.domain.FloatingRateRepository;
import org.apache.fineract.portfolio.floatingrates.exception.FloatingRateNotFoundException;
import org.apache.fineract.portfolio.floatingrates.moduleapi.FloatingRateDefinitionData;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class FloatingRatePortJpaAdapterTest {

    private FloatingRateRepository repository;
    private FloatingRatePortJpaAdapter port;

    @BeforeEach
    void setUp() {
        repository = mock(FloatingRateRepository.class);
        port = new FloatingRatePortJpaAdapter(repository);
    }

    @Test
    void findFloatingRate_mapsFields() {
        final FloatingRate rate = mock(FloatingRate.class);
        when(rate.getId()).thenReturn(3L);
        when(rate.getName()).thenReturn("BLR");
        when(rate.isBaseLendingRate()).thenReturn(true);
        when(rate.isActive()).thenReturn(true);
        when(repository.findById(3L)).thenReturn(Optional.of(rate));

        final FloatingRateDefinitionData data = port.findFloatingRate(3L).orElseThrow();
        assertEquals(3L, data.getId());
        assertEquals("BLR", data.getName());
        assertTrue(data.isBaseLendingRate());
        assertTrue(data.isActive());
    }

    @Test
    void getFloatingRate_throwsWhenMissing() {
        when(repository.findById(9L)).thenReturn(Optional.empty());
        assertThrows(FloatingRateNotFoundException.class, () -> port.getFloatingRate(9L));
    }
}
