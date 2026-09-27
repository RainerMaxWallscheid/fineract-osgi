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
package org.apache.fineract.accounting.journalentry.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import org.apache.fineract.accounting.closure.domain.GLClosure;
import org.apache.fineract.accounting.common.AccountingConstants.AccrualAccountsForLoan;
import org.apache.fineract.accounting.common.AccountingConstants.FinancialActivity;
import org.apache.fineract.accounting.common.AccountingConstants.LoanProductAccountingParams;
import org.apache.fineract.accounting.glaccount.domain.GLAccount;
import org.apache.fineract.accounting.moduleapi.GLAccountAssociation;
import org.apache.fineract.accounting.journalentry.data.AdvancedMappingtDTO;
import org.apache.fineract.accounting.journalentry.data.ChargePaymentDTO;
import org.apache.fineract.accounting.journalentry.data.ChargeTaxPaymentDTO;
import org.apache.fineract.accounting.journalentry.data.GLAccountBalanceHolder;
import org.apache.fineract.accounting.journalentry.data.LoanDTO;
import org.apache.fineract.accounting.journalentry.data.LoanTransactionDTO;
import org.apache.fineract.accounting.producttoaccountmapping.domain.ProductToGLAccountMapping;
import org.apache.fineract.infrastructure.core.service.MathUtil;
import org.apache.fineract.portfolio.PortfolioProductType;
import org.apache.fineract.portfolio.loanaccount.data.LoanTransactionEnumData;
import org.springframework.stereotype.Component;

@Component
public class AccrualBasedAccountingProcessorForLoan implements AccountingProcessorForLoan {
    private final AccountingProcessorHelper helper;
    private final LoanReversalJournalEntryPort journalEntryWritePlatformService;
    private final LoanCommonAccountingHelper loanCommonAccountingHelper;

    @Override
    public void createJournalEntriesForLoan(final LoanDTO loanDTO) {
        final Map<Long, GLClosure> latestGLClosureByOfficeId = new HashMap<>();
        for (final LoanTransactionDTO loanTransactionDTO : loanDTO.getNewLoanTransactions()) {
            // Unbox so a null office id still throws before a journal is stored.
            final long officeId = loanTransactionDTO.getOfficeId() == null ? loanDTO.getOfficeId() : loanTransactionDTO.getOfficeId();
            final GLClosure latestGLClosure = latestGLClosureByOfficeId.computeIfAbsent(officeId, this.helper::getLatestClosureByBranch);
            final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
            this.helper.checkForBranchClosures(latestGLClosure, transactionDate);
            final LoanTransactionEnumData transactionType = loanTransactionDTO.getTransactionType();
            if (loanTransactionDTO.isReversed()) {
                journalEntryWritePlatformService.createJournalEntryForReversedLoanTransaction(transactionDate, loanTransactionDTO.getTransactionId(), officeId);
                continue;
            }
            // Handle Disbursements
            if (transactionType.isDisbursement()) {
                createJournalEntriesForDisbursements(loanDTO, loanTransactionDTO, officeId);
            }
            // Handle Accruals
            if (transactionType.isAccrual() || transactionType.isAccrualAdjustment()) {
                createJournalEntriesForAccruals(loanDTO, loanTransactionDTO, officeId);
            } else 
            /*
             * Handle repayments, loan refunds, repayments at disbursement (except charge adjustment)
             */
            if ((transactionType.isRepaymentType() && !transactionType.isChargeAdjustment()) || transactionType.isRepaymentAtDisbursement() || transactionType.isChargePayment()) {
                createJournalEntriesForRepayments(loanDTO, loanTransactionDTO, officeId, transactionType.isRepaymentAtDisbursement());
            } else 
            // Logic for handling recovery payments
            if (transactionType.isRecoveryRepayment()) {
                createJournalEntriesForRecoveryRepayments(loanDTO, loanTransactionDTO, officeId);
            } else 
            // Logic for Refunds of Overpayments
            if (transactionType.isRefund()) {
                createJournalEntriesForRefund(loanDTO, loanTransactionDTO, officeId);
            } else 
            // Logic for Credit Balance Refunds
            if (transactionType.isCreditBalanceRefund()) {
                createJournalEntriesForCreditBalanceRefund(loanDTO, loanTransactionDTO, officeId);
            } else 
            // Handle Write Offs
            if ((transactionType.isWriteOff() || transactionType.isWaiveInterest() || transactionType.isWaiveCharges())) {
                createJournalEntriesForWriteOffs(loanDTO, loanTransactionDTO, officeId);
            } else 
            // Handle Transfers
            if (transactionType.isInitiateTransfer() || transactionType.isApproveTransfer() || transactionType.isWithdrawTransfer()) {
                createJournalEntriesForTransfers(loanDTO, loanTransactionDTO, officeId);
            } else 
            // Logic for Refunds of Active Loans
            if (transactionType.isRefundForActiveLoans()) {
                createJournalEntriesForRefundForActiveLoan(loanDTO, loanTransactionDTO, officeId);
            } else 
            // Logic for Chargebacks
            if (transactionType.isChargeback()) {
                createJournalEntriesForChargeback(loanDTO, loanTransactionDTO, officeId);
            } else 
            // Logic for Charge Adjustment
            if (transactionType.isChargeAdjustment()) {
                createJournalEntriesForChargeAdjustment(loanDTO, loanTransactionDTO, officeId);
            } else 
            // Logic for Charge-Off
            if (transactionType.isChargeoff()) {
                createJournalEntriesForChargeOff(loanDTO, loanTransactionDTO, officeId);
            } else 
            // Logic for Interest Payment Waiver
            if (transactionType.isInterestPaymentWaiver() || transactionType.isInterestRefund()) {
                createJournalEntriesForInterestPaymentWaiverOrInterestRefund(loanDTO, loanTransactionDTO, officeId);
            }
            // Handle Capitalized Income
            if (transactionType.isCapitalizedIncome()) {
                createJournalEntriesForCapitalizedIncome(loanDTO, loanTransactionDTO, officeId);
            }
            // Handle Capitalized Income Amortization
            if (transactionType.isCapitalizedIncomeAmortization()) {
                createJournalEntriesForCapitalizedIncomeAmortization(loanDTO, loanTransactionDTO, officeId);
            }
            // Handle Capitalized Income Adjustment
            if (transactionType.isCapitalizedIncomeAdjustment()) {
                createJournalEntriesForCapitalizedIncomeAdjustment(loanDTO, loanTransactionDTO, officeId);
            }
            // Capitalized Income Amortization Adjustment
            if (transactionType.isCapitalizedIncomeAmortizationAdjustment()) {
                createJournalEntriesForCapitalizedIncomeAmortizationAdjustment(loanDTO, loanTransactionDTO, officeId);
            }
            // Handle Buy Down Fee
            if (transactionType.isBuyDownFee()) {
                createJournalEntriesForBuyDownFee(loanDTO, loanTransactionDTO, officeId);
            }
            // Handle Buy Down Fee Adjustment
            if (transactionType.isBuyDownFeeAdjustment()) {
                createJournalEntriesForBuyDownFeeAdjustment(loanDTO, loanTransactionDTO, officeId);
            }
            // Handle Buy Down Fee Amortization
            if (transactionType.isBuyDownFeeAmortization()) {
                createJournalEntriesForBuyDownFeeAmortization(loanDTO, loanTransactionDTO, officeId);
            }
            // Handle Buy Down Fee Amortization Adjustment
            if (transactionType.isBuyDownFeeAmortizationAdjustment()) {
                createJournalEntriesForBuyDownFeeAmortizationAdjustment(loanDTO, loanTransactionDTO, officeId);
            }
        }
    }

    private void createJournalEntriesForTransfers(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal principalAmount = loanTransactionDTO.getPrincipal();
        if (!MathUtil.isGreaterThanZero(principalAmount)) {
            return;
        }
        final boolean isInitiateTransfer = loanTransactionDTO.getTransactionType().isInitiateTransfer();
        final Integer debitAccount = isInitiateTransfer ? AccrualAccountsForLoan.TRANSFERS_SUSPENSE.getValue() : AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue();
        final Integer creditAccount = isInitiateTransfer ? AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue() : AccrualAccountsForLoan.TRANSFERS_SUSPENSE.getValue();
        this.helper.createJournalEntriesForLoan(officeId, currencyCode, debitAccount, creditAccount, loanProductId, null, loanId, transactionId, transactionDate, principalAmount);
    }

    private void createJournalEntriesForCapitalizedIncome(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal principalAmount = loanTransactionDTO.getPrincipal();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        final GLAccountBalanceHolder glAccountBalanceHolder = new GLAccountBalanceHolder();
        if (MathUtil.isGreaterThanZero(principalAmount)) {
            populateCreditDebitMaps(loanProductId, principalAmount, paymentTypeId, AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue(), glAccountBalanceHolder);
        }
        // create credit entries
        for (Map.Entry<Long, BigDecimal> creditEntry : glAccountBalanceHolder.getCreditBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(creditEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(creditEntry.getKey());
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, creditEntry.getValue(), glAccount);
            }
        }
        // create debit entries
        for (Map.Entry<Long, BigDecimal> debitEntry : glAccountBalanceHolder.getDebitBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(debitEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(debitEntry.getKey());
                this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, debitEntry.getValue(), glAccount);
            }
        }
    }

    private void createJournalEntriesForCapitalizedIncomeAdjustment(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal transactionAmount = loanTransactionDTO.getAmount();
        final BigDecimal principalAmount = loanTransactionDTO.getPrincipal();
        final BigDecimal interestAmount = loanTransactionDTO.getInterest();
        final BigDecimal feesAmount = loanTransactionDTO.getFees();
        final BigDecimal penaltiesAmount = loanTransactionDTO.getPenalties();
        final BigDecimal overPaymentAmount = loanTransactionDTO.getOverPayment();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        final GLAccountBalanceHolder glAccountBalanceHolder = new GLAccountBalanceHolder();
        if (MathUtil.isGreaterThanZero(transactionAmount)) {
            // Resolve Credit
            // handle principal payment
            if (MathUtil.isGreaterThanZero(principalAmount)) {
                GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue(), paymentTypeId);
                glAccountBalanceHolder.addToCredit(account, principalAmount);
            }
            // handle interest payment
            if (MathUtil.isGreaterThanZero(interestAmount)) {
                GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.INTEREST_RECEIVABLE.getValue(), paymentTypeId);
                glAccountBalanceHolder.addToCredit(account, interestAmount);
            }
            // handle fee payment
            if (MathUtil.isGreaterThanZero(feesAmount)) {
                GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.FEES_RECEIVABLE.getValue(), paymentTypeId);
                glAccountBalanceHolder.addToCredit(account, feesAmount);
            }
            // handle penalty payment
            if (MathUtil.isGreaterThanZero(penaltiesAmount)) {
                GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.PENALTIES_RECEIVABLE.getValue(), paymentTypeId);
                glAccountBalanceHolder.addToCredit(account, penaltiesAmount);
            }
            // handle overpayment
            if (MathUtil.isGreaterThanZero(overPaymentAmount)) {
                GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.OVERPAYMENT.getValue(), paymentTypeId);
                glAccountBalanceHolder.addToCredit(account, overPaymentAmount);
            }
            // Resolve Debit
            GLAccount accountDeferredIncome = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), paymentTypeId);
            glAccountBalanceHolder.addToDebit(accountDeferredIncome, transactionAmount);
        }
        // create credit entries
        for (Map.Entry<Long, BigDecimal> creditEntry : glAccountBalanceHolder.getCreditBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(creditEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(creditEntry.getKey());
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, creditEntry.getValue(), glAccount);
            }
        }
        // create debit entries
        for (Map.Entry<Long, BigDecimal> debitEntry : glAccountBalanceHolder.getDebitBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(debitEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(debitEntry.getKey());
                this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, debitEntry.getValue(), glAccount);
            }
        }
    }

    private void createJournalEntriesForCapitalizedIncomeAmortization(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        final boolean isMarkedAsChargeOff = loanDTO.isMarkedAsChargeOff();
        if (isMarkedAsChargeOff) {
            createJournalEntriesForChargeOffLoanCapitalizedIncomeAmortization(loanDTO, loanTransactionDTO, officeId);
        } else {
            createJournalEntriesForLoanCapitalizedIncomeAmortization(loanDTO, loanTransactionDTO, officeId);
        }
    }

    private void createJournalEntriesForLoanCapitalizedIncomeAmortization(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        final boolean isLoanWrittenOff = loanDTO.isMarkedAsWrittenOff();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal interestAmount = loanTransactionDTO.getInterest();
        final BigDecimal feesAmount = loanTransactionDTO.getFees();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        final GLAccountBalanceHolder glAccountBalanceHolder = new GLAccountBalanceHolder();
        final List<AdvancedMappingtDTO> classificationCodeValues = loanDTO.getCapitalizedIncomeAdvancedMappingData();
        // interest payment
        final AccrualAccountsForLoan creditAccountType = isLoanWrittenOff ? AccrualAccountsForLoan.LOSSES_WRITTEN_OFF : AccrualAccountsForLoan.INCOME_FROM_CAPITALIZATION;
        if (MathUtil.isGreaterThanZero(interestAmount)) {
            if (classificationCodeValues.isEmpty()) {
                populateCreditDebitMaps(loanProductId, interestAmount, paymentTypeId, creditAccountType.getValue(), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), glAccountBalanceHolder);
            } else {
                classificationCodeValues.stream().forEach(classificationCodeValue -> {
                    ProductToGLAccountMapping mapping = null;
                    if (classificationCodeValue.getReferenceValueId() != null) {
                        mapping = fetchAdvanceAccountingMappingForCodeValue(loanProductId, classificationCodeValue.getReferenceValueId(), LoanProductAccountingParams.CAPITALIZED_INCOME_CLASSIFICATION_TO_INCOME_ACCOUNT_MAPPINGS.getValue());
                    }
                    if (mapping == null) {
                        if (MathUtil.isGreaterThanZero(classificationCodeValue.getAmount())) {
                            populateCreditDebitMaps(loanProductId, classificationCodeValue.getAmount(), paymentTypeId, creditAccountType.getValue(), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), glAccountBalanceHolder);
                        } else {
                            populateCreditDebitMaps(loanProductId, classificationCodeValue.getAmount().negate(), paymentTypeId, AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), creditAccountType.getValue(), glAccountBalanceHolder);
                        }
                    } else {
                        if (MathUtil.isGreaterThanZero(classificationCodeValue.getAmount())) {
                            populateCreditDebitMaps(loanProductId, classificationCodeValue.getAmount(), paymentTypeId, leftoverGlAccount(mapping), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), glAccountBalanceHolder);
                        } else {
                            populateCreditDebitMaps(loanProductId, classificationCodeValue.getAmount().negate(), paymentTypeId, AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), leftoverGlAccount(mapping), glAccountBalanceHolder);
                        }
                    }
                });
            }
        }
        // handle fees payment
        if (MathUtil.isGreaterThanZero(feesAmount)) {
            if (classificationCodeValues.isEmpty()) {
                populateCreditDebitMaps(loanProductId, feesAmount, paymentTypeId, creditAccountType.getValue(), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), glAccountBalanceHolder);
            } else {
                classificationCodeValues.stream().forEach(classificationCodeValue -> {
                    ProductToGLAccountMapping mapping = null;
                    if (classificationCodeValue.getReferenceValueId() != null) {
                        mapping = fetchAdvanceAccountingMappingForCodeValue(loanProductId, classificationCodeValue.getReferenceValueId(), LoanProductAccountingParams.CAPITALIZED_INCOME_CLASSIFICATION_TO_INCOME_ACCOUNT_MAPPINGS.getValue());
                    }
                    if (mapping == null) {
                        if (MathUtil.isGreaterThanZero(classificationCodeValue.getAmount())) {
                            populateCreditDebitMaps(loanProductId, classificationCodeValue.getAmount(), paymentTypeId, creditAccountType.getValue(), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), glAccountBalanceHolder);
                        } else {
                            populateCreditDebitMaps(loanProductId, classificationCodeValue.getAmount().negate(), paymentTypeId, AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), creditAccountType.getValue(), glAccountBalanceHolder);
                        }
                    } else {
                        if (MathUtil.isGreaterThanZero(classificationCodeValue.getAmount())) {
                            populateCreditDebitMaps(loanProductId, classificationCodeValue.getAmount(), paymentTypeId, leftoverGlAccount(mapping), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), glAccountBalanceHolder);
                        } else {
                            populateCreditDebitMaps(loanProductId, classificationCodeValue.getAmount().negate(), paymentTypeId, AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), leftoverGlAccount(mapping), glAccountBalanceHolder);
                        }
                    }
                });
            }
        }
        // create credit entries
        for (Map.Entry<Long, BigDecimal> creditEntry : glAccountBalanceHolder.getCreditBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(creditEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(creditEntry.getKey());
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, creditEntry.getValue(), glAccount);
            }
        }
        // create debit entries
        for (Map.Entry<Long, BigDecimal> debitEntry : glAccountBalanceHolder.getDebitBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(debitEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(debitEntry.getKey());
                this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, debitEntry.getValue(), glAccount);
            }
        }
    }

    private ProductToGLAccountMapping fetchAdvanceAccountingMappingForCodeValue(final Long loanProductId, final Long codeValueId, final String codeName) {
        return helper.getClassificationMappingByCodeValue(loanProductId, PortfolioProductType.LOAN, codeValueId, codeName);
    }

    private void createJournalEntriesForChargeOffLoanCapitalizedIncomeAmortization(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final boolean isMarkedFraud = loanDTO.isMarkedAsFraud();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal interestAmount = loanTransactionDTO.getInterest();
        final BigDecimal feesAmount = loanTransactionDTO.getFees();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        final GLAccountBalanceHolder glAccountBalanceHolder = new GLAccountBalanceHolder();
        final Long chargeOffReasonCodeValue = loanDTO.getChargeOffReasonCodeValue();
        final ProductToGLAccountMapping mapping = chargeOffReasonCodeValue != null ? helper.getChargeOffMappingByCodeValue(loanProductId, PortfolioProductType.LOAN, chargeOffReasonCodeValue) : null;
        if (mapping != null) {
            final GLAccount accountDebit = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), paymentTypeId);
            // handle interest payment
            if (MathUtil.isGreaterThanZero(interestAmount)) {
                glAccountBalanceHolder.addToCredit(leftoverGlAccount(mapping), interestAmount);
                glAccountBalanceHolder.addToDebit(accountDebit, interestAmount);
            }
            // handle fees payment
            if (MathUtil.isGreaterThanZero(feesAmount)) {
                glAccountBalanceHolder.addToCredit(leftoverGlAccount(mapping), feesAmount);
                glAccountBalanceHolder.addToDebit(accountDebit, feesAmount);
            }
        } else {
            final AccrualAccountsForLoan creditAccountType = isMarkedFraud ? AccrualAccountsForLoan.CHARGE_OFF_FRAUD_EXPENSE : AccrualAccountsForLoan.CHARGE_OFF_EXPENSE;
            // handle interest payment
            if (MathUtil.isGreaterThanZero(interestAmount)) {
                populateCreditDebitMaps(loanProductId, interestAmount, paymentTypeId, creditAccountType.getValue(), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), glAccountBalanceHolder);
            }
            // handle fees payment
            if (MathUtil.isGreaterThanZero(feesAmount)) {
                populateCreditDebitMaps(loanProductId, feesAmount, paymentTypeId, creditAccountType.getValue(), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), glAccountBalanceHolder);
            }
        }
        // create credit entries
        for (Map.Entry<Long, BigDecimal> creditEntry : glAccountBalanceHolder.getCreditBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(creditEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(creditEntry.getKey());
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, creditEntry.getValue(), glAccount);
            }
        }
        // create debit entries
        for (Map.Entry<Long, BigDecimal> debitEntry : glAccountBalanceHolder.getDebitBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(debitEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(debitEntry.getKey());
                this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, debitEntry.getValue(), glAccount);
            }
        }
    }

    private void createJournalEntriesForCapitalizedIncomeAmortizationAdjustment(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        GLAccountBalanceHolder glAccountBalanceHolder = new GLAccountBalanceHolder();
        if (MathUtil.isGreaterThanZero(loanTransactionDTO.getAmount())) {
            populateCreditDebitMaps(loanDTO.getLoanProductId(), loanTransactionDTO.getAmount(), loanTransactionDTO.getPaymentTypeId(), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), AccrualAccountsForLoan.INCOME_FROM_CAPITALIZATION.getValue(), glAccountBalanceHolder);
        }
        // create credit entries
        for (Map.Entry<Long, BigDecimal> creditEntry : glAccountBalanceHolder.getCreditBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(creditEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(creditEntry.getKey());
                this.helper.createCreditJournalEntryForLoan(officeId, loanDTO.getCurrencyCode(), loanDTO.getLoanId(), loanTransactionDTO.getTransactionId(), loanTransactionDTO.getTransactionDate(), creditEntry.getValue(), glAccount);
            }
        }
        // create debit entries
        for (Map.Entry<Long, BigDecimal> debitEntry : glAccountBalanceHolder.getDebitBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(debitEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(debitEntry.getKey());
                this.helper.createDebitJournalEntryForLoan(officeId, loanDTO.getCurrencyCode(), loanDTO.getLoanId(), loanTransactionDTO.getTransactionId(), loanTransactionDTO.getTransactionDate(), debitEntry.getValue(), glAccount);
            }
        }
    }

    private void createJournalEntriesForBuyDownFee(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal amount = loanTransactionDTO.getAmount();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        final AccrualAccountsForLoan debitAccountType = loanDTO.isMerchantBuyDownFee() ? AccrualAccountsForLoan.BUY_DOWN_EXPENSE : AccrualAccountsForLoan.FUND_SOURCE;
        if (MathUtil.isGreaterThanZero(amount)) {
            this.helper.createJournalEntriesForLoan(officeId, currencyCode, debitAccountType.getValue(), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, amount);
        }
    }

    private void createJournalEntriesForBuyDownFeeAdjustment(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal amount = loanTransactionDTO.getAmount();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        final AccrualAccountsForLoan debitAccountType = loanDTO.isMerchantBuyDownFee() ? AccrualAccountsForLoan.BUY_DOWN_EXPENSE : AccrualAccountsForLoan.FUND_SOURCE;
        if (MathUtil.isGreaterThanZero(amount)) {
            // Mirror of Buy Down Fee entries (as per PS-2574 requirements)
            // Debit: Deferred Income Liability, Credit: Buy Down Expense (merchant)
            // Debit: Deferred Income Liability, Credit: Fund Source (non merchant)
            this.helper.createJournalEntriesForLoan(officeId, currencyCode, AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), debitAccountType.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, amount);
        }
    }

    private void createJournalEntriesForBuyDownFeeAmortization(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        final boolean isMarkedAsChargeOff = loanDTO.isMarkedAsChargeOff();
        if (isMarkedAsChargeOff) {
            createJournalEntriesForChargeOffLoanBuyDownFeeAmortization(loanDTO, loanTransactionDTO, officeId);
        } else {
            createJournalEntriesForLoanBuyDownFeeAmortization(loanDTO, loanTransactionDTO, officeId);
        }
    }

    private void createJournalEntriesForLoanBuyDownFeeAmortization(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        final boolean isLoanWrittenOff = loanDTO.isMarkedAsWrittenOff();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal interestAmount = loanTransactionDTO.getInterest();
        final BigDecimal feesAmount = loanTransactionDTO.getFees();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        final GLAccountBalanceHolder glAccountBalanceHolder = new GLAccountBalanceHolder();
        final List<AdvancedMappingtDTO> classificationCodeValues = loanDTO.getBuydownFeeAdvancedMappingData();
        // interest payment
        final AccrualAccountsForLoan creditAccountType = isLoanWrittenOff ? AccrualAccountsForLoan.LOSSES_WRITTEN_OFF : AccrualAccountsForLoan.INCOME_FROM_BUY_DOWN;
        if (MathUtil.isGreaterThanZero(interestAmount)) {
            if (classificationCodeValues.isEmpty()) {
                populateCreditDebitMaps(loanProductId, interestAmount, paymentTypeId, creditAccountType.getValue(), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), glAccountBalanceHolder);
            } else {
                classificationCodeValues.forEach(classificationCodeValue -> {
                    ProductToGLAccountMapping mapping = null;
                    if (classificationCodeValue.getReferenceValueId() != null) {
                        mapping = fetchAdvanceAccountingMappingForCodeValue(loanProductId, classificationCodeValue.getReferenceValueId(), LoanProductAccountingParams.BUYDOWN_FEE_CLASSIFICATION_TO_INCOME_ACCOUNT_MAPPINGS.getValue());
                    }
                    if (mapping == null) {
                        if (MathUtil.isGreaterThanZero(classificationCodeValue.getAmount())) {
                            populateCreditDebitMaps(loanProductId, classificationCodeValue.getAmount(), paymentTypeId, creditAccountType.getValue(), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), glAccountBalanceHolder);
                        } else {
                            populateCreditDebitMaps(loanProductId, classificationCodeValue.getAmount().negate(), paymentTypeId, AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), creditAccountType.getValue(), glAccountBalanceHolder);
                        }
                    } else {
                        if (MathUtil.isGreaterThanZero(classificationCodeValue.getAmount())) {
                            populateCreditDebitMaps(loanProductId, classificationCodeValue.getAmount(), paymentTypeId, leftoverGlAccount(mapping), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), glAccountBalanceHolder);
                        } else {
                            populateCreditDebitMaps(loanProductId, classificationCodeValue.getAmount().negate(), paymentTypeId, AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), leftoverGlAccount(mapping), glAccountBalanceHolder);
                        }
                    }
                });
            }
        }
        // handle fees payment
        if (MathUtil.isGreaterThanZero(feesAmount)) {
            if (classificationCodeValues.isEmpty()) {
                populateCreditDebitMaps(loanProductId, feesAmount, paymentTypeId, creditAccountType.getValue(), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), glAccountBalanceHolder);
            } else {
                classificationCodeValues.stream().forEach(classificationCodeValue -> {
                    ProductToGLAccountMapping mapping = null;
                    if (classificationCodeValue.getReferenceValueId() != null) {
                        mapping = fetchAdvanceAccountingMappingForCodeValue(loanProductId, classificationCodeValue.getReferenceValueId(), LoanProductAccountingParams.BUYDOWN_FEE_CLASSIFICATION_TO_INCOME_ACCOUNT_MAPPINGS.getValue());
                    }
                    if (mapping == null) {
                        if (MathUtil.isGreaterThanZero(classificationCodeValue.getAmount())) {
                            populateCreditDebitMaps(loanProductId, classificationCodeValue.getAmount(), paymentTypeId, creditAccountType.getValue(), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), glAccountBalanceHolder);
                        } else {
                            populateCreditDebitMaps(loanProductId, classificationCodeValue.getAmount().negate(), paymentTypeId, AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), creditAccountType.getValue(), glAccountBalanceHolder);
                        }
                    } else {
                        if (MathUtil.isGreaterThanZero(classificationCodeValue.getAmount())) {
                            populateCreditDebitMaps(loanProductId, classificationCodeValue.getAmount(), paymentTypeId, leftoverGlAccount(mapping), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), glAccountBalanceHolder);
                        } else {
                            populateCreditDebitMaps(loanProductId, classificationCodeValue.getAmount().negate(), paymentTypeId, AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), leftoverGlAccount(mapping), glAccountBalanceHolder);
                        }
                    }
                });
            }
        }
        // create credit entries
        for (Map.Entry<Long, BigDecimal> creditEntry : glAccountBalanceHolder.getCreditBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(creditEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(creditEntry.getKey());
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, creditEntry.getValue(), glAccount);
            }
        }
        // create debit entries
        for (Map.Entry<Long, BigDecimal> debitEntry : glAccountBalanceHolder.getDebitBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(debitEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(debitEntry.getKey());
                this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, debitEntry.getValue(), glAccount);
            }
        }
    }

    private void createJournalEntriesForChargeOffLoanBuyDownFeeAmortization(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final boolean isMarkedFraud = loanDTO.isMarkedAsFraud();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal interestAmount = loanTransactionDTO.getInterest();
        final BigDecimal feesAmount = loanTransactionDTO.getFees();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        final GLAccountBalanceHolder glAccountBalanceHolder = new GLAccountBalanceHolder();
        final Long chargeOffReasonCodeValue = loanDTO.getChargeOffReasonCodeValue();
        final ProductToGLAccountMapping mapping = chargeOffReasonCodeValue != null ? helper.getChargeOffMappingByCodeValue(loanProductId, PortfolioProductType.LOAN, chargeOffReasonCodeValue) : null;
        if (mapping != null) {
            final GLAccount accountDebit = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), paymentTypeId);
            // handle interest payment
            if (MathUtil.isGreaterThanZero(interestAmount)) {
                glAccountBalanceHolder.addToCredit(leftoverGlAccount(mapping), interestAmount);
                glAccountBalanceHolder.addToDebit(accountDebit, interestAmount);
            }
            // handle fees payment
            if (MathUtil.isGreaterThanZero(feesAmount)) {
                glAccountBalanceHolder.addToCredit(leftoverGlAccount(mapping), feesAmount);
                glAccountBalanceHolder.addToDebit(accountDebit, feesAmount);
            }
        } else {
            final AccrualAccountsForLoan creditAccountType = isMarkedFraud ? AccrualAccountsForLoan.CHARGE_OFF_FRAUD_EXPENSE : AccrualAccountsForLoan.CHARGE_OFF_EXPENSE;
            // handle interest payment
            if (MathUtil.isGreaterThanZero(interestAmount)) {
                populateCreditDebitMaps(loanProductId, interestAmount, paymentTypeId, creditAccountType.getValue(), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), glAccountBalanceHolder);
            }
            // handle fees payment
            if (MathUtil.isGreaterThanZero(feesAmount)) {
                populateCreditDebitMaps(loanProductId, feesAmount, paymentTypeId, creditAccountType.getValue(), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), glAccountBalanceHolder);
            }
        }
        // create credit entries
        for (Map.Entry<Long, BigDecimal> creditEntry : glAccountBalanceHolder.getCreditBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(creditEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(creditEntry.getKey());
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, creditEntry.getValue(), glAccount);
            }
        }
        // create debit entries
        for (Map.Entry<Long, BigDecimal> debitEntry : glAccountBalanceHolder.getDebitBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(debitEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(debitEntry.getKey());
                this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, debitEntry.getValue(), glAccount);
            }
        }
    }

    private void createJournalEntriesForBuyDownFeeAmortizationAdjustment(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        GLAccountBalanceHolder glAccountBalanceHolder = new GLAccountBalanceHolder();
        if (MathUtil.isGreaterThanZero(loanTransactionDTO.getAmount())) {
            populateCreditDebitMaps(loanDTO.getLoanProductId(), loanTransactionDTO.getAmount(), loanTransactionDTO.getPaymentTypeId(), AccrualAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), AccrualAccountsForLoan.INCOME_FROM_BUY_DOWN.getValue(), glAccountBalanceHolder);
        }
        // create credit entries
        for (Map.Entry<Long, BigDecimal> creditEntry : glAccountBalanceHolder.getCreditBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(creditEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(creditEntry.getKey());
                this.helper.createCreditJournalEntryForLoan(officeId, loanDTO.getCurrencyCode(), loanDTO.getLoanId(), loanTransactionDTO.getTransactionId(), loanTransactionDTO.getTransactionDate(), creditEntry.getValue(), glAccount);
            }
        }
        // create debit entries
        for (Map.Entry<Long, BigDecimal> debitEntry : glAccountBalanceHolder.getDebitBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(debitEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(debitEntry.getKey());
                this.helper.createDebitJournalEntryForLoan(officeId, loanDTO.getCurrencyCode(), loanDTO.getLoanId(), loanTransactionDTO.getTransactionId(), loanTransactionDTO.getTransactionDate(), debitEntry.getValue(), glAccount);
            }
        }
    }

    private void createJournalEntriesForInterestPaymentWaiverOrInterestRefund(LoanDTO loanDTO, LoanTransactionDTO loanTransactionDTO, long officeId) {
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        final boolean isMarkedAsChargeOff = loanDTO.isMarkedAsChargeOff();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal principalAmount = loanTransactionDTO.getPrincipal();
        final BigDecimal interestAmount = loanTransactionDTO.getInterest();
        final BigDecimal feesAmount = loanTransactionDTO.getFees();
        final BigDecimal penaltiesAmount = loanTransactionDTO.getPenalties();
        final BigDecimal overPayment = loanTransactionDTO.getOverPayment();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        GLAccountBalanceHolder glAccountBalanceHolder = new GLAccountBalanceHolder();
        if (isMarkedAsChargeOff) {
            // ChargeOFF
            // principal payment
            if (MathUtil.isGreaterThanZero(principalAmount)) {
                populateCreditDebitMaps(loanProductId, principalAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_INTEREST.getValue(), AccrualAccountsForLoan.INTEREST_ON_LOANS.getValue(), glAccountBalanceHolder);
            }
            // interest payment
            if (MathUtil.isGreaterThanZero(interestAmount)) {
                populateCreditDebitMaps(loanProductId, interestAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_INTEREST.getValue(), AccrualAccountsForLoan.INTEREST_ON_LOANS.getValue(), glAccountBalanceHolder);
            }
            // handle fees payment
            if (MathUtil.isGreaterThanZero(feesAmount)) {
                populateCreditDebitMaps(loanProductId, feesAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_INTEREST.getValue(), AccrualAccountsForLoan.INTEREST_ON_LOANS.getValue(), glAccountBalanceHolder);
            }
            // handle penalty payment
            if (MathUtil.isGreaterThanZero(penaltiesAmount)) {
                populateCreditDebitMaps(loanProductId, penaltiesAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_INTEREST.getValue(), AccrualAccountsForLoan.INTEREST_ON_LOANS.getValue(), glAccountBalanceHolder);
            }
            // handle overpayment
            if (MathUtil.isGreaterThanZero(overPayment)) {
                populateCreditDebitMaps(loanProductId, overPayment, paymentTypeId, AccrualAccountsForLoan.OVERPAYMENT.getValue(), AccrualAccountsForLoan.INTEREST_ON_LOANS.getValue(), glAccountBalanceHolder);
            }
        } else {
            // principal payment
            if (MathUtil.isGreaterThanZero(principalAmount)) {
                populateCreditDebitMaps(loanProductId, principalAmount, paymentTypeId, AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue(), AccrualAccountsForLoan.INTEREST_ON_LOANS.getValue(), glAccountBalanceHolder);
            }
            // interest payment
            if (MathUtil.isGreaterThanZero(interestAmount)) {
                populateCreditDebitMaps(loanProductId, interestAmount, paymentTypeId, AccrualAccountsForLoan.INTEREST_RECEIVABLE.getValue(), AccrualAccountsForLoan.INTEREST_ON_LOANS.getValue(), glAccountBalanceHolder);
            }
            // handle fees payment
            if (MathUtil.isGreaterThanZero(feesAmount)) {
                populateCreditDebitMaps(loanProductId, feesAmount, paymentTypeId, AccrualAccountsForLoan.FEES_RECEIVABLE.getValue(), AccrualAccountsForLoan.INTEREST_ON_LOANS.getValue(), glAccountBalanceHolder);
            }
            // handle penalty payment
            if (MathUtil.isGreaterThanZero(penaltiesAmount)) {
                populateCreditDebitMaps(loanProductId, penaltiesAmount, paymentTypeId, AccrualAccountsForLoan.PENALTIES_RECEIVABLE.getValue(), AccrualAccountsForLoan.INTEREST_ON_LOANS.getValue(), glAccountBalanceHolder);
            }
            // handle overpayment
            if (MathUtil.isGreaterThanZero(overPayment)) {
                populateCreditDebitMaps(loanProductId, overPayment, paymentTypeId, AccrualAccountsForLoan.OVERPAYMENT.getValue(), AccrualAccountsForLoan.INTEREST_ON_LOANS.getValue(), glAccountBalanceHolder);
            }
        }
        // create credit entries
        for (Map.Entry<Long, BigDecimal> creditEntry : glAccountBalanceHolder.getCreditBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(creditEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(creditEntry.getKey());
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, creditEntry.getValue(), glAccount);
            }
        }
        // create debit entries
        for (Map.Entry<Long, BigDecimal> debitEntry : glAccountBalanceHolder.getDebitBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(debitEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(debitEntry.getKey());
                this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, debitEntry.getValue(), glAccount);
            }
        }
    }

    private void createJournalEntriesForChargeOff(LoanDTO loanDTO, LoanTransactionDTO loanTransactionDTO, long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        final boolean isMarkedFraud = loanDTO.isMarkedAsFraud();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal principalAmount = loanTransactionDTO.getPrincipal();
        final BigDecimal interestAmount = loanTransactionDTO.getInterest();
        final BigDecimal feesAmount = loanTransactionDTO.getFees();
        final BigDecimal penaltiesAmount = loanTransactionDTO.getPenalties();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        GLAccountBalanceHolder glAccountBalanceHolder = new GLAccountBalanceHolder();
        // need to fetch if there are account mappings (always one)
        Long chargeOffReasonCodeValue = loanDTO.getChargeOffReasonCodeValue();
        ProductToGLAccountMapping mapping = chargeOffReasonCodeValue != null ? helper.getChargeOffMappingByCodeValue(loanProductId, PortfolioProductType.LOAN, chargeOffReasonCodeValue) : null;
        if (MathUtil.isGreaterThanZero(principalAmount)) {
            if (mapping != null) {
                GLAccount accountCredit = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue(), paymentTypeId);
                glAccountBalanceHolder.addToCredit(accountCredit, principalAmount);
                glAccountBalanceHolder.addToDebit(leftoverGlAccount(mapping), principalAmount);
            } else {
                // principal payment
                if (isMarkedFraud) {
                    populateCreditDebitMaps(loanProductId, principalAmount, paymentTypeId, AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue(), AccrualAccountsForLoan.CHARGE_OFF_FRAUD_EXPENSE.getValue(), glAccountBalanceHolder);
                } else {
                    populateCreditDebitMaps(loanProductId, principalAmount, paymentTypeId, AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue(), AccrualAccountsForLoan.CHARGE_OFF_EXPENSE.getValue(), glAccountBalanceHolder);
                }
            }
        }
        // interest payment
        if (MathUtil.isGreaterThanZero(interestAmount)) {
            populateCreditDebitMaps(loanProductId, interestAmount, paymentTypeId, AccrualAccountsForLoan.INTEREST_RECEIVABLE.getValue(), AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_INTEREST.getValue(), glAccountBalanceHolder);
        }
        // handle fees payment
        if (MathUtil.isGreaterThanZero(feesAmount)) {
            populateCreditDebitMaps(loanProductId, feesAmount, paymentTypeId, AccrualAccountsForLoan.FEES_RECEIVABLE.getValue(), AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_FEES.getValue(), glAccountBalanceHolder);
        }
        // handle penalty payment
        if (MathUtil.isGreaterThanZero(penaltiesAmount)) {
            populateCreditDebitMaps(loanProductId, penaltiesAmount, paymentTypeId, AccrualAccountsForLoan.PENALTIES_RECEIVABLE.getValue(), AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_PENALTY.getValue(), glAccountBalanceHolder);
        }
        // create credit entries
        for (Map.Entry<Long, BigDecimal> creditEntry : glAccountBalanceHolder.getCreditBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(creditEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(creditEntry.getKey());
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, creditEntry.getValue(), glAccount);
            }
        }
        // create debit entries
        for (Map.Entry<Long, BigDecimal> debitEntry : glAccountBalanceHolder.getDebitBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(debitEntry.getValue())) {
                GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(debitEntry.getKey());
                this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, debitEntry.getValue(), glAccount);
            }
        }
    }

    private void populateCreditDebitMaps(Long loanProductId, BigDecimal transactionPartAmount, Long paymentTypeId, Integer creditAccountType, Integer debitAccountType, GLAccountBalanceHolder glAccountBalanceHolder) {
        if (MathUtil.isGreaterThanZero(transactionPartAmount)) {
            // Resolve Credit
            GLAccount accountCredit = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, creditAccountType, paymentTypeId);
            glAccountBalanceHolder.addToCredit(accountCredit, transactionPartAmount);
            // Resolve Debit
            GLAccount accountDebit = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, debitAccountType, paymentTypeId);
            glAccountBalanceHolder.addToDebit(accountDebit, transactionPartAmount);
        }
    }

    private void populateCreditDebitMaps(Long loanProductId, BigDecimal transactionPartAmount, Long paymentTypeId, GLAccount accountCredit, Integer debitAccountType, GLAccountBalanceHolder glAccountBalanceHolder) {
        if (MathUtil.isGreaterThanZero(transactionPartAmount)) {
            // Resolve Credit
            glAccountBalanceHolder.addToCredit(accountCredit, transactionPartAmount);
            // Resolve Debit
            GLAccount accountDebit = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, debitAccountType, paymentTypeId);
            glAccountBalanceHolder.addToDebit(accountDebit, transactionPartAmount);
        }
    }

    private void populateCreditDebitMaps(final Long loanProductId, final BigDecimal transactionPartAmount, final Long paymentTypeId, final Integer creditAccountType, final GLAccount accountDebit, final GLAccountBalanceHolder glAccountBalanceHolder) {
        if (MathUtil.isGreaterThanZero(transactionPartAmount)) {
            // Resolve Credit
            final GLAccount accountCredit = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, creditAccountType, paymentTypeId);
            glAccountBalanceHolder.addToCredit(accountCredit, transactionPartAmount);
            // Resolve Debit
            glAccountBalanceHolder.addToDebit(accountDebit, transactionPartAmount);
        }
    }

    private GLAccount leftoverGlAccount(final ProductToGLAccountMapping mapping) {
        return mapping == null ? null : (GLAccount) GLAccountAssociation.persistableById(mapping.getGlAccountId());
    }

    private void createJournalEntriesForChargeAdjustment(LoanDTO loanDTO, LoanTransactionDTO loanTransactionDTO, long officeId) {
        final boolean isMarkedAsChargeOff = loanDTO.isMarkedAsChargeOff();
        if (isMarkedAsChargeOff) {
            createJournalEntriesForChargeOffLoanChargeAdjustment(loanDTO, loanTransactionDTO, officeId);
        } else {
            createJournalEntriesForLoanChargeAdjustment(loanDTO, loanTransactionDTO, officeId);
        }
    }

    private void createJournalEntriesForChargeOffLoanChargeAdjustment(LoanDTO loanDTO, LoanTransactionDTO loanTransactionDTO, long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal principalAmount = loanTransactionDTO.getPrincipal();
        final BigDecimal interestAmount = loanTransactionDTO.getInterest();
        final BigDecimal feesAmount = loanTransactionDTO.getFees();
        final BigDecimal penaltiesAmount = loanTransactionDTO.getPenalties();
        final BigDecimal overPaymentAmount = loanTransactionDTO.getOverPayment();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        BigDecimal totalDebitAmount = new BigDecimal(0);
        Map<GLAccount, BigDecimal> accountMap = new LinkedHashMap<>();
        // handle principal payment
        if (MathUtil.isGreaterThanZero(principalAmount)) {
            totalDebitAmount = totalDebitAmount.add(principalAmount);
            GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_FEES.getValue(), paymentTypeId);
            accountMap.put(account, principalAmount);
        }
        // handle interest payment
        if (MathUtil.isGreaterThanZero(interestAmount)) {
            totalDebitAmount = totalDebitAmount.add(interestAmount);
            GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_FEES.getValue(), paymentTypeId);
            if (accountMap.containsKey(account)) {
                BigDecimal amount = accountMap.get(account).add(interestAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, interestAmount);
            }
        }
        // handle fees payment
        if (MathUtil.isGreaterThanZero(feesAmount)) {
            totalDebitAmount = totalDebitAmount.add(feesAmount);
            GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_FEES.getValue(), paymentTypeId);
            if (accountMap.containsKey(account)) {
                BigDecimal amount = accountMap.get(account).add(feesAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, feesAmount);
            }
        }
        // handle penalty payment
        if (MathUtil.isGreaterThanZero(penaltiesAmount)) {
            totalDebitAmount = totalDebitAmount.add(penaltiesAmount);
            GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_PENALTY.getValue(), paymentTypeId);
            if (accountMap.containsKey(account)) {
                BigDecimal amount = accountMap.get(account).add(penaltiesAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, penaltiesAmount);
            }
        }
        // handle overpayment
        if (MathUtil.isGreaterThanZero(overPaymentAmount)) {
            totalDebitAmount = totalDebitAmount.add(overPaymentAmount);
            GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.OVERPAYMENT.getValue(), paymentTypeId);
            if (accountMap.containsKey(account)) {
                BigDecimal amount = accountMap.get(account).add(overPaymentAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, overPaymentAmount);
            }
        }
        for (Map.Entry<GLAccount, BigDecimal> entry : accountMap.entrySet()) {
            if (MathUtil.isGreaterThanZero(entry.getValue())) {
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, entry.getValue(), entry.getKey());
            }
        }
        if (MathUtil.isGreaterThanZero(totalDebitAmount)) {
            Long chargeId = loanTransactionDTO.getLoanChargeData().getChargeId();
            Integer accountMappingTypeId;
            if (loanTransactionDTO.getLoanChargeData().isPenalty()) {
                accountMappingTypeId = AccrualAccountsForLoan.INCOME_FROM_PENALTIES.getValue();
            } else {
                accountMappingTypeId = AccrualAccountsForLoan.INCOME_FROM_FEES.getValue();
            }
            this.helper.createDebitJournalEntryForLoanCharges(officeId, currencyCode, accountMappingTypeId, loanProductId, chargeId, loanId, transactionId, transactionDate, totalDebitAmount);
        }
    }

    private void createJournalEntriesForLoanChargeAdjustment(LoanDTO loanDTO, LoanTransactionDTO loanTransactionDTO, long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal principalAmount = loanTransactionDTO.getPrincipal();
        final BigDecimal interestAmount = loanTransactionDTO.getInterest();
        final BigDecimal feesAmount = loanTransactionDTO.getFees();
        final BigDecimal penaltiesAmount = loanTransactionDTO.getPenalties();
        final BigDecimal overPaymentAmount = loanTransactionDTO.getOverPayment();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        BigDecimal totalDebitAmount = new BigDecimal(0);
        Map<GLAccount, BigDecimal> accountMap = new LinkedHashMap<>();
        // handle principal payment
        if (MathUtil.isGreaterThanZero(principalAmount)) {
            totalDebitAmount = totalDebitAmount.add(principalAmount);
            GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue(), paymentTypeId);
            accountMap.put(account, principalAmount);
        }
        // handle interest payment
        if (MathUtil.isGreaterThanZero(interestAmount)) {
            totalDebitAmount = totalDebitAmount.add(interestAmount);
            GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.INTEREST_RECEIVABLE.getValue(), paymentTypeId);
            if (accountMap.containsKey(account)) {
                BigDecimal amount = accountMap.get(account).add(interestAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, interestAmount);
            }
        }
        // handle fees payment
        if (MathUtil.isGreaterThanZero(feesAmount)) {
            totalDebitAmount = totalDebitAmount.add(feesAmount);
            GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.FEES_RECEIVABLE.getValue(), paymentTypeId);
            if (accountMap.containsKey(account)) {
                BigDecimal amount = accountMap.get(account).add(feesAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, feesAmount);
            }
        }
        // handle penalties payment
        if (MathUtil.isGreaterThanZero(penaltiesAmount)) {
            totalDebitAmount = totalDebitAmount.add(penaltiesAmount);
            GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.PENALTIES_RECEIVABLE.getValue(), paymentTypeId);
            if (accountMap.containsKey(account)) {
                BigDecimal amount = accountMap.get(account).add(penaltiesAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, penaltiesAmount);
            }
        }
        // handle overpayment
        if (MathUtil.isGreaterThanZero(overPaymentAmount)) {
            totalDebitAmount = totalDebitAmount.add(overPaymentAmount);
            GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.OVERPAYMENT.getValue(), paymentTypeId);
            if (accountMap.containsKey(account)) {
                BigDecimal amount = accountMap.get(account).add(overPaymentAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, overPaymentAmount);
            }
        }
        for (Map.Entry<GLAccount, BigDecimal> entry : accountMap.entrySet()) {
            if (MathUtil.isGreaterThanZero(entry.getValue())) {
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, entry.getValue(), entry.getKey());
            }
        }
        if (MathUtil.isGreaterThanZero(totalDebitAmount)) {
            Long chargeId = loanTransactionDTO.getLoanChargeData().getChargeId();
            Integer accountMappingTypeId;
            if (loanTransactionDTO.getLoanChargeData().isPenalty()) {
                accountMappingTypeId = AccrualAccountsForLoan.INCOME_FROM_PENALTIES.getValue();
            } else {
                accountMappingTypeId = AccrualAccountsForLoan.INCOME_FROM_FEES.getValue();
            }
            this.helper.createDebitJournalEntryForLoanCharges(officeId, currencyCode, accountMappingTypeId, loanProductId, chargeId, loanId, transactionId, transactionDate, totalDebitAmount);
        }
    }

    /**
     * Handle chargeback journal entry creation
     *
     * @param loanDTO
     * @param loanTransactionDTO
     * @param officeId
     */
    private void createJournalEntriesForChargeback(LoanDTO loanDTO, LoanTransactionDTO loanTransactionDTO, long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal amount = loanTransactionDTO.getAmount();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        final BigDecimal overpaidAmount = Objects.isNull(loanTransactionDTO.getOverPayment()) ? BigDecimal.ZERO : loanTransactionDTO.getOverPayment();
        final BigDecimal principalCredited = Objects.isNull(loanTransactionDTO.getPrincipal()) ? BigDecimal.ZERO : loanTransactionDTO.getPrincipal();
        final BigDecimal feeCredited = Objects.isNull(loanTransactionDTO.getFees()) ? BigDecimal.ZERO : loanTransactionDTO.getFees();
        final BigDecimal penaltyCredited = Objects.isNull(loanTransactionDTO.getPenalties()) ? BigDecimal.ZERO : loanTransactionDTO.getPenalties();
        final BigDecimal principalPaid = Objects.isNull(loanTransactionDTO.getPrincipalPaid()) ? BigDecimal.ZERO : loanTransactionDTO.getPrincipalPaid();
        final BigDecimal feePaid = Objects.isNull(loanTransactionDTO.getFeePaid()) ? BigDecimal.ZERO : loanTransactionDTO.getFeePaid();
        final BigDecimal penaltyPaid = Objects.isNull(loanTransactionDTO.getPenaltyPaid()) ? BigDecimal.ZERO : loanTransactionDTO.getPenaltyPaid();
        if (MathUtil.isGreaterThanZero(amount)) {
            helper.createCreditJournalEntryForLoan(officeId, currencyCode, AccrualAccountsForLoan.FUND_SOURCE, loanProductId, paymentTypeId, loanId, transactionId, transactionDate, amount);
        }
        if (MathUtil.isGreaterThanZero(overpaidAmount)) {
            helper.createDebitJournalEntryForLoan(officeId, currencyCode, AccrualAccountsForLoan.OVERPAYMENT.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, overpaidAmount);
        }
        if (principalCredited.compareTo(principalPaid) > 0) {
            helper.createDebitJournalEntryForLoan(officeId, currencyCode, getPrincipalAccount(loanDTO), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, principalCredited.subtract(principalPaid));
        } else if (principalCredited.compareTo(principalPaid) < 0) {
            helper.createCreditJournalEntryForLoan(officeId, currencyCode, getPrincipalAccount(loanDTO), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, principalPaid.subtract(principalCredited));
        }
        if (feeCredited.compareTo(feePaid) > 0) {
            helper.createDebitJournalEntryForLoan(officeId, currencyCode, getFeeAccount(loanDTO), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, feeCredited.subtract(feePaid));
        } else if (feeCredited.compareTo(feePaid) < 0) {
            helper.createCreditJournalEntryForLoan(officeId, currencyCode, getFeeAccount(loanDTO), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, feePaid.subtract(feeCredited));
        }
        if (penaltyCredited.compareTo(penaltyPaid) > 0) {
            helper.createDebitJournalEntryForLoan(officeId, currencyCode, getPenaltyAccount(loanDTO), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, penaltyCredited.subtract(penaltyPaid));
        } else if (penaltyCredited.compareTo(penaltyPaid) < 0) {
            helper.createCreditJournalEntryForLoan(officeId, currencyCode, getPenaltyAccount(loanDTO), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, penaltyPaid.subtract(penaltyCredited));
        }
    }

    private Integer getFeeAccount(LoanDTO loanDTO) {
        Integer account = AccrualAccountsForLoan.FEES_RECEIVABLE.getValue();
        if (loanDTO.isMarkedAsChargeOff()) {
            account = AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_FEES.getValue();
        }
        return account;
    }

    private Integer getPenaltyAccount(LoanDTO loanDTO) {
        Integer account = AccrualAccountsForLoan.PENALTIES_RECEIVABLE.getValue();
        if (loanDTO.isMarkedAsChargeOff()) {
            account = AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_PENALTY.getValue();
        }
        return account;
    }

    private Integer getPrincipalAccount(LoanDTO loanDTO) {
        if (loanDTO.isMarkedAsFraud() && loanDTO.isMarkedAsChargeOff()) {
            return AccrualAccountsForLoan.CHARGE_OFF_FRAUD_EXPENSE.getValue();
        } else if (!loanDTO.isMarkedAsFraud() && loanDTO.isMarkedAsChargeOff()) {
            return AccrualAccountsForLoan.CHARGE_OFF_EXPENSE.getValue();
        } else {
            return AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue();
        }
    }

    /**
     * Debit loan Portfolio and credit Fund source for Disbursement.
     *
     * @param loanDTO
     * @param loanTransactionDTO
     * @param officeId
     */
    private void createJournalEntriesForDisbursements(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal overpaymentPortion = loanTransactionDTO.getOverPayment() != null ? loanTransactionDTO.getOverPayment() : BigDecimal.ZERO;
        final BigDecimal loanTransactionDTOAmount = loanTransactionDTO.getAmount();
        final BigDecimal principalPortion = loanTransactionDTOAmount.subtract(overpaymentPortion);
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        // create journal entries for the disbursement
        if (MathUtil.isGreaterThanZero(principalPortion)) {
            this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, principalPortion);
        }
        if (MathUtil.isGreaterThanZero(overpaymentPortion)) {
            this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, AccrualAccountsForLoan.OVERPAYMENT.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, overpaymentPortion);
        }
        if (MathUtil.isGreaterThanZero(loanTransactionDTOAmount)) {
            if (loanTransactionDTO.isLoanToLoanTransfer()) {
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, FinancialActivity.ASSET_TRANSFER.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, loanTransactionDTOAmount);
            } else if (loanTransactionDTO.isAccountTransfer()) {
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, FinancialActivity.LIABILITY_TRANSFER.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, loanTransactionDTOAmount);
            } else {
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, AccrualAccountsForLoan.FUND_SOURCE.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, loanTransactionDTOAmount);
            }
        }
    }

    /**
     * Handles repayments using the following posting rules <br/>
     * <br/>
     * <br/>
     *
     * <b>Principal Repayment</b>: Debits "Fund Source" and Credits "Loan Portfolio"<br/>
     *
     * <b>Interest Repayment</b>:Debits "Fund Source" and Credits "Receivable Interest" <br/>
     *
     * <b>Fee Repayment</b>:Debits "Fund Source" (or "Interest on Loans" in case of repayment at disbursement) and
     * Credits "Receivable Fees" <br/>
     *
     * <b>Penalty Repayment</b>: Debits "Fund Source" and Credits "Receivable Penalties" <br/>
     * <br/>
     *
     * @param loanTransactionDTO
     * @param loanDTO
     * @param officeId
     */
    private void createJournalEntriesForRepayments(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId, final boolean isIncomeFromFee) {
        final boolean isMarkedChargeOff = loanDTO.isMarkedAsChargeOff();
        if (isMarkedChargeOff) {
            createJournalEntriesForRepaymentWhenLoanIsChargedOff(loanDTO, loanTransactionDTO, officeId, isIncomeFromFee);
        } else {
            createJournalEntriesForLoanRepayments(loanDTO, loanTransactionDTO, officeId, isIncomeFromFee);
        }
    }

    private void createJournalEntriesForWriteOffs(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        final boolean isMarkedChargeOff = loanDTO.isMarkedAsChargeOff();
        if (isMarkedChargeOff) {
            createJournalEntriesForWriteOffsWhenLoanIsChargedOff(loanDTO, loanTransactionDTO, officeId);
        } else {
            createJournalEntriesForLoanWriteOffs(loanDTO, loanTransactionDTO, officeId);
        }
    }

    private void createJournalEntriesForRepaymentWhenLoanIsChargedOff(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId, final boolean isIncomeFromFee) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        final boolean isMarkedFraud = loanDTO.isMarkedAsFraud();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal principalAmount = loanTransactionDTO.getPrincipal();
        final BigDecimal interestAmount = loanTransactionDTO.getInterest();
        final BigDecimal feesAmount = loanTransactionDTO.getFees();
        final BigDecimal penaltiesAmount = loanTransactionDTO.getPenalties();
        final BigDecimal overPaymentAmount = loanTransactionDTO.getOverPayment();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        final GLAccountBalanceHolder glAccountBalanceHolder = new GLAccountBalanceHolder();
        BigDecimal totalDebitAmount = new BigDecimal(0);
        // principal payment
        if (MathUtil.isGreaterThanZero(principalAmount)) {
            totalDebitAmount = totalDebitAmount.add(principalAmount);
            if (loanTransactionDTO.getTransactionType().isMerchantIssuedRefund()) {
                if (isMarkedFraud) {
                    populateCreditDebitMaps(loanProductId, principalAmount, paymentTypeId, AccrualAccountsForLoan.CHARGE_OFF_FRAUD_EXPENSE.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
                } else {
                    populateCreditDebitMaps(loanProductId, principalAmount, paymentTypeId, AccrualAccountsForLoan.CHARGE_OFF_EXPENSE.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
                }
            } else if (loanTransactionDTO.getTransactionType().isPayoutRefund()) {
                if (isMarkedFraud) {
                    populateCreditDebitMaps(loanProductId, principalAmount, paymentTypeId, AccrualAccountsForLoan.CHARGE_OFF_FRAUD_EXPENSE.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
                } else {
                    populateCreditDebitMaps(loanProductId, principalAmount, paymentTypeId, AccrualAccountsForLoan.CHARGE_OFF_EXPENSE.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
                }
            } else if (loanTransactionDTO.getTransactionType().isGoodwillCredit()) {
                populateCreditDebitMaps(loanProductId, principalAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_RECOVERY.getValue(), AccrualAccountsForLoan.GOODWILL_CREDIT.getValue(), glAccountBalanceHolder);
            } else if (loanTransactionDTO.getTransactionType().isRepayment()) {
                populateCreditDebitMaps(loanProductId, principalAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_RECOVERY.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            } else {
                populateCreditDebitMaps(loanProductId, principalAmount, paymentTypeId, AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            }
        }
        // interest payment
        if (MathUtil.isGreaterThanZero(interestAmount)) {
            totalDebitAmount = totalDebitAmount.add(interestAmount);
            if (loanTransactionDTO.getTransactionType().isMerchantIssuedRefund()) {
                populateCreditDebitMaps(loanProductId, interestAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_INTEREST.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            } else if (loanTransactionDTO.getTransactionType().isPayoutRefund()) {
                populateCreditDebitMaps(loanProductId, interestAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_INTEREST.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            } else if (loanTransactionDTO.getTransactionType().isGoodwillCredit()) {
                populateCreditDebitMaps(loanProductId, interestAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_RECOVERY.getValue(), AccrualAccountsForLoan.INCOME_FROM_GOODWILL_CREDIT_INTEREST.getValue(), glAccountBalanceHolder);
            } else if (loanTransactionDTO.getTransactionType().isRepayment()) {
                populateCreditDebitMaps(loanProductId, interestAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_RECOVERY.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            } else {
                populateCreditDebitMaps(loanProductId, interestAmount, paymentTypeId, AccrualAccountsForLoan.INTEREST_RECEIVABLE.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            }
        }
        // handle fees payment
        if (MathUtil.isGreaterThanZero(feesAmount)) {
            totalDebitAmount = totalDebitAmount.add(feesAmount);
            if (loanTransactionDTO.getTransactionType().isMerchantIssuedRefund()) {
                populateCreditDebitMaps(loanProductId, feesAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_FEES.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            } else if (loanTransactionDTO.getTransactionType().isPayoutRefund()) {
                populateCreditDebitMaps(loanProductId, feesAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_FEES.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            } else if (loanTransactionDTO.getTransactionType().isGoodwillCredit()) {
                populateCreditDebitMaps(loanProductId, feesAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_RECOVERY.getValue(), AccrualAccountsForLoan.INCOME_FROM_GOODWILL_CREDIT_FEES.getValue(), glAccountBalanceHolder);
            } else if (loanTransactionDTO.getTransactionType().isRepayment()) {
                populateCreditDebitMaps(loanProductId, feesAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_RECOVERY.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            } else {
                if (isIncomeFromFee) {
                    this.helper.createCreditJournalEntryForLoanCharges(officeId, currencyCode, AccrualAccountsForLoan.INCOME_FROM_FEES.getValue(), loanProductId, loanId, transactionId, transactionDate, feesAmount, loanTransactionDTO.getFeePayments());
                    final GLAccount debitAccount = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.FUND_SOURCE.getValue(), paymentTypeId);
                    glAccountBalanceHolder.addToDebit(debitAccount, feesAmount);
                } else {
                    populateCreditDebitMaps(loanProductId, feesAmount, paymentTypeId, AccrualAccountsForLoan.FEES_RECEIVABLE.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
                }
            }
        }
        // handle penalties
        if (MathUtil.isGreaterThanZero(penaltiesAmount)) {
            totalDebitAmount = totalDebitAmount.add(penaltiesAmount);
            if (loanTransactionDTO.getTransactionType().isMerchantIssuedRefund()) {
                populateCreditDebitMaps(loanProductId, penaltiesAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_PENALTY.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            } else if (loanTransactionDTO.getTransactionType().isPayoutRefund()) {
                populateCreditDebitMaps(loanProductId, penaltiesAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_PENALTY.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            } else if (loanTransactionDTO.getTransactionType().isGoodwillCredit()) {
                populateCreditDebitMaps(loanProductId, penaltiesAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_RECOVERY.getValue(), AccrualAccountsForLoan.INCOME_FROM_GOODWILL_CREDIT_PENALTY.getValue(), glAccountBalanceHolder);
            } else if (loanTransactionDTO.getTransactionType().isRepayment()) {
                populateCreditDebitMaps(loanProductId, penaltiesAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_RECOVERY.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            } else {
                if (isIncomeFromFee) {
                    populateCreditDebitMaps(loanProductId, penaltiesAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_PENALTIES.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
                } else {
                    populateCreditDebitMaps(loanProductId, penaltiesAmount, paymentTypeId, AccrualAccountsForLoan.PENALTIES_RECEIVABLE.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
                }
            }
        }
        // overpayment
        if (MathUtil.isGreaterThanZero(overPaymentAmount)) {
            totalDebitAmount = totalDebitAmount.add(overPaymentAmount);
            if (loanTransactionDTO.getTransactionType().isMerchantIssuedRefund()) {
                populateCreditDebitMaps(loanProductId, overPaymentAmount, paymentTypeId, AccrualAccountsForLoan.OVERPAYMENT.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            } else if (loanTransactionDTO.getTransactionType().isPayoutRefund()) {
                populateCreditDebitMaps(loanProductId, overPaymentAmount, paymentTypeId, AccrualAccountsForLoan.OVERPAYMENT.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            } else if (loanTransactionDTO.getTransactionType().isGoodwillCredit()) {
                populateCreditDebitMaps(loanProductId, overPaymentAmount, paymentTypeId, AccrualAccountsForLoan.OVERPAYMENT.getValue(), AccrualAccountsForLoan.GOODWILL_CREDIT.getValue(), glAccountBalanceHolder);
            } else {
                populateCreditDebitMaps(loanProductId, overPaymentAmount, paymentTypeId, AccrualAccountsForLoan.OVERPAYMENT.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            }
        }
        // create credit entries
        for (Map.Entry<Long, BigDecimal> creditEntry : glAccountBalanceHolder.getCreditBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(creditEntry.getValue())) {
                final GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(creditEntry.getKey());
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, creditEntry.getValue(), glAccount);
            }
        }
        if (MathUtil.isGreaterThanZero(totalDebitAmount)) {
            if (loanTransactionDTO.isLoanToLoanTransfer()) {
                this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, FinancialActivity.ASSET_TRANSFER.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, totalDebitAmount);
            } else if (loanTransactionDTO.isAccountTransfer()) {
                this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, FinancialActivity.LIABILITY_TRANSFER.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, totalDebitAmount);
            } else {
                // create debit entries
                for (Map.Entry<Long, BigDecimal> debitEntry : glAccountBalanceHolder.getDebitBalances().entrySet()) {
                    final GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(debitEntry.getKey());
                    this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, debitEntry.getValue(), glAccount);
                }
            }
        }
        if (MathUtil.isGreaterThanZero(totalDebitAmount)) {
            if (loanTransactionDTO.getTransactionType().isChargeRefund()) {
                /**
                 * Charge Refunds have an extra refund related pair of journal entries in addition to those related to the
                 * repayment above
                 * *
                 */
                final Integer incomeAccount = this.helper.getValueForFeeOrPenaltyIncomeAccount(loanTransactionDTO.getChargeRefundChargeType());
                this.helper.createJournalEntriesForLoan(officeId, currencyCode, incomeAccount, AccrualAccountsForLoan.FUND_SOURCE.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, totalDebitAmount);
            }
        }
    }

    private void createJournalEntriesForWriteOffsWhenLoanIsChargedOff(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        final boolean isMarkedFraud = loanDTO.isMarkedAsFraud();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal principalAmount = loanTransactionDTO.getPrincipal();
        final BigDecimal interestAmount = loanTransactionDTO.getInterest();
        final BigDecimal feesAmount = loanTransactionDTO.getFees();
        final BigDecimal penaltiesAmount = loanTransactionDTO.getPenalties();
        final BigDecimal overPaymentAmount = loanTransactionDTO.getOverPayment();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        final GLAccountBalanceHolder glAccountBalanceHolder = new GLAccountBalanceHolder();
        BigDecimal totalDebitAmount = new BigDecimal(0);
        // principal payment
        if (MathUtil.isGreaterThanZero(principalAmount)) {
            totalDebitAmount = totalDebitAmount.add(principalAmount);
            if (isMarkedFraud) {
                populateCreditDebitMaps(loanProductId, principalAmount, paymentTypeId, AccrualAccountsForLoan.CHARGE_OFF_FRAUD_EXPENSE.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            } else {
                populateCreditDebitMaps(loanProductId, principalAmount, paymentTypeId, AccrualAccountsForLoan.CHARGE_OFF_EXPENSE.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
            }
        }
        // interest payment
        if (MathUtil.isGreaterThanZero(interestAmount)) {
            totalDebitAmount = totalDebitAmount.add(interestAmount);
            populateCreditDebitMaps(loanProductId, interestAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_INTEREST.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
        }
        // handle fees payment
        if (MathUtil.isGreaterThanZero(feesAmount)) {
            totalDebitAmount = totalDebitAmount.add(feesAmount);
            populateCreditDebitMaps(loanProductId, feesAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_FEES.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
        }
        // handle penalties
        if (MathUtil.isGreaterThanZero(penaltiesAmount)) {
            totalDebitAmount = totalDebitAmount.add(penaltiesAmount);
            populateCreditDebitMaps(loanProductId, penaltiesAmount, paymentTypeId, AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_PENALTY.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
        }
        // overpayment
        if (MathUtil.isGreaterThanZero(overPaymentAmount)) {
            totalDebitAmount = totalDebitAmount.add(overPaymentAmount);
            populateCreditDebitMaps(loanProductId, overPaymentAmount, paymentTypeId, AccrualAccountsForLoan.OVERPAYMENT.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), glAccountBalanceHolder);
        }
        // create credit entries
        for (Map.Entry<Long, BigDecimal> creditEntry : glAccountBalanceHolder.getCreditBalances().entrySet()) {
            if (MathUtil.isGreaterThanZero(creditEntry.getValue())) {
                final GLAccount glAccount = glAccountBalanceHolder.getGlAccountMap().get(creditEntry.getKey());
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, creditEntry.getValue(), glAccount);
            }
        }
        if (MathUtil.isGreaterThanZero(totalDebitAmount)) {
            this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, AccrualAccountsForLoan.LOSSES_WRITTEN_OFF.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, totalDebitAmount);
        }
    }

    private void createJournalEntriesForLoanRepayments(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId, final boolean isIncomeFromFee) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal principalAmount = loanTransactionDTO.getPrincipal();
        final BigDecimal interestAmount = loanTransactionDTO.getInterest();
        final BigDecimal feesAmount = loanTransactionDTO.getFees();
        final BigDecimal penaltiesAmount = loanTransactionDTO.getPenalties();
        final BigDecimal overPaymentAmount = loanTransactionDTO.getOverPayment();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        BigDecimal totalDebitAmount = new BigDecimal(0);
        final Map<GLAccount, BigDecimal> accountMap = new LinkedHashMap<>();
        final Map<Integer, BigDecimal> debitAccountMapForGoodwillCredit = new LinkedHashMap<>();
        // handle principal payment
        if (MathUtil.isGreaterThanZero(principalAmount)) {
            totalDebitAmount = totalDebitAmount.add(principalAmount);
            final GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue(), paymentTypeId);
            accountMap.put(account, principalAmount);
            if (loanTransactionDTO.getTransactionType().isGoodwillCredit()) {
                loanCommonAccountingHelper.populateDebitAccountEntry(loanProductId, principalAmount, AccrualAccountsForLoan.GOODWILL_CREDIT.getValue(), debitAccountMapForGoodwillCredit, paymentTypeId);
            }
        }
        // handle interest payment
        if (MathUtil.isGreaterThanZero(interestAmount)) {
            totalDebitAmount = totalDebitAmount.add(interestAmount);
            final GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.INTEREST_RECEIVABLE.getValue(), paymentTypeId);
            if (accountMap.containsKey(account)) {
                final BigDecimal amount = accountMap.get(account).add(interestAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, interestAmount);
            }
            if (loanTransactionDTO.getTransactionType().isGoodwillCredit()) {
                loanCommonAccountingHelper.populateDebitAccountEntry(loanProductId, interestAmount, AccrualAccountsForLoan.INCOME_FROM_GOODWILL_CREDIT_INTEREST.getValue(), debitAccountMapForGoodwillCredit, paymentTypeId);
            }
        }
        // handle fees payment
        if (MathUtil.isGreaterThanZero(feesAmount)) {
            totalDebitAmount = totalDebitAmount.add(feesAmount);
            if (isIncomeFromFee) {
                final List<ChargeTaxPaymentDTO> feeTaxPayments = loanCommonAccountingHelper.filterTaxPayments(loanTransactionDTO, false);
                final BigDecimal feeTaxTotal = loanCommonAccountingHelper.sumTaxAmounts(feeTaxPayments);
                if (feeTaxTotal.compareTo(BigDecimal.ZERO) > 0) {
                    final BigDecimal netFees = feesAmount.subtract(feeTaxTotal);
                    this.helper.createCreditJournalEntryForLoanCharges(officeId, currencyCode, AccrualAccountsForLoan.INCOME_FROM_FEES.getValue(), loanProductId, loanId, transactionId, transactionDate, netFees, loanCommonAccountingHelper.computeNetChargePayments(loanTransactionDTO.getFeePayments(), feeTaxPayments));
                    loanCommonAccountingHelper.createTaxLiabilityCreditEntries(officeId, currencyCode, loanId, transactionId, transactionDate, feeTaxPayments);
                } else {
                    this.helper.createCreditJournalEntryForLoanCharges(officeId, currencyCode, AccrualAccountsForLoan.INCOME_FROM_FEES.getValue(), loanProductId, loanId, transactionId, transactionDate, feesAmount, loanTransactionDTO.getFeePayments());
                }
            } else {
                final GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.FEES_RECEIVABLE.getValue(), paymentTypeId);
                if (accountMap.containsKey(account)) {
                    final BigDecimal amount = accountMap.get(account).add(feesAmount);
                    accountMap.put(account, amount);
                } else {
                    accountMap.put(account, feesAmount);
                }
            }
            if (loanTransactionDTO.getTransactionType().isGoodwillCredit()) {
                loanCommonAccountingHelper.populateDebitAccountEntry(loanProductId, feesAmount, AccrualAccountsForLoan.INCOME_FROM_GOODWILL_CREDIT_FEES.getValue(), debitAccountMapForGoodwillCredit, paymentTypeId);
            }
        }
        // handle penalties payment
        if (MathUtil.isGreaterThanZero(penaltiesAmount)) {
            totalDebitAmount = totalDebitAmount.add(penaltiesAmount);
            if (isIncomeFromFee) {
                final GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.INCOME_FROM_PENALTIES.getValue(), paymentTypeId);
                if (accountMap.containsKey(account)) {
                    final BigDecimal amount = accountMap.get(account).add(penaltiesAmount);
                    accountMap.put(account, amount);
                } else {
                    accountMap.put(account, penaltiesAmount);
                }
            } else {
                final GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.PENALTIES_RECEIVABLE.getValue(), paymentTypeId);
                if (accountMap.containsKey(account)) {
                    final BigDecimal amount = accountMap.get(account).add(penaltiesAmount);
                    accountMap.put(account, amount);
                } else {
                    accountMap.put(account, penaltiesAmount);
                }
            }
            if (loanTransactionDTO.getTransactionType().isGoodwillCredit()) {
                loanCommonAccountingHelper.populateDebitAccountEntry(loanProductId, penaltiesAmount, AccrualAccountsForLoan.INCOME_FROM_GOODWILL_CREDIT_PENALTY.getValue(), debitAccountMapForGoodwillCredit, paymentTypeId);
            }
        }
        if (MathUtil.isGreaterThanZero(overPaymentAmount)) {
            totalDebitAmount = totalDebitAmount.add(overPaymentAmount);
            final GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.OVERPAYMENT.getValue(), paymentTypeId);
            if (accountMap.containsKey(account)) {
                final BigDecimal amount = accountMap.get(account).add(overPaymentAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, overPaymentAmount);
            }
            if (loanTransactionDTO.getTransactionType().isGoodwillCredit()) {
                loanCommonAccountingHelper.populateDebitAccountEntry(loanProductId, overPaymentAmount, AccrualAccountsForLoan.GOODWILL_CREDIT.getValue(), debitAccountMapForGoodwillCredit, paymentTypeId);
            }
        }
        for (Map.Entry<GLAccount, BigDecimal> entry : accountMap.entrySet()) {
            if (MathUtil.isGreaterThanZero(entry.getValue())) {
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, entry.getValue(), entry.getKey());
            }
        }
        if (MathUtil.isGreaterThanZero(totalDebitAmount)) {
            if (loanTransactionDTO.isLoanToLoanTransfer()) {
                this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, FinancialActivity.ASSET_TRANSFER.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, totalDebitAmount);
            } else if (loanTransactionDTO.isAccountTransfer()) {
                this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, FinancialActivity.LIABILITY_TRANSFER.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, totalDebitAmount);
            } else {
                if (loanTransactionDTO.getTransactionType().isGoodwillCredit()) {
                    // create debit entries
                    for (Map.Entry<Integer, BigDecimal> debitEntry : debitAccountMapForGoodwillCredit.entrySet()) {
                        this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, debitEntry.getKey().intValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, debitEntry.getValue());
                    }
                } else {
                    this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, AccrualAccountsForLoan.FUND_SOURCE.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, totalDebitAmount);
                }
            }
        }
        if (MathUtil.isGreaterThanZero(totalDebitAmount) && loanTransactionDTO.getTransactionType().isChargeRefund()) {
            /**
             * Charge Refunds have an extra refund related pair of journal entries in addition to those related to the
             * repayment above
             * *
             */
            final Integer incomeAccount = this.helper.getValueForFeeOrPenaltyIncomeAccount(loanTransactionDTO.getChargeRefundChargeType());
            this.helper.createJournalEntriesForLoan(officeId, currencyCode, incomeAccount, AccrualAccountsForLoan.FUND_SOURCE.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, totalDebitAmount);
        }
    }

    private void createJournalEntriesForLoanWriteOffs(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal principalAmount = loanTransactionDTO.getPrincipal();
        final BigDecimal interestAmount = loanTransactionDTO.getInterest();
        final BigDecimal feesAmount = loanTransactionDTO.getFees();
        final BigDecimal penaltiesAmount = loanTransactionDTO.getPenalties();
        final BigDecimal overPaymentAmount = loanTransactionDTO.getOverPayment();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        BigDecimal totalDebitAmount = new BigDecimal(0);
        final Map<GLAccount, BigDecimal> accountMap = new LinkedHashMap<>();
        // handle principal payment of writeOff
        if (MathUtil.isGreaterThanZero(principalAmount)) {
            totalDebitAmount = totalDebitAmount.add(principalAmount);
            final GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue(), paymentTypeId);
            accountMap.put(account, principalAmount);
        }
        // handle interest payment of writeOff
        if (MathUtil.isGreaterThanZero(interestAmount)) {
            totalDebitAmount = totalDebitAmount.add(interestAmount);
            final GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.INTEREST_RECEIVABLE.getValue(), paymentTypeId);
            if (accountMap.containsKey(account)) {
                final BigDecimal amount = accountMap.get(account).add(interestAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, interestAmount);
            }
        }
        // handle fees payment of writeOff
        if (MathUtil.isGreaterThanZero(feesAmount)) {
            totalDebitAmount = totalDebitAmount.add(feesAmount);
            final GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.FEES_RECEIVABLE.getValue(), paymentTypeId);
            if (accountMap.containsKey(account)) {
                final BigDecimal amount = accountMap.get(account).add(feesAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, feesAmount);
            }
        }
        // handle penalties payment of writeOff
        if (MathUtil.isGreaterThanZero(penaltiesAmount)) {
            totalDebitAmount = totalDebitAmount.add(penaltiesAmount);
            final GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.PENALTIES_RECEIVABLE.getValue(), paymentTypeId);
            if (accountMap.containsKey(account)) {
                final BigDecimal amount = accountMap.get(account).add(penaltiesAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, penaltiesAmount);
            }
        }
        if (MathUtil.isGreaterThanZero(overPaymentAmount)) {
            totalDebitAmount = totalDebitAmount.add(overPaymentAmount);
            final GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccrualAccountsForLoan.OVERPAYMENT.getValue(), paymentTypeId);
            if (accountMap.containsKey(account)) {
                final BigDecimal amount = accountMap.get(account).add(overPaymentAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, overPaymentAmount);
            }
        }
        for (Map.Entry<GLAccount, BigDecimal> entry : accountMap.entrySet()) {
            if (MathUtil.isGreaterThanZero(entry.getValue())) {
                this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, loanId, transactionId, transactionDate, entry.getValue(), entry.getKey());
            }
        }
        if (MathUtil.isGreaterThanZero(totalDebitAmount)) {
            /**
             * Single DEBIT transaction for write-offs
             * *
             */
            final AdvancedMappingtDTO writeAdvancedMappingtDTO = loanDTO.getWriteOffReasonAdvancedMappingData();
            final ProductToGLAccountMapping mapping = (writeAdvancedMappingtDTO != null && writeAdvancedMappingtDTO.getReferenceValueId() != null) ? helper.getWriteOffMappingByCodeValue(loanProductId, PortfolioProductType.LOAN, writeAdvancedMappingtDTO.getReferenceValueId()) : null;
            if (mapping == null) {
                this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, AccrualAccountsForLoan.LOSSES_WRITTEN_OFF.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, totalDebitAmount);
            } else {
                this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, leftoverGlAccount(mapping), loanId, transactionId, transactionDate, totalDebitAmount);
            }
        }
    }

    /**
     * Create a single Debit to fund source and a single credit to "Income from Recovery"
     */
    private void createJournalEntriesForRecoveryRepayments(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal amount = loanTransactionDTO.getAmount();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        if (MathUtil.isGreaterThanZero(amount)) {
            this.helper.createJournalEntriesForLoan(officeId, currencyCode, AccrualAccountsForLoan.FUND_SOURCE.getValue(), AccrualAccountsForLoan.INCOME_FROM_RECOVERY.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, amount);
        }
    }

    /**
     * Recognize the receivable interest <br/>
     * Debit "Interest Receivable" and Credit "Income from Interest"
     *
     * <b>Fees:</b> Debit <i>Fees Receivable</i> and credit <i>Income from Fees</i> <br/>
     *
     * <b>Penalties:</b> Debit <i>Penalties Receivable</i> and credit <i>Income from Penalties</i>
     *
     * @param loanDTO
     * @param loanTransactionDTO
     * @param officeId
     */
    private void createJournalEntriesForAccruals(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final LoanTransactionEnumData transactionType = loanTransactionDTO.getTransactionType();
        final BigDecimal interestAmount = loanTransactionDTO.getInterest();
        final BigDecimal feesAmount = loanTransactionDTO.getFees();
        final BigDecimal penaltiesAmount = loanTransactionDTO.getPenalties();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        // create journal entries for recognizing interest
        if (MathUtil.isGreaterThanZero(interestAmount)) {
            if (transactionType.isAccrualAdjustment()) {
                this.helper.createJournalEntriesForLoan(officeId, currencyCode, AccrualAccountsForLoan.INTEREST_ON_LOANS.getValue(), AccrualAccountsForLoan.INTEREST_RECEIVABLE.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, interestAmount);
            } else {
                this.helper.createJournalEntriesForLoan(officeId, currencyCode, AccrualAccountsForLoan.INTEREST_RECEIVABLE.getValue(), AccrualAccountsForLoan.INTEREST_ON_LOANS.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, interestAmount);
            }
        }
        // create journal entries for the fees application
        if (MathUtil.isGreaterThanZero(feesAmount)) {
            final List<ChargeTaxPaymentDTO> feeTaxPayments = loanCommonAccountingHelper.filterTaxPayments(loanTransactionDTO, false);
            final BigDecimal feeTaxTotal = loanCommonAccountingHelper.sumTaxAmounts(feeTaxPayments);
            if (feeTaxTotal.compareTo(BigDecimal.ZERO) > 0) {
                loanCommonAccountingHelper.createAccrualChargeJournalEntriesWithTax(officeId, currencyCode, loanProductId, loanId, transactionId, transactionDate, feesAmount, loanTransactionDTO.getFeePayments(), feeTaxPayments, AccrualAccountsForLoan.FEES_RECEIVABLE.getValue(), AccrualAccountsForLoan.INCOME_FROM_FEES.getValue(), transactionType.isAccrualAdjustment());
            } else {
                if (transactionType.isAccrualAdjustment()) {
                    this.helper.createJournalEntriesForLoanCharges(officeId, currencyCode, AccrualAccountsForLoan.INCOME_FROM_FEES.getValue(), AccrualAccountsForLoan.FEES_RECEIVABLE.getValue(), loanProductId, loanId, transactionId, transactionDate, feesAmount, loanTransactionDTO.getFeePayments());
                } else {
                    this.helper.createJournalEntriesForLoanCharges(officeId, currencyCode, AccrualAccountsForLoan.FEES_RECEIVABLE.getValue(), AccrualAccountsForLoan.INCOME_FROM_FEES.getValue(), loanProductId, loanId, transactionId, transactionDate, feesAmount, loanTransactionDTO.getFeePayments());
                }
            }
        }
        // create journal entries for the penalties application
        if (MathUtil.isGreaterThanZero(penaltiesAmount)) {
            final List<ChargeTaxPaymentDTO> penaltyTaxPayments = loanCommonAccountingHelper.filterTaxPayments(loanTransactionDTO, true);
            final BigDecimal penaltyTaxTotal = loanCommonAccountingHelper.sumTaxAmounts(penaltyTaxPayments);
            if (penaltyTaxTotal.compareTo(BigDecimal.ZERO) > 0) {
                loanCommonAccountingHelper.createAccrualChargeJournalEntriesWithTax(officeId, currencyCode, loanProductId, loanId, transactionId, transactionDate, penaltiesAmount, loanTransactionDTO.getPenaltyPayments(), penaltyTaxPayments, AccrualAccountsForLoan.PENALTIES_RECEIVABLE.getValue(), AccrualAccountsForLoan.INCOME_FROM_PENALTIES.getValue(), transactionType.isAccrualAdjustment());
            } else {
                if (transactionType.isAccrualAdjustment()) {
                    this.helper.createJournalEntriesForLoanCharges(officeId, currencyCode, AccrualAccountsForLoan.INCOME_FROM_PENALTIES.getValue(), AccrualAccountsForLoan.PENALTIES_RECEIVABLE.getValue(), loanProductId, loanId, transactionId, transactionDate, penaltiesAmount, loanTransactionDTO.getPenaltyPayments());
                } else {
                    this.helper.createJournalEntriesForLoanCharges(officeId, currencyCode, AccrualAccountsForLoan.PENALTIES_RECEIVABLE.getValue(), AccrualAccountsForLoan.INCOME_FROM_PENALTIES.getValue(), loanProductId, loanId, transactionId, transactionDate, penaltiesAmount, loanTransactionDTO.getPenaltyPayments());
                }
            }
        }
    }

    private void createJournalEntriesForRefund(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal refundAmount = loanTransactionDTO.getAmount();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        if (MathUtil.isGreaterThanZero(refundAmount)) {
            if (loanTransactionDTO.isAccountTransfer()) {
                this.helper.createJournalEntriesForLoan(officeId, currencyCode, AccrualAccountsForLoan.OVERPAYMENT.getValue(), FinancialActivity.LIABILITY_TRANSFER.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, refundAmount);
            } else {
                this.helper.createJournalEntriesForLoan(officeId, currencyCode, AccrualAccountsForLoan.OVERPAYMENT.getValue(), AccrualAccountsForLoan.FUND_SOURCE.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, refundAmount);
            }
        }
    }

    private void createJournalEntriesForCreditBalanceRefund(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId) {
        final boolean isMarkedChargeOff = loanDTO.isMarkedAsChargeOff();
        createJournalEntriesForLoanCreditBalanceRefund(loanDTO, loanTransactionDTO, officeId, isMarkedChargeOff);
    }

    private void createJournalEntriesForLoanCreditBalanceRefund(final LoanDTO loanDTO, final LoanTransactionDTO loanTransactionDTO, final long officeId, boolean isMarkedChargeOff) {
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        final boolean isMarkedFraud = loanDTO.isMarkedAsFraud();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        BigDecimal overpaymentAmount = loanTransactionDTO.getOverPayment();
        BigDecimal principalAmount = loanTransactionDTO.getPrincipal();
        BigDecimal totalAmount = BigDecimal.ZERO;
        List<JournalAmountHolder> journalAmountHolders = new ArrayList<>();
        if (MathUtil.isGreaterThanZero(principalAmount)) {
            totalAmount = totalAmount.add(principalAmount);
            journalAmountHolders.add(new JournalAmountHolder(determineAccrualAccountForCBR(isMarkedChargeOff, isMarkedFraud, false), principalAmount));
        }
        if (MathUtil.isGreaterThanZero(overpaymentAmount)) {
            totalAmount = totalAmount.add(overpaymentAmount);
            journalAmountHolders.add(new JournalAmountHolder(determineAccrualAccountForCBR(isMarkedChargeOff, isMarkedFraud, true), overpaymentAmount));
        }
        JournalAmountHolder totalAmountHolder = new JournalAmountHolder(AccrualAccountsForLoan.FUND_SOURCE.getValue(), totalAmount);
        helper.createSplitJournalEntriesForLoan(officeId, currencyCode, journalAmountHolders, totalAmountHolder, loanProductId, paymentTypeId, loanId, transactionId, transactionDate);
    }

    private Integer determineAccrualAccountForCBR(boolean isMarkedChargeOff, boolean isMarkedFraud, boolean isOverpayment) {
        if (isOverpayment) {
            return AccrualAccountsForLoan.OVERPAYMENT.getValue();
        } else {
            if (isMarkedChargeOff) {
                if (isMarkedFraud) {
                    return AccrualAccountsForLoan.CHARGE_OFF_FRAUD_EXPENSE.getValue();
                } else {
                    return AccrualAccountsForLoan.CHARGE_OFF_EXPENSE.getValue();
                }
            } else {
                return AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue();
            }
        }
    }

    private void createJournalEntriesForRefundForActiveLoan(LoanDTO loanDTO, LoanTransactionDTO loanTransactionDTO, long officeId) {
        // TODO Auto-generated method stub
        // loan properties
        final Long loanProductId = loanDTO.getLoanProductId();
        final Long loanId = loanDTO.getLoanId();
        final String currencyCode = loanDTO.getCurrencyCode();
        // transaction properties
        final String transactionId = loanTransactionDTO.getTransactionId();
        final LocalDate transactionDate = loanTransactionDTO.getTransactionDate();
        final BigDecimal principalAmount = loanTransactionDTO.getPrincipal();
        final BigDecimal interestAmount = loanTransactionDTO.getInterest();
        final BigDecimal feesAmount = loanTransactionDTO.getFees();
        final BigDecimal penaltiesAmount = loanTransactionDTO.getPenalties();
        final BigDecimal overPaymentAmount = loanTransactionDTO.getOverPayment();
        final Long paymentTypeId = loanTransactionDTO.getPaymentTypeId();
        BigDecimal totalDebitAmount = new BigDecimal(0);
        if (MathUtil.isGreaterThanZero(principalAmount)) {
            totalDebitAmount = totalDebitAmount.add(principalAmount);
            this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, principalAmount);
        }
        if (MathUtil.isGreaterThanZero(interestAmount)) {
            totalDebitAmount = totalDebitAmount.add(interestAmount);
            this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, AccrualAccountsForLoan.INTEREST_ON_LOANS.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, interestAmount);
        }
        if (MathUtil.isGreaterThanZero(feesAmount)) {
            totalDebitAmount = totalDebitAmount.add(feesAmount);
            List<ChargePaymentDTO> chargePaymentDTOs = new ArrayList<>();
            for (ChargePaymentDTO chargePaymentDTO : loanTransactionDTO.getFeePayments()) {
                chargePaymentDTOs.add(new ChargePaymentDTO(chargePaymentDTO.getChargeId(), chargePaymentDTO.getAmount().floatValue() < 0 ? chargePaymentDTO.getAmount().multiply(new BigDecimal(-1)) : chargePaymentDTO.getAmount(), chargePaymentDTO.getLoanChargeId()));
            }
            this.helper.createDebitJournalEntryForLoanCharges(officeId, currencyCode, AccrualAccountsForLoan.INCOME_FROM_FEES.getValue(), loanProductId, loanId, transactionId, transactionDate, feesAmount, chargePaymentDTOs);
        }
        if (MathUtil.isGreaterThanZero(penaltiesAmount)) {
            totalDebitAmount = totalDebitAmount.add(penaltiesAmount);
            List<ChargePaymentDTO> chargePaymentDTOs = new ArrayList<>();
            for (ChargePaymentDTO chargePaymentDTO : loanTransactionDTO.getPenaltyPayments()) {
                chargePaymentDTOs.add(new ChargePaymentDTO(chargePaymentDTO.getChargeId(), chargePaymentDTO.getAmount().floatValue() < 0 ? chargePaymentDTO.getAmount().multiply(new BigDecimal(-1)) : chargePaymentDTO.getAmount(), chargePaymentDTO.getLoanChargeId()));
            }
            this.helper.createDebitJournalEntryForLoanCharges(officeId, currencyCode, AccrualAccountsForLoan.INCOME_FROM_PENALTIES.getValue(), loanProductId, loanId, transactionId, transactionDate, penaltiesAmount, chargePaymentDTOs);
        }
        if (MathUtil.isGreaterThanZero(overPaymentAmount)) {
            totalDebitAmount = totalDebitAmount.add(overPaymentAmount);
            this.helper.createDebitJournalEntryForLoan(officeId, currencyCode, AccrualAccountsForLoan.OVERPAYMENT.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, overPaymentAmount);
        }
        if (MathUtil.isGreaterThanZero(totalDebitAmount)) {
            /*** create a single debit entry (or reversal) for the entire amount **/
            this.helper.createCreditJournalEntryForLoan(officeId, currencyCode, AccrualAccountsForLoan.FUND_SOURCE.getValue(), loanProductId, paymentTypeId, loanId, transactionId, transactionDate, totalDebitAmount);
        }
    }

    @java.lang.SuppressWarnings("all")
        public AccrualBasedAccountingProcessorForLoan(final AccountingProcessorHelper helper, final LoanReversalJournalEntryPort journalEntryWritePlatformService, final LoanCommonAccountingHelper loanCommonAccountingHelper) {
        this.helper = helper;
        this.journalEntryWritePlatformService = journalEntryWritePlatformService;
        this.loanCommonAccountingHelper = loanCommonAccountingHelper;
    }
}
