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

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Collection;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;
import org.apache.fineract.organisation.monetary.domain.MoneyHelper;
import org.apache.fineract.portfolio.tax.domain.TaxComponent;
import org.apache.fineract.portfolio.tax.domain.TaxGroup;
import org.apache.fineract.portfolio.tax.domain.TaxGroupMappings;
import org.apache.fineract.portfolio.tax.domain.TaxGroupRepository;
import org.apache.fineract.portfolio.tax.moduleapi.TaxComponentShareData;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;

class ChargeTaxApplicationServiceTest {

    private static MockedStatic<MoneyHelper> moneyHelperMock;

    private final LocalDate actualDate = LocalDate.now(ZoneId.systemDefault());

    @BeforeAll
    static void setUpMoneyHelper() {
        moneyHelperMock = mockStatic(MoneyHelper.class);
        moneyHelperMock.when(MoneyHelper::getRoundingMode).thenReturn(RoundingMode.HALF_EVEN);
    }

    @AfterAll
    static void tearDownMoneyHelper() {
        moneyHelperMock.close();
    }

    private ChargeTaxApplicationServiceImpl serviceWith(TaxGroup taxGroup) {
        TaxGroupRepository repo = mock(TaxGroupRepository.class);
        if (taxGroup != null) {
            when(repo.findById(1L)).thenReturn(Optional.of(taxGroup));
        } else {
            when(repo.findById(1L)).thenReturn(Optional.empty());
        }
        return new ChargeTaxApplicationServiceImpl(repo);
    }

    @Test
    void computeTax_returnsEmpty_whenTaxGroupIdIsNull() {
        assertThat(serviceWith(null).computeTax(null, new BigDecimal("100.00"), actualDate, 6)).isEmpty();
    }

    @Test
    void computeTax_returnsEmpty_whenBaseAmountIsNull() {
        TaxGroup taxGroup = mock(TaxGroup.class);
        assertThat(serviceWith(taxGroup).computeTax(1L, null, actualDate, 6)).isEmpty();
    }

    @Test
    void computeTax_returnsEmpty_whenBaseAmountIsZero() {
        TaxGroup taxGroup = mock(TaxGroup.class);
        assertThat(serviceWith(taxGroup).computeTax(1L, BigDecimal.ZERO, actualDate, 6)).isEmpty();
    }

    @Test
    void computeTax_calculatesTaxCorrectly_forSingleComponent() {
        TaxComponent component = mock(TaxComponent.class);
        when(component.getId()).thenReturn(9L);
        when(component.getName()).thenReturn("VAT");
        when(component.getApplicablePercentage(actualDate)).thenReturn(new BigDecimal("10"));
        when(component.getCreditAccount()).thenReturn(null);
        when(component.getDebitAccount()).thenReturn(null);

        TaxGroupMappings mapping = mock(TaxGroupMappings.class);
        when(mapping.occursOnDayFromAndUpToAndIncluding(actualDate)).thenReturn(true);
        when(mapping.getTaxComponent()).thenReturn(component);

        Set<TaxGroupMappings> mappings = new HashSet<>();
        mappings.add(mapping);
        TaxGroup taxGroup = mock(TaxGroup.class);
        when(taxGroup.getTaxGroupMappings()).thenReturn(mappings);

        Collection<TaxComponentShareData> result = serviceWith(taxGroup).computeTax(1L, new BigDecimal("100.00"), actualDate, 6);
        assertThat(result).hasSize(1);
        TaxComponentShareData share = result.iterator().next();
        assertThat(share.getTaxComponentId()).isEqualTo(9L);
        assertThat(share.getAmount()).isEqualByComparingTo(new BigDecimal("10.000000"));
    }
}
