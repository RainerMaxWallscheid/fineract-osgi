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
import java.util.concurrent.atomic.AtomicReference;
import org.apache.fineract.client.feign.util.CallFailedRuntimeException;
import org.apache.fineract.client.models.GetLoansLoanIdResponse;
import org.apache.fineract.client.models.PostLoansLoanIdRequest;
import org.apache.fineract.integrationtests.client.feign.FeignLoanTestBase;
import org.apache.fineract.integrationtests.common.Utils;
import org.apache.fineract.integrationtests.common.loans.LoanProductTestBuilder;
import org.apache.fineract.portfolio.loanaccount.loanschedule.domain.LoanScheduleType;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class LoanContractTerminationTest extends FeignLoanTestBase {

    @Test
    public void testLoanContractTermination() {
        final AtomicReference<Long> loanIdRef = new AtomicReference<>();

        final Long clientId = createClient();

        final Long loanProductId = createLoanProduct(create4IProgressive());

        runAt("20240101", () -> {
            Long loanId = applyAndApproveProgressiveLoan(clientId, loanProductId, "20240101", 500.0, 7.0, 6, null);
            loanIdRef.set(loanId);

            disburseLoan(loanId, BigDecimal.valueOf(100), "20240101");
        });

        runAt("20240202", () -> {
            Long loanId = loanIdRef.get();
            executeInlineCOB(loanId);
        });

        runAt("20240203", () -> {
            Long loanId = loanIdRef.get();

            moveLoanState(loanId,
                    new PostLoansLoanIdRequest().note("Contract Termination Test").externalId(Utils.randomStringGenerator("", 20)),
                    "contractTermination");

            verifyTransactions(loanId, //
                    transaction(100.0, "Disbursement", "20240101"), //
                    transaction(0.58, "Accrual", "20240201"), //
                    transaction(100.62, "Contract Termination", "20240203"), //
                    transaction(0.04, "Accrual", "20240203") //
            );
        });
    }

    @Test
    public void testNegativeLoanContractTerminationInNoActiveLoan() {
        final AtomicReference<Long> loanIdRef = new AtomicReference<>();

        final Long clientId = createClient();

        final Long loanProductId = createLoanProduct(create4IProgressive());

        runAt("20240101", () -> {
            Long loanId = applyAndApproveProgressiveLoan(clientId, loanProductId, "20240101", 500.0, 7.0, 3, null);
            loanIdRef.set(loanId);

            CallFailedRuntimeException callFailedRuntimeException = Assertions.assertThrows(CallFailedRuntimeException.class,
                    () -> moveLoanState(loanId,
                            new PostLoansLoanIdRequest().note("Contract Termination Test").externalId(Utils.randomStringGenerator("", 20)),
                            "contractTermination"));

            Assertions.assertTrue(callFailedRuntimeException.getMessage()
                    .contains("Contract termination can not be applied, Loan Account is not Active"));
        });
    }

    @Test
    public void testNegativeLoanContractTerminationInNoProgressiveLoan() {
        final AtomicReference<Long> loanIdRef = new AtomicReference<>();

        final Long clientId = createClient();

        final Long loanProductId = createLoanProduct(
                createOnePeriod30DaysPeriodicAccrualProduct(12.4).transactionProcessingStrategyCode(LoanProductTestBuilder.DEFAULT_STRATEGY)
                        .loanScheduleType(LoanScheduleType.CUMULATIVE.toString()));

        runAt("20240101", () -> {
            final Long loanId = applyAndApproveLoan(clientId, loanProductId, "20240101", 100.0, 6);

            disburseLoan(loanId, BigDecimal.valueOf(100), "20240101");

            CallFailedRuntimeException callFailedRuntimeException = Assertions.assertThrows(CallFailedRuntimeException.class,
                    () -> moveLoanState(loanId,
                            new PostLoansLoanIdRequest().note("Contract Termination Test").externalId(Utils.randomStringGenerator("", 20)),
                            "contractTermination"));

            Assertions.assertTrue(callFailedRuntimeException.getMessage()
                    .contains("Contract termination can not be applied, Loan product schedule type is not Progressive"));
        });
    }

    @Test
    public void testLoanContractTerminationSameDisbursementDate() {
        final Long clientId = createClient();

        runAt("20240101", () -> {

            Long loanProductId = createLoanProduct(create4IProgressive().interestRecognitionOnDisbursementDate(false));
            Long loanId = applyAndApproveProgressiveLoan(clientId, loanProductId, "20240101", 500.0, 7.0, 6,
                    (request) -> request.interestRecognitionOnDisbursementDate(false));

            disburseLoan(loanId, BigDecimal.valueOf(100), "20240101");

            moveLoanState(loanId,
                    new PostLoansLoanIdRequest().note("Contract Termination Test").externalId(Utils.randomStringGenerator("", 20)),
                    "contractTermination");

            verifyTransactions(loanId, //
                    transaction(100.0, "Disbursement", "20240101"), //
                    transaction(100.0, "Contract Termination", "20240101"));

            GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
            assertEquals(BigDecimal.ZERO.stripTrailingZeros(), loanDetails.getSummary().getInterestCharged().stripTrailingZeros());
        });
    }

}
