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

import java.util.List;
import java.util.concurrent.atomic.AtomicReference;
import org.apache.fineract.integrationtests.client.feign.FeignLoanTestBase;
import org.apache.fineract.integrationtests.client.feign.modules.LoanRequestBuilders;
import org.apache.fineract.integrationtests.client.feign.modules.LoanTestData;
import org.junit.jupiter.api.Test;

public class ProgressiveLoanTransactionProcessorNextLastTest extends FeignLoanTestBase {

    private final Long clientId = createClient();

    @Test
    public void testPartialEarlyRepaymentWithNextLast() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20240101", () -> {
            Long progressiveLoanInterestRecalculationNextLastId = createLoanProduct(
                    create4IProgressive().isInterestRecalculationEnabled(true).loanScheduleProcessingType("HORIZONTAL")
                            .paymentAllocation(List.of(LoanRequestBuilders.paymentAllocation("DEFAULT",
                                    LoanTestData.FuturePaymentAllocationRule.NEXT_LAST_INSTALLMENT))));
            Long loanId = applyAndApproveProgressiveLoan(clientId, progressiveLoanInterestRecalculationNextLastId, "20240101", 100.0,
                    65.7, 6, null);
            loanIdRef.set(loanId);

            disburseLoan(loanId, "20240101", 100.0);
            verifyRepaymentSchedule(loanId, installment(100.0, null, "20240101"),
                    installment(14.52, 5.48, 20.0, false, "20240201"), //
                    installment(15.32, 4.68, 20.0, false, "20240301"), //
                    installment(16.16, 3.84, 20.0, false, "20240401"), //
                    installment(17.04, 2.96, 20.0, false, "20240501"), //
                    installment(17.98, 2.02, 20.0, false, "20240601"), //
                    installment(18.98, 1.04, 20.02, false, "20240701"));

            // should pay to first installment - edge case coming from implementation
            makeLoanRepayment(loanId, "Repayment", "20240101", 5.0);
            verifyRepaymentSchedule(loanId, installment(100.0, null, "20240101"), //
                    installment(14.8, 5.2, 15.0, false, "20240201"), //
                    installment(15.34, 4.66, 20.0, false, "20240301"), //
                    installment(16.18, 3.82, 20.0, false, "20240401"), //
                    installment(17.06, 2.94, 20.0, false, "20240501"), //
                    installment(18.0, 2.0, 20.0, false, "20240601"), //
                    installment(18.62, 1.02, 19.64, false, "20240701"));
        });
        runAt("20240131", () -> {
            Long loanId = loanIdRef.get();

            // test the repayment before the due date. Should go to 1st installment.
            makeLoanRepayment(loanId, "Repayment", "20240131", 4.0);
            verifyRepaymentSchedule(loanId, installment(100.0, null, "20240101"), //
                    installment(14.81, 5.19, 11.0, false, "20240201"), //
                    installment(15.34, 4.66, 20.0, false, "20240301"), //
                    installment(16.18, 3.82, 20.0, false, "20240401"), //
                    installment(17.06, 2.94, 20.0, false, "20240501"), //
                    installment(18.0, 2.0, 20.0, false, "20240601"), //
                    installment(18.61, 1.02, 19.63, false, "20240701"));

            // test the repayment before the due date. Should go to 1st installment, and rest to last installment.
            makeLoanRepayment(loanId, "Repayment", "20240131", 20.0);
            verifyRepaymentSchedule(loanId, installment(100.0, null, "20240101"),
                    installment(14.97, 5.03, 0.0, true, "20240201"), installment(15.7, 4.3, 20.0, false, "20240301"),
                    installment(16.7, 3.3, 20.0, false, "20240401"), installment(17.61, 2.39, 20.0, false, "20240501"),
                    installment(18.58, 1.42, 20.0, false, "20240601"), installment(16.44, 0.41, 7.85, false, "20240701"));
        });
        runAt("20240301", () -> {
            Long loanId = loanIdRef.get();
            // test repayment on due date. should repay 2nd installment normally and rest should go to last installment.
            makeLoanRepayment(loanId, "Repayment", "20240301", 26.0);
            verifyRepaymentSchedule(loanId, installment(100.0, null, "20240101"),
                    installment(14.97, 5.03, 0.0, true, "20240201"), installment(15.7, 4.3, 0.0, true, "20240301"),
                    installment(17.03, 2.97, 14.0, false, "20240401"), installment(17.63, 2.37, 20.0, false, "20240501"),
                    installment(18.59, 1.41, 20.0, false, "20240601"), installment(16.08, 0.39, 7.47, false, "20240701"));
        });
        runAt("20240302", () -> {
            Long loanId = loanIdRef.get();
            // verify multiple partial repayment for "current" installment
            makeLoanRepayment(loanId, "Repayment", "20240302", 7.0);
            verifyRepaymentSchedule(loanId, installment(100.0, null, "20240101"),
                    installment(14.97, 5.03, 0.0, true, "20240201"), installment(15.7, 4.3, 0.0, true, "20240301"),
                    installment(17.4, 2.6, 7.0, false, "20240401"), installment(17.65, 2.35, 20.0, false, "20240501"),
                    installment(18.62, 1.38, 20.0, false, "20240601"), installment(15.66, 0.36, 7.02, false, "20240701"));
            // verify multiple partial repayment for "current" installment
            makeLoanRepayment(loanId, "Repayment", "20240302", 7.0);
            verifyRepaymentSchedule(loanId, installment(100.0, null, "20240101"),
                    installment(14.97, 5.03, 0.0, true, "20240201"), installment(15.7, 4.3, 0.0, true, "20240301"),
                    installment(19.9, 0.1, 0.0, true, "20240401"), installment(15.65, 4.35, 20.0, false, "20240501"),
                    installment(18.64, 1.36, 20.0, false, "20240601"), installment(15.14, 0.34, 6.48, false, "20240701"));
            // verify next then last installment logic.
            makeLoanRepayment(loanId, "Repayment", "20240302", 22.0);
            verifyRepaymentSchedule(loanId, installment(100.0, null, "20240101"),
                    installment(14.97, 5.03, 0.0, true, "20240201"), installment(15.7, 4.3, 0.0, true, "20240301"),
                    installment(19.9, 0.1, 0.0, true, "20240401"), installment(18.02, 1.98, 20.0, false, "20240501"),
                    installment(11.41, 0.02, 0.43, false, "20240601"), installment(20.0, 0.0, 0.0, true, "20240701"));
            // verify last installment logic.
            makeLoanRepayment(loanId, "Repayment", "20240302", 22.0);
            verifyRepaymentSchedule(loanId, installment(100.0, null, "20240101"),
                    installment(14.97, 5.03, 0.0, true, "20240201"), installment(15.7, 4.3, 0.0, true, "20240301"),
                    installment(19.9, 0.1, 0.0, true, "20240401"), installment(9.43, 0.0, 0.0, true, "20240501"),
                    installment(20.0, 0.0, 0.0, true, "20240601"), installment(20.0, 0.0, 0.0, true, "20240701"));
        });
    }

}
