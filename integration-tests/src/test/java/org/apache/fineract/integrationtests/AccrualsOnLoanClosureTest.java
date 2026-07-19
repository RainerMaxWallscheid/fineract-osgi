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

import static org.apache.fineract.infrastructure.configuration.api.GlobalConfigurationConstants.CHARGE_ACCRUAL_DATE;
import java.math.BigDecimal;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.util.Locale;
import org.apache.fineract.client.models.ChargeRequest;
import org.apache.fineract.client.models.GetLoansLoanIdResponse;
import org.apache.fineract.client.models.PostChargesResponse;
import org.apache.fineract.client.models.PostLoansLoanIdChargesRequest;
import org.apache.fineract.client.models.PostLoansLoanIdTransactionsRequest;
import org.apache.fineract.client.models.PutGlobalConfigurationsRequest;
import org.apache.fineract.integrationtests.client.feign.FeignLoanTestBase;
import org.apache.fineract.integrationtests.common.Utils;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class AccrualsOnLoanClosureTest extends FeignLoanTestBase {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(AccrualsOnLoanClosureTest.class);
    private DateTimeFormatter dateFormatter = new DateTimeFormatterBuilder().appendPattern("yyyyMMdd").toFormatter(Locale.ENGLISH);
    private static final String startDate = "20250422";
    private static final String disbursementDate = "20240422";
    private static final String repaymentDate = "20240425";
    private static final Double disbursementAmount = 800.0;
    private static final Double repaymentAmount = 820.0;
    private static final Double chargeAmount = 20.0;
    private static Long loanId;
    private static PostChargesResponse penaltyResponse;
    private static final String penaltyCharge1AddedDate = "20240424";

    @Test
    public void testAccrualCreatedOnLoanClosureWithSubmittedDate() {
        Long clientId = createClient();
        Long loanProductId = createLoanProduct(createOnePeriod30DaysLongNoInterestPeriodicAccrualProduct());
        loanId = applyAndApproveLoan(clientId, loanProductId, disbursementDate, disbursementAmount);
        Assertions.assertNotNull(loanId);
        disburseLoan(loanId, BigDecimal.valueOf(disbursementAmount), disbursementDate);
        penaltyResponse = chargesHelper.createCharge(new ChargeRequest().active(true).chargeTimeType(2).chargeAppliesTo(1).chargeCalculationType(1).penalty(true).amount(20.0).currencyCode("USD").locale("en").chargePaymentMode(0).name(Utils.randomStringGenerator("PENALTY_", 6)));
        runAt(startDate, () -> {
            globalConfigurationHelper.updateGlobalConfiguration(CHARGE_ACCRUAL_DATE, new PutGlobalConfigurationsRequest().stringValue("submitted-date"));
            addLoanCharge(loanId, new PostLoansLoanIdChargesRequest().dateFormat("yyyyMMdd").locale("en").chargeId(penaltyResponse.getResourceId()).amount(chargeAmount).dueDate(penaltyCharge1AddedDate));
            addRepayment(loanId, new PostLoansLoanIdTransactionsRequest().dateFormat("yyyyMMdd").transactionDate(repaymentDate).locale("en").transactionAmount(repaymentAmount));
            GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
            verifyRepaymentSchedule(loanId,  //
            installment(800.0, null, "20240422"),  //
            installment(800.0, 0.0, 0.0, 20.0, 0.0, true, "20240522"));
            verifyTransactions(loanId,  //
            transaction(800.0, "Disbursement", "20240422", 800.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0), transaction(820.0, "Repayment", "20240425", 0.0, 800.0, 0.0, 0.0, 20.0, 0.0, 0.0), transaction(20.0, "Accrual", "20240425", 0.0, 0.0, 0.0, 0.0, 20.0, 0.0, 0.0));
            globalConfigurationHelper.updateGlobalConfiguration(CHARGE_ACCRUAL_DATE, new PutGlobalConfigurationsRequest().stringValue("due-date"));
        });
    }
}
