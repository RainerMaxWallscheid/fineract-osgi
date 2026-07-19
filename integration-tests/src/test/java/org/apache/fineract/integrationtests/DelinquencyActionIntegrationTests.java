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

import static java.lang.Boolean.FALSE;
import static java.lang.Boolean.TRUE;
import static org.apache.fineract.portfolio.delinquency.domain.DelinquencyAction.PAUSE;
import static org.apache.fineract.portfolio.delinquency.domain.DelinquencyAction.RESUME;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.fineract.client.models.BusinessDateUpdateRequest;
import org.apache.fineract.client.models.GetDelinquencyActionsResponse;
import org.apache.fineract.client.models.GetLoanProductsProductIdResponse;
import org.apache.fineract.client.models.GetLoansLoanIdDelinquencyPausePeriod;
import org.apache.fineract.client.models.GetLoansLoanIdLoanInstallmentLevelDelinquency;
import org.apache.fineract.client.models.GetLoansLoanIdRepaymentPeriod;
import org.apache.fineract.client.models.GetLoansLoanIdResponse;
import org.apache.fineract.client.models.PostLoanProductsRequest;
import org.apache.fineract.client.models.PostLoanProductsResponse;
import org.apache.fineract.client.models.PostLoansDelinquencyActionResponse;
import org.apache.fineract.client.util.CallFailedRuntimeException;
import org.apache.fineract.integrationtests.common.ClientHelper;
import org.apache.fineract.integrationtests.common.loans.LoanTestLifecycleExtension;
import org.apache.fineract.integrationtests.common.products.DelinquencyBucketsHelper;
import org.apache.fineract.integrationtests.inlinecob.InlineLoanCOBHelper;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;

@ExtendWith(LoanTestLifecycleExtension.class)
public class DelinquencyActionIntegrationTests extends BaseLoanIntegrationTest {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(DelinquencyActionIntegrationTests.class);
    public static final BigDecimal DOWN_PAYMENT_PERCENTAGE = new BigDecimal(25);

    @Test
    public void testCreateAndReadPauseDelinquencyAction() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProductWith25PctDownPayment(true, true);
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20230101", 1500.0, 2);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1000.0), "20230101");
            // Create Delinquency Pause for the Loan
            PostLoansDelinquencyActionResponse response = loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20230110", "20230115");
            List<GetDelinquencyActionsResponse> loanDelinquencyActions = loanTransactionHelper.getLoanDelinquencyActions(loanId);
            Assertions.assertNotNull(loanDelinquencyActions);
            Assertions.assertEquals(1, loanDelinquencyActions.size());
            Assertions.assertEquals("PAUSE", loanDelinquencyActions.get(0).getAction());
            Assertions.assertEquals(LocalDate.parse("20230110", dateTimeFormatter), loanDelinquencyActions.get(0).getStartDate());
            Assertions.assertEquals(LocalDate.parse("20230115", dateTimeFormatter), loanDelinquencyActions.get(0).getEndDate());
        });
    }

    @Test
    public void testCreateAndReadPauseDelinquencyActionUsingExternalId() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProductWith25PctDownPayment(true, true);
            // Create external ID
            String externalId = UUID.randomUUID().toString();
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20230101", 1500.0, 2, req -> req.externalId(externalId));
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1000.0), "20230101");
            // Create Delinquency Pause for the Loan
            PostLoansDelinquencyActionResponse response = loanTransactionHelper.createLoanDelinquencyAction(externalId, PAUSE, "20230110", "20230115");
            List<GetDelinquencyActionsResponse> loanDelinquencyActions = loanTransactionHelper.getLoanDelinquencyActions(externalId);
            Assertions.assertNotNull(loanDelinquencyActions);
            Assertions.assertEquals(1, loanDelinquencyActions.size());
            Assertions.assertEquals("PAUSE", loanDelinquencyActions.get(0).getAction());
            Assertions.assertEquals(LocalDate.parse("20230110", dateTimeFormatter), loanDelinquencyActions.get(0).getStartDate());
            Assertions.assertEquals(LocalDate.parse("20230115", dateTimeFormatter), loanDelinquencyActions.get(0).getEndDate());
        });
    }

    @Test
    public void testCreatePauseAndResumeDelinquencyAction() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProductWith25PctDownPayment(true, true);
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20230101", 1500.0, 2);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1000.0), "20230101");
            // Create Delinquency Pause for the Loan
            loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20230110", "20230115");
            // Update business date
            businessDateHelper.updateBusinessDate(new BusinessDateUpdateRequest().type(BusinessDateUpdateRequest.TypeEnum.BUSINESS_DATE).date("20230114").dateFormat(DATETIME_PATTERN).locale("en"));
            // Create 2nd Delinquency Resume for the Loan
            loanTransactionHelper.createLoanDelinquencyAction(loanId, RESUME, "20230114");
            List<GetDelinquencyActionsResponse> loanDelinquencyActions = loanTransactionHelper.getLoanDelinquencyActions(loanId);
            Assertions.assertNotNull(loanDelinquencyActions);
            Assertions.assertEquals(2, loanDelinquencyActions.size());
            Assertions.assertEquals("PAUSE", loanDelinquencyActions.get(0).getAction());
            Assertions.assertEquals(LocalDate.parse("20230110", dateTimeFormatter), loanDelinquencyActions.get(0).getStartDate());
            Assertions.assertEquals(LocalDate.parse("20230115", dateTimeFormatter), loanDelinquencyActions.get(0).getEndDate());
            Assertions.assertEquals("RESUME", loanDelinquencyActions.get(1).getAction());
            Assertions.assertEquals(LocalDate.parse("20230114", dateTimeFormatter), loanDelinquencyActions.get(1).getStartDate());
        });
    }

    @Test
    public void testCreatePauseAndResumeDelinquencyActionWithStatusFlag() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProductWith25PctDownPayment(true, true);
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20230101", 1500.0, 2);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1000.0), "20230101");
            // Create Delinquency Pause for the Loan
            loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20230110", "20230115");
            // Update business date
            businessDateHelper.updateBusinessDate(new BusinessDateUpdateRequest().type(BusinessDateUpdateRequest.TypeEnum.BUSINESS_DATE).date("20230114").dateFormat(DATETIME_PATTERN).locale("en"));
            // Validate Loan Delinquency Pause Period on Loan
            validateLoanDelinquencyPausePeriods(loanId, pausePeriods("20230110", "20230115", true));
            // Create a Resume for the Loan for the current business date, it is still expected to be in pause
            loanTransactionHelper.createLoanDelinquencyAction(loanId, RESUME, "20230114");
            // Validate Loan Delinquency Pause Period on Loan
            validateLoanDelinquencyPausePeriods(loanId, pausePeriods("20230110", "20230114", true));
            // Update business date to 20230115
            businessDateHelper.updateBusinessDate(new BusinessDateUpdateRequest().type(BusinessDateUpdateRequest.TypeEnum.BUSINESS_DATE).date("20230115").dateFormat(DATETIME_PATTERN).locale("en"));
            // Validate Loan Delinquency Pause Period on Loan
            validateLoanDelinquencyPausePeriods(loanId, pausePeriods("20230110", "20230114", false));
            // Create a new pause action for the future
            loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20230120", "20230125");
            // Validate Loan Delinquency Pause Period on Loan
            validateLoanDelinquencyPausePeriods(loanId,  //
            pausePeriods("20230110", "20230114", false),  //
            pausePeriods("20230120", "20230125", false) //
            );
        });
    }

    @Test
    public void testValidationErrorIsThrownWhenCreatingPauseActionWithBackdatedStartDateBeforeDisbursement() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProductWith25PctDownPayment(true, true);
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20230101", 1500.0, 2);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1000.0), "20230101");
            // Create Delinquency Pause for the Loan before disbursement date
            CallFailedRuntimeException exception = assertThrows(CallFailedRuntimeException.class, () -> loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20221205", "20230115"));
            assertTrue(exception.getMessage().contains("Start date of pause period must be after first disbursal date"));
        });
    }

    @Test
    public void testCreateAndVerifyBackdatedPauseDelinquencyAction() {
        runAt("20230130", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProductWith25PctDownPayment(true, true);
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20221225", 1500.0, 3, req -> req.submittedOnDate("20221225"));
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1000.0), "20221225");
            // Create Delinquency Pause for the Loan in the past
            PostLoansDelinquencyActionResponse response = loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20230128", "20230215");
            List<GetDelinquencyActionsResponse> loanDelinquencyActions = loanTransactionHelper.getLoanDelinquencyActions(loanId);
            Assertions.assertNotNull(loanDelinquencyActions);
            Assertions.assertEquals(1, loanDelinquencyActions.size());
            Assertions.assertEquals("PAUSE", loanDelinquencyActions.get(0).getAction());
            Assertions.assertEquals(LocalDate.parse("20230128", dateTimeFormatter), loanDelinquencyActions.get(0).getStartDate());
            Assertions.assertEquals(LocalDate.parse("20230215", dateTimeFormatter), loanDelinquencyActions.get(0).getEndDate());
            // Validate Active Delinquency Pause Period on Loan
            validateLoanDelinquencyPausePeriods(loanId, pausePeriods("20230128", "20230215", true));
        });
    }

    @Test
    public void testVerifyLoanDelinquencyRecalculationForBackdatedPauseDelinquencyAction() {
        runAt("20230130", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProductWith25PctDownPaymentAndDelinquencyBucket(true, true, true, 3);
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20221225", 1500.0, 3, req -> req.submittedOnDate("20221225"));
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1000.0), "20221225");
            // Loan delinquency data before backdated pause
            verifyLoanDelinquencyData(loanId, 6, new InstallmentDelinquencyData(4, 10, BigDecimal.valueOf(250.0)));
            // Create Delinquency Pause for the Loan in the past
            loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20230127", "20230215");
            List<GetDelinquencyActionsResponse> loanDelinquencyActions = loanTransactionHelper.getLoanDelinquencyActions(loanId);
            Assertions.assertNotNull(loanDelinquencyActions);
            Assertions.assertEquals(1, loanDelinquencyActions.size());
            Assertions.assertEquals("PAUSE", loanDelinquencyActions.getFirst().getAction());
            Assertions.assertEquals(LocalDate.parse("20230127", dateTimeFormatter), loanDelinquencyActions.getFirst().getStartDate());
            Assertions.assertEquals(LocalDate.parse("20230215", dateTimeFormatter), loanDelinquencyActions.getFirst().getEndDate());
            // Loan delinquency data calculation after backdated pause
            verifyLoanDelinquencyData(loanId, 3, new InstallmentDelinquencyData(1, 3, BigDecimal.valueOf(250.0)));
            // Validate Active Delinquency Pause Period on Loan
            validateLoanDelinquencyPausePeriods(loanId, pausePeriods("20230127", "20230215", true));
        });
    }

    @Test
    public void testValidationErrorIsThrownWhenCreatingActionThatOverlaps() {
        runAt("20230101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProductWith25PctDownPayment(true, true);
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20230101", 1500.0, 2);
            // Disburse Loan
            disburseLoan(loanId, BigDecimal.valueOf(1000.0), "20230101");
            // Create Delinquency Pause for the Loan
            loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20230101", "20230115");
            // Create overlapping Delinquency Pause for the Loan
            CallFailedRuntimeException exception = assertThrows(CallFailedRuntimeException.class, () -> loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20230101", "20230115"));
            assertTrue(exception.getMessage().contains("Delinquency pause period cannot overlap with another pause period"));
        });
    }

    @Test
    public void testLoanAndInstallmentDelinquencyCalculationForCOBAfterPausePeriodEndTest() {
        runAt("20231101", () -> {
            // Create Client
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            // Create Loan Product
            Long loanProductId = createLoanProductWith25PctDownPaymentAndDelinquencyBucket(true, true, true, 0);
            // Apply and Approve Loan
            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20231101", 1000.0, 3, req -> {
                req.submittedOnDate("20231101");
                req.setLoanTermFrequency(45);
                req.setRepaymentEvery(15);
                req.setGraceOnArrearsAgeing(0);
            });
            // Partial Loan amount Disbursement
            disburseLoan(loanId, BigDecimal.valueOf(100.0), "20231101");
            // Update business date
            businessDateHelper.updateBusinessDate(new BusinessDateUpdateRequest().type(BusinessDateUpdateRequest.TypeEnum.BUSINESS_DATE).date("20231105").dateFormat(DATETIME_PATTERN).locale("en"));
            // Create Delinquency Pause for the Loan
            PostLoansDelinquencyActionResponse response = loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20231116", "20231125");
            // run cob for business date 26 November
            final InlineLoanCOBHelper inlineLoanCOBHelper = new InlineLoanCOBHelper(requestSpec, responseSpec);
            businessDateHelper.updateBusinessDate(new BusinessDateUpdateRequest().type(BusinessDateUpdateRequest.TypeEnum.BUSINESS_DATE).date("20231126").dateFormat(DATETIME_PATTERN).locale("en"));
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId.longValue()));
            // Loan delinquency data
            verifyLoanDelinquencyData(loanId, 1, new InstallmentDelinquencyData(1, 3, BigDecimal.valueOf(25.0)));
            // Validate Delinquency Pause Period on Loan
            validateLoanDelinquencyPausePeriods(loanId, pausePeriods("20231116", "20231125", false));
        });
    }

    private void validateLoanDelinquencyPausePeriods(Long loanId, GetLoansLoanIdDelinquencyPausePeriod... pausePeriods) {
        GetLoansLoanIdResponse loan = loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId.intValue());
        Assertions.assertNotNull(loan.getDelinquent());
        if (pausePeriods.length > 0) {
            Assertions.assertEquals(Arrays.asList(pausePeriods), loan.getDelinquent().getDelinquencyPausePeriods());
        } else {
            Assertions.assertNull(loan.getDelinquent().getDelinquencyPausePeriods());
        }
    }

    private GetLoansLoanIdDelinquencyPausePeriod pausePeriods(String startDate, String endDate, boolean active) {
        GetLoansLoanIdDelinquencyPausePeriod pausePeriod = new GetLoansLoanIdDelinquencyPausePeriod();
        pausePeriod.setActive(active);
        pausePeriod.setPausePeriodStart(LocalDate.parse(startDate, dateTimeFormatter));
        pausePeriod.setPausePeriodEnd(LocalDate.parse(endDate, dateTimeFormatter));
        return pausePeriod;
    }

    private void verifyLoanDelinquencyData(Long loanId, Integer loanLevelDelinquentDays, InstallmentDelinquencyData... expectedInstallmentLevelInstallmentDelinquencyData) {
        GetLoansLoanIdResponse loan = loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId.intValue());
        Assertions.assertNotNull(loan.getDelinquent());
        List<GetLoansLoanIdLoanInstallmentLevelDelinquency> installmentLevelDelinquency = loan.getDelinquent().getInstallmentLevelDelinquency();
        assertThat(loan.getDelinquent().getDelinquentDays()).isEqualTo(loanLevelDelinquentDays);
        assertThat(installmentLevelDelinquency.get(0).getMaximumAgeDays()).isEqualTo(expectedInstallmentLevelInstallmentDelinquencyData[0].maxAgeDays);
        assertThat(installmentLevelDelinquency.get(0).getMinimumAgeDays()).isEqualTo(expectedInstallmentLevelInstallmentDelinquencyData[0].minAgeDays);
        assertThat(installmentLevelDelinquency.get(0).getDelinquentAmount()).isEqualByComparingTo(expectedInstallmentLevelInstallmentDelinquencyData[0].delinquentAmount);
    }

    private Long createLoanProductWith25PctDownPayment(boolean autoDownPaymentEnabled, boolean multiDisburseEnabled) {
        PostLoanProductsRequest product = createOnePeriod30DaysLongNoInterestPeriodicAccrualProduct();
        product.setMultiDisburseLoan(multiDisburseEnabled);
        if (!multiDisburseEnabled) {
            product.disallowExpectedDisbursements(null);
            product.setAllowApprovedDisbursedAmountsOverApplied(null);
            product.overAppliedCalculationType(null);
            product.overAppliedNumber(null);
        }
        product.setEnableDownPayment(true);
        product.setDisbursedAmountPercentageForDownPayment(DOWN_PAYMENT_PERCENTAGE);
        product.setEnableAutoRepaymentForDownPayment(autoDownPaymentEnabled);
        PostLoanProductsResponse loanProductResponse = loanProductHelper.createLoanProduct(product);
        GetLoanProductsProductIdResponse getLoanProductsProductIdResponse = loanProductHelper.retrieveLoanProductById(loanProductResponse.getResourceId());
        Long loanProductId = loanProductResponse.getResourceId();
        assertEquals(TRUE, getLoanProductsProductIdResponse.getEnableDownPayment());
        assertNotNull(getLoanProductsProductIdResponse.getDisbursedAmountPercentageForDownPayment());
        assertEquals(0, getLoanProductsProductIdResponse.getDisbursedAmountPercentageForDownPayment().compareTo(DOWN_PAYMENT_PERCENTAGE));
        assertEquals(autoDownPaymentEnabled, getLoanProductsProductIdResponse.getEnableAutoRepaymentForDownPayment());
        assertEquals(multiDisburseEnabled, getLoanProductsProductIdResponse.getMultiDisburseLoan());
        return loanProductId;
    }

    private Long createLoanProductWith25PctDownPaymentAndDelinquencyBucket(boolean autoDownPaymentEnabled, boolean multiDisburseEnabled, boolean installmentLevelDelinquencyEnabled, Integer graceOnArrearsAging) {
        // Create DelinquencyBuckets
        Long delinquencyBucketId = DelinquencyBucketsHelper.createBucket(List.of(//
        Pair.of(1, 3),  //
        Pair.of(4, 10),  //
        Pair.of(11, 60),  //
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
        PostLoanProductsResponse loanProductResponse = loanProductHelper.createLoanProduct(product);
        GetLoanProductsProductIdResponse getLoanProductsProductIdResponse = loanProductHelper.retrieveLoanProductById(loanProductResponse.getResourceId());
        Long loanProductId = loanProductResponse.getResourceId();
        assertEquals(TRUE, getLoanProductsProductIdResponse.getEnableDownPayment());
        assertNotNull(getLoanProductsProductIdResponse.getDisbursedAmountPercentageForDownPayment());
        assertEquals(0, getLoanProductsProductIdResponse.getDisbursedAmountPercentageForDownPayment().compareTo(DOWN_PAYMENT_PERCENTAGE));
        assertEquals(autoDownPaymentEnabled, getLoanProductsProductIdResponse.getEnableAutoRepaymentForDownPayment());
        assertEquals(multiDisburseEnabled, getLoanProductsProductIdResponse.getMultiDisburseLoan());
        return loanProductId;
    }

    private Long createLoanProductWithDelinquencyBucketNoDownPayment(boolean multiDisburseEnabled, boolean installmentLevelDelinquencyEnabled, Integer graceOnArrearsAging) {
        Long delinquencyBucketId = DelinquencyBucketsHelper.createBucket(List.of(//
        Pair.of(1, 3),  //
        Pair.of(4, 10),  //
        Pair.of(11, 60),  //
        Pair.of(61, null)//
        ));
        PostLoanProductsRequest product = createOnePeriod30DaysLongNoInterestPeriodicAccrualProduct();
        product.setDelinquencyBucketId(delinquencyBucketId.longValue());
        product.setMultiDisburseLoan(multiDisburseEnabled);
        product.setEnableDownPayment(false);
        product.setGraceOnArrearsAgeing(graceOnArrearsAging);
        product.setEnableInstallmentLevelDelinquency(installmentLevelDelinquencyEnabled);
        PostLoanProductsResponse loanProductResponse = loanProductHelper.createLoanProduct(product);
        return loanProductResponse.getResourceId();
    }

    @Test
    public void testDelinquentDaysAndDateAfterPastDelinquencyPause() {
        final Long[] loanIdHolder = new Long[1];
        runAt("20220101", () -> {
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            Long loanProductId = createLoanProductWith25PctDownPaymentAndDelinquencyBucket(true, true, false, 0);
            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20220101", 1000.0, 2, req -> {
                req.setLoanTermFrequency(30);
                req.setRepaymentEvery(15);
                req.setGraceOnArrearsAgeing(0);
            });
            disburseLoan(loanId, BigDecimal.valueOf(1000.0), "20220101");
            loanIdHolder[0] = loanId;
            loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20220120", "20220130");
        });
        runAt("20220202", () -> {
            final InlineLoanCOBHelper inlineLoanCOBHelper = new InlineLoanCOBHelper(requestSpec, responseSpec);
            Long loanId = loanIdHolder[0];
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            assertNotNull(loanDetails.getDelinquent(), "Delinquent data should not be null");
            Integer pastDueDays = loanDetails.getDelinquent().getPastDueDays();
            assertNotNull(pastDueDays, "Past due days should not be null");
            assertEquals(17, pastDueDays, "Past due days should be 17 (16 Jan due date to 02 Feb business date)");
            Integer delinquentDays = loanDetails.getDelinquent().getDelinquentDays();
            assertNotNull(delinquentDays, "Delinquent days should not be null");
            assertEquals(7, delinquentDays, "Delinquent days should be 7 (17 past due days - 10 paused days = 7)");
            LocalDate delinquentDate = loanDetails.getDelinquent().getDelinquentDate();
            assertNotNull(delinquentDate, "Delinquent date should not be null");
            assertEquals(LocalDate.parse("20220116", dateTimeFormatter), delinquentDate, "Delinquent date should be 20220116 (first installment due date, NOT adjusted for pause)");
            List<GetLoansLoanIdDelinquencyPausePeriod> pausePeriods = loanDetails.getDelinquent().getDelinquencyPausePeriods();
            assertNotNull(pausePeriods);
            assertEquals(1, pausePeriods.size());
            assertEquals(LocalDate.parse("20220120", dateTimeFormatter), pausePeriods.get(0).getPausePeriodStart());
            assertEquals(LocalDate.parse("20220130", dateTimeFormatter), pausePeriods.get(0).getPausePeriodEnd());
            assertEquals(FALSE, pausePeriods.get(0).getActive());
        });
    }

    @Test
    public void testInstallmentLevelDelinquencyWithMultipleOverdueInstallments() {
        final Long[] loanIdHolder = new Long[1];
        runAt("20220101", () -> {
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            Long loanProductId = createLoanProductWith25PctDownPaymentAndDelinquencyBucket(true, true, true, 0);
            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20220101", 1000.0, 3, req -> {
                req.setLoanTermFrequency(45);
                req.setRepaymentEvery(15);
                req.setGraceOnArrearsAgeing(0);
            });
            disburseLoan(loanId, BigDecimal.valueOf(100.0), "20220101");
            loanIdHolder[0] = loanId;
            businessDateHelper.updateBusinessDate(new BusinessDateUpdateRequest().type(BusinessDateUpdateRequest.TypeEnum.BUSINESS_DATE).date("20220105").dateFormat(DATETIME_PATTERN).locale("en"));
            loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20220120", "20220130");
        });
        runAt("20220302", () -> {
            final InlineLoanCOBHelper inlineLoanCOBHelper = new InlineLoanCOBHelper(requestSpec, responseSpec);
            Long loanId = loanIdHolder[0];
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            assertNotNull(loanDetails.getDelinquent(), "Loan delinquent data should not be null");
            Integer loanLevelPastDueDays = loanDetails.getDelinquent().getPastDueDays();
            assertEquals(45, loanLevelPastDueDays, "Loan level past due days should be 45 (16 Jan to 02 Mar)");
            Integer loanLevelDelinquentDays = loanDetails.getDelinquent().getDelinquentDays();
            assertEquals(35, loanLevelDelinquentDays, "Loan level delinquent days should be 35 (45 past due days - 10 paused days = 35)");
            LocalDate loanLevelDelinquentDate = loanDetails.getDelinquent().getDelinquentDate();
            assertEquals(LocalDate.parse("20220116", dateTimeFormatter), loanLevelDelinquentDate, "Loan level delinquent date should be 20220116 (first installment due date)");
            Map<String, BigDecimal> expectedTotals = calculateExpectedBucketTotals(loanDetails, LocalDate.parse("20220302", dateTimeFormatter));
            assertTrue(expectedTotals.containsKey("11-60"), "Expected 11-60 bucket to contain delinquent installments");
            assertInstallmentDelinquencyBuckets(loanDetails, LocalDate.parse("20220302", dateTimeFormatter), expectedTotals);
        });
    }

    @Test
    public void testInstallmentDelinquencyWithSinglePauseAffectingMultipleInstallments() {
        final Long[] loanIdHolder = new Long[1];
        runAt("20220110", () -> {
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            Long loanProductId = createLoanProductWith25PctDownPaymentAndDelinquencyBucket(true, true, true, 0);
            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20220110", 1000.0, 3, req -> {
                req.setLoanTermFrequency(30);
                req.setRepaymentEvery(10);
                req.setGraceOnArrearsAgeing(0);
            });
            disburseLoan(loanId, BigDecimal.valueOf(100.0), "20220110");
            loanIdHolder[0] = loanId;
            businessDateHelper.updateBusinessDate(new BusinessDateUpdateRequest().type(BusinessDateUpdateRequest.TypeEnum.BUSINESS_DATE).date("20220114").dateFormat(DATETIME_PATTERN).locale("en"));
            loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20220115", "20220125");
        });
        runAt("20220205", () -> {
            final InlineLoanCOBHelper inlineLoanCOBHelper = new InlineLoanCOBHelper(requestSpec, responseSpec);
            Long loanId = loanIdHolder[0];
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            assertNotNull(loanDetails.getDelinquent(), "Loan delinquent data should not be null");
            List<GetLoansLoanIdLoanInstallmentLevelDelinquency> delinquencies = loanDetails.getDelinquent().getInstallmentLevelDelinquency();
            assertNotNull(delinquencies, "Installment level delinquency should not be null");
            Map<String, BigDecimal> actualTotals = new HashMap<>();
            for (GetLoansLoanIdLoanInstallmentLevelDelinquency delinquency : delinquencies) {
                String bucketKey = formatBucketKey(delinquency.getMinimumAgeDays(), delinquency.getMaximumAgeDays());
                actualTotals.merge(bucketKey, delinquency.getDelinquentAmount(), BigDecimal::add);
            }
            assertEquals(2, actualTotals.size(), "Should have 2 delinquency buckets");
            assertTrue(actualTotals.containsKey("4-10"), "Should have 4-10 bucket");
            assertTrue(actualTotals.containsKey("11-60"), "Should have 11-60 bucket");
            assertEquals(0, BigDecimal.valueOf(25.0).compareTo(actualTotals.get("4-10")), "4-10 bucket should have 25.0");
            assertEquals(0, BigDecimal.valueOf(25.0).compareTo(actualTotals.get("11-60")), "11-60 bucket should have 25.0");
        });
    }

    @Test
    public void testInstallmentDelinquencyWithMultiplePausesAffectingSameInstallment() {
        final Long[] loanIdHolder = new Long[1];
        runAt("20220101", () -> {
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            Long loanProductId = createLoanProductWith25PctDownPaymentAndDelinquencyBucket(true, true, true, 0);
            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20220101", 1000.0, 1, req -> {
                req.setLoanTermFrequency(30);
                req.setRepaymentEvery(30);
                req.setGraceOnArrearsAgeing(0);
            });
            disburseLoan(loanId, BigDecimal.valueOf(100.0), "20220101");
            loanIdHolder[0] = loanId;
        });
        runAt("20220204", () -> {
            Long loanId = loanIdHolder[0];
            loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20220204", "20220209");
        });
        runAt("20220215", () -> {
            Long loanId = loanIdHolder[0];
            loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20220215", "20220220");
        });
        runAt("20220301", () -> {
            final InlineLoanCOBHelper inlineLoanCOBHelper = new InlineLoanCOBHelper(requestSpec, responseSpec);
            Long loanId = loanIdHolder[0];
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            assertNotNull(loanDetails.getDelinquent(), "Loan delinquent data should not be null");
            LocalDate businessDate = LocalDate.parse("20220301", dateTimeFormatter);
            LocalDate installmentDueDate = loanDetails.getDelinquent().getDelinquentDate();
            Integer loanLevelPastDueDays = loanDetails.getDelinquent().getPastDueDays();
            long expectedPastDueDays = ChronoUnit.DAYS.between(installmentDueDate, businessDate);
            assertEquals((int) expectedPastDueDays, loanLevelPastDueDays, "Loan level past due days should match the business date minus the first installment due date");
            Integer loanLevelDelinquentDays = loanDetails.getDelinquent().getDelinquentDays();
            long expectedDelinquentDays = Math.max(expectedPastDueDays - 10, 0);
            assertEquals((int) expectedDelinquentDays, loanLevelDelinquentDays, "Loan level delinquent days should subtract both five-day pause periods from the past due days");
            LocalDate loanLevelDelinquentDate = loanDetails.getDelinquent().getDelinquentDate();
            assertEquals(installmentDueDate, loanLevelDelinquentDate, "Loan level delinquent date should equal the installment due date");
            List<GetLoansLoanIdLoanInstallmentLevelDelinquency> delinquencies = loanDetails.getDelinquent().getInstallmentLevelDelinquency();
            assertNotNull(delinquencies, "Installment level delinquency should not be null");
            Map<String, BigDecimal> actualTotals = new HashMap<>();
            for (GetLoansLoanIdLoanInstallmentLevelDelinquency delinquency : delinquencies) {
                String bucketKey = formatBucketKey(delinquency.getMinimumAgeDays(), delinquency.getMaximumAgeDays());
                actualTotals.merge(bucketKey, delinquency.getDelinquentAmount(), BigDecimal::add);
            }
            assertEquals(1, actualTotals.size(), "Should have 1 delinquency bucket");
            assertTrue(actualTotals.containsKey("11-60"), "Should have 11-60 bucket");
            assertEquals(0, BigDecimal.valueOf(75.0).compareTo(actualTotals.get("11-60")), "11-60 bucket should have 75.0");
        });
    }

    @Test
    public void testInstallmentDelinquencyWithPauseBetweenSequentialInstallments() {
        final Long[] loanIdHolder = new Long[1];
        runAt("20220101", () -> {
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            Long loanProductId = createLoanProductWith25PctDownPaymentAndDelinquencyBucket(true, true, true, 0);
            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20220101", 1000.0, 2, req -> {
                req.setLoanTermFrequency(20);
                req.setRepaymentEvery(10);
                req.setGraceOnArrearsAgeing(0);
            });
            disburseLoan(loanId, BigDecimal.valueOf(100.0), "20220101");
            loanIdHolder[0] = loanId;
            businessDateHelper.updateBusinessDate(new BusinessDateUpdateRequest().type(BusinessDateUpdateRequest.TypeEnum.BUSINESS_DATE).date("20220102").dateFormat(DATETIME_PATTERN).locale("en"));
            loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20220103", "20220110");
        });
        runAt("20220112", () -> {
            final InlineLoanCOBHelper inlineLoanCOBHelper = new InlineLoanCOBHelper(requestSpec, responseSpec);
            Long loanId = loanIdHolder[0];
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            assertNotNull(loanDetails.getDelinquent(), "Loan delinquent data should not be null");
            Map<String, BigDecimal> expectedTotals = calculateExpectedBucketTotals(loanDetails, LocalDate.parse("20220112", dateTimeFormatter));
            assertInstallmentDelinquencyBuckets(loanDetails, LocalDate.parse("20220112", dateTimeFormatter), expectedTotals);
        });
    }

    @Test
    public void testInstallmentDelinquencyWithFourInstallmentsAndPausePeriod() {
        final Long[] loanIdHolder = new Long[1];
        runAt("20220101", () -> {
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            Long loanProductId = createLoanProductWith25PctDownPaymentAndDelinquencyBucket(true, true, true, 0);
            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20220101", 1000.0, 4, req -> {
                req.setLoanTermFrequency(60);
                req.setRepaymentEvery(15);
                req.setGraceOnArrearsAgeing(0);
            });
            disburseLoan(loanId, BigDecimal.valueOf(1000.0), "20220101");
            loanIdHolder[0] = loanId;
            businessDateHelper.updateBusinessDate(new BusinessDateUpdateRequest().type(BusinessDateUpdateRequest.TypeEnum.BUSINESS_DATE).date("20220101").dateFormat(DATETIME_PATTERN).locale("en"));
            loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20220102", "20220120");
        });
        runAt("20220301", () -> {
            final InlineLoanCOBHelper inlineLoanCOBHelper = new InlineLoanCOBHelper(requestSpec, responseSpec);
            Long loanId = loanIdHolder[0];
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            assertNotNull(loanDetails.getDelinquent(), "Loan delinquent data should not be null");
            Map<String, BigDecimal> expectedTotals = calculateExpectedBucketTotals(loanDetails, LocalDate.parse("20220301", dateTimeFormatter));
            assertInstallmentDelinquencyBuckets(loanDetails, LocalDate.parse("20220301", dateTimeFormatter), expectedTotals);
        });
    }

    @Test
    public void testPauseUsesBusinessDateNotCOBDate() {
        final Long[] loanIdHolder = new Long[1];
        runAt("20250101", () -> {
            Long clientId = clientHelper.createClient(ClientHelper.defaultClientCreationRequest()).getClientId();
            Long loanProductId = createLoanProductWithDelinquencyBucketNoDownPayment(true, true, 3);
            Long loanId = applyAndApproveLoan(clientId, loanProductId, "20250101", 1000.0, 4, req -> {
                req.setLoanTermFrequency(40);
                req.setRepaymentEvery(10);
                req.setGraceOnArrearsAgeing(3);
            });
            disburseLoan(loanId, BigDecimal.valueOf(1000.0), "20250101");
            loanIdHolder[0] = loanId;
        });
        runAt("20250107", () -> {
            final InlineLoanCOBHelper inlineLoanCOBHelper = new InlineLoanCOBHelper(requestSpec, responseSpec);
            Long loanId = loanIdHolder[0];
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
            loanTransactionHelper.createLoanDelinquencyAction(loanId, PAUSE, "20250109", "20250120");
        });
        runAt("20250115", () -> {
            final InlineLoanCOBHelper inlineLoanCOBHelper = new InlineLoanCOBHelper(requestSpec, responseSpec);
            Long loanId = loanIdHolder[0];
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
        });
        runAt("20250125", () -> {
            final InlineLoanCOBHelper inlineLoanCOBHelper = new InlineLoanCOBHelper(requestSpec, responseSpec);
            Long loanId = loanIdHolder[0];
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
        });
        runAt("20250210", () -> {
            final InlineLoanCOBHelper inlineLoanCOBHelper = new InlineLoanCOBHelper(requestSpec, responseSpec);
            Long loanId = loanIdHolder[0];
            inlineLoanCOBHelper.executeInlineCOB(List.of(loanId));
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            assertNotNull(loanDetails.getDelinquent(), "Loan delinquent data should not be null");
            Integer loanLevelPastDueDays = loanDetails.getDelinquent().getPastDueDays();
            assertEquals(30, loanLevelPastDueDays, "Loan level past due days should be 30 (Jan 11 to Feb 10) - First installment due Jan 11 (10 days after Jan 1)");
            Integer loanLevelDelinquentDays = loanDetails.getDelinquent().getDelinquentDays();
            assertEquals(18, loanLevelDelinquentDays, "Loan level delinquent days should be 18 (29 overdue days from Jan 12 to Feb 10, minus 8 paused days from Jan 12 to Jan 20, minus 3 grace)");
            LocalDate loanLevelDelinquentDate = loanDetails.getDelinquent().getDelinquentDate();
            assertEquals(LocalDate.parse("20250114", dateTimeFormatter), loanLevelDelinquentDate, "Loan level delinquent date should be Jan 14, 2025 (first installment due Jan 11 + 3 days grace)");
            Map<String, BigDecimal> expectedTotals = calculateExpectedBucketTotals(loanDetails, LocalDate.parse("20250210", dateTimeFormatter));
            assertInstallmentDelinquencyBuckets(loanDetails, LocalDate.parse("20250210", dateTimeFormatter), expectedTotals);
        });
    }


    public static class InstallmentDelinquencyData {
        Integer minAgeDays;
        Integer maxAgeDays;
        BigDecimal delinquentAmount;

        @java.lang.SuppressWarnings("all")
                public InstallmentDelinquencyData(final Integer minAgeDays, final Integer maxAgeDays, final BigDecimal delinquentAmount) {
            this.minAgeDays = minAgeDays;
            this.maxAgeDays = maxAgeDays;
            this.delinquentAmount = delinquentAmount;
        }
    }

    private void assertInstallmentDelinquencyBuckets(GetLoansLoanIdResponse loanDetails, LocalDate businessDate, Map<String, BigDecimal> expectedBucketTotals) {
        SoftAssertions softly = new SoftAssertions();
        List<GetLoansLoanIdLoanInstallmentLevelDelinquency> delinquencies = loanDetails.getDelinquent().getInstallmentLevelDelinquency();
        softly.assertThat(delinquencies).as("Installment level delinquency should not be null").isNotNull();
        Map<String, BigDecimal> calculatedTotals = calculateExpectedBucketTotals(loanDetails, businessDate);
        Map<String, BigDecimal> actualTotals = new HashMap<>();
        for (GetLoansLoanIdLoanInstallmentLevelDelinquency delinquency : delinquencies) {
            String bucketKey = formatBucketKey(delinquency.getMinimumAgeDays(), delinquency.getMaximumAgeDays());
            actualTotals.merge(bucketKey, delinquency.getDelinquentAmount(), BigDecimal::add);
        }
        softly.assertThat(actualTotals.keySet()).as("Unexpected delinquency bucket set").isEqualTo(calculatedTotals.keySet());
        calculatedTotals.forEach((bucket, expectedAmount) -> {
            BigDecimal actualAmount = actualTotals.get(bucket);
            softly.assertThat(actualAmount).as("Missing delinquency bucket " + bucket).isNotNull();
            softly.assertThat(actualAmount.setScale(2, RoundingMode.HALF_DOWN)).as("Unexpected delinquent amount for bucket " + bucket).isEqualByComparingTo(expectedAmount.setScale(2, RoundingMode.HALF_DOWN));
        });
        if (expectedBucketTotals != null) {
            expectedBucketTotals.forEach((bucket, amount) -> {
                BigDecimal calculated = calculatedTotals.get(bucket);
                softly.assertThat(calculated).as("Expected bucket " + bucket + " not present in calculated totals").isNotNull();
                softly.assertThat(calculated.setScale(2, RoundingMode.HALF_DOWN)).as("Calculated delinquent amount did not match expectation for bucket " + bucket).isEqualByComparingTo(amount.setScale(2, RoundingMode.HALF_DOWN));
            });
        }
        BigDecimal loanLevelAmount = loanDetails.getDelinquent().getDelinquentAmount();
        if (loanLevelAmount != null) {
            BigDecimal actualSum = actualTotals.values().stream().reduce(BigDecimal.ZERO, BigDecimal::add);
            softly.assertThat(actualSum.setScale(2, RoundingMode.HALF_DOWN)).as("Installment bucket totals should sum to the loan level delinquent amount").isEqualByComparingTo(loanLevelAmount.setScale(2, RoundingMode.HALF_DOWN));
        }
        softly.assertAll();
    }

    private Map<String, BigDecimal> calculateExpectedBucketTotals(GetLoansLoanIdResponse loanDetails, LocalDate businessDate) {
        Map<String, BigDecimal> totals = new HashMap<>();
        List<GetLoansLoanIdDelinquencyPausePeriod> pauses = loanDetails.getDelinquent().getDelinquencyPausePeriods();
        for (GetLoansLoanIdRepaymentPeriod period : loanDetails.getRepaymentSchedule().getPeriods()) {
            if (Boolean.TRUE.equals(period.getDownPaymentPeriod())) {
                continue;
            }
            LocalDate dueDate = period.getDueDate();
            if (dueDate == null || !dueDate.isBefore(businessDate)) {
                continue;
            }
            BigDecimal outstanding = period.getTotalOutstandingForPeriod();
            if (outstanding == null || outstanding.compareTo(BigDecimal.ZERO) <= 0) {
                continue;
            }
            long pastDueDays = ChronoUnit.DAYS.between(dueDate, businessDate);
            if (pastDueDays <= 0) {
                continue;
            }
            long pausedDays = 0L;
            if (pauses != null) {
                for (GetLoansLoanIdDelinquencyPausePeriod pause : pauses) {
                    LocalDate pauseStart = pause.getPausePeriodStart();
                    LocalDate pauseEnd = pause.getPausePeriodEnd() != null ? pause.getPausePeriodEnd() : businessDate;
                    if (pauseStart == null || !pauseEnd.isAfter(pauseStart)) {
                        continue;
                    }
                    LocalDate overlapStart = pauseStart.isAfter(dueDate) ? pauseStart : dueDate;
                    LocalDate overlapEnd = pauseEnd.isBefore(businessDate) ? pauseEnd : businessDate;
                    if (overlapEnd.isAfter(overlapStart)) {
                        pausedDays += ChronoUnit.DAYS.between(overlapStart, overlapEnd);
                    }
                }
            }
            long delinquentDays = pastDueDays - pausedDays;
            if (delinquentDays <= 0) {
                continue;
            }
            String bucket = formatBucketKeyForDays(delinquentDays);
            totals.merge(bucket, outstanding, BigDecimal::add);
        }
        return totals;
    }

    private String formatBucketKey(Integer minAgeDays, Integer maxAgeDays) {
        if (minAgeDays == null) {
            return "0";
        }
        if (maxAgeDays == null) {
            return minAgeDays + "+";
        }
        return minAgeDays + "-" + maxAgeDays;
    }

    private String formatBucketKeyForDays(long delinquentDays) {
        if (delinquentDays >= 1 && delinquentDays <= 3) {
            return "1-3";
        } else if (delinquentDays >= 4 && delinquentDays <= 10) {
            return "4-10";
        } else if (delinquentDays >= 11 && delinquentDays <= 60) {
            return "11-60";
        } else if (delinquentDays >= 61) {
            return "61+";
        }
        return "0";
    }
}
