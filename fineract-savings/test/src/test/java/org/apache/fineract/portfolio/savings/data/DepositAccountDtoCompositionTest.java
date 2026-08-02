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
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.portfolio.savings.DepositAccountType;
import org.apache.fineract.portfolio.savings.service.SavingsEnumerations;
import org.junit.jupiter.api.Test;

/**
 * Smoke tests for Fixed/Recurring deposit account composition (no inheritance from DepositAccountData).
 */
class DepositAccountDtoCompositionTest {

    @Test
    void fixedDepositAccountDoesNotExtendDepositAccountData() {
        assertTrue(FixedDepositAccountData.class.getSuperclass().equals(Object.class));
        assertFalse(DepositAccountData.class.isAssignableFrom(FixedDepositAccountData.class));
    }

    @Test
    void recurringDepositAccountDoesNotExtendDepositAccountData() {
        assertTrue(RecurringDepositAccountData.class.getSuperclass().equals(Object.class));
        assertFalse(DepositAccountData.class.isAssignableFrom(RecurringDepositAccountData.class));
    }

    @Test
    void fixedDepositAccountFlattensSharedAccountFields() {
        final CurrencyData currency = new CurrencyData("USD", "US Dollar", 2, 1, "$", "currency.USD");
        final EnumOptionData interest = new EnumOptionData(1L, "Monthly", "Monthly");
        final EnumOptionData depositType = SavingsEnumerations.depositType(DepositAccountType.FIXED_DEPOSIT.getValue());
        final DepositAccountData base = DepositAccountData.instance(11L, "FD-001", null, null, null, 5L, "Client", 7L, "FD Product", null,
                null, null, null, currency, BigDecimal.TEN, interest, interest, interest, interest, null, null, null, false, null,
                depositType, null, false, null);

        final FixedDepositAccountData fd = FixedDepositAccountData.instance(base, true, BigDecimal.ONE, interest, 3, 12, interest, interest,
                1, interest, BigDecimal.valueOf(500), BigDecimal.valueOf(550), LocalDate.of(2026, 1, 1), 12, interest, null, Boolean.FALSE,
                null);

        assertEquals(11L, fd.getId());
        assertEquals("FD-001", fd.getAccountNo());
        assertEquals(5L, fd.getClientId());
        assertEquals("Client", fd.getClientName());
        assertEquals(7L, fd.getDepositProductId());
        assertEquals(currency, fd.getCurrency());
        assertEquals(BigDecimal.TEN, fd.getNominalAnnualInterestRate());
        assertTrue(fd.isPreClosurePenalApplicable());
        assertEquals(3, fd.getMinDepositTerm());
        assertEquals(BigDecimal.valueOf(500), fd.getDepositAmount());
        assertEquals(LocalDate.of(2026, 1, 1), fd.getMaturityDate());

        final DepositAccountData rebuilt = fd.asAccountData();
        assertEquals(11L, rebuilt.getId());
        assertEquals("FD-001", rebuilt.getAccountNo());
        assertEquals(5L, rebuilt.getClientId());

        final FixedDepositAccountData withChart = FixedDepositAccountData.withInterestChart(fd, null);
        assertEquals(11L, withChart.getId());
        assertEquals(3, withChart.getMinDepositTerm());
    }

    @Test
    void recurringDepositAccountFlattensSharedAccountFields() {
        final CurrencyData currency = new CurrencyData("EUR", "Euro", 2, 1, "€", "currency.EUR");
        final EnumOptionData interest = new EnumOptionData(1L, "Monthly", "Monthly");
        final EnumOptionData depositType = SavingsEnumerations.depositType(DepositAccountType.RECURRING_DEPOSIT.getValue());
        final DepositAccountData base = DepositAccountData.instance(22L, "RD-001", null, null, null, 9L, "Client RD", 3L, "RD Product", null,
                null, null, null, currency, BigDecimal.ONE, interest, interest, interest, interest, null, null, null, false, null,
                depositType, null, false, null);

        final RecurringDepositAccountData rd = RecurringDepositAccountData.instance(base, false, null, null, 1, 6, interest, interest, null,
                null, BigDecimal.TEN, BigDecimal.valueOf(100), LocalDate.of(2026, 6, 1), 6, interest, BigDecimal.TEN, null,
                LocalDate.of(2025, 1, 1), null, null, true, false, true, false);

        assertEquals(22L, rd.getId());
        assertEquals("RD-001", rd.getAccountNo());
        assertEquals(9L, rd.getClientId());
        assertTrue(rd.isIsMandatoryDeposit());
        assertFalse(rd.isAllowWithdrawal());
        assertTrue(rd.isAdjustAdvanceTowardsFuturePayments());
        assertEquals(BigDecimal.TEN, rd.getMandatoryRecommendedDepositAmount());

        final DepositAccountData rebuilt = rd.asAccountData();
        assertEquals(22L, rebuilt.getId());
        assertEquals("RD-001", rebuilt.getAccountNo());
    }
}
