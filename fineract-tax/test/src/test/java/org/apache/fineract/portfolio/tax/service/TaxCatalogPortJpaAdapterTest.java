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
package org.apache.fineract.portfolio.tax.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import java.util.Optional;
import org.apache.fineract.portfolio.tax.domain.TaxComponent;
import org.apache.fineract.portfolio.tax.domain.TaxComponentRepository;
import org.apache.fineract.portfolio.tax.domain.TaxGroup;
import org.apache.fineract.portfolio.tax.domain.TaxGroupRepository;
import org.apache.fineract.portfolio.tax.exception.TaxComponentNotFoundException;
import org.apache.fineract.portfolio.tax.exception.TaxGroupNotFoundException;
import org.apache.fineract.portfolio.tax.moduleapi.TaxComponentDefinitionData;
import org.apache.fineract.portfolio.tax.moduleapi.TaxGroupDefinitionData;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class TaxCatalogPortJpaAdapterTest {

    private TaxGroupRepository taxGroupRepository;
    private TaxComponentRepository taxComponentRepository;
    private TaxCatalogPortJpaAdapter port;

    @BeforeEach
    void setUp() {
        taxGroupRepository = mock(TaxGroupRepository.class);
        taxComponentRepository = mock(TaxComponentRepository.class);
        port = new TaxCatalogPortJpaAdapter(taxGroupRepository, taxComponentRepository);
    }

    @Test
    void findTaxGroup_mapsFields() {
        final TaxGroup group = mock(TaxGroup.class);
        when(group.getId()).thenReturn(5L);
        when(group.getName()).thenReturn("VAT");
        when(taxGroupRepository.findById(5L)).thenReturn(Optional.of(group));

        final TaxGroupDefinitionData data = port.findTaxGroup(5L).orElseThrow();
        assertEquals(5L, data.getId());
        assertEquals("VAT", data.getName());
    }

    @Test
    void getTaxGroup_throwsWhenMissing() {
        when(taxGroupRepository.findById(9L)).thenReturn(Optional.empty());
        assertThrows(TaxGroupNotFoundException.class, () -> port.getTaxGroup(9L));
    }

    @Test
    void findTaxComponent_mapsFields() {
        final TaxComponent component = mock(TaxComponent.class);
        when(component.getId()).thenReturn(3L);
        when(component.getName()).thenReturn("CGST");
        when(component.getPercentage()).thenReturn(new BigDecimal("9.00"));
        when(taxComponentRepository.findById(3L)).thenReturn(Optional.of(component));

        final TaxComponentDefinitionData data = port.findTaxComponent(3L).orElseThrow();
        assertEquals(3L, data.getId());
        assertEquals("CGST", data.getName());
        assertEquals(new BigDecimal("9.00"), data.getPercentage());
    }

    @Test
    void getTaxComponent_throwsWhenMissing() {
        when(taxComponentRepository.findById(7L)).thenReturn(Optional.empty());
        assertThrows(TaxComponentNotFoundException.class, () -> port.getTaxComponent(7L));
    }

    @Test
    void findTaxGroup_emptyWhenNullId() {
        assertTrue(port.findTaxGroup(null).isEmpty());
    }
}
