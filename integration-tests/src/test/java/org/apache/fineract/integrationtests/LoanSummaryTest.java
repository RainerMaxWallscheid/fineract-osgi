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
import java.math.RoundingMode;
import java.util.List;
import org.apache.fineract.client.models.GetLoansLoanIdRepaymentPeriod;
import org.apache.fineract.client.models.GetLoansLoanIdResponse;
import org.apache.fineract.client.models.PostLoanProductsResponse;
import org.apache.fineract.client.models.PostLoansResponse;
import org.apache.fineract.integrationtests.common.BusinessStepHelper;
import org.apache.fineract.integrationtests.common.ClientHelper;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

public class LoanSummaryTest extends BaseLoanIntegrationTest {

    private static BusinessStepHelper.BusinessStepsSnapshot originalConfig;
    private static final BusinessStepHelper businessStepHelper = new BusinessStepHelper();
    Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
    Long loanId;

    @BeforeAll
    static void setup() {
        originalConfig = businessStepHelper.getConfigurationSnapshot("LOAN_CLOSE_OF_BUSINESS");
    }

    @AfterAll
    public static void teardown() {
        originalConfig.restore();
    }

    @Test
    public void testUnpaidPayableNotDueInterestForProgressiveLoanInCaseOfEarlyRepayment() {
        businessStepHelper.updateSteps("LOAN_CLOSE_OF_BUSINESS", "ADD_PERIODIC_ACCRUAL_ENTRIES", "LOAN_INTEREST_RECALCULATION");
        runAt("20240101", () -> {
            final PostLoanProductsResponse loanProductsResponse = loanProductHelper.createLoanProduct(create4IProgressive());
            PostLoansResponse postLoansResponse = loanTransactionHelper.applyLoan(applyLP2ProgressiveLoanRequest(clientId,
                    loanProductsResponse.getResourceId(), "20240101", 1000.0, 9.99, 6, null));
            loanId = postLoansResponse.getLoanId();
            loanTransactionHelper.approveLoan(loanId, approveLoanRequest(1000.0, "20240101"));
            disburseLoan(loanId, BigDecimal.valueOf(250.0), "20240101");
        });
        runAt("20240107", () -> {
            disburseLoan(loanId, BigDecimal.valueOf(350.0), "20240104");
            disburseLoan(loanId, BigDecimal.valueOf(400.0), "20240105");
        });
        runAt("20240115", () -> {
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertEquals(BigDecimal.valueOf(3.05),
                    loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros());
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20240115", 171.43);
            loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertEquals(BigDecimal.ZERO, loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros());
        });
        runAt("20240116", () -> {
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertEquals(BigDecimal.valueOf(0.22),
                    loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros());
            verifyTransactions(loanId, transaction(250.0, "Disbursement", "20240101"),
                    transaction(350.0, "Disbursement", "20240104"), transaction(400.0, "Disbursement", "20240105"),
                    transaction(2.78, "Accrual", "20240114"), transaction(171.43, "Repayment", "20240115"),
                    transaction(0.27, "Accrual", "20240115"));
        });
        runAt("20240117", () -> {
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertEquals(BigDecimal.valueOf(0.44),
                    loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros());
            verifyTransactions(loanId, transaction(250.0, "Disbursement", "20240101"),
                    transaction(350.0, "Disbursement", "20240104"), transaction(400.0, "Disbursement", "20240105"),
                    transaction(2.78, "Accrual", "20240114"), transaction(171.43, "Repayment", "20240115"),
                    transaction(0.27, "Accrual", "20240115"), transaction(0.22, "Accrual", "20240116"));
        });
        runAt("20240118", () -> {
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertEquals(BigDecimal.valueOf(0.67),
                    loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros());
            verifyTransactions(loanId, transaction(250.0, "Disbursement", "20240101"),
                    transaction(350.0, "Disbursement", "20240104"), transaction(400.0, "Disbursement", "20240105"),
                    transaction(2.78, "Accrual", "20240114"), transaction(171.43, "Repayment", "20240115"),
                    transaction(0.27, "Accrual", "20240115"), transaction(0.22, "Accrual", "20240116"),
                    transaction(0.22, "Accrual", "20240117"));
        });
        runAt("20240119", () -> {
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
            verifyTransactions(loanId, transaction(250.0, "Disbursement", "20240101"),
                    transaction(350.0, "Disbursement", "20240104"), transaction(400.0, "Disbursement", "20240105"),
                    transaction(2.78, "Accrual", "20240114"), transaction(171.43, "Repayment", "20240115"),
                    transaction(0.27, "Accrual", "20240115"), transaction(0.22, "Accrual", "20240116"),
                    transaction(0.22, "Accrual", "20240117"), transaction(0.23, "Accrual", "20240118"));
        });
    }

    @Test
    public void testUnpaidPayableNotDueInterestForProgressiveLoanInCaseOfEarlyRepaymentAlmostFullyPaid2ndPeriod() {
        businessStepHelper.updateSteps("LOAN_CLOSE_OF_BUSINESS", "LOAN_INTEREST_RECALCULATION");
        runAt("20250315", () -> {
            final PostLoanProductsResponse loanProductsResponse = loanProductHelper.createLoanProduct(
                    create4IProgressive().interestRatePerPeriod(35.99).numberOfRepayments(12).isInterestRecalculationEnabled(true));
            PostLoansResponse postLoansResponse = loanTransactionHelper.applyLoan(applyLP2ProgressiveLoanRequest(clientId,
                    loanProductsResponse.getResourceId(), "20250315", 296.79, 35.99, 12, null));
            loanId = postLoansResponse.getLoanId();
            loanTransactionHelper.approveLoan(loanId, approveLoanRequest(296.79, "20250315"));
            disburseLoan(loanId, BigDecimal.valueOf(296.79), "20250315");
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
        });
        runAt("20250316", () -> {
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20250316", 59.0);
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertEquals(BigDecimal.ZERO, loanDetails.getSummary().getTotalUnpaidPayableDueInterest().stripTrailingZeros());
            Assertions.assertEquals(BigDecimal.ZERO, loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros());
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
        });
        runAt("20250317", () -> {
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertEquals(BigDecimal.ZERO, loanDetails.getSummary().getTotalUnpaidPayableDueInterest().stripTrailingZeros());
            Assertions.assertEquals(BigDecimal.valueOf(0.23),
                    loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros());
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
        });
        runAt("20250318", () -> {
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertEquals(BigDecimal.ZERO, loanDetails.getSummary().getTotalUnpaidPayableDueInterest().stripTrailingZeros());
            Assertions.assertEquals(BigDecimal.valueOf(0.46),
                    loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros());
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
        });
        runAt("20250514", () -> {
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertEquals(BigDecimal.ZERO, loanDetails.getSummary().getTotalUnpaidPayableDueInterest().stripTrailingZeros());
            Assertions.assertEquals(BigDecimal.valueOf(13.81),
                    loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros());
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
        });

        runAt("20250515", () -> {
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertEquals(BigDecimal.ZERO, loanDetails.getSummary().getTotalUnpaidPayableDueInterest().stripTrailingZeros());
            Assertions.assertEquals(BigDecimal.valueOf(14.05),
                    loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros());
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
        });

        runAt("20250614", () -> {
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertEquals(BigDecimal.ZERO, loanDetails.getSummary().getTotalUnpaidPayableDueInterest().stripTrailingZeros());
            Assertions.assertEquals(BigDecimal.valueOf(20.96),
                    loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros());
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
        });
        runAt("20250615", () -> {
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertEquals(BigDecimal.valueOf(21.19),
                    loanDetails.getSummary().getTotalUnpaidPayableDueInterest().stripTrailingZeros());
            Assertions.assertEquals(BigDecimal.ZERO, loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros());
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
        });
        runAt("20250616", () -> {
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertEquals(BigDecimal.valueOf(21.19),
                    loanDetails.getSummary().getTotalUnpaidPayableDueInterest().stripTrailingZeros());
            Assertions.assertEquals(BigDecimal.valueOf(0.24),
                    loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros());
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
        });
    }

    @Test
    public void testCapitalizedIncomeExistsInRepaymentScheduleAndModifiesPrincipal() {
        runAt("20230301", () -> {
            final PostLoanProductsResponse loanProductsResponse = loanProductHelper
                    .createLoanProduct(create4IProgressiveWithCapitalizedIncome());
            PostLoansResponse postLoansResponse = loanTransactionHelper.applyLoan(applyLP2ProgressiveLoanRequest(clientId,
                    loanProductsResponse.getResourceId(), "20230301", 10000.00, 12.00, 4, null));
            loanId = postLoansResponse.getLoanId();
            loanTransactionHelper.approveLoan(loanId, approveLoanRequest(10000.00, "20230301"));
            disburseLoan(loanId, BigDecimal.valueOf(1000.00), "20230301");
        });
        runAt("20230302", () -> {
            loanTransactionHelper.addCapitalizedIncome(loanId, "20230302", 100.00);
        });

        BigDecimal thousand = BigDecimal.valueOf(1000.0);
        BigDecimal hundred = BigDecimal.valueOf(100.0);
        BigDecimal thousandOneHundred = BigDecimal.valueOf(1100.0);

        GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);

        Assertions.assertEquals(thousand, loanDetails.getPrincipal().setScale(1, RoundingMode.HALF_UP));
        Assertions.assertEquals(thousand, loanDetails.getSummary().getPrincipalDisbursed().setScale(1, RoundingMode.HALF_UP));
        Assertions.assertEquals(hundred, loanDetails.getSummary().getTotalCapitalizedIncome().setScale(1, RoundingMode.HALF_UP));
        Assertions.assertEquals(thousandOneHundred, loanDetails.getSummary().getTotalPrincipal().setScale(1, RoundingMode.HALF_UP));
        Assertions.assertEquals(thousandOneHundred, loanDetails.getSummary().getPrincipalOutstanding().setScale(1, RoundingMode.HALF_UP));

        List<GetLoansLoanIdRepaymentPeriod> periods = loanDetails.getRepaymentSchedule().getPeriods();
        Assertions.assertEquals(6, periods.size());
        Assertions.assertEquals(thousand, periods.get(0).getPrincipalLoanBalanceOutstanding().setScale(1, RoundingMode.HALF_UP));
        Assertions.assertEquals(hundred, periods.get(1).getPrincipalLoanBalanceOutstanding().setScale(1, RoundingMode.HALF_UP));
    }

}
