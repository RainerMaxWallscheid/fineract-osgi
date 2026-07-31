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
package org.apache.fineract.portfolio.charge.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import java.util.Optional;
import org.apache.fineract.portfolio.charge.domain.Charge;
import org.apache.fineract.portfolio.charge.domain.ChargeRepository;
import org.apache.fineract.portfolio.charge.exception.ChargeIsNotActiveException;
import org.apache.fineract.portfolio.charge.exception.ChargeNotFoundException;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionData;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * Unit tests for {@link ChargeDefinitionPortJpaAdapter} (Module API Step 0).
 */
class ChargeDefinitionPortJpaAdapterTest {

    private ChargeRepository repository;
    private ChargeDefinitionPortJpaAdapter port;

    @BeforeEach
    void setUp() {
        repository = mock(ChargeRepository.class);
        port = new ChargeDefinitionPortJpaAdapter(repository);
    }

    @Test
    void existsActiveCharge_trueWhenActive() {
        final Charge charge = mockCharge(1L, "Fee", true, false);
        when(repository.findById(1L)).thenReturn(Optional.of(charge));

        assertTrue(port.existsActiveCharge(1L));
        assertFalse(port.existsActiveCharge(99L));
        assertFalse(port.existsActiveCharge(null));
    }

    @Test
    void findActiveCharge_emptyWhenInactiveOrDeleted() {
        final Charge inactive = mockCharge(2L, "Old", false, false);
        final Charge deleted = mockCharge(3L, "Gone", true, true);
        when(repository.findById(2L)).thenReturn(Optional.of(inactive));
        when(repository.findById(3L)).thenReturn(Optional.of(deleted));

        assertTrue(port.findActiveCharge(2L).isEmpty());
        assertTrue(port.findCharge(2L).isPresent());
        assertTrue(port.findCharge(3L).isEmpty());
        assertTrue(port.findActiveCharge(3L).isEmpty());
    }

    @Test
    void getActiveCharge_mapsFieldsAndThrowsWhenMissing() {
        final Charge charge = mockCharge(5L, "Disbursement fee", true, false);
        when(repository.findById(5L)).thenReturn(Optional.of(charge));
        when(repository.findById(6L)).thenReturn(Optional.empty());

        final ChargeDefinitionData data = port.getActiveCharge(5L);
        assertEquals(5L, data.getId());
        assertEquals("Disbursement fee", data.getName());
        assertEquals(new BigDecimal("10.00"), data.getAmount());
        assertEquals("USD", data.getCurrencyCode());
        assertEquals(1, data.getChargeAppliesTo());
        assertTrue(data.isActive());
        assertFalse(data.isPenalty());

        assertThrows(ChargeNotFoundException.class, () -> port.getActiveCharge(6L));
    }

    @Test
    void getActiveCharge_throwsWhenInactive() {
        final Charge inactive = mockCharge(7L, "Paused", false, false);
        when(repository.findById(7L)).thenReturn(Optional.of(inactive));

        assertThrows(ChargeIsNotActiveException.class, () -> port.getActiveCharge(7L));
    }

    private static Charge mockCharge(final Long id, final String name, final boolean active, final boolean deleted) {
        final Charge charge = mock(Charge.class);
        when(charge.getId()).thenReturn(id);
        when(charge.getName()).thenReturn(name);
        when(charge.getAmount()).thenReturn(new BigDecimal("10.00"));
        when(charge.getCurrencyCode()).thenReturn("USD");
        when(charge.getChargeAppliesTo()).thenReturn(1);
        when(charge.getChargeTimeType()).thenReturn(1);
        when(charge.getChargeCalculation()).thenReturn(1);
        when(charge.getChargePaymentMode()).thenReturn(0);
        when(charge.isPenalty()).thenReturn(false);
        when(charge.isActive()).thenReturn(active);
        when(charge.isDeleted()).thenReturn(deleted);
        when(charge.getMinCap()).thenReturn(null);
        when(charge.getMaxCap()).thenReturn(null);
        when(charge.getFeeInterval()).thenReturn(null);
        when(charge.feeFrequency()).thenReturn(null);
        when(charge.getIncomeAccountId()).thenReturn(null);
        when(charge.getTaxGroupId()).thenReturn(null);
        // Adapter maps via Charge#toDefinitionData() (not individual getters).
        when(charge.toDefinitionData()).thenReturn(new ChargeDefinitionData(id, name, new BigDecimal("10.00"), "USD", 1, 1, 1, 0, false,
                active, null, null, null, null, null, null));
        return charge;
    }
}
