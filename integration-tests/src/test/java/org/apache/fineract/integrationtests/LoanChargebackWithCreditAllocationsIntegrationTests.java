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
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import org.apache.fineract.client.models.AdvancedPaymentData;
import org.apache.fineract.client.models.CreditAllocationData;
import org.apache.fineract.client.models.CreditAllocationOrder;
import org.apache.fineract.client.models.GetLoansLoanIdResponse;
import org.apache.fineract.client.models.GetLoansLoanIdSummary;
import org.apache.fineract.client.models.PaymentAllocationOrder;
import org.apache.fineract.client.models.PostLoanProductsRequest;
import org.apache.fineract.client.models.PostLoanProductsResponse;
import org.apache.fineract.client.models.PostLoansLoanIdResponse;
import org.apache.fineract.client.models.PostLoansRequest;
import org.apache.fineract.client.models.PostLoansResponse;
import org.apache.fineract.integrationtests.common.ClientHelper;
import org.apache.fineract.integrationtests.common.Utils;
import org.apache.fineract.portfolio.loanaccount.loanschedule.domain.LoanScheduleProcessingType;
import org.apache.fineract.portfolio.loanaccount.loanschedule.domain.LoanScheduleType;
import org.apache.fineract.portfolio.loanproduct.domain.PaymentAllocationType;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.lang.Nullable;

public class LoanChargebackWithCreditAllocationsIntegrationTests extends BaseLoanIntegrationTest {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(LoanChargebackWithCreditAllocationsIntegrationTests.class);

    @Test
    public void simpleChargebackWithCreditAllocationPenaltyFeeInterestAndPrincipal() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1250.0), "20230101");
            // Add Charges
            Long feeId = addCharge(loanId, false, 50, "20230115");
            Long penaltyId = addCharge(loanId, true, 20, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 382.0, false, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Update Business Date
            updateBusinessDate("20230120");
            // Add Repayment
            Long repaymentTransaction = addRepaymentForLoan(loanId, 382.0, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 0.0, true, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Add Chargeback
            addChargebackForLoan(loanId, repaymentTransaction, 100.0); // 20 penalty + 50 fee + 0 interest + 30
            // principal
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(382.0, "Repayment", "20230120", 938.0, 312.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230120", 968.0, 30.0, 0.0, 50.0, 20.0, 0.0, 0.0) //
            );
            // Verify Repayment Schedule
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(342.0, 0, 100, 40, 100.0, false, "20230201"), installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
        });
    }

    @Test
    public void simpleChargebackWithCreditAllocationPenaltyFeeInterestAndPrincipalOnTheLastDayOfTheInstallment() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1250.0), "20230101");
            // Add Charges
            Long feeId = addCharge(loanId, false, 50, "20230115");
            Long penaltyId = addCharge(loanId, true, 20, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 382.0, false, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Update Business Date
            updateBusinessDate("20230120");
            // Add Repayment
            Long repaymentTransaction = addRepaymentForLoan(loanId, 382.0, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 0.0, true, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            updateBusinessDate("20230201");
            // Add Chargeback
            addChargebackForLoan(loanId, repaymentTransaction, 100.0); // 20 penalty + 50 fee + 0 interest + 30
            // principal
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(382.0, "Repayment", "20230120", 938.0, 312.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230201", 968.0, 30.0, 0.0, 50.0, 20.0, 0.0, 0.0) //
            );
            // Verify Repayment Schedule
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 0, true, "20230201"),  //
            installment(342.0, 0, 50, 20, 412.0, false, "20230301"), installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
        });
    }

    @Test
    public void simpleChargebackWithCreditAllocationPenaltyFeeInterestAndPrincipalOnTheLastDayOfTheLoan() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1250.0), "20230101");
            // Add Charges
            Long feeId = addCharge(loanId, false, 50, "20230115");
            Long penaltyId = addCharge(loanId, true, 20, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 382.0, false, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Update Business Date
            updateBusinessDate("20230120");
            // Add Repayment
            Long repaymentTransaction = addRepaymentForLoan(loanId, 382.0, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 0.0, true, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            updateBusinessDate("20230501");
            // Add Chargeback
            addChargebackForLoan(loanId, repaymentTransaction, 100.0); // 20 penalty + 50 fee + 0 interest + 30
            // principal
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(382.0, "Repayment", "20230120", 938.0, 312.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230501", 968.0, 30.0, 0.0, 50.0, 20.0, 0.0, 0.0) //
            );
            // Verify Repayment Schedule
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 0.0, true, "20230201"), installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(344.0, 0, 50, 20, 414.0, false, "20230501") //
            );
        });
    }

    @Test
    public void chargebackWithCreditAllocationPenaltyFeeInterestAndPrincipalOnNPlusOneInstallment() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1250.0), "20230101");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Update Business Date + and make a full repayment for the first installment
            updateBusinessDate("20230120");
            addRepaymentForLoan(loanId, 312.0, "20230120");
            // Update Business Date + and make a full repayment for the second installment
            updateBusinessDate("20230220");
            addRepaymentForLoan(loanId, 312.0, "20230220");
            // Update Business Date + and make a full repayment for the third installment
            updateBusinessDate("20230320");
            addRepaymentForLoan(loanId, 312.0, "20230320");
            // Add some charges Update Business Date + and make a full repayment for the fourth installment
            updateBusinessDate("20230420");
            addCharge(loanId, false, 50, "20230420");
            addCharge(loanId, true, 20, "20230420");
            Long repaymentTransaction = addRepaymentForLoan(loanId, 384.0, "20230420");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 0, 0, 0.0, true, "20230201"),  //
            installment(312.0, 0, 0, 0, 0.0, true, "20230301"),  //
            installment(312.0, 0, 0, 0, 0.0, true, "20230401"),  //
            installment(314.0, 0, 50, 20, 0.0, true, "20230501") //
            );
            // Let's move over the maturity date and chargeback some money
            updateBusinessDate("20230502");
            // Add Chargeback, 20 penalty + 50 fee + 0 interest + 30 principal
            addChargebackForLoan(loanId, repaymentTransaction, 100.0);
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(312.0, "Repayment", "20230120", 938.0, 312.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(312.0, "Repayment", "20230220", 626.0, 312.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(312.0, "Repayment", "20230320", 314.0, 312.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(384.0, "Repayment", "20230420", 0.0, 314.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(70.0, "Accrual", "20230420", 0.0, 0.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230502", 30.0, 30.0, 0.0, 50.0, 20.0, 0.0, 0.0) //
            );
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 0, 0, 0.0, true, "20230201"),  //
            installment(312.0, 0, 0, 0, 0.0, true, "20230301"),  //
            installment(312.0, 0, 0, 0, 0.0, true, "20230401"),  //
            installment(314.0, 0, 50, 20, 0.0, true, "20230501"),  //
            installment(30.0, 0, 50, 20, 100.0, false, "20230502") //
            );
        });
    }

    @Test
    public void chargebackWithCreditAllocationAndReverseReplayWithBackdatedPayment() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1250.0), "20230101");
            // Add Charges
            Long feeId = addCharge(loanId, false, 50, "20230115");
            Long penaltyId = addCharge(loanId, true, 20, "20230115");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 382.0, false, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Update Business Date
            updateBusinessDate("20230120");
            // Add Repayment
            Long repaymentTransaction = addRepaymentForLoan(loanId, 382.0, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 0.0, true, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            updateBusinessDate("20230121");
            // Add Chargeback20 penalty + 50 fee + 0 interest + 30 principal
            addChargebackForLoan(loanId, repaymentTransaction, 100.0);
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(382.0, "Repayment", "20230120", 938.0, 312.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230121", 968.0, 30.0, 0.0, 50.0, 20.0, 0.0, 0.0) //
            );
            // Verify Repayment Schedule
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(342.0, 0, 100, 40, 100.0, false, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // let's add a backdated repayment on 19th of January to trigger reverse replaying the chargeback, that will
            // pay both the charges earlier.
            addRepaymentForLoan(loanId, 200.0, "20230119");
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(200.0, "Repayment", "20230119", 1120.0, 130.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(382.0, "Repayment", "20230120", 738.0, 382.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230121", 838.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0) //
            );
        });
    }

    @Test
    public void chargebackWithCreditAllocationReverseReplayedWithBackdatedPayment() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1250.0), "20230101");
            // Add Charges
            Long feeId = addCharge(loanId, false, 50, "20230115");
            Long penaltyId = addCharge(loanId, true, 20, "20230115");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 382.0, false, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Update Business Date
            updateBusinessDate("20230120");
            // Add Repayment
            Long repaymentTransaction = addRepaymentForLoan(loanId, 382.0, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 0.0, true, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            updateBusinessDate("20230122");
            // Add Chargeback20 penalty + 50 fee + 0 interest + 30 principal
            addChargebackForLoan(loanId, repaymentTransaction, 100.0);
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(382.0, "Repayment", "20230120", 938.0, 312.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230122", 968.0, 30.0, 0.0, 50.0, 20.0, 0.0, 0.0) //
            );
            // Verify Repayment Schedule
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(342.0, 0, 100, 40, 100.0, false, "20230201"), installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // let's add a backdated repayment on 21th of January that will reverse replay the chargeback transaction
            // but will leave the
            // original repayment from 20th of January unchanged.
            addRepaymentForLoan(loanId, 200.0, "20230121");
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(382.0, "Repayment", "20230120", 938.0, 312.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(200.0, "Repayment", "20230121", 738.0, 200.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230122", 768.0, 30.0, 0.0, 50.0, 20.0, 0.0, 0.0) //
            );
            verifyLoanSummaryAmounts(loanId, 30.0, 50.0, 20.0, 838.0);
        });
    }

    @Test
    public void chargebackWithCreditAllocationPrincipalInterestFeePenalty() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PRINCIPAL", "INTEREST", "FEE", "PENALTY")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1250.0), "20230101");
            // Add Charges
            Long feeId = addCharge(loanId, false, 50, "20230115");
            Long penaltyId = addCharge(loanId, true, 20, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 382.0, false, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Update Business Date
            updateBusinessDate("20230120");
            // Add Repayment
            Long repaymentTransaction = addRepaymentForLoan(loanId, 382.0, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 0.0, true, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Add Chargeback
            addChargebackForLoan(loanId, repaymentTransaction, 100.0); // 100 principal, 0 interest, 0 fee 0 penalty
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(382.0, "Repayment", "20230120", 938.0, 312.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230120", 1038.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0) //
            );
            // Verify Repayment Schedule
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(412.0, 0, 50, 20, 100.0, false, "20230201"), installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            verifyLoanSummaryAmounts(loanId, 100.0, 0.0, 0.0, 1038);
        });
    }

    @Test
    public void chargebackWithCreditAllocationPrincipalInterestFeePenaltyWhenOverpaid() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PRINCIPAL", "INTEREST", "FEE", "PENALTY")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1250.0), "20230101");
            // Add Charges
            Long feeId = addCharge(loanId, false, 50, "20230115");
            Long penaltyId = addCharge(loanId, true, 20, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 382.0, false, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Update Business Date
            updateBusinessDate("20230120");
            // Add Repayment
            Long repaymentTransaction = addRepaymentForLoan(loanId, 1370.0, "20230120"); // 1250 + 70 = 1320; 50
            // overpayment
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 0.0, true, "20230201"),  //
            installment(312.0, 0, 0, 0, 0.0, true, "20230301"),  //
            installment(312.0, 0, 0, 0, 0.0, true, "20230401"),  //
            installment(314.0, 0, 0, 0, 0.0, true, "20230501") //
            );
            updateBusinessDate("20230502");
            // Add Chargeback
            addChargebackForLoan(loanId, repaymentTransaction, 100.0); // 100 principal, 0 interest, 0 fee 0 penalty
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(1370.0, "Repayment", "20230120", 0, 1250.0, 0.0, 50.0, 20.0, 0.0, 50.0),  //
            transaction(70.0, "Accrual", "20230120", 0.0, 0.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230502", 50.0, 100.0, 0.0, 0.0, 0.0, 0.0, 50.0) //
            );
            // Verify Repayment Schedule
            // DEFAULT payment allocation is ..., DUE_PENALTY, DUE_FEE, DUE_PRINCIPAL, ...
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 0, true, "20230201"),  //
            installment(312.0, 0, 0, 0, 0, true, "20230301"),  //
            installment(312.0, 0, 0, 0, 0, true, "20230401"),  //
            installment(314.0, 0, 0, 0, 0, true, "20230501"),  //
            installment(100.0, 0, 0, 0, outstanding(50.0, 0.0, 0.0, 0.0, 50.0), false, "20230502") //
            );
        });
    }

    @Test
    public void chargebackWithCreditAllocationFeePenaltyPrincipalInterestWhenOverpaid() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("FEE", "PENALTY", "PRINCIPAL", "INTEREST")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1250.0), "20230101");
            // Add Charges
            Long feeId = addCharge(loanId, false, 50, "20230115");
            Long penaltyId = addCharge(loanId, true, 20, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 382.0, false, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Update Business Date
            updateBusinessDate("20230120");
            // Add Repayment
            Long repaymentTransaction = addRepaymentForLoan(loanId, 1370.0, "20230120"); // 1250 + 70 = 1320; 50
            // overpayment
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 0.0, true, "20230201"),  //
            installment(312.0, 0, 0, 0, 0.0, true, "20230301"),  //
            installment(312.0, 0, 0, 0, 0.0, true, "20230401"),  //
            installment(314.0, 0, 0, 0, 0.0, true, "20230501") //
            );
            // Add Chargeback
            addChargebackForLoan(loanId, repaymentTransaction, 100.0); // 100 principal, 0 interest, 0 fee 0 penalty
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(1370.0, "Repayment", "20230120", 0, 1250.0, 0.0, 50.0, 20.0, 0.0, 50.0),  //
            transaction(70.0, "Accrual", "20230120", 0.0, 0.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230120", 30.0, 30.0, 0.0, 50.0, 20.0, 0.0, 50.0) //
            );
            // Verify Repayment Schedule,
            // DEFAULT payment allocation is ..., DUE_PENALTY, DUE_FEE, DUE_PRINCIPAL, ...
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(342.0, 0, 100, 40, outstanding(30.0, 0.0, 20.0, 0.0, 50.0), false, "20230201"),  //
            installment(312.0, 0, 0, 0, 0.0, true, "20230301"),  //
            installment(312.0, 0, 0, 0, 0.0, true, "20230401"),  //
            installment(314.0, 0, 0, 0, 0.0, true, "20230501") //
            );
            verifyLoanSummaryAmounts(loanId, 30.0, 50.0, 20.0, 50.0);
        });
    }

    @Test
    public void chargebackWithCreditAllocationFeePenaltyPrincipalInterestWhenOverpaidDefaultPaymentPrincipalFirst() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocationPrincipalFirst(),  //
            chargebackAllocation("FEE", "PENALTY", "PRINCIPAL", "INTEREST")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1250.0), "20230101");
            // Add Charges
            Long feeId = addCharge(loanId, false, 50, "20230115");
            Long penaltyId = addCharge(loanId, true, 20, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 382.0, false, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Update Business Date
            updateBusinessDate("20230120");
            // Add Repayment
            Long repaymentTransaction = addRepaymentForLoan(loanId, 1370.0, "20230120"); // 1250 + 70 = 1320; 50
            // overpayment
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 0.0, true, "20230201"),  //
            installment(312.0, 0, 0, 0, 0.0, true, "20230301"),  //
            installment(312.0, 0, 0, 0, 0.0, true, "20230401"),  //
            installment(314.0, 0, 0, 0, 0.0, true, "20230501") //
            );
            // Add Chargeback
            addChargebackForLoan(loanId, repaymentTransaction, 100.0); // 100 principal, 0 interest, 0 fee 0 penalty
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(1370.0, "Repayment", "20230120", 0, 1250.0, 0.0, 50.0, 20.0, 0.0, 50.0),  //
            transaction(70.0, "Accrual", "20230120", 0.0, 0.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230120", 0.0, 30.0, 0.0, 50.0, 20.0, 0.0, 50.0) //
            );
            // Verify Repayment Schedule,
            // DEFAULT payment allocation is ..., DUE_PRINCIPAL, DUE_FEE, DUE_PENALTY ...
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(342.0, 0, 100, 40, outstanding(0.0, 0.0, 30.0, 20.0, 50.0), false, "20230201"),  //
            installment(312.0, 0, 0, 0, 0.0, true, "20230301"),  //
            installment(312.0, 0, 0, 0, 0.0, true, "20230401"),  //
            installment(314.0, 0, 0, 0, 0.0, true, "20230501") //
            );
            verifyLoanSummaryAmounts(loanId, 30.0, 50.0, 20.0, 50.0);
        });
    }

    @Test
    public void doubleChargebackWithCreditAllocationPenaltyFeeInterestAndPrincipal() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1250.0), "20230101");
            // Add Charges
            Long feeId = addCharge(loanId, false, 50, "20230115");
            Long penaltyId = addCharge(loanId, true, 20, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 382.0, false, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Update Business Date
            updateBusinessDate("20230120");
            // Add Repayment
            Long repaymentTransaction = addRepaymentForLoan(loanId, 382.0, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 0.0, true, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Add Chargeback
            addChargebackForLoan(loanId, repaymentTransaction, 100.0); // 20 penalty + 50 fee + 0 interest + 30
            // principal
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(382.0, "Repayment", "20230120", 938.0, 312.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230120", 968.0, 30.0, 0.0, 50.0, 20.0, 0.0, 0.0) //
            );
            // Verify Repayment Schedule
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(342.0, 0, 100, 40, 100.0, false, "20230201"), installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            updateBusinessDate("20230121");
            addChargebackForLoan(loanId, repaymentTransaction, 100.0); // 100 to principal
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(382.0, "Repayment", "20230120", 938.0, 312.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230120", 968.0, 30.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230121", 1068.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0) //
            );
            // Verify Repayment Schedule
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(442.0, 0, 100, 40, 200.0, false, "20230201"), installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
        });
    }

    @Test
    public void doubleChargebackReverseReplayedBothFeeAndPenaltyPayedWithCreditAllocationPenaltyFeeInterestAndPrincipal() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1250.0), "20230101");
            // Add Charges
            Long feeId = addCharge(loanId, false, 50, "20230115");
            Long penaltyId = addCharge(loanId, true, 20, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 382.0, false, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Update Business Date
            updateBusinessDate("20230120");
            // Add Repayment
            Long repaymentTransaction = addRepaymentForLoan(loanId, 382.0, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 0.0, true, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Add Chargeback
            addChargebackForLoan(loanId, repaymentTransaction, 100.0); // 20 penalty + 50 fee + 0 interest + 30
            // principal
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(382.0, "Repayment", "20230120", 938.0, 312.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230120", 968.0, 30.0, 0.0, 50.0, 20.0, 0.0, 0.0) //
            );
            // Verify Repayment Schedule
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(342.0, 0, 100, 40, 100.0, false, "20230201"), installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            updateBusinessDate("20230121");
            addChargebackForLoan(loanId, repaymentTransaction, 100.0); // 100 to principal
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(382.0, "Repayment", "20230120", 938.0, 312.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230120", 968.0, 30.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230121", 1068.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0) //
            );
            // Verify Repayment Schedule
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(442.0, 0, 100, 40, 200.0, false, "20230201"), installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Let's add repayment to trigger reverse replay for both chargebacks
            addRepaymentForLoan(loanId, 200.0, "20230119");
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(200.0, "Repayment", "20230119", 1120.0, 130.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(382.0, "Repayment", "20230120", 738.0, 382.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230120", 838.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230121", 938.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0) //
            );
        });
    }

    @Test
    public void doubleChargebackReverseReplayedOnlyPenaltyPayedWithCreditAllocationPenaltyFeeInterestAndPrincipal() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1250.0), "20230101");
            // Add Charges
            Long feeId = addCharge(loanId, false, 50, "20230115");
            Long penaltyId = addCharge(loanId, true, 20, "20230115");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 382.0, false, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Update Business Date
            updateBusinessDate("20230120");
            // Add Repayment
            Long repaymentTransaction = addRepaymentForLoan(loanId, 382.0, "20230120");
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(312.0, 0, 50, 20, 0.0, true, "20230201"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Add Chargeback
            addChargebackForLoan(loanId, repaymentTransaction, 100.0); // 20 penalty + 50 fee + 0 interest + 30
            // principal
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(382.0, "Repayment", "20230120", 938.0, 312.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230120", 968.0, 30.0, 0.0, 50.0, 20.0, 0.0, 0.0) //
            );
            // Verify Repayment Schedule
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(342.0, 0, 100, 40, 100.0, false, "20230201"), installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            updateBusinessDate("20230121");
            addChargebackForLoan(loanId, repaymentTransaction, 100.0); // 100 to principal
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(382.0, "Repayment", "20230120", 938.0, 312.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230120", 968.0, 30.0, 0.0, 50.0, 20.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230121", 1068.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0) //
            );
            // Verify Repayment Schedule
            verifyRepaymentSchedule(loanId,  //
            installment(1250.0, null, "20230101"),  //
            installment(442.0, 0, 100, 40, 200.0, false, "20230201"), installment(312.0, 0, 0, 0, 312.0, false, "20230301"),  //
            installment(312.0, 0, 0, 0, 312.0, false, "20230401"),  //
            installment(314.0, 0, 0, 0, 314.0, false, "20230501") //
            );
            // Let's add repayment to trigger reverse replay for both chargebacks
            addRepaymentForLoan(loanId, 20.0, "20230119");
            verifyTransactions(loanId,  //
            transaction(1250.0, "Disbursement", "20230101", 1250.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(20.0, "Repayment", "20230119", 1250.0, 0.0, 0.0, 0.0, 20.0, 0.0, 0.0),  //
            transaction(382.0, "Repayment", "20230120", 918.0, 332.0, 0.0, 50.0, 0.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230120", 968.0, 50.0, 0.0, 50.0, 0.0, 0.0, 0.0),  //
            transaction(100.0, "Chargeback", "20230121", 1068.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0) //
            );
        });
    }

    @Test
    public void testAccountingChargebackOnPrincipal() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, 3);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(750), "20230101");
            verifyRepaymentSchedule(loanId,  //
            installment(750.0, null, "20230101"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230201"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230301"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230401") //
            );
            // Repayment #1
            updateBusinessDate("20230201");
            Long repaymentTransaction1 = addRepaymentForLoan(loanId, 250.0, "20230201");
            // Repayment #2
            updateBusinessDate("20230301");
            Long repaymentTransaction2 = addRepaymentForLoan(loanId, 250.0, "20230301");
            // Repayment #3
            updateBusinessDate("20230330");
            Long repaymentTransaction3 = addRepaymentForLoan(loanId, 250.0, "20230330");
            // Chargeback 250
            Long chargeback = addChargebackForLoan(loanId, repaymentTransaction2, 250.0);
            verifyTransactions(loanId,  //
            transaction(750.0, "Disbursement", "20230101", 750.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230201", 500.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230301", 250.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230330", 0.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Chargeback", "20230330", 250, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0) //
            );
            // Verify GL entries
            verifyTRJournalEntries(repaymentTransaction1,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250)//
            );
            verifyTRJournalEntries(repaymentTransaction2,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250) //
            );
            verifyTRJournalEntries(repaymentTransaction3,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250)//
            );
            verifyTRJournalEntries(chargeback,  //
            debit(loansReceivableAccount, 250),  //
            credit(fundSource, 250) //
            );
        });
    }

    @Test
    public void testAccountingChargebackOnPrincipalAndFees() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, 3);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(750), "20230101");
            Long feeId = addCharge(loanId, false, 30, "20230215");
            verifyRepaymentSchedule(loanId,  //
            installment(750.0, null, "20230101"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230201"),  //
            installment(250.0, 0, 30, 0, 280.0, false, "20230301"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230401") //
            );
            // Repayment #1
            updateBusinessDate("20230201");
            Long repaymentTransaction1 = addRepaymentForLoan(loanId, 250.0, "20230201");
            // Repayment #2
            updateBusinessDate("20230301");
            Long repaymentTransaction2 = addRepaymentForLoan(loanId, 280.0, "20230301");
            // Run periodic accrual
            schedulerJobHelper.executeAndAwaitJob("Add Accrual Transactions");
            // Repayment #3
            updateBusinessDate("20230330");
            Long repaymentTransaction3 = addRepaymentForLoan(loanId, 250.0, "20230330");
            // Chargeback 250
            Long chargeback = addChargebackForLoan(loanId, repaymentTransaction2, 280.0);
            verifyTransactions(loanId,  //
            transaction(750.0, "Disbursement", "20230101", 750.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230201", 500.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(280.0, "Repayment", "20230301", 250.0, 250.0, 0.0, 30.0, 0.0, 0.0, 0.0),  //
            transaction(30.0, "Accrual", "20230301", 0.0, 0.0, 0.0, 30.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230330", 0.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(280.0, "Chargeback", "20230330", 250, 250.0, 0.0, 30.0, 0.0, 0.0, 0.0) //
            );
            // Verify GL entries
            verifyTRJournalEntries(repaymentTransaction1,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250) //
            );
            verifyTRJournalEntries(repaymentTransaction2,  //
            debit(fundSource, 280),  //
            credit(loansReceivableAccount, 250),  //
            credit(feeReceivableAccount, 30)//
            );
            verifyTRJournalEntries(repaymentTransaction3,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250)//
            );
            verifyTRJournalEntries(chargeback,  //
            debit(loansReceivableAccount, 250),  //
            debit(feeReceivableAccount, 30),  //
            credit(fundSource, 280) //
            );
        });
    }

    @Test
    public void testAccountingChargebackOnPrincipalAndPenalties() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, 3);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(750), "20230101");
            Long feeId = addCharge(loanId, true, 30, "20230215");
            verifyRepaymentSchedule(loanId,  //
            installment(750.0, null, "20230101"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230201"),  //
            installment(250.0, 0, 0, 30.0, 280.0, false, "20230301"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230401") //
            );
            // Repayment #1
            updateBusinessDate("20230201");
            Long repaymentTransaction1 = addRepaymentForLoan(loanId, 250.0, "20230201");
            // Repayment #2
            updateBusinessDate("20230301");
            Long repaymentTransaction2 = addRepaymentForLoan(loanId, 280.0, "20230301");
            // Run periodic accrual
            schedulerJobHelper.executeAndAwaitJob("Add Accrual Transactions");
            // Repayment #3
            updateBusinessDate("20230330");
            Long repaymentTransaction3 = addRepaymentForLoan(loanId, 250.0, "20230330");
            // Chargeback 250
            Long chargeback = addChargebackForLoan(loanId, repaymentTransaction2, 280.0);
            verifyTransactions(loanId,  //
            transaction(750.0, "Disbursement", "20230101", 750.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230201", 500.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(280.0, "Repayment", "20230301", 250.0, 250.0, 0.0, 0.0, 30.0, 0.0, 0.0),  //
            transaction(30.0, "Accrual", "20230301", 0.0, 0.0, 0.0, 0.0, 30.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230330", 0.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(280.0, "Chargeback", "20230330", 250, 250.0, 0.0, 0.0, 30.0, 0.0, 0.0) //
            );
            // Verify GL entries
            verifyTRJournalEntries(repaymentTransaction1,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250) //
            );
            verifyTRJournalEntries(repaymentTransaction2,  //
            debit(fundSource, 280),  //
            credit(loansReceivableAccount, 250),  //
            credit(penaltyReceivableAccount, 30)//
            );
            verifyTRJournalEntries(repaymentTransaction3,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250)//
            );
            verifyTRJournalEntries(chargeback,  //
            debit(loansReceivableAccount, 250),  //
            debit(penaltyReceivableAccount, 30),  //
            credit(fundSource, 280) //
            );
        });
    }

    @Test
    public void testAccountingOverpaymentAmountIsSmallerThanChargeback() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, 3);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(750), "20230101");
            verifyRepaymentSchedule(loanId,  //
            installment(750.0, null, "20230101"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230201"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230301"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230401") //
            );
            // Repayment #1
            updateBusinessDate("20230201");
            Long repaymentTransaction1 = addRepaymentForLoan(loanId, 250.0, "20230201");
            // Repayment #2
            updateBusinessDate("20230301");
            Long repaymentTransaction2 = addRepaymentForLoan(loanId, 250.0, "20230301");
            // Repayment #3
            updateBusinessDate("20230330");
            Long repaymentTransaction3 = addRepaymentForLoan(loanId, 400.0, "20230330");
            // Chargeback 250
            updateBusinessDate("20230331");
            Long chargeback = addChargebackForLoan(loanId, repaymentTransaction2, 250.0);
            verifyTransactions(loanId,  //
            transaction(750.0, "Disbursement", "20230101", 750.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230201", 500.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230301", 250.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(400.0, "Repayment", "20230330", 0.0, 250.0, 0.0, 0.0, 0.0, 0.0, 150.0),  //
            transaction(250.0, "Chargeback", "20230331", 100, 250.0, 0.0, 0.0, 0.0, 0.0, 150.0) //
            );
            // Verify GL entries
            verifyTRJournalEntries(repaymentTransaction1,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250) //
            );
            verifyTRJournalEntries(repaymentTransaction2,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250) //
            );
            verifyTRJournalEntries(repaymentTransaction3,  //
            debit(fundSource, 400),  //
            credit(loansReceivableAccount, 250),  //
            credit(overpaymentAccount, 150) //
            );
            verifyTRJournalEntries(chargeback,  //
            debit(loansReceivableAccount, 100),  //
            debit(overpaymentAccount, 150),  //
            credit(fundSource, 250) //
            );
        });
    }

    @Test
    public void testAccountingOverpaymentAmountIsBiggerThanChargeback() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, 3);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(750), "20230101");
            verifyRepaymentSchedule(loanId,  //
            installment(750.0, null, "20230101"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230201"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230301"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230401") //
            );
            // Repayment #1
            updateBusinessDate("20230201");
            Long repaymentTransaction1 = addRepaymentForLoan(loanId, 250.0, "20230201");
            // Repayment #2
            updateBusinessDate("20230301");
            Long repaymentTransaction2 = addRepaymentForLoan(loanId, 250.0, "20230301");
            // Repayment #3
            updateBusinessDate("20230330");
            Long repaymentTransaction3 = addRepaymentForLoan(loanId, 400.0, "20230330");
            // Chargeback 250
            updateBusinessDate("20230331");
            Long chargeback = addChargebackForLoan(loanId, repaymentTransaction2, 100.0);
            verifyTransactions(loanId,  //
            transaction(750.0, "Disbursement", "20230101", 750.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230201", 500.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230301", 250.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(400.0, "Repayment", "20230330", 0.0, 250.0, 0.0, 0.0, 0.0, 0.0, 150.0),  //
            transaction(100.0, "Chargeback", "20230331", 0.0, 100.0, 0.0, 0.0, 0.0, 0.0, 100.0) //
            );
            // Verify GL entries
            verifyTRJournalEntries(repaymentTransaction1,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250) //
            );
            verifyTRJournalEntries(repaymentTransaction2,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250) //
            );
            verifyTRJournalEntries(repaymentTransaction3,  //
            debit(fundSource, 400),  //
            credit(loansReceivableAccount, 250),  //
            credit(overpaymentAccount, 150) //
            );
            verifyTRJournalEntries(chargeback,  //
            debit(overpaymentAccount, 100),  //
            credit(fundSource, 100) //
            );
        });
    }

    @Test
    public void testAccountingOverpaidLoansWithFeesWhenOverpaymentAmountIsBiggerThanChargeback() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, 3);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(750), "20230101");
            verifyRepaymentSchedule(loanId,  //
            installment(750.0, null, "20230101"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230201"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230301"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230401") //
            );
            // Repayment #1
            updateBusinessDate("20230201");
            Long repaymentTransaction1 = addRepaymentForLoan(loanId, 250.0, "20230201");
            // Add fee & Repayment #2
            updateBusinessDate("20230301");
            Long feeId = addCharge(loanId, false, 30, "20230301");
            Long repaymentTransaction2 = addRepaymentForLoan(loanId, 280.0, "20230301");
            schedulerJobHelper.executeAndAwaitJob("Add Accrual Transactions");
            // Repayment #3
            updateBusinessDate("20230330");
            Long repaymentTransaction3 = addRepaymentForLoan(loanId, 400.0, "20230330");
            // Chargeback 250
            updateBusinessDate("20230331");
            Long chargeback = addChargebackForLoan(loanId, repaymentTransaction2, 100.0);
            verifyTransactions(loanId,  //
            transaction(750.0, "Disbursement", "20230101", 750.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230201", 500.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(280.0, "Repayment", "20230301", 250.0, 250.0, 0.0, 30.0, 0.0, 0.0, 0.0),  //
            transaction(30.0, "Accrual", "20230301", 0.0, 0.0, 0.0, 30.0, 0.0, 0.0, 0.0),  //
            transaction(400.0, "Repayment", "20230330", 0.0, 250.0, 0.0, 0.0, 0.0, 0.0, 150.0),  //
            transaction(100.0, "Chargeback", "20230331", 0.0, 70.0, 0.0, 30.0, 0.0, 0.0, 100.0) //
            );
            // Verify GL entries
            verifyTRJournalEntries(repaymentTransaction1,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250) //
            );
            verifyTRJournalEntries(repaymentTransaction2,  //
            debit(fundSource, 280),  //
            credit(loansReceivableAccount, 250),  //
            credit(feeReceivableAccount, 30) //
            );
            verifyTRJournalEntries(getTransactionId(loanId, "Accrual", "20230301"),  //
            debit(feeReceivableAccount, 30),  //
            credit(feeIncomeAccount, 30) //
            );
            verifyTRJournalEntries(repaymentTransaction3,  //
            debit(fundSource, 400),  //
            credit(loansReceivableAccount, 250),  //
            credit(overpaymentAccount, 150) //
            );
            verifyTRJournalEntries(chargeback,  //
            debit(overpaymentAccount, 100),  //
            credit(fundSource, 100) //
            );
        });
    }

    @Test
    public void testAccountingChargebackOnChargeOffWithPrincipal() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, 3);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(750), "20230101");
            verifyRepaymentSchedule(loanId,  //
            installment(750.0, null, "20230101"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230201"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230301"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230401") //
            );
            // Repayment #1
            updateBusinessDate("20230201");
            Long repaymentTransaction1 = addRepaymentForLoan(loanId, 250.0, "20230201");
            // Repayment #2
            updateBusinessDate("20230301");
            Long repaymentTransaction2 = addRepaymentForLoan(loanId, 250.0, "20230301");
            // Charge-Off
            updateBusinessDate("20230315");
            Long chargeOff = chargeOffLoan(loanId, "20230315");
            // Chargeback 250
            updateBusinessDate("20230330");
            Long chargeback = addChargebackForLoan(loanId, repaymentTransaction2, 250.0);
            verifyTransactions(loanId,  //
            transaction(750.0, "Disbursement", "20230101", 750.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230201", 500.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230301", 250.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Charge-off", "20230315", 0.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Chargeback", "20230330", 500.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0) //
            );
            // Verify GL entries
            verifyTRJournalEntries(repaymentTransaction1,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250)//
            );
            verifyTRJournalEntries(repaymentTransaction2,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250) //
            );
            verifyTRJournalEntries(chargeOff,  //
            debit(chargeOffExpenseAccount, 250),  //
            credit(loansReceivableAccount, 250)//
            );
            verifyTRJournalEntries(chargeback,  //
            debit(chargeOffExpenseAccount, 250),  //
            credit(fundSource, 250) //
            );
        });
    }

    @Test
    public void testAccountingChargebackOnChargeOffFraudWithPrincipal() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, 3);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(750), "20230101");
            verifyRepaymentSchedule(loanId,  //
            installment(750.0, null, "20230101"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230201"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230301"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230401") //
            );
            // Repayment #1
            updateBusinessDate("20230201");
            Long repaymentTransaction1 = addRepaymentForLoan(loanId, 250.0, "20230201");
            // Repayment #2
            updateBusinessDate("20230301");
            Long repaymentTransaction2 = addRepaymentForLoan(loanId, 250.0, "20230301");
            // Charge-Off
            updateBusinessDate("20230315");
            Long chargeOff = chargeOffLoan(loanId, "20230315");
            changeLoanFraudState(loanId, true);
            // Chargeback 250
            updateBusinessDate("20230330");
            Long chargeback = addChargebackForLoan(loanId, repaymentTransaction2, 250.0);
            verifyTransactions(loanId,  //
            transaction(750.0, "Disbursement", "20230101", 750.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230201", 500.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230301", 250.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Charge-off", "20230315", 0.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Chargeback", "20230330", 500.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0) //
            );
            // Verify GL entries
            verifyTRJournalEntries(repaymentTransaction1,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250)//
            );
            verifyTRJournalEntries(repaymentTransaction2,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250) //
            );
            verifyTRJournalEntries(chargeOff,  //
            debit(chargeOffExpenseAccount, 250),  //
            credit(loansReceivableAccount, 250)//
            );
            verifyTRJournalEntries(chargeback,  //
            debit(chargeOffFraudExpenseAccount, 250),  //
            credit(fundSource, 250) //
            );
        });
    }

    @Test
    public void testAccountingChargebackOnChargeOffWithFees() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, 3);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(750), "20230101");
            verifyRepaymentSchedule(loanId,  //
            installment(750.0, null, "20230101"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230201"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230301"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230401") //
            );
            // Repayment #1
            updateBusinessDate("20230201");
            Long repaymentTransaction1 = addRepaymentForLoan(loanId, 250.0, "20230201");
            // Add fee 30
            updateBusinessDate("20230301");
            addCharge(loanId, false, 30, "20230301");
            // Repayment #2
            Long repaymentTransaction2 = addRepaymentForLoan(loanId, 280.0, "20230301");
            // Run periodic accrual
            schedulerJobHelper.executeAndAwaitJob("Add Accrual Transactions");
            // Charge-Off
            updateBusinessDate("20230315");
            addCharge(loanId, false, 20, "20230315");
            Long chargeOff = chargeOffLoan(loanId, "20230315");
            // Chargeback 250
            updateBusinessDate("20230330");
            Long chargeback = addChargebackForLoan(loanId, repaymentTransaction2, 280.0);
            verifyTransactions(loanId,  //
            transaction(750.0, "Disbursement", "20230101", 750.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230201", 500.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(30.0, "Accrual", "20230301", 0.0, 0.0, 0.0, 30.0, 0.0, 0.0, 0.0),  //
            transaction(280.0, "Repayment", "20230301", 250.0, 250.0, 0.0, 30.0, 0.0, 0.0, 0.0),  //
            transaction(270.0, "Charge-off", "20230315", 0.0, 250.0, 0.0, 20.0, 0.0, 0.0, 0.0),  //
            transaction(280.0, "Chargeback", "20230330", 500.0, 250.0, 0.0, 30.0, 0.0, 0.0, 0.0) //
            );
            // Verify GL entries
            verifyTRJournalEntries(repaymentTransaction1,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250)//
            );
            verifyTRJournalEntries(repaymentTransaction2,  //
            debit(fundSource, 280),  //
            credit(loansReceivableAccount, 250),  //
            credit(feeReceivableAccount, 30) //
            );
            verifyTRJournalEntries(getTransactionId(loanId, "Accrual", "20230301"),  //
            debit(feeReceivableAccount, 30),  //
            credit(feeIncomeAccount, 30) //
            );
            verifyTRJournalEntries(chargeOff,  //
            debit(chargeOffExpenseAccount, 250),  //
            credit(loansReceivableAccount, 250),  //
            credit(feeReceivableAccount, 20),  //
            debit(feeChargeOffAccount, 20) //
            );
            verifyTRJournalEntries(chargeback,  //
            credit(fundSource, 280),  //
            debit(chargeOffExpenseAccount, 250),  //
            debit(feeChargeOffAccount, 30) //
            );
        });
    }

    @Test
    public void testAccountingChargebackOnChargeOffWithPenalties() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProduct(//
            createDefaultPaymentAllocation(),  //
            chargebackAllocation("PENALTY", "FEE", "INTEREST", "PRINCIPAL")//
            );
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, 3);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(750), "20230101");
            verifyRepaymentSchedule(loanId,  //
            installment(750.0, null, "20230101"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230201"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230301"),  //
            installment(250.0, 0, 0, 0, 250.0, false, "20230401") //
            );
            // Repayment #1
            updateBusinessDate("20230201");
            Long repaymentTransaction1 = addRepaymentForLoan(loanId, 250.0, "20230201");
            // Add fee 30
            updateBusinessDate("20230301");
            addCharge(loanId, true, 30, "20230301");
            // Repayment #2
            Long repaymentTransaction2 = addRepaymentForLoan(loanId, 280.0, "20230301");
            // Run periodic accrual
            schedulerJobHelper.executeAndAwaitJob("Add Accrual Transactions");
            // Charge-Off
            updateBusinessDate("20230315");
            addCharge(loanId, true, 20, "20230315");
            Long chargeOff = chargeOffLoan(loanId, "20230315");
            // Chargeback 250
            updateBusinessDate("20230330");
            Long chargeback = addChargebackForLoan(loanId, repaymentTransaction2, 280.0);
            verifyTransactions(loanId,  //
            transaction(750.0, "Disbursement", "20230101", 750.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(250.0, "Repayment", "20230201", 500.0, 250.0, 0.0, 0.0, 0.0, 0.0, 0.0),  //
            transaction(30.0, "Accrual", "20230301", 0.0, 0.0, 0.0, 0.0, 30.0, 0.0, 0.0),  //
            transaction(280.0, "Repayment", "20230301", 250.0, 250.0, 0.0, 0.0, 30.0, 0.0, 0.0),  //
            transaction(270.0, "Charge-off", "20230315", 0.0, 250.0, 0.0, 0.0, 20.0, 0.0, 0.0),  //
            transaction(280.0, "Chargeback", "20230330", 500.0, 250.0, 0.0, 0.0, 30.0, 0.0, 0.0) //
            );
            // Verify GL entries
            verifyTRJournalEntries(repaymentTransaction1,  //
            debit(fundSource, 250),  //
            credit(loansReceivableAccount, 250)//
            );
            verifyTRJournalEntries(repaymentTransaction2,  //
            debit(fundSource, 280),  //
            credit(loansReceivableAccount, 250),  //
            credit(penaltyReceivableAccount, 30) //
            );
            verifyTRJournalEntries(getTransactionId(loanId, "Accrual", "20230301"),  //
            debit(penaltyReceivableAccount, 30),  //
            credit(penaltyIncomeAccount, 30) //
            );
            verifyTRJournalEntries(chargeOff,  //
            debit(chargeOffExpenseAccount, 250),  //
            credit(loansReceivableAccount, 250),  //
            credit(penaltyReceivableAccount, 20),  //
            debit(penaltyChargeOffAccount, 20) //
            );
            verifyTRJournalEntries(chargeback,  //
            credit(fundSource, 280),  //
            debit(chargeOffExpenseAccount, 250),  //
            debit(penaltyChargeOffAccount, 30) //
            );
        });
    }

    private void verifyLoanSummaryAmounts(Long loanId, double creditedPrincipal, double creditedFee, double creditedPenalty, double totalOutstanding) {
        GetLoansLoanIdResponse loanResponse = loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId.intValue());
        GetLoansLoanIdSummary summary = loanResponse.getSummary();
        Assertions.assertNotNull(summary);
        Assertions.assertEquals(creditedPrincipal, Utils.getDoubleValue(summary.getPrincipalAdjustments()));
        Assertions.assertEquals(creditedFee, Utils.getDoubleValue(summary.getFeeAdjustments()));
        Assertions.assertEquals(creditedPenalty, Utils.getDoubleValue(summary.getPenaltyAdjustments()));
        Assertions.assertEquals(totalOutstanding, Utils.getDoubleValue(summary.getTotalOutstanding()));
    }

    private Long applyAndApproveLoan(Long clientId, Long loanProductId, int numberOfRepayments) {
        PostLoansRequest applicationRequest = //
        //
        //
        //
        //
        applyLoanRequest(clientId, loanProductId, "20230101", 1250.0, numberOfRepayments).repaymentEvery(1).loanTermFrequency(numberOfRepayments).repaymentFrequencyType(RepaymentFrequencyType.MONTHS).loanTermFrequencyType(RepaymentFrequencyType.MONTHS).transactionProcessingStrategyCode("advanced-payment-allocation-strategy");
        PostLoansResponse postLoansResponse = loanTransactionHelper.applyLoan(applicationRequest);
        PostLoansLoanIdResponse approvedLoanResult = loanTransactionHelper.approveLoan(postLoansResponse.getResourceId(), approveLoanRequest(1250.0, "20230101"));
        Assertions.assertNotNull(approvedLoanResult);
        Assertions.assertNotNull(approvedLoanResult.getLoanId());
        return approvedLoanResult.getLoanId();
    }

    @Nullable
    private Long applyAndApproveLoan(Long clientId, Long loanProductId) {
        return applyAndApproveLoan(clientId, loanProductId, 4);
    }

    public Long createLoanProduct(AdvancedPaymentData defaultAllocation, CreditAllocationData creditAllocationData) {
        PostLoanProductsRequest postLoanProductsRequest = loanProductWithAdvancedPaymentAllocationWith4Installments(defaultAllocation, creditAllocationData);
        PostLoanProductsResponse loanProductResponse = loanProductHelper.createLoanProduct(postLoanProductsRequest);
        return loanProductResponse.getResourceId();
    }

    private PostLoanProductsRequest loanProductWithAdvancedPaymentAllocationWith4Installments(AdvancedPaymentData defaultAllocation, CreditAllocationData creditAllocationData) {
        return //
        //
        //
        //
        //
        createOnePeriod30DaysLongNoInterestPeriodicAccrualProduct().numberOfRepayments(4).repaymentEvery(1).repaymentFrequencyType(RepaymentFrequencyType.MONTHS.longValue()).loanScheduleType(LoanScheduleType.PROGRESSIVE.toString()).loanScheduleProcessingType(LoanScheduleProcessingType.VERTICAL.toString()).transactionProcessingStrategyCode("advanced-payment-allocation-strategy").paymentAllocation(List.of(defaultAllocation, createRepaymentPaymentAllocation())).creditAllocation(List.of(creditAllocationData));
    }

    private AdvancedPaymentData createDefaultPaymentAllocationPrincipalFirst() {
        AdvancedPaymentData advancedPaymentData = new AdvancedPaymentData();
        advancedPaymentData.setTransactionType("DEFAULT");
        advancedPaymentData.setFutureInstallmentAllocationRule("NEXT_INSTALLMENT");
        List<PaymentAllocationOrder> paymentAllocationOrders = getPaymentAllocationOrder(PaymentAllocationType.PAST_DUE_PENALTY, PaymentAllocationType.PAST_DUE_FEE, PaymentAllocationType.PAST_DUE_PRINCIPAL, PaymentAllocationType.PAST_DUE_INTEREST, PaymentAllocationType.DUE_PRINCIPAL, PaymentAllocationType.DUE_FEE, PaymentAllocationType.DUE_PENALTY, PaymentAllocationType.DUE_INTEREST, PaymentAllocationType.IN_ADVANCE_PRINCIPAL, PaymentAllocationType.IN_ADVANCE_FEE, PaymentAllocationType.IN_ADVANCE_PENALTY, PaymentAllocationType.IN_ADVANCE_INTEREST);
        advancedPaymentData.setPaymentAllocationOrder(paymentAllocationOrders);
        return advancedPaymentData;
    }

    private AdvancedPaymentData createRepaymentPaymentAllocation() {
        AdvancedPaymentData advancedPaymentData = new AdvancedPaymentData();
        advancedPaymentData.setTransactionType("REPAYMENT");
        advancedPaymentData.setFutureInstallmentAllocationRule("NEXT_INSTALLMENT");
        List<PaymentAllocationOrder> paymentAllocationOrders = getPaymentAllocationOrder(PaymentAllocationType.PAST_DUE_PENALTY, PaymentAllocationType.PAST_DUE_FEE, PaymentAllocationType.PAST_DUE_INTEREST, PaymentAllocationType.PAST_DUE_PRINCIPAL, PaymentAllocationType.DUE_PENALTY, PaymentAllocationType.DUE_FEE, PaymentAllocationType.DUE_INTEREST, PaymentAllocationType.DUE_PRINCIPAL, PaymentAllocationType.IN_ADVANCE_PENALTY, PaymentAllocationType.IN_ADVANCE_FEE, PaymentAllocationType.IN_ADVANCE_PRINCIPAL, PaymentAllocationType.IN_ADVANCE_INTEREST);
        advancedPaymentData.setPaymentAllocationOrder(paymentAllocationOrders);
        return advancedPaymentData;
    }

    private CreditAllocationData chargebackAllocation(String... allocationRules) {
        CreditAllocationData creditAllocationData = new CreditAllocationData();
        creditAllocationData.setTransactionType("CHARGEBACK");
        creditAllocationData.setCreditAllocationOrder(createCreditAllocationOrders(allocationRules));
        return creditAllocationData;
    }

    public List<CreditAllocationOrder> createCreditAllocationOrders(String... allocationRule) {
        AtomicInteger integer = new AtomicInteger(1);
        return Arrays.stream(allocationRule).map(allocation -> {
            CreditAllocationOrder creditAllocationOrder = new CreditAllocationOrder();
            creditAllocationOrder.setCreditAllocationRule(allocation);
            creditAllocationOrder.setOrder(integer.getAndIncrement());
            return creditAllocationOrder;
        }).toList();
    }
}
