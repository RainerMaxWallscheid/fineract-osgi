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
import java.time.LocalDate;
import org.apache.fineract.client.models.GetLoansLoanIdResponse;
import org.apache.fineract.client.models.PostChargesResponse;
import org.apache.fineract.infrastructure.configuration.api.GlobalConfigurationConstants;
import org.apache.fineract.integrationtests.client.feign.FeignLoanTestBase;
import org.apache.fineract.integrationtests.client.feign.modules.LoanRequestBuilders;
import org.apache.fineract.integrationtests.common.Utils;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class LoanChargeProgressiveTest extends FeignLoanTestBase {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(LoanChargeProgressiveTest.class);
    private Long clientId;
    private Long loanId;

    // create client, progressive loan product, loan with disburse limit 1000 for the client,
    // and disburse 250 on 20240601
    @BeforeEach
    public void beforeEach() {
        runAt("20240601", () -> {
            clientId = createClient();
            final Long loanProductId = createLoanProduct(create4IProgressive());
            loanId = applyForLoan(applyLP2ProgressiveLoanRequest(clientId, loanProductId, "20240601", 1000.0, 10.0, 4, null));
            approveLoan(loanId, LoanRequestBuilders.approveLoan(1000.0, "20240601"));
            disburseLoan(loanId, BigDecimal.valueOf(250.0), "20240601");
        });
    }

    @Test
    public void loanChargeAfterMaturityTest() {
        runAt("20241002", () -> {
            final PostChargesResponse chargeResponse = createCharge(20.0, "EUR");
            addLoanCharge(loanId, chargeResponse.getResourceId(), "20241002", 20.0);
            final GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
            validateRepaymentPeriod(loanDetails, 5, LocalDate.of(2024, 10, 2), 0, 20, 0, 0);
            executeInlineCOB(loanId);
            final GetLoansLoanIdResponse loanDetails2 = getLoanDetails(loanId);
            validateRepaymentPeriod(loanDetails2, 5, LocalDate.of(2024, 10, 2), 0, 20, 0, 0);
        });
    }

    @Test
    public void immediateChargeAccrualPostMaturityTest() {
        runAt("20241003", () -> {
            executeInlineCOB(loanId);
            globalConfigurationHelper.manageConfigurations(GlobalConfigurationConstants.ENABLE_IMMEDIATE_CHARGE_ACCRUAL_POST_MATURITY, true);
            final PostChargesResponse chargeResponse = createCharge(20.0, "EUR");
            addLoanCharge(loanId, chargeResponse.getResourceId(), "20241003", 20.0);
            final GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
            Assertions.assertTrue(loanDetails.getTransactions().stream().anyMatch(t -> t.getType().getAccrual() && Utils.getDoubleValue(t.getAmount()).equals(20.0)));
        });
        runAt("20241004", () -> {
            globalConfigurationHelper.manageConfigurations(GlobalConfigurationConstants.ENABLE_IMMEDIATE_CHARGE_ACCRUAL_POST_MATURITY, false);
            executeInlineCOB(loanId);
            final GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
            Assertions.assertTrue(loanDetails.getTransactions().stream().anyMatch(t -> t.getType().getAccrual() && Utils.getDoubleValue(t.getFeeChargesPortion()).equals(20.0)));
        });
    }

    @AfterEach
    public void afterEach() {
        globalConfigurationHelper.manageConfigurations(GlobalConfigurationConstants.ENABLE_IMMEDIATE_CHARGE_ACCRUAL_POST_MATURITY, false);
    }
}
