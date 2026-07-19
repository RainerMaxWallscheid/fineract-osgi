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

import static org.apache.fineract.portfolio.loanaccount.domain.LoanTransactionRelationTypeEnum.REPLAYED;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.builder.ResponseSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.specification.RequestSpecification;
import io.restassured.specification.ResponseSpecification;
import java.math.BigDecimal;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicReference;
import java.util.concurrent.atomic.AtomicReferenceArray;
import org.apache.fineract.client.models.AdvancedPaymentData;
import org.apache.fineract.client.models.GetLoansLoanIdResponse;
import org.apache.fineract.client.models.GetLoansLoanIdTransactions;
import org.apache.fineract.client.models.GetLoansLoanIdTransactionsTransactionIdResponse;
import org.apache.fineract.client.models.PaymentAllocationOrder;
import org.apache.fineract.client.models.PostClientsResponse;
import org.apache.fineract.client.models.PostLoanProductsResponse;
import org.apache.fineract.client.models.PostLoansLoanIdTransactionsRequest;
import org.apache.fineract.client.models.PostLoansLoanIdTransactionsResponse;
import org.apache.fineract.client.models.PostLoansLoanIdTransactionsTransactionIdRequest;
import org.apache.fineract.client.util.CallFailedRuntimeException;
import org.apache.fineract.integrationtests.common.ClientHelper;
import org.apache.fineract.integrationtests.common.Utils;
import org.apache.fineract.integrationtests.common.loans.LoanTransactionHelper;
import org.apache.fineract.portfolio.loanaccount.domain.LoanStatus;
import org.apache.fineract.portfolio.loanproduct.domain.PaymentAllocationType;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

public class LoanInterestRefundTest extends BaseLoanIntegrationTest {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(LoanInterestRefundTest.class);
    private static ResponseSpecification responseSpec;
    private static RequestSpecification requestSpec;
    private static LoanTransactionHelper loanTransactionHelper;
    private static PostClientsResponse client;

    @BeforeAll
    public static void setup() {
        Utils.initializeRESTAssured();
        requestSpec = new RequestSpecBuilder().setContentType(ContentType.JSON).build();
        requestSpec.header("Authorization", "Basic " + Utils.loginIntoServerAndGetBase64EncodedAuthenticationKey());
        requestSpec.header("Fineract-Platform-TenantId", "default");
        responseSpec = new ResponseSpecBuilder().expectStatusCode(200).build();
        loanTransactionHelper = new LoanTransactionHelper(requestSpec, responseSpec);
        ClientHelper clientHelper = new ClientHelper(requestSpec, responseSpec);
        client = clientHelper.createClient(ClientHelper.defaultClientCreationRequest());
    }

    @Test
    public void verifyInterestRefundNotCreatedForPayoutRefundWhenTypesAreEmpty() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.9, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210122", 1000.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"), transaction(1000.0, "Payout Refund", "20210122"));
        });
    }

    @Test
    public void verifyInterestRefundNotCreatedForMerchantIssuedRefundWhenTypesAreEmpty() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.9, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210122", 1000.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"), transaction(1000.0, "Merchant Issued Refund", "20210122"));
        });
    }

    @Test
    public void verifyFullMerchantIssuedRefundWithReAmortizationOnDay0HighInterest6month() {
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).paymentAllocation(List.of(createDefaultPaymentAllocation("REAMORTIZATION"))).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 600.0, 60.0, 6, null);
            Assertions.assertNotNull(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(600), "20210101");
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210101", 600.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(600.0, "Disbursement", "20210101"),  //
            transaction(600.0, "Merchant Issued Refund", "20210101") //
            );
            verifyRepaymentSchedule(loanId, installment(600.0, null, "20210101"),  //
            fullyRepaidInstallment(100.0, 0.0, "20210201"),  //
            fullyRepaidInstallment(100.0, 0.0, "20210301"),  //
            fullyRepaidInstallment(100.0, 0.0, "20210401"),  //
            fullyRepaidInstallment(100.0, 0.0, "20210501"),  //
            fullyRepaidInstallment(100.0, 0.0, "20210601"),  //
            fullyRepaidInstallment(100.0, 0.0, "20210701") //
            );
        });
    }

    @Test
    public void verifyAlmostFullMerchantIssuedRefundWithReAmortizationOnDay0HighInterest12month() {
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).paymentAllocation(List.of(createDefaultPaymentAllocation("REAMORTIZATION"))).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 26.0, 12, null);
            Assertions.assertNotNull(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210101", 980.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(980.0, "Merchant Issued Refund", "20210101") //
            );
            verifyRepaymentSchedule(loanId, installment(1000.0, null, "20210101"),  //
            installment(95.04, 0.44, 13.81, false, "20210201"),  //
            installment(88.3, 0.13, 6.76, false, "20210301"),  //
            fullyRepaidInstallment(81.67, 0.0, "20210401"),  //
            fullyRepaidInstallment(81.67, 0.0, "20210501"),  //
            fullyRepaidInstallment(81.67, 0.0, "20210601"),  //
            fullyRepaidInstallment(81.67, 0.0, "20210701"),  //
            fullyRepaidInstallment(81.67, 0.0, "20210801"),  //
            fullyRepaidInstallment(81.67, 0.0, "20210901"),  //
            fullyRepaidInstallment(81.67, 0.0, "20211001"),  //
            fullyRepaidInstallment(81.67, 0.0, "20211101"),  //
            fullyRepaidInstallment(81.67, 0.0, "20211201"),  //
            fullyRepaidInstallment(81.63, 0.0, "20220101") //
            );
        });
    }

    @Test
    public void verifyFullMerchantIssuedRefundWithReAmortizationOnDay0HighInterest12month() {
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).paymentAllocation(List.of(createDefaultPaymentAllocation("REAMORTIZATION"))).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 26.0, 12, null);
            Assertions.assertNotNull(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210101", 1000.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(1000.0, "Merchant Issued Refund", "20210101") //
            );
            verifyRepaymentSchedule(loanId, installment(1000.0, null, "20210101"),  //
            fullyRepaidInstallment(83.33, 0.0, "20210201"),  //
            fullyRepaidInstallment(83.33, 0.0, "20210301"),  //
            fullyRepaidInstallment(83.33, 0.0, "20210401"),  //
            fullyRepaidInstallment(83.33, 0.0, "20210501"),  //
            fullyRepaidInstallment(83.33, 0.0, "20210601"),  //
            fullyRepaidInstallment(83.33, 0.0, "20210701"),  //
            fullyRepaidInstallment(83.33, 0.0, "20210801"),  //
            fullyRepaidInstallment(83.33, 0.0, "20210901"),  //
            fullyRepaidInstallment(83.33, 0.0, "20211001"),  //
            fullyRepaidInstallment(83.33, 0.0, "20211101"),  //
            fullyRepaidInstallment(83.33, 0.0, "20211201"),  //
            fullyRepaidInstallment(83.37, 0.0, "20220101") //
            );
        });
    }

    @Test
    public void verifyInterestRefundCreatedForPayoutRefund() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210122", 1000.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId,  //
            transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(1000.0, "Payout Refund", "20210122"),  //
            transaction(5.75, "Interest Refund", "20210122"),  //
            transaction(5.75, "Accrual", "20210122")); //
            checkTransactionWasNotReverseReplayed(postLoansLoanIdTransactionsResponse.getLoanId(), postLoansLoanIdTransactionsResponse.getResourceId());
            checkTransactionWasNotReverseReplayed(postLoansLoanIdTransactionsResponse.getLoanId(), postLoansLoanIdTransactionsResponse.getSubResourceId());
            verifyTRJournalEntries(postLoansLoanIdTransactionsResponse.getResourceId(),  //
            journalEntry(1000, fundSource, "DEBIT"),  //
            journalEntry(5.75, interestReceivableAccount, "CREDIT"),  //
            journalEntry(994.25, loansReceivableAccount, "CREDIT"));
            verifyTRJournalEntries(postLoansLoanIdTransactionsResponse.getSubResourceId(), journalEntry(5.75, interestIncomeAccount, "DEBIT"),  //
            journalEntry(5.75, loansReceivableAccount, "CREDIT")); //
        });
    }

    private void checkTransactionWasNotReverseReplayed(Long loanId, Long transactionId) {
        GetLoansLoanIdTransactionsTransactionIdResponse loanTransactionDetails = loanTransactionHelper.getLoanTransactionDetails(loanId, transactionId);
        if (loanTransactionDetails.getTransactionRelations() != null) {
            loanTransactionDetails.getTransactionRelations().forEach(transactionRelation -> {
                if (REPLAYED.name().equals(transactionRelation.getRelationType())) {
                    Assertions.fail("Transaction was replayed!");
                }
            });
        }
    }

    @Test
    public void verifyInterestRefundCreatedForMerchantIssuedRefund() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210122", 1000.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(1000.0, "Merchant Issued Refund", "20210122"),  //
            transaction(5.75, "Accrual", "20210122"),  //
            transaction(5.75, "Interest Refund", "20210122") //
            );
        });
    }

    @Test
    public void verifyInterestRefundCreatedForMerchantIssuedRefundDay22HighInterest12month() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 26.0, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210122", 1000.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(14.96, "Accrual", "20210122"),  //
            transaction(14.96, "Interest Refund", "20210122"),  //
            transaction(1000.0, "Merchant Issued Refund", "20210122") //
            );
            verifyRepaymentSchedule(loanId, installment(1000.0, null, "20210101"),  //
            fullyRepaidInstallment(80.52, 14.96, "20210201"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210301"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210401"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210501"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210601"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210701"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210801"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210901"),  //
            fullyRepaidInstallment(95.48, 0.0, "20211001"),  //
            fullyRepaidInstallment(95.48, 0.0, "20211101"),  //
            fullyRepaidInstallment(60.16, 0.0, "20211201"),  //
            fullyRepaidInstallment(0.0, 0.0, "20220101") //
            );
        });
    }

    @Test
    public void verifyFullMerchantIssuedRefundOnDay0HighInterest12month() {
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 26.0, 12, null);
            Assertions.assertNotNull(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210101", 1000.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(1000.0, "Merchant Issued Refund", "20210101") //
            );
            verifyRepaymentSchedule(loanId, installment(1000.0, null, "20210101"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210201"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210301"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210401"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210501"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210601"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210701"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210801"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210901"),  //
            fullyRepaidInstallment(95.48, 0.0, "20211001"),  //
            fullyRepaidInstallment(95.48, 0.0, "20211101"),  //
            fullyRepaidInstallment(45.2, 0.0, "20211201"),  //
            fullyRepaidInstallment(0.0, 0.0, "20220101") //
            );
        });
    }

    @Test
    public void verifyRepaymentDay0HighInterest12month() {
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 26.0, 12, null);
            Assertions.assertNotNull(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210101", 1000.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(1000.0, "Repayment", "20210101") //
            );
            verifyRepaymentSchedule(loanId, installment(1000.0, null, "20210101"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210201"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210301"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210401"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210501"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210601"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210701"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210801"),  //
            fullyRepaidInstallment(95.48, 0.0, "20210901"),  //
            fullyRepaidInstallment(95.48, 0.0, "20211001"),  //
            fullyRepaidInstallment(95.48, 0.0, "20211101"),  //
            fullyRepaidInstallment(45.2, 0.0, "20211201"),  //
            fullyRepaidInstallment(0.0, 0.0, "20220101") //
            );
        });
    }

    @Test
    public void verifyUC01() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210122", 1000.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(1000.0, "Payout Refund", "20210122"),  //
            transaction(5.75, "Accrual", "20210122"),  //
            transaction(5.75, "Interest Refund", "20210122") //
            );
        });
    }

    @Test
    public void verifyUC02a() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
        });
        runAt("20210201", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210201", 1000.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(1000.0, "Payout Refund", "20210201"),  //
            transaction(8.48, "Accrual", "20210201"),  //
            transaction(8.48, "Interest Refund", "20210201")); //
        });
    }

    @Test
    public void verifyUC02b() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
        });
        runAt("20210201", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210201", 87.89);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"), transaction(87.89, "Repayment", "20210201"));
        });
        runAt("20210209", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210209", 1000.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(87.89, "Repayment", "20210201"),  //
            transaction(1000.0, "Payout Refund", "20210209"),  //
            transaction(10.5, "Interest Refund", "20210209"),  //
            transaction(10.5, "Accrual", "20210209") //
            );
        });
    }

    @Test
    public void verifyUC03() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).disallowExpectedDisbursements(true).multiDisburseLoan(true).maxTrancheCount(2).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(750), "20210101");
            disburseLoan(loanId, BigDecimal.valueOf(250), "20210101");
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210122", 1000.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(750.0, "Disbursement", "20210101"),  //
            transaction(250.0, "Disbursement", "20210101"),  //
            transaction(1000.0, "Payout Refund", "20210122"),  //
            transaction(5.75, "Accrual", "20210122"),  //
            transaction(5.75, "Interest Refund", "20210122") //
            );
        });
    }

    @Test
    public void verifyUC04() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).disallowExpectedDisbursements(true).multiDisburseLoan(true).maxTrancheCount(2).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(250), "20210101");
        });
        runAt("20210104", () -> {
            Long loanId = loanIdRef.get();
            disburseLoan(loanId, BigDecimal.valueOf(750), "20210104");
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210122", 1000.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(750.0, "Disbursement", "20210104"),  //
            transaction(250.0, "Disbursement", "20210101"),  //
            transaction(1000.0, "Payout Refund", "20210122"),  //
            transaction(5.13, "Accrual", "20210122"),  //
            transaction(5.13, "Interest Refund", "20210122") //
            );
        });
    }

    @Test
    public void verifyUC05() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).multiDisburseLoan(true).disallowExpectedDisbursements(true).maxTrancheCount(2).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(500), "20210101");
        });
        runAt("20210107", () -> {
            Long loanId = loanIdRef.get();
            disburseLoan(loanId, BigDecimal.valueOf(500), "20210107");
        });
        runAt("20210201", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210201", 87.82);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(500.0, "Disbursement", "20210101"), transaction(500.0, "Disbursement", "20210107"), transaction(87.82, "Repayment", "20210201"));
        });
        runAt("20210209", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210209", 1000.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(500.0, "Disbursement", "20210101"),  //
            transaction(500.0, "Disbursement", "20210107"),  //
            transaction(1000.0, "Payout Refund", "20210209"),  //
            transaction(87.82, "Repayment", "20210201"),  //
            transaction(9.67, "Interest Refund", "20210209"),  //
            transaction(9.67, "Accrual", "20210209") //
            );
        });
    }

    @Test
    public void verifyUC06() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20201201", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20201201", 1000.0, 9.99, 6, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20201201");
        });
        runAt("20201214", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20201214", 500.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20201201"),  //
            transaction(500.0, "Payout Refund", "20201214"),  //
            transaction(1.78, "Interest Refund", "20201214"));
        });
    }

    @Test
    public void verifyUC07() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
        });
        runAt("20210201", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210201", 87.89);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(87.89, "Repayment", "20210201"));
        });
        runAt("20210209", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210209", 500.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(87.89, "Repayment", "20210201"),  //
            transaction(500.0, "Payout Refund", "20210209"),  //
            transaction(5.35, "Interest Refund", "20210209"));
        });
    }

    @Test
    public void verifyUC08() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).disallowExpectedDisbursements(true).multiDisburseLoan(true).maxTrancheCount(2).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 6, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(250), "20210101");
            disburseLoan(loanId, BigDecimal.valueOf(750), "20210101");
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210122", 500.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(250.0, "Disbursement", "20210101"),  //
            transaction(750.0, "Disbursement", "20210101"),  //
            transaction(500.0, "Payout Refund", "20210122"),  //
            transaction(2.88, "Interest Refund", "20210122"));
        });
    }

    @Test
    public void verifyUC09() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).disallowExpectedDisbursements(true).multiDisburseLoan(true).maxTrancheCount(2).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 6, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(250), "20210101");
        });
        runAt("20210107", () -> {
            Long loanId = loanIdRef.get();
            disburseLoan(loanId, BigDecimal.valueOf(750), "20210107");
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210122", 500.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(250.0, "Disbursement", "20210101"),  //
            transaction(750.0, "Disbursement", "20210107"),  //
            transaction(500.0, "Payout Refund", "20210122"),  //
            transaction(2.47, "Interest Refund", "20210122"));
        });
    }

    @Test
    public void verifyUC10() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).disallowExpectedDisbursements(true).multiDisburseLoan(true).maxTrancheCount(2).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 6, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(250), "20210101");
        });
        runAt("20210107", () -> {
            Long loanId = loanIdRef.get();
            disburseLoan(loanId, BigDecimal.valueOf(750), "20210107");
        });
        runAt("20210701", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210201", 171.29);
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210301", 171.29);
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210401", 171.29);
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210501", 171.29);
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210601", 171.29);
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210701", 171.32);
            verifyTransactions(loanId, transaction(250.0, "Disbursement", "20210101"),  //
            transaction(750.0, "Disbursement", "20210107"),  //
            transaction(171.29, "Repayment", "20210201"),  //
            transaction(171.29, "Repayment", "20210301"),  //
            transaction(171.29, "Repayment", "20210401"),  //
            transaction(171.29, "Repayment", "20210501"),  //
            transaction(171.29, "Repayment", "20210601"),  //
            transaction(171.32, "Repayment", "20210701"),  //
            transaction(27.77, "Accrual", "20210701") //
            ); //
        });
        runAt("20210711", () -> {
            Long loanId = loanIdRef.get();
            PostLoansLoanIdTransactionsResponse postLoansLoanIdTransactionsResponse = loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210711", 500.0);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse);
            Assertions.assertNotNull(postLoansLoanIdTransactionsResponse.getResourceId());
            verifyTransactions(loanId, transaction(250.0, "Disbursement", "20210101"),  //
            transaction(750.0, "Disbursement", "20210107"),  //
            transaction(171.29, "Repayment", "20210201"),  //
            transaction(171.29, "Repayment", "20210301"),  //
            transaction(171.29, "Repayment", "20210401"),  //
            transaction(171.29, "Repayment", "20210501"),  //
            transaction(171.29, "Repayment", "20210601"),  //
            transaction(171.32, "Repayment", "20210701"),  //
            transaction(500.0, "Payout Refund", "20210711"),  //
            transaction(20.41, "Interest Refund", "20210711"),  //
            transaction(27.77, "Accrual", "20210701") //
            ); //
        });
    }

    @Test
    public void verifyUC11() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 6, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
        });
        runAt("20210114", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210114", 500.0);
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(500.0, "Merchant Issued Refund", "20210114"),  //
            transaction(1.78, "Interest Refund", "20210114"));
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210122", 500.0);
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(500.0, "Merchant Issued Refund", "20210114"),  //
            transaction(1.78, "Interest Refund", "20210114"),  //
            transaction(500.0, "Payout Refund", "20210122"),  //
            transaction(2.88, "Interest Refund", "20210122"),  //
            transaction(4.66, "Accrual", "20210122") //
            );
        });
    }

    @Test
    public void verifyUC12() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 6, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
        });
        runAt("20210201", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210201", 171.5);
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(171.5, "Repayment", "20210201"));
        });
        runAt("20210209", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210209", 500.0);
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(171.5, "Repayment", "20210201"),  //
            transaction(500.0, "Merchant Issued Refund", "20210209"),  //
            transaction(5.34, "Interest Refund", "20210209"));
        });
        runAt("20210225", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210225", 250.0);
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(171.5, "Repayment", "20210201"),  //
            transaction(500.0, "Merchant Issued Refund", "20210209"),  //
            transaction(5.34, "Interest Refund", "20210209"),  //
            transaction(250.0, "Payout Refund", "20210225"),  //
            transaction(3.78, "Interest Refund", "20210225") //
            );
        });
    }

    @Test
    public void verifyUC13() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).multiDisburseLoan(true).disallowExpectedDisbursements(true).maxTrancheCount(2).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(250), "20210101");
            disburseLoan(loanId, BigDecimal.valueOf(750), "20210101");
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210122", 500.0);
            verifyTransactions(loanId, transaction(250.0, "Disbursement", "20210101"),  //
            transaction(750.0, "Disbursement", "20210101"),  //
            transaction(500.0, "Merchant Issued Refund", "20210122"),  //
            transaction(2.88, "Interest Refund", "20210122") //
            );
        });
        runAt("20210126", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210126", 400.0);
            verifyTransactions(loanId, transaction(250.0, "Disbursement", "20210101"),  //
            transaction(750.0, "Disbursement", "20210101"),  //
            transaction(500.0, "Merchant Issued Refund", "20210122"),  //
            transaction(2.88, "Interest Refund", "20210122"),  //
            transaction(400.0, "Payout Refund", "20210126"),  //
            transaction(2.74, "Interest Refund", "20210126") //
            );
        });
        runAt("20210201", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210201", 100.84);
            verifyTransactions(loanId, transaction(250.0, "Disbursement", "20210101"),  //
            transaction(750.0, "Disbursement", "20210101"),  //
            transaction(500.0, "Merchant Issued Refund", "20210122"),  //
            transaction(2.88, "Interest Refund", "20210122"),  //
            transaction(400.0, "Payout Refund", "20210126"),  //
            transaction(2.74, "Interest Refund", "20210126"),  //
            transaction(100.84, "Repayment", "20210201"),  //
            transaction(6.46, "Accrual", "20210201")); //
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertNotNull(loanDetails);
            Assertions.assertNotNull(loanDetails.getStatus());
            Assertions.assertEquals(600, loanDetails.getStatus().getId());
        });
    }

    @Test
    public void verifyUC14() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).multiDisburseLoan(true).disallowExpectedDisbursements(true).maxTrancheCount(3).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 6, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(200), "20210101");
            disburseLoan(loanId, BigDecimal.valueOf(300), "20210101");
        });
        runAt("20210105", () -> {
            Long loanId = loanIdRef.get();
            disburseLoan(loanId, BigDecimal.valueOf(500), "20210105");
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210122", 250.0);
            verifyTransactions(loanId, transaction(200.0, "Disbursement", "20210101"),  //
            transaction(300.0, "Disbursement", "20210101"),  //
            transaction(500.0, "Disbursement", "20210105"),  //
            transaction(250.0, "Merchant Issued Refund", "20210122"),  //
            transaction(1.44, "Interest Refund", "20210122") //
            );
        });
        runAt("20210126", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210126", 400.0);
            verifyTransactions(loanId, transaction(200.0, "Disbursement", "20210101"),  //
            transaction(300.0, "Disbursement", "20210101"),  //
            transaction(500.0, "Disbursement", "20210105"),  //
            transaction(250.0, "Merchant Issued Refund", "20210122"),  //
            transaction(1.44, "Interest Refund", "20210122"),  //
            transaction(400.0, "Payout Refund", "20210126"),  //
            transaction(2.58, "Interest Refund", "20210126") //
            );
        });
        runAt("20210401", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210201", 171.41);
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210301", 171.41);
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210401", 11.24);
            verifyTransactions(loanId, transaction(200.0, "Disbursement", "20210101"),  //
            transaction(300.0, "Disbursement", "20210101"),  //
            transaction(500.0, "Disbursement", "20210105"),  //
            transaction(250.0, "Merchant Issued Refund", "20210122"),  //
            transaction(1.44, "Interest Refund", "20210122"),  //
            transaction(400.0, "Payout Refund", "20210126"),  //
            transaction(2.58, "Interest Refund", "20210126"),  //
            transaction(171.41, "Repayment", "20210201"),  //
            transaction(171.41, "Repayment", "20210301"),  //
            transaction(11.24, "Repayment", "20210401"),  //
            transaction(8.08, "Accrual", "20210401") //
            );
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertNotNull(loanDetails);
            Assertions.assertNotNull(loanDetails.getStatus());
            Assertions.assertEquals(600, loanDetails.getStatus().getId());
        });
    }

    @Test
    public void verifyUC15() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).multiDisburseLoan(true).disallowExpectedDisbursements(true).maxTrancheCount(3).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 6, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(500), "20210101");
        });
        runAt("20210105", () -> {
            Long loanId = loanIdRef.get();
            disburseLoan(loanId, BigDecimal.valueOf(500), "20210105");
        });
        runAt("20210201", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210201", 171.41);
            verifyTransactions(loanId, transaction(500.0, "Disbursement", "20210101"),  //
            transaction(500.0, "Disbursement", "20210105"),  //
            transaction(171.41, "Repayment", "20210201"));
        });
        runAt("20210213", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210213", 250.0);
            verifyTransactions(loanId, transaction(500.0, "Disbursement", "20210101"),  //
            transaction(500.0, "Disbursement", "20210105"),  //
            transaction(171.41, "Repayment", "20210201"),  //
            transaction(250.0, "Payout Refund", "20210213"),  //
            transaction(2.95, "Interest Refund", "20210213") //
            );
        });
        runAt("20210224", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210224", 400.0);
            verifyTransactions(loanId, transaction(500.0, "Disbursement", "20210101"),  //
            transaction(500.0, "Disbursement", "20210105"),  //
            transaction(171.41, "Repayment", "20210201"),  //
            transaction(250.0, "Payout Refund", "20210213"),  //
            transaction(2.95, "Interest Refund", "20210213"),  //
            transaction(400.0, "Merchant Issued Refund", "20210224"),  //
            transaction(5.77, "Interest Refund", "20210224") //
            );
        });
        runAt("20210401", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210301", 171.41);
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210401", 11.25);
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertNotNull(loanDetails);
            Assertions.assertNotNull(loanDetails.getStatus());
            Assertions.assertEquals(600, loanDetails.getStatus().getId());
        });
    }

    @Test
    public void verifyUC16() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).multiDisburseLoan(true).disallowExpectedDisbursements(true).maxTrancheCount(3).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 6, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(500), "20210101");
        });
        runAt("20210105", () -> {
            Long loanId = loanIdRef.get();
            disburseLoan(loanId, BigDecimal.valueOf(500), "20210105");
        });
        runAt("20210201", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210201", 171.41);
            verifyTransactions(loanId, transaction(500.0, "Disbursement", "20210101"),  //
            transaction(500.0, "Disbursement", "20210105"),  //
            transaction(171.41, "Repayment", "20210201"));
        });
        runAt("20210213", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210213", 250.0);
            verifyTransactions(loanId, transaction(500.0, "Disbursement", "20210101"),  //
            transaction(500.0, "Disbursement", "20210105"),  //
            transaction(171.41, "Repayment", "20210201"),  //
            transaction(250.0, "Payout Refund", "20210213"),  //
            transaction(2.95, "Interest Refund", "20210213") //
            );
        });
        runAt("20210401", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210301", 171.41);
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210401", 171.41);
        });
        runAt("20210406", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210406", 400.0);
            verifyTransactions(loanId, transaction(500.0, "Disbursement", "20210101"),  //
            transaction(500.0, "Disbursement", "20210105"),  //
            transaction(171.41, "Repayment", "20210201"),  //
            transaction(171.41, "Repayment", "20210301"),  //
            transaction(171.41, "Repayment", "20210401"),  //
            transaction(250.0, "Payout Refund", "20210213"),  //
            transaction(2.95, "Interest Refund", "20210213"),  //
            transaction(400.0, "Merchant Issued Refund", "20210406"),  //
            transaction(10.12, "Interest Refund", "20210406"),  //
            transaction(17.14, "Accrual", "20210406") //
            );
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertNotNull(loanDetails);
            Assertions.assertNotNull(loanDetails.getStatus());
            Assertions.assertEquals(700, loanDetails.getStatus().getId());
            Assertions.assertEquals(160.16, Utils.getDoubleValue(loanDetails.getTotalOverpaid()));
        });
    }

    @Test
    public void verifyUC17() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).multiDisburseLoan(true).disallowExpectedDisbursements(true).maxTrancheCount(2).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.99, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
        });
        runAt("20210112", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210112", 400.0);
            verifyTransactions(loanId,  //
            transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(400.0, "Payout Refund", "20210112"),  //
            transaction(1.2, "Interest Refund", "20210112") //
            );
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210117", 150.0);
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(400.0, "Payout Refund", "20210112"),  //
            transaction(1.2, "Interest Refund", "20210112"),  //
            transaction(150.0, "Merchant Issued Refund", "20210117"),  //
            transaction(0.66, "Interest Refund", "20210117") //
            );
        });
        runAt("20210201", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210201", 171.5);
        });
        runAt("20210208", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "PayoutRefund", "20210208", 250.0);
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(400.0, "Payout Refund", "20210112"),  //
            transaction(1.2, "Interest Refund", "20210112"),  //
            transaction(150.0, "Merchant Issued Refund", "20210117"),  //
            transaction(0.66, "Interest Refund", "20210117"),  //
            transaction(171.5, "Repayment", "20210201"),  //
            transaction(250.0, "Payout Refund", "20210208"),  //
            transaction(2.61, "Interest Refund", "20210208") //
            );
        });
        runAt("20210301", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210301", 30.43);
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertNotNull(loanDetails);
            Assertions.assertNotNull(loanDetails.getStatus());
            Assertions.assertEquals(600, loanDetails.getStatus().getId());
        });
    }

    @Test
    public void verifyUC18S1() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).multiDisburseLoan(true).disallowExpectedDisbursements(true).maxTrancheCount(2).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.9, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210122", 1000.0);
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(1000.0, "Merchant Issued Refund", "20210122"),  //
            transaction(5.7, "Interest Refund", "20210122"),  //
            transaction(5.7, "Accrual", "20210122") //
            );
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210110", 85.63);
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(85.63, "Repayment", "20210110"),  //
            transaction(5.7, "Accrual", "20210122"),  //
            transaction(1000.0, "Merchant Issued Refund", "20210122"),  //
            transaction(5.42, "Interest Refund", "20210122"),  //
            transaction(0.28, "Accrual Adjustment", "20210122") //
            );
        });
    }

    @Test
    public void verifyNoEmptyInterestRefundTransaction() {
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).multiDisburseLoan(true).disallowExpectedDisbursements(true).maxTrancheCount(2).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.9, 12, null);
            Assertions.assertNotNull(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
            loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210101", 1000.0);
            verifyTransactions(loanId,  //
            transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(1000.0, "Merchant Issued Refund", "20210101") //
            );
        });
    }

    @Test
    public void verifyUC18S2() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        AtomicReference<Long> repaymentIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).multiDisburseLoan(true).disallowExpectedDisbursements(true).maxTrancheCount(2).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.9, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
        });
        runAt("20210110", () -> {
            Long loanId = loanIdRef.get();
            Long response = loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20210110", 85.63).getResourceId();
            Assertions.assertNotNull(response);
            repaymentIdRef.set(response);
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(85.63, "Repayment", "20210110") //
            );
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210122", 1000.0);
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            transaction(85.63, "Repayment", "20210110"),  //
            transaction(1000.0, "Merchant Issued Refund", "20210122"),  //
            transaction(5.42, "Interest Refund", "20210122"),  //
            transaction(5.42, "Accrual", "20210122") //
            );
            Long repaymentId = repaymentIdRef.get();
            loanTransactionHelper.reverseLoanTransaction(loanId, repaymentId, "20210110");
            verifyTransactions(loanId, transaction(1000.0, "Disbursement", "20210101"),  //
            reversedTransaction(85.63, "Repayment", "20210110"),  //
            transaction(1000.0, "Merchant Issued Refund", "20210122"),  //
            transaction(5.7, "Interest Refund", "20210122"),  //
            transaction(5.42, "Accrual", "20210122"),  //
            transaction(0.28, "Accrual", "20210122") //
            );
        });
    }

    // UC19: Interest Refund reverse transaction only when the related transactions, Merchant Issued Refund or Payout
    // Refund are reversed
    // 1. Create a Loan Product that supports Interest Refund Types
    // 2. Submit, Approve and Disburse the loan
    // 3. Apply a Merchant Issued Refund Transaction
    // 4. Try to reverse the Interest Refund Transaction expecting to have an Exception
    // 5. Reverse the Merchant Issued Refund transaction and review the Interest Refund Transction is reversed too
    @Test
    public void verifyUC19() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        runAt("20210101", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
            //
            //
            //
            //
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).multiDisburseLoan(true).disallowExpectedDisbursements(true).maxTrancheCount(2).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20210101", 1000.0, 9.9, 12, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(1000), "20210101");
        });
        runAt("20210122", () -> {
            Long loanId = loanIdRef.get();
            loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20210122", 1000.0);
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertNotNull(loanDetails.getTransactions());
            Optional<GetLoansLoanIdTransactions> optInterestRefundTransaction = loanDetails.getTransactions().stream().filter(item -> {
                Assertions.assertNotNull(item.getType());
                return Objects.equals(item.getType().getValue(), "Interest Refund");
            }).findFirst();
            final Long interestRefundTransactionId = optInterestRefundTransaction.orElseThrow().getId();
            CallFailedRuntimeException exception = assertThrows(CallFailedRuntimeException.class, () -> loanTransactionHelper.reverseLoanTransaction(loanId, interestRefundTransactionId, new PostLoansLoanIdTransactionsTransactionIdRequest().dateFormat(DATETIME_PATTERN).transactionDate("20210122").transactionAmount(0.0).locale("en")));
            assertEquals(403, exception.getResponse().code());
            assertTrue(exception.getMessage().contains("error.msg.loan.transaction.update.not.allowed"));
            Optional<GetLoansLoanIdTransactions> optMerchantIssuedTransaction = loanDetails.getTransactions().stream().filter(item -> Objects.equals(item.getType().getValue(), "Merchant Issued Refund")).findFirst();
            final Long merchantIssuedTransactionId = optMerchantIssuedTransaction.orElseThrow().getId();
            loanTransactionHelper.reverseLoanTransaction(loanId, merchantIssuedTransactionId, new PostLoansLoanIdTransactionsTransactionIdRequest().dateFormat(DATETIME_PATTERN).transactionDate("20210122").transactionAmount(0.0).locale("en"));
            loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            Assertions.assertNotNull(loanDetails.getTransactions());
            optInterestRefundTransaction = loanDetails.getTransactions().stream().filter(item -> Objects.equals(item.getType().getValue(), "Interest Refund")).findFirst();
            assertEquals(Boolean.TRUE, optInterestRefundTransaction.orElseThrow().getManuallyReversed());
        });
    }

    // UC20: Manual interest refund on closed loan results in DatabaseException
    @Test
    public void verifyUC20() {
        AtomicReference<Long> loanIdRef = new AtomicReference<>();
        final Integer totalTransactions = 4;
        AtomicReferenceArray<PostLoansLoanIdTransactionsResponse> merchantIssuedRefundTransactions = new AtomicReferenceArray<>(totalTransactions);
        runAt("20250307", () -> {
            PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
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
            //
            //
            create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).chargeOffBehaviour("ZERO_INTEREST").enableAccrualActivityPosting(true).allowApprovedDisbursedAmountsOverApplied(true).overAppliedCalculationType("flat").overAppliedNumber(10000).enableInstallmentLevelDelinquency(true).multiDisburseLoan(true).loanScheduleType("PROGRESSIVE").loanScheduleProcessingType("HORIZONTAL").interestRecognitionOnDisbursementDate(true).disallowExpectedDisbursements(true).maxTrancheCount(500).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY) //
            );
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProduct.getResourceId(), "20250307", 915.88, 24.99, 24, null);
            Assertions.assertNotNull(loanId);
            loanIdRef.set(loanId);
        });
        runAt("20250311", () -> {
            for (int i = 0; i < totalTransactions; i++) {
                disburseLoan(loanIdRef.get(), BigDecimal.valueOf(228.97), "20250311");
            }
        });
        runAt("20250404", () -> {
            Long response = loanTransactionHelper.makeLoanRepayment(loanIdRef.get(), "Repayment", "20250404", 48.91).getResourceId();
            Assertions.assertNotNull(response);
        });
        runAt("20250502", () -> {
            Long response = loanTransactionHelper.makeLoanRepayment(loanIdRef.get(), "Repayment", "20250502", 48.91).getResourceId();
            Assertions.assertNotNull(response);
        });
        runAt("20250530", () -> {
            Long response = loanTransactionHelper.makeLoanRepayment(loanIdRef.get(), "Repayment", "20250530", 48.91).getResourceId();
            Assertions.assertNotNull(response);
        });
        runAt("20250627", () -> {
            Long response = loanTransactionHelper.makeLoanRepayment(loanIdRef.get(), "Repayment", "20250627", 48.91).getResourceId();
            Assertions.assertNotNull(response);
        });
        runAt("20250808", () -> {
            Long response = loanTransactionHelper.makeLoanRepayment(loanIdRef.get(), "Repayment", "20250808", 48.91).getResourceId();
            Assertions.assertNotNull(response);
        });
        runAt("20250905", () -> {
            Long response = loanTransactionHelper.makeLoanRepayment(loanIdRef.get(), "Repayment", "20250905", 48.91).getResourceId();
            Assertions.assertNotNull(response);
        });
        runAt("20251003", () -> {
            Long response = loanTransactionHelper.makeLoanRepayment(loanIdRef.get(), "Repayment", "20251003", 48.91).getResourceId();
            Assertions.assertNotNull(response);
        });
        runAt("20251008", () -> {
            for (int i = 0; i < totalTransactions; i++) {
                final String transactionExternalId = UUID.randomUUID().toString();
                PostLoansLoanIdTransactionsResponse refundResponse = loanTransactionHelper.makeMerchantIssuedRefund(loanIdRef.get(), new PostLoansLoanIdTransactionsRequest().dateFormat(DATETIME_PATTERN).transactionDate("20251008").locale(LOCALE).transactionAmount(228.97).externalId(transactionExternalId).interestRefundCalculation(false));
                Assertions.assertNotNull(refundResponse.getResourceId());
                merchantIssuedRefundTransactions.set(i, refundResponse);
            }
        });
        runAt("20251009", () -> {
            loanTransactionHelper.makeCreditBalanceRefund(loanIdRef.get(), new PostLoansLoanIdTransactionsRequest().dateFormat(DATETIME_PATTERN).transactionDate("20251009").locale(LOCALE).transactionAmount(225.15));
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanIdRef.get());
            assertTrue(loanDetails.getStatus().getClosedObligationsMet());
            for (int i = 0; i < totalTransactions; i++) {
                loanTransactionHelper.createManualInterestRefund(loanIdRef.get(), merchantIssuedRefundTransactions.get(i).getResourceId(), null, 0.01, null);
            }
        });
    }

    AdvancedPaymentData createPaymentAllocationInterestPrincipalPenaltyFee(String transactionType, String futureInstallmentAllocationRule) {
        AdvancedPaymentData advancedPaymentData = new AdvancedPaymentData();
        advancedPaymentData.setTransactionType(transactionType);
        advancedPaymentData.setFutureInstallmentAllocationRule(futureInstallmentAllocationRule);
        List<PaymentAllocationOrder> paymentAllocationOrders = getPaymentAllocationOrder(PaymentAllocationType.PAST_DUE_INTEREST, PaymentAllocationType.PAST_DUE_PRINCIPAL, PaymentAllocationType.PAST_DUE_PENALTY, PaymentAllocationType.PAST_DUE_FEE, PaymentAllocationType.DUE_INTEREST, PaymentAllocationType.DUE_PRINCIPAL, PaymentAllocationType.DUE_PENALTY, PaymentAllocationType.DUE_FEE, PaymentAllocationType.IN_ADVANCE_INTEREST, PaymentAllocationType.IN_ADVANCE_PRINCIPAL, PaymentAllocationType.IN_ADVANCE_PENALTY, PaymentAllocationType.IN_ADVANCE_FEE);
        advancedPaymentData.setPaymentAllocationOrder(paymentAllocationOrders);
        return advancedPaymentData;
    }

    private Long createLoanProduct() {
        PostLoanProductsResponse loanProduct = loanProductHelper.createLoanProduct( //
        //
        //
        //
        //
        //
        //
        create4IProgressive().daysInMonthType(DaysInMonthType.ACTUAL).daysInYearType(DaysInYearType.ACTUAL).isInterestRecalculationEnabled(true).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.PAYOUT_REFUND).addSupportedInterestRefundTypesItem(SupportedInterestRefundTypesItem.MERCHANT_ISSUED_REFUND).recalculationRestFrequencyType(RecalculationRestFrequencyType.DAILY).paymentAllocation(List.of(//
        createPaymentAllocationInterestPrincipalPenaltyFee("DEFAULT", FuturePaymentAllocationRule.NEXT_INSTALLMENT),  //
        createPaymentAllocationInterestPrincipalPenaltyFee("PAYOUT_REFUND", FuturePaymentAllocationRule.LAST_INSTALLMENT),  //
        createPaymentAllocationInterestPrincipalPenaltyFee("MERCHANT_ISSUED_REFUND", FuturePaymentAllocationRule.LAST_INSTALLMENT))) //
        );
        Assertions.assertNotNull(loanProduct.getResourceId());
        return loanProduct.getResourceId();
    }

    private Long loanProductId = null;

    private Long getOrCreateLoanProduct() {
        if (loanProductId == null) {
            loanProductId = createLoanProduct();
        }
        return loanProductId;
    }

    @Test
    public void verifyMerchantIssuedRefundPostingForBackdatedLoan() {
        runAt("20250129", () -> {
            Long loanProductId = getOrCreateLoanProduct();
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProductId, "20240829", 450.0, 26.0, 12, null);
            Assertions.assertNotNull(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(450.0), "20240829");
            PostLoansLoanIdTransactionsResponse repayment = loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20250129", 500.0);
            Assertions.assertNotNull(repayment);
            Assertions.assertNotNull(repayment.getResourceId());
            verifyTransactions(loanId,  //
            transaction(450.0, "Disbursement", "20240829"),  //
            transaction(500.0, "Merchant Issued Refund", "20250129"),  //
            transaction(48.94, "Interest Refund", "20250129"),  //
            transaction(48.94, "Accrual", "20250129") //
            ); //
        });
    }

    /**
     * Goal: test Merchant issued Refund does not cause infinite loop in special case of 2 transaction. * interest
     * recalculation should be on. * merchant issued refund payment allocation should set to Last installment * default
     * payment allocation should set to Next Installment Make a repayment to repay first instalment on its due date Make
     * MerchantIssuedRefund to fully repay almost all the installments. 2nd installment should be fully unpaid and 3rd
     * installment should have less outstanding principal portion than the total outstanding interest on the loan ( 2nd
     * installment ). Make a 2nd MerchantIssuedRefund equal to remaining principal. Verify Repayment schedules and
     * transactions. Verify that the loan become overpaid by the amount of 2nd interest refund.
     */
    @Test
    public void verifyMerchantIssuedRefundInTwoPortion() {
        runAt("20250201", () -> {
            Long loanProductId = getOrCreateLoanProduct();
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProductId, "20250101", 100.0, 26.0, 6, null);
            Assertions.assertNotNull(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(100.0), "20250101");
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20250201", 17.94);
            loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20250201", 66.41);
            verifyTransactions(loanId,  //
            transaction(100.0, "Disbursement", "20250101"),  //
            transaction(17.94, "Repayment", "20250201"),  //
            transaction(66.41, "Merchant Issued Refund", "20250201"),  //
            transaction(1.47, "Interest Refund", "20250201") //
            );
            verifyRepaymentSchedule(loanId,  //
            installment(100.0, null, "20250101"),  //
            installment(15.73, 2.21, 0.0, true, "20250201"),  //
            installment(17.61, 0.33, 16.47, false, "20250301"),  //
            installment(12.84, 0.01, 0.26, false, "20250401"),  //
            installment(17.94, 0.0, 0.0, true, "20250501"),  //
            installment(17.94, 0.0, 0.0, true, "20250601"),  //
            installment(17.94, 0.0, 0.0, true, "20250701") //
            );
            loanTransactionHelper.makeLoanRepayment(loanId, "MerchantIssuedRefund", "20250201", 16.39);
            verifyTransactions(loanId,  //
            transaction(100.0, "Disbursement", "20250101"),  //
            transaction(17.94, "Repayment", "20250201"),  //
            transaction(66.41, "Merchant Issued Refund", "20250201"),  //
            transaction(1.47, "Interest Refund", "20250201"),  //
            transaction(16.39, "Merchant Issued Refund", "20250201"),  //
            transaction(0.36, "Interest Refund", "20250201"),  //
            transaction(2.21, "Accrual", "20250201") //
            );
            verifyRepaymentSchedule(loanId,  //
            installment(100.0, null, "20250101"),  //
            installment(15.73, 2.21, 0.0, true, "20250201"),  //
            installment(12.51, 0.0, 0.0, true, "20250301"),  //
            installment(17.94, 0.0, 0.0, true, "20250401"),  //
            installment(17.94, 0.0, 0.0, true, "20250501"),  //
            installment(17.94, 0.0, 0.0, true, "20250601"),  //
            installment(17.94, 0.0, 0.0, true, "20250701") //
            );
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            verifyLoanStatus(loanDetails, LoanStatus.OVERPAID);
            Assertions.assertEquals(0.36, Utils.getDoubleValue(loanDetails.getTotalOverpaid()));
        });
    }

    @Test
    public void allowToReprocessInterestRefundEvenIfNoTransactionWasChanged() {
        runAt("20250201", () -> {
            Long loanProductId = getOrCreateLoanProduct();
            Long loanId = applyAndApproveProgressiveLoan(client.getClientId(), loanProductId, "20250101", 100.0, 26.0, 6, null);
            Assertions.assertNotNull(loanId);
            disburseLoan(loanId, BigDecimal.valueOf(100.0), "20250101");
            final String transactionExternalId = UUID.randomUUID().toString();
            final PostLoansLoanIdTransactionsResponse refundResponse = loanTransactionHelper.makeMerchantIssuedRefund(loanId, new PostLoansLoanIdTransactionsRequest().dateFormat(DATETIME_PATTERN).transactionDate("20250201").locale("en").transactionAmount(66.41).externalId(transactionExternalId).interestRefundCalculation(false));
            Assertions.assertNotNull(refundResponse.getResourceId());
            verifyTransactions(loanId,  //
            transaction(100.0, "Disbursement", "20250101"),  //
            transaction(66.41, "Merchant Issued Refund", "20250201") //
            );
            // Create manual interest refund via API
            loanTransactionHelper.createManualInterestRefund(loanId, refundResponse.getResourceId(), "20250201", 0.47, null);
            verifyTransactions(loanId,  //
            transaction(100.0, "Disbursement", "20250101"),  //
            transaction(66.41, "Merchant Issued Refund", "20250201"),  //
            transaction(0.47, "Interest Refund", "20250201") //
            );
            PostLoansLoanIdTransactionsResponse repaymentResponse = loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20250120", 17.94);
            loanTransactionHelper.makeLoanRepayment(loanId, "Repayment", "20250125", 10.94);
            verifyTransactions(loanId,  //
            transaction(100.0, "Disbursement", "20250101"),  //
            transaction(17.94, "Repayment", "20250120"),  //
            transaction(10.94, "Repayment", "20250125"),  //
            transaction(66.41, "Merchant Issued Refund", "20250201"),  //
            transaction(1.47, "Interest Refund", "20250201") //
            );
            loanTransactionHelper.reverseLoanTransaction(loanId, repaymentResponse.getResourceId(), new PostLoansLoanIdTransactionsTransactionIdRequest().dateFormat(DATETIME_PATTERN).transactionDate("20250125").transactionAmount(0.0).locale("en"));
            verifyTransactions(loanId,  //
            transaction(100.0, "Disbursement", "20250101"),  //
            reversedTransaction(17.94, "Repayment", "20250120"),  //
            transaction(10.94, "Repayment", "20250125"),  //
            transaction(66.41, "Merchant Issued Refund", "20250201"),  //
            transaction(1.47, "Interest Refund", "20250201") //
            );
            GetLoansLoanIdResponse loanDetails = loanTransactionHelper.getLoanDetails(loanId);
            verifyLoanStatus(loanDetails, LoanStatus.ACTIVE);
            Assertions.assertEquals(23.97, Utils.getDoubleValue(loanDetails.getSummary().getTotalOutstanding()));
        });
    }
}
