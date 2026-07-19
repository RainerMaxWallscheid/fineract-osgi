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
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.google.common.collect.Streams;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Objects;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Stream;
import org.apache.fineract.client.feign.util.CallFailedRuntimeException;
import org.apache.fineract.client.models.GetLoansLoanIdLoanChargePaidByData;
import org.apache.fineract.client.models.GetLoansLoanIdResponse;
import org.apache.fineract.client.models.PostChargesResponse;
import org.apache.fineract.client.models.PostLoanProductsRequest;
import org.apache.fineract.client.models.PostLoansLoanIdChargesResponse;
import org.apache.fineract.client.models.PostLoansRequest;
import org.apache.fineract.integrationtests.client.feign.FeignLoanTestBase;
import org.apache.fineract.integrationtests.client.feign.modules.LoanRequestBuilders;
import org.apache.fineract.integrationtests.common.ClientHelper;
import org.apache.fineract.integrationtests.common.loans.LoanProductTestBuilder;
import org.junit.jupiter.api.Named;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;

public class LoanWaiveChargeTest extends FeignLoanTestBase {

    private static Stream<Arguments> processingStrategy() {
        return Stream.of(Arguments.of(Named.of("originalStrategy", false)), //
                Arguments.of(Named.of("advancedStrategy", true)));
    }

    @ParameterizedTest
    @MethodSource("processingStrategy")
    public void test_LoanPaidByDateIsCorrect_WhenNPlusOneInstallmentCharge_IsWaived(boolean advancedPaymentStrategy) {
        double amount = 1000.0;
        AtomicLong appliedLoanId = new AtomicLong();

        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();

            // Create Loan Product
            PostLoanProductsRequest product;
            if (advancedPaymentStrategy) {
                product = createOnePeriod30DaysLongNoInterestPeriodicAccrualProductWithAdvancedPaymentAllocation();
            } else {
                product = createOnePeriod30DaysLongNoInterestPeriodicAccrualProduct();
            }

            Long loanProductId = createLoanProduct(product);

            // Apply and Approve Loan

            PostLoansRequest applicationRequest = applyLoanRequest(clientId, loanProductId, "20230101", amount, 1);
            if (advancedPaymentStrategy) {
                applicationRequest = applicationRequest
                        .transactionProcessingStrategyCode(LoanProductTestBuilder.ADVANCED_PAYMENT_ALLOCATION_STRATEGY);
            }

            Long loanId = applyForLoan(applicationRequest);

            approveLoan(loanId, approveLoanRequest(amount, "20230101"));
            appliedLoanId.set(loanId);

            // disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(amount), "20230101");

            // verify schedule
            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230101"), //
                    installment(1000.0, 0.0, 0.0, 1000.0, false, "20230131"));
        });
        runAt("20230202", () -> {
            Long loanId = appliedLoanId.get();

            // create charge
            double chargeAmount = 100.0;
            PostChargesResponse chargeResult = createCharge(chargeAmount);
            Long chargeId = chargeResult.getResourceId();

            // add charge after maturity
            PostLoansLoanIdChargesResponse loanChargeResult = addLoanCharge(loanId, chargeId, "20230201", chargeAmount);
            Long loanChargeId = loanChargeResult.getResourceId();

            // verify N+1 installment in schedule
            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230101"), //
                    installment(1000.0, 0.0, 0.0, 1000.0, false, "20230131"), //
                    installment(0.0, 0.0, 100.0, 100.0, false, "20230201") //
            );

            // waive charge
            waiveLoanCharge(loanId, loanChargeId, 2);
        });
        runAt("20230203", () -> {
            Long loanId = appliedLoanId.get();

            // repay loan
            addRepaymentForLoan(loanId, amount, "20230203");

            // verify maturity
            GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
            assertTrue(loanDetails.getStatus().getClosedObligationsMet());

            // verify N+1 installment completion
            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230101"), //
                    installment(1000.0, 0.0, 0.0, 0.0, true, "20230131"), //
                    installment(0.0, 0.0, 100.0, 0.0, true, "20230201") //
            );

            // verify obligationsMetOnDate for N+1 installment
            LocalDate obligationsMetOnDate = Streams.findLast(loanDetails.getRepaymentSchedule().getPeriods().stream()).get()
                    .getObligationsMetOnDate();
            LocalDate expected = LocalDate.of(2023, 2, 1);
            assertEquals(expected, obligationsMetOnDate);
        });
    }

    @ParameterizedTest
    @MethodSource("processingStrategy")
    public void accrualIsCalculatedWhenThereIsWaivedChargeAndLoanIsClosed(boolean advancedPaymentStrategy) {
        double amount = 1000.0;
        AtomicLong appliedLoanId = new AtomicLong();
        String LoanCoBJobName = "Loan COB";

        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();

            // Create Loan Product
            PostLoanProductsRequest product;
            if (advancedPaymentStrategy) {
                product = createOnePeriod30DaysLongNoInterestPeriodicAccrualProductWithAdvancedPaymentAllocation();
            } else {
                product = createOnePeriod30DaysLongNoInterestPeriodicAccrualProduct();
            }

            Long loanProductId = createLoanProduct(product);

            // Apply and Approve Loan

            PostLoansRequest applicationRequest = applyLoanRequest(clientId, loanProductId, "20230101", amount, 1);
            if (advancedPaymentStrategy) {
                applicationRequest = applicationRequest
                        .transactionProcessingStrategyCode(LoanProductTestBuilder.ADVANCED_PAYMENT_ALLOCATION_STRATEGY);
            }

            Long loanId = applyForLoan(applicationRequest);

            approveLoan(loanId, approveLoanRequest(amount, "20230101"));
            appliedLoanId.set(loanId);

            // disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(amount), "20230101");

            // verify schedule
            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230101"), //
                    installment(1000.0, 0.0, 0.0, 1000.0, false, "20230131"));
        });

        runAt("20230110", () -> {
            Long loanId = appliedLoanId.get();

            // create charge
            double chargeAmount = 10.0;
            PostChargesResponse chargeResult = createCharge(chargeAmount);
            Long chargeId = chargeResult.getResourceId();

            PostLoansLoanIdChargesResponse loanChargeResult = addLoanCharge(loanId, chargeId, "20230109", chargeAmount);
            loanChargeResult.getResourceId();
            schedulerHelper.executeAndAwaitJob(LoanCoBJobName);

            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230101"), //
                    installment(1000.0, 0.0, 10.0, 1010.0, false, "20230131") //

            );
            verifyTransactions(loanId, //
                    transaction(1000.0, "Disbursement", "20230101", 1000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0), //
                    transaction(10.0, "Accrual", "20230109", 0.0, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0));
        });
        runAt("20230111", () -> {
            Long loanId = appliedLoanId.get();

            // create charge
            double chargeAmount = 9.0;
            PostChargesResponse chargeResult = createCharge(chargeAmount);
            Long chargeId = chargeResult.getResourceId();

            PostLoansLoanIdChargesResponse loanChargeResult = addLoanCharge(loanId, chargeId, "20230110", chargeAmount);
            Long loanChargeId = loanChargeResult.getResourceId();
            schedulerHelper.executeAndAwaitJob(LoanCoBJobName);
            // waive charge
            waiveLoanCharge(loanId, loanChargeId, 1);

            verifyTransactions(loanId, //
                    transaction(1000.0, "Disbursement", "20230101", 1000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0), //
                    transaction(10.0, "Accrual", "20230109", 0.0, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0), //
                    transaction(9.0, "Accrual", "20230110", 0.0, 0.0, 0.0, 9.0, 0.0, 0.0, 0.0), //
                    transaction(9.0, "Waive loan charges", "20230110", 1000.0, 0.0, 0.0, 9.0, 0.0, 0.0, 0.0) //
            );

            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230101"), //
                    installment(1000.0, 0.0, 19.0, 1010.0, false, "20230131") //
            );
        });

        runAt("20230112", () -> {
            Long loanId = appliedLoanId.get();

            // create charge
            double chargeAmount = 8.0;
            PostChargesResponse chargeResult = createCharge(chargeAmount);
            Long chargeId = chargeResult.getResourceId();

            PostLoansLoanIdChargesResponse loanChargeResult = addLoanCharge(loanId, chargeId, "20230111", chargeAmount);
            loanChargeResult.getResourceId();

            addRepayment(loanId, LoanRequestBuilders.repayLoan(1018.0, "20230112"));

            verifyTransactions(loanId, //
                    transaction(1000.0, "Disbursement", "20230101", 1000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0), //
                    transaction(10.0, "Accrual", "20230109", 0.0, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0), //
                    transaction(9.0, "Accrual", "20230110", 0.0, 0.0, 0.0, 9.0, 0.0, 0.0, 0.0), //
                    transaction(9.0, "Waive loan charges", "20230110", 1000.0, 0.0, 0.0, 9.0, 0.0, 0.0, 0.0), //
                    transaction(1018.0, "Repayment", "20230112", 0.0, 1000.0, 0.0, 18.0, 0.0, 0.0, 0.0), //
                    transaction(8.0, "Accrual", "20230112", 0.0, 0.0, 0.0, 8.0, 0.0, 0.0, 0.0) //
            );

            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230101"), //
                    installment(1000.0, 0.0, 27.0, 0.0, true, "20230131") //
            );
        });

    }

    @Test
    public void testLoanCannotBeChargedOffWhenUndoingFeeWaiver() {
        double amount = 1000.0;
        AtomicLong appliedLoanId = new AtomicLong();

        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();

            // Create Loan Product
            PostLoanProductsRequest product = create4IProgressive();
            Long loanProductId = createLoanProduct(product);

            // Apply and Approve Loan
            Long loanId = applyAndApproveProgressiveLoan(clientId, loanProductId, "20230101", amount, 9.9, 4, null);
            appliedLoanId.set(loanId);

            // disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(amount), "20230101");
        });
        runAt("20230123", () -> {
            // create charge
            double chargeAmount = 5.0;
            PostChargesResponse chargeResult = createCharge(chargeAmount, "EUR");
            Long chargeId = chargeResult.getResourceId();

            PostLoansLoanIdChargesResponse loanChargeResult = addLoanCharge(appliedLoanId.get(), chargeId, "20230123", chargeAmount);
            long loanChargeId = loanChargeResult.getResourceId();

            // waive charge
            waiveLoanCharge(appliedLoanId.get(), loanChargeId, 1);

            GetLoansLoanIdResponse loanDetails = getLoanDetails(appliedLoanId.get());
            Optional<GetLoansLoanIdLoanChargePaidByData> chargeData = loanDetails.getTransactions().stream()
                    .flatMap(t -> t.getLoanChargePaidByList().stream()).filter(t -> Objects.equals(loanChargeId, t.getChargeId()))
                    .findAny();

            reverseLoanTransaction(appliedLoanId.get(), chargeData.get().getTransactionId(), "20230123");
            CallFailedRuntimeException callFailedRuntimeException = assertThrows(CallFailedRuntimeException.class,
                    () -> chargeOffLoan(appliedLoanId.get(), "20230105"));
            assertTrue(callFailedRuntimeException.getMessage().contains("error.msg.loan.monetary.transactions.after.charge.off"));
        });
    }
}
