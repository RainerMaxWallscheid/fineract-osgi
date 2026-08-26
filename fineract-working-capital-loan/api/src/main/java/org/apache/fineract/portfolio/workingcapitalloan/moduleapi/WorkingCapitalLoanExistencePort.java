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
package org.apache.fineract.portfolio.workingcapitalloan.moduleapi;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.portfolio.loanaccount.data.LoanApplicationTimelineData;

/**
 * ID-only working-capital loan existence/status check (ADR-021). Foreign BCs
 * must not depend on leftover {@code WorkingCapitalLoanRepository}.
 */
public interface WorkingCapitalLoanExistencePort {

    boolean existsById(Long loanId);

    /**
     * Throws {@code WorkingCapitalLoanNotFoundException} when {@code loanId} is unknown.
     */
    boolean isSubmittedAndPendingApproval(Long loanId);

    /**
     * Throws {@code WorkingCapitalLoanNotFoundException} when {@code loanId} is unknown.
     */
    String statusCode(Long loanId);

    /**
     * Throws {@code WorkingCapitalLoanNotFoundException} when {@code loanId} is unknown.
     */
    ExternalId externalId(Long loanId);

    /**
     * Throws {@code WorkingCapitalLoanNotFoundException} when {@code externalId} is unknown.
     */
    Long idByExternalId(ExternalId externalId);

    /**
     * Nullable external-id lookup. Returns {@code null} when unknown.
     */
    Long findIdByExternalId(ExternalId externalId);

    /**
     * True when any of {@code loanIds} is behind {@code cobDate} or disbursed on that date
     * with a null last-closed business date.
     */
    boolean anyBehindCobDate(LocalDate cobDate, List<Long> loanIds);

    boolean existsByAccountNumber(String accountNumber);

    record AccountNumberSource(Long id, Long clientId, String productShortName) {}

    AccountNumberSource accountNumberSource(Object loan);

    record SummaryView(Long id, String accountNo, String externalId, Long productId, String productName, String shortProductName,
            Long statusId, String statusCode, String statusValue, CurrencyData currency, Integer loanCycle,
            LoanApplicationTimelineData timeline, Boolean inArrears, BigDecimal loanBalance, BigDecimal amountPaid) {}

    List<SummaryView> retrieveLoanSummaryData(Long clientId);
}
