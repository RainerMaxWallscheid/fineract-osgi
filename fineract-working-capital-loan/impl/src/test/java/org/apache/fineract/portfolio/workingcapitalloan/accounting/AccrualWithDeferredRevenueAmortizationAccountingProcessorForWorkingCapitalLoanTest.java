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
package org.apache.fineract.portfolio.workingcapitalloan.accounting;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.ArgumentMatchers.isNull;
import static org.mockito.Mockito.lenient;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import org.apache.fineract.accounting.common.AccountingConstants.CashAccountsForLoan;
import org.apache.fineract.accounting.moduleapi.WorkingCapitalLoanJournalPort;
import org.apache.fineract.infrastructure.businessdate.domain.BusinessDateType;
import org.apache.fineract.infrastructure.core.service.ThreadLocalContextUtil;
import org.apache.fineract.organisation.monetary.domain.MonetaryCurrency;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransactionRelationTypeEnum;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransactionType;
import org.apache.fineract.portfolio.paymentdetail.domain.PaymentDetail;
import org.apache.fineract.portfolio.paymenttype.domain.PaymentType;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoan;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoanCharge;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoanTransaction;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoanTransactionAllocation;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoanTransactionRelation;
import org.apache.fineract.portfolio.workingcapitalloanproduct.domain.WorkingCapitalLoanProduct;
import org.apache.fineract.portfolio.workingcapitalloanproduct.domain.WorkingCapitalLoanProductRelatedDetails;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class AccrualWithDeferredRevenueAmortizationAccountingProcessorForWorkingCapitalLoanTest {

    private static final long OFFICE_ID = 1L;
    private static final long PRODUCT_ID = 10L;
    private static final long LOAN_ID = 100L;
    private static final long TXN_ID = 200L;
    private static final String CURRENCY_CODE = "USD";
    private static final LocalDate TXN_DATE = LocalDate.of(2026, 5, 1);

    @Mock
    private WorkingCapitalLoanJournalPort journalPort;

    @InjectMocks
    private AccrualWithDeferredRevenueAmortizationAccountingProcessorForWorkingCapitalLoan processor;

    @Mock
    private WorkingCapitalLoan loan;
    @Mock
    private WorkingCapitalLoanTransaction txn;
    @Mock
    private WorkingCapitalLoanTransactionAllocation allocation;
    @Mock
    private WorkingCapitalLoanProduct loanProduct;
    @Mock
    private WorkingCapitalLoanProductRelatedDetails loanProductRelatedDetails;
    @Mock
    private MonetaryCurrency currency;

    @BeforeEach
    void setUp() {
        ThreadLocalContextUtil.setBusinessDates(new HashMap<>(
                Map.of(BusinessDateType.BUSINESS_DATE, TXN_DATE, BusinessDateType.COB_DATE, LocalDate.of(2026, 4, 30))));

        lenient().when(loan.getOfficeId()).thenReturn(OFFICE_ID);
        lenient().when(loan.getLoanProduct()).thenReturn(loanProduct);
        lenient().when(loanProduct.getId()).thenReturn(PRODUCT_ID);
        lenient().when(loan.getLoanProductRelatedDetails()).thenReturn(loanProductRelatedDetails);
        lenient().when(loanProductRelatedDetails.getCurrency()).thenReturn(currency);
        lenient().when(currency.getCode()).thenReturn(CURRENCY_CODE);
        lenient().when(txn.getWcLoan()).thenReturn(loan);
        lenient().when(txn.getTypeOf()).thenReturn(LoanTransactionType.REPAYMENT);
        lenient().when(loan.getId()).thenReturn(LOAN_ID);
        lenient().when(txn.getId()).thenReturn(TXN_ID);
        lenient().when(txn.getTransactionDate()).thenReturn(TXN_DATE);
        lenient().when(txn.getPaymentDetail()).thenReturn(null);
    }

    private void mockChargeAdjustmentRelation(final boolean penaltyCharge) {
        final WorkingCapitalLoanCharge charge = org.mockito.Mockito.mock(WorkingCapitalLoanCharge.class);
        lenient().when(charge.isPenaltyCharge()).thenReturn(penaltyCharge);
        final WorkingCapitalLoanTransactionRelation relation = org.mockito.Mockito.mock(WorkingCapitalLoanTransactionRelation.class);
        lenient().when(relation.getToCharge()).thenReturn(charge);
        lenient().when(relation.getRelationType()).thenReturn(LoanTransactionRelationTypeEnum.CHARGE_ADJUSTMENT);
        lenient().when(txn.getLoanTransactionRelations()).thenReturn(Set.of(relation));
    }

    private void verifyCredit(final CashAccountsForLoan accountType, final String amount) {
        verify(journalPort).postCredit(eq(OFFICE_ID), eq(PRODUCT_ID), eq(CURRENCY_CODE), eq(accountType.getValue()), isNull(), eq(LOAN_ID),
                eq(TXN_ID), any(), eq(new BigDecimal(amount)));
    }

    private void verifyDebit(final CashAccountsForLoan accountType, final Long paymentTypeId, final String amount) {
        verify(journalPort).postDebit(eq(OFFICE_ID), eq(PRODUCT_ID), eq(CURRENCY_CODE), eq(accountType.getValue()), eq(paymentTypeId),
                eq(LOAN_ID), eq(TXN_ID), any(), eq(new BigDecimal(amount)));
    }

    @AfterEach
    void tearDown() {
        ThreadLocalContextUtil.reset();
    }

    @Test
    void testRegularRepaymentWithFeesAndPenalties() {
        when(txn.getTransactionAmount()).thenReturn(new BigDecimal("1500"));
        when(allocation.getPrincipalPortion()).thenReturn(new BigDecimal("1000"));
        when(allocation.getFeeChargesPortion()).thenReturn(new BigDecimal("300"));
        when(allocation.getPenaltyChargesPortion()).thenReturn(new BigDecimal("200"));

        processor.postJournalEntries(loan, txn, allocation, false);

        verify(journalPort).ensureBranchNotClosed(OFFICE_ID, TXN_DATE);
        verifyCredit(CashAccountsForLoan.LOAN_PORTFOLIO, "1000");
        verifyCredit(CashAccountsForLoan.FEES_RECEIVABLE, "300");
        verifyCredit(CashAccountsForLoan.PENALTIES_RECEIVABLE, "200");
        verifyDebit(CashAccountsForLoan.FUND_SOURCE, null, "1500");
    }

    @Test
    void testRegularRepaymentWithOverpayment() {
        when(txn.getTransactionAmount()).thenReturn(new BigDecimal("5200"));
        when(allocation.getPrincipalPortion()).thenReturn(new BigDecimal("5000"));
        when(allocation.getFeeChargesPortion()).thenReturn(BigDecimal.ZERO);
        when(allocation.getPenaltyChargesPortion()).thenReturn(BigDecimal.ZERO);

        processor.postJournalEntries(loan, txn, allocation, false);

        verifyCredit(CashAccountsForLoan.LOAN_PORTFOLIO, "5000");
        verifyCredit(CashAccountsForLoan.OVERPAYMENT, "200");
        verifyDebit(CashAccountsForLoan.FUND_SOURCE, null, "5200");
    }

    @Test
    void testRegularRepaymentOnAlreadyClosedOrOverpaidLoanPostsOnlyOverpaymentCredit() {
        when(txn.getTransactionAmount()).thenReturn(new BigDecimal("750"));
        when(allocation.getPrincipalPortion()).thenReturn(BigDecimal.ZERO);
        when(allocation.getFeeChargesPortion()).thenReturn(BigDecimal.ZERO);
        when(allocation.getPenaltyChargesPortion()).thenReturn(BigDecimal.ZERO);

        processor.postJournalEntries(loan, txn, allocation, false);

        verifyDebit(CashAccountsForLoan.FUND_SOURCE, null, "750");
        verifyCredit(CashAccountsForLoan.OVERPAYMENT, "750");
        verify(journalPort, never()).postCredit(anyLong(), anyLong(), any(), eq(CashAccountsForLoan.LOAN_PORTFOLIO.getValue()), any(),
                anyLong(), anyLong(), any(), any());
        verify(journalPort, never()).postCredit(anyLong(), anyLong(), any(), eq(CashAccountsForLoan.FEES_RECEIVABLE.getValue()), any(),
                anyLong(), anyLong(), any(), any());
        verify(journalPort, never()).postCredit(anyLong(), anyLong(), any(), eq(CashAccountsForLoan.PENALTIES_RECEIVABLE.getValue()), any(),
                anyLong(), anyLong(), any(), any());
    }

    @Test
    void testChargedOffRepaymentCreatesSeparateRecoveryEntries() {
        when(txn.getTransactionAmount()).thenReturn(new BigDecimal("1500"));
        when(allocation.getPrincipalPortion()).thenReturn(new BigDecimal("1000"));
        when(allocation.getFeeChargesPortion()).thenReturn(new BigDecimal("300"));
        when(allocation.getPenaltyChargesPortion()).thenReturn(new BigDecimal("200"));

        processor.postJournalEntries(loan, txn, allocation, true);

        verify(journalPort).postCredit(eq(OFFICE_ID), eq(PRODUCT_ID), eq(CURRENCY_CODE), eq(CashAccountsForLoan.INCOME_FROM_RECOVERY.getValue()),
                isNull(), eq(LOAN_ID), eq(TXN_ID), any(), eq(new BigDecimal("1000")));
        verify(journalPort).postCredit(eq(OFFICE_ID), eq(PRODUCT_ID), eq(CURRENCY_CODE), eq(CashAccountsForLoan.INCOME_FROM_RECOVERY.getValue()),
                isNull(), eq(LOAN_ID), eq(TXN_ID), any(), eq(new BigDecimal("300")));
        verify(journalPort).postCredit(eq(OFFICE_ID), eq(PRODUCT_ID), eq(CURRENCY_CODE), eq(CashAccountsForLoan.INCOME_FROM_RECOVERY.getValue()),
                isNull(), eq(LOAN_ID), eq(TXN_ID), any(), eq(new BigDecimal("200")));
        verifyDebit(CashAccountsForLoan.FUND_SOURCE, null, "1500");
    }

    @Test
    void testChargedOffRepaymentWithOverpayment() {
        when(txn.getTransactionAmount()).thenReturn(new BigDecimal("6000"));
        when(allocation.getPrincipalPortion()).thenReturn(new BigDecimal("5000"));
        when(allocation.getFeeChargesPortion()).thenReturn(BigDecimal.ZERO);
        when(allocation.getPenaltyChargesPortion()).thenReturn(BigDecimal.ZERO);

        processor.postJournalEntries(loan, txn, allocation, true);

        verify(journalPort).postCredit(eq(OFFICE_ID), eq(PRODUCT_ID), eq(CURRENCY_CODE), eq(CashAccountsForLoan.INCOME_FROM_RECOVERY.getValue()),
                isNull(), eq(LOAN_ID), eq(TXN_ID), any(), eq(new BigDecimal("5000")));
        verifyCredit(CashAccountsForLoan.OVERPAYMENT, "1000");
        verifyDebit(CashAccountsForLoan.FUND_SOURCE, null, "6000");
    }

    @Test
    void testReversalDelegatesToJournalPort() {
        when(txn.getReversedOnDate()).thenReturn(LocalDate.of(2026, 5, 2));

        processor.postReversalJournalEntries(loan, txn);

        verify(journalPort).reverse(OFFICE_ID, TXN_ID, LocalDate.of(2026, 5, 2));
    }

    @Test
    void testCreditBalanceRefundPostsOverpaymentDebitAndFundSourceCredit() {
        when(txn.getTypeOf()).thenReturn(LoanTransactionType.CREDIT_BALANCE_REFUND);
        when(txn.getTransactionAmount()).thenReturn(new BigDecimal("50"));

        processor.postJournalEntries(loan, txn, allocation, false);

        verifyDebit(CashAccountsForLoan.OVERPAYMENT, null, "50");
        verifyCredit(CashAccountsForLoan.FUND_SOURCE, "50");
    }

    @Test
    void testCreditBalanceRefundReversalDelegatesToJournalPort() {
        when(txn.getReversedOnDate()).thenReturn(LocalDate.of(2026, 5, 3));

        processor.postReversalJournalEntries(loan, txn);

        verify(journalPort).reverse(OFFICE_ID, TXN_ID, LocalDate.of(2026, 5, 3));
    }

    @Test
    void testAdvanceAccountingUsesPaymentChannelFundSource() {
        final PaymentDetail paymentDetail = org.mockito.Mockito.mock(PaymentDetail.class);
        final PaymentType paymentType = org.mockito.Mockito.mock(PaymentType.class);

        when(txn.getTransactionAmount()).thenReturn(new BigDecimal("1000"));
        when(txn.getPaymentDetail()).thenReturn(paymentDetail);
        when(paymentDetail.getPaymentType()).thenReturn(paymentType);
        when(paymentType.getId()).thenReturn(5L);
        when(allocation.getPrincipalPortion()).thenReturn(new BigDecimal("1000"));
        when(allocation.getFeeChargesPortion()).thenReturn(BigDecimal.ZERO);
        when(allocation.getPenaltyChargesPortion()).thenReturn(BigDecimal.ZERO);

        processor.postJournalEntries(loan, txn, allocation, false);

        verifyDebit(CashAccountsForLoan.FUND_SOURCE, 5L, "1000");
    }

    @Test
    void testChargeAdjustmentOnFeeChargeDebitsFeeIncomeAndCreditsFeeReceivable() {
        when(txn.getTypeOf()).thenReturn(LoanTransactionType.CHARGE_ADJUSTMENT);
        when(txn.getTransactionAmount()).thenReturn(new BigDecimal("40"));
        mockChargeAdjustmentRelation(false);
        when(allocation.getPrincipalPortion()).thenReturn(BigDecimal.ZERO);
        when(allocation.getFeeChargesPortion()).thenReturn(new BigDecimal("40"));
        when(allocation.getPenaltyChargesPortion()).thenReturn(BigDecimal.ZERO);

        processor.postJournalEntries(loan, txn, allocation, false);

        verifyDebit(CashAccountsForLoan.INCOME_FROM_FEES, null, "40");
        verifyCredit(CashAccountsForLoan.FEES_RECEIVABLE, "40");
    }

    @Test
    void testChargeAdjustmentOnPenaltyChargeDebitsPenaltyIncomeAndCreditsPenaltyReceivable() {
        when(txn.getTypeOf()).thenReturn(LoanTransactionType.CHARGE_ADJUSTMENT);
        when(txn.getTransactionAmount()).thenReturn(new BigDecimal("25"));
        mockChargeAdjustmentRelation(true);
        when(allocation.getPrincipalPortion()).thenReturn(BigDecimal.ZERO);
        when(allocation.getFeeChargesPortion()).thenReturn(BigDecimal.ZERO);
        when(allocation.getPenaltyChargesPortion()).thenReturn(new BigDecimal("25"));

        processor.postJournalEntries(loan, txn, allocation, false);

        verifyDebit(CashAccountsForLoan.INCOME_FROM_PENALTIES, null, "25");
        verifyCredit(CashAccountsForLoan.PENALTIES_RECEIVABLE, "25");
    }

    @Test
    void testChargeAdjustmentSpillingOntoPrincipalDebitsFullAmountAgainstChargesOwnIncomeAccount() {
        when(txn.getTypeOf()).thenReturn(LoanTransactionType.CHARGE_ADJUSTMENT);
        when(txn.getTransactionAmount()).thenReturn(new BigDecimal("60"));
        mockChargeAdjustmentRelation(false);
        when(allocation.getPrincipalPortion()).thenReturn(new BigDecimal("40"));
        when(allocation.getFeeChargesPortion()).thenReturn(new BigDecimal("20"));
        when(allocation.getPenaltyChargesPortion()).thenReturn(BigDecimal.ZERO);

        processor.postJournalEntries(loan, txn, allocation, false);

        verifyDebit(CashAccountsForLoan.INCOME_FROM_FEES, null, "60");
        verifyCredit(CashAccountsForLoan.FEES_RECEIVABLE, "20");
        verifyCredit(CashAccountsForLoan.LOAN_PORTFOLIO, "40");
    }

    @Test
    void testChargedOffChargeAdjustmentDebitsRecoveryInsteadOfFeeIncome() {
        when(txn.getTypeOf()).thenReturn(LoanTransactionType.CHARGE_ADJUSTMENT);
        when(txn.getTransactionAmount()).thenReturn(new BigDecimal("40"));
        mockChargeAdjustmentRelation(false);
        when(allocation.getPrincipalPortion()).thenReturn(BigDecimal.ZERO);
        when(allocation.getFeeChargesPortion()).thenReturn(new BigDecimal("40"));
        when(allocation.getPenaltyChargesPortion()).thenReturn(BigDecimal.ZERO);

        processor.postJournalEntries(loan, txn, allocation, true);

        verifyDebit(CashAccountsForLoan.INCOME_FROM_RECOVERY, null, "40");
        verifyCredit(CashAccountsForLoan.FEES_RECEIVABLE, "40");
    }

    @Test
    void testChargeAdjustmentWithoutChargeLinkFailsFast() {
        when(txn.getTypeOf()).thenReturn(LoanTransactionType.CHARGE_ADJUSTMENT);
        when(txn.getTransactionAmount()).thenReturn(new BigDecimal("40"));
        when(txn.getLoanTransactionRelations()).thenReturn(Set.of());
        when(allocation.getPrincipalPortion()).thenReturn(BigDecimal.ZERO);
        when(allocation.getFeeChargesPortion()).thenReturn(new BigDecimal("40"));
        when(allocation.getPenaltyChargesPortion()).thenReturn(BigDecimal.ZERO);

        assertThrows(IllegalStateException.class, () -> processor.postJournalEntries(loan, txn, allocation, false));
    }
}
