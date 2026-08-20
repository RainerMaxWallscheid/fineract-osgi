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
package org.apache.fineract.investor.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import org.apache.fineract.infrastructure.configuration.domain.ConfigurationDomainService;
import org.apache.fineract.organisation.monetary.mapper.CurrencyMapper;
import org.apache.fineract.portfolio.loanaccount.data.LoanAccountData;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.domain.LoanSummary;
import org.apache.fineract.portfolio.loanaccount.loanschedule.data.LoanScheduleData;
import org.apache.fineract.portfolio.loanaccount.service.LoanOutstandingInterestPortAdapter;
import org.apache.fineract.portfolio.loanaccount.service.LoanReadPlatformService;
import org.apache.fineract.portfolio.loanaccount.service.LoanSummaryDataProvider;
import org.apache.fineract.portfolio.loanaccount.service.LoanSummaryProviderDelegate;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class ExternalAssetOwnerTransferOutstandingInterestCalculationTest {

    @Mock
    private LoanSummaryProviderDelegate loanSummaryDataProvider;

    @Mock
    private ConfigurationDomainService configurationDomainService;

    @Mock
    private LoanReadPlatformService loanReadPlatformService;

    @Mock
    private CurrencyMapper currencyMapper;

    @Mock
    private Loan loan;

    @Mock
    private LoanSummary loanSummary;

    @Mock
    private LoanAccountData loanAccountData;

    @Mock
    private LoanScheduleData loanScheduleData;

    @Mock
    private LoanSummaryDataProvider summaryDataProvider;

    private ExternalAssetOwnerTransferOutstandingInterestCalculation externalAssetOwnerTransferOutstandingInterestCalculation;

    @BeforeEach
    void setUp() {
        final LoanOutstandingInterestPortAdapter port = new LoanOutstandingInterestPortAdapter(loanSummaryDataProvider,
                configurationDomainService, loanReadPlatformService, currencyMapper);
        externalAssetOwnerTransferOutstandingInterestCalculation = new ExternalAssetOwnerTransferOutstandingInterestCalculation(port);
    }

    @Test
    void testCalculateOutstandingInterest_WhenLoanNotDisbursed_ShouldReturnZero() {
        when(loan.isOpen()).thenReturn(false);

        BigDecimal result = externalAssetOwnerTransferOutstandingInterestCalculation.calculateOutstandingInterest(loan);

        assertEquals(BigDecimal.ZERO, result);
        verify(configurationDomainService, never()).getAssetOwnerTransferOustandingInterestStrategy();
        verify(loanReadPlatformService, never()).retrieveOne(Mockito.anyLong());
        verify(loan, times(1)).isOpen();
    }

    @Test
    void testCalculateOutstandingInterest_WhenLoanDisbursedWithTotalStrategy_ShouldCalculate() {
        when(loan.isOpen()).thenReturn(true);
        when(configurationDomainService.getAssetOwnerTransferOustandingInterestStrategy()).thenReturn("TOTAL_OUTSTANDING_INTEREST");
        when(loan.getSummary()).thenReturn(loanSummary);
        BigDecimal expectedInterest = new BigDecimal("150.50");
        when(loanSummary.getTotalInterestOutstanding()).thenReturn(expectedInterest);

        BigDecimal result = externalAssetOwnerTransferOutstandingInterestCalculation.calculateOutstandingInterest(loan);

        assertEquals(expectedInterest, result);
        verify(loan, times(1)).isOpen();
        verify(loan, times(1)).getSummary();
    }

    @Test
    void testCalculateOutstandingInterest_BackdatedUndisbursedLoan_ShouldReturnZero() {
        when(loan.isOpen()).thenReturn(false);

        BigDecimal result = externalAssetOwnerTransferOutstandingInterestCalculation.calculateOutstandingInterest(loan);

        assertEquals(BigDecimal.ZERO, result);
        verify(loan, times(1)).isOpen();
        verify(configurationDomainService, never()).getAssetOwnerTransferOustandingInterestStrategy();
    }
}
