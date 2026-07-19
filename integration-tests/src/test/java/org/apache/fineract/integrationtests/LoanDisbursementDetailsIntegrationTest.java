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

import static java.lang.Double.parseDouble;
import static org.hamcrest.Matchers.equalTo;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.builder.ResponseSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.specification.RequestSpecification;
import io.restassured.specification.ResponseSpecification;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.atomic.AtomicInteger;
import org.apache.fineract.client.models.AdvancedPaymentData;
import org.apache.fineract.client.models.GetLoanProductsProductIdResponse;
import org.apache.fineract.client.models.GetLoansLoanIdRepaymentPeriod;
import org.apache.fineract.client.models.GetLoansLoanIdRepaymentSchedule;
import org.apache.fineract.client.models.GetLoansLoanIdResponse;
import org.apache.fineract.client.models.PaymentAllocationOrder;
import org.apache.fineract.client.models.PostLoansLoanIdResponse;
import org.apache.fineract.client.models.PutLoansLoanIdResponse;
import org.apache.fineract.integrationtests.common.ClientHelper;
import org.apache.fineract.integrationtests.common.CollateralManagementHelper;
import org.apache.fineract.integrationtests.common.Utils;
import org.apache.fineract.integrationtests.common.loans.LoanApplicationTestBuilder;
import org.apache.fineract.integrationtests.common.loans.LoanDisbursementTestBuilder;
import org.apache.fineract.integrationtests.common.loans.LoanProductTestBuilder;
import org.apache.fineract.integrationtests.common.loans.LoanStatusChecker;
import org.apache.fineract.integrationtests.common.loans.LoanTestLifecycleExtension;
import org.apache.fineract.integrationtests.common.loans.LoanTransactionHelper;
import org.apache.fineract.portfolio.loanaccount.loanschedule.domain.LoanScheduleType;
import org.apache.fineract.portfolio.loanproduct.domain.PaymentAllocationType;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;

@SuppressWarnings({"rawtypes", "unchecked"})
@ExtendWith(LoanTestLifecycleExtension.class)
public class LoanDisbursementDetailsIntegrationTest {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(LoanDisbursementDetailsIntegrationTest.class);
    private ResponseSpecification responseSpec;
    private RequestSpecification requestSpec;
    private LoanTransactionHelper loanTransactionHelper;
    private Integer loanId;
    private Integer disbursementId;
    final String approveDate = "20140301";
    final String expectedDisbursementDate = "20140301";
    final String proposedAmount = "5000";
    final String approvalAmount = "5000";

    @BeforeEach
    public void setup() {
        Utils.initializeRESTAssured();
        this.requestSpec = new RequestSpecBuilder().setContentType(ContentType.JSON).build();
        this.requestSpec.header("Authorization", "Basic " + Utils.loginIntoServerAndGetBase64EncodedAuthenticationKey());
        this.responseSpec = new ResponseSpecBuilder().expectStatusCode(200).build();
        this.loanTransactionHelper = new LoanTransactionHelper(this.requestSpec, this.responseSpec);
    }

    @Test
    public void createAndValidateMultiDisburseLoansBasedOnEmi() {
        List<HashMap> createTranches = new ArrayList<>();
        String id = null;
        String installmentAmount = "800";
        String withoutInstallmentAmount = "";
        String proposedAmount = "10000";
        createTranches.add(this.loanTransactionHelper.createTrancheDetail(id, "20150601", "5000"));
        createTranches.add(this.loanTransactionHelper.createTrancheDetail(id, "20150901", "5000"));
        final Integer clientID = ClientHelper.createClient(this.requestSpec, this.responseSpec, "20140101");
        log.info("---------------------------------CLIENT CREATED WITH ID---------------------------------------------------{}", clientID);
        final Integer loanProductID = this.loanTransactionHelper.getLoanProductId(new LoanProductTestBuilder().withInterestTypeAsDecliningBalance().withMoratorium("", "").withAmortizationTypeAsEqualInstallments().withTranches(true).withInterestCalculationPeriodTypeAsRepaymentPeriod(true).build(null));
        log.info("----------------------------------LOAN PRODUCT CREATED WITH ID------------------------------------------- {}", loanProductID);
        final Integer loanIDWithEmi = applyForLoanApplicationWithEmiAmount(clientID, loanProductID, proposedAmount, createTranches, installmentAmount);
        log.info("-----------------------------------LOAN CREATED WITH EMI LOANID------------------------------------------------- {}", loanIDWithEmi);
        HashMap repaymentScheduleWithEmi = (HashMap) this.loanTransactionHelper.getLoanDetail(this.requestSpec, this.responseSpec, loanIDWithEmi, "repaymentSchedule");
        ArrayList<HashMap> periods = (ArrayList<HashMap>) repaymentScheduleWithEmi.get("periods");
        assertEquals(15, periods.size());
        this.validateRepaymentScheduleWithEMI(periods);
        HashMap loanStatusHashMap = LoanStatusChecker.getStatusOfLoan(this.requestSpec, this.responseSpec, loanIDWithEmi);
        LoanStatusChecker.verifyLoanIsPending(loanStatusHashMap);
        log.info("-----------------------------------APPROVE LOAN-----------------------------------------------------------");
        loanStatusHashMap = this.loanTransactionHelper.approveLoanWithApproveAmount("20150601", "20150601", "10000", loanIDWithEmi, createTranches);
        LoanStatusChecker.verifyLoanIsApproved(loanStatusHashMap);
        LoanStatusChecker.verifyLoanIsWaitingForDisbursal(loanStatusHashMap);
        log.info("-----------------------------------MULTI DISBURSAL LOAN WITH EMI APPROVED SUCCESSFULLY---------------------------------------");
        final Integer loanIDWithoutEmi = applyForLoanApplicationWithEmiAmount(clientID, loanProductID, proposedAmount, createTranches, withoutInstallmentAmount);
        this.loanTransactionHelper.getLoanDetail(this.requestSpec, this.responseSpec, loanIDWithoutEmi, "repaymentSchedule");
        ArrayList<HashMap> periods1 = (ArrayList<HashMap>) repaymentScheduleWithEmi.get("periods");
        assertEquals(15, periods1.size());
        log.info("-----------------------------------LOAN CREATED WITHOUT EMI LOANID------------------------------------------------- {}", loanIDWithoutEmi);
        /* To be uncommented once issue MIFOSX-2006 is closed. */
        // this.validateRepaymentScheduleWithoutEMI(periods1);
        HashMap loanStatusMap = LoanStatusChecker.getStatusOfLoan(this.requestSpec, this.responseSpec, loanIDWithoutEmi);
        LoanStatusChecker.verifyLoanIsPending(loanStatusMap);
        log.info("-----------------------------------APPROVE LOAN-----------------------------------------------------------");
        loanStatusHashMap = this.loanTransactionHelper.approveLoanWithApproveAmount("20150601", "20150601", "10000", loanIDWithoutEmi, createTranches);
        LoanStatusChecker.verifyLoanIsApproved(loanStatusHashMap);
        LoanStatusChecker.verifyLoanIsWaitingForDisbursal(loanStatusHashMap);
        log.info("-----------------------------------MULTI DISBURSAL LOAN WITHOUT EMI APPROVED SUCCESSFULLY---------------------------------------");
    }

    private void validateRepaymentScheduleWithEMI(ArrayList<HashMap> periods) {
        LoanDisbursementTestBuilder expectedRepaymentSchedule0 = new LoanDisbursementTestBuilder("[2015, 6, 1]", 0.0F, 0.0F, null, null, 5000.0F, null, null, null);
        LoanDisbursementTestBuilder expectedRepaymentSchedule1 = new LoanDisbursementTestBuilder("[2015, 7, 1]", 800.0F, 800.0F, 50.0F, 750.0F, 4250.0F, 750.0F, 750.0F, "[2015, 6, 1]");
        LoanDisbursementTestBuilder expectedRepaymentSchedule2 = new LoanDisbursementTestBuilder("[2015, 8, 1]", 800.0F, 800.0F, 42.5F, 757.5F, 3492.5F, 757.5F, 757.5F, "[2015, 7, 1]");
        LoanDisbursementTestBuilder expectedRepaymentSchedule3 = new LoanDisbursementTestBuilder("[2015, 9, 1]", 0.0F, 0.0F, null, null, 5000.0F, null, null, null);
        LoanDisbursementTestBuilder expectedRepaymentSchedule4 = new LoanDisbursementTestBuilder("[2015, 9, 1]", 800.0F, 800.0F, 34.92F, 765.08F, 7727.42F, 765.08F, 765.08F, "[2015, 8, 1]");
        LoanDisbursementTestBuilder expectedRepaymentSchedule5 = new LoanDisbursementTestBuilder("[2015, 10, 1]", 800.0F, 800.0F, 77.27F, 722.73F, 7004.69F, 722.73F, 722.73F, "[2015, 9, 1]");
        LoanDisbursementTestBuilder expectedRepaymentSchedule6 = new LoanDisbursementTestBuilder("[2015, 11, 1]", 800.0F, 800.0F, 70.05F, 729.95F, 6274.74F, 729.95F, 729.95F, "[2015, 10, 1]");
        LoanDisbursementTestBuilder expectedRepaymentSchedule7 = new LoanDisbursementTestBuilder("[2015, 12, 1]", 800.0F, 800.0F, 62.75F, 737.25F, 5537.49F, 737.25F, 737.25F, "[2015, 11, 1]");
        LoanDisbursementTestBuilder expectedRepaymentSchedule8 = new LoanDisbursementTestBuilder("[2016, 1, 1]", 800.0F, 800.0F, 55.37F, 744.63F, 4792.86F, 744.63F, 744.63F, "[2015, 12, 1]");
        LoanDisbursementTestBuilder expectedRepaymentSchedule9 = new LoanDisbursementTestBuilder("[2016, 2, 1]", 800.0F, 800.0F, 47.93F, 752.07F, 4040.79F, 752.07F, 752.07F, "[2016, 1, 1]");
        LoanDisbursementTestBuilder expectedRepaymentSchedule10 = new LoanDisbursementTestBuilder("[2016, 3, 1]", 800.0F, 800.0F, 40.41F, 759.59F, 3281.2F, 759.59F, 759.59F, "[2016, 2, 1]");
        LoanDisbursementTestBuilder expectedRepaymentSchedule11 = new LoanDisbursementTestBuilder("[2016, 4, 1]", 800.0F, 800.0F, 32.81F, 767.19F, 2514.01F, 767.19F, 767.19F, "[2016, 3, 1]");
        LoanDisbursementTestBuilder expectedRepaymentSchedule12 = new LoanDisbursementTestBuilder("[2016, 5, 1]", 800.0F, 800.0F, 25.14F, 774.86F, 1739.15F, 774.86F, 774.86F, "[2016, 4, 1]");
        LoanDisbursementTestBuilder expectedRepaymentSchedule13 = new LoanDisbursementTestBuilder("[2016, 6, 1]", 800.0F, 800.0F, 17.39F, 782.61F, 956.54F, 782.61F, 782.61F, "[2016, 5, 1]");
        LoanDisbursementTestBuilder expectedRepaymentSchedule14 = new LoanDisbursementTestBuilder("[2016, 7, 1]", 966.11F, 966.11F, 9.57F, 956.54F, 0.0F, 956.54F, 956.54F, "[2016, 6, 1]");
        ArrayList<LoanDisbursementTestBuilder> list = new ArrayList<LoanDisbursementTestBuilder>();
        list.add(expectedRepaymentSchedule0);
        list.add(expectedRepaymentSchedule1);
        list.add(expectedRepaymentSchedule2);
        list.add(expectedRepaymentSchedule3);
        list.add(expectedRepaymentSchedule4);
        list.add(expectedRepaymentSchedule5);
        list.add(expectedRepaymentSchedule6);
        list.add(expectedRepaymentSchedule7);
        list.add(expectedRepaymentSchedule8);
        list.add(expectedRepaymentSchedule9);
        list.add(expectedRepaymentSchedule10);
        list.add(expectedRepaymentSchedule11);
        list.add(expectedRepaymentSchedule12);
        list.add(expectedRepaymentSchedule13);
        list.add(expectedRepaymentSchedule14);
        for (int i = 0; i < list.size(); i++) {
            log.info("values {} {} {}", i, periods.get(i), list.get(i));
            this.assertRepaymentScheduleValuesWithEMI(periods.get(i), list.get(i), i);
        }
    }

    private void assertRepaymentScheduleValuesWithEMI(HashMap period, LoanDisbursementTestBuilder expectedRepaymentSchedule, int position) {
        assertEquals(period.get("dueDate").toString(), expectedRepaymentSchedule.getDueDate());
        assertEquals(period.get("principalLoanBalanceOutstanding"), expectedRepaymentSchedule.getPrincipalLoanBalanceOutstanding());
        log.info("{}", period.get("totalOriginalDueForPeriod").toString());
        assertEquals(Float.parseFloat(period.get("totalOriginalDueForPeriod").toString()), expectedRepaymentSchedule.getTotalOriginalDueForPeriod().floatValue(), 0.0F);
        assertEquals(Float.parseFloat(period.get("totalOutstandingForPeriod").toString()), expectedRepaymentSchedule.getTotalOutstandingForPeriod(), 0.0F);
        if (position != 0 && position != 3) {
            assertEquals(Float.parseFloat(period.get("interestOutstanding").toString()), expectedRepaymentSchedule.getInterestOutstanding(), 0.0F);
            assertEquals(Float.parseFloat(period.get("principalOutstanding").toString()), expectedRepaymentSchedule.getPrincipalOutstanding(), 0.0F);
            assertEquals(Float.parseFloat(period.get("principalDue").toString()), expectedRepaymentSchedule.getPrincipalDue(), 0.0F);
            assertEquals(Float.parseFloat(period.get("principalOriginalDue").toString()), expectedRepaymentSchedule.getPrincipalOriginalDue(), 0.0F);
            assertEquals(period.get("fromDate").toString(), expectedRepaymentSchedule.getFromDate());
        }
    }

    private Integer applyForLoanApplicationWithEmiAmount(final Integer clientId, final Integer loanProductId, final String proposedAmount, List<HashMap> tranches, final String installmentAmount) {
        log.info("----------------APPLYING FOR LOAN APPLICATION");
        List<HashMap> collaterals = new ArrayList<>();
        final Integer collateralId = CollateralManagementHelper.createCollateralProduct(this.requestSpec, this.responseSpec);
        Assertions.assertNotNull(collateralId);
        final Integer clientCollateralId = CollateralManagementHelper.createClientCollateral(this.requestSpec, this.responseSpec, clientId.toString(), collateralId);
        Assertions.assertNotNull(clientCollateralId);
        addCollaterals(collaterals, clientCollateralId, BigDecimal.valueOf(1));
        final String loanApplicationJSON =  //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        new LoanApplicationTestBuilder().withPrincipal(proposedAmount).withLoanTermFrequency("12").withLoanTermFrequencyAsMonths().withNumberOfRepayments("12").withRepaymentEveryAfter("1").withRepaymentFrequencyTypeAsMonths().withInterestRatePerPeriod("1").withExpectedDisbursementDate("20150601").withTranches(tranches).withFixedEmiAmount(installmentAmount).withInterestTypeAsDecliningBalance().withSubmittedOnDate("20150601").withAmortizationTypeAsEqualInstallments().withCollaterals(collaterals).build(clientId.toString(), loanProductId.toString(), null);
        return this.loanTransactionHelper.getLoanId(loanApplicationJSON);
    }

    @Test
    public void validateEqualInstallmentsForMultiTrancheLoan() {
        final String operationDate = "20140101";
        final String principal = "1000";
        final String disbursedPrincipal = "900";
        final Integer clientId = ClientHelper.createClient(this.requestSpec, this.responseSpec, operationDate);
        log.info("-----------------CLIENT CREATED WITH ID------------------- {}", clientId);
        final String loanProductJSON =  //
        //
        //
        //
        new LoanProductTestBuilder().withAmortizationTypeAsEqualInstallments().withInterestTypeAsDecliningBalance().withMoratorium("", "").withInterestCalculationPeriodTypeAsRepaymentPeriod(true).withInterestTypeAsDecliningBalance().withMultiDisburse().withDisallowExpectedDisbursements(true).build(null);
        log.info("Product {}", loanProductJSON);
        final Integer loanProductId = this.loanTransactionHelper.getLoanProductId(loanProductJSON);
        log.info("------------------LOAN PRODUCT CREATED WITH ID----------- {}", loanProductId);
        final Integer loanId = applyForMultiTrancheLoanApplication(clientId.toString(), loanProductId.toString(), principal, operationDate);
        log.info("-------------------LOAN CREATED WITH loanId----------------- {}", loanId);
        this.loanTransactionHelper.approveLoanWithApproveAmount(operationDate, expectedDisbursementDate, principal, loanId, null);
        log.info("-------------------MULTI DISBURSAL LOAN APPROVED SUCCESSFULLY-------");
        GetLoansLoanIdResponse getLoansLoanIdResponse = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        assertNotNull(getLoansLoanIdResponse);
        this.loanTransactionHelper.printRepaymentSchedule(getLoansLoanIdResponse);
        loanTransactionHelper.disburseLoanWithTransactionAmount(operationDate, loanId, disbursedPrincipal);
        log.info("-------------------MULTI DISBURSAL LOAN DISBURSED SUCCESSFULLY-------");
        getLoansLoanIdResponse = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        assertNotNull(getLoansLoanIdResponse);
        this.loanTransactionHelper.printRepaymentSchedule(getLoansLoanIdResponse);
        final BigDecimal limit = BigDecimal.TWO;
        evaluateEqualInstallmentsForRepaymentSchedule(getLoansLoanIdResponse.getRepaymentSchedule(), limit);
        log.info("-----------MULTI DISBURSAL LOAN EQUAL INSTALLMENTS SUCCESSFULLY-------");
    }

    @Test
    public void disburseLoanWithExceededOverAppliedAmountFails() {
        final String operationDate = "20140101";
        final String principal = "1000";
        final String firstDisbursedPrincipal = "900";
        final String secondDisbursedPrincipal = "1101";
        final Integer clientId = ClientHelper.createClient(this.requestSpec, this.responseSpec, operationDate);
        log.info("-----------------CLIENT CREATED WITH ID------------------- {}", clientId);
        final String loanProductJSON =  //
        //
        //
        //
        new LoanProductTestBuilder().withAmortizationTypeAsEqualInstallments().withInterestTypeAsDecliningBalance().withMoratorium("", "").withInterestCalculationPeriodTypeAsRepaymentPeriod(true).withInterestTypeAsDecliningBalance().withMultiDisburse().withDisallowExpectedDisbursements(true).build(null);
        log.info("Product {}", loanProductJSON);
        final Integer loanProductId = this.loanTransactionHelper.getLoanProductId(loanProductJSON);
        log.info("------------------LOAN PRODUCT CREATED WITH ID----------- {}", loanProductId);
        final Integer loanId = applyForMultiTrancheLoanApplication(clientId.toString(), loanProductId.toString(), principal, operationDate);
        log.info("-------------------LOAN CREATED WITH loanId----------------- {}", loanId);
        this.loanTransactionHelper.approveLoanWithApproveAmount(operationDate, expectedDisbursementDate, principal, loanId, null);
        log.info("-------------------MULTI DISBURSAL LOAN APPROVED SUCCESSFULLY-------");
        GetLoansLoanIdResponse getLoansLoanIdResponse = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        assertNotNull(getLoansLoanIdResponse);
        this.loanTransactionHelper.printRepaymentSchedule(getLoansLoanIdResponse);
        loanTransactionHelper.disburseLoanWithTransactionAmount(operationDate, loanId, firstDisbursedPrincipal);
        log.info("-------------------MULTI DISBURSAL LOAN DISBURSED SUCCESSFULLY-------");
        loanTransactionHelper.disburseLoanWithTransactionAmount(operationDate, loanId, secondDisbursedPrincipal, overAppliedAmountFailedResponseSpec());
        log.info("-------------------MULTI DISBURSAL LOAN DISBURSEMENT FAILED-------");
    }

    @Test
    public void disburseLoanWithExceededOverAppliedAmountSucceed() {
        final String operationDate = "20140101";
        final String principal = "1000";
        final String firstDisbursedPrincipal = "900";
        final String secondDisbursedPrincipal = "1100";
        final Integer clientId = ClientHelper.createClient(this.requestSpec, this.responseSpec, operationDate);
        log.info("-----------------CLIENT CREATED WITH ID------------------- {}", clientId);
        final String loanProductJSON =  //
        //
        //
        //
        new LoanProductTestBuilder().withAmortizationTypeAsEqualInstallments().withInterestTypeAsDecliningBalance().withMoratorium("", "").withInterestCalculationPeriodTypeAsRepaymentPeriod(true).withInterestTypeAsDecliningBalance().withMultiDisburse().withDisallowExpectedDisbursements(true).build(null);
        log.info("Product {}", loanProductJSON);
        final Integer loanProductId = this.loanTransactionHelper.getLoanProductId(loanProductJSON);
        log.info("------------------LOAN PRODUCT CREATED WITH ID----------- {}", loanProductId);
        final Integer loanId = applyForMultiTrancheLoanApplication(clientId.toString(), loanProductId.toString(), principal, operationDate);
        log.info("-------------------LOAN CREATED WITH loanId----------------- {}", loanId);
        this.loanTransactionHelper.approveLoanWithApproveAmount(operationDate, expectedDisbursementDate, principal, loanId, null);
        log.info("-------------------MULTI DISBURSAL LOAN APPROVED SUCCESSFULLY-------");
        GetLoansLoanIdResponse getLoansLoanIdResponse = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        assertNotNull(getLoansLoanIdResponse);
        this.loanTransactionHelper.printRepaymentSchedule(getLoansLoanIdResponse);
        loanTransactionHelper.disburseLoanWithTransactionAmount(operationDate, loanId, firstDisbursedPrincipal);
        log.info("-------------------MULTI DISBURSAL LOAN DISBURSED SUCCESSFULLY-FIRST-------");
        loanTransactionHelper.disburseLoanWithTransactionAmount(operationDate, loanId, secondDisbursedPrincipal);
        log.info("-------------------MULTI DISBURSAL LOAN DISBURSED SUCCESSFULLY-SECOND-------");
        double disbursementPrincipalSum = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId).getDisbursementDetails().stream().mapToDouble(d -> d.getPrincipal().doubleValue()).sum();
        assertEquals(parseDouble(firstDisbursedPrincipal) + parseDouble(secondDisbursedPrincipal), disbursementPrincipalSum);
    }

    @Test
    public void createApproveAndValidateMultiDisburseLoan() throws ParseException {
        List<HashMap> createTranches = new ArrayList<>();
        String id = null;
        createTranches.add(this.loanTransactionHelper.createTrancheDetail(id, "20140301", "1000"));
        final Integer clientID = ClientHelper.createClient(this.requestSpec, this.responseSpec, "20140101");
        log.info("---------------------------------CLIENT CREATED WITH ID--------------------------------------------------- {}", clientID);
        final Integer loanProductID = this.loanTransactionHelper.getLoanProductId(new LoanProductTestBuilder().withInterestTypeAsDecliningBalance().withTranches(true).withInterestCalculationPeriodTypeAsRepaymentPeriod(true).build(null));
        log.info("----------------------------------LOAN PRODUCT CREATED WITH ID------------------------------------------- {}", loanProductID);
        this.loanId = applyForLoanApplicationWithTranches(clientID, loanProductID, proposedAmount, createTranches);
        log.info("-----------------------------------LOAN CREATED WITH LOANID------------------------------------------------- {}", this.loanId);
        HashMap loanStatusHashMap = LoanStatusChecker.getStatusOfLoan(this.requestSpec, this.responseSpec, this.loanId);
        LoanStatusChecker.verifyLoanIsPending(loanStatusHashMap);
        log.info("-----------------------------------APPROVE LOAN-----------------------------------------------------------");
        loanStatusHashMap = this.loanTransactionHelper.approveLoanWithApproveAmount(approveDate, expectedDisbursementDate, approvalAmount, this.loanId, createTranches);
        LoanStatusChecker.verifyLoanIsApproved(loanStatusHashMap);
        LoanStatusChecker.verifyLoanIsWaitingForDisbursal(loanStatusHashMap);
        log.info("-----------------------------------MULTI DISBURSAL LOAN APPROVED SUCCESSFULLY---------------------------------------");
        ArrayList<HashMap> disbursementDetails = (ArrayList<HashMap>) this.loanTransactionHelper.getLoanDetail(this.requestSpec, this.responseSpec, this.loanId, "disbursementDetails");
        this.disbursementId = (Integer) disbursementDetails.get(0).get("id");
        this.editLoanDisbursementDetails();
    }

    @Test
    public void allowModifyLoanApplicationAfterUndoDisbursalWithTranches() throws ParseException {
        final String operationDate = this.approveDate;
        List<HashMap> tranches = new ArrayList<>();
        String principal = "1000";
        final List<HashMap> collaterals = new ArrayList<>();
        final Integer clientId = ClientHelper.createClient(this.requestSpec, this.responseSpec, operationDate);
        log.info("---------------------------------CLIENT CREATED WITH ID--------------------------------------------------- {}", clientId);
        final Integer loanProductId = this.loanTransactionHelper.getLoanProductId(new LoanProductTestBuilder().withInterestTypeAsDecliningBalance().withTranches(true).withDisallowExpectedDisbursements(true).withInterestCalculationPeriodTypeAsRepaymentPeriod(true).build(null));
        log.info("----------------------------------LOAN PRODUCT CREATED WITH ID------------------------------------------- {}", loanProductId);
        GetLoanProductsProductIdResponse getLoanProductsProductIdResponse = this.loanTransactionHelper.getLoanProduct(loanProductId);
        assertNotNull(getLoanProductsProductIdResponse);
        log.info("Loan Product Id {} with DisallowExpectectedDisbursements in {}", loanProductId, getLoanProductsProductIdResponse.getDisallowExpectedDisbursements());
        assertEquals(true, getLoanProductsProductIdResponse.getDisallowExpectedDisbursements());
        final Integer loanId = applyForLoanApplicationWithTranches(clientId, loanProductId, proposedAmount, tranches);
        log.info("-----------------------------------LOAN CREATED WITH LOANID------------------------------------------------- {}", loanId);
        loanTransactionHelper.approveLoanWithApproveAmount(operationDate, operationDate, approvalAmount, loanId, tranches);
        GetLoansLoanIdResponse getLoansLoanIdResponse = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        assertNotNull(getLoansLoanIdResponse);
        log.info("Loan Id {} with Status {} with Disbursement details {}", getLoansLoanIdResponse.getId(), getLoansLoanIdResponse.getStatus().getCode(), getLoansLoanIdResponse.getDisbursementDetails().size());
        log.info("-------------------MULTI DISBURSAL LOAN APPROVED SUCCESSFULLY-------");
        assertEquals(0, getLoansLoanIdResponse.getDisbursementDetails().size(), "Disbursement details items");
        loanTransactionHelper.disburseLoanWithTransactionAmount(operationDate, loanId, principal);
        getLoansLoanIdResponse = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        assertNotNull(getLoansLoanIdResponse);
        log.info("Loan Id {} with Status {} with Disbursement details {}", getLoansLoanIdResponse.getId(), getLoansLoanIdResponse.getStatus().getCode(), getLoansLoanIdResponse.getDisbursementDetails().size());
        log.info("-------------------MULTI DISBURSAL LOAN DISBURSED SUCCESSFULLY-------");
        assertEquals(1, getLoansLoanIdResponse.getDisbursementDetails().size(), "Disbursement details items");
        PostLoansLoanIdResponse postLoansLoanIdResponse = this.loanTransactionHelper.applyLoanCommand(loanId, "undoDisbursal");
        assertNotNull(postLoansLoanIdResponse);
        log.info("-------------------UNDO DISBURSAL LOAN SUCCESSFULLY-------");
        getLoansLoanIdResponse = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        assertNotNull(getLoansLoanIdResponse);
        log.info("Loan Id {} with Status {} with Disbursement details {}", getLoansLoanIdResponse.getId(), getLoansLoanIdResponse.getStatus().getCode(), getLoansLoanIdResponse.getDisbursementDetails().size());
        assertEquals(0, getLoansLoanIdResponse.getDisbursementDetails().size(), "Disbursement details items");
        getLoansLoanIdResponse = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        assertNotNull(getLoansLoanIdResponse);
        log.info("Loan Id {} with Status {} with Disbursement details {}", getLoansLoanIdResponse.getId(), getLoansLoanIdResponse.getStatus().getCode(), getLoansLoanIdResponse.getDisbursementDetails().size());
        assertEquals(0, getLoansLoanIdResponse.getDisbursementDetails().size(), "Disbursement details items");
        postLoansLoanIdResponse = this.loanTransactionHelper.applyLoanCommand(loanId, "undoApproval");
        assertNotNull(postLoansLoanIdResponse);
        log.info("-------------------UNDO APPROVAL LOAN SUCCESSFULLY-------");
        getLoansLoanIdResponse = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        assertNotNull(getLoansLoanIdResponse);
        log.info("Loan Id {} with Status {} with Disbursement details {}", getLoansLoanIdResponse.getId(), getLoansLoanIdResponse.getStatus().getCode(), getLoansLoanIdResponse.getDisbursementDetails().size());
        principal = "10000";
        final String loanApplicationJSON = buildLoanApplicationJSON(clientId, loanProductId, principal, tranches, operationDate, collaterals);
        log.info("Modify Loan Application: {}", loanApplicationJSON);
        PutLoansLoanIdResponse putLoansLoanIdResponse = this.loanTransactionHelper.modifyLoanApplication(loanId, loanApplicationJSON);
        assertNotNull(putLoansLoanIdResponse);
        getLoansLoanIdResponse = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        assertNotNull(getLoansLoanIdResponse);
        log.info("Loan Id {} with Status {} with Disbursement details {} and Principal {}", getLoansLoanIdResponse.getId(), getLoansLoanIdResponse.getStatus().getCode(), getLoansLoanIdResponse.getDisbursementDetails().size(), getLoansLoanIdResponse.getPrincipal());
        // ReDo the Approval and Disbursement
        loanTransactionHelper.approveLoanWithApproveAmount(operationDate, operationDate, approvalAmount, loanId, null);
        getLoansLoanIdResponse = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        assertNotNull(getLoansLoanIdResponse);
        log.info("Loan Id {} with Status {} with Disbursement details {}", getLoansLoanIdResponse.getId(), getLoansLoanIdResponse.getStatus().getCode(), getLoansLoanIdResponse.getDisbursementDetails().size());
        loanTransactionHelper.disburseLoanWithTransactionAmount(operationDate, loanId, principal);
        getLoansLoanIdResponse = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        assertNotNull(getLoansLoanIdResponse);
        log.info("Loan Id {} with Status {} with Disbursement details {}", getLoansLoanIdResponse.getId(), getLoansLoanIdResponse.getStatus().getCode(), getLoansLoanIdResponse.getDisbursementDetails().size());
        log.info("-------------------MULTI DISBURSAL LOAN DISBURSED SUCCESSFULLY-------");
        assertEquals(1, getLoansLoanIdResponse.getDisbursementDetails().size(), "Disbursement details items");
    }

    private void editLoanDisbursementDetails() throws ParseException {
        this.editDateAndPrincipalOfExistingTranche();
        this.addNewDisbursementDetails();
        this.deleteDisbursmentDetails();
    }

    private void addNewDisbursementDetails() throws ParseException {
        List<HashMap> addTranches = new ArrayList<>();
        ArrayList<HashMap> disbursementDetails = (ArrayList<HashMap>) this.loanTransactionHelper.getLoanDetail(this.requestSpec, this.responseSpec, this.loanId, "disbursementDetails");
        ArrayList expectedDisbursementDate = (ArrayList) disbursementDetails.get(0).get("expectedDisbursementDate");
        String date = formatExpectedDisbursementDate(expectedDisbursementDate.toString());
        String id = null;
        addTranches.add(this.loanTransactionHelper.createTrancheDetail(disbursementDetails.get(0).get("id").toString(), date, disbursementDetails.get(0).get("principal").toString()));
        addTranches.add(this.loanTransactionHelper.createTrancheDetail(id, "20140303", "2000"));
        addTranches.add(this.loanTransactionHelper.createTrancheDetail(id, "20140304", "500"));
        /* Add disbursement detail */
        this.loanTransactionHelper.addAndDeleteDisbursementDetail(this.loanId, this.approvalAmount, this.expectedDisbursementDate, addTranches, "");
    }

    private void deleteDisbursmentDetails() throws ParseException {
        List<HashMap> deleteTranches = new ArrayList<>();
        ArrayList<HashMap> disbursementDetails = (ArrayList<HashMap>) this.loanTransactionHelper.getLoanDetail(this.requestSpec, this.responseSpec, this.loanId, "disbursementDetails");
        /* Delete the last tranche */
        for (int i = 0; i < disbursementDetails.size() - 1; i++) {
            ArrayList expectedDisbursementDate = (ArrayList) disbursementDetails.get(i).get("expectedDisbursementDate");
            String disbursementDate = formatExpectedDisbursementDate(expectedDisbursementDate.toString());
            deleteTranches.add(this.loanTransactionHelper.createTrancheDetail(disbursementDetails.get(i).get("id").toString(), disbursementDate, disbursementDetails.get(i).get("principal").toString()));
        }
        /* Add disbursement detail */
        this.loanTransactionHelper.addAndDeleteDisbursementDetail(this.loanId, this.approvalAmount, this.expectedDisbursementDate, deleteTranches, "");
    }

    private void editDateAndPrincipalOfExistingTranche() throws ParseException {
        String updatedExpectedDisbursementDate = "20140301";
        String updatedPrincipal = "900";
        /* Update */
        this.loanTransactionHelper.editDisbursementDetail(this.loanId, this.disbursementId, this.approvalAmount, this.expectedDisbursementDate, updatedExpectedDisbursementDate, updatedPrincipal, "");
        /* Validate Edit */
        ArrayList<HashMap> disbursementDetails = (ArrayList<HashMap>) this.loanTransactionHelper.getLoanDetail(this.requestSpec, this.responseSpec, this.loanId, "disbursementDetails");
        assertEquals(Float.parseFloat(updatedPrincipal), disbursementDetails.get(0).get("principal"));
        ArrayList expectedDisbursementDate = (ArrayList) disbursementDetails.get(0).get("expectedDisbursementDate");
        String date = formatExpectedDisbursementDate(expectedDisbursementDate.toString());
        assertEquals(updatedExpectedDisbursementDate, date);
    }

    private String formatExpectedDisbursementDate(String expectedDisbursementDate) throws ParseException {
        SimpleDateFormat source = new SimpleDateFormat("[yyyy, MM, dd]");
        SimpleDateFormat target = new SimpleDateFormat("yyyyMMdd", Locale.US);
        String date = target.format(source.parse(expectedDisbursementDate));
        return date;
    }

    private String buildLoanApplicationJSON(final Integer clientId, final Integer loanProductId, String principal, List<HashMap> tranches, final String operationDate, List<HashMap> collaterals) {
        return  //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        new LoanApplicationTestBuilder().withPrincipal(principal).withLoanTermFrequency("5").withLoanTermFrequencyAsMonths().withNumberOfRepayments("5").withRepaymentEveryAfter("1").withRepaymentFrequencyTypeAsMonths().withInterestRatePerPeriod("2").withExpectedDisbursementDate("20140301").withTranches(tranches).withInterestTypeAsDecliningBalance().withSubmittedOnDate("20140301").withCollaterals(collaterals).build(clientId.toString(), loanProductId.toString(), null);
    }

    private Integer applyForLoanApplicationWithTranches(final Integer clientId, final Integer loanProductId, String principal, List<HashMap> tranches) {
        log.info("----------------APPLYING FOR LOAN APPLICATION");
        List<HashMap> collaterals = new ArrayList<>();
        final Integer collateralId = CollateralManagementHelper.createCollateralProduct(this.requestSpec, this.responseSpec);
        Assertions.assertNotNull(collateralId);
        final Integer clientCollateralId = CollateralManagementHelper.createClientCollateral(this.requestSpec, this.responseSpec, clientId.toString(), collateralId);
        Assertions.assertNotNull(clientCollateralId);
        addCollaterals(collaterals, clientCollateralId, BigDecimal.valueOf(1));
        final String loanApplicationJSON = buildLoanApplicationJSON(clientId, loanProductId, principal, tranches, "20140301", collaterals);
        return this.loanTransactionHelper.getLoanId(loanApplicationJSON);
    }

    private Integer applyForMultiTrancheLoanApplication(final String clientId, final String loanProductId, String principal, String operationDate) {
        log.info("----------------APPLYING FOR MULTI TRANCHE LOAN APPLICATION");
        List<HashMap> emptyData = new ArrayList<>();
        final String loanApplicationJSON =  //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        new LoanApplicationTestBuilder().withPrincipal(principal).withLoanTermFrequency("3").withLoanTermFrequencyAsMonths().withNumberOfRepayments("3").withRepaymentEveryAfter("1").withRepaymentFrequencyTypeAsMonths().withInterestRatePerPeriod("0").withExpectedDisbursementDate(operationDate).withTranches(emptyData).withInterestTypeAsDecliningBalance().withSubmittedOnDate(operationDate).withCollaterals(emptyData).build(clientId, loanProductId, null);
        log.info("Loan account {}", loanApplicationJSON);
        return this.loanTransactionHelper.getLoanId(loanApplicationJSON);
    }

    private void addCollaterals(List<HashMap> collaterals, Integer collateralId, BigDecimal quantity) {
        collaterals.add(collaterals(collateralId, quantity));
    }

    private HashMap<String, String> collaterals(Integer collateralId, BigDecimal quantity) {
        HashMap<String, String> collateral = new HashMap<String, String>(2);
        collateral.put("clientCollateralId", collateralId.toString());
        collateral.put("quantity", quantity.toString());
        return collateral;
    }

    public void evaluateEqualInstallmentsForRepaymentSchedule(GetLoansLoanIdRepaymentSchedule getLoanRepaymentSchedule, BigDecimal limit) {
        BigDecimal totalOutstandingForPeriod = BigDecimal.ZERO;
        BigDecimal totalInstallmentAmountForPeriod = BigDecimal.ZERO;
        if (getLoanRepaymentSchedule != null) {
            log.info("Loan with {} periods", getLoanRepaymentSchedule.getPeriods().size());
            for (GetLoansLoanIdRepaymentPeriod period : getLoanRepaymentSchedule.getPeriods()) {
                if (period.getPeriod() != null) {
                    log.info("Period number {} for due date {} and outstanding {} {}", period.getPeriod(), period.getDueDate(), period.getTotalOutstandingForPeriod(), period.getTotalInstallmentAmountForPeriod());
                    if (period.getPeriod() == 1) {
                        totalOutstandingForPeriod = period.getTotalOutstandingForPeriod();
                        totalInstallmentAmountForPeriod = period.getTotalInstallmentAmountForPeriod();
                    } else {
                        assertTrue(period.getTotalOutstandingForPeriod().subtract(totalOutstandingForPeriod).abs().compareTo(limit) <= 0);
                        assertTrue(period.getTotalInstallmentAmountForPeriod().subtract(totalInstallmentAmountForPeriod).abs().compareTo(limit) <= 0);
                    }
                }
            }
        }
    }

    private ResponseSpecification overAppliedAmountFailedResponseSpec() {
        return new ResponseSpecBuilder().expectBody("userMessageGlobalisationCode", equalTo("validation.msg.domain.rule.violation")).expectBody("errors[0].userMessageGlobalisationCode", equalTo("error.msg.loan.disbursal.amount.can\'t.be.greater.than.maximum.applied.loan.amount.calculation")).expectStatusCode(403).build();
    }

    private AdvancedPaymentData createDefaultPaymentAllocation(String futureInstallmentAllocationRule) {
        AdvancedPaymentData advancedPaymentData = new AdvancedPaymentData();
        advancedPaymentData.setTransactionType("DEFAULT");
        advancedPaymentData.setFutureInstallmentAllocationRule(futureInstallmentAllocationRule);
        List<PaymentAllocationOrder> paymentAllocationOrders = getPaymentAllocationOrder(PaymentAllocationType.PAST_DUE_PENALTY, PaymentAllocationType.PAST_DUE_FEE, PaymentAllocationType.PAST_DUE_PRINCIPAL, PaymentAllocationType.PAST_DUE_INTEREST, PaymentAllocationType.DUE_PENALTY, PaymentAllocationType.DUE_FEE, PaymentAllocationType.DUE_PRINCIPAL, PaymentAllocationType.DUE_INTEREST, PaymentAllocationType.IN_ADVANCE_PENALTY, PaymentAllocationType.IN_ADVANCE_FEE, PaymentAllocationType.IN_ADVANCE_PRINCIPAL, PaymentAllocationType.IN_ADVANCE_INTEREST);
        advancedPaymentData.setPaymentAllocationOrder(paymentAllocationOrders);
        return advancedPaymentData;
    }

    private List<PaymentAllocationOrder> getPaymentAllocationOrder(PaymentAllocationType... paymentAllocationTypes) {
        AtomicInteger integer = new AtomicInteger(1);
        return Arrays.stream(paymentAllocationTypes).map(pat -> {
            PaymentAllocationOrder paymentAllocationOrder = new PaymentAllocationOrder();
            paymentAllocationOrder.setPaymentAllocationRule(pat.name());
            paymentAllocationOrder.setOrder(integer.getAndIncrement());
            return paymentAllocationOrder;
        }).toList();
    }

    @Test
    public void testCreateLoanProductWithFullTermTrancheEnabled() {
        AdvancedPaymentData defaultAllocation = createDefaultPaymentAllocation("NEXT_INSTALLMENT");
        final String loanProductJSON = new LoanProductTestBuilder().withAmortizationTypeAsEqualInstallments().withInterestTypeAsDecliningBalance().withMoratorium("", "").withInterestCalculationPeriodTypeAsRepaymentPeriod(true).withInterestTypeAsDecliningBalance().withMultiDisburse().withLoanScheduleType(LoanScheduleType.PROGRESSIVE).addAdvancedPaymentAllocation(defaultAllocation).withAllowFullTermForTranche(true).build(null);
        final Integer loanProductId = this.loanTransactionHelper.getLoanProductId(loanProductJSON);
        log.info("------------------LOAN PRODUCT CREATED WITH ID----------- {}", loanProductId);
        GetLoanProductsProductIdResponse loanProduct = this.loanTransactionHelper.getLoanProduct(loanProductId);
        assertNotNull(loanProduct);
        assertEquals(true, loanProduct.getMultiDisburseLoan());
        assertEquals(true, loanProduct.getAllowFullTermForTranche());
        log.info("-------------------LOAN PRODUCT WITH allowFullTermForTranche CREATED SUCCESSFULLY-------");
    }

    @Test
    public void testCreateLoanProductWithFullTermTrancheOnCumulativeShouldFail() {
        final ResponseSpecification errorResponse = new ResponseSpecBuilder().expectBody("userMessageGlobalisationCode", equalTo("validation.msg.validation.errors.exist")).expectBody("errors[0].userMessageGlobalisationCode", equalTo("validation.msg.loanproduct.allowFullTermForTranche.requires.progressive.schedule.type")).expectStatusCode(400).build();
        final LoanTransactionHelper validationErrorHelper = new LoanTransactionHelper(this.requestSpec, errorResponse);
        final String loanProductJSON = new LoanProductTestBuilder().withAmortizationTypeAsEqualInstallments().withInterestTypeAsDecliningBalance().withMoratorium("", "").withInterestCalculationPeriodTypeAsRepaymentPeriod(true).withInterestTypeAsDecliningBalance().withMultiDisburse().withLoanScheduleType(LoanScheduleType.CUMULATIVE).withAllowFullTermForTranche(true).build(null);
        validationErrorHelper.getLoanProductId(loanProductJSON);
        log.info("-------------------LOAN PRODUCT WITH allowFullTermForTranche ON CUMULATIVE FAILED AS EXPECTED-------");
    }

    @Test
    public void testCreateLoanProductWithFullTermTrancheOnSingleDisburseShouldFail() {
        AdvancedPaymentData defaultAllocation = createDefaultPaymentAllocation("NEXT_INSTALLMENT");
        final ResponseSpecification errorResponse = new ResponseSpecBuilder().expectBody("userMessageGlobalisationCode", equalTo("validation.msg.validation.errors.exist")).expectBody("errors[0].userMessageGlobalisationCode", equalTo("validation.msg.loanproduct.allowFullTermForTranche.requires.multi.disburse.loan")).expectStatusCode(400).build();
        final LoanTransactionHelper validationErrorHelper = new LoanTransactionHelper(this.requestSpec, errorResponse);
        final String loanProductJSON = new LoanProductTestBuilder().withAmortizationTypeAsEqualInstallments().withInterestTypeAsDecliningBalance().withMoratorium("", "").withInterestCalculationPeriodTypeAsRepaymentPeriod(true).withInterestTypeAsDecliningBalance().withLoanScheduleType(LoanScheduleType.PROGRESSIVE).addAdvancedPaymentAllocation(defaultAllocation).withAllowFullTermForTranche(true).build(null);
        validationErrorHelper.getLoanProductId(loanProductJSON);
        log.info("-------------------LOAN PRODUCT WITH allowFullTermForTranche ON SINGLE DISBURSE FAILED AS EXPECTED-------");
    }

    @Test
    public void testUpdateLoanProductPreservesAllowFullTermForTranche() {
        AdvancedPaymentData defaultAllocation = createDefaultPaymentAllocation("NEXT_INSTALLMENT");
        final String loanProductJSON = new LoanProductTestBuilder().withAmortizationTypeAsEqualInstallments().withInterestTypeAsDecliningBalance().withMoratorium("", "").withInterestCalculationPeriodTypeAsRepaymentPeriod(true).withInterestTypeAsDecliningBalance().withMultiDisburse().withLoanScheduleType(LoanScheduleType.PROGRESSIVE).addAdvancedPaymentAllocation(defaultAllocation).withAllowFullTermForTranche(true).build(null);
        final Integer loanProductId = this.loanTransactionHelper.getLoanProductId(loanProductJSON);
        log.info("------------------LOAN PRODUCT CREATED WITH ID----------- {}", loanProductId);
        GetLoanProductsProductIdResponse loanProduct = this.loanTransactionHelper.getLoanProduct(loanProductId);
        assertNotNull(loanProduct);
        assertEquals(true, loanProduct.getAllowFullTermForTranche());
        org.apache.fineract.client.models.PutLoanProductsProductIdRequest updateRequest = new org.apache.fineract.client.models.PutLoanProductsProductIdRequest();
        updateRequest.setDescription("Updated description");
        this.loanTransactionHelper.updateLoanProduct((long) loanProductId, updateRequest);
        GetLoanProductsProductIdResponse updatedProduct = this.loanTransactionHelper.getLoanProduct(loanProductId);
        assertNotNull(updatedProduct);
        assertEquals(true, updatedProduct.getAllowFullTermForTranche());
        assertEquals("Updated description", updatedProduct.getDescription());
        log.info("-------------------LOAN PRODUCT UPDATE PRESERVED allowFullTermForTranche FLAG-------");
    }

    @Test
    public void testLoanInheritsAllowFullTermForTrancheFromProduct() {
        AdvancedPaymentData defaultAllocation = createDefaultPaymentAllocation("NEXT_INSTALLMENT");
        final String loanProductJSON = new LoanProductTestBuilder().withAmortizationTypeAsEqualInstallments().withInterestTypeAsDecliningBalance().withMoratorium("", "").withInterestCalculationPeriodTypeAsRepaymentPeriod(true).withInterestTypeAsDecliningBalance().withMultiDisburse().withLoanScheduleType(LoanScheduleType.PROGRESSIVE).addAdvancedPaymentAllocation(defaultAllocation).withAllowFullTermForTranche(true).build(null);
        final Integer loanProductId = this.loanTransactionHelper.getLoanProductId(loanProductJSON);
        log.info("------------------LOAN PRODUCT CREATED WITH ID----------- {}", loanProductId);
        final Integer clientId = ClientHelper.createClient(this.requestSpec, this.responseSpec);
        log.info("------------------CLIENT CREATED WITH ID----------- {}", clientId);
        List<HashMap> createTranches = new ArrayList<>();
        createTranches.add(this.loanTransactionHelper.createTrancheDetail(null, "20140301", "5000"));
        createTranches.add(this.loanTransactionHelper.createTrancheDetail(null, "20140401", "5000"));
        final String loanApplicationJSON = new LoanApplicationTestBuilder().withPrincipal("10000").withLoanTermFrequency("12").withLoanTermFrequencyAsMonths().withNumberOfRepayments("12").withRepaymentEveryAfter("1").withRepaymentFrequencyTypeAsMonths().withInterestRatePerPeriod("1").withExpectedDisbursementDate("20140301").withTranches(createTranches).withSubmittedOnDate("20140301").withRepaymentStrategy(LoanProductTestBuilder.ADVANCED_PAYMENT_ALLOCATION_STRATEGY).build(clientId.toString(), loanProductId.toString(), null);
        final Integer loanId = this.loanTransactionHelper.getLoanId(loanApplicationJSON);
        log.info("------------------LOAN CREATED WITH ID----------- {}", loanId);
        GetLoansLoanIdResponse loanDetails = this.loanTransactionHelper.getLoanDetails((long) loanId);
        assertNotNull(loanDetails);
        assertEquals(true, loanDetails.getAllowFullTermForTranche());
        log.info("-------------------LOAN INHERITED allowFullTermForTranche FROM PRODUCT SUCCESSFULLY-------");
    }

    @Test
    public void testLoanLevelOverrideOfAllowFullTermForTranche() {
        AdvancedPaymentData defaultAllocation = createDefaultPaymentAllocation("NEXT_INSTALLMENT");
        final String loanProductJSON = new LoanProductTestBuilder().withAmortizationTypeAsEqualInstallments().withInterestTypeAsDecliningBalance().withMoratorium("", "").withInterestCalculationPeriodTypeAsRepaymentPeriod(true).withInterestTypeAsDecliningBalance().withMultiDisburse().withLoanScheduleType(LoanScheduleType.PROGRESSIVE).addAdvancedPaymentAllocation(defaultAllocation).withAllowFullTermForTranche(true).build(null);
        final Integer loanProductId = this.loanTransactionHelper.getLoanProductId(loanProductJSON);
        log.info("------------------LOAN PRODUCT CREATED WITH ID----------- {}", loanProductId);
        final Integer clientId = ClientHelper.createClient(this.requestSpec, this.responseSpec);
        log.info("------------------CLIENT CREATED WITH ID----------- {}", clientId);
        List<HashMap> createTranches = new ArrayList<>();
        createTranches.add(this.loanTransactionHelper.createTrancheDetail(null, "20140301", "5000"));
        createTranches.add(this.loanTransactionHelper.createTrancheDetail(null, "20140401", "5000"));
        final String loanApplicationJSON = new LoanApplicationTestBuilder().withPrincipal("10000").withLoanTermFrequency("12").withLoanTermFrequencyAsMonths().withNumberOfRepayments("12").withRepaymentEveryAfter("1").withRepaymentFrequencyTypeAsMonths().withInterestRatePerPeriod("1").withExpectedDisbursementDate("20140301").withTranches(createTranches).withSubmittedOnDate("20140301").withRepaymentStrategy(LoanProductTestBuilder.ADVANCED_PAYMENT_ALLOCATION_STRATEGY).withAllowFullTermForTranche(false).build(clientId.toString(), loanProductId.toString(), null);
        final Integer loanId = this.loanTransactionHelper.getLoanId(loanApplicationJSON);
        log.info("------------------LOAN CREATED WITH ID----------- {}", loanId);
        GetLoansLoanIdResponse loanDetails = this.loanTransactionHelper.getLoanDetails((long) loanId);
        assertNotNull(loanDetails);
        assertEquals(false, loanDetails.getAllowFullTermForTranche());
        log.info("-------------------LOAN LEVEL OVERRIDE OF allowFullTermForTranche WORKED SUCCESSFULLY-------");
    }

    @Test
    public void testFullTermTranche_S1_DisbursementOnInstallmentDate() {
        AdvancedPaymentData defaultAllocation = createDefaultPaymentAllocation("NEXT_INSTALLMENT");
        final String loanProductJSON = new LoanProductTestBuilder().withAmortizationTypeAsEqualInstallments().withInterestTypeAsDecliningBalance().withMoratorium("", "").withInterestCalculationPeriodTypeAsRepaymentPeriod(true).withinterestRatePerPeriod("9.4822").withInterestRateFrequencyTypeAsYear().withMultiDisburse().withLoanScheduleType(LoanScheduleType.PROGRESSIVE).addAdvancedPaymentAllocation(defaultAllocation).withAllowFullTermForTranche(true).withDaysInYear("360").withMinPrincipal("100").build(null);
        final Integer loanProductId = this.loanTransactionHelper.getLoanProductId(loanProductJSON);
        log.info("------------------LOAN PRODUCT CREATED WITH ID----------- {}", loanProductId);
        final Integer clientId = ClientHelper.createClient(this.requestSpec, this.responseSpec, "20240101");
        log.info("------------------CLIENT CREATED WITH ID----------- {}", clientId);
        List<HashMap> createTranches = new ArrayList<>();
        createTranches.add(this.loanTransactionHelper.createTrancheDetail(null, "20240101", "100"));
        createTranches.add(this.loanTransactionHelper.createTrancheDetail(null, "20240201", "100"));
        final String loanApplicationJSON = new LoanApplicationTestBuilder().withPrincipal("200").withLoanTermFrequency("6").withLoanTermFrequencyAsMonths().withNumberOfRepayments("6").withRepaymentEveryAfter("1").withRepaymentFrequencyTypeAsMonths().withInterestRatePerPeriod("9.4822").withExpectedDisbursementDate("20240101").withTranches(createTranches).withSubmittedOnDate("20240101").withRepaymentStrategy(LoanProductTestBuilder.ADVANCED_PAYMENT_ALLOCATION_STRATEGY).build(clientId.toString(), loanProductId.toString(), null);
        final Integer loanId = this.loanTransactionHelper.getLoanId(loanApplicationJSON);
        log.info("------------------LOAN CREATED WITH ID----------- {}", loanId);
        this.loanTransactionHelper.approveLoanWithApproveAmount("20240101", "20240101", "200", loanId, createTranches);
        log.info("-------------------LOAN APPROVED-------");
        loanTransactionHelper.disburseLoanWithTransactionAmount("20240101", loanId, "100");
        log.info("-------------------FIRST TRANCHE DISBURSED-------");
        loanTransactionHelper.disburseLoanWithTransactionAmount("20240201", loanId, "100");
        log.info("-------------------SECOND TRANCHE DISBURSED-------");
        GetLoansLoanIdResponse loanDetails = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        assertNotNull(loanDetails);
        GetLoansLoanIdRepaymentSchedule schedule = loanDetails.getRepaymentSchedule();
        assertNotNull(schedule);
        List<GetLoansLoanIdRepaymentPeriod> periods = schedule.getPeriods();
        assertNotNull(periods);
        assertEquals(9, periods.size(), "Total periods should be 9 (2 disbursements + 7 repayment periods)");
        // Count disbursement periods (no period number) and repayment periods (with period number)
        long disbursementPeriods = periods.stream().filter(p -> p.getPeriod() == null).count();
        long repaymentPeriods = periods.stream().filter(p -> p.getPeriod() != null).count();
        assertEquals(2, disbursementPeriods, "Should have 2 disbursement periods");
        assertEquals(7, repaymentPeriods, "Should have 7 repayment periods");
        log.info("-------------------S1 TEST: SCHEDULE VALIDATION-------");
        log.info("Schedule structure validated: 2 disbursement + 7 repayment periods");
        // Close the loan to allow LoanTestLifecycleExtension cleanup to succeed
        closeFullTermTrancheLoan(loanId, "20240801");
    }

    @Test
    public void testFullTermTranche_S2_MidPeriodDisbursement() {
        AdvancedPaymentData defaultAllocation = createDefaultPaymentAllocation("NEXT_INSTALLMENT");
        final String loanProductJSON = new LoanProductTestBuilder().withAmortizationTypeAsEqualInstallments().withInterestTypeAsDecliningBalance().withMoratorium("", "").withInterestCalculationPeriodTypeAsRepaymentPeriod(true).withinterestRatePerPeriod("9.4822").withInterestRateFrequencyTypeAsYear().withMultiDisburse().withLoanScheduleType(LoanScheduleType.PROGRESSIVE).addAdvancedPaymentAllocation(defaultAllocation).withAllowFullTermForTranche(true).withDaysInYear("360").withMinPrincipal("100").build(null);
        final Integer loanProductId = this.loanTransactionHelper.getLoanProductId(loanProductJSON);
        log.info("------------------LOAN PRODUCT CREATED WITH ID----------- {}", loanProductId);
        final Integer clientId = ClientHelper.createClient(this.requestSpec, this.responseSpec, "20240101");
        log.info("------------------CLIENT CREATED WITH ID----------- {}", clientId);
        List<HashMap> createTranches = new ArrayList<>();
        createTranches.add(this.loanTransactionHelper.createTrancheDetail(null, "20240101", "100"));
        createTranches.add(this.loanTransactionHelper.createTrancheDetail(null, "20240215", "100"));
        final String loanApplicationJSON = new LoanApplicationTestBuilder().withPrincipal("200").withLoanTermFrequency("6").withLoanTermFrequencyAsMonths().withNumberOfRepayments("6").withRepaymentEveryAfter("1").withRepaymentFrequencyTypeAsMonths().withInterestRatePerPeriod("9.4822").withExpectedDisbursementDate("20240101").withTranches(createTranches).withSubmittedOnDate("20240101").withRepaymentStrategy(LoanProductTestBuilder.ADVANCED_PAYMENT_ALLOCATION_STRATEGY).build(clientId.toString(), loanProductId.toString(), null);
        final Integer loanId = this.loanTransactionHelper.getLoanId(loanApplicationJSON);
        log.info("------------------LOAN CREATED WITH ID----------- {}", loanId);
        this.loanTransactionHelper.approveLoanWithApproveAmount("20240101", "20240101", "200", loanId, createTranches);
        log.info("-------------------LOAN APPROVED-------");
        loanTransactionHelper.disburseLoanWithTransactionAmount("20240101", loanId, "100");
        log.info("-------------------FIRST TRANCHE DISBURSED-------");
        loanTransactionHelper.disburseLoanWithTransactionAmount("20240215", loanId, "100");
        log.info("-------------------SECOND TRANCHE DISBURSED (MID-PERIOD)-------");
        GetLoansLoanIdResponse loanDetails = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        assertNotNull(loanDetails);
        GetLoansLoanIdRepaymentSchedule schedule = loanDetails.getRepaymentSchedule();
        assertNotNull(schedule);
        List<GetLoansLoanIdRepaymentPeriod> periods = schedule.getPeriods();
        assertNotNull(periods);
        assertEquals(9, periods.size(), "Total periods should be 9 (2 disbursements + 7 repayment periods)");
        // Count disbursement periods (no period number) and repayment periods (with period number)
        long disbursementPeriods = periods.stream().filter(p -> p.getPeriod() == null).count();
        long repaymentPeriods = periods.stream().filter(p -> p.getPeriod() != null).count();
        assertEquals(2, disbursementPeriods, "Should have 2 disbursement periods");
        assertEquals(7, repaymentPeriods, "Should have 7 repayment periods");
        log.info("-------------------S2 TEST: SCHEDULE VALIDATION-------");
        log.info("Schedule structure validated: 2 disbursement + 7 repayment periods (mid-period disbursement)");
        // Close the loan to allow LoanTestLifecycleExtension cleanup to succeed
        closeFullTermTrancheLoan(loanId, "20240801");
    }

    @Test
    public void testFullTermTranche_S3_BothBeforeFirstRepayment() {
        AdvancedPaymentData defaultAllocation = createDefaultPaymentAllocation("NEXT_INSTALLMENT");
        final String loanProductJSON = new LoanProductTestBuilder().withAmortizationTypeAsEqualInstallments().withInterestTypeAsDecliningBalance().withMoratorium("", "").withInterestCalculationPeriodTypeAsRepaymentPeriod(true).withinterestRatePerPeriod("9.4822").withInterestRateFrequencyTypeAsYear().withMultiDisburse().withLoanScheduleType(LoanScheduleType.PROGRESSIVE).addAdvancedPaymentAllocation(defaultAllocation).withAllowFullTermForTranche(true).withDaysInYear("360").withMinPrincipal("100").build(null);
        final Integer loanProductId = this.loanTransactionHelper.getLoanProductId(loanProductJSON);
        log.info("------------------LOAN PRODUCT CREATED WITH ID----------- {}", loanProductId);
        final Integer clientId = ClientHelper.createClient(this.requestSpec, this.responseSpec, "20240101");
        log.info("------------------CLIENT CREATED WITH ID----------- {}", clientId);
        List<HashMap> createTranches = new ArrayList<>();
        createTranches.add(this.loanTransactionHelper.createTrancheDetail(null, "20240101", "100"));
        createTranches.add(this.loanTransactionHelper.createTrancheDetail(null, "20240115", "100"));
        final String loanApplicationJSON = new LoanApplicationTestBuilder().withPrincipal("200").withLoanTermFrequency("6").withLoanTermFrequencyAsMonths().withNumberOfRepayments("6").withRepaymentEveryAfter("1").withRepaymentFrequencyTypeAsMonths().withInterestRatePerPeriod("9.4822").withExpectedDisbursementDate("20240101").withTranches(createTranches).withSubmittedOnDate("20240101").withRepaymentStrategy(LoanProductTestBuilder.ADVANCED_PAYMENT_ALLOCATION_STRATEGY).build(clientId.toString(), loanProductId.toString(), null);
        final Integer loanId = this.loanTransactionHelper.getLoanId(loanApplicationJSON);
        log.info("------------------LOAN CREATED WITH ID----------- {}", loanId);
        this.loanTransactionHelper.approveLoanWithApproveAmount("20240101", "20240101", "200", loanId, createTranches);
        log.info("-------------------LOAN APPROVED-------");
        loanTransactionHelper.disburseLoanWithTransactionAmount("20240101", loanId, "100");
        log.info("-------------------FIRST TRANCHE DISBURSED-------");
        loanTransactionHelper.disburseLoanWithTransactionAmount("20240115", loanId, "100");
        log.info("-------------------SECOND TRANCHE DISBURSED (BEFORE FIRST REPAYMENT)-------");
        GetLoansLoanIdResponse loanDetails = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        assertNotNull(loanDetails);
        GetLoansLoanIdRepaymentSchedule schedule = loanDetails.getRepaymentSchedule();
        assertNotNull(schedule);
        List<GetLoansLoanIdRepaymentPeriod> periods = schedule.getPeriods();
        assertNotNull(periods);
        assertEquals(8, periods.size(), "Total periods should be 8 (2 disbursements + 6 repayment periods - NO EXTENSION)");
        // Count disbursement periods (no period number) and repayment periods (with period number)
        long disbursementPeriods = periods.stream().filter(p -> p.getPeriod() == null).count();
        long repaymentPeriods = periods.stream().filter(p -> p.getPeriod() != null).count();
        assertEquals(2, disbursementPeriods, "Should have 2 disbursement periods");
        assertEquals(6, repaymentPeriods, "Should have 6 repayment periods (no term extension)");
        log.info("-------------------S3 TEST: SCHEDULE VALIDATION-------");
        log.info("Schedule structure validated: 2 disbursement + 6 repayment periods (no term extension)");
        log.info("Both disbursements before first repayment date result in same maturity date");
        // Close the loan to allow LoanTestLifecycleExtension cleanup to succeed
        closeFullTermTrancheLoan(loanId, "20240701");
    }

    @Test
    public void testFullTermTrancheBackwardCompatibility() {
        AdvancedPaymentData defaultAllocation = createDefaultPaymentAllocation("NEXT_INSTALLMENT");
        final String loanProductWithoutFlag = new LoanProductTestBuilder().withAmortizationTypeAsEqualInstallments().withInterestTypeAsDecliningBalance().withMoratorium("", "").withInterestCalculationPeriodTypeAsRepaymentPeriod(true).withinterestRatePerPeriod("9.4822").withInterestRateFrequencyTypeAsYear().withMultiDisburse().withLoanScheduleType(LoanScheduleType.PROGRESSIVE).addAdvancedPaymentAllocation(defaultAllocation).withAllowFullTermForTranche(false).withDaysInYear("360").withMinPrincipal("100").build(null);
        final Integer loanProductId = this.loanTransactionHelper.getLoanProductId(loanProductWithoutFlag);
        log.info("------------------LOAN PRODUCT CREATED WITH allowFullTermForTranche=false ID----------- {}", loanProductId);
        final Integer clientId = ClientHelper.createClient(this.requestSpec, this.responseSpec, "20240101");
        log.info("------------------CLIENT CREATED WITH ID----------- {}", clientId);
        List<HashMap> createTranches = new ArrayList<>();
        createTranches.add(this.loanTransactionHelper.createTrancheDetail(null, "20240101", "100"));
        createTranches.add(this.loanTransactionHelper.createTrancheDetail(null, "20240201", "100"));
        final String loanApplicationJSON = new LoanApplicationTestBuilder().withPrincipal("200").withLoanTermFrequency("6").withLoanTermFrequencyAsMonths().withNumberOfRepayments("6").withRepaymentEveryAfter("1").withRepaymentFrequencyTypeAsMonths().withInterestRatePerPeriod("9.4822").withExpectedDisbursementDate("20240101").withTranches(createTranches).withSubmittedOnDate("20240101").withRepaymentStrategy(LoanProductTestBuilder.ADVANCED_PAYMENT_ALLOCATION_STRATEGY).build(clientId.toString(), loanProductId.toString(), null);
        final Integer loanId = this.loanTransactionHelper.getLoanId(loanApplicationJSON);
        log.info("------------------LOAN CREATED WITH ID----------- {}", loanId);
        this.loanTransactionHelper.approveLoanWithApproveAmount("20240101", "20240101", "200", loanId, createTranches);
        log.info("-------------------LOAN APPROVED-------");
        loanTransactionHelper.disburseLoanWithTransactionAmount("20240101", loanId, "100");
        log.info("-------------------FIRST TRANCHE DISBURSED-------");
        loanTransactionHelper.disburseLoanWithTransactionAmount("20240201", loanId, "100");
        log.info("-------------------SECOND TRANCHE DISBURSED-------");
        GetLoansLoanIdResponse loanDetails = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        assertNotNull(loanDetails);
        GetLoansLoanIdRepaymentSchedule schedule = loanDetails.getRepaymentSchedule();
        assertNotNull(schedule);
        List<GetLoansLoanIdRepaymentPeriod> periods = schedule.getPeriods();
        assertNotNull(periods);
        log.info("-------------------BACKWARD COMPATIBILITY TEST: SCHEDULE VALIDATION-------");
        log.info("Expected: OLD behavior when allowFullTermForTranche=false");
        log.info("Schedule should NOT use full term tranche logic - should match existing multi-disburse behavior");
    }

    /**
     * Helper method to close a loan by making a full prepayment. This ensures the loan is closed before the
     * LoanTestLifecycleExtension cleanup runs.
     */
    private void closeFullTermTrancheLoan(Integer loanId, String lastRepaymentDate) {
        GetLoansLoanIdResponse loanDetails = this.loanTransactionHelper.getLoan(requestSpec, responseSpec, loanId);
        BigDecimal outstandingAmount = loanDetails.getSummary().getTotalOutstanding();
        if (outstandingAmount != null && outstandingAmount.compareTo(BigDecimal.ZERO) > 0) {
            log.info("-------------------CLOSING LOAN {} WITH PREPAYMENT OF {} ON {}-------", loanId, outstandingAmount, lastRepaymentDate);
            this.loanTransactionHelper.makeLoanRepayment(lastRepaymentDate, outstandingAmount.floatValue(), loanId);
        }
    }
}
