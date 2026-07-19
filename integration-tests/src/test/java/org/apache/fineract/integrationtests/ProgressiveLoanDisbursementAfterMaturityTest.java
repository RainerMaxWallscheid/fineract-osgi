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
package org.apache.fineract.integrationtests;

import static org.junit.jupiter.api.Assertions.assertEquals;
import java.math.BigDecimal;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;
import org.apache.fineract.client.models.GetLoansLoanIdResponse;
import org.apache.fineract.client.models.PostLoansLoanIdTransactionsResponse;
import org.apache.fineract.integrationtests.client.feign.FeignLoanTestBase;
import org.apache.fineract.integrationtests.client.feign.modules.LoanRequestBuilders;
import org.apache.fineract.integrationtests.client.feign.modules.LoanTestData;
import org.apache.fineract.portfolio.loanaccount.domain.LoanStatus;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class ProgressiveLoanDisbursementAfterMaturityTest extends FeignLoanTestBase {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(ProgressiveLoanDisbursementAfterMaturityTest.class);

    @Test
    public void testSecondDisbursementAfterOriginalMaturityDate() {
        final Long clientId = createClient();
        final AtomicReference<Long> loanIdRef = new AtomicReference<>();
        // Create loan product with specific configurations for this test
        final Long loanProductId = createLoanProduct(create4IProgressive().multiDisburseLoan(true).maxTrancheCount(10).disallowExpectedDisbursements(true).allowApprovedDisbursedAmountsOverApplied(true).overAppliedCalculationType("percentage").overAppliedNumber(100).enableDownPayment(true).disbursedAmountPercentageForDownPayment(BigDecimal.valueOf(25.0)).enableAutoRepaymentForDownPayment(true).addSupportedInterestRefundTypesItem(LoanTestData.SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).addSupportedInterestRefundTypesItem(LoanTestData.SupportedInterestRefundTypesItem.PAYOUT_REFUND).paymentAllocation(List.of(LoanRequestBuilders.paymentAllocation("DEFAULT", LoanTestData.FuturePaymentAllocationRule.NEXT_INSTALLMENT), LoanRequestBuilders.paymentAllocation("DOWN_PAYMENT", LoanTestData.FuturePaymentAllocationRule.NEXT_INSTALLMENT), LoanRequestBuilders.paymentAllocation("MERCHANT_ISSUED_REFUND", LoanTestData.FuturePaymentAllocationRule.LAST_INSTALLMENT), LoanRequestBuilders.paymentAllocation("PAYOUT_REFUND", LoanTestData.FuturePaymentAllocationRule.LAST_INSTALLMENT))));
        runAt("20240314", () -> {
            Long loanId = applyAndApproveProgressiveLoan(clientId, loanProductId, "20240314", 1000.0, 0.0, 3, null);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(487.58), "20240314");
            GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
            verifyLoanStatus(loanDetails, LoanStatus.ACTIVE);
            verifyTransactions(loanId, transaction(487.58, "Disbursement", "20240314"), transaction(121.9, "Down Payment", "20240314"));
            assertEquals(0, BigDecimal.valueOf(365.68).compareTo(loanDetails.getSummary().getPrincipalOutstanding()));
        });
        // Step 4: Create first merchant issued refund on 20240324 for €201.39
        runAt("20240324", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse mirResponse = makeLoanRepayment(loanId, "MerchantIssuedRefund", "20240324", 201.39);
            Assertions.assertNotNull(mirResponse);
            Assertions.assertNotNull(mirResponse.getResourceId());
            GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
            verifyLoanStatus(loanDetails, LoanStatus.ACTIVE);
            // Verify remaining balance
            assertEquals(0, BigDecimal.valueOf(164.29).compareTo(loanDetails.getSummary().getPrincipalOutstanding()));
            log.info("First MIR applied. Outstanding: €{}", loanDetails.getSummary().getPrincipalOutstanding());
        });
        // Step 5: Create second merchant issued refund on 20240324 for €286.19 to overpay
        runAt("20240324", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse mirResponse = makeLoanRepayment(loanId, "MerchantIssuedRefund", "20240324", 286.19);
            Assertions.assertNotNull(mirResponse);
            Assertions.assertNotNull(mirResponse.getResourceId());
            // After second MIR, the loan should be overpaid
            GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
            verifyLoanStatus(loanDetails, LoanStatus.OVERPAID);
            // Verify overpaid amount
            assertEquals(0, BigDecimal.valueOf(121.9).compareTo(loanDetails.getTotalOverpaid()));
        });
        // Step 6: Create credit balance refund on 20240325 to close the loan
        runAt("20240325", () -> {
            Long loanId = loanIdRef.get();
            makeLoanRepayment(loanId, "CreditBalanceRefund", "20240325", 121.9);
            GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
            verifyLoanStatus(loanDetails, LoanStatus.CLOSED_OBLIGATIONS_MET);
            assertEquals(0, BigDecimal.ZERO.compareTo(loanDetails.getSummary().getPrincipalOutstanding()));
        });
        runAt("20250401", () -> {
            Long loanId = loanIdRef.get();
            try {
                // Attempt second disbursement after original maturity date
                disburseLoan(loanId, BigDecimal.valueOf(312.69), "20250401");
                // If disbursement succeeds, verify the loan is active again
                GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
                verifyLoanStatus(loanDetails, LoanStatus.ACTIVE);
                // Verify second disbursement and automatic downpayment
                verifyTransactions(loanId, transaction(487.58, "Disbursement", "20240314"), transaction(121.9, "Down Payment", "20240314"), transaction(201.39, "Merchant Issued Refund", "20240324"), transaction(286.19, "Merchant Issued Refund", "20240324"), transaction(121.9, "Credit Balance Refund", "20240325"), transaction(312.69, "Disbursement", "20250401"), transaction(78.17, "Down Payment", "20250401")); // 25% of 312.69
                // Verify outstanding balance after second disbursement
                BigDecimal expectedOutstanding = BigDecimal.valueOf(312.69).subtract(BigDecimal.valueOf(78.17));
                assertEquals(0, expectedOutstanding.compareTo(loanDetails.getSummary().getPrincipalOutstanding()));
            } catch (Exception e) {
                log.error("Second disbursement failed after maturity date: {}", e.getMessage());
                Assertions.fail("Second disbursement should be allowed after original maturity date: " + e.getMessage());
            }
        });
    }
}
