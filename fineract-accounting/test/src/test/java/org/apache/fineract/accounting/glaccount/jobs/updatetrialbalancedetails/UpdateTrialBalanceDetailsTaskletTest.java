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
package org.apache.fineract.accounting.glaccount.jobs.updatetrialbalancedetails;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import org.junit.jupiter.api.Test;

class UpdateTrialBalanceDetailsTaskletTest {

    @Test
    void toLocalDate_supportsCommonTemporalTypes() {
        LocalDate expected = LocalDate.of(2024, 6, 15);
        assertEquals(expected, UpdateTrialBalanceDetailsTasklet.toLocalDate(expected));
        assertEquals(expected, UpdateTrialBalanceDetailsTasklet.toLocalDate(LocalDateTime.of(2024, 6, 15, 10, 30)));
        assertEquals(expected, UpdateTrialBalanceDetailsTasklet.toLocalDate(OffsetDateTime.of(2024, 6, 15, 10, 30, 0, 0, ZoneOffset.UTC)));
        assertEquals(expected, UpdateTrialBalanceDetailsTasklet.toLocalDate(Timestamp.valueOf(LocalDateTime.of(2024, 6, 15, 10, 30))));
        assertEquals(expected, UpdateTrialBalanceDetailsTasklet.toLocalDate(java.sql.Date.valueOf(expected)));
        assertNull(UpdateTrialBalanceDetailsTasklet.toLocalDate(null));
    }

    @Test
    void toLong_and_toBigDecimal_supportNumberTypes() {
        assertEquals(42L, UpdateTrialBalanceDetailsTasklet.toLong(42L));
        assertEquals(42L, UpdateTrialBalanceDetailsTasklet.toLong(42));
        assertEquals(new BigDecimal("12.34"), UpdateTrialBalanceDetailsTasklet.toBigDecimal(new BigDecimal("12.34")));
        assertEquals(new BigDecimal("12"), UpdateTrialBalanceDetailsTasklet.toBigDecimal(12));
        assertNull(UpdateTrialBalanceDetailsTasklet.toLong(null));
        assertNull(UpdateTrialBalanceDetailsTasklet.toBigDecimal(null));
    }
}
