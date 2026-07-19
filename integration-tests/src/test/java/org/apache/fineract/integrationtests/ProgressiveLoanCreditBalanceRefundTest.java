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

import java.math.BigDecimal;
import java.util.concurrent.atomic.AtomicReference;
import org.apache.fineract.integrationtests.client.feign.FeignLoanTestBase;
import org.junit.jupiter.api.Test;

public class ProgressiveLoanCreditBalanceRefundTest extends FeignLoanTestBase {

    Long clientId = createClient();
    Long loanProductId = createLoanProduct(create4IProgressive());

    @Test
    public void testAccrualCreationAfterCBRThenReverseRepayment() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        AtomicReference<Long> reverseRepaymentIdRef = new AtomicReference<>();
        runAt("20210213", () -> {
            loanIdRef.set(applyAndApproveProgressiveLoan(clientId, loanProductId, "20210213", 300.0, 37.56, 12, null));

            disburseLoan(loanIdRef.get(), BigDecimal.valueOf(300.0), "20210213");

            verifyRepaymentSchedule(loanIdRef.get(), //
                    installment(300.0, null, "20210213"), //
                    installment(20.98, 9.39, 30.37, false, "20210313"), //
                    installment(21.64, 8.73, 30.37, false, "20210413"), //
                    installment(22.31, 8.06, 30.37, false, "20210513"), //
                    installment(23.01, 7.36, 30.37, false, "20210613"), //
                    installment(23.73, 6.64, 30.37, false, "20210713"), //
                    installment(24.48, 5.89, 30.37, false, "20210813"), //
                    installment(25.24, 5.13, 30.37, false, "20210913"), //
                    installment(26.03, 4.34, 30.37, false, "20211013"), //
                    installment(26.85, 3.52, 30.37, false, "20211113"), //
                    installment(27.69, 2.68, 30.37, false, "20211213"), //
                    installment(28.55, 1.82, 30.37, false, "20220113"), //
                    installment(29.49, 0.92, 30.41, false, "20220213") //
            );

            makeLoanRepayment(loanIdRef.get(), "Repayment", "20210213", 60.0);
            Long repaymentId = makeLoanRepayment(loanIdRef.get(), "Repayment", "20210213", 40.0).getResourceId();
            reverseRepaymentIdRef.set(repaymentId);
            makeLoanRepayment(loanIdRef.get(), "MerchantIssuedRefund", "20210213", 300.0);

            verifyRepaymentSchedule(loanIdRef.get(), //
                    installment(300.0, null, "20210213"), //
                    installment(30.37, 0.0, 0.0, true, "20210313"), //
                    installment(30.37, 0.0, 0.0, true, "20210413"), //
                    installment(30.37, 0.0, 0.0, true, "20210513"), //
                    installment(30.37, 0.0, 0.0, true, "20210613"), //
                    installment(30.37, 0.0, 0.0, true, "20210713"), //
                    installment(30.37, 0.0, 0.0, true, "20210813"), //
                    installment(30.37, 0.0, 0.0, true, "20210913"), //
                    installment(30.37, 0.0, 0.0, true, "20211013"), //
                    installment(30.37, 0.0, 0.0, true, "20211113"), //
                    installment(26.67, 0.0, 0.0, true, "20211213"), //
                    installment(0.0, 0.0, 0.0, true, "20220113"), //
                    installment(0.0, 0.0, 0.0, true, "20220213") //
            );
            verifyTransactions(loanIdRef.get(), //
                    transaction(300.0, "Disbursement", "20210213", 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(60.0, "Repayment", "20210213", 240.0, 60.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(40.0, "Repayment", "20210213", 200.0, 40.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(300.0, "Merchant Issued Refund", "20210213", 0.0, 200.0, 0.0, 0.0, 0.0, 0.0, 100.0, false) //
            );
        });

        runAt("20210219", () -> {
            final Long loanId = loanIdRef.get();
            executeInlineCOB(loanId);
            makeLoanRepayment(loanId, "CreditBalanceRefund", "20210219", 100.0);
            // 0 overpaid
            verifyRepaymentSchedule(loanId, //
                    installment(300.0, null, "20210213"), //
                    installment(30.37, 0.0, 0.0, true, "20210313"), //
                    installment(30.37, 0.0, 0.0, true, "20210413"), //
                    installment(30.37, 0.0, 0.0, true, "20210513"), //
                    installment(30.37, 0.0, 0.0, true, "20210613"), //
                    installment(30.37, 0.0, 0.0, true, "20210713"), //
                    installment(30.37, 0.0, 0.0, true, "20210813"), //
                    installment(30.37, 0.0, 0.0, true, "20210913"), //
                    installment(30.37, 0.0, 0.0, true, "20211013"), //
                    installment(30.37, 0.0, 0.0, true, "20211113"), //
                    installment(26.67, 0.0, 0.0, true, "20211213"), //
                    installment(0.0, 0.0, 0.0, true, "20220113"), //
                    installment(0.0, 0.0, 0.0, true, "20220213") //
            );
            verifyTransactions(loanId, //
                    transaction(300.0, "Disbursement", "20210213", 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(60.0, "Repayment", "20210213", 240.0, 60.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(40.0, "Repayment", "20210213", 200.0, 40.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(300.0, "Merchant Issued Refund", "20210213", 0.0, 200.0, 0.0, 0.0, 0.0, 0.0, 100.0, false), //
                    transaction(100.0, "Credit Balance Refund", "20210219", 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 100.0, false) //
            );
        });
        runAt("20210223", () -> {
            final Long loanId = loanIdRef.get();
            final Long reverseRepaymentId = reverseRepaymentIdRef.get();
            executeInlineCOB(loanId);
            reverseLoanTransaction(loanId, reverseRepaymentId, "20210223");
            // 40 outstanding
            verifyRepaymentSchedule(loanId, //
                    installment(300.0, null, "20210213"), //
                    installment(130.37, 0.98, 40.98, false, "20210313"), //
                    installment(30.37, 0.0, 0.0, true, "20210413"), //
                    installment(30.37, 0.0, 0.0, true, "20210513"), //
                    installment(30.37, 0.0, 0.0, true, "20210613"), //
                    installment(30.37, 0.0, 0.0, true, "20210713"), //
                    installment(30.37, 0.0, 0.0, true, "20210813"), //
                    installment(30.37, 0.0, 0.0, true, "20210913"), //
                    installment(30.37, 0.0, 0.0, true, "20211013"), //
                    installment(30.37, 0.0, 0.0, true, "20211113"), //
                    installment(26.67, 0.0, 0.0, true, "20211213"), //
                    installment(0.0, 0.0, 0.0, true, "20220113"), //
                    installment(0.0, 0.0, 0.0, true, "20220213") //
            );

            verifyTransactions(loanId, //
                    transaction(300.0, "Disbursement", "20210213", 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(60.0, "Repayment", "20210213", 240.0, 60.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(40.0, "Repayment", "20210213", 200.0, 40.0, 0.0, 0.0, 0.0, 0.0, 0.0, true), //
                    transaction(300.0, "Merchant Issued Refund", "20210213", 0.0, 240.0, 0.0, 0.0, 0.0, 0.0, 60.0, false), //
                    transaction(100.0, "Credit Balance Refund", "20210219", 40.0, 40.0, 0.0, 0.0, 0.0, 0.0, 60.0, false) //
            );
        });
        runAt("20210224", () -> {
            final Long loanId = loanIdRef.get();
            executeInlineCOB(loanId);
            verifyTransactions(loanId, //
                    transaction(300.0, "Disbursement", "20210213", 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(60.0, "Repayment", "20210213", 240.0, 60.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(40.0, "Repayment", "20210213", 200.0, 40.0, 0.0, 0.0, 0.0, 0.0, 0.0, true), //
                    transaction(300.0, "Merchant Issued Refund", "20210213", 0.0, 240.0, 0.0, 0.0, 0.0, 0.0, 60.0, false), //
                    transaction(100.0, "Credit Balance Refund", "20210219", 40.0, 40.0, 0.0, 0.0, 0.0, 0.0, 60.0, false), //
                    transaction(0.18, "Accrual", "20210223", 0.0, 0.0, 0.18, 0.0, 0.0, 0.0, 0.0, false) //
            );
        });
        runAt("20210228", () -> {
            final Long loanId = loanIdRef.get();
            executeInlineCOB(loanId);
            verifyTransactions(loanId, //
                    transaction(300.0, "Disbursement", "20210213", 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(60.0, "Repayment", "20210213", 240.0, 60.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(40.0, "Repayment", "20210213", 200.0, 40.0, 0.0, 0.0, 0.0, 0.0, 0.0, true), //
                    transaction(300.0, "Merchant Issued Refund", "20210213", 0.0, 240.0, 0.0, 0.0, 0.0, 0.0, 60.0, false), //
                    transaction(100.0, "Credit Balance Refund", "20210219", 40.0, 40.0, 0.0, 0.0, 0.0, 0.0, 60.0, false), //
                    transaction(0.18, "Accrual", "20210223", 0.0, 0.0, 0.18, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(0.04, "Accrual", "20210224", 0.0, 0.0, 0.04, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(0.05, "Accrual", "20210225", 0.0, 0.0, 0.05, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(0.04, "Accrual", "20210226", 0.0, 0.0, 0.04, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(0.05, "Accrual", "20210227", 0.0, 0.0, 0.05, 0.0, 0.0, 0.0, 0.0, false) //
            );
        });
    }

    @Test
    public void testAccrualCreationAfterCBRThenReverseRepaymentThenRepayment() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        AtomicReference<Long> reverseRepaymentIdRef = new AtomicReference<>();
        runAt("20210213", () -> {
            Long loanId = applyAndApproveProgressiveLoan(clientId, loanProductId, "20210213", 300.0, 37.56, 12, null);
            loanIdRef.set(loanId);

            disburseLoan(loanId, BigDecimal.valueOf(300.0), "20210213");

            verifyRepaymentSchedule(loanId, //
                    installment(300.0, null, "20210213"), //
                    installment(20.98, 9.39, 30.37, false, "20210313"), //
                    installment(21.64, 8.73, 30.37, false, "20210413"), //
                    installment(22.31, 8.06, 30.37, false, "20210513"), //
                    installment(23.01, 7.36, 30.37, false, "20210613"), //
                    installment(23.73, 6.64, 30.37, false, "20210713"), //
                    installment(24.48, 5.89, 30.37, false, "20210813"), //
                    installment(25.24, 5.13, 30.37, false, "20210913"), //
                    installment(26.03, 4.34, 30.37, false, "20211013"), //
                    installment(26.85, 3.52, 30.37, false, "20211113"), //
                    installment(27.69, 2.68, 30.37, false, "20211213"), //
                    installment(28.55, 1.82, 30.37, false, "20220113"), //
                    installment(29.49, 0.92, 30.41, false, "20220213") //
            );
            Long resourceId = makeLoanRepayment(loanId, "Repayment", "20210213", 100.0).getResourceId();
            reverseRepaymentIdRef.set(resourceId);

            makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210213", 300.0);

            verifyRepaymentSchedule(loanId, //
                    installment(300.0, null, "20210213"), //
                    installment(30.37, 0.0, 0.0, true, "20210313"), //
                    installment(30.37, 0.0, 0.0, true, "20210413"), //
                    installment(30.37, 0.0, 0.0, true, "20210513"), //
                    installment(30.37, 0.0, 0.0, true, "20210613"), //
                    installment(30.37, 0.0, 0.0, true, "20210713"), //
                    installment(30.37, 0.0, 0.0, true, "20210813"), //
                    installment(30.37, 0.0, 0.0, true, "20210913"), //
                    installment(30.37, 0.0, 0.0, true, "20211013"), //
                    installment(30.37, 0.0, 0.0, true, "20211113"), //
                    installment(26.67, 0.0, 0.0, true, "20211213"), //
                    installment(0.0, 0.0, 0.0, true, "20220113"), //
                    installment(0.0, 0.0, 0.0, true, "20220213") //
            );
            verifyTransactions(loanId, //
                    transaction(300.0, "Disbursement", "20210213", 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(100.0, "Repayment", "20210213", 200.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(300.0, "Merchant Issued Refund", "20210213", 0.0, 200.0, 0.0, 0.0, 0.0, 0.0, 100.0, false) //
            );

        });
        runAt("20210219", () -> {
            final Long loanId = loanIdRef.get();
            executeInlineCOB(loanId);
            makeLoanRepayment(loanId, "CreditBalanceRefund", "20210219", 100.0);
            verifyRepaymentSchedule(loanId, //
                    installment(300.0, null, "20210213"), //
                    installment(30.37, 0.0, 0.0, true, "20210313"), //
                    installment(30.37, 0.0, 0.0, true, "20210413"), //
                    installment(30.37, 0.0, 0.0, true, "20210513"), //
                    installment(30.37, 0.0, 0.0, true, "20210613"), //
                    installment(30.37, 0.0, 0.0, true, "20210713"), //
                    installment(30.37, 0.0, 0.0, true, "20210813"), //
                    installment(30.37, 0.0, 0.0, true, "20210913"), //
                    installment(30.37, 0.0, 0.0, true, "20211013"), //
                    installment(30.37, 0.0, 0.0, true, "20211113"), //
                    installment(26.67, 0.0, 0.0, true, "20211213"), //
                    installment(0.0, 0.0, 0.0, true, "20220113"), //
                    installment(0.0, 0.0, 0.0, true, "20220213") //
            );
            verifyTransactions(loanId, //
                    transaction(300.0, "Disbursement", "20210213", 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(100.0, "Repayment", "20210213", 200.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(300.0, "Merchant Issued Refund", "20210213", 0.0, 200.0, 0.0, 0.0, 0.0, 0.0, 100.0, false), //
                    transaction(100.0, "Credit Balance Refund", "20210219", 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 100.0, false) //
            );
        });
        runAt("20210223", () -> {
            final Long loanId = loanIdRef.get();
            executeInlineCOB(loanId);

            final Long reverseRepaymentId = reverseRepaymentIdRef.get();
            reverseLoanTransaction(loanId, reverseRepaymentId, "20210223");
            verifyRepaymentSchedule(loanId, //
                    installment(300.0, null, "20210213"), //
                    installment(130.37, 2.46, 102.46, false, "20210313"), //
                    installment(30.37, 0.0, 0.0, true, "20210413"), //
                    installment(30.37, 0.0, 0.0, true, "20210513"), //
                    installment(30.37, 0.0, 0.0, true, "20210613"), //
                    installment(30.37, 0.0, 0.0, true, "20210713"), //
                    installment(30.37, 0.0, 0.0, true, "20210813"), //
                    installment(30.37, 0.0, 0.0, true, "20210913"), //
                    installment(30.37, 0.0, 0.0, true, "20211013"), //
                    installment(30.37, 0.0, 0.0, true, "20211113"), //
                    installment(26.67, 0.0, 0.0, true, "20211213"), //
                    installment(0.0, 0.0, 0.0, true, "20220113"), //
                    installment(0.0, 0.0, 0.0, true, "20220213") //
            );
            verifyTransactions(loanId, //
                    transaction(300.0, "Disbursement", "20210213", 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(100.0, "Repayment", "20210213", 200.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0, true), //
                    transaction(300.0, "Merchant Issued Refund", "20210213", 0.0, 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(100.0, "Credit Balance Refund", "20210219", 100.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0, false) //
            );
        });
        runAt("20210224", () -> {
            final Long loanId = loanIdRef.get();
            executeInlineCOB(loanId);
            verifyTransactions(loanId, //
                    transaction(300.0, "Disbursement", "20210213", 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(100.0, "Repayment", "20210213", 200.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0, true), //
                    transaction(300.0, "Merchant Issued Refund", "20210213", 0.0, 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(100.0, "Credit Balance Refund", "20210219", 100.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(0.45, "Accrual", "20210223", 0.0, 0.0, 0.45, 0.0, 0.0, 0.0, 0.0, false) //
            );
        });
        runAt("20210228", () -> {
            final Long loanId = loanIdRef.get();
            executeInlineCOB(loanId);
            makeLoanRepayment(loanId, "Repayment", "20210228", 101.01);
            verifyRepaymentSchedule(loanId, //
                    installment(300.0, null, "20210213"), //
                    installment(130.37, 1.01, 0.0, true, "20210313"), //
                    installment(30.37, 0.0, 0.0, true, "20210413"), //
                    installment(30.37, 0.0, 0.0, true, "20210513"), //
                    installment(30.37, 0.0, 0.0, true, "20210613"), //
                    installment(30.37, 0.0, 0.0, true, "20210713"), //
                    installment(30.37, 0.0, 0.0, true, "20210813"), //
                    installment(30.37, 0.0, 0.0, true, "20210913"), //
                    installment(30.37, 0.0, 0.0, true, "20211013"), //
                    installment(30.37, 0.0, 0.0, true, "20211113"), //
                    installment(26.67, 0.0, 0.0, true, "20211213"), //
                    installment(0.0, 0.0, 0.0, true, "20220113"), //
                    installment(0.0, 0.0, 0.0, true, "20220213") //
            );
            verifyTransactions(loanId, //
                    transaction(300.0, "Disbursement", "20210213", 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(100.0, "Repayment", "20210213", 200.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0, true), //
                    transaction(300.0, "Merchant Issued Refund", "20210213", 0.0, 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(100.0, "Credit Balance Refund", "20210219", 100.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(0.45, "Accrual", "20210223", 0.0, 0.0, 0.45, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(0.11, "Accrual", "20210224", 0.0, 0.0, 0.11, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(0.11, "Accrual", "20210225", 0.0, 0.0, 0.11, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(0.11, "Accrual", "20210226", 0.0, 0.0, 0.11, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(0.11, "Accrual", "20210227", 0.0, 0.0, 0.11, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(101.01, "Repayment", "20210228", 0.0, 100.0, 1.01, 0.0, 0.0, 0.0, 0.0, false), //
                    transaction(0.12, "Accrual", "20210228", 0.0, 0.0, 0.12, 0.0, 0.0, 0.0, 0.0, false) //
            );
        });
    }
}
