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
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.portfolio.charge.domain.ChargeAppliesTo;
import org.apache.fineract.portfolio.charge.domain.ChargeTimeType;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * White-box unit tests for catalog dropdown options (Fragment-Host host types).
 */
class ChargeDropdownReadPlatformServiceImplTest {

    private ChargeDropdownReadPlatformServiceImpl service;

    @BeforeEach
    void setUp() {
        service = new ChargeDropdownReadPlatformServiceImpl();
    }

    @Test
    void retrieveApplicableToTypes_excludesInvalid() {
        final List<EnumOptionData> options = service.retrieveApplicableToTypes();
        assertFalse(options.isEmpty());
        assertTrue(options.stream().noneMatch(o -> "Invalid".equalsIgnoreCase(o.getValue()) || Integer.valueOf(0).equals(o.getId().intValue())));
    }

    @Test
    void retrievePaymentModes_hasRegularAndAccountTransfer() {
        final List<EnumOptionData> modes = service.retrievePaymentModes();
        assertEquals(2, modes.size());
    }

    @Test
    void retrieveLoanCollectionTimeTypes_includesDisbursementAndOverdue() {
        final List<EnumOptionData> times = service.retrieveLoanCollectionTimeTypes();
        assertTrue(times.size() >= 4);
        assertTrue(times.stream().anyMatch(o -> o.getId().intValue() == ChargeTimeType.DISBURSEMENT.getValue()));
        assertTrue(times.stream().anyMatch(o -> o.getId().intValue() == ChargeTimeType.OVERDUE_INSTALLMENT.getValue()));
    }

    @Test
    void workingCapitalLoan_paymentModesAreRegularOnly() {
        final List<EnumOptionData> modes = service.retrievePaymentModes(ChargeAppliesTo.WORKING_CAPITAL_LOAN);
        assertEquals(1, modes.size());
    }

    @Test
    void workingCapitalLoan_collectionTimesUseDedicatedEnumSet() {
        final List<EnumOptionData> times = service.retrieveCollectionTimeTypes(ChargeAppliesTo.WORKING_CAPITAL_LOAN);
        assertFalse(times.isEmpty());
        // Generic list is larger; WC loan set is filtered via ChargeTimeType.validWorkingCapitalLoan()
        assertTrue(times.size() <= service.retrieveCollectionTimeTypes().size());
    }

    @Test
    void workingCapitalLoan_calculationTypesForSpecifiedDueDate() {
        final List<EnumOptionData> calcs = service.retrieveCalculationTypes(ChargeAppliesTo.WORKING_CAPITAL_LOAN,
                ChargeTimeType.SPECIFIED_DUE_DATE);
        assertFalse(calcs.isEmpty());
    }
}
