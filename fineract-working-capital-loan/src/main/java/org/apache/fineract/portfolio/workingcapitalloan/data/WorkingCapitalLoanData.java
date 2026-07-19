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
package org.apache.fineract.portfolio.workingcapitalloan.data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import org.apache.fineract.infrastructure.core.data.StringEnumOptionData;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.portfolio.client.data.ClientData;
import org.apache.fineract.portfolio.delinquency.data.DelinquencyBucketData;
import org.apache.fineract.portfolio.loanaccount.data.LoanApplicationTimelineData;
import org.apache.fineract.portfolio.loanaccount.data.LoanStatusEnumData;
import org.apache.fineract.portfolio.loanorigination.data.LoanOriginatorData;
import org.apache.fineract.portfolio.workingcapitalloanbreach.data.WorkingCapitalBreachData;
import org.apache.fineract.portfolio.workingcapitalloannearbreach.data.WorkingCapitalNearBreachData;
import org.apache.fineract.portfolio.workingcapitalloanproduct.data.WorkingCapitalLoanProductData;
import org.apache.fineract.portfolio.workingcapitalloanproduct.data.WorkingCapitalPaymentAllocationData;

/**
 * Data Transfer Object for Working Capital Loan (application/summary).
 */
public class WorkingCapitalLoanData implements Serializable {
    private Long id;
    private String accountNo;
    private ExternalId externalId;
    private ClientData client;
    private Long clientId;
    private String clientAccountNo;
    private String clientName;
    private ExternalId clientExternalId;
    private Long clientOfficeId;
    private Long fundId;
    private String fundName;
    private WorkingCapitalLoanProductData product;
    private Long loanProductId;
    private String loanProductName;
    private String loanProductDescription;
    private LoanStatusEnumData status;
    private BigDecimal proposedPrincipal;
    private BigDecimal approvedPrincipal;
    private BigDecimal principal;
    private BigDecimal netDisbursalAmount;
    private StringEnumOptionData amortizationType;
    private Integer npvDayCount;
    private Integer loanProductCounter;
    private List<WorkingCapitalLoanChargeData> charges;
    private CurrencyData currency;
    private BigDecimal paymentRate;
    private Integer repaymentEvery;
    private StringEnumOptionData repaymentFrequencyType;
    private BigDecimal discountFee;
    private BigDecimal proposedDiscountFee;
    private BigDecimal approvedDiscountFee;
    private Integer numberOfRepayments;
    private BigDecimal periodPaymentAmount;
    private BigDecimal dailyEir;
    private BigDecimal calculatedAnnualEir;
    private DelinquencyBucketData delinquencyBucket;
    private WorkingCapitalBreachData breach;
    private WorkingCapitalNearBreachData nearBreach;
    private LocalDate lastClosedBusinessDate;
    private List<WorkingCapitalPaymentAllocationData> paymentAllocation;
    private LoanApplicationTimelineData timeline;
    private List<WorkingCapitalLoanDisbursementDetailData> disbursementDetails;
    private WorkingCapitalLoanBalanceData balance;
    private Integer delinquencyGraceDays;
    private StringEnumOptionData delinquencyStartType;
    private Integer breachGraceDays;
    private BigDecimal totalPaymentVolume;
    private LocalDate delinquencyStartDate;
    private LocalDate breachStartDate;
    private WorkingCapitalLoanCollectionData delinquent;
    private Boolean enableInstallmentLevelDelinquency;
    private WorkingCapitalLoanSummaryData summary;
    private List<LoanOriginatorData> originators;
    private Boolean fraud;
    private Boolean chargedOff;


    @java.lang.SuppressWarnings("all")
        public static class WorkingCapitalLoanDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String accountNo;
        @java.lang.SuppressWarnings("all")
                private ExternalId externalId;
        @java.lang.SuppressWarnings("all")
                private ClientData client;
        @java.lang.SuppressWarnings("all")
                private Long clientId;
        @java.lang.SuppressWarnings("all")
                private String clientAccountNo;
        @java.lang.SuppressWarnings("all")
                private String clientName;
        @java.lang.SuppressWarnings("all")
                private ExternalId clientExternalId;
        @java.lang.SuppressWarnings("all")
                private Long clientOfficeId;
        @java.lang.SuppressWarnings("all")
                private Long fundId;
        @java.lang.SuppressWarnings("all")
                private String fundName;
        @java.lang.SuppressWarnings("all")
                private WorkingCapitalLoanProductData product;
        @java.lang.SuppressWarnings("all")
                private Long loanProductId;
        @java.lang.SuppressWarnings("all")
                private String loanProductName;
        @java.lang.SuppressWarnings("all")
                private String loanProductDescription;
        @java.lang.SuppressWarnings("all")
                private LoanStatusEnumData status;
        @java.lang.SuppressWarnings("all")
                private BigDecimal proposedPrincipal;
        @java.lang.SuppressWarnings("all")
                private BigDecimal approvedPrincipal;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principal;
        @java.lang.SuppressWarnings("all")
                private BigDecimal netDisbursalAmount;
        @java.lang.SuppressWarnings("all")
                private StringEnumOptionData amortizationType;
        @java.lang.SuppressWarnings("all")
                private Integer npvDayCount;
        @java.lang.SuppressWarnings("all")
                private Integer loanProductCounter;
        @java.lang.SuppressWarnings("all")
                private List<WorkingCapitalLoanChargeData> charges;
        @java.lang.SuppressWarnings("all")
                private CurrencyData currency;
        @java.lang.SuppressWarnings("all")
                private BigDecimal paymentRate;
        @java.lang.SuppressWarnings("all")
                private Integer repaymentEvery;
        @java.lang.SuppressWarnings("all")
                private StringEnumOptionData repaymentFrequencyType;
        @java.lang.SuppressWarnings("all")
                private BigDecimal discountFee;
        @java.lang.SuppressWarnings("all")
                private BigDecimal proposedDiscountFee;
        @java.lang.SuppressWarnings("all")
                private BigDecimal approvedDiscountFee;
        @java.lang.SuppressWarnings("all")
                private Integer numberOfRepayments;
        @java.lang.SuppressWarnings("all")
                private BigDecimal periodPaymentAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal dailyEir;
        @java.lang.SuppressWarnings("all")
                private BigDecimal calculatedAnnualEir;
        @java.lang.SuppressWarnings("all")
                private DelinquencyBucketData delinquencyBucket;
        @java.lang.SuppressWarnings("all")
                private WorkingCapitalBreachData breach;
        @java.lang.SuppressWarnings("all")
                private WorkingCapitalNearBreachData nearBreach;
        @java.lang.SuppressWarnings("all")
                private LocalDate lastClosedBusinessDate;
        @java.lang.SuppressWarnings("all")
                private List<WorkingCapitalPaymentAllocationData> paymentAllocation;
        @java.lang.SuppressWarnings("all")
                private LoanApplicationTimelineData timeline;
        @java.lang.SuppressWarnings("all")
                private List<WorkingCapitalLoanDisbursementDetailData> disbursementDetails;
        @java.lang.SuppressWarnings("all")
                private WorkingCapitalLoanBalanceData balance;
        @java.lang.SuppressWarnings("all")
                private Integer delinquencyGraceDays;
        @java.lang.SuppressWarnings("all")
                private StringEnumOptionData delinquencyStartType;
        @java.lang.SuppressWarnings("all")
                private Integer breachGraceDays;
        @java.lang.SuppressWarnings("all")
                private BigDecimal totalPaymentVolume;
        @java.lang.SuppressWarnings("all")
                private LocalDate delinquencyStartDate;
        @java.lang.SuppressWarnings("all")
                private LocalDate breachStartDate;
        @java.lang.SuppressWarnings("all")
                private WorkingCapitalLoanCollectionData delinquent;
        @java.lang.SuppressWarnings("all")
                private Boolean enableInstallmentLevelDelinquency;
        @java.lang.SuppressWarnings("all")
                private WorkingCapitalLoanSummaryData summary;
        @java.lang.SuppressWarnings("all")
                private List<LoanOriginatorData> originators;
        @java.lang.SuppressWarnings("all")
                private Boolean fraud;
        @java.lang.SuppressWarnings("all")
                private Boolean chargedOff;

        @java.lang.SuppressWarnings("all")
                WorkingCapitalLoanDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder accountNo(final String accountNo) {
            this.accountNo = accountNo;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder externalId(final ExternalId externalId) {
            this.externalId = externalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder client(final ClientData client) {
            this.client = client;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder clientId(final Long clientId) {
            this.clientId = clientId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder clientAccountNo(final String clientAccountNo) {
            this.clientAccountNo = clientAccountNo;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder clientName(final String clientName) {
            this.clientName = clientName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder clientExternalId(final ExternalId clientExternalId) {
            this.clientExternalId = clientExternalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder clientOfficeId(final Long clientOfficeId) {
            this.clientOfficeId = clientOfficeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder fundId(final Long fundId) {
            this.fundId = fundId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder fundName(final String fundName) {
            this.fundName = fundName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder product(final WorkingCapitalLoanProductData product) {
            this.product = product;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder loanProductId(final Long loanProductId) {
            this.loanProductId = loanProductId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder loanProductName(final String loanProductName) {
            this.loanProductName = loanProductName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder loanProductDescription(final String loanProductDescription) {
            this.loanProductDescription = loanProductDescription;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder status(final LoanStatusEnumData status) {
            this.status = status;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder proposedPrincipal(final BigDecimal proposedPrincipal) {
            this.proposedPrincipal = proposedPrincipal;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder approvedPrincipal(final BigDecimal approvedPrincipal) {
            this.approvedPrincipal = approvedPrincipal;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder principal(final BigDecimal principal) {
            this.principal = principal;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder netDisbursalAmount(final BigDecimal netDisbursalAmount) {
            this.netDisbursalAmount = netDisbursalAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder amortizationType(final StringEnumOptionData amortizationType) {
            this.amortizationType = amortizationType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder npvDayCount(final Integer npvDayCount) {
            this.npvDayCount = npvDayCount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder loanProductCounter(final Integer loanProductCounter) {
            this.loanProductCounter = loanProductCounter;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder charges(final List<WorkingCapitalLoanChargeData> charges) {
            this.charges = charges;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder currency(final CurrencyData currency) {
            this.currency = currency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder paymentRate(final BigDecimal paymentRate) {
            this.paymentRate = paymentRate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder repaymentEvery(final Integer repaymentEvery) {
            this.repaymentEvery = repaymentEvery;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder repaymentFrequencyType(final StringEnumOptionData repaymentFrequencyType) {
            this.repaymentFrequencyType = repaymentFrequencyType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder discountFee(final BigDecimal discountFee) {
            this.discountFee = discountFee;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder proposedDiscountFee(final BigDecimal proposedDiscountFee) {
            this.proposedDiscountFee = proposedDiscountFee;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder approvedDiscountFee(final BigDecimal approvedDiscountFee) {
            this.approvedDiscountFee = approvedDiscountFee;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder numberOfRepayments(final Integer numberOfRepayments) {
            this.numberOfRepayments = numberOfRepayments;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder periodPaymentAmount(final BigDecimal periodPaymentAmount) {
            this.periodPaymentAmount = periodPaymentAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder dailyEir(final BigDecimal dailyEir) {
            this.dailyEir = dailyEir;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder calculatedAnnualEir(final BigDecimal calculatedAnnualEir) {
            this.calculatedAnnualEir = calculatedAnnualEir;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder delinquencyBucket(final DelinquencyBucketData delinquencyBucket) {
            this.delinquencyBucket = delinquencyBucket;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder breach(final WorkingCapitalBreachData breach) {
            this.breach = breach;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder nearBreach(final WorkingCapitalNearBreachData nearBreach) {
            this.nearBreach = nearBreach;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder lastClosedBusinessDate(final LocalDate lastClosedBusinessDate) {
            this.lastClosedBusinessDate = lastClosedBusinessDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder paymentAllocation(final List<WorkingCapitalPaymentAllocationData> paymentAllocation) {
            this.paymentAllocation = paymentAllocation;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder timeline(final LoanApplicationTimelineData timeline) {
            this.timeline = timeline;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder disbursementDetails(final List<WorkingCapitalLoanDisbursementDetailData> disbursementDetails) {
            this.disbursementDetails = disbursementDetails;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder balance(final WorkingCapitalLoanBalanceData balance) {
            this.balance = balance;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder delinquencyGraceDays(final Integer delinquencyGraceDays) {
            this.delinquencyGraceDays = delinquencyGraceDays;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder delinquencyStartType(final StringEnumOptionData delinquencyStartType) {
            this.delinquencyStartType = delinquencyStartType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder breachGraceDays(final Integer breachGraceDays) {
            this.breachGraceDays = breachGraceDays;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder totalPaymentVolume(final BigDecimal totalPaymentVolume) {
            this.totalPaymentVolume = totalPaymentVolume;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder delinquencyStartDate(final LocalDate delinquencyStartDate) {
            this.delinquencyStartDate = delinquencyStartDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder breachStartDate(final LocalDate breachStartDate) {
            this.breachStartDate = breachStartDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder delinquent(final WorkingCapitalLoanCollectionData delinquent) {
            this.delinquent = delinquent;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder enableInstallmentLevelDelinquency(final Boolean enableInstallmentLevelDelinquency) {
            this.enableInstallmentLevelDelinquency = enableInstallmentLevelDelinquency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder summary(final WorkingCapitalLoanSummaryData summary) {
            this.summary = summary;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder originators(final List<LoanOriginatorData> originators) {
            this.originators = originators;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder fraud(final Boolean fraud) {
            this.fraud = fraud;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder chargedOff(final Boolean chargedOff) {
            this.chargedOff = chargedOff;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanData build() {
            return new WorkingCapitalLoanData(this.id, this.accountNo, this.externalId, this.client, this.clientId, this.clientAccountNo, this.clientName, this.clientExternalId, this.clientOfficeId, this.fundId, this.fundName, this.product, this.loanProductId, this.loanProductName, this.loanProductDescription, this.status, this.proposedPrincipal, this.approvedPrincipal, this.principal, this.netDisbursalAmount, this.amortizationType, this.npvDayCount, this.loanProductCounter, this.charges, this.currency, this.paymentRate, this.repaymentEvery, this.repaymentFrequencyType, this.discountFee, this.proposedDiscountFee, this.approvedDiscountFee, this.numberOfRepayments, this.periodPaymentAmount, this.dailyEir, this.calculatedAnnualEir, this.delinquencyBucket, this.breach, this.nearBreach, this.lastClosedBusinessDate, this.paymentAllocation, this.timeline, this.disbursementDetails, this.balance, this.delinquencyGraceDays, this.delinquencyStartType, this.breachGraceDays, this.totalPaymentVolume, this.delinquencyStartDate, this.breachStartDate, this.delinquent, this.enableInstallmentLevelDelinquency, this.summary, this.originators, this.fraud, this.chargedOff);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder(id=" + this.id + ", accountNo=" + this.accountNo + ", externalId=" + this.externalId + ", client=" + this.client + ", clientId=" + this.clientId + ", clientAccountNo=" + this.clientAccountNo + ", clientName=" + this.clientName + ", clientExternalId=" + this.clientExternalId + ", clientOfficeId=" + this.clientOfficeId + ", fundId=" + this.fundId + ", fundName=" + this.fundName + ", product=" + this.product + ", loanProductId=" + this.loanProductId + ", loanProductName=" + this.loanProductName + ", loanProductDescription=" + this.loanProductDescription + ", status=" + this.status + ", proposedPrincipal=" + this.proposedPrincipal + ", approvedPrincipal=" + this.approvedPrincipal + ", principal=" + this.principal + ", netDisbursalAmount=" + this.netDisbursalAmount + ", amortizationType=" + this.amortizationType + ", npvDayCount=" + this.npvDayCount + ", loanProductCounter=" + this.loanProductCounter + ", charges=" + this.charges + ", currency=" + this.currency + ", paymentRate=" + this.paymentRate + ", repaymentEvery=" + this.repaymentEvery + ", repaymentFrequencyType=" + this.repaymentFrequencyType + ", discountFee=" + this.discountFee + ", proposedDiscountFee=" + this.proposedDiscountFee + ", approvedDiscountFee=" + this.approvedDiscountFee + ", numberOfRepayments=" + this.numberOfRepayments + ", periodPaymentAmount=" + this.periodPaymentAmount + ", dailyEir=" + this.dailyEir + ", calculatedAnnualEir=" + this.calculatedAnnualEir + ", delinquencyBucket=" + this.delinquencyBucket + ", breach=" + this.breach + ", nearBreach=" + this.nearBreach + ", lastClosedBusinessDate=" + this.lastClosedBusinessDate + ", paymentAllocation=" + this.paymentAllocation + ", timeline=" + this.timeline + ", disbursementDetails=" + this.disbursementDetails + ", balance=" + this.balance + ", delinquencyGraceDays=" + this.delinquencyGraceDays + ", delinquencyStartType=" + this.delinquencyStartType + ", breachGraceDays=" + this.breachGraceDays + ", totalPaymentVolume=" + this.totalPaymentVolume + ", delinquencyStartDate=" + this.delinquencyStartDate + ", breachStartDate=" + this.breachStartDate + ", delinquent=" + this.delinquent + ", enableInstallmentLevelDelinquency=" + this.enableInstallmentLevelDelinquency + ", summary=" + this.summary + ", originators=" + this.originators + ", fraud=" + this.fraud + ", chargedOff=" + this.chargedOff + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder builder() {
        return new WorkingCapitalLoanData.WorkingCapitalLoanDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getAccountNo() {
        return this.accountNo;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public ClientData getClient() {
        return this.client;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public String getClientAccountNo() {
        return this.clientAccountNo;
    }

    @java.lang.SuppressWarnings("all")
        public String getClientName() {
        return this.clientName;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getClientExternalId() {
        return this.clientExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientOfficeId() {
        return this.clientOfficeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getFundId() {
        return this.fundId;
    }

    @java.lang.SuppressWarnings("all")
        public String getFundName() {
        return this.fundName;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanProductData getProduct() {
        return this.product;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanProductId() {
        return this.loanProductId;
    }

    @java.lang.SuppressWarnings("all")
        public String getLoanProductName() {
        return this.loanProductName;
    }

    @java.lang.SuppressWarnings("all")
        public String getLoanProductDescription() {
        return this.loanProductDescription;
    }

    @java.lang.SuppressWarnings("all")
        public LoanStatusEnumData getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getProposedPrincipal() {
        return this.proposedPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getApprovedPrincipal() {
        return this.approvedPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipal() {
        return this.principal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getNetDisbursalAmount() {
        return this.netDisbursalAmount;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getAmortizationType() {
        return this.amortizationType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getNpvDayCount() {
        return this.npvDayCount;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getLoanProductCounter() {
        return this.loanProductCounter;
    }

    @java.lang.SuppressWarnings("all")
        public List<WorkingCapitalLoanChargeData> getCharges() {
        return this.charges;
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPaymentRate() {
        return this.paymentRate;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRepaymentEvery() {
        return this.repaymentEvery;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getRepaymentFrequencyType() {
        return this.repaymentFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDiscountFee() {
        return this.discountFee;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getProposedDiscountFee() {
        return this.proposedDiscountFee;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getApprovedDiscountFee() {
        return this.approvedDiscountFee;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getNumberOfRepayments() {
        return this.numberOfRepayments;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPeriodPaymentAmount() {
        return this.periodPaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDailyEir() {
        return this.dailyEir;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getCalculatedAnnualEir() {
        return this.calculatedAnnualEir;
    }

    @java.lang.SuppressWarnings("all")
        public DelinquencyBucketData getDelinquencyBucket() {
        return this.delinquencyBucket;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalBreachData getBreach() {
        return this.breach;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalNearBreachData getNearBreach() {
        return this.nearBreach;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getLastClosedBusinessDate() {
        return this.lastClosedBusinessDate;
    }

    @java.lang.SuppressWarnings("all")
        public List<WorkingCapitalPaymentAllocationData> getPaymentAllocation() {
        return this.paymentAllocation;
    }

    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData getTimeline() {
        return this.timeline;
    }

    @java.lang.SuppressWarnings("all")
        public List<WorkingCapitalLoanDisbursementDetailData> getDisbursementDetails() {
        return this.disbursementDetails;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanBalanceData getBalance() {
        return this.balance;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getDelinquencyGraceDays() {
        return this.delinquencyGraceDays;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getDelinquencyStartType() {
        return this.delinquencyStartType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getBreachGraceDays() {
        return this.breachGraceDays;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalPaymentVolume() {
        return this.totalPaymentVolume;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDelinquencyStartDate() {
        return this.delinquencyStartDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getBreachStartDate() {
        return this.breachStartDate;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanCollectionData getDelinquent() {
        return this.delinquent;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getEnableInstallmentLevelDelinquency() {
        return this.enableInstallmentLevelDelinquency;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanSummaryData getSummary() {
        return this.summary;
    }

    @java.lang.SuppressWarnings("all")
        public List<LoanOriginatorData> getOriginators() {
        return this.originators;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getFraud() {
        return this.fraud;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getChargedOff() {
        return this.chargedOff;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setAccountNo(final String accountNo) {
        this.accountNo = accountNo;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalId(final ExternalId externalId) {
        this.externalId = externalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setClient(final ClientData client) {
        this.client = client;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientId(final Long clientId) {
        this.clientId = clientId;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientAccountNo(final String clientAccountNo) {
        this.clientAccountNo = clientAccountNo;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientName(final String clientName) {
        this.clientName = clientName;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientExternalId(final ExternalId clientExternalId) {
        this.clientExternalId = clientExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientOfficeId(final Long clientOfficeId) {
        this.clientOfficeId = clientOfficeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setFundId(final Long fundId) {
        this.fundId = fundId;
    }

    @java.lang.SuppressWarnings("all")
        public void setFundName(final String fundName) {
        this.fundName = fundName;
    }

    @java.lang.SuppressWarnings("all")
        public void setProduct(final WorkingCapitalLoanProductData product) {
        this.product = product;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanProductId(final Long loanProductId) {
        this.loanProductId = loanProductId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanProductName(final String loanProductName) {
        this.loanProductName = loanProductName;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanProductDescription(final String loanProductDescription) {
        this.loanProductDescription = loanProductDescription;
    }

    @java.lang.SuppressWarnings("all")
        public void setStatus(final LoanStatusEnumData status) {
        this.status = status;
    }

    @java.lang.SuppressWarnings("all")
        public void setProposedPrincipal(final BigDecimal proposedPrincipal) {
        this.proposedPrincipal = proposedPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public void setApprovedPrincipal(final BigDecimal approvedPrincipal) {
        this.approvedPrincipal = approvedPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public void setPrincipal(final BigDecimal principal) {
        this.principal = principal;
    }

    @java.lang.SuppressWarnings("all")
        public void setNetDisbursalAmount(final BigDecimal netDisbursalAmount) {
        this.netDisbursalAmount = netDisbursalAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmortizationType(final StringEnumOptionData amortizationType) {
        this.amortizationType = amortizationType;
    }

    @java.lang.SuppressWarnings("all")
        public void setNpvDayCount(final Integer npvDayCount) {
        this.npvDayCount = npvDayCount;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanProductCounter(final Integer loanProductCounter) {
        this.loanProductCounter = loanProductCounter;
    }

    @java.lang.SuppressWarnings("all")
        public void setCharges(final List<WorkingCapitalLoanChargeData> charges) {
        this.charges = charges;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrency(final CurrencyData currency) {
        this.currency = currency;
    }

    @java.lang.SuppressWarnings("all")
        public void setPaymentRate(final BigDecimal paymentRate) {
        this.paymentRate = paymentRate;
    }

    @java.lang.SuppressWarnings("all")
        public void setRepaymentEvery(final Integer repaymentEvery) {
        this.repaymentEvery = repaymentEvery;
    }

    @java.lang.SuppressWarnings("all")
        public void setRepaymentFrequencyType(final StringEnumOptionData repaymentFrequencyType) {
        this.repaymentFrequencyType = repaymentFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public void setDiscountFee(final BigDecimal discountFee) {
        this.discountFee = discountFee;
    }

    @java.lang.SuppressWarnings("all")
        public void setProposedDiscountFee(final BigDecimal proposedDiscountFee) {
        this.proposedDiscountFee = proposedDiscountFee;
    }

    @java.lang.SuppressWarnings("all")
        public void setApprovedDiscountFee(final BigDecimal approvedDiscountFee) {
        this.approvedDiscountFee = approvedDiscountFee;
    }

    @java.lang.SuppressWarnings("all")
        public void setNumberOfRepayments(final Integer numberOfRepayments) {
        this.numberOfRepayments = numberOfRepayments;
    }

    @java.lang.SuppressWarnings("all")
        public void setPeriodPaymentAmount(final BigDecimal periodPaymentAmount) {
        this.periodPaymentAmount = periodPaymentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setDailyEir(final BigDecimal dailyEir) {
        this.dailyEir = dailyEir;
    }

    @java.lang.SuppressWarnings("all")
        public void setCalculatedAnnualEir(final BigDecimal calculatedAnnualEir) {
        this.calculatedAnnualEir = calculatedAnnualEir;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyBucket(final DelinquencyBucketData delinquencyBucket) {
        this.delinquencyBucket = delinquencyBucket;
    }

    @java.lang.SuppressWarnings("all")
        public void setBreach(final WorkingCapitalBreachData breach) {
        this.breach = breach;
    }

    @java.lang.SuppressWarnings("all")
        public void setNearBreach(final WorkingCapitalNearBreachData nearBreach) {
        this.nearBreach = nearBreach;
    }

    @java.lang.SuppressWarnings("all")
        public void setLastClosedBusinessDate(final LocalDate lastClosedBusinessDate) {
        this.lastClosedBusinessDate = lastClosedBusinessDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setPaymentAllocation(final List<WorkingCapitalPaymentAllocationData> paymentAllocation) {
        this.paymentAllocation = paymentAllocation;
    }

    @java.lang.SuppressWarnings("all")
        public void setTimeline(final LoanApplicationTimelineData timeline) {
        this.timeline = timeline;
    }

    @java.lang.SuppressWarnings("all")
        public void setDisbursementDetails(final List<WorkingCapitalLoanDisbursementDetailData> disbursementDetails) {
        this.disbursementDetails = disbursementDetails;
    }

    @java.lang.SuppressWarnings("all")
        public void setBalance(final WorkingCapitalLoanBalanceData balance) {
        this.balance = balance;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyGraceDays(final Integer delinquencyGraceDays) {
        this.delinquencyGraceDays = delinquencyGraceDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyStartType(final StringEnumOptionData delinquencyStartType) {
        this.delinquencyStartType = delinquencyStartType;
    }

    @java.lang.SuppressWarnings("all")
        public void setBreachGraceDays(final Integer breachGraceDays) {
        this.breachGraceDays = breachGraceDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalPaymentVolume(final BigDecimal totalPaymentVolume) {
        this.totalPaymentVolume = totalPaymentVolume;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyStartDate(final LocalDate delinquencyStartDate) {
        this.delinquencyStartDate = delinquencyStartDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setBreachStartDate(final LocalDate breachStartDate) {
        this.breachStartDate = breachStartDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquent(final WorkingCapitalLoanCollectionData delinquent) {
        this.delinquent = delinquent;
    }

    @java.lang.SuppressWarnings("all")
        public void setEnableInstallmentLevelDelinquency(final Boolean enableInstallmentLevelDelinquency) {
        this.enableInstallmentLevelDelinquency = enableInstallmentLevelDelinquency;
    }

    @java.lang.SuppressWarnings("all")
        public void setSummary(final WorkingCapitalLoanSummaryData summary) {
        this.summary = summary;
    }

    @java.lang.SuppressWarnings("all")
        public void setOriginators(final List<LoanOriginatorData> originators) {
        this.originators = originators;
    }

    @java.lang.SuppressWarnings("all")
        public void setFraud(final Boolean fraud) {
        this.fraud = fraud;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargedOff(final Boolean chargedOff) {
        this.chargedOff = chargedOff;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanData() {
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanData(final Long id, final String accountNo, final ExternalId externalId, final ClientData client, final Long clientId, final String clientAccountNo, final String clientName, final ExternalId clientExternalId, final Long clientOfficeId, final Long fundId, final String fundName, final WorkingCapitalLoanProductData product, final Long loanProductId, final String loanProductName, final String loanProductDescription, final LoanStatusEnumData status, final BigDecimal proposedPrincipal, final BigDecimal approvedPrincipal, final BigDecimal principal, final BigDecimal netDisbursalAmount, final StringEnumOptionData amortizationType, final Integer npvDayCount, final Integer loanProductCounter, final List<WorkingCapitalLoanChargeData> charges, final CurrencyData currency, final BigDecimal paymentRate, final Integer repaymentEvery, final StringEnumOptionData repaymentFrequencyType, final BigDecimal discountFee, final BigDecimal proposedDiscountFee, final BigDecimal approvedDiscountFee, final Integer numberOfRepayments, final BigDecimal periodPaymentAmount, final BigDecimal dailyEir, final BigDecimal calculatedAnnualEir, final DelinquencyBucketData delinquencyBucket, final WorkingCapitalBreachData breach, final WorkingCapitalNearBreachData nearBreach, final LocalDate lastClosedBusinessDate, final List<WorkingCapitalPaymentAllocationData> paymentAllocation, final LoanApplicationTimelineData timeline, final List<WorkingCapitalLoanDisbursementDetailData> disbursementDetails, final WorkingCapitalLoanBalanceData balance, final Integer delinquencyGraceDays, final StringEnumOptionData delinquencyStartType, final Integer breachGraceDays, final BigDecimal totalPaymentVolume, final LocalDate delinquencyStartDate, final LocalDate breachStartDate, final WorkingCapitalLoanCollectionData delinquent, final Boolean enableInstallmentLevelDelinquency, final WorkingCapitalLoanSummaryData summary, final List<LoanOriginatorData> originators, final Boolean fraud, final Boolean chargedOff) {
        this.id = id;
        this.accountNo = accountNo;
        this.externalId = externalId;
        this.client = client;
        this.clientId = clientId;
        this.clientAccountNo = clientAccountNo;
        this.clientName = clientName;
        this.clientExternalId = clientExternalId;
        this.clientOfficeId = clientOfficeId;
        this.fundId = fundId;
        this.fundName = fundName;
        this.product = product;
        this.loanProductId = loanProductId;
        this.loanProductName = loanProductName;
        this.loanProductDescription = loanProductDescription;
        this.status = status;
        this.proposedPrincipal = proposedPrincipal;
        this.approvedPrincipal = approvedPrincipal;
        this.principal = principal;
        this.netDisbursalAmount = netDisbursalAmount;
        this.amortizationType = amortizationType;
        this.npvDayCount = npvDayCount;
        this.loanProductCounter = loanProductCounter;
        this.charges = charges;
        this.currency = currency;
        this.paymentRate = paymentRate;
        this.repaymentEvery = repaymentEvery;
        this.repaymentFrequencyType = repaymentFrequencyType;
        this.discountFee = discountFee;
        this.proposedDiscountFee = proposedDiscountFee;
        this.approvedDiscountFee = approvedDiscountFee;
        this.numberOfRepayments = numberOfRepayments;
        this.periodPaymentAmount = periodPaymentAmount;
        this.dailyEir = dailyEir;
        this.calculatedAnnualEir = calculatedAnnualEir;
        this.delinquencyBucket = delinquencyBucket;
        this.breach = breach;
        this.nearBreach = nearBreach;
        this.lastClosedBusinessDate = lastClosedBusinessDate;
        this.paymentAllocation = paymentAllocation;
        this.timeline = timeline;
        this.disbursementDetails = disbursementDetails;
        this.balance = balance;
        this.delinquencyGraceDays = delinquencyGraceDays;
        this.delinquencyStartType = delinquencyStartType;
        this.breachGraceDays = breachGraceDays;
        this.totalPaymentVolume = totalPaymentVolume;
        this.delinquencyStartDate = delinquencyStartDate;
        this.breachStartDate = breachStartDate;
        this.delinquent = delinquent;
        this.enableInstallmentLevelDelinquency = enableInstallmentLevelDelinquency;
        this.summary = summary;
        this.originators = originators;
        this.fraud = fraud;
        this.chargedOff = chargedOff;
    }
}
