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
import java.util.ArrayList;
import java.util.Collection;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import org.apache.fineract.infrastructure.codes.data.CodeValueData;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.infrastructure.core.data.StringEnumOptionData;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.infrastructure.dataqueries.data.DatatableData;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.organisation.staff.data.StaffData;
import org.apache.fineract.portfolio.account.data.PortfolioAccountData;
import org.apache.fineract.portfolio.accountdetails.data.LoanAccountSummaryData;
import org.apache.fineract.portfolio.calendar.data.CalendarData;
import org.apache.fineract.portfolio.charge.data.ChargeData;
import org.apache.fineract.portfolio.client.data.ClientData;
import org.apache.fineract.portfolio.delinquency.data.DelinquencyRangeData;
import org.apache.fineract.portfolio.floatingrates.data.InterestRatePeriodData;
import org.apache.fineract.portfolio.fund.data.FundData;
import org.apache.fineract.portfolio.group.data.GroupGeneralData;
import org.apache.fineract.portfolio.loanaccount.domain.LoanStatus;
import org.apache.fineract.portfolio.loanaccount.guarantor.data.IGuarantor;
import org.apache.fineract.portfolio.loanaccount.loanschedule.data.LoanScheduleData;
import org.apache.fineract.portfolio.loanorigination.data.LoanOriginatorData;
import org.apache.fineract.portfolio.loanproduct.data.LoanProductBorrowerCycleVariationData;
import org.apache.fineract.portfolio.loanproduct.data.LoanProductData;
import org.apache.fineract.portfolio.loanproduct.data.TransactionProcessingStrategyData;
import org.apache.fineract.portfolio.loanproduct.domain.LoanProductValueConditionType;
import org.apache.fineract.portfolio.note.data.NoteData;
import org.apache.fineract.portfolio.rate.data.RateData;

@SuppressWarnings("ObjectToString")
public class LoanAccountData {
    // basic loan details
    // identity
    private Long id;
    private String accountNo;
    private ExternalId externalId = ExternalId.empty();
    // status
    private LoanStatusEnumData status;
    private EnumOptionData subStatus;
    // related to
    private Long clientId;
    private String clientAccountNo;
    private String clientName;
    private ExternalId clientExternalId;
    private Long clientOfficeId;
    private GroupGeneralData group;
    private Long loanProductId;
    private String loanProductName;
    private String loanProductDescription;
    // TODO: avoid prefix "is"
    private boolean isLoanProductLinkedToFloatingRate;
    private Long fundId;
    private String fundName;
    private Long loanPurposeId;
    private String loanPurposeName;
    private Long loanOfficerId;
    private String loanOfficerName;
    private EnumOptionData loanType;
    // terms
    private CurrencyData currency;
    private BigDecimal principal;
    private BigDecimal approvedPrincipal;
    private BigDecimal proposedPrincipal;
    private BigDecimal netDisbursalAmount;
    private Integer termFrequency;
    private EnumOptionData termPeriodFrequencyType;
    private Integer numberOfRepayments;
    private Integer actualNoTerm;
    private Integer repaymentEvery;
    private Integer fixedLength;
    private EnumOptionData repaymentFrequencyType;
    private EnumOptionData repaymentFrequencyNthDayType;
    private EnumOptionData repaymentFrequencyDayOfWeekType;
    private BigDecimal interestRatePerPeriod;
    private EnumOptionData interestRateFrequencyType;
    private BigDecimal annualInterestRate;
    // TODO: avoid prefix "is"
    private boolean isFloatingInterestRate;
    private BigDecimal interestRateDifferential;
    // settings
    private EnumOptionData amortizationType;
    private EnumOptionData interestType;
    private EnumOptionData interestCalculationPeriodType;
    private Boolean allowPartialPeriodInterestCalculation;
    private BigDecimal inArrearsTolerance;
    private String transactionProcessingStrategyCode;
    private String transactionProcessingStrategyName;
    private Integer graceOnPrincipalPayment;
    private Integer recurringMoratoriumOnPrincipalPeriods;
    private Integer graceOnInterestPayment;
    private Integer graceOnInterestCharged;
    private Integer graceOnArrearsAgeing;
    private LocalDate interestChargedFromDate;
    private LocalDate expectedFirstRepaymentOnDate;
    private Boolean syncDisbursementWithMeeting;
    private Boolean disallowExpectedDisbursements;
    // timeline
    private LoanApplicationTimelineData timeline;
    // totals
    private LoanSummaryData summary;
    // associations
    private LoanScheduleData repaymentSchedule;
    private Collection<LoanTransactionData> transactions;
    private Collection<LoanChargeData> charges;
    private Collection<LoanCollateralManagementData> collateral;
    private Collection<? extends IGuarantor> guarantors;
    private CalendarData meeting;
    private Collection<NoteData> notes;
    private Collection<DisbursementData> disbursementDetails;
    private LoanScheduleData originalSchedule;
    private Collection<LoanOriginatorData> originators;
    // template
    private Collection<LoanProductData> productOptions;
    private Collection<StaffData> loanOfficerOptions;
    private Collection<CodeValueData> loanPurposeOptions;
    private Collection<FundData> fundOptions;
    private Collection<EnumOptionData> termFrequencyTypeOptions;
    private Collection<EnumOptionData> repaymentFrequencyTypeOptions;
    private Collection<EnumOptionData> repaymentFrequencyNthDayTypeOptions;
    private Collection<EnumOptionData> repaymentFrequencyDaysOfWeekTypeOptions;
    private Collection<EnumOptionData> interestRateFrequencyTypeOptions;
    private Collection<EnumOptionData> amortizationTypeOptions;
    private Collection<EnumOptionData> interestTypeOptions;
    private Collection<EnumOptionData> interestCalculationPeriodTypeOptions;
    private Collection<TransactionProcessingStrategyData> transactionProcessingStrategyOptions;
    private Collection<ChargeData> chargeOptions;
    private Collection<CodeValueData> loanCollateralOptions;
    private Collection<CalendarData> calendarOptions;
    private List<EnumOptionData> loanScheduleTypeOptions;
    private List<EnumOptionData> loanScheduleProcessingTypeOptions;
    private List<StringEnumOptionData> daysInYearCustomStrategyOptions;
    private List<StringEnumOptionData> capitalizedIncomeCalculationTypeOptions;
    private List<StringEnumOptionData> capitalizedIncomeStrategyOptions;
    private List<StringEnumOptionData> capitalizedIncomeTypeOptions;
    private List<StringEnumOptionData> buyDownFeeCalculationTypeOptions;
    private List<StringEnumOptionData> buyDownFeeStrategyOptions;
    private List<StringEnumOptionData> buyDownFeeIncomeTypeOptions;
    private BigDecimal feeChargesAtDisbursementCharged;
    private BigDecimal totalOverpaid;
    // loanCycle
    private Integer loanCounter;
    private Integer loanProductCounter;
    // linkable account details
    private PortfolioAccountData linkedAccount;
    private Collection<PortfolioAccountData> accountLinkingOptions;
    private Boolean multiDisburseLoan;
    private Boolean canDefineInstallmentAmount;
    private BigDecimal fixedEmiAmount;
    private BigDecimal maxOutstandingLoanBalance;
    private Boolean canDisburse;
    private Collection<LoanTermVariationsData> emiAmountVariations;
    private Collection<LoanTermVariationsData> loanTermVariations;
    private Collection<LoanAccountSummaryData> clientActiveLoanOptions;
    private Boolean canUseForTopup;
    // TODO: avoid prefix "is"
    private boolean isTopup;
    private boolean fraud;
    private Long closureLoanId;
    private String closureLoanAccountNo;
    private BigDecimal topupAmount;
    private LoanProductData product;
    private Map<Long, LoanBorrowerCycleData> memberVariations;
    private Boolean inArrears;
    // TODO: avoid prefix "is"
    private Boolean isNPA;
    private Collection<ChargeData> overdueCharges;
    private EnumOptionData daysInMonthType;
    private EnumOptionData daysInYearType;
    private StringEnumOptionData daysInYearCustomStrategy;
    // TODO: avoid prefix "is"
    private boolean isInterestRecalculationEnabled;
    private LoanInterestRecalculationData interestRecalculationData;
    private Boolean createStandingInstructionAtDisbursement;
    // Paid In Advance
    private PaidInAdvanceData paidInAdvance;
    private Collection<InterestRatePeriodData> interestRatesPeriods;
    // VariableInstallments
    // TODO: avoid prefix "is"
    private Boolean isVariableInstallmentsAllowed;
    private Integer minimumGap;
    private Integer maximumGap;
    private List<DatatableData> datatables;
    // TODO: avoid prefix "is"
    private Boolean isEqualAmortization;
    private BigDecimal fixedPrincipalPercentagePerInstallment;
    // Rate
    private List<RateData> rates;
    // TODO: avoid prefix "is"
    private Boolean isRatesEnabled;
    // import fields
    private String dateFormat;
    private String locale;
    private transient Integer rowIndex;
    private LocalDate submittedOnDate;
    private Long productId;
    private Integer loanTermFrequency;
    private EnumOptionData loanTermFrequencyType;
    private LocalDate repaymentsStartingFromDate;
    private String linkAccountId;
    private Long groupId;
    private LocalDate expectedDisbursementDate;
    private LocalDate overpaidOnDate;
    private CollectionData delinquent;
    private DelinquencyRangeData delinquencyRange;
    private Boolean enableInstallmentLevelDelinquency;
    private LocalDate lastClosedBusinessDate;
    private Boolean chargedOff;
    private Boolean allowFullTermForTranche;
    private Boolean enableDownPayment;
    private BigDecimal disbursedAmountPercentageForDownPayment;
    private Boolean enableAutoRepaymentForDownPayment;
    private EnumOptionData repaymentStartDateType;
    private Boolean interestRecognitionOnDisbursementDate;
    private EnumOptionData loanScheduleType;
    private EnumOptionData loanScheduleProcessingType;
    private StringEnumOptionData chargeOffBehaviour;
    private Boolean enableIncomeCapitalization;
    private StringEnumOptionData capitalizedIncomeCalculationType;
    private StringEnumOptionData capitalizedIncomeStrategy;
    private StringEnumOptionData capitalizedIncomeType;
    private Boolean enableBuyDownFee;
    private StringEnumOptionData buyDownFeeCalculationType;
    private StringEnumOptionData buyDownFeeStrategy;
    private StringEnumOptionData buyDownFeeIncomeType;
    private Boolean merchantBuyDownFee;

    public static LoanAccountData importInstanceIndividual(EnumOptionData loanTypeEnumOption, Long clientId, Long productId, Long loanOfficerId, LocalDate submittedOnDate, Long fundId, BigDecimal principal, Integer numberOfRepayments, Integer repaymentEvery, EnumOptionData repaidEveryFrequencyEnums, Integer loanTermFrequency, EnumOptionData loanTermFrequencyTypeEnum, BigDecimal nominalInterestRate, LocalDate expectedDisbursementDate, EnumOptionData amortizationEnumOption, EnumOptionData interestMethodEnum, EnumOptionData interestCalculationPeriodTypeEnum, BigDecimal inArrearsTolerance, String transactionProcessingStrategyCode, Integer graceOnPrincipalPayment, Integer graceOnInterestPayment, Integer graceOnInterestCharged, LocalDate interestChargedFromDate, LocalDate repaymentsStartingFromDate, Integer rowIndex, ExternalId externalId, Long groupId, Collection<LoanChargeData> charges, String linkAccountId, String locale, String dateFormat, List<LoanCollateralManagementData> loanCollateralManagementData, Integer fixedLength, StringEnumOptionData daysInYearCustomStrategy) {
        return new LoanAccountData().setLoanType(loanTypeEnumOption).setClientId(clientId).setProductId(productId).setLoanOfficerId(loanOfficerId).setSubmittedOnDate(submittedOnDate).setFundId(fundId).setPrincipal(principal).setNumberOfRepayments(numberOfRepayments).setRepaymentEvery(repaymentEvery).setRepaymentFrequencyType(repaidEveryFrequencyEnums).setLoanTermFrequency(loanTermFrequency).setLoanTermFrequencyType(loanTermFrequencyTypeEnum).setInterestRatePerPeriod(nominalInterestRate).setExpectedDisbursementDate(expectedDisbursementDate).setAmortizationType(amortizationEnumOption).setInterestType(interestMethodEnum).setInterestCalculationPeriodType(interestCalculationPeriodTypeEnum).setInArrearsTolerance(inArrearsTolerance).setTransactionProcessingStrategyCode(transactionProcessingStrategyCode).setGraceOnPrincipalPayment(graceOnPrincipalPayment).setGraceOnInterestPayment(graceOnInterestPayment).setGraceOnInterestCharged(graceOnInterestCharged).setInterestChargedFromDate(interestChargedFromDate).setRepaymentsStartingFromDate(repaymentsStartingFromDate).setRowIndex(rowIndex).setExternalId(externalId).setGroupId(groupId).setCharges(charges).setLinkAccountId(linkAccountId).setLocale(locale).setDateFormat(dateFormat).setCollateral(loanCollateralManagementData).setFixedLength(fixedLength).setDaysInYearCustomStrategy(daysInYearCustomStrategy);
    }

    public static LoanAccountData importInstanceGroup(EnumOptionData loanTypeEnumOption, Long groupIdforGroupLoan, Long productId, Long loanOfficerId, LocalDate submittedOnDate, Long fundId, BigDecimal principal, Integer numberOfRepayments, Integer repaidEvery, EnumOptionData repaidEveryFrequencyEnums, Integer loanTermFrequency, EnumOptionData loanTermFrequencyTypeEnum, BigDecimal nominalInterestRate, LocalDate expectedDisbursementDate, EnumOptionData amortizationEnumOption, EnumOptionData interestMethodEnum, EnumOptionData interestCalculationPeriodEnum, BigDecimal arrearsTolerance, String transactionProcessingStrategyCode, Integer graceOnPrincipalPayment, Integer graceOnInterestPayment, Integer graceOnInterestCharged, LocalDate interestChargedFromDate, LocalDate repaymentsStartingFromDate, Integer rowIndex, ExternalId externalId, String linkAccountId, String locale, String dateFormat, Integer fixedLength) {
        return new LoanAccountData().setLoanType(loanTypeEnumOption).setGroupId(groupIdforGroupLoan).setProductId(productId).setLoanOfficerId(loanOfficerId).setSubmittedOnDate(submittedOnDate).setFundId(fundId).setPrincipal(principal).setNumberOfRepayments(numberOfRepayments).setRepaymentEvery(repaidEvery).setRepaymentFrequencyType(repaidEveryFrequencyEnums).setLoanTermFrequency(loanTermFrequency).setLoanTermFrequencyType(loanTermFrequencyTypeEnum).setInterestRatePerPeriod(nominalInterestRate).setAmortizationType(amortizationEnumOption).setInterestType(interestMethodEnum).setExpectedDisbursementDate(expectedDisbursementDate).setInterestCalculationPeriodType(interestCalculationPeriodEnum).setInArrearsTolerance(arrearsTolerance).setTransactionProcessingStrategyCode(transactionProcessingStrategyCode).setGraceOnPrincipalPayment(graceOnPrincipalPayment).setGraceOnInterestPayment(graceOnInterestPayment).setGraceOnInterestCharged(graceOnInterestCharged).setInterestChargedFromDate(interestChargedFromDate).setRepaymentsStartingFromDate(repaymentsStartingFromDate).setRowIndex(rowIndex).setExternalId(externalId).setLinkAccountId(linkAccountId).setLocale(locale).setDateFormat(dateFormat).setFixedLength(fixedLength);
    }

    public LoanAccountData withClientData(final ClientData clientData) {
        return  //
        //
        //
        //
        this.setClientId(clientData.getId()).setClientAccountNo(clientData.getAccountNo()).setClientName(clientData.getDisplayName()).setClientOfficeId(clientData.getOfficeId()).setClientExternalId(clientData.getExternalId()); //
    }

    public LoanAccountData withExpectedDisbursementDate(final LocalDate expectedDisbursementDate) {
        if (getTimeline() == null) {
            setTimeline(new LoanApplicationTimelineData());
        }
        this.getTimeline().setExpectedDisbursementDate(expectedDisbursementDate);
        return this.setExpectedDisbursementDate(expectedDisbursementDate);
    }

    public LoanAccountData withProductData(final LoanProductData product, final Integer loanCycleNumber) {
        final EnumOptionData termPeriodFrequencyType = product.getRepaymentFrequencyType();
        final Collection<LoanChargeData> charges = new ArrayList<LoanChargeData>();
        for (final ChargeData charge : product.charges()) {
            if (!charge.isOverdueInstallmentCharge()) {
                charges.add(toLoanChargeData(charge));
            }
        }
        BigDecimal principal = null;
        BigDecimal proposedPrincipal = null;
        BigDecimal interestRatePerPeriod = null;
        Integer numberOfRepayments = null;
        if (product.isUseBorrowerCycle() && loanCycleNumber != null && loanCycleNumber > 0) {
            Collection<LoanProductBorrowerCycleVariationData> principalVariationsForBorrowerCycle = product.getPrincipalVariationsForBorrowerCycle();
            Collection<LoanProductBorrowerCycleVariationData> interestForVariationsForBorrowerCycle = product.getInterestRateVariationsForBorrowerCycle();
            Collection<LoanProductBorrowerCycleVariationData> repaymentVariationsForBorrowerCycle = product.getNumberOfRepaymentVariationsForBorrowerCycle();
            principal = fetchLoanCycleDefaultValue(principalVariationsForBorrowerCycle, loanCycleNumber);
            proposedPrincipal = principal;
            interestRatePerPeriod = fetchLoanCycleDefaultValue(interestForVariationsForBorrowerCycle, loanCycleNumber);
            BigDecimal numberofRepaymentval = fetchLoanCycleDefaultValue(repaymentVariationsForBorrowerCycle, loanCycleNumber);
            if (numberofRepaymentval != null) {
                numberOfRepayments = numberofRepaymentval.intValue();
            }
        }
        if (principal == null) {
            principal = product.getPrincipal();
            proposedPrincipal = principal;
        }
        // Add net get net disbursal amount from charges and principal
        BigDecimal netDisbursalAmount = principal;
        if (!charges.isEmpty()) {
            for (LoanChargeData charge : charges) {
                netDisbursalAmount = netDisbursalAmount.subtract(charge.getAmount());
            }
        }
        if (interestRatePerPeriod == null) {
            interestRatePerPeriod = product.getInterestRatePerPeriod();
        }
        if (numberOfRepayments == null) {
            numberOfRepayments = product.getNumberOfRepayments();
        }
        return this.setProductId(product.getId()).setLoanProductName(product.getName()).setLoanProductDescription(product.getDescription()).setLoanProductLinkedToFloatingRate(product.isLinkedToFloatingInterestRates()).setFundId(product.getFundId()).setFundName(product.getFundName()).setCurrency(product.getCurrency()).setProposedPrincipal(proposedPrincipal).setPrincipal(principal).setApprovedPrincipal(principal).setNetDisbursalAmount(netDisbursalAmount).setInArrearsTolerance(product.getInArrearsTolerance()).setTermFrequency(numberOfRepayments * product.getRepaymentEvery()).setTermPeriodFrequencyType(termPeriodFrequencyType).setNumberOfRepayments(numberOfRepayments).setRepaymentEvery(product.getRepaymentEvery()).setRepaymentFrequencyType(product.getRepaymentFrequencyType()).setTransactionProcessingStrategyCode(product.getTransactionProcessingStrategyCode()).setAmortizationType(product.getAmortizationType()).setInterestRatePerPeriod(interestRatePerPeriod).setInterestRateFrequencyType(product.getInterestRateFrequencyType()).setAnnualInterestRate(product.getAnnualInterestRate()).setInterestType(product.getInterestType()).setFloatingInterestRate(product.isFloatingInterestRateCalculationAllowed()).setInterestRateDifferential(product.getDefaultDifferentialLendingRate()).setInterestCalculationPeriodType(product.getInterestCalculationPeriodType()).setAllowPartialPeriodInterestCalculation(product.isAllowPartialPeriodInterestCalculation()).setGraceOnPrincipalPayment(product.getGraceOnPrincipalPayment()).setRecurringMoratoriumOnPrincipalPeriods(product.getRecurringMoratoriumOnPrincipalPeriods()).setGraceOnInterestPayment(product.getGraceOnInterestPayment()).setGraceOnInterestCharged(product.getGraceOnInterestCharged()).setCharges(charges).setMultiDisburseLoan(product.getMultiDisburseLoan()).setCanDefineInstallmentAmount(product.isCanDefineInstallmentAmount()).setMaxOutstandingLoanBalance(product.getOutstandingLoanBalance()).setProduct(product).setGraceOnArrearsAgeing(product.getGraceOnArrearsAgeing()).setOverdueCharges(product.overdueFeeCharges()).setDaysInMonthType(product.getDaysInMonthType()).setDaysInYearType(product.getDaysInYearType()).setInterestRecalculationEnabled(product.isInterestRecalculationEnabled()).setInterestRecalculationData(product.toLoanInterestRecalculationData()).setIsVariableInstallmentsAllowed(product.isAllowVariableInstallments()).setMinimumGap(product.getMinimumGap()).setMaximumGap(product.getMaximumGap()).setTopup(product.isCanUseForTopup()).setIsEqualAmortization(product.isEqualAmortization()).setFixedPrincipalPercentagePerInstallment(product.getFixedPrincipalPercentagePerInstallment()).setDelinquent(CollectionData.template()).setDisallowExpectedDisbursements(product.getDisallowExpectedDisbursements()).setLoanScheduleType(product.getLoanScheduleType()).setLoanScheduleProcessingType(product.getLoanScheduleProcessingType()).setRepaymentStartDateType(product.getRepaymentStartDateType()).setInterestRecognitionOnDisbursementDate(product.isInterestRecognitionOnDisbursementDate()).setDaysInYearCustomStrategyOptions(product.getDaysInYearCustomStrategyOptions()).setDaysInYearCustomStrategy(product.getDaysInYearCustomStrategy());
    }

    /*
     * Used to send back loan account data with the basic details coming from query.
     */
    public static LoanAccountData basicLoanDetails(final Long id, final String accountNo, final LoanStatusEnumData status, final ExternalId externalId, final Long clientId, final String clientAccountNo, final String clientName, final Long clientOfficeId, final ExternalId clientExternalId, final GroupGeneralData group, final EnumOptionData loanType, final Long loanProductId, final String loanProductName, final String loanProductDescription, final boolean isLoanProductLinkedToFloatingRate, final Long fundId, final String fundName, final Long loanPurposeId, final String loanPurposeName, final Long loanOfficerId, final String loanOfficerName, final CurrencyData currencyData, final BigDecimal proposedPrincipal, final BigDecimal principal, final BigDecimal approvedPrincipal, final BigDecimal netDisbursalAmount, final BigDecimal totalOverpaid, final BigDecimal inArrearsTolerance, final Integer termFrequency, final EnumOptionData termPeriodFrequencyType, final Integer numberOfRepayments, final Integer repaymentEvery, final EnumOptionData repaymentFrequencyType, EnumOptionData repaymentFrequencyNthDayType, EnumOptionData repaymentFrequencyDayOfWeekType, final String transactionStrategy, final String transactionStrategyName, final EnumOptionData amortizationType, final BigDecimal interestRatePerPeriod, final EnumOptionData interestRateFrequencyType, final BigDecimal annualInterestRate, final EnumOptionData interestType, final boolean isFloatingInterestRate, final BigDecimal interestRateDifferential, final EnumOptionData interestCalculationPeriodType, Boolean allowPartialPeriodInterestCalculation, final LocalDate expectedFirstRepaymentOnDate, final Integer graceOnPrincipalPayment, final Integer recurringMoratoriumOnPrincipalPeriods, final Integer graceOnInterestPayment, final Integer graceOnInterestCharged, final LocalDate interestChargedFromDate, final LoanApplicationTimelineData timeline, final LoanSummaryData loanSummary, final BigDecimal feeChargesDueAtDisbursementCharged, final Boolean syncDisbursementWithMeeting, final Integer loanCounter, final Integer loanProductCounter, final Boolean multiDisburseLoan, Boolean canDefineInstallmentAmount, final BigDecimal fixedEmiAmont, final BigDecimal outstandingLoanBalance, final Boolean inArrears, final Integer graceOnArrearsAgeing, final Boolean isNPA, final EnumOptionData daysInMonthType, final EnumOptionData daysInYearType, final boolean isInterestRecalculationEnabled, final LoanInterestRecalculationData interestRecalculationData, final Boolean createStandingInstructionAtDisbursement, final Boolean isVariableInstallmentsAllowed, Integer minimumGap, Integer maximumGap, final EnumOptionData subStatus, final boolean canUseForTopup, final boolean isTopup, final Long closureLoanId, final String closureLoanAccountNo, final BigDecimal topupAmount, final boolean isEqualAmortization, final BigDecimal fixedPrincipalPercentagePerInstallment, final DelinquencyRangeData delinquencyRange, final boolean disallowExpectedDisbursements, final boolean fraud, LocalDate lastClosedBusinessDate, LocalDate overpaidOnDate, final boolean chargedOff, final boolean enableDownPayment, final BigDecimal disbursedAmountPercentageForDownPayment, final boolean enableAutoRepaymentForDownPayment, final EnumOptionData repaymentStartDateType, final boolean enableInstallmentLevelDelinquency, final EnumOptionData loanScheduleType, final EnumOptionData loanScheduleProcessingType, final Integer fixedLength, final StringEnumOptionData chargeOffBehaviour, final boolean isInterestRecognitionOnDisbursementDate, final boolean allowFullTermForTranche, final StringEnumOptionData daysInYearCustomStrategy, final boolean enableIncomeCapitalization, final StringEnumOptionData capitalizedIncomeCalculationType, final StringEnumOptionData capitalizedIncomeStrategy, StringEnumOptionData capitalizedIncomeType, final boolean enableBuyDownFee, final StringEnumOptionData buyDownFeeCalculationType, final StringEnumOptionData buyDownFeeStrategy, final StringEnumOptionData buyDownFeeIncomeType, final boolean merchantBuyDownFee) {
        final CollectionData delinquent = CollectionData.template();
        return new LoanAccountData().setId(id).setAccountNo(accountNo).setStatus(status).setExternalId(externalId).setClientId(clientId).setClientAccountNo(clientAccountNo).setClientName(clientName).setClientOfficeId(clientOfficeId).setClientExternalId(clientExternalId).setGroup(group).setLoanType(loanType).setLoanProductId(loanProductId).setLoanProductName(loanProductName).setLoanProductDescription(loanProductDescription).setLoanProductLinkedToFloatingRate(isLoanProductLinkedToFloatingRate).setFundId(fundId).setFundName(fundName).setLoanPurposeId(loanPurposeId).setLoanPurposeName(loanPurposeName).setLoanOfficerId(loanOfficerId).setLoanOfficerName(loanOfficerName).setCurrency(currencyData).setProposedPrincipal(proposedPrincipal).setPrincipal(principal).setApprovedPrincipal(approvedPrincipal).setNetDisbursalAmount(netDisbursalAmount).setTotalOverpaid(totalOverpaid).setInArrearsTolerance(inArrearsTolerance).setTermFrequency(termFrequency).setTermPeriodFrequencyType(termPeriodFrequencyType).setNumberOfRepayments(numberOfRepayments).setRepaymentEvery(repaymentEvery).setRepaymentFrequencyType(repaymentFrequencyType).setRepaymentFrequencyNthDayType(repaymentFrequencyNthDayType).setRepaymentFrequencyDayOfWeekType(repaymentFrequencyDayOfWeekType).setTransactionProcessingStrategyCode(transactionStrategy).setTransactionProcessingStrategyName(transactionStrategyName).setAmortizationType(amortizationType).setInterestRatePerPeriod(interestRatePerPeriod).setInterestRateFrequencyType(interestRateFrequencyType).setAnnualInterestRate(annualInterestRate).setInterestType(interestType).setFloatingInterestRate(isFloatingInterestRate).setInterestRateDifferential(interestRateDifferential).setInterestCalculationPeriodType(interestCalculationPeriodType).setAllowPartialPeriodInterestCalculation(allowPartialPeriodInterestCalculation).setExpectedFirstRepaymentOnDate(expectedFirstRepaymentOnDate).setGraceOnPrincipalPayment(graceOnPrincipalPayment).setRecurringMoratoriumOnPrincipalPeriods(recurringMoratoriumOnPrincipalPeriods).setGraceOnInterestPayment(graceOnInterestPayment).setGraceOnInterestCharged(graceOnInterestCharged).setInterestChargedFromDate(interestChargedFromDate).setTimeline(timeline).setSummary(loanSummary).setFeeChargesAtDisbursementCharged(feeChargesDueAtDisbursementCharged).setSyncDisbursementWithMeeting(syncDisbursementWithMeeting).setLoanCounter(loanCounter).setLoanProductCounter(loanProductCounter).setMultiDisburseLoan(multiDisburseLoan).setCanDefineInstallmentAmount(canDefineInstallmentAmount).setFixedEmiAmount(fixedEmiAmont).setMaxOutstandingLoanBalance(outstandingLoanBalance).setInArrears(inArrears).setGraceOnArrearsAgeing(graceOnArrearsAgeing).setIsNPA(isNPA).setDaysInMonthType(daysInMonthType).setDaysInYearType(daysInYearType).setInterestRecalculationEnabled(isInterestRecalculationEnabled).setInterestRecalculationData(interestRecalculationData).setCreateStandingInstructionAtDisbursement(createStandingInstructionAtDisbursement).setIsVariableInstallmentsAllowed(isVariableInstallmentsAllowed).setMinimumGap(minimumGap).setMaximumGap(maximumGap).setSubStatus(subStatus).setCanUseForTopup(canUseForTopup).setTopup(isTopup).setClosureLoanId(closureLoanId).setClosureLoanAccountNo(closureLoanAccountNo).setTopupAmount(topupAmount).setIsEqualAmortization(isEqualAmortization).setFixedPrincipalPercentagePerInstallment(fixedPrincipalPercentagePerInstallment).setDelinquent(delinquent).setDelinquencyRange(delinquencyRange).setDisallowExpectedDisbursements(disallowExpectedDisbursements).setFraud(fraud).setLastClosedBusinessDate(lastClosedBusinessDate).setOverpaidOnDate(overpaidOnDate).setChargedOff(chargedOff).setEnableDownPayment(enableDownPayment).setDisbursedAmountPercentageForDownPayment(disbursedAmountPercentageForDownPayment).setEnableAutoRepaymentForDownPayment(enableAutoRepaymentForDownPayment).setRepaymentStartDateType(repaymentStartDateType).setEnableInstallmentLevelDelinquency(enableInstallmentLevelDelinquency).setLoanScheduleType(loanScheduleType).setLoanScheduleProcessingType(loanScheduleProcessingType).setFixedLength(fixedLength).setChargeOffBehaviour(chargeOffBehaviour).setInterestRecognitionOnDisbursementDate(isInterestRecognitionOnDisbursementDate).setAllowFullTermForTranche(allowFullTermForTranche).setDaysInYearCustomStrategy(daysInYearCustomStrategy).setEnableIncomeCapitalization(enableIncomeCapitalization).setCapitalizedIncomeCalculationType(capitalizedIncomeCalculationType).setCapitalizedIncomeStrategy(capitalizedIncomeStrategy).setCapitalizedIncomeType(capitalizedIncomeType).setEnableBuyDownFee(enableBuyDownFee).setBuyDownFeeCalculationType(buyDownFeeCalculationType).setBuyDownFeeStrategy(buyDownFeeStrategy).setBuyDownFeeIncomeType(buyDownFeeIncomeType).setMerchantBuyDownFee(merchantBuyDownFee);
    }

    /*
     * Used to combine the associations and template data on top of exist loan account data
     */
    public LoanAccountData associationsAndTemplate(final LoanScheduleData repaymentSchedule, final Collection<LoanTransactionData> transactions, final Collection<LoanChargeData> charges, final Collection<LoanCollateralManagementData> collateral, final Collection<? extends IGuarantor> guarantors, final CalendarData calendarData, final Collection<LoanProductData> productOptions, final Collection<EnumOptionData> termFrequencyTypeOptions, final Collection<EnumOptionData> repaymentFrequencyTypeOptions, final Collection<EnumOptionData> repaymentFrequencyNthDayTypeOptions, final Collection<EnumOptionData> repaymentFrequencyDayOfWeekTypeOptions, final Collection<TransactionProcessingStrategyData> transactionProcessingStrategyOptions, final Collection<EnumOptionData> interestRateFrequencyTypeOptions, final Collection<EnumOptionData> amortizationTypeOptions, final Collection<EnumOptionData> interestTypeOptions, final Collection<EnumOptionData> interestCalculationPeriodTypeOptions, final Collection<FundData> fundOptions, final Collection<ChargeData> chargeOptions, final ChargeData chargeTemplate, final Collection<StaffData> loanOfficerOptions, final Collection<CodeValueData> loanPurposeOptions, final Collection<CodeValueData> loanCollateralOptions, final Collection<CalendarData> calendarOptions, final Collection<NoteData> notes, final Collection<PortfolioAccountData> accountLinkingOptions, final PortfolioAccountData linkedAccount, final Collection<DisbursementData> disbursementDetails, final Collection<LoanTermVariationsData> emiAmountVariations, final Collection<ChargeData> overdueCharges, final PaidInAdvanceData paidInAdvance, Collection<InterestRatePeriodData> interestRatesPeriods, final Collection<LoanAccountSummaryData> clientActiveLoanOptions, final List<RateData> rates, final Boolean isRatesEnabled, final CollectionData delinquent, final List<EnumOptionData> loanScheduleTypeOptions, final List<EnumOptionData> loanScheduleProcessingTypeOptions, final List<LoanTermVariationsData> loanTermVariations, final List<StringEnumOptionData> daysInYearCustomStrategyOptions, final List<StringEnumOptionData> capitalizedIncomeCalculationTypeOptions, final List<StringEnumOptionData> capitalizedIncomeStrategyOptions, final List<StringEnumOptionData> capitalizedIncomeTypeOptions, final List<StringEnumOptionData> buyDownFeeCalculationTypeOptions, final List<StringEnumOptionData> buyDownFeeStrategyOptions, final List<StringEnumOptionData> buyDownFeeIncomeTypeOptions) {
        // TODO: why are these variables 'calendarData', 'chargeTemplate' never used (see original private constructor)
        return 
        // .setMeeting(calendarData)
        this.setRepaymentSchedule(repaymentSchedule).setTransactions(transactions).setCharges(charges).setCollateral(collateral).setGuarantors(guarantors).setProductOptions(productOptions).setTermFrequencyTypeOptions(termFrequencyTypeOptions).setRepaymentFrequencyTypeOptions(repaymentFrequencyTypeOptions).setRepaymentFrequencyNthDayTypeOptions(repaymentFrequencyNthDayTypeOptions).setRepaymentFrequencyDaysOfWeekTypeOptions(repaymentFrequencyDayOfWeekTypeOptions).setTransactionProcessingStrategyOptions(transactionProcessingStrategyOptions).setInterestRateFrequencyTypeOptions(interestRateFrequencyTypeOptions).setAmortizationTypeOptions(amortizationTypeOptions).setInterestTypeOptions(interestTypeOptions).setInterestCalculationPeriodTypeOptions(interestCalculationPeriodTypeOptions).setFundOptions(fundOptions).setChargeOptions(chargeOptions).setLoanOfficerOptions(loanOfficerOptions).setLoanPurposeOptions(loanPurposeOptions).setLoanCollateralOptions(loanCollateralOptions).setCalendarOptions(calendarOptions).setNotes(notes).setAccountLinkingOptions(accountLinkingOptions).setLinkedAccount(linkedAccount).setDisbursementDetails(disbursementDetails).setEmiAmountVariations(emiAmountVariations).setOverdueCharges(overdueCharges).setPaidInAdvance(paidInAdvance).setInterestRatesPeriods(interestRatesPeriods).setClientActiveLoanOptions(clientActiveLoanOptions).setRates(rates).setIsRatesEnabled(isRatesEnabled).setDelinquent(delinquent).setLoanScheduleTypeOptions(loanScheduleTypeOptions).setLoanScheduleProcessingTypeOptions(loanScheduleProcessingTypeOptions).setLoanTermVariations(loanTermVariations).setDaysInYearCustomStrategyOptions(daysInYearCustomStrategyOptions).setCapitalizedIncomeCalculationTypeOptions(capitalizedIncomeCalculationTypeOptions).setCapitalizedIncomeStrategyOptions(capitalizedIncomeStrategyOptions).setCapitalizedIncomeTypeOptions(capitalizedIncomeTypeOptions).setBuyDownFeeCalculationTypeOptions(buyDownFeeCalculationTypeOptions).setBuyDownFeeStrategyOptions(buyDownFeeStrategyOptions).setBuyDownFeeIncomeTypeOptions(buyDownFeeIncomeTypeOptions);
    }

    public LoanAccountData associationsAndTemplate(final Collection<LoanProductData> productOptions, final Collection<StaffData> allowedLoanOfficers, final Collection<CalendarData> calendarOptions, final Collection<PortfolioAccountData> accountLinkingOptions, final Boolean isRatesEnabled) {
        return  //
        //
        //
        //
        this.setProductOptions(productOptions).setLoanOfficerOptions(allowedLoanOfficers).setCalendarOptions(calendarOptions).setAccountLinkingOptions(accountLinkingOptions).setIsRatesEnabled(isRatesEnabled); //
    }

    public LoanAccountData associateMemberVariations(final Map<Long, Integer> memberLoanCycle) {
        final Map<Long, LoanBorrowerCycleData> memberVariations = new HashMap<>();
        for (Map.Entry<Long, Integer> mapEntry : memberLoanCycle.entrySet()) {
            BigDecimal principal = null;
            BigDecimal interestRatePerPeriod = null;
            Integer numberOfRepayments = null;
            Long clientId = mapEntry.getKey();
            Integer loanCycleNumber = mapEntry.getValue();
            if (product.isUseBorrowerCycle() && loanCycleNumber != null && loanCycleNumber > 0) {
                Collection<LoanProductBorrowerCycleVariationData> principalVariationsForBorrowerCycle = product.getPrincipalVariationsForBorrowerCycle();
                Collection<LoanProductBorrowerCycleVariationData> interestForVariationsForBorrowerCycle = product.getInterestRateVariationsForBorrowerCycle();
                Collection<LoanProductBorrowerCycleVariationData> repaymentVariationsForBorrowerCycle = product.getNumberOfRepaymentVariationsForBorrowerCycle();
                principal = fetchLoanCycleDefaultValue(principalVariationsForBorrowerCycle, loanCycleNumber);
                interestRatePerPeriod = fetchLoanCycleDefaultValue(interestForVariationsForBorrowerCycle, loanCycleNumber);
                BigDecimal numberofRepaymentval = fetchLoanCycleDefaultValue(repaymentVariationsForBorrowerCycle, loanCycleNumber);
                if (numberofRepaymentval != null) {
                    numberOfRepayments = numberofRepaymentval.intValue();
                }
            }
            if (principal == null) {
                principal = product.getPrincipal();
            }
            if (interestRatePerPeriod == null) {
                interestRatePerPeriod = product.getInterestRatePerPeriod();
            }
            if (numberOfRepayments == null) {
                numberOfRepayments = product.getNumberOfRepayments();
            }
            final Integer termFrequency = numberOfRepayments * product.getRepaymentEvery();
            LoanBorrowerCycleData borrowerCycleData = new LoanBorrowerCycleData(principal, interestRatePerPeriod, numberOfRepayments, termFrequency);
            memberVariations.put(clientId, borrowerCycleData);
        }
        return this.setMemberVariations(memberVariations);
    }

    public LoanAccountData withInterestRecalculationCalendarData(final CalendarData calendarData, final CalendarData compoundingCalendarData) {
        if (interestRecalculationData == null) {
            interestRecalculationData = new LoanInterestRecalculationData();
        }
        final LoanInterestRecalculationData newInterestRecalculationData = interestRecalculationData.withCalendarData(calendarData, compoundingCalendarData);
        return this.setInterestRecalculationData(newInterestRecalculationData);
    }

    public static final Comparator<LoanAccountData> LOAN_ACCOUNT_DATA_COMPARATOR_BY_CLIENT_NAME = (loan1, loan2) -> {
        String clientOfLoan1 = loan1.getClientName().toUpperCase(Locale.ENGLISH);
        String clientOfLoan2 = loan2.getClientName().toUpperCase(Locale.ENGLISH);
        return clientOfLoan1.compareTo(clientOfLoan2);
    };

    private static BigDecimal fetchLoanCycleDefaultValue(Collection<LoanProductBorrowerCycleVariationData> borrowerCycleVariationData, Integer loanCycleNumber) {
        BigDecimal defaultValue = null;
        Integer cycleNumberSelected = 0;
        for (LoanProductBorrowerCycleVariationData data : borrowerCycleVariationData) {
            if (isLoanCycleValuesWhenConditionEqual(loanCycleNumber, data) || isLoanCycleValuesWhenConditionGreterthan(loanCycleNumber, cycleNumberSelected, data)) {
                cycleNumberSelected = data.getBorrowerCycleNumber();
                defaultValue = data.getDefaultValue();
            }
        }
        return defaultValue;
    }

    private static boolean isLoanCycleValuesWhenConditionGreterthan(Integer loanCycleNumber, Integer cycleNumberSelected, LoanProductBorrowerCycleVariationData data) {
        return data.getBorrowerCycleNumber() < loanCycleNumber && data.getLoanProductValueConditionType().equals(LoanProductValueConditionType.GREATERTHAN) && cycleNumberSelected < data.getBorrowerCycleNumber();
    }

    private static boolean isLoanCycleValuesWhenConditionEqual(Integer loanCycleNumber, LoanProductBorrowerCycleVariationData data) {
        return data.getBorrowerCycleNumber().equals(loanCycleNumber) && data.getLoanProductValueConditionType().equals(LoanProductValueConditionType.EQUAL);
    }

    public Long getInterestRecalculationDetailId() {
        if (isInterestRecalculationEnabled) {
            return this.interestRecalculationData.getId();
        }
        return null;
    }

    public boolean isActive() {
        return LoanStatus.fromInt(getStatus().getId().intValue()).isActive();
    }

    public static LoanChargeData toLoanChargeData(final ChargeData chargeData) {
        BigDecimal percentage = null;
        if (chargeData.getChargeCalculationType().getId() == 2) {
            percentage = chargeData.getAmount();
        }
        return LoanChargeData.newLoanChargeDetails(chargeData.getId(), chargeData.getName(), chargeData.getCurrency(), chargeData.getAmount(), percentage, chargeData.getChargeTimeType(), chargeData.getChargeCalculationType(), chargeData.isPenalty(), chargeData.getChargePaymentMode(), chargeData.getMinCap(), chargeData.getMaxCap(), ExternalId.empty());
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
        public LoanStatusEnumData getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getSubStatus() {
        return this.subStatus;
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
        public GroupGeneralData getGroup() {
        return this.group;
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
        public boolean isLoanProductLinkedToFloatingRate() {
        return this.isLoanProductLinkedToFloatingRate;
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
        public Long getLoanPurposeId() {
        return this.loanPurposeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getLoanPurposeName() {
        return this.loanPurposeName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanOfficerId() {
        return this.loanOfficerId;
    }

    @java.lang.SuppressWarnings("all")
        public String getLoanOfficerName() {
        return this.loanOfficerName;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getLoanType() {
        return this.loanType;
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipal() {
        return this.principal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getApprovedPrincipal() {
        return this.approvedPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getProposedPrincipal() {
        return this.proposedPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getNetDisbursalAmount() {
        return this.netDisbursalAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getTermFrequency() {
        return this.termFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getTermPeriodFrequencyType() {
        return this.termPeriodFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getNumberOfRepayments() {
        return this.numberOfRepayments;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getActualNoTerm() {
        return this.actualNoTerm;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRepaymentEvery() {
        return this.repaymentEvery;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getFixedLength() {
        return this.fixedLength;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getRepaymentFrequencyType() {
        return this.repaymentFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getRepaymentFrequencyNthDayType() {
        return this.repaymentFrequencyNthDayType;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getRepaymentFrequencyDayOfWeekType() {
        return this.repaymentFrequencyDayOfWeekType;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestRatePerPeriod() {
        return this.interestRatePerPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getInterestRateFrequencyType() {
        return this.interestRateFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAnnualInterestRate() {
        return this.annualInterestRate;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isFloatingInterestRate() {
        return this.isFloatingInterestRate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestRateDifferential() {
        return this.interestRateDifferential;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getAmortizationType() {
        return this.amortizationType;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getInterestType() {
        return this.interestType;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getInterestCalculationPeriodType() {
        return this.interestCalculationPeriodType;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getAllowPartialPeriodInterestCalculation() {
        return this.allowPartialPeriodInterestCalculation;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInArrearsTolerance() {
        return this.inArrearsTolerance;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransactionProcessingStrategyCode() {
        return this.transactionProcessingStrategyCode;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransactionProcessingStrategyName() {
        return this.transactionProcessingStrategyName;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getGraceOnPrincipalPayment() {
        return this.graceOnPrincipalPayment;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRecurringMoratoriumOnPrincipalPeriods() {
        return this.recurringMoratoriumOnPrincipalPeriods;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getGraceOnInterestPayment() {
        return this.graceOnInterestPayment;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getGraceOnInterestCharged() {
        return this.graceOnInterestCharged;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getGraceOnArrearsAgeing() {
        return this.graceOnArrearsAgeing;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getInterestChargedFromDate() {
        return this.interestChargedFromDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getExpectedFirstRepaymentOnDate() {
        return this.expectedFirstRepaymentOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getSyncDisbursementWithMeeting() {
        return this.syncDisbursementWithMeeting;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getDisallowExpectedDisbursements() {
        return this.disallowExpectedDisbursements;
    }

    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData getTimeline() {
        return this.timeline;
    }

    @java.lang.SuppressWarnings("all")
        public LoanSummaryData getSummary() {
        return this.summary;
    }

    @java.lang.SuppressWarnings("all")
        public LoanScheduleData getRepaymentSchedule() {
        return this.repaymentSchedule;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LoanTransactionData> getTransactions() {
        return this.transactions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LoanChargeData> getCharges() {
        return this.charges;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LoanCollateralManagementData> getCollateral() {
        return this.collateral;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<? extends IGuarantor> getGuarantors() {
        return this.guarantors;
    }

    @java.lang.SuppressWarnings("all")
        public CalendarData getMeeting() {
        return this.meeting;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<NoteData> getNotes() {
        return this.notes;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<DisbursementData> getDisbursementDetails() {
        return this.disbursementDetails;
    }

    @java.lang.SuppressWarnings("all")
        public LoanScheduleData getOriginalSchedule() {
        return this.originalSchedule;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LoanOriginatorData> getOriginators() {
        return this.originators;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LoanProductData> getProductOptions() {
        return this.productOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<StaffData> getLoanOfficerOptions() {
        return this.loanOfficerOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getLoanPurposeOptions() {
        return this.loanPurposeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<FundData> getFundOptions() {
        return this.fundOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<EnumOptionData> getTermFrequencyTypeOptions() {
        return this.termFrequencyTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<EnumOptionData> getRepaymentFrequencyTypeOptions() {
        return this.repaymentFrequencyTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<EnumOptionData> getRepaymentFrequencyNthDayTypeOptions() {
        return this.repaymentFrequencyNthDayTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<EnumOptionData> getRepaymentFrequencyDaysOfWeekTypeOptions() {
        return this.repaymentFrequencyDaysOfWeekTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<EnumOptionData> getInterestRateFrequencyTypeOptions() {
        return this.interestRateFrequencyTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<EnumOptionData> getAmortizationTypeOptions() {
        return this.amortizationTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<EnumOptionData> getInterestTypeOptions() {
        return this.interestTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<EnumOptionData> getInterestCalculationPeriodTypeOptions() {
        return this.interestCalculationPeriodTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<TransactionProcessingStrategyData> getTransactionProcessingStrategyOptions() {
        return this.transactionProcessingStrategyOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<ChargeData> getChargeOptions() {
        return this.chargeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getLoanCollateralOptions() {
        return this.loanCollateralOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CalendarData> getCalendarOptions() {
        return this.calendarOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getLoanScheduleTypeOptions() {
        return this.loanScheduleTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getLoanScheduleProcessingTypeOptions() {
        return this.loanScheduleProcessingTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getDaysInYearCustomStrategyOptions() {
        return this.daysInYearCustomStrategyOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getCapitalizedIncomeCalculationTypeOptions() {
        return this.capitalizedIncomeCalculationTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getCapitalizedIncomeStrategyOptions() {
        return this.capitalizedIncomeStrategyOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getCapitalizedIncomeTypeOptions() {
        return this.capitalizedIncomeTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getBuyDownFeeCalculationTypeOptions() {
        return this.buyDownFeeCalculationTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getBuyDownFeeStrategyOptions() {
        return this.buyDownFeeStrategyOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getBuyDownFeeIncomeTypeOptions() {
        return this.buyDownFeeIncomeTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeChargesAtDisbursementCharged() {
        return this.feeChargesAtDisbursementCharged;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalOverpaid() {
        return this.totalOverpaid;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getLoanCounter() {
        return this.loanCounter;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getLoanProductCounter() {
        return this.loanProductCounter;
    }

    @java.lang.SuppressWarnings("all")
        public PortfolioAccountData getLinkedAccount() {
        return this.linkedAccount;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<PortfolioAccountData> getAccountLinkingOptions() {
        return this.accountLinkingOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getMultiDisburseLoan() {
        return this.multiDisburseLoan;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getCanDefineInstallmentAmount() {
        return this.canDefineInstallmentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFixedEmiAmount() {
        return this.fixedEmiAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMaxOutstandingLoanBalance() {
        return this.maxOutstandingLoanBalance;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getCanDisburse() {
        return this.canDisburse;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LoanTermVariationsData> getEmiAmountVariations() {
        return this.emiAmountVariations;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LoanTermVariationsData> getLoanTermVariations() {
        return this.loanTermVariations;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LoanAccountSummaryData> getClientActiveLoanOptions() {
        return this.clientActiveLoanOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getCanUseForTopup() {
        return this.canUseForTopup;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isTopup() {
        return this.isTopup;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isFraud() {
        return this.fraud;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClosureLoanId() {
        return this.closureLoanId;
    }

    @java.lang.SuppressWarnings("all")
        public String getClosureLoanAccountNo() {
        return this.closureLoanAccountNo;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTopupAmount() {
        return this.topupAmount;
    }

    @java.lang.SuppressWarnings("all")
        public LoanProductData getProduct() {
        return this.product;
    }

    @java.lang.SuppressWarnings("all")
        public Map<Long, LoanBorrowerCycleData> getMemberVariations() {
        return this.memberVariations;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getInArrears() {
        return this.inArrears;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsNPA() {
        return this.isNPA;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<ChargeData> getOverdueCharges() {
        return this.overdueCharges;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getDaysInMonthType() {
        return this.daysInMonthType;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getDaysInYearType() {
        return this.daysInYearType;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getDaysInYearCustomStrategy() {
        return this.daysInYearCustomStrategy;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isInterestRecalculationEnabled() {
        return this.isInterestRecalculationEnabled;
    }

    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData getInterestRecalculationData() {
        return this.interestRecalculationData;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getCreateStandingInstructionAtDisbursement() {
        return this.createStandingInstructionAtDisbursement;
    }

    @java.lang.SuppressWarnings("all")
        public PaidInAdvanceData getPaidInAdvance() {
        return this.paidInAdvance;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<InterestRatePeriodData> getInterestRatesPeriods() {
        return this.interestRatesPeriods;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsVariableInstallmentsAllowed() {
        return this.isVariableInstallmentsAllowed;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getMinimumGap() {
        return this.minimumGap;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getMaximumGap() {
        return this.maximumGap;
    }

    @java.lang.SuppressWarnings("all")
        public List<DatatableData> getDatatables() {
        return this.datatables;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsEqualAmortization() {
        return this.isEqualAmortization;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFixedPrincipalPercentagePerInstallment() {
        return this.fixedPrincipalPercentagePerInstallment;
    }

    @java.lang.SuppressWarnings("all")
        public List<RateData> getRates() {
        return this.rates;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsRatesEnabled() {
        return this.isRatesEnabled;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRowIndex() {
        return this.rowIndex;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSubmittedOnDate() {
        return this.submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public Long getProductId() {
        return this.productId;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getLoanTermFrequency() {
        return this.loanTermFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getLoanTermFrequencyType() {
        return this.loanTermFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getRepaymentsStartingFromDate() {
        return this.repaymentsStartingFromDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getLinkAccountId() {
        return this.linkAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getGroupId() {
        return this.groupId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getExpectedDisbursementDate() {
        return this.expectedDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getOverpaidOnDate() {
        return this.overpaidOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public CollectionData getDelinquent() {
        return this.delinquent;
    }

    @java.lang.SuppressWarnings("all")
        public DelinquencyRangeData getDelinquencyRange() {
        return this.delinquencyRange;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getEnableInstallmentLevelDelinquency() {
        return this.enableInstallmentLevelDelinquency;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getLastClosedBusinessDate() {
        return this.lastClosedBusinessDate;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getChargedOff() {
        return this.chargedOff;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getAllowFullTermForTranche() {
        return this.allowFullTermForTranche;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getEnableDownPayment() {
        return this.enableDownPayment;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDisbursedAmountPercentageForDownPayment() {
        return this.disbursedAmountPercentageForDownPayment;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getEnableAutoRepaymentForDownPayment() {
        return this.enableAutoRepaymentForDownPayment;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getRepaymentStartDateType() {
        return this.repaymentStartDateType;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getInterestRecognitionOnDisbursementDate() {
        return this.interestRecognitionOnDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getLoanScheduleType() {
        return this.loanScheduleType;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getLoanScheduleProcessingType() {
        return this.loanScheduleProcessingType;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getChargeOffBehaviour() {
        return this.chargeOffBehaviour;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getEnableIncomeCapitalization() {
        return this.enableIncomeCapitalization;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getCapitalizedIncomeCalculationType() {
        return this.capitalizedIncomeCalculationType;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getCapitalizedIncomeStrategy() {
        return this.capitalizedIncomeStrategy;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getCapitalizedIncomeType() {
        return this.capitalizedIncomeType;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getEnableBuyDownFee() {
        return this.enableBuyDownFee;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getBuyDownFeeCalculationType() {
        return this.buyDownFeeCalculationType;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getBuyDownFeeStrategy() {
        return this.buyDownFeeStrategy;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getBuyDownFeeIncomeType() {
        return this.buyDownFeeIncomeType;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getMerchantBuyDownFee() {
        return this.merchantBuyDownFee;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setAccountNo(final String accountNo) {
        this.accountNo = accountNo;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setExternalId(final ExternalId externalId) {
        this.externalId = externalId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setStatus(final LoanStatusEnumData status) {
        this.status = status;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setSubStatus(final EnumOptionData subStatus) {
        this.subStatus = subStatus;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setClientId(final Long clientId) {
        this.clientId = clientId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setClientAccountNo(final String clientAccountNo) {
        this.clientAccountNo = clientAccountNo;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setClientName(final String clientName) {
        this.clientName = clientName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setClientExternalId(final ExternalId clientExternalId) {
        this.clientExternalId = clientExternalId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setClientOfficeId(final Long clientOfficeId) {
        this.clientOfficeId = clientOfficeId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setGroup(final GroupGeneralData group) {
        this.group = group;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanProductId(final Long loanProductId) {
        this.loanProductId = loanProductId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanProductName(final String loanProductName) {
        this.loanProductName = loanProductName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanProductDescription(final String loanProductDescription) {
        this.loanProductDescription = loanProductDescription;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanProductLinkedToFloatingRate(final boolean isLoanProductLinkedToFloatingRate) {
        this.isLoanProductLinkedToFloatingRate = isLoanProductLinkedToFloatingRate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setFundId(final Long fundId) {
        this.fundId = fundId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setFundName(final String fundName) {
        this.fundName = fundName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanPurposeId(final Long loanPurposeId) {
        this.loanPurposeId = loanPurposeId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanPurposeName(final String loanPurposeName) {
        this.loanPurposeName = loanPurposeName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanOfficerId(final Long loanOfficerId) {
        this.loanOfficerId = loanOfficerId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanOfficerName(final String loanOfficerName) {
        this.loanOfficerName = loanOfficerName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanType(final EnumOptionData loanType) {
        this.loanType = loanType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setCurrency(final CurrencyData currency) {
        this.currency = currency;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setPrincipal(final BigDecimal principal) {
        this.principal = principal;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setApprovedPrincipal(final BigDecimal approvedPrincipal) {
        this.approvedPrincipal = approvedPrincipal;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setProposedPrincipal(final BigDecimal proposedPrincipal) {
        this.proposedPrincipal = proposedPrincipal;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setNetDisbursalAmount(final BigDecimal netDisbursalAmount) {
        this.netDisbursalAmount = netDisbursalAmount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setTermFrequency(final Integer termFrequency) {
        this.termFrequency = termFrequency;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setTermPeriodFrequencyType(final EnumOptionData termPeriodFrequencyType) {
        this.termPeriodFrequencyType = termPeriodFrequencyType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setNumberOfRepayments(final Integer numberOfRepayments) {
        this.numberOfRepayments = numberOfRepayments;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setActualNoTerm(final Integer actualNoTerm) {
        this.actualNoTerm = actualNoTerm;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setRepaymentEvery(final Integer repaymentEvery) {
        this.repaymentEvery = repaymentEvery;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setFixedLength(final Integer fixedLength) {
        this.fixedLength = fixedLength;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setRepaymentFrequencyType(final EnumOptionData repaymentFrequencyType) {
        this.repaymentFrequencyType = repaymentFrequencyType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setRepaymentFrequencyNthDayType(final EnumOptionData repaymentFrequencyNthDayType) {
        this.repaymentFrequencyNthDayType = repaymentFrequencyNthDayType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setRepaymentFrequencyDayOfWeekType(final EnumOptionData repaymentFrequencyDayOfWeekType) {
        this.repaymentFrequencyDayOfWeekType = repaymentFrequencyDayOfWeekType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setInterestRatePerPeriod(final BigDecimal interestRatePerPeriod) {
        this.interestRatePerPeriod = interestRatePerPeriod;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setInterestRateFrequencyType(final EnumOptionData interestRateFrequencyType) {
        this.interestRateFrequencyType = interestRateFrequencyType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setAnnualInterestRate(final BigDecimal annualInterestRate) {
        this.annualInterestRate = annualInterestRate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setFloatingInterestRate(final boolean isFloatingInterestRate) {
        this.isFloatingInterestRate = isFloatingInterestRate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setInterestRateDifferential(final BigDecimal interestRateDifferential) {
        this.interestRateDifferential = interestRateDifferential;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setAmortizationType(final EnumOptionData amortizationType) {
        this.amortizationType = amortizationType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setInterestType(final EnumOptionData interestType) {
        this.interestType = interestType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setInterestCalculationPeriodType(final EnumOptionData interestCalculationPeriodType) {
        this.interestCalculationPeriodType = interestCalculationPeriodType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setAllowPartialPeriodInterestCalculation(final Boolean allowPartialPeriodInterestCalculation) {
        this.allowPartialPeriodInterestCalculation = allowPartialPeriodInterestCalculation;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setInArrearsTolerance(final BigDecimal inArrearsTolerance) {
        this.inArrearsTolerance = inArrearsTolerance;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setTransactionProcessingStrategyCode(final String transactionProcessingStrategyCode) {
        this.transactionProcessingStrategyCode = transactionProcessingStrategyCode;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setTransactionProcessingStrategyName(final String transactionProcessingStrategyName) {
        this.transactionProcessingStrategyName = transactionProcessingStrategyName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setGraceOnPrincipalPayment(final Integer graceOnPrincipalPayment) {
        this.graceOnPrincipalPayment = graceOnPrincipalPayment;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setRecurringMoratoriumOnPrincipalPeriods(final Integer recurringMoratoriumOnPrincipalPeriods) {
        this.recurringMoratoriumOnPrincipalPeriods = recurringMoratoriumOnPrincipalPeriods;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setGraceOnInterestPayment(final Integer graceOnInterestPayment) {
        this.graceOnInterestPayment = graceOnInterestPayment;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setGraceOnInterestCharged(final Integer graceOnInterestCharged) {
        this.graceOnInterestCharged = graceOnInterestCharged;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setGraceOnArrearsAgeing(final Integer graceOnArrearsAgeing) {
        this.graceOnArrearsAgeing = graceOnArrearsAgeing;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setInterestChargedFromDate(final LocalDate interestChargedFromDate) {
        this.interestChargedFromDate = interestChargedFromDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setExpectedFirstRepaymentOnDate(final LocalDate expectedFirstRepaymentOnDate) {
        this.expectedFirstRepaymentOnDate = expectedFirstRepaymentOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setSyncDisbursementWithMeeting(final Boolean syncDisbursementWithMeeting) {
        this.syncDisbursementWithMeeting = syncDisbursementWithMeeting;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setDisallowExpectedDisbursements(final Boolean disallowExpectedDisbursements) {
        this.disallowExpectedDisbursements = disallowExpectedDisbursements;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setTimeline(final LoanApplicationTimelineData timeline) {
        this.timeline = timeline;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setSummary(final LoanSummaryData summary) {
        this.summary = summary;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setRepaymentSchedule(final LoanScheduleData repaymentSchedule) {
        this.repaymentSchedule = repaymentSchedule;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setTransactions(final Collection<LoanTransactionData> transactions) {
        this.transactions = transactions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setCharges(final Collection<LoanChargeData> charges) {
        this.charges = charges;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setCollateral(final Collection<LoanCollateralManagementData> collateral) {
        this.collateral = collateral;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setGuarantors(final Collection<? extends IGuarantor> guarantors) {
        this.guarantors = guarantors;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setMeeting(final CalendarData meeting) {
        this.meeting = meeting;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setNotes(final Collection<NoteData> notes) {
        this.notes = notes;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setDisbursementDetails(final Collection<DisbursementData> disbursementDetails) {
        this.disbursementDetails = disbursementDetails;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setOriginalSchedule(final LoanScheduleData originalSchedule) {
        this.originalSchedule = originalSchedule;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setOriginators(final Collection<LoanOriginatorData> originators) {
        this.originators = originators;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setProductOptions(final Collection<LoanProductData> productOptions) {
        this.productOptions = productOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanOfficerOptions(final Collection<StaffData> loanOfficerOptions) {
        this.loanOfficerOptions = loanOfficerOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanPurposeOptions(final Collection<CodeValueData> loanPurposeOptions) {
        this.loanPurposeOptions = loanPurposeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setFundOptions(final Collection<FundData> fundOptions) {
        this.fundOptions = fundOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setTermFrequencyTypeOptions(final Collection<EnumOptionData> termFrequencyTypeOptions) {
        this.termFrequencyTypeOptions = termFrequencyTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setRepaymentFrequencyTypeOptions(final Collection<EnumOptionData> repaymentFrequencyTypeOptions) {
        this.repaymentFrequencyTypeOptions = repaymentFrequencyTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setRepaymentFrequencyNthDayTypeOptions(final Collection<EnumOptionData> repaymentFrequencyNthDayTypeOptions) {
        this.repaymentFrequencyNthDayTypeOptions = repaymentFrequencyNthDayTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setRepaymentFrequencyDaysOfWeekTypeOptions(final Collection<EnumOptionData> repaymentFrequencyDaysOfWeekTypeOptions) {
        this.repaymentFrequencyDaysOfWeekTypeOptions = repaymentFrequencyDaysOfWeekTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setInterestRateFrequencyTypeOptions(final Collection<EnumOptionData> interestRateFrequencyTypeOptions) {
        this.interestRateFrequencyTypeOptions = interestRateFrequencyTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setAmortizationTypeOptions(final Collection<EnumOptionData> amortizationTypeOptions) {
        this.amortizationTypeOptions = amortizationTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setInterestTypeOptions(final Collection<EnumOptionData> interestTypeOptions) {
        this.interestTypeOptions = interestTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setInterestCalculationPeriodTypeOptions(final Collection<EnumOptionData> interestCalculationPeriodTypeOptions) {
        this.interestCalculationPeriodTypeOptions = interestCalculationPeriodTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setTransactionProcessingStrategyOptions(final Collection<TransactionProcessingStrategyData> transactionProcessingStrategyOptions) {
        this.transactionProcessingStrategyOptions = transactionProcessingStrategyOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setChargeOptions(final Collection<ChargeData> chargeOptions) {
        this.chargeOptions = chargeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanCollateralOptions(final Collection<CodeValueData> loanCollateralOptions) {
        this.loanCollateralOptions = loanCollateralOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setCalendarOptions(final Collection<CalendarData> calendarOptions) {
        this.calendarOptions = calendarOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanScheduleTypeOptions(final List<EnumOptionData> loanScheduleTypeOptions) {
        this.loanScheduleTypeOptions = loanScheduleTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanScheduleProcessingTypeOptions(final List<EnumOptionData> loanScheduleProcessingTypeOptions) {
        this.loanScheduleProcessingTypeOptions = loanScheduleProcessingTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setDaysInYearCustomStrategyOptions(final List<StringEnumOptionData> daysInYearCustomStrategyOptions) {
        this.daysInYearCustomStrategyOptions = daysInYearCustomStrategyOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setCapitalizedIncomeCalculationTypeOptions(final List<StringEnumOptionData> capitalizedIncomeCalculationTypeOptions) {
        this.capitalizedIncomeCalculationTypeOptions = capitalizedIncomeCalculationTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setCapitalizedIncomeStrategyOptions(final List<StringEnumOptionData> capitalizedIncomeStrategyOptions) {
        this.capitalizedIncomeStrategyOptions = capitalizedIncomeStrategyOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setCapitalizedIncomeTypeOptions(final List<StringEnumOptionData> capitalizedIncomeTypeOptions) {
        this.capitalizedIncomeTypeOptions = capitalizedIncomeTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setBuyDownFeeCalculationTypeOptions(final List<StringEnumOptionData> buyDownFeeCalculationTypeOptions) {
        this.buyDownFeeCalculationTypeOptions = buyDownFeeCalculationTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setBuyDownFeeStrategyOptions(final List<StringEnumOptionData> buyDownFeeStrategyOptions) {
        this.buyDownFeeStrategyOptions = buyDownFeeStrategyOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setBuyDownFeeIncomeTypeOptions(final List<StringEnumOptionData> buyDownFeeIncomeTypeOptions) {
        this.buyDownFeeIncomeTypeOptions = buyDownFeeIncomeTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setFeeChargesAtDisbursementCharged(final BigDecimal feeChargesAtDisbursementCharged) {
        this.feeChargesAtDisbursementCharged = feeChargesAtDisbursementCharged;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setTotalOverpaid(final BigDecimal totalOverpaid) {
        this.totalOverpaid = totalOverpaid;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanCounter(final Integer loanCounter) {
        this.loanCounter = loanCounter;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanProductCounter(final Integer loanProductCounter) {
        this.loanProductCounter = loanProductCounter;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLinkedAccount(final PortfolioAccountData linkedAccount) {
        this.linkedAccount = linkedAccount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setAccountLinkingOptions(final Collection<PortfolioAccountData> accountLinkingOptions) {
        this.accountLinkingOptions = accountLinkingOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setMultiDisburseLoan(final Boolean multiDisburseLoan) {
        this.multiDisburseLoan = multiDisburseLoan;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setCanDefineInstallmentAmount(final Boolean canDefineInstallmentAmount) {
        this.canDefineInstallmentAmount = canDefineInstallmentAmount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setFixedEmiAmount(final BigDecimal fixedEmiAmount) {
        this.fixedEmiAmount = fixedEmiAmount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setMaxOutstandingLoanBalance(final BigDecimal maxOutstandingLoanBalance) {
        this.maxOutstandingLoanBalance = maxOutstandingLoanBalance;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setCanDisburse(final Boolean canDisburse) {
        this.canDisburse = canDisburse;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setEmiAmountVariations(final Collection<LoanTermVariationsData> emiAmountVariations) {
        this.emiAmountVariations = emiAmountVariations;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanTermVariations(final Collection<LoanTermVariationsData> loanTermVariations) {
        this.loanTermVariations = loanTermVariations;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setClientActiveLoanOptions(final Collection<LoanAccountSummaryData> clientActiveLoanOptions) {
        this.clientActiveLoanOptions = clientActiveLoanOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setCanUseForTopup(final Boolean canUseForTopup) {
        this.canUseForTopup = canUseForTopup;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setTopup(final boolean isTopup) {
        this.isTopup = isTopup;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setFraud(final boolean fraud) {
        this.fraud = fraud;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setClosureLoanId(final Long closureLoanId) {
        this.closureLoanId = closureLoanId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setClosureLoanAccountNo(final String closureLoanAccountNo) {
        this.closureLoanAccountNo = closureLoanAccountNo;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setTopupAmount(final BigDecimal topupAmount) {
        this.topupAmount = topupAmount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setProduct(final LoanProductData product) {
        this.product = product;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setMemberVariations(final Map<Long, LoanBorrowerCycleData> memberVariations) {
        this.memberVariations = memberVariations;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setInArrears(final Boolean inArrears) {
        this.inArrears = inArrears;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setIsNPA(final Boolean isNPA) {
        this.isNPA = isNPA;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setOverdueCharges(final Collection<ChargeData> overdueCharges) {
        this.overdueCharges = overdueCharges;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setDaysInMonthType(final EnumOptionData daysInMonthType) {
        this.daysInMonthType = daysInMonthType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setDaysInYearType(final EnumOptionData daysInYearType) {
        this.daysInYearType = daysInYearType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setDaysInYearCustomStrategy(final StringEnumOptionData daysInYearCustomStrategy) {
        this.daysInYearCustomStrategy = daysInYearCustomStrategy;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setInterestRecalculationEnabled(final boolean isInterestRecalculationEnabled) {
        this.isInterestRecalculationEnabled = isInterestRecalculationEnabled;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setInterestRecalculationData(final LoanInterestRecalculationData interestRecalculationData) {
        this.interestRecalculationData = interestRecalculationData;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setCreateStandingInstructionAtDisbursement(final Boolean createStandingInstructionAtDisbursement) {
        this.createStandingInstructionAtDisbursement = createStandingInstructionAtDisbursement;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setPaidInAdvance(final PaidInAdvanceData paidInAdvance) {
        this.paidInAdvance = paidInAdvance;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setInterestRatesPeriods(final Collection<InterestRatePeriodData> interestRatesPeriods) {
        this.interestRatesPeriods = interestRatesPeriods;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setIsVariableInstallmentsAllowed(final Boolean isVariableInstallmentsAllowed) {
        this.isVariableInstallmentsAllowed = isVariableInstallmentsAllowed;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setMinimumGap(final Integer minimumGap) {
        this.minimumGap = minimumGap;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setMaximumGap(final Integer maximumGap) {
        this.maximumGap = maximumGap;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setDatatables(final List<DatatableData> datatables) {
        this.datatables = datatables;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setIsEqualAmortization(final Boolean isEqualAmortization) {
        this.isEqualAmortization = isEqualAmortization;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setFixedPrincipalPercentagePerInstallment(final BigDecimal fixedPrincipalPercentagePerInstallment) {
        this.fixedPrincipalPercentagePerInstallment = fixedPrincipalPercentagePerInstallment;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setRates(final List<RateData> rates) {
        this.rates = rates;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setIsRatesEnabled(final Boolean isRatesEnabled) {
        this.isRatesEnabled = isRatesEnabled;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLocale(final String locale) {
        this.locale = locale;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setRowIndex(final Integer rowIndex) {
        this.rowIndex = rowIndex;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setSubmittedOnDate(final LocalDate submittedOnDate) {
        this.submittedOnDate = submittedOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setProductId(final Long productId) {
        this.productId = productId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanTermFrequency(final Integer loanTermFrequency) {
        this.loanTermFrequency = loanTermFrequency;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanTermFrequencyType(final EnumOptionData loanTermFrequencyType) {
        this.loanTermFrequencyType = loanTermFrequencyType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setRepaymentsStartingFromDate(final LocalDate repaymentsStartingFromDate) {
        this.repaymentsStartingFromDate = repaymentsStartingFromDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLinkAccountId(final String linkAccountId) {
        this.linkAccountId = linkAccountId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setGroupId(final Long groupId) {
        this.groupId = groupId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setExpectedDisbursementDate(final LocalDate expectedDisbursementDate) {
        this.expectedDisbursementDate = expectedDisbursementDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setOverpaidOnDate(final LocalDate overpaidOnDate) {
        this.overpaidOnDate = overpaidOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setDelinquent(final CollectionData delinquent) {
        this.delinquent = delinquent;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setDelinquencyRange(final DelinquencyRangeData delinquencyRange) {
        this.delinquencyRange = delinquencyRange;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setEnableInstallmentLevelDelinquency(final Boolean enableInstallmentLevelDelinquency) {
        this.enableInstallmentLevelDelinquency = enableInstallmentLevelDelinquency;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLastClosedBusinessDate(final LocalDate lastClosedBusinessDate) {
        this.lastClosedBusinessDate = lastClosedBusinessDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setChargedOff(final Boolean chargedOff) {
        this.chargedOff = chargedOff;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setAllowFullTermForTranche(final Boolean allowFullTermForTranche) {
        this.allowFullTermForTranche = allowFullTermForTranche;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setEnableDownPayment(final Boolean enableDownPayment) {
        this.enableDownPayment = enableDownPayment;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setDisbursedAmountPercentageForDownPayment(final BigDecimal disbursedAmountPercentageForDownPayment) {
        this.disbursedAmountPercentageForDownPayment = disbursedAmountPercentageForDownPayment;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setEnableAutoRepaymentForDownPayment(final Boolean enableAutoRepaymentForDownPayment) {
        this.enableAutoRepaymentForDownPayment = enableAutoRepaymentForDownPayment;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setRepaymentStartDateType(final EnumOptionData repaymentStartDateType) {
        this.repaymentStartDateType = repaymentStartDateType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setInterestRecognitionOnDisbursementDate(final Boolean interestRecognitionOnDisbursementDate) {
        this.interestRecognitionOnDisbursementDate = interestRecognitionOnDisbursementDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanScheduleType(final EnumOptionData loanScheduleType) {
        this.loanScheduleType = loanScheduleType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setLoanScheduleProcessingType(final EnumOptionData loanScheduleProcessingType) {
        this.loanScheduleProcessingType = loanScheduleProcessingType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setChargeOffBehaviour(final StringEnumOptionData chargeOffBehaviour) {
        this.chargeOffBehaviour = chargeOffBehaviour;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setEnableIncomeCapitalization(final Boolean enableIncomeCapitalization) {
        this.enableIncomeCapitalization = enableIncomeCapitalization;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setCapitalizedIncomeCalculationType(final StringEnumOptionData capitalizedIncomeCalculationType) {
        this.capitalizedIncomeCalculationType = capitalizedIncomeCalculationType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setCapitalizedIncomeStrategy(final StringEnumOptionData capitalizedIncomeStrategy) {
        this.capitalizedIncomeStrategy = capitalizedIncomeStrategy;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setCapitalizedIncomeType(final StringEnumOptionData capitalizedIncomeType) {
        this.capitalizedIncomeType = capitalizedIncomeType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setEnableBuyDownFee(final Boolean enableBuyDownFee) {
        this.enableBuyDownFee = enableBuyDownFee;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setBuyDownFeeCalculationType(final StringEnumOptionData buyDownFeeCalculationType) {
        this.buyDownFeeCalculationType = buyDownFeeCalculationType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setBuyDownFeeStrategy(final StringEnumOptionData buyDownFeeStrategy) {
        this.buyDownFeeStrategy = buyDownFeeStrategy;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setBuyDownFeeIncomeType(final StringEnumOptionData buyDownFeeIncomeType) {
        this.buyDownFeeIncomeType = buyDownFeeIncomeType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanAccountData setMerchantBuyDownFee(final Boolean merchantBuyDownFee) {
        this.merchantBuyDownFee = merchantBuyDownFee;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanAccountData)) return false;
        final LoanAccountData other = (LoanAccountData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isLoanProductLinkedToFloatingRate() != other.isLoanProductLinkedToFloatingRate()) return false;
        if (this.isFloatingInterestRate() != other.isFloatingInterestRate()) return false;
        if (this.isTopup() != other.isTopup()) return false;
        if (this.isFraud() != other.isFraud()) return false;
        if (this.isInterestRecalculationEnabled() != other.isInterestRecalculationEnabled()) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$clientId = this.getClientId();
        final java.lang.Object other$clientId = other.getClientId();
        if (this$clientId == null ? other$clientId != null : !this$clientId.equals(other$clientId)) return false;
        final java.lang.Object this$clientOfficeId = this.getClientOfficeId();
        final java.lang.Object other$clientOfficeId = other.getClientOfficeId();
        if (this$clientOfficeId == null ? other$clientOfficeId != null : !this$clientOfficeId.equals(other$clientOfficeId)) return false;
        final java.lang.Object this$loanProductId = this.getLoanProductId();
        final java.lang.Object other$loanProductId = other.getLoanProductId();
        if (this$loanProductId == null ? other$loanProductId != null : !this$loanProductId.equals(other$loanProductId)) return false;
        final java.lang.Object this$fundId = this.getFundId();
        final java.lang.Object other$fundId = other.getFundId();
        if (this$fundId == null ? other$fundId != null : !this$fundId.equals(other$fundId)) return false;
        final java.lang.Object this$loanPurposeId = this.getLoanPurposeId();
        final java.lang.Object other$loanPurposeId = other.getLoanPurposeId();
        if (this$loanPurposeId == null ? other$loanPurposeId != null : !this$loanPurposeId.equals(other$loanPurposeId)) return false;
        final java.lang.Object this$loanOfficerId = this.getLoanOfficerId();
        final java.lang.Object other$loanOfficerId = other.getLoanOfficerId();
        if (this$loanOfficerId == null ? other$loanOfficerId != null : !this$loanOfficerId.equals(other$loanOfficerId)) return false;
        final java.lang.Object this$termFrequency = this.getTermFrequency();
        final java.lang.Object other$termFrequency = other.getTermFrequency();
        if (this$termFrequency == null ? other$termFrequency != null : !this$termFrequency.equals(other$termFrequency)) return false;
        final java.lang.Object this$numberOfRepayments = this.getNumberOfRepayments();
        final java.lang.Object other$numberOfRepayments = other.getNumberOfRepayments();
        if (this$numberOfRepayments == null ? other$numberOfRepayments != null : !this$numberOfRepayments.equals(other$numberOfRepayments)) return false;
        final java.lang.Object this$actualNoTerm = this.getActualNoTerm();
        final java.lang.Object other$actualNoTerm = other.getActualNoTerm();
        if (this$actualNoTerm == null ? other$actualNoTerm != null : !this$actualNoTerm.equals(other$actualNoTerm)) return false;
        final java.lang.Object this$repaymentEvery = this.getRepaymentEvery();
        final java.lang.Object other$repaymentEvery = other.getRepaymentEvery();
        if (this$repaymentEvery == null ? other$repaymentEvery != null : !this$repaymentEvery.equals(other$repaymentEvery)) return false;
        final java.lang.Object this$fixedLength = this.getFixedLength();
        final java.lang.Object other$fixedLength = other.getFixedLength();
        if (this$fixedLength == null ? other$fixedLength != null : !this$fixedLength.equals(other$fixedLength)) return false;
        final java.lang.Object this$allowPartialPeriodInterestCalculation = this.getAllowPartialPeriodInterestCalculation();
        final java.lang.Object other$allowPartialPeriodInterestCalculation = other.getAllowPartialPeriodInterestCalculation();
        if (this$allowPartialPeriodInterestCalculation == null ? other$allowPartialPeriodInterestCalculation != null : !this$allowPartialPeriodInterestCalculation.equals(other$allowPartialPeriodInterestCalculation)) return false;
        final java.lang.Object this$graceOnPrincipalPayment = this.getGraceOnPrincipalPayment();
        final java.lang.Object other$graceOnPrincipalPayment = other.getGraceOnPrincipalPayment();
        if (this$graceOnPrincipalPayment == null ? other$graceOnPrincipalPayment != null : !this$graceOnPrincipalPayment.equals(other$graceOnPrincipalPayment)) return false;
        final java.lang.Object this$recurringMoratoriumOnPrincipalPeriods = this.getRecurringMoratoriumOnPrincipalPeriods();
        final java.lang.Object other$recurringMoratoriumOnPrincipalPeriods = other.getRecurringMoratoriumOnPrincipalPeriods();
        if (this$recurringMoratoriumOnPrincipalPeriods == null ? other$recurringMoratoriumOnPrincipalPeriods != null : !this$recurringMoratoriumOnPrincipalPeriods.equals(other$recurringMoratoriumOnPrincipalPeriods)) return false;
        final java.lang.Object this$graceOnInterestPayment = this.getGraceOnInterestPayment();
        final java.lang.Object other$graceOnInterestPayment = other.getGraceOnInterestPayment();
        if (this$graceOnInterestPayment == null ? other$graceOnInterestPayment != null : !this$graceOnInterestPayment.equals(other$graceOnInterestPayment)) return false;
        final java.lang.Object this$graceOnInterestCharged = this.getGraceOnInterestCharged();
        final java.lang.Object other$graceOnInterestCharged = other.getGraceOnInterestCharged();
        if (this$graceOnInterestCharged == null ? other$graceOnInterestCharged != null : !this$graceOnInterestCharged.equals(other$graceOnInterestCharged)) return false;
        final java.lang.Object this$graceOnArrearsAgeing = this.getGraceOnArrearsAgeing();
        final java.lang.Object other$graceOnArrearsAgeing = other.getGraceOnArrearsAgeing();
        if (this$graceOnArrearsAgeing == null ? other$graceOnArrearsAgeing != null : !this$graceOnArrearsAgeing.equals(other$graceOnArrearsAgeing)) return false;
        final java.lang.Object this$syncDisbursementWithMeeting = this.getSyncDisbursementWithMeeting();
        final java.lang.Object other$syncDisbursementWithMeeting = other.getSyncDisbursementWithMeeting();
        if (this$syncDisbursementWithMeeting == null ? other$syncDisbursementWithMeeting != null : !this$syncDisbursementWithMeeting.equals(other$syncDisbursementWithMeeting)) return false;
        final java.lang.Object this$disallowExpectedDisbursements = this.getDisallowExpectedDisbursements();
        final java.lang.Object other$disallowExpectedDisbursements = other.getDisallowExpectedDisbursements();
        if (this$disallowExpectedDisbursements == null ? other$disallowExpectedDisbursements != null : !this$disallowExpectedDisbursements.equals(other$disallowExpectedDisbursements)) return false;
        final java.lang.Object this$loanCounter = this.getLoanCounter();
        final java.lang.Object other$loanCounter = other.getLoanCounter();
        if (this$loanCounter == null ? other$loanCounter != null : !this$loanCounter.equals(other$loanCounter)) return false;
        final java.lang.Object this$loanProductCounter = this.getLoanProductCounter();
        final java.lang.Object other$loanProductCounter = other.getLoanProductCounter();
        if (this$loanProductCounter == null ? other$loanProductCounter != null : !this$loanProductCounter.equals(other$loanProductCounter)) return false;
        final java.lang.Object this$multiDisburseLoan = this.getMultiDisburseLoan();
        final java.lang.Object other$multiDisburseLoan = other.getMultiDisburseLoan();
        if (this$multiDisburseLoan == null ? other$multiDisburseLoan != null : !this$multiDisburseLoan.equals(other$multiDisburseLoan)) return false;
        final java.lang.Object this$canDefineInstallmentAmount = this.getCanDefineInstallmentAmount();
        final java.lang.Object other$canDefineInstallmentAmount = other.getCanDefineInstallmentAmount();
        if (this$canDefineInstallmentAmount == null ? other$canDefineInstallmentAmount != null : !this$canDefineInstallmentAmount.equals(other$canDefineInstallmentAmount)) return false;
        final java.lang.Object this$canDisburse = this.getCanDisburse();
        final java.lang.Object other$canDisburse = other.getCanDisburse();
        if (this$canDisburse == null ? other$canDisburse != null : !this$canDisburse.equals(other$canDisburse)) return false;
        final java.lang.Object this$canUseForTopup = this.getCanUseForTopup();
        final java.lang.Object other$canUseForTopup = other.getCanUseForTopup();
        if (this$canUseForTopup == null ? other$canUseForTopup != null : !this$canUseForTopup.equals(other$canUseForTopup)) return false;
        final java.lang.Object this$closureLoanId = this.getClosureLoanId();
        final java.lang.Object other$closureLoanId = other.getClosureLoanId();
        if (this$closureLoanId == null ? other$closureLoanId != null : !this$closureLoanId.equals(other$closureLoanId)) return false;
        final java.lang.Object this$inArrears = this.getInArrears();
        final java.lang.Object other$inArrears = other.getInArrears();
        if (this$inArrears == null ? other$inArrears != null : !this$inArrears.equals(other$inArrears)) return false;
        final java.lang.Object this$isNPA = this.getIsNPA();
        final java.lang.Object other$isNPA = other.getIsNPA();
        if (this$isNPA == null ? other$isNPA != null : !this$isNPA.equals(other$isNPA)) return false;
        final java.lang.Object this$createStandingInstructionAtDisbursement = this.getCreateStandingInstructionAtDisbursement();
        final java.lang.Object other$createStandingInstructionAtDisbursement = other.getCreateStandingInstructionAtDisbursement();
        if (this$createStandingInstructionAtDisbursement == null ? other$createStandingInstructionAtDisbursement != null : !this$createStandingInstructionAtDisbursement.equals(other$createStandingInstructionAtDisbursement)) return false;
        final java.lang.Object this$isVariableInstallmentsAllowed = this.getIsVariableInstallmentsAllowed();
        final java.lang.Object other$isVariableInstallmentsAllowed = other.getIsVariableInstallmentsAllowed();
        if (this$isVariableInstallmentsAllowed == null ? other$isVariableInstallmentsAllowed != null : !this$isVariableInstallmentsAllowed.equals(other$isVariableInstallmentsAllowed)) return false;
        final java.lang.Object this$minimumGap = this.getMinimumGap();
        final java.lang.Object other$minimumGap = other.getMinimumGap();
        if (this$minimumGap == null ? other$minimumGap != null : !this$minimumGap.equals(other$minimumGap)) return false;
        final java.lang.Object this$maximumGap = this.getMaximumGap();
        final java.lang.Object other$maximumGap = other.getMaximumGap();
        if (this$maximumGap == null ? other$maximumGap != null : !this$maximumGap.equals(other$maximumGap)) return false;
        final java.lang.Object this$isEqualAmortization = this.getIsEqualAmortization();
        final java.lang.Object other$isEqualAmortization = other.getIsEqualAmortization();
        if (this$isEqualAmortization == null ? other$isEqualAmortization != null : !this$isEqualAmortization.equals(other$isEqualAmortization)) return false;
        final java.lang.Object this$isRatesEnabled = this.getIsRatesEnabled();
        final java.lang.Object other$isRatesEnabled = other.getIsRatesEnabled();
        if (this$isRatesEnabled == null ? other$isRatesEnabled != null : !this$isRatesEnabled.equals(other$isRatesEnabled)) return false;
        final java.lang.Object this$productId = this.getProductId();
        final java.lang.Object other$productId = other.getProductId();
        if (this$productId == null ? other$productId != null : !this$productId.equals(other$productId)) return false;
        final java.lang.Object this$loanTermFrequency = this.getLoanTermFrequency();
        final java.lang.Object other$loanTermFrequency = other.getLoanTermFrequency();
        if (this$loanTermFrequency == null ? other$loanTermFrequency != null : !this$loanTermFrequency.equals(other$loanTermFrequency)) return false;
        final java.lang.Object this$groupId = this.getGroupId();
        final java.lang.Object other$groupId = other.getGroupId();
        if (this$groupId == null ? other$groupId != null : !this$groupId.equals(other$groupId)) return false;
        final java.lang.Object this$enableInstallmentLevelDelinquency = this.getEnableInstallmentLevelDelinquency();
        final java.lang.Object other$enableInstallmentLevelDelinquency = other.getEnableInstallmentLevelDelinquency();
        if (this$enableInstallmentLevelDelinquency == null ? other$enableInstallmentLevelDelinquency != null : !this$enableInstallmentLevelDelinquency.equals(other$enableInstallmentLevelDelinquency)) return false;
        final java.lang.Object this$chargedOff = this.getChargedOff();
        final java.lang.Object other$chargedOff = other.getChargedOff();
        if (this$chargedOff == null ? other$chargedOff != null : !this$chargedOff.equals(other$chargedOff)) return false;
        final java.lang.Object this$allowFullTermForTranche = this.getAllowFullTermForTranche();
        final java.lang.Object other$allowFullTermForTranche = other.getAllowFullTermForTranche();
        if (this$allowFullTermForTranche == null ? other$allowFullTermForTranche != null : !this$allowFullTermForTranche.equals(other$allowFullTermForTranche)) return false;
        final java.lang.Object this$enableDownPayment = this.getEnableDownPayment();
        final java.lang.Object other$enableDownPayment = other.getEnableDownPayment();
        if (this$enableDownPayment == null ? other$enableDownPayment != null : !this$enableDownPayment.equals(other$enableDownPayment)) return false;
        final java.lang.Object this$enableAutoRepaymentForDownPayment = this.getEnableAutoRepaymentForDownPayment();
        final java.lang.Object other$enableAutoRepaymentForDownPayment = other.getEnableAutoRepaymentForDownPayment();
        if (this$enableAutoRepaymentForDownPayment == null ? other$enableAutoRepaymentForDownPayment != null : !this$enableAutoRepaymentForDownPayment.equals(other$enableAutoRepaymentForDownPayment)) return false;
        final java.lang.Object this$interestRecognitionOnDisbursementDate = this.getInterestRecognitionOnDisbursementDate();
        final java.lang.Object other$interestRecognitionOnDisbursementDate = other.getInterestRecognitionOnDisbursementDate();
        if (this$interestRecognitionOnDisbursementDate == null ? other$interestRecognitionOnDisbursementDate != null : !this$interestRecognitionOnDisbursementDate.equals(other$interestRecognitionOnDisbursementDate)) return false;
        final java.lang.Object this$enableIncomeCapitalization = this.getEnableIncomeCapitalization();
        final java.lang.Object other$enableIncomeCapitalization = other.getEnableIncomeCapitalization();
        if (this$enableIncomeCapitalization == null ? other$enableIncomeCapitalization != null : !this$enableIncomeCapitalization.equals(other$enableIncomeCapitalization)) return false;
        final java.lang.Object this$enableBuyDownFee = this.getEnableBuyDownFee();
        final java.lang.Object other$enableBuyDownFee = other.getEnableBuyDownFee();
        if (this$enableBuyDownFee == null ? other$enableBuyDownFee != null : !this$enableBuyDownFee.equals(other$enableBuyDownFee)) return false;
        final java.lang.Object this$merchantBuyDownFee = this.getMerchantBuyDownFee();
        final java.lang.Object other$merchantBuyDownFee = other.getMerchantBuyDownFee();
        if (this$merchantBuyDownFee == null ? other$merchantBuyDownFee != null : !this$merchantBuyDownFee.equals(other$merchantBuyDownFee)) return false;
        final java.lang.Object this$accountNo = this.getAccountNo();
        final java.lang.Object other$accountNo = other.getAccountNo();
        if (this$accountNo == null ? other$accountNo != null : !this$accountNo.equals(other$accountNo)) return false;
        final java.lang.Object this$externalId = this.getExternalId();
        final java.lang.Object other$externalId = other.getExternalId();
        if (this$externalId == null ? other$externalId != null : !this$externalId.equals(other$externalId)) return false;
        final java.lang.Object this$status = this.getStatus();
        final java.lang.Object other$status = other.getStatus();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        final java.lang.Object this$subStatus = this.getSubStatus();
        final java.lang.Object other$subStatus = other.getSubStatus();
        if (this$subStatus == null ? other$subStatus != null : !this$subStatus.equals(other$subStatus)) return false;
        final java.lang.Object this$clientAccountNo = this.getClientAccountNo();
        final java.lang.Object other$clientAccountNo = other.getClientAccountNo();
        if (this$clientAccountNo == null ? other$clientAccountNo != null : !this$clientAccountNo.equals(other$clientAccountNo)) return false;
        final java.lang.Object this$clientName = this.getClientName();
        final java.lang.Object other$clientName = other.getClientName();
        if (this$clientName == null ? other$clientName != null : !this$clientName.equals(other$clientName)) return false;
        final java.lang.Object this$clientExternalId = this.getClientExternalId();
        final java.lang.Object other$clientExternalId = other.getClientExternalId();
        if (this$clientExternalId == null ? other$clientExternalId != null : !this$clientExternalId.equals(other$clientExternalId)) return false;
        final java.lang.Object this$group = this.getGroup();
        final java.lang.Object other$group = other.getGroup();
        if (this$group == null ? other$group != null : !this$group.equals(other$group)) return false;
        final java.lang.Object this$loanProductName = this.getLoanProductName();
        final java.lang.Object other$loanProductName = other.getLoanProductName();
        if (this$loanProductName == null ? other$loanProductName != null : !this$loanProductName.equals(other$loanProductName)) return false;
        final java.lang.Object this$loanProductDescription = this.getLoanProductDescription();
        final java.lang.Object other$loanProductDescription = other.getLoanProductDescription();
        if (this$loanProductDescription == null ? other$loanProductDescription != null : !this$loanProductDescription.equals(other$loanProductDescription)) return false;
        final java.lang.Object this$fundName = this.getFundName();
        final java.lang.Object other$fundName = other.getFundName();
        if (this$fundName == null ? other$fundName != null : !this$fundName.equals(other$fundName)) return false;
        final java.lang.Object this$loanPurposeName = this.getLoanPurposeName();
        final java.lang.Object other$loanPurposeName = other.getLoanPurposeName();
        if (this$loanPurposeName == null ? other$loanPurposeName != null : !this$loanPurposeName.equals(other$loanPurposeName)) return false;
        final java.lang.Object this$loanOfficerName = this.getLoanOfficerName();
        final java.lang.Object other$loanOfficerName = other.getLoanOfficerName();
        if (this$loanOfficerName == null ? other$loanOfficerName != null : !this$loanOfficerName.equals(other$loanOfficerName)) return false;
        final java.lang.Object this$loanType = this.getLoanType();
        final java.lang.Object other$loanType = other.getLoanType();
        if (this$loanType == null ? other$loanType != null : !this$loanType.equals(other$loanType)) return false;
        final java.lang.Object this$currency = this.getCurrency();
        final java.lang.Object other$currency = other.getCurrency();
        if (this$currency == null ? other$currency != null : !this$currency.equals(other$currency)) return false;
        final java.lang.Object this$principal = this.getPrincipal();
        final java.lang.Object other$principal = other.getPrincipal();
        if (this$principal == null ? other$principal != null : !this$principal.equals(other$principal)) return false;
        final java.lang.Object this$approvedPrincipal = this.getApprovedPrincipal();
        final java.lang.Object other$approvedPrincipal = other.getApprovedPrincipal();
        if (this$approvedPrincipal == null ? other$approvedPrincipal != null : !this$approvedPrincipal.equals(other$approvedPrincipal)) return false;
        final java.lang.Object this$proposedPrincipal = this.getProposedPrincipal();
        final java.lang.Object other$proposedPrincipal = other.getProposedPrincipal();
        if (this$proposedPrincipal == null ? other$proposedPrincipal != null : !this$proposedPrincipal.equals(other$proposedPrincipal)) return false;
        final java.lang.Object this$netDisbursalAmount = this.getNetDisbursalAmount();
        final java.lang.Object other$netDisbursalAmount = other.getNetDisbursalAmount();
        if (this$netDisbursalAmount == null ? other$netDisbursalAmount != null : !this$netDisbursalAmount.equals(other$netDisbursalAmount)) return false;
        final java.lang.Object this$termPeriodFrequencyType = this.getTermPeriodFrequencyType();
        final java.lang.Object other$termPeriodFrequencyType = other.getTermPeriodFrequencyType();
        if (this$termPeriodFrequencyType == null ? other$termPeriodFrequencyType != null : !this$termPeriodFrequencyType.equals(other$termPeriodFrequencyType)) return false;
        final java.lang.Object this$repaymentFrequencyType = this.getRepaymentFrequencyType();
        final java.lang.Object other$repaymentFrequencyType = other.getRepaymentFrequencyType();
        if (this$repaymentFrequencyType == null ? other$repaymentFrequencyType != null : !this$repaymentFrequencyType.equals(other$repaymentFrequencyType)) return false;
        final java.lang.Object this$repaymentFrequencyNthDayType = this.getRepaymentFrequencyNthDayType();
        final java.lang.Object other$repaymentFrequencyNthDayType = other.getRepaymentFrequencyNthDayType();
        if (this$repaymentFrequencyNthDayType == null ? other$repaymentFrequencyNthDayType != null : !this$repaymentFrequencyNthDayType.equals(other$repaymentFrequencyNthDayType)) return false;
        final java.lang.Object this$repaymentFrequencyDayOfWeekType = this.getRepaymentFrequencyDayOfWeekType();
        final java.lang.Object other$repaymentFrequencyDayOfWeekType = other.getRepaymentFrequencyDayOfWeekType();
        if (this$repaymentFrequencyDayOfWeekType == null ? other$repaymentFrequencyDayOfWeekType != null : !this$repaymentFrequencyDayOfWeekType.equals(other$repaymentFrequencyDayOfWeekType)) return false;
        final java.lang.Object this$interestRatePerPeriod = this.getInterestRatePerPeriod();
        final java.lang.Object other$interestRatePerPeriod = other.getInterestRatePerPeriod();
        if (this$interestRatePerPeriod == null ? other$interestRatePerPeriod != null : !this$interestRatePerPeriod.equals(other$interestRatePerPeriod)) return false;
        final java.lang.Object this$interestRateFrequencyType = this.getInterestRateFrequencyType();
        final java.lang.Object other$interestRateFrequencyType = other.getInterestRateFrequencyType();
        if (this$interestRateFrequencyType == null ? other$interestRateFrequencyType != null : !this$interestRateFrequencyType.equals(other$interestRateFrequencyType)) return false;
        final java.lang.Object this$annualInterestRate = this.getAnnualInterestRate();
        final java.lang.Object other$annualInterestRate = other.getAnnualInterestRate();
        if (this$annualInterestRate == null ? other$annualInterestRate != null : !this$annualInterestRate.equals(other$annualInterestRate)) return false;
        final java.lang.Object this$interestRateDifferential = this.getInterestRateDifferential();
        final java.lang.Object other$interestRateDifferential = other.getInterestRateDifferential();
        if (this$interestRateDifferential == null ? other$interestRateDifferential != null : !this$interestRateDifferential.equals(other$interestRateDifferential)) return false;
        final java.lang.Object this$amortizationType = this.getAmortizationType();
        final java.lang.Object other$amortizationType = other.getAmortizationType();
        if (this$amortizationType == null ? other$amortizationType != null : !this$amortizationType.equals(other$amortizationType)) return false;
        final java.lang.Object this$interestType = this.getInterestType();
        final java.lang.Object other$interestType = other.getInterestType();
        if (this$interestType == null ? other$interestType != null : !this$interestType.equals(other$interestType)) return false;
        final java.lang.Object this$interestCalculationPeriodType = this.getInterestCalculationPeriodType();
        final java.lang.Object other$interestCalculationPeriodType = other.getInterestCalculationPeriodType();
        if (this$interestCalculationPeriodType == null ? other$interestCalculationPeriodType != null : !this$interestCalculationPeriodType.equals(other$interestCalculationPeriodType)) return false;
        final java.lang.Object this$inArrearsTolerance = this.getInArrearsTolerance();
        final java.lang.Object other$inArrearsTolerance = other.getInArrearsTolerance();
        if (this$inArrearsTolerance == null ? other$inArrearsTolerance != null : !this$inArrearsTolerance.equals(other$inArrearsTolerance)) return false;
        final java.lang.Object this$transactionProcessingStrategyCode = this.getTransactionProcessingStrategyCode();
        final java.lang.Object other$transactionProcessingStrategyCode = other.getTransactionProcessingStrategyCode();
        if (this$transactionProcessingStrategyCode == null ? other$transactionProcessingStrategyCode != null : !this$transactionProcessingStrategyCode.equals(other$transactionProcessingStrategyCode)) return false;
        final java.lang.Object this$transactionProcessingStrategyName = this.getTransactionProcessingStrategyName();
        final java.lang.Object other$transactionProcessingStrategyName = other.getTransactionProcessingStrategyName();
        if (this$transactionProcessingStrategyName == null ? other$transactionProcessingStrategyName != null : !this$transactionProcessingStrategyName.equals(other$transactionProcessingStrategyName)) return false;
        final java.lang.Object this$interestChargedFromDate = this.getInterestChargedFromDate();
        final java.lang.Object other$interestChargedFromDate = other.getInterestChargedFromDate();
        if (this$interestChargedFromDate == null ? other$interestChargedFromDate != null : !this$interestChargedFromDate.equals(other$interestChargedFromDate)) return false;
        final java.lang.Object this$expectedFirstRepaymentOnDate = this.getExpectedFirstRepaymentOnDate();
        final java.lang.Object other$expectedFirstRepaymentOnDate = other.getExpectedFirstRepaymentOnDate();
        if (this$expectedFirstRepaymentOnDate == null ? other$expectedFirstRepaymentOnDate != null : !this$expectedFirstRepaymentOnDate.equals(other$expectedFirstRepaymentOnDate)) return false;
        final java.lang.Object this$timeline = this.getTimeline();
        final java.lang.Object other$timeline = other.getTimeline();
        if (this$timeline == null ? other$timeline != null : !this$timeline.equals(other$timeline)) return false;
        final java.lang.Object this$summary = this.getSummary();
        final java.lang.Object other$summary = other.getSummary();
        if (this$summary == null ? other$summary != null : !this$summary.equals(other$summary)) return false;
        final java.lang.Object this$repaymentSchedule = this.getRepaymentSchedule();
        final java.lang.Object other$repaymentSchedule = other.getRepaymentSchedule();
        if (this$repaymentSchedule == null ? other$repaymentSchedule != null : !this$repaymentSchedule.equals(other$repaymentSchedule)) return false;
        final java.lang.Object this$transactions = this.getTransactions();
        final java.lang.Object other$transactions = other.getTransactions();
        if (this$transactions == null ? other$transactions != null : !this$transactions.equals(other$transactions)) return false;
        final java.lang.Object this$charges = this.getCharges();
        final java.lang.Object other$charges = other.getCharges();
        if (this$charges == null ? other$charges != null : !this$charges.equals(other$charges)) return false;
        final java.lang.Object this$collateral = this.getCollateral();
        final java.lang.Object other$collateral = other.getCollateral();
        if (this$collateral == null ? other$collateral != null : !this$collateral.equals(other$collateral)) return false;
        final java.lang.Object this$guarantors = this.getGuarantors();
        final java.lang.Object other$guarantors = other.getGuarantors();
        if (this$guarantors == null ? other$guarantors != null : !this$guarantors.equals(other$guarantors)) return false;
        final java.lang.Object this$meeting = this.getMeeting();
        final java.lang.Object other$meeting = other.getMeeting();
        if (this$meeting == null ? other$meeting != null : !this$meeting.equals(other$meeting)) return false;
        final java.lang.Object this$notes = this.getNotes();
        final java.lang.Object other$notes = other.getNotes();
        if (this$notes == null ? other$notes != null : !this$notes.equals(other$notes)) return false;
        final java.lang.Object this$disbursementDetails = this.getDisbursementDetails();
        final java.lang.Object other$disbursementDetails = other.getDisbursementDetails();
        if (this$disbursementDetails == null ? other$disbursementDetails != null : !this$disbursementDetails.equals(other$disbursementDetails)) return false;
        final java.lang.Object this$originalSchedule = this.getOriginalSchedule();
        final java.lang.Object other$originalSchedule = other.getOriginalSchedule();
        if (this$originalSchedule == null ? other$originalSchedule != null : !this$originalSchedule.equals(other$originalSchedule)) return false;
        final java.lang.Object this$originators = this.getOriginators();
        final java.lang.Object other$originators = other.getOriginators();
        if (this$originators == null ? other$originators != null : !this$originators.equals(other$originators)) return false;
        final java.lang.Object this$productOptions = this.getProductOptions();
        final java.lang.Object other$productOptions = other.getProductOptions();
        if (this$productOptions == null ? other$productOptions != null : !this$productOptions.equals(other$productOptions)) return false;
        final java.lang.Object this$loanOfficerOptions = this.getLoanOfficerOptions();
        final java.lang.Object other$loanOfficerOptions = other.getLoanOfficerOptions();
        if (this$loanOfficerOptions == null ? other$loanOfficerOptions != null : !this$loanOfficerOptions.equals(other$loanOfficerOptions)) return false;
        final java.lang.Object this$loanPurposeOptions = this.getLoanPurposeOptions();
        final java.lang.Object other$loanPurposeOptions = other.getLoanPurposeOptions();
        if (this$loanPurposeOptions == null ? other$loanPurposeOptions != null : !this$loanPurposeOptions.equals(other$loanPurposeOptions)) return false;
        final java.lang.Object this$fundOptions = this.getFundOptions();
        final java.lang.Object other$fundOptions = other.getFundOptions();
        if (this$fundOptions == null ? other$fundOptions != null : !this$fundOptions.equals(other$fundOptions)) return false;
        final java.lang.Object this$termFrequencyTypeOptions = this.getTermFrequencyTypeOptions();
        final java.lang.Object other$termFrequencyTypeOptions = other.getTermFrequencyTypeOptions();
        if (this$termFrequencyTypeOptions == null ? other$termFrequencyTypeOptions != null : !this$termFrequencyTypeOptions.equals(other$termFrequencyTypeOptions)) return false;
        final java.lang.Object this$repaymentFrequencyTypeOptions = this.getRepaymentFrequencyTypeOptions();
        final java.lang.Object other$repaymentFrequencyTypeOptions = other.getRepaymentFrequencyTypeOptions();
        if (this$repaymentFrequencyTypeOptions == null ? other$repaymentFrequencyTypeOptions != null : !this$repaymentFrequencyTypeOptions.equals(other$repaymentFrequencyTypeOptions)) return false;
        final java.lang.Object this$repaymentFrequencyNthDayTypeOptions = this.getRepaymentFrequencyNthDayTypeOptions();
        final java.lang.Object other$repaymentFrequencyNthDayTypeOptions = other.getRepaymentFrequencyNthDayTypeOptions();
        if (this$repaymentFrequencyNthDayTypeOptions == null ? other$repaymentFrequencyNthDayTypeOptions != null : !this$repaymentFrequencyNthDayTypeOptions.equals(other$repaymentFrequencyNthDayTypeOptions)) return false;
        final java.lang.Object this$repaymentFrequencyDaysOfWeekTypeOptions = this.getRepaymentFrequencyDaysOfWeekTypeOptions();
        final java.lang.Object other$repaymentFrequencyDaysOfWeekTypeOptions = other.getRepaymentFrequencyDaysOfWeekTypeOptions();
        if (this$repaymentFrequencyDaysOfWeekTypeOptions == null ? other$repaymentFrequencyDaysOfWeekTypeOptions != null : !this$repaymentFrequencyDaysOfWeekTypeOptions.equals(other$repaymentFrequencyDaysOfWeekTypeOptions)) return false;
        final java.lang.Object this$interestRateFrequencyTypeOptions = this.getInterestRateFrequencyTypeOptions();
        final java.lang.Object other$interestRateFrequencyTypeOptions = other.getInterestRateFrequencyTypeOptions();
        if (this$interestRateFrequencyTypeOptions == null ? other$interestRateFrequencyTypeOptions != null : !this$interestRateFrequencyTypeOptions.equals(other$interestRateFrequencyTypeOptions)) return false;
        final java.lang.Object this$amortizationTypeOptions = this.getAmortizationTypeOptions();
        final java.lang.Object other$amortizationTypeOptions = other.getAmortizationTypeOptions();
        if (this$amortizationTypeOptions == null ? other$amortizationTypeOptions != null : !this$amortizationTypeOptions.equals(other$amortizationTypeOptions)) return false;
        final java.lang.Object this$interestTypeOptions = this.getInterestTypeOptions();
        final java.lang.Object other$interestTypeOptions = other.getInterestTypeOptions();
        if (this$interestTypeOptions == null ? other$interestTypeOptions != null : !this$interestTypeOptions.equals(other$interestTypeOptions)) return false;
        final java.lang.Object this$interestCalculationPeriodTypeOptions = this.getInterestCalculationPeriodTypeOptions();
        final java.lang.Object other$interestCalculationPeriodTypeOptions = other.getInterestCalculationPeriodTypeOptions();
        if (this$interestCalculationPeriodTypeOptions == null ? other$interestCalculationPeriodTypeOptions != null : !this$interestCalculationPeriodTypeOptions.equals(other$interestCalculationPeriodTypeOptions)) return false;
        final java.lang.Object this$transactionProcessingStrategyOptions = this.getTransactionProcessingStrategyOptions();
        final java.lang.Object other$transactionProcessingStrategyOptions = other.getTransactionProcessingStrategyOptions();
        if (this$transactionProcessingStrategyOptions == null ? other$transactionProcessingStrategyOptions != null : !this$transactionProcessingStrategyOptions.equals(other$transactionProcessingStrategyOptions)) return false;
        final java.lang.Object this$chargeOptions = this.getChargeOptions();
        final java.lang.Object other$chargeOptions = other.getChargeOptions();
        if (this$chargeOptions == null ? other$chargeOptions != null : !this$chargeOptions.equals(other$chargeOptions)) return false;
        final java.lang.Object this$loanCollateralOptions = this.getLoanCollateralOptions();
        final java.lang.Object other$loanCollateralOptions = other.getLoanCollateralOptions();
        if (this$loanCollateralOptions == null ? other$loanCollateralOptions != null : !this$loanCollateralOptions.equals(other$loanCollateralOptions)) return false;
        final java.lang.Object this$calendarOptions = this.getCalendarOptions();
        final java.lang.Object other$calendarOptions = other.getCalendarOptions();
        if (this$calendarOptions == null ? other$calendarOptions != null : !this$calendarOptions.equals(other$calendarOptions)) return false;
        final java.lang.Object this$loanScheduleTypeOptions = this.getLoanScheduleTypeOptions();
        final java.lang.Object other$loanScheduleTypeOptions = other.getLoanScheduleTypeOptions();
        if (this$loanScheduleTypeOptions == null ? other$loanScheduleTypeOptions != null : !this$loanScheduleTypeOptions.equals(other$loanScheduleTypeOptions)) return false;
        final java.lang.Object this$loanScheduleProcessingTypeOptions = this.getLoanScheduleProcessingTypeOptions();
        final java.lang.Object other$loanScheduleProcessingTypeOptions = other.getLoanScheduleProcessingTypeOptions();
        if (this$loanScheduleProcessingTypeOptions == null ? other$loanScheduleProcessingTypeOptions != null : !this$loanScheduleProcessingTypeOptions.equals(other$loanScheduleProcessingTypeOptions)) return false;
        final java.lang.Object this$daysInYearCustomStrategyOptions = this.getDaysInYearCustomStrategyOptions();
        final java.lang.Object other$daysInYearCustomStrategyOptions = other.getDaysInYearCustomStrategyOptions();
        if (this$daysInYearCustomStrategyOptions == null ? other$daysInYearCustomStrategyOptions != null : !this$daysInYearCustomStrategyOptions.equals(other$daysInYearCustomStrategyOptions)) return false;
        final java.lang.Object this$capitalizedIncomeCalculationTypeOptions = this.getCapitalizedIncomeCalculationTypeOptions();
        final java.lang.Object other$capitalizedIncomeCalculationTypeOptions = other.getCapitalizedIncomeCalculationTypeOptions();
        if (this$capitalizedIncomeCalculationTypeOptions == null ? other$capitalizedIncomeCalculationTypeOptions != null : !this$capitalizedIncomeCalculationTypeOptions.equals(other$capitalizedIncomeCalculationTypeOptions)) return false;
        final java.lang.Object this$capitalizedIncomeStrategyOptions = this.getCapitalizedIncomeStrategyOptions();
        final java.lang.Object other$capitalizedIncomeStrategyOptions = other.getCapitalizedIncomeStrategyOptions();
        if (this$capitalizedIncomeStrategyOptions == null ? other$capitalizedIncomeStrategyOptions != null : !this$capitalizedIncomeStrategyOptions.equals(other$capitalizedIncomeStrategyOptions)) return false;
        final java.lang.Object this$capitalizedIncomeTypeOptions = this.getCapitalizedIncomeTypeOptions();
        final java.lang.Object other$capitalizedIncomeTypeOptions = other.getCapitalizedIncomeTypeOptions();
        if (this$capitalizedIncomeTypeOptions == null ? other$capitalizedIncomeTypeOptions != null : !this$capitalizedIncomeTypeOptions.equals(other$capitalizedIncomeTypeOptions)) return false;
        final java.lang.Object this$buyDownFeeCalculationTypeOptions = this.getBuyDownFeeCalculationTypeOptions();
        final java.lang.Object other$buyDownFeeCalculationTypeOptions = other.getBuyDownFeeCalculationTypeOptions();
        if (this$buyDownFeeCalculationTypeOptions == null ? other$buyDownFeeCalculationTypeOptions != null : !this$buyDownFeeCalculationTypeOptions.equals(other$buyDownFeeCalculationTypeOptions)) return false;
        final java.lang.Object this$buyDownFeeStrategyOptions = this.getBuyDownFeeStrategyOptions();
        final java.lang.Object other$buyDownFeeStrategyOptions = other.getBuyDownFeeStrategyOptions();
        if (this$buyDownFeeStrategyOptions == null ? other$buyDownFeeStrategyOptions != null : !this$buyDownFeeStrategyOptions.equals(other$buyDownFeeStrategyOptions)) return false;
        final java.lang.Object this$buyDownFeeIncomeTypeOptions = this.getBuyDownFeeIncomeTypeOptions();
        final java.lang.Object other$buyDownFeeIncomeTypeOptions = other.getBuyDownFeeIncomeTypeOptions();
        if (this$buyDownFeeIncomeTypeOptions == null ? other$buyDownFeeIncomeTypeOptions != null : !this$buyDownFeeIncomeTypeOptions.equals(other$buyDownFeeIncomeTypeOptions)) return false;
        final java.lang.Object this$feeChargesAtDisbursementCharged = this.getFeeChargesAtDisbursementCharged();
        final java.lang.Object other$feeChargesAtDisbursementCharged = other.getFeeChargesAtDisbursementCharged();
        if (this$feeChargesAtDisbursementCharged == null ? other$feeChargesAtDisbursementCharged != null : !this$feeChargesAtDisbursementCharged.equals(other$feeChargesAtDisbursementCharged)) return false;
        final java.lang.Object this$totalOverpaid = this.getTotalOverpaid();
        final java.lang.Object other$totalOverpaid = other.getTotalOverpaid();
        if (this$totalOverpaid == null ? other$totalOverpaid != null : !this$totalOverpaid.equals(other$totalOverpaid)) return false;
        final java.lang.Object this$linkedAccount = this.getLinkedAccount();
        final java.lang.Object other$linkedAccount = other.getLinkedAccount();
        if (this$linkedAccount == null ? other$linkedAccount != null : !this$linkedAccount.equals(other$linkedAccount)) return false;
        final java.lang.Object this$accountLinkingOptions = this.getAccountLinkingOptions();
        final java.lang.Object other$accountLinkingOptions = other.getAccountLinkingOptions();
        if (this$accountLinkingOptions == null ? other$accountLinkingOptions != null : !this$accountLinkingOptions.equals(other$accountLinkingOptions)) return false;
        final java.lang.Object this$fixedEmiAmount = this.getFixedEmiAmount();
        final java.lang.Object other$fixedEmiAmount = other.getFixedEmiAmount();
        if (this$fixedEmiAmount == null ? other$fixedEmiAmount != null : !this$fixedEmiAmount.equals(other$fixedEmiAmount)) return false;
        final java.lang.Object this$maxOutstandingLoanBalance = this.getMaxOutstandingLoanBalance();
        final java.lang.Object other$maxOutstandingLoanBalance = other.getMaxOutstandingLoanBalance();
        if (this$maxOutstandingLoanBalance == null ? other$maxOutstandingLoanBalance != null : !this$maxOutstandingLoanBalance.equals(other$maxOutstandingLoanBalance)) return false;
        final java.lang.Object this$emiAmountVariations = this.getEmiAmountVariations();
        final java.lang.Object other$emiAmountVariations = other.getEmiAmountVariations();
        if (this$emiAmountVariations == null ? other$emiAmountVariations != null : !this$emiAmountVariations.equals(other$emiAmountVariations)) return false;
        final java.lang.Object this$loanTermVariations = this.getLoanTermVariations();
        final java.lang.Object other$loanTermVariations = other.getLoanTermVariations();
        if (this$loanTermVariations == null ? other$loanTermVariations != null : !this$loanTermVariations.equals(other$loanTermVariations)) return false;
        final java.lang.Object this$clientActiveLoanOptions = this.getClientActiveLoanOptions();
        final java.lang.Object other$clientActiveLoanOptions = other.getClientActiveLoanOptions();
        if (this$clientActiveLoanOptions == null ? other$clientActiveLoanOptions != null : !this$clientActiveLoanOptions.equals(other$clientActiveLoanOptions)) return false;
        final java.lang.Object this$closureLoanAccountNo = this.getClosureLoanAccountNo();
        final java.lang.Object other$closureLoanAccountNo = other.getClosureLoanAccountNo();
        if (this$closureLoanAccountNo == null ? other$closureLoanAccountNo != null : !this$closureLoanAccountNo.equals(other$closureLoanAccountNo)) return false;
        final java.lang.Object this$topupAmount = this.getTopupAmount();
        final java.lang.Object other$topupAmount = other.getTopupAmount();
        if (this$topupAmount == null ? other$topupAmount != null : !this$topupAmount.equals(other$topupAmount)) return false;
        final java.lang.Object this$product = this.getProduct();
        final java.lang.Object other$product = other.getProduct();
        if (this$product == null ? other$product != null : !this$product.equals(other$product)) return false;
        final java.lang.Object this$memberVariations = this.getMemberVariations();
        final java.lang.Object other$memberVariations = other.getMemberVariations();
        if (this$memberVariations == null ? other$memberVariations != null : !this$memberVariations.equals(other$memberVariations)) return false;
        final java.lang.Object this$overdueCharges = this.getOverdueCharges();
        final java.lang.Object other$overdueCharges = other.getOverdueCharges();
        if (this$overdueCharges == null ? other$overdueCharges != null : !this$overdueCharges.equals(other$overdueCharges)) return false;
        final java.lang.Object this$daysInMonthType = this.getDaysInMonthType();
        final java.lang.Object other$daysInMonthType = other.getDaysInMonthType();
        if (this$daysInMonthType == null ? other$daysInMonthType != null : !this$daysInMonthType.equals(other$daysInMonthType)) return false;
        final java.lang.Object this$daysInYearType = this.getDaysInYearType();
        final java.lang.Object other$daysInYearType = other.getDaysInYearType();
        if (this$daysInYearType == null ? other$daysInYearType != null : !this$daysInYearType.equals(other$daysInYearType)) return false;
        final java.lang.Object this$daysInYearCustomStrategy = this.getDaysInYearCustomStrategy();
        final java.lang.Object other$daysInYearCustomStrategy = other.getDaysInYearCustomStrategy();
        if (this$daysInYearCustomStrategy == null ? other$daysInYearCustomStrategy != null : !this$daysInYearCustomStrategy.equals(other$daysInYearCustomStrategy)) return false;
        final java.lang.Object this$interestRecalculationData = this.getInterestRecalculationData();
        final java.lang.Object other$interestRecalculationData = other.getInterestRecalculationData();
        if (this$interestRecalculationData == null ? other$interestRecalculationData != null : !this$interestRecalculationData.equals(other$interestRecalculationData)) return false;
        final java.lang.Object this$paidInAdvance = this.getPaidInAdvance();
        final java.lang.Object other$paidInAdvance = other.getPaidInAdvance();
        if (this$paidInAdvance == null ? other$paidInAdvance != null : !this$paidInAdvance.equals(other$paidInAdvance)) return false;
        final java.lang.Object this$interestRatesPeriods = this.getInterestRatesPeriods();
        final java.lang.Object other$interestRatesPeriods = other.getInterestRatesPeriods();
        if (this$interestRatesPeriods == null ? other$interestRatesPeriods != null : !this$interestRatesPeriods.equals(other$interestRatesPeriods)) return false;
        final java.lang.Object this$datatables = this.getDatatables();
        final java.lang.Object other$datatables = other.getDatatables();
        if (this$datatables == null ? other$datatables != null : !this$datatables.equals(other$datatables)) return false;
        final java.lang.Object this$fixedPrincipalPercentagePerInstallment = this.getFixedPrincipalPercentagePerInstallment();
        final java.lang.Object other$fixedPrincipalPercentagePerInstallment = other.getFixedPrincipalPercentagePerInstallment();
        if (this$fixedPrincipalPercentagePerInstallment == null ? other$fixedPrincipalPercentagePerInstallment != null : !this$fixedPrincipalPercentagePerInstallment.equals(other$fixedPrincipalPercentagePerInstallment)) return false;
        final java.lang.Object this$rates = this.getRates();
        final java.lang.Object other$rates = other.getRates();
        if (this$rates == null ? other$rates != null : !this$rates.equals(other$rates)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$submittedOnDate = this.getSubmittedOnDate();
        final java.lang.Object other$submittedOnDate = other.getSubmittedOnDate();
        if (this$submittedOnDate == null ? other$submittedOnDate != null : !this$submittedOnDate.equals(other$submittedOnDate)) return false;
        final java.lang.Object this$loanTermFrequencyType = this.getLoanTermFrequencyType();
        final java.lang.Object other$loanTermFrequencyType = other.getLoanTermFrequencyType();
        if (this$loanTermFrequencyType == null ? other$loanTermFrequencyType != null : !this$loanTermFrequencyType.equals(other$loanTermFrequencyType)) return false;
        final java.lang.Object this$repaymentsStartingFromDate = this.getRepaymentsStartingFromDate();
        final java.lang.Object other$repaymentsStartingFromDate = other.getRepaymentsStartingFromDate();
        if (this$repaymentsStartingFromDate == null ? other$repaymentsStartingFromDate != null : !this$repaymentsStartingFromDate.equals(other$repaymentsStartingFromDate)) return false;
        final java.lang.Object this$linkAccountId = this.getLinkAccountId();
        final java.lang.Object other$linkAccountId = other.getLinkAccountId();
        if (this$linkAccountId == null ? other$linkAccountId != null : !this$linkAccountId.equals(other$linkAccountId)) return false;
        final java.lang.Object this$expectedDisbursementDate = this.getExpectedDisbursementDate();
        final java.lang.Object other$expectedDisbursementDate = other.getExpectedDisbursementDate();
        if (this$expectedDisbursementDate == null ? other$expectedDisbursementDate != null : !this$expectedDisbursementDate.equals(other$expectedDisbursementDate)) return false;
        final java.lang.Object this$overpaidOnDate = this.getOverpaidOnDate();
        final java.lang.Object other$overpaidOnDate = other.getOverpaidOnDate();
        if (this$overpaidOnDate == null ? other$overpaidOnDate != null : !this$overpaidOnDate.equals(other$overpaidOnDate)) return false;
        final java.lang.Object this$delinquent = this.getDelinquent();
        final java.lang.Object other$delinquent = other.getDelinquent();
        if (this$delinquent == null ? other$delinquent != null : !this$delinquent.equals(other$delinquent)) return false;
        final java.lang.Object this$delinquencyRange = this.getDelinquencyRange();
        final java.lang.Object other$delinquencyRange = other.getDelinquencyRange();
        if (this$delinquencyRange == null ? other$delinquencyRange != null : !this$delinquencyRange.equals(other$delinquencyRange)) return false;
        final java.lang.Object this$lastClosedBusinessDate = this.getLastClosedBusinessDate();
        final java.lang.Object other$lastClosedBusinessDate = other.getLastClosedBusinessDate();
        if (this$lastClosedBusinessDate == null ? other$lastClosedBusinessDate != null : !this$lastClosedBusinessDate.equals(other$lastClosedBusinessDate)) return false;
        final java.lang.Object this$disbursedAmountPercentageForDownPayment = this.getDisbursedAmountPercentageForDownPayment();
        final java.lang.Object other$disbursedAmountPercentageForDownPayment = other.getDisbursedAmountPercentageForDownPayment();
        if (this$disbursedAmountPercentageForDownPayment == null ? other$disbursedAmountPercentageForDownPayment != null : !this$disbursedAmountPercentageForDownPayment.equals(other$disbursedAmountPercentageForDownPayment)) return false;
        final java.lang.Object this$repaymentStartDateType = this.getRepaymentStartDateType();
        final java.lang.Object other$repaymentStartDateType = other.getRepaymentStartDateType();
        if (this$repaymentStartDateType == null ? other$repaymentStartDateType != null : !this$repaymentStartDateType.equals(other$repaymentStartDateType)) return false;
        final java.lang.Object this$loanScheduleType = this.getLoanScheduleType();
        final java.lang.Object other$loanScheduleType = other.getLoanScheduleType();
        if (this$loanScheduleType == null ? other$loanScheduleType != null : !this$loanScheduleType.equals(other$loanScheduleType)) return false;
        final java.lang.Object this$loanScheduleProcessingType = this.getLoanScheduleProcessingType();
        final java.lang.Object other$loanScheduleProcessingType = other.getLoanScheduleProcessingType();
        if (this$loanScheduleProcessingType == null ? other$loanScheduleProcessingType != null : !this$loanScheduleProcessingType.equals(other$loanScheduleProcessingType)) return false;
        final java.lang.Object this$chargeOffBehaviour = this.getChargeOffBehaviour();
        final java.lang.Object other$chargeOffBehaviour = other.getChargeOffBehaviour();
        if (this$chargeOffBehaviour == null ? other$chargeOffBehaviour != null : !this$chargeOffBehaviour.equals(other$chargeOffBehaviour)) return false;
        final java.lang.Object this$capitalizedIncomeCalculationType = this.getCapitalizedIncomeCalculationType();
        final java.lang.Object other$capitalizedIncomeCalculationType = other.getCapitalizedIncomeCalculationType();
        if (this$capitalizedIncomeCalculationType == null ? other$capitalizedIncomeCalculationType != null : !this$capitalizedIncomeCalculationType.equals(other$capitalizedIncomeCalculationType)) return false;
        final java.lang.Object this$capitalizedIncomeStrategy = this.getCapitalizedIncomeStrategy();
        final java.lang.Object other$capitalizedIncomeStrategy = other.getCapitalizedIncomeStrategy();
        if (this$capitalizedIncomeStrategy == null ? other$capitalizedIncomeStrategy != null : !this$capitalizedIncomeStrategy.equals(other$capitalizedIncomeStrategy)) return false;
        final java.lang.Object this$capitalizedIncomeType = this.getCapitalizedIncomeType();
        final java.lang.Object other$capitalizedIncomeType = other.getCapitalizedIncomeType();
        if (this$capitalizedIncomeType == null ? other$capitalizedIncomeType != null : !this$capitalizedIncomeType.equals(other$capitalizedIncomeType)) return false;
        final java.lang.Object this$buyDownFeeCalculationType = this.getBuyDownFeeCalculationType();
        final java.lang.Object other$buyDownFeeCalculationType = other.getBuyDownFeeCalculationType();
        if (this$buyDownFeeCalculationType == null ? other$buyDownFeeCalculationType != null : !this$buyDownFeeCalculationType.equals(other$buyDownFeeCalculationType)) return false;
        final java.lang.Object this$buyDownFeeStrategy = this.getBuyDownFeeStrategy();
        final java.lang.Object other$buyDownFeeStrategy = other.getBuyDownFeeStrategy();
        if (this$buyDownFeeStrategy == null ? other$buyDownFeeStrategy != null : !this$buyDownFeeStrategy.equals(other$buyDownFeeStrategy)) return false;
        final java.lang.Object this$buyDownFeeIncomeType = this.getBuyDownFeeIncomeType();
        final java.lang.Object other$buyDownFeeIncomeType = other.getBuyDownFeeIncomeType();
        if (this$buyDownFeeIncomeType == null ? other$buyDownFeeIncomeType != null : !this$buyDownFeeIncomeType.equals(other$buyDownFeeIncomeType)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanAccountData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isLoanProductLinkedToFloatingRate() ? 79 : 97);
        result = result * PRIME + (this.isFloatingInterestRate() ? 79 : 97);
        result = result * PRIME + (this.isTopup() ? 79 : 97);
        result = result * PRIME + (this.isFraud() ? 79 : 97);
        result = result * PRIME + (this.isInterestRecalculationEnabled() ? 79 : 97);
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $clientId = this.getClientId();
        result = result * PRIME + ($clientId == null ? 43 : $clientId.hashCode());
        final java.lang.Object $clientOfficeId = this.getClientOfficeId();
        result = result * PRIME + ($clientOfficeId == null ? 43 : $clientOfficeId.hashCode());
        final java.lang.Object $loanProductId = this.getLoanProductId();
        result = result * PRIME + ($loanProductId == null ? 43 : $loanProductId.hashCode());
        final java.lang.Object $fundId = this.getFundId();
        result = result * PRIME + ($fundId == null ? 43 : $fundId.hashCode());
        final java.lang.Object $loanPurposeId = this.getLoanPurposeId();
        result = result * PRIME + ($loanPurposeId == null ? 43 : $loanPurposeId.hashCode());
        final java.lang.Object $loanOfficerId = this.getLoanOfficerId();
        result = result * PRIME + ($loanOfficerId == null ? 43 : $loanOfficerId.hashCode());
        final java.lang.Object $termFrequency = this.getTermFrequency();
        result = result * PRIME + ($termFrequency == null ? 43 : $termFrequency.hashCode());
        final java.lang.Object $numberOfRepayments = this.getNumberOfRepayments();
        result = result * PRIME + ($numberOfRepayments == null ? 43 : $numberOfRepayments.hashCode());
        final java.lang.Object $actualNoTerm = this.getActualNoTerm();
        result = result * PRIME + ($actualNoTerm == null ? 43 : $actualNoTerm.hashCode());
        final java.lang.Object $repaymentEvery = this.getRepaymentEvery();
        result = result * PRIME + ($repaymentEvery == null ? 43 : $repaymentEvery.hashCode());
        final java.lang.Object $fixedLength = this.getFixedLength();
        result = result * PRIME + ($fixedLength == null ? 43 : $fixedLength.hashCode());
        final java.lang.Object $allowPartialPeriodInterestCalculation = this.getAllowPartialPeriodInterestCalculation();
        result = result * PRIME + ($allowPartialPeriodInterestCalculation == null ? 43 : $allowPartialPeriodInterestCalculation.hashCode());
        final java.lang.Object $graceOnPrincipalPayment = this.getGraceOnPrincipalPayment();
        result = result * PRIME + ($graceOnPrincipalPayment == null ? 43 : $graceOnPrincipalPayment.hashCode());
        final java.lang.Object $recurringMoratoriumOnPrincipalPeriods = this.getRecurringMoratoriumOnPrincipalPeriods();
        result = result * PRIME + ($recurringMoratoriumOnPrincipalPeriods == null ? 43 : $recurringMoratoriumOnPrincipalPeriods.hashCode());
        final java.lang.Object $graceOnInterestPayment = this.getGraceOnInterestPayment();
        result = result * PRIME + ($graceOnInterestPayment == null ? 43 : $graceOnInterestPayment.hashCode());
        final java.lang.Object $graceOnInterestCharged = this.getGraceOnInterestCharged();
        result = result * PRIME + ($graceOnInterestCharged == null ? 43 : $graceOnInterestCharged.hashCode());
        final java.lang.Object $graceOnArrearsAgeing = this.getGraceOnArrearsAgeing();
        result = result * PRIME + ($graceOnArrearsAgeing == null ? 43 : $graceOnArrearsAgeing.hashCode());
        final java.lang.Object $syncDisbursementWithMeeting = this.getSyncDisbursementWithMeeting();
        result = result * PRIME + ($syncDisbursementWithMeeting == null ? 43 : $syncDisbursementWithMeeting.hashCode());
        final java.lang.Object $disallowExpectedDisbursements = this.getDisallowExpectedDisbursements();
        result = result * PRIME + ($disallowExpectedDisbursements == null ? 43 : $disallowExpectedDisbursements.hashCode());
        final java.lang.Object $loanCounter = this.getLoanCounter();
        result = result * PRIME + ($loanCounter == null ? 43 : $loanCounter.hashCode());
        final java.lang.Object $loanProductCounter = this.getLoanProductCounter();
        result = result * PRIME + ($loanProductCounter == null ? 43 : $loanProductCounter.hashCode());
        final java.lang.Object $multiDisburseLoan = this.getMultiDisburseLoan();
        result = result * PRIME + ($multiDisburseLoan == null ? 43 : $multiDisburseLoan.hashCode());
        final java.lang.Object $canDefineInstallmentAmount = this.getCanDefineInstallmentAmount();
        result = result * PRIME + ($canDefineInstallmentAmount == null ? 43 : $canDefineInstallmentAmount.hashCode());
        final java.lang.Object $canDisburse = this.getCanDisburse();
        result = result * PRIME + ($canDisburse == null ? 43 : $canDisburse.hashCode());
        final java.lang.Object $canUseForTopup = this.getCanUseForTopup();
        result = result * PRIME + ($canUseForTopup == null ? 43 : $canUseForTopup.hashCode());
        final java.lang.Object $closureLoanId = this.getClosureLoanId();
        result = result * PRIME + ($closureLoanId == null ? 43 : $closureLoanId.hashCode());
        final java.lang.Object $inArrears = this.getInArrears();
        result = result * PRIME + ($inArrears == null ? 43 : $inArrears.hashCode());
        final java.lang.Object $isNPA = this.getIsNPA();
        result = result * PRIME + ($isNPA == null ? 43 : $isNPA.hashCode());
        final java.lang.Object $createStandingInstructionAtDisbursement = this.getCreateStandingInstructionAtDisbursement();
        result = result * PRIME + ($createStandingInstructionAtDisbursement == null ? 43 : $createStandingInstructionAtDisbursement.hashCode());
        final java.lang.Object $isVariableInstallmentsAllowed = this.getIsVariableInstallmentsAllowed();
        result = result * PRIME + ($isVariableInstallmentsAllowed == null ? 43 : $isVariableInstallmentsAllowed.hashCode());
        final java.lang.Object $minimumGap = this.getMinimumGap();
        result = result * PRIME + ($minimumGap == null ? 43 : $minimumGap.hashCode());
        final java.lang.Object $maximumGap = this.getMaximumGap();
        result = result * PRIME + ($maximumGap == null ? 43 : $maximumGap.hashCode());
        final java.lang.Object $isEqualAmortization = this.getIsEqualAmortization();
        result = result * PRIME + ($isEqualAmortization == null ? 43 : $isEqualAmortization.hashCode());
        final java.lang.Object $isRatesEnabled = this.getIsRatesEnabled();
        result = result * PRIME + ($isRatesEnabled == null ? 43 : $isRatesEnabled.hashCode());
        final java.lang.Object $productId = this.getProductId();
        result = result * PRIME + ($productId == null ? 43 : $productId.hashCode());
        final java.lang.Object $loanTermFrequency = this.getLoanTermFrequency();
        result = result * PRIME + ($loanTermFrequency == null ? 43 : $loanTermFrequency.hashCode());
        final java.lang.Object $groupId = this.getGroupId();
        result = result * PRIME + ($groupId == null ? 43 : $groupId.hashCode());
        final java.lang.Object $enableInstallmentLevelDelinquency = this.getEnableInstallmentLevelDelinquency();
        result = result * PRIME + ($enableInstallmentLevelDelinquency == null ? 43 : $enableInstallmentLevelDelinquency.hashCode());
        final java.lang.Object $chargedOff = this.getChargedOff();
        result = result * PRIME + ($chargedOff == null ? 43 : $chargedOff.hashCode());
        final java.lang.Object $allowFullTermForTranche = this.getAllowFullTermForTranche();
        result = result * PRIME + ($allowFullTermForTranche == null ? 43 : $allowFullTermForTranche.hashCode());
        final java.lang.Object $enableDownPayment = this.getEnableDownPayment();
        result = result * PRIME + ($enableDownPayment == null ? 43 : $enableDownPayment.hashCode());
        final java.lang.Object $enableAutoRepaymentForDownPayment = this.getEnableAutoRepaymentForDownPayment();
        result = result * PRIME + ($enableAutoRepaymentForDownPayment == null ? 43 : $enableAutoRepaymentForDownPayment.hashCode());
        final java.lang.Object $interestRecognitionOnDisbursementDate = this.getInterestRecognitionOnDisbursementDate();
        result = result * PRIME + ($interestRecognitionOnDisbursementDate == null ? 43 : $interestRecognitionOnDisbursementDate.hashCode());
        final java.lang.Object $enableIncomeCapitalization = this.getEnableIncomeCapitalization();
        result = result * PRIME + ($enableIncomeCapitalization == null ? 43 : $enableIncomeCapitalization.hashCode());
        final java.lang.Object $enableBuyDownFee = this.getEnableBuyDownFee();
        result = result * PRIME + ($enableBuyDownFee == null ? 43 : $enableBuyDownFee.hashCode());
        final java.lang.Object $merchantBuyDownFee = this.getMerchantBuyDownFee();
        result = result * PRIME + ($merchantBuyDownFee == null ? 43 : $merchantBuyDownFee.hashCode());
        final java.lang.Object $accountNo = this.getAccountNo();
        result = result * PRIME + ($accountNo == null ? 43 : $accountNo.hashCode());
        final java.lang.Object $externalId = this.getExternalId();
        result = result * PRIME + ($externalId == null ? 43 : $externalId.hashCode());
        final java.lang.Object $status = this.getStatus();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        final java.lang.Object $subStatus = this.getSubStatus();
        result = result * PRIME + ($subStatus == null ? 43 : $subStatus.hashCode());
        final java.lang.Object $clientAccountNo = this.getClientAccountNo();
        result = result * PRIME + ($clientAccountNo == null ? 43 : $clientAccountNo.hashCode());
        final java.lang.Object $clientName = this.getClientName();
        result = result * PRIME + ($clientName == null ? 43 : $clientName.hashCode());
        final java.lang.Object $clientExternalId = this.getClientExternalId();
        result = result * PRIME + ($clientExternalId == null ? 43 : $clientExternalId.hashCode());
        final java.lang.Object $group = this.getGroup();
        result = result * PRIME + ($group == null ? 43 : $group.hashCode());
        final java.lang.Object $loanProductName = this.getLoanProductName();
        result = result * PRIME + ($loanProductName == null ? 43 : $loanProductName.hashCode());
        final java.lang.Object $loanProductDescription = this.getLoanProductDescription();
        result = result * PRIME + ($loanProductDescription == null ? 43 : $loanProductDescription.hashCode());
        final java.lang.Object $fundName = this.getFundName();
        result = result * PRIME + ($fundName == null ? 43 : $fundName.hashCode());
        final java.lang.Object $loanPurposeName = this.getLoanPurposeName();
        result = result * PRIME + ($loanPurposeName == null ? 43 : $loanPurposeName.hashCode());
        final java.lang.Object $loanOfficerName = this.getLoanOfficerName();
        result = result * PRIME + ($loanOfficerName == null ? 43 : $loanOfficerName.hashCode());
        final java.lang.Object $loanType = this.getLoanType();
        result = result * PRIME + ($loanType == null ? 43 : $loanType.hashCode());
        final java.lang.Object $currency = this.getCurrency();
        result = result * PRIME + ($currency == null ? 43 : $currency.hashCode());
        final java.lang.Object $principal = this.getPrincipal();
        result = result * PRIME + ($principal == null ? 43 : $principal.hashCode());
        final java.lang.Object $approvedPrincipal = this.getApprovedPrincipal();
        result = result * PRIME + ($approvedPrincipal == null ? 43 : $approvedPrincipal.hashCode());
        final java.lang.Object $proposedPrincipal = this.getProposedPrincipal();
        result = result * PRIME + ($proposedPrincipal == null ? 43 : $proposedPrincipal.hashCode());
        final java.lang.Object $netDisbursalAmount = this.getNetDisbursalAmount();
        result = result * PRIME + ($netDisbursalAmount == null ? 43 : $netDisbursalAmount.hashCode());
        final java.lang.Object $termPeriodFrequencyType = this.getTermPeriodFrequencyType();
        result = result * PRIME + ($termPeriodFrequencyType == null ? 43 : $termPeriodFrequencyType.hashCode());
        final java.lang.Object $repaymentFrequencyType = this.getRepaymentFrequencyType();
        result = result * PRIME + ($repaymentFrequencyType == null ? 43 : $repaymentFrequencyType.hashCode());
        final java.lang.Object $repaymentFrequencyNthDayType = this.getRepaymentFrequencyNthDayType();
        result = result * PRIME + ($repaymentFrequencyNthDayType == null ? 43 : $repaymentFrequencyNthDayType.hashCode());
        final java.lang.Object $repaymentFrequencyDayOfWeekType = this.getRepaymentFrequencyDayOfWeekType();
        result = result * PRIME + ($repaymentFrequencyDayOfWeekType == null ? 43 : $repaymentFrequencyDayOfWeekType.hashCode());
        final java.lang.Object $interestRatePerPeriod = this.getInterestRatePerPeriod();
        result = result * PRIME + ($interestRatePerPeriod == null ? 43 : $interestRatePerPeriod.hashCode());
        final java.lang.Object $interestRateFrequencyType = this.getInterestRateFrequencyType();
        result = result * PRIME + ($interestRateFrequencyType == null ? 43 : $interestRateFrequencyType.hashCode());
        final java.lang.Object $annualInterestRate = this.getAnnualInterestRate();
        result = result * PRIME + ($annualInterestRate == null ? 43 : $annualInterestRate.hashCode());
        final java.lang.Object $interestRateDifferential = this.getInterestRateDifferential();
        result = result * PRIME + ($interestRateDifferential == null ? 43 : $interestRateDifferential.hashCode());
        final java.lang.Object $amortizationType = this.getAmortizationType();
        result = result * PRIME + ($amortizationType == null ? 43 : $amortizationType.hashCode());
        final java.lang.Object $interestType = this.getInterestType();
        result = result * PRIME + ($interestType == null ? 43 : $interestType.hashCode());
        final java.lang.Object $interestCalculationPeriodType = this.getInterestCalculationPeriodType();
        result = result * PRIME + ($interestCalculationPeriodType == null ? 43 : $interestCalculationPeriodType.hashCode());
        final java.lang.Object $inArrearsTolerance = this.getInArrearsTolerance();
        result = result * PRIME + ($inArrearsTolerance == null ? 43 : $inArrearsTolerance.hashCode());
        final java.lang.Object $transactionProcessingStrategyCode = this.getTransactionProcessingStrategyCode();
        result = result * PRIME + ($transactionProcessingStrategyCode == null ? 43 : $transactionProcessingStrategyCode.hashCode());
        final java.lang.Object $transactionProcessingStrategyName = this.getTransactionProcessingStrategyName();
        result = result * PRIME + ($transactionProcessingStrategyName == null ? 43 : $transactionProcessingStrategyName.hashCode());
        final java.lang.Object $interestChargedFromDate = this.getInterestChargedFromDate();
        result = result * PRIME + ($interestChargedFromDate == null ? 43 : $interestChargedFromDate.hashCode());
        final java.lang.Object $expectedFirstRepaymentOnDate = this.getExpectedFirstRepaymentOnDate();
        result = result * PRIME + ($expectedFirstRepaymentOnDate == null ? 43 : $expectedFirstRepaymentOnDate.hashCode());
        final java.lang.Object $timeline = this.getTimeline();
        result = result * PRIME + ($timeline == null ? 43 : $timeline.hashCode());
        final java.lang.Object $summary = this.getSummary();
        result = result * PRIME + ($summary == null ? 43 : $summary.hashCode());
        final java.lang.Object $repaymentSchedule = this.getRepaymentSchedule();
        result = result * PRIME + ($repaymentSchedule == null ? 43 : $repaymentSchedule.hashCode());
        final java.lang.Object $transactions = this.getTransactions();
        result = result * PRIME + ($transactions == null ? 43 : $transactions.hashCode());
        final java.lang.Object $charges = this.getCharges();
        result = result * PRIME + ($charges == null ? 43 : $charges.hashCode());
        final java.lang.Object $collateral = this.getCollateral();
        result = result * PRIME + ($collateral == null ? 43 : $collateral.hashCode());
        final java.lang.Object $guarantors = this.getGuarantors();
        result = result * PRIME + ($guarantors == null ? 43 : $guarantors.hashCode());
        final java.lang.Object $meeting = this.getMeeting();
        result = result * PRIME + ($meeting == null ? 43 : $meeting.hashCode());
        final java.lang.Object $notes = this.getNotes();
        result = result * PRIME + ($notes == null ? 43 : $notes.hashCode());
        final java.lang.Object $disbursementDetails = this.getDisbursementDetails();
        result = result * PRIME + ($disbursementDetails == null ? 43 : $disbursementDetails.hashCode());
        final java.lang.Object $originalSchedule = this.getOriginalSchedule();
        result = result * PRIME + ($originalSchedule == null ? 43 : $originalSchedule.hashCode());
        final java.lang.Object $originators = this.getOriginators();
        result = result * PRIME + ($originators == null ? 43 : $originators.hashCode());
        final java.lang.Object $productOptions = this.getProductOptions();
        result = result * PRIME + ($productOptions == null ? 43 : $productOptions.hashCode());
        final java.lang.Object $loanOfficerOptions = this.getLoanOfficerOptions();
        result = result * PRIME + ($loanOfficerOptions == null ? 43 : $loanOfficerOptions.hashCode());
        final java.lang.Object $loanPurposeOptions = this.getLoanPurposeOptions();
        result = result * PRIME + ($loanPurposeOptions == null ? 43 : $loanPurposeOptions.hashCode());
        final java.lang.Object $fundOptions = this.getFundOptions();
        result = result * PRIME + ($fundOptions == null ? 43 : $fundOptions.hashCode());
        final java.lang.Object $termFrequencyTypeOptions = this.getTermFrequencyTypeOptions();
        result = result * PRIME + ($termFrequencyTypeOptions == null ? 43 : $termFrequencyTypeOptions.hashCode());
        final java.lang.Object $repaymentFrequencyTypeOptions = this.getRepaymentFrequencyTypeOptions();
        result = result * PRIME + ($repaymentFrequencyTypeOptions == null ? 43 : $repaymentFrequencyTypeOptions.hashCode());
        final java.lang.Object $repaymentFrequencyNthDayTypeOptions = this.getRepaymentFrequencyNthDayTypeOptions();
        result = result * PRIME + ($repaymentFrequencyNthDayTypeOptions == null ? 43 : $repaymentFrequencyNthDayTypeOptions.hashCode());
        final java.lang.Object $repaymentFrequencyDaysOfWeekTypeOptions = this.getRepaymentFrequencyDaysOfWeekTypeOptions();
        result = result * PRIME + ($repaymentFrequencyDaysOfWeekTypeOptions == null ? 43 : $repaymentFrequencyDaysOfWeekTypeOptions.hashCode());
        final java.lang.Object $interestRateFrequencyTypeOptions = this.getInterestRateFrequencyTypeOptions();
        result = result * PRIME + ($interestRateFrequencyTypeOptions == null ? 43 : $interestRateFrequencyTypeOptions.hashCode());
        final java.lang.Object $amortizationTypeOptions = this.getAmortizationTypeOptions();
        result = result * PRIME + ($amortizationTypeOptions == null ? 43 : $amortizationTypeOptions.hashCode());
        final java.lang.Object $interestTypeOptions = this.getInterestTypeOptions();
        result = result * PRIME + ($interestTypeOptions == null ? 43 : $interestTypeOptions.hashCode());
        final java.lang.Object $interestCalculationPeriodTypeOptions = this.getInterestCalculationPeriodTypeOptions();
        result = result * PRIME + ($interestCalculationPeriodTypeOptions == null ? 43 : $interestCalculationPeriodTypeOptions.hashCode());
        final java.lang.Object $transactionProcessingStrategyOptions = this.getTransactionProcessingStrategyOptions();
        result = result * PRIME + ($transactionProcessingStrategyOptions == null ? 43 : $transactionProcessingStrategyOptions.hashCode());
        final java.lang.Object $chargeOptions = this.getChargeOptions();
        result = result * PRIME + ($chargeOptions == null ? 43 : $chargeOptions.hashCode());
        final java.lang.Object $loanCollateralOptions = this.getLoanCollateralOptions();
        result = result * PRIME + ($loanCollateralOptions == null ? 43 : $loanCollateralOptions.hashCode());
        final java.lang.Object $calendarOptions = this.getCalendarOptions();
        result = result * PRIME + ($calendarOptions == null ? 43 : $calendarOptions.hashCode());
        final java.lang.Object $loanScheduleTypeOptions = this.getLoanScheduleTypeOptions();
        result = result * PRIME + ($loanScheduleTypeOptions == null ? 43 : $loanScheduleTypeOptions.hashCode());
        final java.lang.Object $loanScheduleProcessingTypeOptions = this.getLoanScheduleProcessingTypeOptions();
        result = result * PRIME + ($loanScheduleProcessingTypeOptions == null ? 43 : $loanScheduleProcessingTypeOptions.hashCode());
        final java.lang.Object $daysInYearCustomStrategyOptions = this.getDaysInYearCustomStrategyOptions();
        result = result * PRIME + ($daysInYearCustomStrategyOptions == null ? 43 : $daysInYearCustomStrategyOptions.hashCode());
        final java.lang.Object $capitalizedIncomeCalculationTypeOptions = this.getCapitalizedIncomeCalculationTypeOptions();
        result = result * PRIME + ($capitalizedIncomeCalculationTypeOptions == null ? 43 : $capitalizedIncomeCalculationTypeOptions.hashCode());
        final java.lang.Object $capitalizedIncomeStrategyOptions = this.getCapitalizedIncomeStrategyOptions();
        result = result * PRIME + ($capitalizedIncomeStrategyOptions == null ? 43 : $capitalizedIncomeStrategyOptions.hashCode());
        final java.lang.Object $capitalizedIncomeTypeOptions = this.getCapitalizedIncomeTypeOptions();
        result = result * PRIME + ($capitalizedIncomeTypeOptions == null ? 43 : $capitalizedIncomeTypeOptions.hashCode());
        final java.lang.Object $buyDownFeeCalculationTypeOptions = this.getBuyDownFeeCalculationTypeOptions();
        result = result * PRIME + ($buyDownFeeCalculationTypeOptions == null ? 43 : $buyDownFeeCalculationTypeOptions.hashCode());
        final java.lang.Object $buyDownFeeStrategyOptions = this.getBuyDownFeeStrategyOptions();
        result = result * PRIME + ($buyDownFeeStrategyOptions == null ? 43 : $buyDownFeeStrategyOptions.hashCode());
        final java.lang.Object $buyDownFeeIncomeTypeOptions = this.getBuyDownFeeIncomeTypeOptions();
        result = result * PRIME + ($buyDownFeeIncomeTypeOptions == null ? 43 : $buyDownFeeIncomeTypeOptions.hashCode());
        final java.lang.Object $feeChargesAtDisbursementCharged = this.getFeeChargesAtDisbursementCharged();
        result = result * PRIME + ($feeChargesAtDisbursementCharged == null ? 43 : $feeChargesAtDisbursementCharged.hashCode());
        final java.lang.Object $totalOverpaid = this.getTotalOverpaid();
        result = result * PRIME + ($totalOverpaid == null ? 43 : $totalOverpaid.hashCode());
        final java.lang.Object $linkedAccount = this.getLinkedAccount();
        result = result * PRIME + ($linkedAccount == null ? 43 : $linkedAccount.hashCode());
        final java.lang.Object $accountLinkingOptions = this.getAccountLinkingOptions();
        result = result * PRIME + ($accountLinkingOptions == null ? 43 : $accountLinkingOptions.hashCode());
        final java.lang.Object $fixedEmiAmount = this.getFixedEmiAmount();
        result = result * PRIME + ($fixedEmiAmount == null ? 43 : $fixedEmiAmount.hashCode());
        final java.lang.Object $maxOutstandingLoanBalance = this.getMaxOutstandingLoanBalance();
        result = result * PRIME + ($maxOutstandingLoanBalance == null ? 43 : $maxOutstandingLoanBalance.hashCode());
        final java.lang.Object $emiAmountVariations = this.getEmiAmountVariations();
        result = result * PRIME + ($emiAmountVariations == null ? 43 : $emiAmountVariations.hashCode());
        final java.lang.Object $loanTermVariations = this.getLoanTermVariations();
        result = result * PRIME + ($loanTermVariations == null ? 43 : $loanTermVariations.hashCode());
        final java.lang.Object $clientActiveLoanOptions = this.getClientActiveLoanOptions();
        result = result * PRIME + ($clientActiveLoanOptions == null ? 43 : $clientActiveLoanOptions.hashCode());
        final java.lang.Object $closureLoanAccountNo = this.getClosureLoanAccountNo();
        result = result * PRIME + ($closureLoanAccountNo == null ? 43 : $closureLoanAccountNo.hashCode());
        final java.lang.Object $topupAmount = this.getTopupAmount();
        result = result * PRIME + ($topupAmount == null ? 43 : $topupAmount.hashCode());
        final java.lang.Object $product = this.getProduct();
        result = result * PRIME + ($product == null ? 43 : $product.hashCode());
        final java.lang.Object $memberVariations = this.getMemberVariations();
        result = result * PRIME + ($memberVariations == null ? 43 : $memberVariations.hashCode());
        final java.lang.Object $overdueCharges = this.getOverdueCharges();
        result = result * PRIME + ($overdueCharges == null ? 43 : $overdueCharges.hashCode());
        final java.lang.Object $daysInMonthType = this.getDaysInMonthType();
        result = result * PRIME + ($daysInMonthType == null ? 43 : $daysInMonthType.hashCode());
        final java.lang.Object $daysInYearType = this.getDaysInYearType();
        result = result * PRIME + ($daysInYearType == null ? 43 : $daysInYearType.hashCode());
        final java.lang.Object $daysInYearCustomStrategy = this.getDaysInYearCustomStrategy();
        result = result * PRIME + ($daysInYearCustomStrategy == null ? 43 : $daysInYearCustomStrategy.hashCode());
        final java.lang.Object $interestRecalculationData = this.getInterestRecalculationData();
        result = result * PRIME + ($interestRecalculationData == null ? 43 : $interestRecalculationData.hashCode());
        final java.lang.Object $paidInAdvance = this.getPaidInAdvance();
        result = result * PRIME + ($paidInAdvance == null ? 43 : $paidInAdvance.hashCode());
        final java.lang.Object $interestRatesPeriods = this.getInterestRatesPeriods();
        result = result * PRIME + ($interestRatesPeriods == null ? 43 : $interestRatesPeriods.hashCode());
        final java.lang.Object $datatables = this.getDatatables();
        result = result * PRIME + ($datatables == null ? 43 : $datatables.hashCode());
        final java.lang.Object $fixedPrincipalPercentagePerInstallment = this.getFixedPrincipalPercentagePerInstallment();
        result = result * PRIME + ($fixedPrincipalPercentagePerInstallment == null ? 43 : $fixedPrincipalPercentagePerInstallment.hashCode());
        final java.lang.Object $rates = this.getRates();
        result = result * PRIME + ($rates == null ? 43 : $rates.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $submittedOnDate = this.getSubmittedOnDate();
        result = result * PRIME + ($submittedOnDate == null ? 43 : $submittedOnDate.hashCode());
        final java.lang.Object $loanTermFrequencyType = this.getLoanTermFrequencyType();
        result = result * PRIME + ($loanTermFrequencyType == null ? 43 : $loanTermFrequencyType.hashCode());
        final java.lang.Object $repaymentsStartingFromDate = this.getRepaymentsStartingFromDate();
        result = result * PRIME + ($repaymentsStartingFromDate == null ? 43 : $repaymentsStartingFromDate.hashCode());
        final java.lang.Object $linkAccountId = this.getLinkAccountId();
        result = result * PRIME + ($linkAccountId == null ? 43 : $linkAccountId.hashCode());
        final java.lang.Object $expectedDisbursementDate = this.getExpectedDisbursementDate();
        result = result * PRIME + ($expectedDisbursementDate == null ? 43 : $expectedDisbursementDate.hashCode());
        final java.lang.Object $overpaidOnDate = this.getOverpaidOnDate();
        result = result * PRIME + ($overpaidOnDate == null ? 43 : $overpaidOnDate.hashCode());
        final java.lang.Object $delinquent = this.getDelinquent();
        result = result * PRIME + ($delinquent == null ? 43 : $delinquent.hashCode());
        final java.lang.Object $delinquencyRange = this.getDelinquencyRange();
        result = result * PRIME + ($delinquencyRange == null ? 43 : $delinquencyRange.hashCode());
        final java.lang.Object $lastClosedBusinessDate = this.getLastClosedBusinessDate();
        result = result * PRIME + ($lastClosedBusinessDate == null ? 43 : $lastClosedBusinessDate.hashCode());
        final java.lang.Object $disbursedAmountPercentageForDownPayment = this.getDisbursedAmountPercentageForDownPayment();
        result = result * PRIME + ($disbursedAmountPercentageForDownPayment == null ? 43 : $disbursedAmountPercentageForDownPayment.hashCode());
        final java.lang.Object $repaymentStartDateType = this.getRepaymentStartDateType();
        result = result * PRIME + ($repaymentStartDateType == null ? 43 : $repaymentStartDateType.hashCode());
        final java.lang.Object $loanScheduleType = this.getLoanScheduleType();
        result = result * PRIME + ($loanScheduleType == null ? 43 : $loanScheduleType.hashCode());
        final java.lang.Object $loanScheduleProcessingType = this.getLoanScheduleProcessingType();
        result = result * PRIME + ($loanScheduleProcessingType == null ? 43 : $loanScheduleProcessingType.hashCode());
        final java.lang.Object $chargeOffBehaviour = this.getChargeOffBehaviour();
        result = result * PRIME + ($chargeOffBehaviour == null ? 43 : $chargeOffBehaviour.hashCode());
        final java.lang.Object $capitalizedIncomeCalculationType = this.getCapitalizedIncomeCalculationType();
        result = result * PRIME + ($capitalizedIncomeCalculationType == null ? 43 : $capitalizedIncomeCalculationType.hashCode());
        final java.lang.Object $capitalizedIncomeStrategy = this.getCapitalizedIncomeStrategy();
        result = result * PRIME + ($capitalizedIncomeStrategy == null ? 43 : $capitalizedIncomeStrategy.hashCode());
        final java.lang.Object $capitalizedIncomeType = this.getCapitalizedIncomeType();
        result = result * PRIME + ($capitalizedIncomeType == null ? 43 : $capitalizedIncomeType.hashCode());
        final java.lang.Object $buyDownFeeCalculationType = this.getBuyDownFeeCalculationType();
        result = result * PRIME + ($buyDownFeeCalculationType == null ? 43 : $buyDownFeeCalculationType.hashCode());
        final java.lang.Object $buyDownFeeStrategy = this.getBuyDownFeeStrategy();
        result = result * PRIME + ($buyDownFeeStrategy == null ? 43 : $buyDownFeeStrategy.hashCode());
        final java.lang.Object $buyDownFeeIncomeType = this.getBuyDownFeeIncomeType();
        result = result * PRIME + ($buyDownFeeIncomeType == null ? 43 : $buyDownFeeIncomeType.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanAccountData(id=" + this.getId() + ", accountNo=" + this.getAccountNo() + ", externalId=" + this.getExternalId() + ", status=" + this.getStatus() + ", subStatus=" + this.getSubStatus() + ", clientId=" + this.getClientId() + ", clientAccountNo=" + this.getClientAccountNo() + ", clientName=" + this.getClientName() + ", clientExternalId=" + this.getClientExternalId() + ", clientOfficeId=" + this.getClientOfficeId() + ", group=" + this.getGroup() + ", loanProductId=" + this.getLoanProductId() + ", loanProductName=" + this.getLoanProductName() + ", loanProductDescription=" + this.getLoanProductDescription() + ", isLoanProductLinkedToFloatingRate=" + this.isLoanProductLinkedToFloatingRate() + ", fundId=" + this.getFundId() + ", fundName=" + this.getFundName() + ", loanPurposeId=" + this.getLoanPurposeId() + ", loanPurposeName=" + this.getLoanPurposeName() + ", loanOfficerId=" + this.getLoanOfficerId() + ", loanOfficerName=" + this.getLoanOfficerName() + ", loanType=" + this.getLoanType() + ", currency=" + this.getCurrency() + ", principal=" + this.getPrincipal() + ", approvedPrincipal=" + this.getApprovedPrincipal() + ", proposedPrincipal=" + this.getProposedPrincipal() + ", netDisbursalAmount=" + this.getNetDisbursalAmount() + ", termFrequency=" + this.getTermFrequency() + ", termPeriodFrequencyType=" + this.getTermPeriodFrequencyType() + ", numberOfRepayments=" + this.getNumberOfRepayments() + ", actualNoTerm=" + this.getActualNoTerm() + ", repaymentEvery=" + this.getRepaymentEvery() + ", fixedLength=" + this.getFixedLength() + ", repaymentFrequencyType=" + this.getRepaymentFrequencyType() + ", repaymentFrequencyNthDayType=" + this.getRepaymentFrequencyNthDayType() + ", repaymentFrequencyDayOfWeekType=" + this.getRepaymentFrequencyDayOfWeekType() + ", interestRatePerPeriod=" + this.getInterestRatePerPeriod() + ", interestRateFrequencyType=" + this.getInterestRateFrequencyType() + ", annualInterestRate=" + this.getAnnualInterestRate() + ", isFloatingInterestRate=" + this.isFloatingInterestRate() + ", interestRateDifferential=" + this.getInterestRateDifferential() + ", amortizationType=" + this.getAmortizationType() + ", interestType=" + this.getInterestType() + ", interestCalculationPeriodType=" + this.getInterestCalculationPeriodType() + ", allowPartialPeriodInterestCalculation=" + this.getAllowPartialPeriodInterestCalculation() + ", inArrearsTolerance=" + this.getInArrearsTolerance() + ", transactionProcessingStrategyCode=" + this.getTransactionProcessingStrategyCode() + ", transactionProcessingStrategyName=" + this.getTransactionProcessingStrategyName() + ", graceOnPrincipalPayment=" + this.getGraceOnPrincipalPayment() + ", recurringMoratoriumOnPrincipalPeriods=" + this.getRecurringMoratoriumOnPrincipalPeriods() + ", graceOnInterestPayment=" + this.getGraceOnInterestPayment() + ", graceOnInterestCharged=" + this.getGraceOnInterestCharged() + ", graceOnArrearsAgeing=" + this.getGraceOnArrearsAgeing() + ", interestChargedFromDate=" + this.getInterestChargedFromDate() + ", expectedFirstRepaymentOnDate=" + this.getExpectedFirstRepaymentOnDate() + ", syncDisbursementWithMeeting=" + this.getSyncDisbursementWithMeeting() + ", disallowExpectedDisbursements=" + this.getDisallowExpectedDisbursements() + ", timeline=" + this.getTimeline() + ", summary=" + this.getSummary() + ", repaymentSchedule=" + this.getRepaymentSchedule() + ", transactions=" + this.getTransactions() + ", charges=" + this.getCharges() + ", collateral=" + this.getCollateral() + ", guarantors=" + this.getGuarantors() + ", meeting=" + this.getMeeting() + ", notes=" + this.getNotes() + ", disbursementDetails=" + this.getDisbursementDetails() + ", originalSchedule=" + this.getOriginalSchedule() + ", originators=" + this.getOriginators() + ", productOptions=" + this.getProductOptions() + ", loanOfficerOptions=" + this.getLoanOfficerOptions() + ", loanPurposeOptions=" + this.getLoanPurposeOptions() + ", fundOptions=" + this.getFundOptions() + ", termFrequencyTypeOptions=" + this.getTermFrequencyTypeOptions() + ", repaymentFrequencyTypeOptions=" + this.getRepaymentFrequencyTypeOptions() + ", repaymentFrequencyNthDayTypeOptions=" + this.getRepaymentFrequencyNthDayTypeOptions() + ", repaymentFrequencyDaysOfWeekTypeOptions=" + this.getRepaymentFrequencyDaysOfWeekTypeOptions() + ", interestRateFrequencyTypeOptions=" + this.getInterestRateFrequencyTypeOptions() + ", amortizationTypeOptions=" + this.getAmortizationTypeOptions() + ", interestTypeOptions=" + this.getInterestTypeOptions() + ", interestCalculationPeriodTypeOptions=" + this.getInterestCalculationPeriodTypeOptions() + ", transactionProcessingStrategyOptions=" + this.getTransactionProcessingStrategyOptions() + ", chargeOptions=" + this.getChargeOptions() + ", loanCollateralOptions=" + this.getLoanCollateralOptions() + ", calendarOptions=" + this.getCalendarOptions() + ", loanScheduleTypeOptions=" + this.getLoanScheduleTypeOptions() + ", loanScheduleProcessingTypeOptions=" + this.getLoanScheduleProcessingTypeOptions() + ", daysInYearCustomStrategyOptions=" + this.getDaysInYearCustomStrategyOptions() + ", capitalizedIncomeCalculationTypeOptions=" + this.getCapitalizedIncomeCalculationTypeOptions() + ", capitalizedIncomeStrategyOptions=" + this.getCapitalizedIncomeStrategyOptions() + ", capitalizedIncomeTypeOptions=" + this.getCapitalizedIncomeTypeOptions() + ", buyDownFeeCalculationTypeOptions=" + this.getBuyDownFeeCalculationTypeOptions() + ", buyDownFeeStrategyOptions=" + this.getBuyDownFeeStrategyOptions() + ", buyDownFeeIncomeTypeOptions=" + this.getBuyDownFeeIncomeTypeOptions() + ", feeChargesAtDisbursementCharged=" + this.getFeeChargesAtDisbursementCharged() + ", totalOverpaid=" + this.getTotalOverpaid() + ", loanCounter=" + this.getLoanCounter() + ", loanProductCounter=" + this.getLoanProductCounter() + ", linkedAccount=" + this.getLinkedAccount() + ", accountLinkingOptions=" + this.getAccountLinkingOptions() + ", multiDisburseLoan=" + this.getMultiDisburseLoan() + ", canDefineInstallmentAmount=" + this.getCanDefineInstallmentAmount() + ", fixedEmiAmount=" + this.getFixedEmiAmount() + ", maxOutstandingLoanBalance=" + this.getMaxOutstandingLoanBalance() + ", canDisburse=" + this.getCanDisburse() + ", emiAmountVariations=" + this.getEmiAmountVariations() + ", loanTermVariations=" + this.getLoanTermVariations() + ", clientActiveLoanOptions=" + this.getClientActiveLoanOptions() + ", canUseForTopup=" + this.getCanUseForTopup() + ", isTopup=" + this.isTopup() + ", fraud=" + this.isFraud() + ", closureLoanId=" + this.getClosureLoanId() + ", closureLoanAccountNo=" + this.getClosureLoanAccountNo() + ", topupAmount=" + this.getTopupAmount() + ", product=" + this.getProduct() + ", memberVariations=" + this.getMemberVariations() + ", inArrears=" + this.getInArrears() + ", isNPA=" + this.getIsNPA() + ", overdueCharges=" + this.getOverdueCharges() + ", daysInMonthType=" + this.getDaysInMonthType() + ", daysInYearType=" + this.getDaysInYearType() + ", daysInYearCustomStrategy=" + this.getDaysInYearCustomStrategy() + ", isInterestRecalculationEnabled=" + this.isInterestRecalculationEnabled() + ", interestRecalculationData=" + this.getInterestRecalculationData() + ", createStandingInstructionAtDisbursement=" + this.getCreateStandingInstructionAtDisbursement() + ", paidInAdvance=" + this.getPaidInAdvance() + ", interestRatesPeriods=" + this.getInterestRatesPeriods() + ", isVariableInstallmentsAllowed=" + this.getIsVariableInstallmentsAllowed() + ", minimumGap=" + this.getMinimumGap() + ", maximumGap=" + this.getMaximumGap() + ", datatables=" + this.getDatatables() + ", isEqualAmortization=" + this.getIsEqualAmortization() + ", fixedPrincipalPercentagePerInstallment=" + this.getFixedPrincipalPercentagePerInstallment() + ", rates=" + this.getRates() + ", isRatesEnabled=" + this.getIsRatesEnabled() + ", dateFormat=" + this.getDateFormat() + ", locale=" + this.getLocale() + ", rowIndex=" + this.getRowIndex() + ", submittedOnDate=" + this.getSubmittedOnDate() + ", productId=" + this.getProductId() + ", loanTermFrequency=" + this.getLoanTermFrequency() + ", loanTermFrequencyType=" + this.getLoanTermFrequencyType() + ", repaymentsStartingFromDate=" + this.getRepaymentsStartingFromDate() + ", linkAccountId=" + this.getLinkAccountId() + ", groupId=" + this.getGroupId() + ", expectedDisbursementDate=" + this.getExpectedDisbursementDate() + ", overpaidOnDate=" + this.getOverpaidOnDate() + ", delinquent=" + this.getDelinquent() + ", delinquencyRange=" + this.getDelinquencyRange() + ", enableInstallmentLevelDelinquency=" + this.getEnableInstallmentLevelDelinquency() + ", lastClosedBusinessDate=" + this.getLastClosedBusinessDate() + ", chargedOff=" + this.getChargedOff() + ", allowFullTermForTranche=" + this.getAllowFullTermForTranche() + ", enableDownPayment=" + this.getEnableDownPayment() + ", disbursedAmountPercentageForDownPayment=" + this.getDisbursedAmountPercentageForDownPayment() + ", enableAutoRepaymentForDownPayment=" + this.getEnableAutoRepaymentForDownPayment() + ", repaymentStartDateType=" + this.getRepaymentStartDateType() + ", interestRecognitionOnDisbursementDate=" + this.getInterestRecognitionOnDisbursementDate() + ", loanScheduleType=" + this.getLoanScheduleType() + ", loanScheduleProcessingType=" + this.getLoanScheduleProcessingType() + ", chargeOffBehaviour=" + this.getChargeOffBehaviour() + ", enableIncomeCapitalization=" + this.getEnableIncomeCapitalization() + ", capitalizedIncomeCalculationType=" + this.getCapitalizedIncomeCalculationType() + ", capitalizedIncomeStrategy=" + this.getCapitalizedIncomeStrategy() + ", capitalizedIncomeType=" + this.getCapitalizedIncomeType() + ", enableBuyDownFee=" + this.getEnableBuyDownFee() + ", buyDownFeeCalculationType=" + this.getBuyDownFeeCalculationType() + ", buyDownFeeStrategy=" + this.getBuyDownFeeStrategy() + ", buyDownFeeIncomeType=" + this.getBuyDownFeeIncomeType() + ", merchantBuyDownFee=" + this.getMerchantBuyDownFee() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanAccountData() {
    }
}
