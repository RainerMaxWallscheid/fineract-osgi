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

import static java.lang.Boolean.TRUE;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.fineract.client.models.GetLoanProductsProductIdResponse;
import org.apache.fineract.client.models.GetLoansLoanIdResponse;
import org.apache.fineract.client.models.PostLoanProductsRequest;
import org.apache.fineract.client.models.PutGlobalConfigurationsRequest;
import org.apache.fineract.infrastructure.configuration.api.GlobalConfigurationConstants;
import org.apache.fineract.integrationtests.client.feign.FeignLoanTestBase;
import org.apache.fineract.integrationtests.common.ClientHelper;
import org.apache.fineract.integrationtests.common.products.DelinquencyBucketsHelper;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class LoanDelinquencyDetailsNextPaymentDateConfigurationTest extends FeignLoanTestBase {

    public static final BigDecimal DOWN_PAYMENT_PERCENTAGE = new BigDecimal(25);

    @Test
    public void testNextPaymentDateForUnpaidInstallmentsWithNPlusOneTest() {
        runAt("20231101", () -> {
            try {
                globalConfigurationHelper.updateGlobalConfiguration(GlobalConfigurationConstants.NEXT_PAYMENT_DUE_DATE,
                        new PutGlobalConfigurationsRequest().stringValue("next-unpaid-due-date"));
                Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();

                Long loanProductId = createLoanProductWith25PctDownPaymentAndDelinquencyBucket(false, true, false, 0);

                Long loanId = applyAndApproveLoan(clientId, loanProductId, "20231101", 1000.0, 3, req -> {
                    req.submittedOnDate("20231101");
                    req.setLoanTermFrequency(45);
                    req.setRepaymentEvery(15);
                    req.setGraceOnArrearsAgeing(0);
                });

                disburseLoan(loanId, BigDecimal.valueOf(1000.00), "20231101");

                verifyRepaymentSchedule(loanId, //
                        installment(1000.0, null, "20231101"), //
                        installment(250.0, false, "20231101"), //
                        installment(250.0, false, "20231116"), //
                        installment(250.0, false, "20231201"), //
                        installment(250.0, false, "20231216") //
                );

                verifyLoanDelinquencyNextPaymentDate(loanId, "20231101", false);

                updateBusinessDate("20231113");

                verifyLoanDelinquencyNextPaymentDate(loanId, "20231116", false);

                updateBusinessDate("20231116");

                verifyLoanDelinquencyNextPaymentDate(loanId, "20231201", false);

                updateBusinessDate("20231201");

                verifyLoanDelinquencyNextPaymentDate(loanId, "20231216", false);

                addCharge(loanId, false, 50, "20231223");

                verifyRepaymentSchedule(loanId, //
                        installment(1000.0, null, "20231101"), //
                        installment(250.0, false, "20231101"), //
                        installment(250.0, false, "20231116"), //
                        installment(250.0, false, "20231201"), //
                        installment(250.0, false, "20231216"), //
                        installment(0.0, 0.0, 50.0, 50.0, false, "20231223") //
                );

                updateBusinessDate("20231217");

                verifyLoanDelinquencyNextPaymentDate(loanId, "20231223", false);

                updateBusinessDate("20231225");

            } finally {
                globalConfigurationHelper.updateGlobalConfiguration(GlobalConfigurationConstants.NEXT_PAYMENT_DUE_DATE,
                        new PutGlobalConfigurationsRequest().stringValue("earliest-unpaid-date"));
            }

        });
    }

    @Test
    public void testNextPaymentDateFor2Paid1PartiallyPaidInstallmentsWithNPlusOneTest() {
        runAt("20231101", () -> {
            try {
                globalConfigurationHelper.updateGlobalConfiguration(GlobalConfigurationConstants.NEXT_PAYMENT_DUE_DATE,
                        new PutGlobalConfigurationsRequest().stringValue("next-unpaid-due-date"));
                Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();

                Long loanProductId = createLoanProductWith25PctDownPaymentAndDelinquencyBucket(true, true, false, 0);

                Long loanId = applyAndApproveLoan(clientId, loanProductId, "20231101", 1000.0, 3, req -> {
                    req.submittedOnDate("20231101");
                    req.setLoanTermFrequency(45);
                    req.setRepaymentEvery(15);
                    req.setGraceOnArrearsAgeing(0);
                });

                disburseLoan(loanId, BigDecimal.valueOf(1000.00), "20231101");

                verifyRepaymentSchedule(loanId, //
                        installment(1000.0, null, "20231101"), //
                        installment(250.0, true, "20231101"), //
                        installment(250.0, false, "20231116"), //
                        installment(250.0, false, "20231201"), //
                        installment(250.0, false, "20231216") //
                );

                verifyLoanDelinquencyNextPaymentDate(loanId, "20231116", false);

                updateBusinessDate("20231113");

                verifyLoanDelinquencyNextPaymentDate(loanId, "20231116", false);

                addRepaymentForLoan(loanId, 250.0, "20231113");

                verifyRepaymentSchedule(loanId, //
                        installment(1000.0, null, "20231101"), //
                        installment(250.0, true, "20231101"), //
                        installment(250.0, true, "20231116"), //
                        installment(250.0, false, "20231201"), //
                        installment(250.0, false, "20231216")//
                );

                verifyLoanDelinquencyNextPaymentDate(loanId, "20231201", false);

                updateBusinessDate("20231116");

                verifyLoanDelinquencyNextPaymentDate(loanId, "20231201", false);

                addRepaymentForLoan(loanId, 100.0, "20231116");

                verifyRepaymentSchedule(loanId, //
                        installment(1000.0, null, "20231101"), //
                        installment(250.0, true, "20231101"), //
                        installment(250.0, true, "20231116"), //
                        installment(250.0, 0.0, 150.0, false, "20231201"), //
                        installment(250.0, false, "20231216")//
                );

                verifyLoanDelinquencyNextPaymentDate(loanId, "20231201", false);

                updateBusinessDate("20231201");

                verifyLoanDelinquencyNextPaymentDate(loanId, "20231216", false);

                addCharge(loanId, false, 50, "20231223");

                verifyRepaymentSchedule(loanId, //
                        installment(1000.0, null, "20231101"), //
                        installment(250.0, true, "20231101"), //
                        installment(250.0, true, "20231116"), //
                        installment(250.0, 0.0, 150.0, false, "20231201"), //
                        installment(250.0, false, "20231216"), //
                        installment(0.0, 0.0, 50.0, 50.0, false, "20231223") //
                );

                updateBusinessDate("20231217");

                verifyLoanDelinquencyNextPaymentDate(loanId, "20231223", false);

                updateBusinessDate("20231225");
            } finally {
                globalConfigurationHelper.updateGlobalConfiguration(GlobalConfigurationConstants.NEXT_PAYMENT_DUE_DATE,
                        new PutGlobalConfigurationsRequest().stringValue("earliest-unpaid-date"));
            }

        });
    }

    private void verifyLoanDelinquencyNextPaymentDate(Long loanId, String nextPaymentDate, boolean verifyNull) {
        GetLoansLoanIdResponse loan = getLoanDetails(loanId);
        Assertions.assertNotNull(loan.getDelinquent());
        if (!verifyNull) {
            Assertions.assertNotNull(loan.getDelinquent().getNextPaymentDueDate());
            assertThat(loan.getDelinquent().getNextPaymentDueDate().isEqual(LocalDate.parse(nextPaymentDate, dateTimeFormatter)));
        } else {
            Assertions.assertNull(loan.getDelinquent().getNextPaymentDueDate());
        }

    }

    private Long createLoanProductWith25PctDownPaymentAndDelinquencyBucket(boolean autoDownPaymentEnabled, boolean multiDisburseEnabled,
            boolean installmentLevelDelinquencyEnabled, Integer graceOnArrearsAging) {
        Long delinquencyBucketId = DelinquencyBucketsHelper.createBucket(List.of(//
                Pair.of(1, 3), //
                Pair.of(4, 10), //
                Pair.of(11, 60), //
                Pair.of(61, null)//
        ));
        PostLoanProductsRequest product = createOnePeriod30DaysLongNoInterestPeriodicAccrualProduct();
        product.setDelinquencyBucketId(delinquencyBucketId.longValue());
        product.setMultiDisburseLoan(multiDisburseEnabled);
        product.setEnableDownPayment(true);
        product.setGraceOnArrearsAgeing(graceOnArrearsAging);

        product.setDisbursedAmountPercentageForDownPayment(DOWN_PAYMENT_PERCENTAGE);
        product.setEnableAutoRepaymentForDownPayment(autoDownPaymentEnabled);
        product.setEnableInstallmentLevelDelinquency(installmentLevelDelinquencyEnabled);

        Long loanProductId = createLoanProduct(product);
        GetLoanProductsProductIdResponse getLoanProductsProductIdResponse = retrieveLoanProduct(loanProductId);

        assertEquals(TRUE, getLoanProductsProductIdResponse.getEnableDownPayment());
        assertNotNull(getLoanProductsProductIdResponse.getDisbursedAmountPercentageForDownPayment());
        assertEquals(0, getLoanProductsProductIdResponse.getDisbursedAmountPercentageForDownPayment().compareTo(DOWN_PAYMENT_PERCENTAGE));
        assertEquals(autoDownPaymentEnabled, getLoanProductsProductIdResponse.getEnableAutoRepaymentForDownPayment());
        assertEquals(multiDisburseEnabled, getLoanProductsProductIdResponse.getMultiDisburseLoan());
        return loanProductId;

    }
}
