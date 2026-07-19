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

import static org.apache.fineract.integrationtests.client.feign.modules.LoanTestData.DATETIME_PATTERN;

import java.math.BigDecimal;
import org.apache.fineract.client.models.GetLoansLoanIdResponse;
import org.apache.fineract.client.models.GetLoansLoanIdTransactionsTemplateResponse;
import org.apache.fineract.integrationtests.client.feign.FeignLoanTestBase;
import org.apache.fineract.integrationtests.client.feign.modules.LoanRequestBuilders;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class LoanPayOffTest extends FeignLoanTestBase {

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
    public void testPayOffOnDisbursementDate() {
        runAt("20240601", () -> {
            GetLoansLoanIdTransactionsTemplateResponse prepayAmount = getPrepaymentAmount(loanId, null, DATETIME_PATTERN);

            Assertions.assertEquals(250.0, prepayAmount.getAmount());

            addRepaymentForLoan(loanId, 250.0, "20240601");

            final GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
            Assertions.assertNotNull(loanDetails.getStatus());
            Assertions.assertEquals(Boolean.TRUE, loanDetails.getStatus().getClosedObligationsMet());
        });
    }
}
