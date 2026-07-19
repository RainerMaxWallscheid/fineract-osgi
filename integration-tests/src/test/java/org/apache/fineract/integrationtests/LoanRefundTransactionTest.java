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

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.concurrent.atomic.AtomicReference;
import org.apache.fineract.client.models.GetLoansLoanIdResponse;
import org.apache.fineract.client.models.PostCreateRescheduleLoansRequest;
import org.apache.fineract.client.models.PostLoansLoanIdTransactionsRequest;
import org.apache.fineract.client.models.PostLoansLoanIdTransactionsResponse;
import org.apache.fineract.client.models.PostUpdateRescheduleLoansRequest;
import org.apache.fineract.integrationtests.client.feign.FeignLoanTestBase;
import org.apache.fineract.integrationtests.client.feign.modules.LoanTestData;
import org.apache.fineract.integrationtests.common.ClientHelper;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class LoanRefundTransactionTest extends FeignLoanTestBase {

    private static final String DATETIME_PATTERN = LoanTestData.DATETIME_PATTERN;

    @Test
    public void testMerchantIssuedRefundCreatesAndReversesInterestRefund() {
        runAt("20240701", () -> {
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            final Long loanId = createAndDisburseLoanForMerchantIssuedRefundWithInterestRefund(clientId);
            final PostLoansLoanIdTransactionsResponse merchantIssuedRefundResponse = makeMerchantIssuedRefund(loanId,
                    new PostLoansLoanIdTransactionsRequest().dateFormat(DATETIME_PATTERN).transactionDate("20240701")
                            .locale(LoanTestData.LOCALE).transactionAmount(100.0));

            GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
            Assertions.assertTrue(
                    loanDetails.getTransactions().stream().anyMatch(transaction -> transaction.getType().getMerchantIssuedRefund()
                            && Boolean.FALSE.equals(transaction.getManuallyReversed())));

            Assertions.assertTrue(loanDetails.getTransactions().stream()
                    .anyMatch(transaction -> transaction.getType().getCode().equals("loanTransactionType.interestRefund")
                            && Boolean.FALSE.equals(transaction.getManuallyReversed())));

            reverseLoanTransaction(loanId, merchantIssuedRefundResponse.getResourceId(), "20240701");

            loanDetails = getLoanDetails(loanId);
            Assertions.assertTrue(
                    loanDetails.getTransactions().stream().anyMatch(transaction -> transaction.getType().getMerchantIssuedRefund()
                            && Boolean.TRUE.equals(transaction.getManuallyReversed())));

            Assertions.assertTrue(loanDetails.getTransactions().stream()
                    .anyMatch(transaction -> transaction.getType().getCode().equals("loanTransactionType.interestRefund")
                            && Boolean.TRUE.equals(transaction.getManuallyReversed())));
        });
    }

    @Test
    public void testPayoutRefundCreatesAndReversesInterestRefund() {
        runAt("20240701", () -> {
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            final Long loanId = createAndDisburseLoanForPayoutRefundWithInterestRefund(clientId);
            final PostLoansLoanIdTransactionsResponse payoutRefundResponse = makePayoutRefund(loanId,
                    new PostLoansLoanIdTransactionsRequest().dateFormat(DATETIME_PATTERN).transactionDate("20240701")
                            .locale(LoanTestData.LOCALE).transactionAmount(100.0));

            GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
            Assertions.assertTrue(loanDetails.getTransactions().stream().anyMatch(
                    transaction -> transaction.getType().getPayoutRefund() && Boolean.FALSE.equals(transaction.getManuallyReversed())));

            Assertions.assertTrue(loanDetails.getTransactions().stream()
                    .anyMatch(transaction -> transaction.getType().getCode().equals("loanTransactionType.interestRefund")
                            && Boolean.FALSE.equals(transaction.getManuallyReversed())));

            reverseLoanTransaction(loanId, payoutRefundResponse.getResourceId(), "20240701");

            loanDetails = getLoanDetails(loanId);
            Assertions.assertTrue(loanDetails.getTransactions().stream().anyMatch(
                    transaction -> transaction.getType().getPayoutRefund() && Boolean.TRUE.equals(transaction.getManuallyReversed())));

            Assertions.assertTrue(loanDetails.getTransactions().stream()
                    .anyMatch(transaction -> transaction.getType().getCode().equals("loanTransactionType.interestRefund")
                            && Boolean.TRUE.equals(transaction.getManuallyReversed())));
        });
    }

    @Test
    public void testMerchantIssuedRefundDoesNotCreateInterestRefundWithLessThanOrEqualToZeroInterest() {
        runAt("20250420", () -> {
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            Long loanId = createLoanForRefundWithInterestRefund(clientId, "MERCHANT_ISSUED_REFUND", "20250405", 500.0, 20.99, 6);
            disburseLoan(loanId, BigDecimal.valueOf(265.91), "20250405");
            disburseLoan(loanId, BigDecimal.valueOf(1.99), "20250405");
            disburseLoan(loanId, BigDecimal.valueOf(20.00), "20250405");

            makeMerchantIssuedRefund(loanId, new PostLoansLoanIdTransactionsRequest().dateFormat(DATETIME_PATTERN)
                    .transactionDate("20250406").locale(LoanTestData.LOCALE).transactionAmount(6.29));

            makeMerchantIssuedRefund(loanId, new PostLoansLoanIdTransactionsRequest().dateFormat(DATETIME_PATTERN)
                    .transactionDate("20250407").locale(LoanTestData.LOCALE).transactionAmount(1.99));

            GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
            Assertions.assertTrue(loanDetails.getTransactions().stream()
                    .filter(transaction -> transaction.getType().getCode().equals("loanTransactionType.interestRefund"))
                    .allMatch(transaction -> transaction.getAmount().doubleValue() > 0.0));
        });
    }

    @Test
    public void testMerchantIssuedRefundAndCreditBalanceRefundWithAdjustSchedule() {
        final AtomicReference<Long> loanIdRef = new AtomicReference<>();

        runAt("20250924", () -> {
            final Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            final Long loanId = createLoanForRefundWithInterestRefund(clientId, "MERCHANT_ISSUED_REFUND", "20250924", 116.89,
                    35.99, 3);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(116.89), "20250924");
        });

        runAt("20250926", () -> {
            executeInlineCOB(loanIdRef.get());
            addRepaymentForLoan(loanIdRef.get(), 117.12, "20250926");
        });

        runAt("20251006", () -> {
            executeInlineCOB(loanIdRef.get());
            makeMerchantIssuedRefund(loanIdRef.get(), new PostLoansLoanIdTransactionsRequest().dateFormat(DATETIME_PATTERN)
                    .transactionDate("20251006").locale(LoanTestData.LOCALE).transactionAmount(8.13));

            GetLoansLoanIdResponse loanDetails = getLoanDetails(loanIdRef.get());
            assertTrue(loanDetails.getStatus().getOverpaid());

            validateLoanSummaryBalances(loanDetails, 0.00, 117.12, 0.00, 116.89, 8.14);
        });

        runAt("20251007", () -> {
            executeInlineCOB(loanIdRef.get());
            makeCreditBalanceRefund(loanIdRef.get(), new PostLoansLoanIdTransactionsRequest().dateFormat(DATETIME_PATTERN)
                    .transactionDate("20251007").locale(LoanTestData.LOCALE).transactionAmount(8.14));

            GetLoansLoanIdResponse loanDetails = getLoanDetails(loanIdRef.get());
            assertTrue(loanDetails.getStatus().getClosedObligationsMet());
            validateLoanSummaryBalances(loanDetails, 0.00, 117.12, 0.00, 116.89, null);

            Long scheduleId = createRescheduleRequest(new PostCreateRescheduleLoansRequest().loanId(loanIdRef.get()).rescheduleReasonId(1L)
                    .rescheduleFromDate("20250925").dateFormat(DATETIME_PATTERN).locale(LoanTestData.LOCALE)
                    .submittedOnDate("20251007").newInterestRate(BigDecimal.valueOf(25.99)));

            approveRescheduleRequest(scheduleId, new PostUpdateRescheduleLoansRequest().approvedOnDate("20251007")
                    .locale(LoanTestData.LOCALE).dateFormat(DATETIME_PATTERN));

            loanDetails = getLoanDetails(loanIdRef.get());
            assertTrue(loanDetails.getStatus().getOverpaid());

            validateLoanSummaryBalances(loanDetails, 0.00, 117.06, 0.00, 116.89, 0.06);
        });
    }

    private Long createAndDisburseLoanForMerchantIssuedRefundWithInterestRefund(Long clientId) {
        return createAndDisburseLoanForRefundWithInterestRefund(clientId, "MERCHANT_ISSUED_REFUND");
    }

    private Long createAndDisburseLoanForPayoutRefundWithInterestRefund(Long clientId) {
        return createAndDisburseLoanForRefundWithInterestRefund(clientId, "PAYOUT_REFUND");
    }

    private Long createAndDisburseLoanForRefundWithInterestRefund(Long clientId, String refundType) {
        Long loanId = createLoanForRefundWithInterestRefund(clientId, refundType, "20240601", 1000.0, 10.0, 4);
        disburseLoan(loanId, BigDecimal.valueOf(1000.0), "20240601");
        return loanId;
    }

    private Long createLoanForRefundWithInterestRefund(Long clientId, String refundType, String date, double amount, double interestRate,
            int numRepayments) {
        final Long loanProductId = createLoanProduct(
                create4IProgressive().supportedInterestRefundTypes(new ArrayList<>()).addSupportedInterestRefundTypesItem(refundType));
        Long loanId = applyForLoan(
                applyLP2ProgressiveLoanRequest(clientId, loanProductId, date, amount, interestRate, numRepayments, null));
        approveLoan(loanId, approveLoanRequest(amount, date));
        return loanId;
    }
}
