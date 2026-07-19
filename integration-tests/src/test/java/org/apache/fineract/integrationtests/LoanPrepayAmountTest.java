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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import org.apache.fineract.client.models.GetLoansLoanIdResponse;
import org.apache.fineract.client.models.GetLoansLoanIdTransactionsTemplateResponse;
import org.apache.fineract.integrationtests.client.feign.FeignLoanTestBase;
import org.apache.fineract.integrationtests.client.feign.modules.LoanRequestBuilders;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class LoanPrepayAmountTest extends FeignLoanTestBase {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(LoanPrepayAmountTest.class);
    Long clientId;
    Long loanId;

    @BeforeEach
    public void setup() {
        clientId = createClient();
    }

    @Test
    public void testLoanPrepayAmountProgressive() {
        runAt("20240101", () -> {
            final Long loanProductId = createLoanProduct(create4IProgressive());
            Long loanIdLocal = applyForLoan(applyLP2ProgressiveLoanRequest(clientId, loanProductId, "20240101", 1000.0, 9.99, 6, null));
            loanId = loanIdLocal;
            approveLoan(loanId, LoanRequestBuilders.approveLoan(1000.0, "20240101"));
            disburseLoan(loanId, BigDecimal.valueOf(250.0), "20240101");
        });
        runAt("7 january 2024", () -> {
            disburseLoan(loanId, BigDecimal.valueOf(350.0), "20240104");
            disburseLoan(loanId, BigDecimal.valueOf(400.0), "20240105");
        });
        for (int i = 7; i <= 31; i++) {
            runAt(i + " January 2024", () -> {
                GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
                GetLoansLoanIdTransactionsTemplateResponse prepayAmountResponse = getPrepaymentAmount(loanId, null, DATETIME_PATTERN);
                Assertions.assertEquals(BigDecimal.valueOf(prepayAmountResponse.getInterestPortion()).stripTrailingZeros(), loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros());
            });
        }
    }

    @Test
    public void testLoanPrepayAmountProgressivePartialRepayment() {
        runAt("20250315", () -> {
            final Long loanProductId = createLoanProduct(create4IProgressive().interestRatePerPeriod(35.99).numberOfRepayments(12).isInterestRecalculationEnabled(true));
            Long loanIdLocal = applyForLoan(applyLP2ProgressiveLoanRequest(clientId, loanProductId, "20250315", 296.79, 35.99, 12, null));
            loanId = loanIdLocal;
            approveLoan(loanId, LoanRequestBuilders.approveLoan(296.79, "20250315"));
            disburseLoan(loanId, BigDecimal.valueOf(296.79), "20250315");
        });
        runAt("20250316", () -> {
            addRepaymentForLoan(loanId, 59.0, "20250316");
            GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
            Assertions.assertEquals(BigDecimal.ZERO, loanDetails.getSummary().getTotalUnpaidPayableDueInterest().stripTrailingZeros());
            Assertions.assertEquals(BigDecimal.ZERO, loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros());
            GetLoansLoanIdTransactionsTemplateResponse prepayAmountResponse = getPrepaymentAmount(loanId, "20250316", DATETIME_PATTERN);
            Assertions.assertEquals(BigDecimal.valueOf(prepayAmountResponse.getInterestPortion()).stripTrailingZeros(), loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest());
        });
        for (int i = 1; i < 4; i++) {
            executeInlineCOB(loanId);
            LocalDate date = LocalDate.of(2025, 3, 17).plusDays(i * 11);
            String formattedDate = DateTimeFormatter.ofPattern(DATETIME_PATTERN, Locale.ENGLISH).format(date);
            runAt(formattedDate, () -> {
                GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
                GetLoansLoanIdTransactionsTemplateResponse prepayAmountResponse = getPrepaymentAmount(loanId, formattedDate, DATETIME_PATTERN);
                Assertions.assertEquals(loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros(), BigDecimal.valueOf(prepayAmountResponse.getInterestPortion()).stripTrailingZeros());
            });
        }
    }

    @Test
    public void testLoanPrepayAmountProgressivePartialRepaymentNoInterestRecalculation() {
        runAt("20250315", () -> {
            final Long loanProductId = createLoanProduct(create4IProgressive().interestRatePerPeriod(35.99).numberOfRepayments(12).isInterestRecalculationEnabled(false));
            Long loanIdLocal = applyForLoan(applyLP2ProgressiveLoanRequest(clientId, loanProductId, "20250315", 296.79, 35.99, 12, null));
            loanId = loanIdLocal;
            approveLoan(loanId, LoanRequestBuilders.approveLoan(296.79, "20250315"));
            disburseLoan(loanId, BigDecimal.valueOf(296.79), "20250315");
            executeInlineCOB(loanId);
        });
        runAt("20250316", () -> {
            addRepaymentForLoan(loanId, 59.0, "20250316");
            GetLoansLoanIdResponse loanDetails = getLoanDetails(loanId);
            Assertions.assertEquals(BigDecimal.ZERO, loanDetails.getSummary().getTotalUnpaidPayableDueInterest().stripTrailingZeros());
            Assertions.assertEquals(BigDecimal.ZERO, loanDetails.getSummary().getTotalUnpaidPayableNotDueInterest().stripTrailingZeros());
            GetLoansLoanIdTransactionsTemplateResponse prepayAmountResponse = getPrepaymentAmount(loanId, "20250316", DATETIME_PATTERN);
            Assertions.assertEquals(BigDecimal.valueOf(44.43).stripTrailingZeros(), BigDecimal.valueOf(prepayAmountResponse.getInterestPortion()).stripTrailingZeros());
        });
    }
}
