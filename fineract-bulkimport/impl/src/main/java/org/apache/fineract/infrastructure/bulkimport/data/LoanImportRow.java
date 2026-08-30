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
package org.apache.fineract.infrastructure.bulkimport.data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Collection;
import java.util.List;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.infrastructure.core.data.StringEnumOptionData;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.portfolio.loanaccount.data.LoanChargeData;
import org.apache.fineract.portfolio.loanaccount.data.LoanCollateralManagementData;

/**
 * JSON payload for loan-application bulk import (same field names as leftover
 * {@code LoanAccountData} import instance).
 */
public class LoanImportRow {

    private EnumOptionData loanType;
    private Long clientId;
    private Long productId;
    private Long loanOfficerId;
    private LocalDate submittedOnDate;
    private Long fundId;
    private BigDecimal principal;
    private Integer numberOfRepayments;
    private Integer repaymentEvery;
    private EnumOptionData repaymentFrequencyType;
    private Integer loanTermFrequency;
    private EnumOptionData loanTermFrequencyType;
    private BigDecimal interestRatePerPeriod;
    private LocalDate expectedDisbursementDate;
    private EnumOptionData amortizationType;
    private EnumOptionData interestType;
    private EnumOptionData interestCalculationPeriodType;
    private BigDecimal inArrearsTolerance;
    private String transactionProcessingStrategyCode;
    private Integer graceOnPrincipalPayment;
    private Integer graceOnInterestPayment;
    private Integer graceOnInterestCharged;
    private LocalDate interestChargedFromDate;
    private LocalDate repaymentsStartingFromDate;
    private transient Integer rowIndex;
    private ExternalId externalId;
    private Long groupId;
    private Collection<LoanChargeData> charges;
    private String linkAccountId;
    private String locale;
    private String dateFormat;
    private List<LoanCollateralManagementData> collateral;
    private Integer fixedLength;
    private StringEnumOptionData daysInYearCustomStrategy;

    public Integer getRowIndex() {
        return this.rowIndex;
    }

    public String getLocale() {
        return this.locale;
    }

    public static LoanImportRow individual(final EnumOptionData loanType, final Long clientId, final Long productId,
            final Long loanOfficerId, final LocalDate submittedOnDate, final Long fundId, final BigDecimal principal,
            final Integer numberOfRepayments, final Integer repaymentEvery, final EnumOptionData repaymentFrequencyType,
            final Integer loanTermFrequency, final EnumOptionData loanTermFrequencyType, final BigDecimal interestRatePerPeriod,
            final LocalDate expectedDisbursementDate, final EnumOptionData amortizationType, final EnumOptionData interestType,
            final EnumOptionData interestCalculationPeriodType, final BigDecimal inArrearsTolerance,
            final String transactionProcessingStrategyCode, final Integer graceOnPrincipalPayment, final Integer graceOnInterestPayment,
            final Integer graceOnInterestCharged, final LocalDate interestChargedFromDate, final LocalDate repaymentsStartingFromDate,
            final Integer rowIndex, final ExternalId externalId, final Long groupId, final Collection<LoanChargeData> charges,
            final String linkAccountId, final String locale, final String dateFormat, final List<LoanCollateralManagementData> collateral,
            final Integer fixedLength, final StringEnumOptionData daysInYearCustomStrategy) {
        final LoanImportRow row = new LoanImportRow();
        row.loanType = loanType;
        row.clientId = clientId;
        row.productId = productId;
        row.loanOfficerId = loanOfficerId;
        row.submittedOnDate = submittedOnDate;
        row.fundId = fundId;
        row.principal = principal;
        row.numberOfRepayments = numberOfRepayments;
        row.repaymentEvery = repaymentEvery;
        row.repaymentFrequencyType = repaymentFrequencyType;
        row.loanTermFrequency = loanTermFrequency;
        row.loanTermFrequencyType = loanTermFrequencyType;
        row.interestRatePerPeriod = interestRatePerPeriod;
        row.expectedDisbursementDate = expectedDisbursementDate;
        row.amortizationType = amortizationType;
        row.interestType = interestType;
        row.interestCalculationPeriodType = interestCalculationPeriodType;
        row.inArrearsTolerance = inArrearsTolerance;
        row.transactionProcessingStrategyCode = transactionProcessingStrategyCode;
        row.graceOnPrincipalPayment = graceOnPrincipalPayment;
        row.graceOnInterestPayment = graceOnInterestPayment;
        row.graceOnInterestCharged = graceOnInterestCharged;
        row.interestChargedFromDate = interestChargedFromDate;
        row.repaymentsStartingFromDate = repaymentsStartingFromDate;
        row.rowIndex = rowIndex;
        row.externalId = externalId;
        row.groupId = groupId;
        row.charges = charges;
        row.linkAccountId = linkAccountId;
        row.locale = locale;
        row.dateFormat = dateFormat;
        row.collateral = collateral;
        row.fixedLength = fixedLength;
        row.daysInYearCustomStrategy = daysInYearCustomStrategy;
        return row;
    }

    public static LoanImportRow group(final EnumOptionData loanType, final Long groupId, final Long productId, final Long loanOfficerId,
            final LocalDate submittedOnDate, final Long fundId, final BigDecimal principal, final Integer numberOfRepayments,
            final Integer repaymentEvery, final EnumOptionData repaymentFrequencyType, final Integer loanTermFrequency,
            final EnumOptionData loanTermFrequencyType, final BigDecimal interestRatePerPeriod, final LocalDate expectedDisbursementDate,
            final EnumOptionData amortizationType, final EnumOptionData interestType, final EnumOptionData interestCalculationPeriodType,
            final BigDecimal inArrearsTolerance, final String transactionProcessingStrategyCode, final Integer graceOnPrincipalPayment,
            final Integer graceOnInterestPayment, final Integer graceOnInterestCharged, final LocalDate interestChargedFromDate,
            final LocalDate repaymentsStartingFromDate, final Integer rowIndex, final ExternalId externalId, final String linkAccountId,
            final String locale, final String dateFormat, final Integer fixedLength) {
        return individual(loanType, null, productId, loanOfficerId, submittedOnDate, fundId, principal, numberOfRepayments, repaymentEvery,
                repaymentFrequencyType, loanTermFrequency, loanTermFrequencyType, interestRatePerPeriod, expectedDisbursementDate,
                amortizationType, interestType, interestCalculationPeriodType, inArrearsTolerance, transactionProcessingStrategyCode,
                graceOnPrincipalPayment, graceOnInterestPayment, graceOnInterestCharged, interestChargedFromDate, repaymentsStartingFromDate,
                rowIndex, externalId, groupId, null, linkAccountId, locale, dateFormat, null, fixedLength, null);
    }
}
