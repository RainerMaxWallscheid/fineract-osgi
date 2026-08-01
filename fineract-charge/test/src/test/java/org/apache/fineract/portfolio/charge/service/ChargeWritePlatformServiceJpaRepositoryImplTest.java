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
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.Optional;
import org.apache.fineract.accounting.glaccount.domain.GLAccountRepositoryWrapper;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;
import org.apache.fineract.infrastructure.security.service.PlatformSecurityContext;
import org.apache.fineract.portfolio.charge.domain.Charge;
import org.apache.fineract.portfolio.charge.domain.ChargeRepository;
import org.apache.fineract.portfolio.charge.exception.ChargeCannotBeDeletedException;
import org.apache.fineract.portfolio.charge.exception.ChargeNotFoundException;
import org.apache.fineract.portfolio.charge.serialization.ChargeDefinitionCommandFromApiJsonDeserializer;
import org.apache.fineract.portfolio.paymenttype.domain.PaymentTypeRepository;
import org.apache.fineract.portfolio.tax.moduleapi.TaxCatalogPort;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 * White-box tests for catalog delete guards (JDBC association checks, no loan BC).
 */
class ChargeWritePlatformServiceJpaRepositoryImplTest {

    private PlatformSecurityContext context;
    private ChargeDefinitionCommandFromApiJsonDeserializer deserializer;
    private ChargeRepository chargeRepository;
    private JdbcTemplate jdbcTemplate;
    private ChargeOfficeAccessPort chargeOfficeAccessPort;
    private GLAccountRepositoryWrapper glAccountRepository;
    private TaxCatalogPort taxCatalogPort;
    private PaymentTypeRepository paymentTypeRepository;
    private ChargeWritePlatformServiceJpaRepositoryImpl service;

    @BeforeEach
    void setUp() {
        context = mock(PlatformSecurityContext.class);
        deserializer = mock(ChargeDefinitionCommandFromApiJsonDeserializer.class);
        chargeRepository = mock(ChargeRepository.class);
        jdbcTemplate = mock(JdbcTemplate.class);
        chargeOfficeAccessPort = mock(ChargeOfficeAccessPort.class);
        glAccountRepository = mock(GLAccountRepositoryWrapper.class);
        taxCatalogPort = mock(TaxCatalogPort.class);
        paymentTypeRepository = mock(PaymentTypeRepository.class);
        service = new ChargeWritePlatformServiceJpaRepositoryImpl(context, deserializer, chargeRepository, jdbcTemplate,
                chargeOfficeAccessPort, glAccountRepository, taxCatalogPort, paymentTypeRepository);
    }

    @Test
    void deleteCharge_throwsWhenMissing() {
        when(chargeRepository.findById(42L)).thenReturn(Optional.empty());
        assertThrows(ChargeNotFoundException.class, () -> service.deleteCharge(42L));
    }

    @Test
    void deleteCharge_throwsWhenAlreadyDeleted() {
        final Charge charge = mock(Charge.class);
        when(charge.isDeleted()).thenReturn(true);
        when(chargeRepository.findById(7L)).thenReturn(Optional.of(charge));

        assertThrows(ChargeNotFoundException.class, () -> service.deleteCharge(7L));
        verify(charge, never()).delete();
    }

    @Test
    void deleteCharge_throwsWhenLoanProductAssociationExists() {
        final Charge charge = mock(Charge.class);
        when(charge.isDeleted()).thenReturn(false);
        when(chargeRepository.findById(9L)).thenReturn(Optional.of(charge));
        // loan products / loans / savings association SQL + WC loan repo
        when(jdbcTemplate.queryForObject(anyString(), eq(String.class), any(Object[].class))).thenReturn("true");
        when(chargeRepository.isAnyWorkingCapitalLoansAssociateWithThisCharge(9L)).thenReturn(Optional.empty());

        assertThrows(ChargeCannotBeDeletedException.class, () -> service.deleteCharge(9L));
        verify(charge, never()).delete();
    }

    @Test
    void deleteCharge_softDeletesWhenUnassociated() {
        final Charge charge = mock(Charge.class);
        when(charge.getId()).thenReturn(11L);
        when(charge.isDeleted()).thenReturn(false);
        when(chargeRepository.findById(11L)).thenReturn(Optional.of(charge));
        when(jdbcTemplate.queryForObject(anyString(), eq(String.class), any(Object[].class))).thenReturn("false");
        when(chargeRepository.isAnyWorkingCapitalLoansAssociateWithThisCharge(11L)).thenReturn(Optional.empty());
        when(chargeRepository.save(charge)).thenReturn(charge);

        final CommandProcessingResult result = service.deleteCharge(11L);

        verify(charge).delete();
        verify(chargeRepository).save(charge);
        assertEquals(11L, result.getResourceId());
    }
}
