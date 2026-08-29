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
package org.apache.fineract.portfolio.loanaccount.moduleapi;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

/**
 * Bulk-import loan lookup/helpers without leftover loan JPA (ADR-021).
 */
public interface BulkImportLoanPort {

    record LoanLookup(Long id, String accountNo, String clientName, Long clientId, String statusValue, String productName,
            BigDecimal principal, BigDecimal totalOutstanding, LocalDate disbursementDate) {}

    record ProductLookup(Long id, String name, String fundName, BigDecimal principal, BigDecimal minPrincipal, BigDecimal maxPrincipal,
            Integer numberOfRepayments, Integer minNumberOfRepayments, Integer maxNumberOfRepayments, Integer repaymentEvery,
            String repaymentFrequencyValue, BigDecimal interestRatePerPeriod, BigDecimal minInterestRatePerPeriod,
            BigDecimal maxInterestRatePerPeriod, String interestRateFrequencyValue, String amortizationTypeValue, String interestTypeValue,
            String interestCalculationPeriodTypeValue, BigDecimal inArrearsTolerance, String transactionProcessingStrategyName,
            Integer graceOnPrincipalPayment, Integer graceOnInterestPayment, Integer graceOnInterestCharged, LocalDate startDate,
            LocalDate closeDate) {}

    String repaymentStrategyCode(String strategyName);

    BigDecimal chargePercentageOf(BigDecimal principal, BigDecimal percentage);

    Long loanIdByAccountNumber(String accountNumber);

    List<LoanLookup> loansByOfficeId(Long officeId);

    List<ProductLookup> products();
}
