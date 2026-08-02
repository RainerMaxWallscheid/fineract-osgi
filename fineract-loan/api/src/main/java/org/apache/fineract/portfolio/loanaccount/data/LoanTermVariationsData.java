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
package org.apache.fineract.portfolio.loanaccount.data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTermVariationType;

public class LoanTermVariationsData implements Comparable<LoanTermVariationsData> {
    private final Long id;
    private final EnumOptionData termType;
    private LocalDate termVariationApplicableFrom;
    private final BigDecimal decimalValue;
    private final LocalDate dateValue;
    private final boolean isSpecificToInstallment;
    private Boolean isProcessed;
    private OffsetDateTime createdDate;

    public LoanTermVariationsData(final Long id, final EnumOptionData termType, final LocalDate termVariationApplicableFrom, final BigDecimal decimalValue, final LocalDate dateValue, final boolean isSpecificToInstallment) {
        this.id = id;
        this.termType = termType;
        this.termVariationApplicableFrom = termVariationApplicableFrom;
        this.decimalValue = decimalValue;
        this.dateValue = dateValue;
        this.isSpecificToInstallment = isSpecificToInstallment;
    }

    public LoanTermVariationsData(final Long id, final Integer termType, final LocalDate termVariationApplicableFrom, final BigDecimal decimalValue, final LocalDate dateValue, final boolean isSpecificToInstallment) {
        this.id = id;
        this.termType = toEnumOptionData(LoanTermVariationType.fromInt(termType));
        this.termVariationApplicableFrom = termVariationApplicableFrom;
        this.decimalValue = decimalValue;
        this.dateValue = dateValue;
        this.isSpecificToInstallment = isSpecificToInstallment;
    }

    /** Pure helper so this DTO stays on loan-api without depending on LoanEnumerations (impl residual). */
    private static EnumOptionData toEnumOptionData(final LoanTermVariationType type) {
        return switch (type) {
            case EMI_AMOUNT -> new EnumOptionData(LoanTermVariationType.EMI_AMOUNT.getValue().longValue(),
                    LoanTermVariationType.EMI_AMOUNT.getCode(), "emiAmount");
            case INTEREST_RATE -> new EnumOptionData(LoanTermVariationType.INTEREST_RATE.getValue().longValue(),
                    LoanTermVariationType.INTEREST_RATE.getCode(), "interestRate");
            case DELETE_INSTALLMENT -> new EnumOptionData(LoanTermVariationType.DELETE_INSTALLMENT.getValue().longValue(),
                    LoanTermVariationType.DELETE_INSTALLMENT.getCode(), "deleteInstallment");
            case DUE_DATE -> new EnumOptionData(LoanTermVariationType.DUE_DATE.getValue().longValue(),
                    LoanTermVariationType.DUE_DATE.getCode(), "dueDate");
            case INSERT_INSTALLMENT -> new EnumOptionData(LoanTermVariationType.INSERT_INSTALLMENT.getValue().longValue(),
                    LoanTermVariationType.INSERT_INSTALLMENT.getCode(), "insertInstallment");
            case PRINCIPAL_AMOUNT -> new EnumOptionData(LoanTermVariationType.PRINCIPAL_AMOUNT.getValue().longValue(),
                    LoanTermVariationType.PRINCIPAL_AMOUNT.getCode(), "principalAmount");
            case GRACE_ON_INTEREST -> new EnumOptionData(LoanTermVariationType.GRACE_ON_INTEREST.getValue().longValue(),
                    LoanTermVariationType.GRACE_ON_INTEREST.getCode(), "graceOnInterest");
            case GRACE_ON_PRINCIPAL -> new EnumOptionData(LoanTermVariationType.GRACE_ON_PRINCIPAL.getValue().longValue(),
                    LoanTermVariationType.GRACE_ON_PRINCIPAL.getCode(), "graceOnPrincipal");
            case EXTEND_REPAYMENT_PERIOD -> new EnumOptionData(LoanTermVariationType.EXTEND_REPAYMENT_PERIOD.getValue().longValue(),
                    LoanTermVariationType.EXTEND_REPAYMENT_PERIOD.getCode(), "extendRepaymentPeriod");
            case INTEREST_RATE_FROM_INSTALLMENT ->
                new EnumOptionData(LoanTermVariationType.INTEREST_RATE_FROM_INSTALLMENT.getValue().longValue(),
                        LoanTermVariationType.INTEREST_RATE_FROM_INSTALLMENT.getCode(), "interestRateForInstallment");
            case INTEREST_PAUSE -> new EnumOptionData(LoanTermVariationType.INTEREST_PAUSE.getValue().longValue(),
                    LoanTermVariationType.INTEREST_PAUSE.getCode(), "interestPause");
            default -> new EnumOptionData(LoanTermVariationType.INVALID.getValue().longValue(), LoanTermVariationType.INVALID.getCode(),
                    "Invalid");
        };
    }

    public LoanTermVariationsData(final EnumOptionData termType, final LocalDate termVariationApplicableFrom, final BigDecimal decimalValue, LocalDate dateValue, final boolean isSpecificToInstallment) {
        this.id = null;
        this.termType = termType;
        this.termVariationApplicableFrom = termVariationApplicableFrom;
        this.decimalValue = decimalValue;
        this.dateValue = dateValue;
        this.isSpecificToInstallment = isSpecificToInstallment;
    }

    public LoanTermVariationsData(Long id, EnumOptionData type, LocalDate termApplicableFrom, BigDecimal decimalValue, LocalDate dateValue, boolean isSpecificToInstallment, OffsetDateTime createdDate) {
        this(id, type, termApplicableFrom, decimalValue, dateValue, isSpecificToInstallment);
        this.createdDate = createdDate;
    }

    public LoanTermVariationType getTermVariationType() {
        return LoanTermVariationType.fromInt(this.termType.getId().intValue());
    }

    public boolean isApplicable(final LocalDate fromDate, final LocalDate dueDate) {
        return occursOnDayFromAndUpTo(fromDate, dueDate, this.termVariationApplicableFrom);
    }

    private boolean occursOnDayFromAndUpTo(final LocalDate fromNotInclusive, final LocalDate upToInclusive, final LocalDate target) {
        return DateUtils.isAfter(target, fromNotInclusive) && !DateUtils.isAfter(target, upToInclusive);
    }

    public boolean isApplicable(final LocalDate fromDate) {
        return occursBefore(fromDate, this.termVariationApplicableFrom);
    }

    private boolean occursBefore(final LocalDate date, final LocalDate target) {
        return target != null && !DateUtils.isAfter(target, date);
    }

    public boolean isSpecificToInstallment() {
        return this.isSpecificToInstallment;
    }

    public boolean isIsSpecificToInstallment() {
        return this.isSpecificToInstallment;
    }

    public Boolean isProcessed() {
        return this.isProcessed != null && this.isProcessed;
    }

    public void setProcessed(Boolean isProcessed) {
        this.isProcessed = isProcessed;
    }

    @Override
    public int compareTo(LoanTermVariationsData o) {
        int comparsion = getTermVariationApplicableFrom().compareTo(o.getTermVariationApplicableFrom());
        if (comparsion == 0) {
            if (o.getTermVariationType().isDueDateVariation() || o.getTermVariationType().isInsertInstallment()) {
                comparsion = 1;
            }
        }
        return comparsion;
    }

    public void setApplicableFromDate(final LocalDate applicableFromDate) {
        this.termVariationApplicableFrom = applicableFromDate;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getTermType() {
        return this.termType;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getTermVariationApplicableFrom() {
        return this.termVariationApplicableFrom;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDecimalValue() {
        return this.decimalValue;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDateValue() {
        return this.dateValue;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsProcessed() {
        return this.isProcessed;
    }

    @java.lang.SuppressWarnings("all")
        public OffsetDateTime getCreatedDate() {
        return this.createdDate;
    }
}
