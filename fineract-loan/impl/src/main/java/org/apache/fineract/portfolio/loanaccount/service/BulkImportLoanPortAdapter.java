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
package org.apache.fineract.portfolio.loanaccount.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import org.apache.fineract.infrastructure.core.service.SearchParameters;
import org.apache.fineract.portfolio.loanaccount.data.LoanAccountData;
import org.apache.fineract.portfolio.loanaccount.domain.LoanCharge;
import org.apache.fineract.portfolio.loanaccount.domain.LoanRepaymentScheduleTransactionProcessorFactory;
import org.apache.fineract.portfolio.loanaccount.domain.transactionprocessor.LoanRepaymentScheduleTransactionProcessor;
import org.apache.fineract.portfolio.loanaccount.moduleapi.BulkImportLoanPort;
import org.apache.fineract.portfolio.loanproduct.data.LoanProductData;
import org.apache.fineract.portfolio.loanproduct.service.LoanProductReadPlatformService;
import org.springframework.stereotype.Service;

@Service
public class BulkImportLoanPortAdapter implements BulkImportLoanPort {

    private final LoanRepaymentScheduleTransactionProcessorFactory loanRepaymentScheduleTransactionProcessorFactory;
    private final LoanReadPlatformService loanReadPlatformService;
    private final LoanProductReadPlatformService loanProductReadPlatformService;

    public BulkImportLoanPortAdapter(
            final LoanRepaymentScheduleTransactionProcessorFactory loanRepaymentScheduleTransactionProcessorFactory,
            final LoanReadPlatformService loanReadPlatformService, final LoanProductReadPlatformService loanProductReadPlatformService) {
        this.loanRepaymentScheduleTransactionProcessorFactory = loanRepaymentScheduleTransactionProcessorFactory;
        this.loanReadPlatformService = loanReadPlatformService;
        this.loanProductReadPlatformService = loanProductReadPlatformService;
    }

    @Override
    public String repaymentStrategyCode(final String strategyName) {
        final LoanRepaymentScheduleTransactionProcessor processor = this.loanRepaymentScheduleTransactionProcessorFactory
                .determineProcessor(strategyName);
        if (processor != null) {
            return processor.getCode();
        }
        return "mifos-standard-strategy";
    }

    @Override
    public BigDecimal chargePercentageOf(final BigDecimal principal, final BigDecimal percentage) {
        return LoanCharge.percentageOf(principal, percentage);
    }

    @Override
    public Long loanIdByAccountNumber(final String accountNumber) {
        return this.loanReadPlatformService.retrieveLoanIdByAccountNumber(accountNumber);
    }

    @Override
    public List<LoanLookup> loansByOfficeId(final Long officeId) {
        final SearchParameters searchParameters = officeId == null ? null : SearchParameters.builder().officeId(officeId).build();
        final List<LoanAccountData> loans = this.loanReadPlatformService.retrieveAll(searchParameters).getPageItems();
        final List<LoanLookup> lookups = new ArrayList<>();
        if (loans == null) {
            return lookups;
        }
        for (final LoanAccountData loan : loans) {
            lookups.add(new LoanLookup(loan.getId(), loan.getAccountNo(), loan.getClientName(), loan.getClientId(),
                    loan.getStatus() == null ? null : loan.getStatus().getValue(), loan.getLoanProductName(), loan.getPrincipal(),
                    loan.getSummary() == null ? null : loan.getSummary().getTotalOutstanding(),
                    loan.getTimeline() == null ? null : loan.getTimeline().getDisbursementDate()));
        }
        return lookups;
    }

    @Override
    public List<ProductLookup> products() {
        final List<ProductLookup> lookups = new ArrayList<>();
        for (final LoanProductData product : this.loanProductReadPlatformService.retrieveAllLoanProducts()) {
            lookups.add(new ProductLookup(product.getId(), product.getName(), product.getFundName(), product.getPrincipal(),
                    product.getMinPrincipal(), product.getMaxPrincipal(), product.getNumberOfRepayments(),
                    product.getMinNumberOfRepayments(), product.getMaxNumberOfRepayments(), product.getRepaymentEvery(),
                    product.getRepaymentFrequencyType() == null ? null : product.getRepaymentFrequencyType().getValue(),
                    product.getInterestRatePerPeriod(), product.getMinInterestRatePerPeriod(), product.getMaxInterestRatePerPeriod(),
                    product.getInterestRateFrequencyType() == null ? null : product.getInterestRateFrequencyType().getValue(),
                    product.getAmortizationType() == null ? null : product.getAmortizationType().getValue(),
                    product.getInterestType() == null ? null : product.getInterestType().getValue(),
                    product.getInterestCalculationPeriodType() == null ? null : product.getInterestCalculationPeriodType().getValue(),
                    product.getInArrearsTolerance(), product.getTransactionProcessingStrategyName(), product.getGraceOnPrincipalPayment(),
                    product.getGraceOnInterestPayment(), product.getGraceOnInterestCharged(), product.getStartDate(),
                    product.getCloseDate()));
        }
        return lookups;
    }
}
