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

import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.math.BigDecimal;
import org.apache.fineract.client.models.GetLoanProductsProductIdResponse;
import org.apache.fineract.client.models.PostLoanProductsRequest;
import org.apache.fineract.integrationtests.client.feign.FeignLoanTestBase;
import org.apache.fineract.integrationtests.common.ClientHelper;
import org.apache.fineract.portfolio.loanaccount.loanschedule.domain.LoanScheduleProcessingType;
import org.apache.fineract.portfolio.loanaccount.loanschedule.domain.LoanScheduleType;
import org.junit.jupiter.api.Test;

public class LoanRepaymentScheduleForChargesAfterMaturityTest extends FeignLoanTestBase {

    @Test
    public void loanNPlusOneInstallmentIsRetainedAfterLoanRescheduleTest() {
        runAt("20230303", () -> {
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            Long loanProductId = createLoanProductWithMultiDisbursalAndRepayments();

            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20230301", 1500.0, 4, req -> {
                req.setRepaymentEvery(15);
                req.setLoanTermFrequency(60);
            });

            disburseLoan(loanId, BigDecimal.valueOf(1000.00), "20230301");

            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230301"), //
                    installment(250.0, false, "20230316"), //
                    installment(250.0, false, "20230331"), //
                    installment(250.0, false, "20230415"), //
                    installment(250.0, false, "20230430")//
            );

            addCharge(loanId, false, 50, "20230523");

            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230301"), //
                    installment(250.0, false, "20230316"), //
                    installment(250.0, false, "20230331"), //
                    installment(250.0, false, "20230415"), //
                    installment(250.0, false, "20230430"), //
                    installment(0.0, 0.0, 50.0, 50.0, false, "20230523")//
            );

            createAndApproveReschedule(loanId, "20230303", "20230415", "20230430");
            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230301"), //
                    installment(250.0, false, "20230316"), //
                    installment(250.0, false, "20230331"), //
                    installment(250.0, false, "20230430"), //
                    installment(250.0, false, "20230515"), //
                    installment(0.0, 0.0, 50.0, 50.0, false, "20230523")//
            );

        });
    }

    @Test
    public void loanNPlusOneInstallmentIsAdjustedAfterRescheduleIfDateFallBeforeMaturityDateTest() {
        runAt("20230303", () -> {
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            Long loanProductId = createLoanProductWithMultiDisbursalAndRepayments();

            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20230301", 1500.0, 4, req -> {
                req.setRepaymentEvery(15);
                req.setLoanTermFrequency(60);
            });

            disburseLoan(loanId, BigDecimal.valueOf(1000.00), "20230301");

            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230301"), //
                    installment(250.0, false, "20230316"), //
                    installment(250.0, false, "20230331"), //
                    installment(250.0, false, "20230415"), //
                    installment(250.0, false, "20230430")//
            );

            addCharge(loanId, false, 50, "20230513");

            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230301"), //
                    installment(250.0, false, "20230316"), //
                    installment(250.0, false, "20230331"), //
                    installment(250.0, false, "20230415"), //
                    installment(250.0, false, "20230430"), //
                    installment(0.0, 0.0, 50.0, 50.0, false, "20230513")//
            );

            createAndApproveReschedule(loanId, "20230303", "20230415", "20230430");
            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230301"), //
                    installment(250.0, false, "20230316"), //
                    installment(250.0, false, "20230331"), //
                    installment(250.0, false, "20230430"), //
                    installment(250.0, 0.0, 50.0, 300.0, false, "20230515")//
            );

        });
    }

    @Test
    public void loanNPlusOneInstallmentIsRetainedAfterLoanRescheduleForAdvancedPaymentAllocationTest() {
        runAt("20230303", () -> {
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            Long loanProductId = createLoanProductWithMultiDisbursalAndRepaymentsWithAdvancedPaymentAllocationStrategy();

            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20230301", 1500.0, 4, req -> {
                req.setRepaymentEvery(15);
                req.setLoanTermFrequency(60);
                req.setTransactionProcessingStrategyCode("advanced-payment-allocation-strategy");
                req.setLoanScheduleProcessingType(LoanScheduleType.PROGRESSIVE.toString());
                req.setLoanScheduleProcessingType(LoanScheduleProcessingType.HORIZONTAL.toString());
            });

            disburseLoan(loanId, BigDecimal.valueOf(1000.00), "20230301");

            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230301"), //
                    installment(250.0, false, "20230316"), //
                    installment(250.0, false, "20230331"), //
                    installment(250.0, false, "20230415"), //
                    installment(250.0, false, "20230430")//
            );

            addCharge(loanId, false, 50, "20230523");

            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230301"), //
                    installment(250.0, false, "20230316"), //
                    installment(250.0, false, "20230331"), //
                    installment(250.0, false, "20230415"), //
                    installment(250.0, false, "20230430"), //
                    installment(0.0, 0.0, 50.0, 50.0, false, "20230523")//
            );

            createAndApproveReschedule(loanId, "20230303", "20230415", "20230430");
            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230301"), //
                    installment(250.0, false, "20230316"), //
                    installment(250.0, false, "20230331"), //
                    installment(250.0, false, "20230430"), //
                    installment(250.0, false, "20230515"), //
                    installment(0.0, 0.0, 50.0, 50.0, false, "20230523")//
            );

        });
    }

    @Test
    public void loanNPlusOneInstallmentIsAdjustedAfterRescheduleIfDateFallBeforeMaturityDateForAdvancedPaymentAllocationTest() {
        runAt("20230303", () -> {
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            Long loanProductId = createLoanProductWithMultiDisbursalAndRepaymentsWithAdvancedPaymentAllocationStrategy();

            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20230301", 1500.0, 4, req -> {
                req.setRepaymentEvery(15);
                req.setLoanTermFrequency(60);
                req.setTransactionProcessingStrategyCode("advanced-payment-allocation-strategy");
            });

            disburseLoan(loanId, BigDecimal.valueOf(1000.00), "20230301");

            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230301"), //
                    installment(250.0, false, "20230316"), //
                    installment(250.0, false, "20230331"), //
                    installment(250.0, false, "20230415"), //
                    installment(250.0, false, "20230430")//
            );

            addCharge(loanId, false, 50, "20230513");

            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230301"), //
                    installment(250.0, false, "20230316"), //
                    installment(250.0, false, "20230331"), //
                    installment(250.0, false, "20230415"), //
                    installment(250.0, false, "20230430"), //
                    installment(0.0, 0.0, 50.0, 50.0, false, "20230513")//
            );

            createAndApproveReschedule(loanId, "20230303", "20230415", "20230430");
            verifyRepaymentSchedule(loanId, //
                    installment(1000.0, null, "20230301"), //
                    installment(250.0, false, "20230316"), //
                    installment(250.0, false, "20230331"), //
                    installment(250.0, false, "20230430"), //
                    installment(250.0, 0.0, 50.0, 300.0, false, "20230515")//
            );

        });
    }

    @Test
    public void incorrectValueAfterCharge() {
        runAt("20241220", () -> {
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            PostLoanProductsRequest product = createOnePeriod30DaysLongNoInterestPeriodicAccrualProductWithAdvancedPaymentAllocation()
                    .minPrincipal(100.0);
            Long loanProductId = createLoanProduct(product);

            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20241220", 800.0, 4, req -> {
                req.setRepaymentEvery(30);
                req.setLoanTermFrequency(120);
                req.setTransactionProcessingStrategyCode("advanced-payment-allocation-strategy");
            });

            disburseLoan(loanId, BigDecimal.valueOf(800.00), "20241220");

            addCharge(loanId, false, 123456789012.12, "20241223");

            verifyRepaymentSchedule(loanId, //
                    installment(800.0, null, "20241220"), //
                    installment(200.0, 0.0, 123456789212.12, false, "20250119"), //
                    installment(200.0, 0.0, 200.0, false, "20250218"), //
                    installment(200.0, 0.0, 200.0, false, "20250320"), //
                    installment(200.0, 0.0, 200.0, false, "20250419")//
            );
        });
    }

    private Long createLoanProductWithMultiDisbursalAndRepayments() {
        boolean multiDisburseEnabled = true;
        PostLoanProductsRequest product = createOnePeriod30DaysLongNoInterestPeriodicAccrualProduct();
        product.setMultiDisburseLoan(multiDisburseEnabled);
        product.setNumberOfRepayments(4);
        product.setRepaymentEvery(15);

        if (!multiDisburseEnabled) {
            product.disallowExpectedDisbursements(null);
            product.setAllowApprovedDisbursedAmountsOverApplied(null);
            product.overAppliedCalculationType(null);
            product.overAppliedNumber(null);
        }

        Long loanProductId = createLoanProduct(product);
        GetLoanProductsProductIdResponse getLoanProductsProductIdResponse = retrieveLoanProduct(loanProductId);
        assertNotNull(getLoanProductsProductIdResponse);
        return loanProductId;

    }

    private Long createLoanProductWithMultiDisbursalAndRepaymentsWithAdvancedPaymentAllocationStrategy() {
        boolean multiDisburseEnabled = true;
        PostLoanProductsRequest product = createOnePeriod30DaysLongNoInterestPeriodicAccrualProductWithAdvancedPaymentAllocation();
        product.setMultiDisburseLoan(multiDisburseEnabled);
        product.setNumberOfRepayments(4);
        product.setRepaymentEvery(15);

        if (!multiDisburseEnabled) {
            product.disallowExpectedDisbursements(null);
            product.setAllowApprovedDisbursedAmountsOverApplied(null);
            product.overAppliedCalculationType(null);
            product.overAppliedNumber(null);
        }

        Long loanProductId = createLoanProduct(product);
        GetLoanProductsProductIdResponse getLoanProductsProductIdResponse = retrieveLoanProduct(loanProductId);
        assertNotNull(getLoanProductsProductIdResponse);
        return loanProductId;
    }
}
