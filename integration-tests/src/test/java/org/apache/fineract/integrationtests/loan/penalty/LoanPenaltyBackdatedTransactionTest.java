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
package org.apache.fineract.integrationtests.loan.penalty;

import java.math.BigDecimal;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;
import org.apache.fineract.client.models.LoanProductChargeData;
import org.apache.fineract.client.models.PostLoanProductsRequest;
import org.apache.fineract.client.models.PostLoanProductsResponse;
import org.apache.fineract.client.models.PostLoansLoanIdResponse;
import org.apache.fineract.client.models.PostLoansRequest;
import org.apache.fineract.client.models.PostLoansResponse;
import org.apache.fineract.client.models.PutGlobalConfigurationsRequest;
import org.apache.fineract.infrastructure.configuration.api.GlobalConfigurationConstants;
import org.apache.fineract.integrationtests.BaseLoanIntegrationTest;
import org.apache.fineract.integrationtests.common.ClientHelper;
import org.apache.fineract.integrationtests.common.charges.ChargesHelper;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class LoanPenaltyBackdatedTransactionTest extends BaseLoanIntegrationTest {

    @BeforeEach
    public void before() {
        PutGlobalConfigurationsRequest request = new PutGlobalConfigurationsRequest().value(0L).enabled(true);
        globalConfigurationHelper.updateGlobalConfiguration(GlobalConfigurationConstants.PENALTY_WAIT_PERIOD, request);
    }

    @AfterEach
    public void after() {
        // go back to defaults
        PutGlobalConfigurationsRequest request = new PutGlobalConfigurationsRequest().value(2L).enabled(true);
        globalConfigurationHelper.updateGlobalConfiguration(GlobalConfigurationConstants.PENALTY_WAIT_PERIOD, request);
    }

    @Test
    public void test_PenaltyRecalculationWorksForBackdatedTx_WhenCumulative_1() {
        AtomicReference<Long> aLoanId = new AtomicReference<>();

        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();

            int numberOfRepayments = 3;
            int repaymentEvery = 4;

            // Create charges
            double chargeAmount = 1.0;
            Long chargeId = createOverduePenaltyPercentageCharge(chargeAmount, ChargesHelper.CHARGE_FEE_FREQUENCY_DAYS, 1);

            // Create Loan Product
            PostLoanProductsRequest product = createOnePeriod30DaysLongNoInterestPeriodicAccrualProduct() //
                    .graceOnArrearsAgeing(0).numberOfRepayments(numberOfRepayments) //
                    .repaymentEvery(repaymentEvery) //
                    .installmentAmountInMultiplesOf(null) //
                    .repaymentFrequencyType(RepaymentFrequencyType.DAYS.longValue()) //
                    .interestType(InterestType.DECLINING_BALANCE)//
                    .interestCalculationPeriodType(InterestCalculationPeriodType.DAILY)//
                    .interestRecalculationCompoundingMethod(InterestRecalculationCompoundingMethod.NONE)//
                    .rescheduleStrategyMethod(RescheduleStrategyMethod.ADJUST_LAST_UNPAID_PERIOD)//
                    .isInterestRecalculationEnabled(true)//
                    .recalculationRestFrequencyInterval(1)//
                    .recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY)//
                    .rescheduleStrategyMethod(RescheduleStrategyMethod.REDUCE_EMI_AMOUNT)//
                    .allowPartialPeriodInterestCalculation(false)//
                    .disallowExpectedDisbursements(false)//
                    .allowApprovedDisbursedAmountsOverApplied(false)//
                    .overAppliedNumber(null)//
                    .overAppliedCalculationType(null)//
                    .multiDisburseLoan(null)//
                    .charges(List.of(new LoanProductChargeData().id(chargeId)));//

            PostLoanProductsResponse loanProductResponse = loanProductHelper.createLoanProduct(product);
            Long loanProductId = loanProductResponse.getResourceId();

            // Apply and Approve Loan
            double amount = 5000.0;

            PostLoansRequest applicationRequest = applyLoanRequest(clientId, loanProductId, "20230101", amount, numberOfRepayments)//
                    .repaymentEvery(repaymentEvery)//
                    .loanTermFrequency(numberOfRepayments * repaymentEvery)//
                    .repaymentFrequencyType(RepaymentFrequencyType.DAYS)//
                    .loanTermFrequencyType(RepaymentFrequencyType.DAYS)//
                    .interestType(InterestType.DECLINING_BALANCE)//
                    .interestCalculationPeriodType(InterestCalculationPeriodType.DAILY);

            PostLoansResponse postLoansResponse = loanTransactionHelper.applyLoan(applicationRequest);

            PostLoansLoanIdResponse approvedLoanResult = loanTransactionHelper.approveLoan(postLoansResponse.getResourceId(),
                    approveLoanRequest(amount, "20230101"));

            aLoanId.getAndSet(approvedLoanResult.getLoanId());
            Long loanId = aLoanId.get();

            // disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(5000.0), "20230101");

            // verify transactions
            verifyTransactions(loanId, //
                    transaction(5000.0, "Disbursement", "20230101") //
            );
        });

        runAt("20230109", () -> {
            Long loanId = aLoanId.get();
            // run accrual posting
            schedulerJobHelper.executeAndAwaitJob("Apply penalty to overdue loans");
            schedulerJobHelper.executeAndAwaitJob("Add Accrual Transactions");

            // verify transactions
            verifyTransactions(loanId, //
                    transaction(5000.0, "Disbursement", "20230101", 5000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0), //
                    transaction(16.67, "Accrual", "20230105", 0.0, 0.0, 0.0, 0.0, 16.67, 0.0, 0.0), //
                    transaction(50.01, "Accrual", "20230109", 0.0, 0.0, 0.0, 0.0, 50.01, 0.0, 0.0) //
            );

            // repay 1k
            addRepaymentForLoan(loanId, 1000.0, "20230107");

            // verify transactions
            verifyTransactions(loanId, //
                    transaction(5000.0, "Disbursement", "20230101", 5000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0), //
                    transaction(16.67, "Accrual", "20230105", 0.0, 0.0, 0.0, 0.0, 16.67, 0.0, 0.0), //
                    transaction(1000.0, "Repayment", "20230107", 4016.67, 983.33, 0.0, 0.0, 16.67, 0.0, 0.0), //
                    transaction(50.01, "Accrual", "20230109", 0.0, 0.0, 0.0, 0.0, 50.01, 0.0, 0.0) //
            );

            // reverse accruals
            deactivateOverdueLoanCharges(loanId, "20230107");

            // run accrual posting
            schedulerJobHelper.executeAndAwaitJob("Apply penalty to overdue loans");
            schedulerJobHelper.executeAndAwaitJob("Add Accrual Transactions");

            // verify transactions
            verifyTransactions(loanId, //
                    transaction(5000.0, "Disbursement", "20230101", 5000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0), //
                    transaction(16.67, "Accrual", "20230105", 0.0, 0.0, 0.0, 0.0, 16.67, 0.0, 0.0), //
                    transaction(1000.0, "Repayment", "20230107", 4016.67, 983.33, 0.0, 0.0, 16.67, 0.0, 0.0), //
                    transaction(50.01, "Accrual", "20230109", 0.0, 0.0, 0.0, 0.0, 50.01, 0.0, 0.0, true), //
                    transaction(30.33, "Accrual", "20230109", 0.0, 0.0, 0.0, 0.0, 30.33, 0.0, 0.0) //
            );
        });
    }

    @Test
    public void test_PenaltyRecalculationWorksForBackdatedTx_WhenCumulative_2() {
        AtomicReference<Long> aLoanId = new AtomicReference<>();

        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();

            int numberOfRepayments = 3;
            int repaymentEvery = 4;

            // Create charges
            double chargeAmount = 1.0;
            Long chargeId = createOverduePenaltyPercentageCharge(chargeAmount, ChargesHelper.CHARGE_FEE_FREQUENCY_DAYS, 1);

            // Create Loan Product
            PostLoanProductsRequest product = createOnePeriod30DaysLongNoInterestPeriodicAccrualProduct() //
                    .graceOnArrearsAgeing(0).numberOfRepayments(numberOfRepayments) //
                    .repaymentEvery(repaymentEvery) //
                    .installmentAmountInMultiplesOf(null) //
                    .repaymentFrequencyType(RepaymentFrequencyType.DAYS.longValue()) //
                    .interestType(InterestType.DECLINING_BALANCE)//
                    .interestCalculationPeriodType(InterestCalculationPeriodType.DAILY)//
                    .interestRecalculationCompoundingMethod(InterestRecalculationCompoundingMethod.NONE)//
                    .rescheduleStrategyMethod(RescheduleStrategyMethod.ADJUST_LAST_UNPAID_PERIOD)//
                    .isInterestRecalculationEnabled(true)//
                    .recalculationRestFrequencyInterval(1)//
                    .recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY)//
                    .rescheduleStrategyMethod(RescheduleStrategyMethod.REDUCE_EMI_AMOUNT)//
                    .allowPartialPeriodInterestCalculation(false)//
                    .disallowExpectedDisbursements(false)//
                    .allowApprovedDisbursedAmountsOverApplied(false)//
                    .overAppliedNumber(null)//
                    .overAppliedCalculationType(null)//
                    .multiDisburseLoan(null)//
                    .charges(List.of(new LoanProductChargeData().id(chargeId)));//

            PostLoanProductsResponse loanProductResponse = loanProductHelper.createLoanProduct(product);
            Long loanProductId = loanProductResponse.getResourceId();

            // Apply and Approve Loan
            double amount = 5000.0;

            PostLoansRequest applicationRequest = applyLoanRequest(clientId, loanProductId, "20230101", amount, numberOfRepayments)//
                    .repaymentEvery(repaymentEvery)//
                    .loanTermFrequency(numberOfRepayments * repaymentEvery)//
                    .repaymentFrequencyType(RepaymentFrequencyType.DAYS)//
                    .loanTermFrequencyType(RepaymentFrequencyType.DAYS)//
                    .interestType(InterestType.DECLINING_BALANCE)//
                    .interestCalculationPeriodType(InterestCalculationPeriodType.DAILY);

            PostLoansResponse postLoansResponse = loanTransactionHelper.applyLoan(applicationRequest);

            PostLoansLoanIdResponse approvedLoanResult = loanTransactionHelper.approveLoan(postLoansResponse.getResourceId(),
                    approveLoanRequest(amount, "20230101"));

            aLoanId.getAndSet(approvedLoanResult.getLoanId());
            Long loanId = aLoanId.get();

            // disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(5000.0), "20230101");

            // verify transactions
            verifyTransactions(loanId, //
                    transaction(5000.0, "Disbursement", "20230101") //
            );
        });

        runAt("20230109", () -> {
            Long loanId = aLoanId.get();

            // run accrual posting
            schedulerJobHelper.executeAndAwaitJob("Apply penalty to overdue loans");
            schedulerJobHelper.executeAndAwaitJob("Add Accrual Transactions");

            // verify transactions
            verifyTransactions(loanId, //
                    transaction(5000.0, "Disbursement", "20230101", 5000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0), //
                    transaction(16.67, "Accrual", "20230105", 0.0, 0.0, 0.0, 0.0, 16.67, 0.0, 0.0), //
                    transaction(50.01, "Accrual", "20230109", 0.0, 0.0, 0.0, 0.0, 50.01, 0.0, 0.0) //
            );

            // repay 1k
            addRepaymentForLoan(loanId, 1000.0, "20230107");

            // verify transactions
            verifyTransactions(loanId, //
                    transaction(5000.0, "Disbursement", "20230101", 5000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0), //
                    transaction(16.67, "Accrual", "20230105", 0.0, 0.0, 0.0, 0.0, 16.67, 0.0, 0.0), //
                    transaction(1000.0, "Repayment", "20230107", 4016.67, 983.33, 0.0, 0.0, 16.67, 0.0, 0.0), //
                    transaction(50.01, "Accrual", "20230109", 0.0, 0.0, 0.0, 0.0, 50.01, 0.0, 0.0) //
            );

            // reverse accruals
            deactivateOverdueLoanCharges(loanId, "20230105");

            // run accrual posting
            schedulerJobHelper.executeAndAwaitJob("Apply penalty to overdue loans");
            schedulerJobHelper.executeAndAwaitJob("Add Accrual Transactions");

            // verify transactions
            verifyTransactions(loanId, //
                    transaction(5000.0, "Disbursement", "20230101", 5000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0), //
                    transaction(16.67, "Accrual", "20230105", 0.0, 0.0, 0.0, 0.0, 16.67, 0.0, 0.0, true), //
                    transaction(6.83, "Accrual", "20230105", 0.0, 0.0, 0.0, 0.0, 6.83, 0.0, 0.0), //
                    transaction(1000.0, "Repayment", "20230107", 4006.83, 993.17, 0.0, 0.0, 6.83, 0.0, 0.0), //
                    transaction(50.01, "Accrual", "20230109", 0.0, 0.0, 0.0, 0.0, 50.01, 0.0, 0.0, true), //
                    transaction(20.49, "Accrual", "20230109", 0.0, 0.0, 0.0, 0.0, 20.49, 0.0, 0.0) //
            );
        });
    }

    @Test
    public void test_PenaltyRecalculationWorksForBackdatedTx_WhenCumulative_3() {
        AtomicReference<Long> aLoanId = new AtomicReference<>();

        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();

            int numberOfRepayments = 3;
            int repaymentEvery = 4;

            // Create charges
            double chargeAmount = 1.0;
            Long chargeId = createOverduePenaltyPercentageCharge(chargeAmount, ChargesHelper.CHARGE_FEE_FREQUENCY_DAYS, 1);

            // Create Loan Product
            PostLoanProductsRequest product = createOnePeriod30DaysLongNoInterestPeriodicAccrualProduct() //
                    .graceOnArrearsAgeing(0).numberOfRepayments(numberOfRepayments) //
                    .repaymentEvery(repaymentEvery) //
                    .installmentAmountInMultiplesOf(null) //
                    .repaymentFrequencyType(RepaymentFrequencyType.DAYS.longValue()) //
                    .interestType(InterestType.DECLINING_BALANCE)//
                    .interestCalculationPeriodType(InterestCalculationPeriodType.DAILY)//
                    .interestRecalculationCompoundingMethod(InterestRecalculationCompoundingMethod.NONE)//
                    .rescheduleStrategyMethod(RescheduleStrategyMethod.ADJUST_LAST_UNPAID_PERIOD)//
                    .isInterestRecalculationEnabled(true)//
                    .recalculationRestFrequencyInterval(1)//
                    .recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY)//
                    .rescheduleStrategyMethod(RescheduleStrategyMethod.REDUCE_EMI_AMOUNT)//
                    .allowPartialPeriodInterestCalculation(false)//
                    .disallowExpectedDisbursements(false)//
                    .allowApprovedDisbursedAmountsOverApplied(false)//
                    .overAppliedNumber(null)//
                    .overAppliedCalculationType(null)//
                    .multiDisburseLoan(null)//
                    .charges(List.of(new LoanProductChargeData().id(chargeId)));//

            PostLoanProductsResponse loanProductResponse = loanProductHelper.createLoanProduct(product);
            Long loanProductId = loanProductResponse.getResourceId();

            // Apply and Approve Loan
            double amount = 5000.0;

            PostLoansRequest applicationRequest = applyLoanRequest(clientId, loanProductId, "20230101", amount, numberOfRepayments)//
                    .repaymentEvery(repaymentEvery)//
                    .loanTermFrequency(numberOfRepayments * repaymentEvery)//
                    .repaymentFrequencyType(RepaymentFrequencyType.DAYS)//
                    .loanTermFrequencyType(RepaymentFrequencyType.DAYS)//
                    .interestType(InterestType.DECLINING_BALANCE)//
                    .interestCalculationPeriodType(InterestCalculationPeriodType.DAILY);

            PostLoansResponse postLoansResponse = loanTransactionHelper.applyLoan(applicationRequest);

            PostLoansLoanIdResponse approvedLoanResult = loanTransactionHelper.approveLoan(postLoansResponse.getResourceId(),
                    approveLoanRequest(amount, "20230101"));

            aLoanId.getAndSet(approvedLoanResult.getLoanId());
            Long loanId = aLoanId.get();

            // disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(5000.0), "20230101");

            // verify transactions
            verifyTransactions(loanId, //
                    transaction(5000.0, "Disbursement", "20230101") //
            );
        });

        runAt("20230109", () -> {
            Long loanId = aLoanId.get();

            // run accrual posting
            schedulerJobHelper.executeAndAwaitJob("Apply penalty to overdue loans");
            schedulerJobHelper.executeAndAwaitJob("Add Accrual Transactions");

            // verify transactions
            verifyTransactions(loanId, //
                    transaction(5000.0, "Disbursement", "20230101", 5000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0), //
                    transaction(16.67, "Accrual", "20230105", 0.0, 0.0, 0.0, 0.0, 16.67, 0.0, 0.0), //
                    transaction(50.01, "Accrual", "20230109", 0.0, 0.0, 0.0, 0.0, 50.01, 0.0, 0.0) //
            );

            // repay 1k
            addRepaymentForLoan(loanId, 1000.0, "20230107");

            // verify transactions
            verifyTransactions(loanId, //
                    transaction(5000.0, "Disbursement", "20230101", 5000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0), //
                    transaction(16.67, "Accrual", "20230105", 0.0, 0.0, 0.0, 0.0, 16.67, 0.0, 0.0), //
                    transaction(1000.0, "Repayment", "20230107", 4016.67, 983.33, 0.0, 0.0, 16.67, 0.0, 0.0), //
                    transaction(50.01, "Accrual", "20230109", 0.0, 0.0, 0.0, 0.0, 50.01, 0.0, 0.0) //
            );

            // reverse accruals
            deactivateOverdueLoanCharges(loanId, "20230107");

            // run accrual posting
            schedulerJobHelper.executeAndAwaitJob("Apply penalty to overdue loans");
            schedulerJobHelper.executeAndAwaitJob("Add Accrual Transactions");

            // verify transactions
            verifyTransactions(loanId, //
                    transaction(5000.0, "Disbursement", "20230101", 5000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0), //
                    transaction(16.67, "Accrual", "20230105", 0.0, 0.0, 0.0, 0.0, 16.67, 0.0, 0.0), //
                    transaction(1000.0, "Repayment", "20230107", 4016.67, 983.33, 0.0, 0.0, 16.67, 0.0, 0.0), //
                    transaction(50.01, "Accrual", "20230109", 0.0, 0.0, 0.0, 0.0, 50.01, 0.0, 0.0, true), //
                    transaction(30.33, "Accrual", "20230109", 0.0, 0.0, 0.0, 0.0, 30.33, 0.0, 0.0) //
            );
        });

        runAt("20230110", () -> {
            Long loanId = aLoanId.get();

            // repay 1k
            addRepaymentForLoan(loanId, 1000.0, "20230110");

            // verify transactions
            verifyTransactions(loanId, //
                    transaction(5000.0, "Disbursement", "20230101", 5000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0), //
                    transaction(16.67, "Accrual", "20230105", 0.0, 0.0, 0.0, 0.0, 16.67, 0.0, 0.0), //
                    transaction(1000.0, "Repayment", "20230107", 4016.67, 983.33, 0.0, 0.0, 16.67, 0.0, 0.0), //
                    transaction(50.01, "Accrual", "20230109", 0.0, 0.0, 0.0, 0.0, 50.01, 0.0, 0.0, true), //
                    transaction(30.33, "Accrual", "20230109", 0.0, 0.0, 0.0, 0.0, 30.33, 0.0, 0.0), //
                    transaction(1000.0, "Repayment", "20230110", 3047.0, 969.67, 0.0, 0.0, 30.33, 0.0, 0.0) //
            );
        });
    }
}
