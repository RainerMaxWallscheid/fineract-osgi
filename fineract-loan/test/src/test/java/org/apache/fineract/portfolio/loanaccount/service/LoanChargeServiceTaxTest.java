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
package org.apache.fineract.portfolio.loanaccount.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.organisation.monetary.domain.MoneyHelper;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeCalculationType;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeTimeType;
import org.apache.fineract.portfolio.loanaccount.domain.LoanCharge;
import org.apache.fineract.portfolio.loanaccount.domain.LoanChargeTaxDetails;
import org.apache.fineract.portfolio.loanaccount.domain.LoanLifecycleStateMachine;
import org.apache.fineract.portfolio.loanaccount.serialization.LoanChargeValidator;
import org.apache.fineract.portfolio.tax.moduleapi.TaxComponentShareData;
import org.apache.fineract.portfolio.tax.service.ChargeTaxApplicationService;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;

class LoanChargeServiceTaxTest {

    private static MockedStatic<MoneyHelper> moneyHelperMock;
    private static MockedStatic<DateUtils> dateUtilsMock;

    private static final LocalDate BUSINESS_DATE = LocalDate.of(2026, 4, 10);

    @BeforeAll
    static void setUpStatics() {
        moneyHelperMock = mockStatic(MoneyHelper.class);
        moneyHelperMock.when(MoneyHelper::getRoundingMode).thenReturn(RoundingMode.HALF_EVEN);
        moneyHelperMock.when(MoneyHelper::getMathContext).thenReturn(new MathContext(12, RoundingMode.HALF_EVEN));

        dateUtilsMock = mockStatic(DateUtils.class);
        dateUtilsMock.when(DateUtils::getBusinessLocalDate).thenReturn(BUSINESS_DATE);
    }

    @AfterAll
    static void tearDownStatics() {
        moneyHelperMock.close();
        dateUtilsMock.close();
    }

    private LoanChargeService buildService(ChargeTaxApplicationService taxService) {
        return new LoanChargeService(mock(LoanChargeValidator.class), mock(LoanTransactionProcessingService.class),
                mock(LoanLifecycleStateMachine.class), mock(LoanBalanceService.class), mock(LoanScheduleGeneratorService.class),
                taxService);
    }

    @Test
    void populateDerivedFields_doesNotApplyTax_whenChargeHasNoTaxGroup() {
        ChargeTaxApplicationService taxService = mock(ChargeTaxApplicationService.class);
        LoanChargeService service = buildService(taxService);

        LoanCharge loanCharge = loanCharge(null, new BigDecimal("100.00"), null);

        service.populateDerivedFields(loanCharge, BigDecimal.ZERO, new BigDecimal("100.00"), null, BigDecimal.ZERO);

        assertThat(loanCharge.getTaxAmount()).isZero();
        assertThat(loanCharge.getTaxDetails()).isEmpty();
    }

    @Test
    void populateDerivedFields_doesNotInflateAmount_whenTaxGroupIsConfigured() {
        ChargeTaxApplicationService taxService = mock(ChargeTaxApplicationService.class);
        when(taxService.computeTax(eq(7L), any(BigDecimal.class), any(LocalDate.class), anyInt()))
                .thenReturn(List.of(share(1L, "160.000000")));

        LoanChargeService service = buildService(taxService);
        LoanCharge loanCharge = loanCharge(7L, new BigDecimal("1000.00"), null);

        service.populateDerivedFields(loanCharge, BigDecimal.ZERO, new BigDecimal("1000.00"), null, BigDecimal.ZERO);

        assertThat(loanCharge.getTaxAmount()).isEqualByComparingTo(new BigDecimal("160.000000"));
        assertThat(loanCharge.getAmount()).isEqualByComparingTo(new BigDecimal("1000.00"));
    }

    @Test
    void populateDerivedFields_populatesTaxDetails_forEachTaxComponent() {
        ChargeTaxApplicationService taxService = mock(ChargeTaxApplicationService.class);
        when(taxService.computeTax(any(), any(), any(), anyInt()))
                .thenReturn(List.of(share(11L, "10.000000"), share(12L, "5.000000")));

        LoanChargeService service = buildService(taxService);
        LoanCharge loanCharge = loanCharge(7L, new BigDecimal("100.00"), null);

        service.populateDerivedFields(loanCharge, BigDecimal.ZERO, new BigDecimal("100.00"), null, BigDecimal.ZERO);

        assertThat(loanCharge.getTaxDetails()).hasSize(2);
        assertThat(loanCharge.getTaxDetails()).extracting(LoanChargeTaxDetails::getTaxComponentId).containsExactlyInAnyOrder(11L, 12L);
    }

    @Test
    void populateDerivedFields_setsAmountOutstanding_fromOriginalAmount() {
        ChargeTaxApplicationService taxService = mock(ChargeTaxApplicationService.class);
        when(taxService.computeTax(any(), any(), any(), anyInt())).thenReturn(List.of(share(1L, "75.000000")));

        LoanChargeService service = buildService(taxService);
        LoanCharge loanCharge = loanCharge(7L, new BigDecimal("500.00"), null);

        service.populateDerivedFields(loanCharge, BigDecimal.ZERO, new BigDecimal("500.00"), null, BigDecimal.ZERO);

        assertThat(loanCharge.getAmountOutstanding()).isEqualByComparingTo(new BigDecimal("500.00"));
    }

    @Test
    void populateDerivedFields_doesNotMutateCharge_whenComputedTaxIsZero() {
        ChargeTaxApplicationService taxService = mock(ChargeTaxApplicationService.class);
        when(taxService.computeTax(any(), any(), any(), anyInt())).thenReturn(Collections.emptyList());

        LoanChargeService service = buildService(taxService);
        LoanCharge loanCharge = loanCharge(7L, new BigDecimal("200.00"), null);

        service.populateDerivedFields(loanCharge, BigDecimal.ZERO, new BigDecimal("200.00"), null, BigDecimal.ZERO);

        assertThat(loanCharge.getTaxAmount()).isZero();
        assertThat(loanCharge.getAmount()).isEqualByComparingTo(new BigDecimal("200.00"));
    }

    @Test
    void populateDerivedFields_usesSubmittedOnDate_asEffectiveDateForTax() {
        LocalDate submittedOn = LocalDate.of(2026, 1, 15);
        ChargeTaxApplicationService taxService = mock(ChargeTaxApplicationService.class);
        when(taxService.computeTax(any(), any(), any(), anyInt())).thenReturn(List.of(share(1L, "20.000000")));

        LoanChargeService service = buildService(taxService);
        LoanCharge loanCharge = loanCharge(7L, new BigDecimal("200.00"), submittedOn);

        service.populateDerivedFields(loanCharge, BigDecimal.ZERO, new BigDecimal("200.00"), null, BigDecimal.ZERO);

        org.mockito.Mockito.verify(taxService).computeTax(7L, new BigDecimal("200.00"), submittedOn, 6);
    }

    @Test
    void populateDerivedFields_usesBusinessDate_whenSubmittedOnDateIsNull() {
        ChargeTaxApplicationService taxService = mock(ChargeTaxApplicationService.class);
        when(taxService.computeTax(any(), any(), any(), anyInt())).thenReturn(List.of(share(1L, "10.000000")));

        LoanChargeService service = buildService(taxService);
        LoanCharge loanCharge = loanCharge(7L, new BigDecimal("100.00"), null);

        service.populateDerivedFields(loanCharge, BigDecimal.ZERO, new BigDecimal("100.00"), null, BigDecimal.ZERO);

        org.mockito.Mockito.verify(taxService).computeTax(7L, new BigDecimal("100.00"), BUSINESS_DATE, 6);
    }

    @Test
    void populateDerivedFields_clearsPreviousTaxDetails_onReapplication() {
        ChargeTaxApplicationService taxService = mock(ChargeTaxApplicationService.class);
        when(taxService.computeTax(any(), any(), any(), anyInt())).thenReturn(
                List.of(share(11L, "10.000000"), share(12L, "5.000000")), List.of(share(11L, "20.000000")));

        LoanChargeService service = buildService(taxService);
        LoanCharge loanCharge = loanCharge(7L, new BigDecimal("100.00"), null);

        service.populateDerivedFields(loanCharge, BigDecimal.ZERO, new BigDecimal("100.00"), null, BigDecimal.ZERO);
        assertThat(loanCharge.getTaxDetails()).hasSize(2);

        loanCharge.setAmount(new BigDecimal("100.00"));
        loanCharge.setAmountOutstanding(new BigDecimal("100.00"));

        service.populateDerivedFields(loanCharge, BigDecimal.ZERO, new BigDecimal("100.00"), null, BigDecimal.ZERO);
        assertThat(loanCharge.getTaxDetails()).hasSize(1);
        assertThat(loanCharge.getTaxDetails().get(0).getTaxComponentId()).isEqualTo(11L);
    }

    private static TaxComponentShareData share(Long componentId, String amount) {
        return new TaxComponentShareData(componentId, "c" + componentId, new BigDecimal(amount), null, null);
    }

    private LoanCharge loanCharge(Long taxGroupId, BigDecimal amount, LocalDate submittedOnDate) {
        LoanCharge lc = new LoanCharge();
        lc.setChargeId(1L);
        lc.setChargeName("test-charge");
        lc.setCurrencyCode("USD");
        lc.setTaxGroupId(taxGroupId);
        lc.setAmount(amount);
        lc.setAmountOutstanding(amount);
        lc.setChargeCalculation(ChargeCalculationType.FLAT.getValue());
        lc.setChargeTime(ChargeTimeType.SPECIFIED_DUE_DATE.getValue());
        lc.setSubmittedOnDate(submittedOnDate);
        lc.setAmountOrPercentage(amount);
        return lc;
    }
}
