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
package org.apache.fineract.portfolio.savings.data;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.junit.jupiter.api.Test;

/**
 * Smoke tests for Fixed/Recurring deposit product composition (no inheritance from DepositProductData).
 */
class DepositProductDtoCompositionTest {

    @Test
    void fixedDepositProductDoesNotExtendDepositProductData() {
        assertTrue(FixedDepositProductData.class.getSuperclass().equals(Object.class));
        assertFalse(DepositProductData.class.isAssignableFrom(FixedDepositProductData.class));
    }

    @Test
    void recurringDepositProductDoesNotExtendDepositProductData() {
        assertTrue(RecurringDepositProductData.class.getSuperclass().equals(Object.class));
        assertFalse(DepositProductData.class.isAssignableFrom(RecurringDepositProductData.class));
    }

    @Test
    void fixedDepositProductFlattensSharedProductFields() {
        final CurrencyData currency = new CurrencyData("USD", "US Dollar", 2, 1, "$", "currency.USD");
        final EnumOptionData interest = new EnumOptionData(1L, "Monthly", "Monthly");
        final DepositProductData base = DepositProductData.instance(11L, "FD Product", "FDP", "desc", currency, BigDecimal.TEN, interest,
                interest, interest, interest, 1, interest, interest, BigDecimal.ONE, false, null);

        final FixedDepositProductData fd = FixedDepositProductData.instance(base, true, BigDecimal.ONE, interest, 3, 12, interest, interest,
                1, interest, BigDecimal.valueOf(100), BigDecimal.valueOf(500), BigDecimal.valueOf(1000));

        assertEquals(11L, fd.getId());
        assertEquals("FD Product", fd.getName());
        assertEquals("FDP", fd.getShortName());
        assertEquals(currency, fd.getCurrency());
        assertEquals(BigDecimal.TEN, fd.getNominalAnnualInterestRate());
        assertTrue(fd.isPreClosurePenalApplicable());
        assertEquals(3, fd.getMinDepositTerm());
        assertEquals(BigDecimal.valueOf(500), fd.getDepositAmount());

        final FixedDepositProductData withCharges = FixedDepositProductData.withCharges(fd, null);
        assertEquals(11L, withCharges.getId());
        assertEquals(3, withCharges.getMinDepositTerm());
    }

    @Test
    void recurringDepositProductFlattensSharedProductFields() {
        final CurrencyData currency = new CurrencyData("EUR", "Euro", 2, 1, "€", "currency.EUR");
        final EnumOptionData interest = new EnumOptionData(1L, "Monthly", "Monthly");
        final DepositProductData base = DepositProductData.instance(22L, "RD Product", "RDP", "desc", currency, BigDecimal.ONE, interest,
                interest, interest, interest, null, null, interest, null, false, null);

        final RecurringDepositProductData rd = RecurringDepositProductData.instance(base, false, null, null, 1, 6, interest, interest, null,
                null, true, false, true, BigDecimal.TEN, BigDecimal.TEN, BigDecimal.valueOf(100));

        assertEquals(22L, rd.getId());
        assertEquals("RD Product", rd.getName());
        assertTrue(rd.isMandatoryDeposit());
        assertFalse(rd.isAllowWithdrawal());
        assertTrue(rd.isAdjustAdvanceTowardsFuturePayments());
        assertEquals(BigDecimal.TEN, rd.getDepositAmount());
    }
}
