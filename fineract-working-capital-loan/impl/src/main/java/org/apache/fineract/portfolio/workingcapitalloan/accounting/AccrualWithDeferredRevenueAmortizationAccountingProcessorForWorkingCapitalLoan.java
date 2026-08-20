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
package org.apache.fineract.portfolio.workingcapitalloan.accounting;

import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.commons.lang3.NotImplementedException;
import org.apache.fineract.accounting.common.AccountingConstants.CashAccountsForLoan;
import org.apache.fineract.accounting.moduleapi.WorkingCapitalLoanJournalPort;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.core.service.MathUtil;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransactionRelationTypeEnum;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransactionType;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoan;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoanTransaction;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoanTransactionAllocation;
import org.springframework.stereotype.Component;

@Component
public class AccrualWithDeferredRevenueAmortizationAccountingProcessorForWorkingCapitalLoan implements WorkingCapitalLoanAccountingProcessor {
    private final WorkingCapitalLoanJournalPort journalPort;

    @Override
    public void postJournalEntries(final WorkingCapitalLoan loan, final WorkingCapitalLoanTransaction txn,
            final WorkingCapitalLoanTransactionAllocation allocation, final boolean isChargedOff) {
        final long officeId = loan.getOfficeId();
        final Long productId = loan.getLoanProduct().getId();
        final String currencyCode = loan.getLoanProductRelatedDetails().getCurrency().getCode();
        final LocalDate transactionDate = txn.getTransactionDate();
        final Long paymentTypeId = extractPaymentTypeId(txn);
        this.journalPort.ensureBranchNotClosed(officeId, transactionDate);
        final BigDecimal principalPortion = MathUtil.nullToZero(allocation.getPrincipalPortion());
        final BigDecimal feesPortion = MathUtil.nullToZero(allocation.getFeeChargesPortion());
        final BigDecimal penaltiesPortion = MathUtil.nullToZero(allocation.getPenaltyChargesPortion());
        final BigDecimal overpaymentPortion = txn.getTransactionAmount().subtract(principalPortion).subtract(feesPortion)
                .subtract(penaltiesPortion).max(BigDecimal.ZERO);
        switch (txn.getTypeOf()) {
            case LoanTransactionType.REPAYMENT -> {
                if (isChargedOff) {
                    postChargedOffRepaymentEntries(officeId, productId, currencyCode, transactionDate, paymentTypeId, txn, principalPortion,
                            feesPortion, penaltiesPortion, overpaymentPortion);
                } else {
                    postRegularRepaymentEntries(officeId, productId, currencyCode, transactionDate, paymentTypeId, txn, principalPortion,
                            feesPortion, penaltiesPortion, overpaymentPortion);
                }
            }
            case LoanTransactionType.GOODWILL_CREDIT -> {
                if (!isChargedOff) {
                    postGoodwillCreditJournalEntries(loan, txn, principalPortion, feesPortion, penaltiesPortion, overpaymentPortion);
                } else {
                    throw new NotImplementedException("Charge off is not implemented yet for Goodwill Credit for Working Capital Loan");
                }
            }
            case LoanTransactionType.CREDIT_BALANCE_REFUND -> postCreditBalanceRefundJournalEntries(loan, txn);
            case LoanTransactionType.CHARGE_ADJUSTMENT -> postChargeAdjustmentJournalEntries(loan, txn, principalPortion, feesPortion,
                    penaltiesPortion, overpaymentPortion, isChargedOff);
            default -> {
                throw new NotImplementedException(
                        "Post Journal Entries is not implemented yet for " + txn.getTypeOf().getCode() + " for Working Capital Loan");
            }
        }
    }

    private void postChargeAdjustmentJournalEntries(final WorkingCapitalLoan loan, final WorkingCapitalLoanTransaction txn,
            final BigDecimal principalPortion, final BigDecimal feesPortion, final BigDecimal penaltiesPortion,
            final BigDecimal overpaymentPortion, final boolean isChargedOff) {
        final JournalEntryPostingHelper accountPostHelper = new JournalEntryPostingHelper(loan, txn);
        final CashAccountsForLoan incomeAccountType = isChargedOff ? CashAccountsForLoan.INCOME_FROM_RECOVERY
                : isAdjustedChargeAPenalty(txn) ? CashAccountsForLoan.INCOME_FROM_PENALTIES : CashAccountsForLoan.INCOME_FROM_FEES;
        accountPostHelper.postDebitJournalEntry(incomeAccountType, txn.getTransactionAmount());
        accountPostHelper.postCreditJournalEntry(CashAccountsForLoan.LOAN_PORTFOLIO, principalPortion);
        accountPostHelper.postCreditJournalEntry(CashAccountsForLoan.FEES_RECEIVABLE, feesPortion);
        accountPostHelper.postCreditJournalEntry(CashAccountsForLoan.PENALTIES_RECEIVABLE, penaltiesPortion);
        accountPostHelper.postCreditJournalEntry(CashAccountsForLoan.OVERPAYMENT, overpaymentPortion);
    }

    private boolean isAdjustedChargeAPenalty(final WorkingCapitalLoanTransaction txn) {
        return txn.getLoanTransactionRelations().stream()
                .filter(relation -> relation.getToCharge() != null
                        && relation.getRelationType() == LoanTransactionRelationTypeEnum.CHARGE_ADJUSTMENT)
                .findFirst().map(relation -> relation.getToCharge().isPenaltyCharge())
                .orElseThrow(() -> new IllegalStateException(
                        "Charge adjustment transaction " + txn.getId() + " is missing its link to the adjusted charge"));
    }

    private void postGoodwillCreditJournalEntries(final WorkingCapitalLoan loan, final WorkingCapitalLoanTransaction txn,
            final BigDecimal principalPortion, final BigDecimal feesPortion, final BigDecimal penaltiesPortion,
            final BigDecimal overpaymentPortion) {
        final BigDecimal overpaymentPlusPrincipal = principalPortion.add(overpaymentPortion);
        final JournalEntryPostingHelper accountPostHelper = new JournalEntryPostingHelper(loan, txn);
        accountPostHelper.postDebitJournalEntry(CashAccountsForLoan.GOODWILL_CREDIT, overpaymentPlusPrincipal);
        accountPostHelper.postDebitJournalEntry(CashAccountsForLoan.INCOME_FROM_GOODWILL_CREDIT_FEES, feesPortion);
        accountPostHelper.postDebitJournalEntry(CashAccountsForLoan.INCOME_FROM_GOODWILL_CREDIT_PENALTY, penaltiesPortion);
        accountPostHelper.postCreditJournalEntry(CashAccountsForLoan.LOAN_PORTFOLIO, principalPortion);
        accountPostHelper.postCreditJournalEntry(CashAccountsForLoan.FEES_RECEIVABLE, feesPortion);
        accountPostHelper.postCreditJournalEntry(CashAccountsForLoan.PENALTIES_RECEIVABLE, penaltiesPortion);
        accountPostHelper.postCreditJournalEntry(CashAccountsForLoan.OVERPAYMENT, overpaymentPortion);
    }

    private void postCreditBalanceRefundJournalEntries(final WorkingCapitalLoan loan, final WorkingCapitalLoanTransaction txn) {
        final BigDecimal amount = txn.getTransactionAmount();
        final JournalEntryPostingHelper accountPostHelper = new JournalEntryPostingHelper(loan, txn);
        accountPostHelper.postDebitJournalEntry(CashAccountsForLoan.OVERPAYMENT, amount);
        accountPostHelper.postCreditJournalEntry(CashAccountsForLoan.FUND_SOURCE, amount);
    }

    @Override
    public void postReversalJournalEntries(final WorkingCapitalLoan loan, final WorkingCapitalLoanTransaction txn) {
        final long officeId = loan.getOfficeId();
        final LocalDate transactionDate = txn.getReversedOnDate() != null ? txn.getReversedOnDate() : DateUtils.getBusinessLocalDate();
        this.journalPort.reverse(officeId, txn.getId(), transactionDate);
    }

    private void postRegularRepaymentEntries(final long officeId, final Long productId, final String currencyCode,
            final LocalDate transactionDate, final Long paymentTypeId, final WorkingCapitalLoanTransaction txn,
            final BigDecimal principalPortion, final BigDecimal feesPortion, final BigDecimal penaltiesPortion,
            final BigDecimal overpaymentPortion) {
        postRepaymentCreditEntries(officeId, productId, currencyCode, transactionDate, txn, principalPortion,
                CashAccountsForLoan.LOAN_PORTFOLIO, feesPortion, CashAccountsForLoan.FEES_RECEIVABLE, penaltiesPortion,
                CashAccountsForLoan.PENALTIES_RECEIVABLE, overpaymentPortion);
        postFundSourceDebit(officeId, productId, currencyCode, transactionDate, paymentTypeId, txn);
    }

    private void postChargedOffRepaymentEntries(final long officeId, final Long productId, final String currencyCode,
            final LocalDate transactionDate, final Long paymentTypeId, final WorkingCapitalLoanTransaction txn,
            final BigDecimal principalPortion, final BigDecimal feesPortion, final BigDecimal penaltiesPortion,
            final BigDecimal overpaymentPortion) {
        postRepaymentCreditEntries(officeId, productId, currencyCode, transactionDate, txn, principalPortion,
                CashAccountsForLoan.INCOME_FROM_RECOVERY, feesPortion, CashAccountsForLoan.INCOME_FROM_RECOVERY, penaltiesPortion,
                CashAccountsForLoan.INCOME_FROM_RECOVERY, overpaymentPortion);
        postFundSourceDebit(officeId, productId, currencyCode, transactionDate, paymentTypeId, txn);
    }

    private void postRepaymentCreditEntries(final long officeId, final Long productId, final String currencyCode,
            final LocalDate transactionDate, final WorkingCapitalLoanTransaction txn, final BigDecimal principalPortion,
            final CashAccountsForLoan principalAccountType, final BigDecimal feesPortion, final CashAccountsForLoan feesAccountType,
            final BigDecimal penaltiesPortion, final CashAccountsForLoan penaltiesAccountType, final BigDecimal overpaymentPortion) {
        final Long loanId = txn.getWcLoan().getId();
        final Long txnId = txn.getId();
        if (MathUtil.isGreaterThanZero(principalPortion)) {
            this.journalPort.postCredit(officeId, productId, currencyCode, principalAccountType.getValue(), null, loanId, txnId,
                    transactionDate, principalPortion);
        }
        if (MathUtil.isGreaterThanZero(feesPortion)) {
            this.journalPort.postCredit(officeId, productId, currencyCode, feesAccountType.getValue(), null, loanId, txnId, transactionDate,
                    feesPortion);
        }
        if (MathUtil.isGreaterThanZero(penaltiesPortion)) {
            this.journalPort.postCredit(officeId, productId, currencyCode, penaltiesAccountType.getValue(), null, loanId, txnId,
                    transactionDate, penaltiesPortion);
        }
        if (MathUtil.isGreaterThanZero(overpaymentPortion)) {
            this.journalPort.postCredit(officeId, productId, currencyCode, CashAccountsForLoan.OVERPAYMENT.getValue(), null, loanId, txnId,
                    transactionDate, overpaymentPortion);
        }
    }

    private void postFundSourceDebit(final long officeId, final Long productId, final String currencyCode, final LocalDate transactionDate,
            final Long paymentTypeId, final WorkingCapitalLoanTransaction txn) {
        final BigDecimal totalAmount = txn.getTransactionAmount();
        if (MathUtil.isGreaterThanZero(totalAmount)) {
            this.journalPort.postDebit(officeId, productId, currencyCode, CashAccountsForLoan.FUND_SOURCE.getValue(), paymentTypeId,
                    txn.getWcLoan().getId(), txn.getId(), transactionDate, totalAmount);
        }
    }

    @Override
    public void postJournalEntriesForDiscountFeeAmortization(final WorkingCapitalLoan loan, final WorkingCapitalLoanTransaction txn,
            final boolean isChargedOff) {
        final long officeId = loan.getOfficeId();
        final Long productId = loan.getLoanProduct().getId();
        final String currencyCode = loan.getLoanProductRelatedDetails().getCurrency().getCode();
        final LocalDate transactionDate = txn.getTransactionDate();
        final Long loanId = loan.getId();
        final Long txnId = txn.getId();
        final BigDecimal amount = txn.getTransactionAmount();
        this.journalPort.ensureBranchNotClosed(officeId, transactionDate);
        if (MathUtil.isGreaterThanZero(amount)) {
            this.journalPort.postDebit(officeId, productId, currencyCode, CashAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), null,
                    loanId, txnId, transactionDate, amount);
            final CashAccountsForLoan creditAccountType = isChargedOff ? CashAccountsForLoan.CHARGE_OFF_EXPENSE
                    : CashAccountsForLoan.INCOME_FROM_DISCOUNT_FEE;
            this.journalPort.postCredit(officeId, productId, currencyCode, creditAccountType.getValue(), null, loanId, txnId,
                    transactionDate, amount);
        }
    }

    @Override
    public void postJournalEntriesForDiscountFeeAmortizationAdjustment(final WorkingCapitalLoan loan,
            final WorkingCapitalLoanTransaction txn, final boolean isChargedOff) {
        final long officeId = loan.getOfficeId();
        final Long productId = loan.getLoanProduct().getId();
        final String currencyCode = loan.getLoanProductRelatedDetails().getCurrency().getCode();
        final LocalDate transactionDate = txn.getTransactionDate();
        final Long loanId = loan.getId();
        final Long txnId = txn.getId();
        final BigDecimal amount = txn.getTransactionAmount();
        this.journalPort.ensureBranchNotClosed(officeId, transactionDate);
        if (MathUtil.isGreaterThanZero(amount)) {
            this.journalPort.postCredit(officeId, productId, currencyCode, CashAccountsForLoan.DEFERRED_INCOME_LIABILITY.getValue(), null,
                    loanId, txnId, transactionDate, amount);
            final CashAccountsForLoan debitAccountType = isChargedOff ? CashAccountsForLoan.CHARGE_OFF_EXPENSE
                    : CashAccountsForLoan.INCOME_FROM_DISCOUNT_FEE;
            this.journalPort.postDebit(officeId, productId, currencyCode, debitAccountType.getValue(), null, loanId, txnId, transactionDate,
                    amount);
        }
    }

    @Override
    public void postJournalEntriesForDiscountFee(final WorkingCapitalLoan loan, final WorkingCapitalLoanTransaction txn) {
        postDiscountFeeDeferralEntries(loan, txn, CashAccountsForLoan.LOAN_PORTFOLIO, CashAccountsForLoan.DEFERRED_INCOME_LIABILITY);
    }

    @Override
    public void postJournalEntriesForDiscountFeeAdjustment(final WorkingCapitalLoan loan, final WorkingCapitalLoanTransaction txn) {
        postDiscountFeeDeferralEntries(loan, txn, CashAccountsForLoan.DEFERRED_INCOME_LIABILITY, CashAccountsForLoan.LOAN_PORTFOLIO);
    }

    private void postDiscountFeeDeferralEntries(final WorkingCapitalLoan loan, final WorkingCapitalLoanTransaction txn,
            final CashAccountsForLoan debitAccountType, final CashAccountsForLoan creditAccountType) {
        final long officeId = loan.getOfficeId();
        final Long productId = loan.getLoanProduct().getId();
        final String currencyCode = loan.getLoanProductRelatedDetails().getCurrency().getCode();
        final LocalDate transactionDate = txn.getTransactionDate();
        final Long loanId = loan.getId();
        final Long txnId = txn.getId();
        final BigDecimal amount = txn.getTransactionAmount();
        this.journalPort.ensureBranchNotClosed(officeId, transactionDate);
        if (MathUtil.isGreaterThanZero(amount)) {
            this.journalPort.postDebit(officeId, productId, currencyCode, debitAccountType.getValue(), null, loanId, txnId, transactionDate,
                    amount);
            this.journalPort.postCredit(officeId, productId, currencyCode, creditAccountType.getValue(), null, loanId, txnId,
                    transactionDate, amount);
        }
    }

    private Long extractPaymentTypeId(final WorkingCapitalLoanTransaction txn) {
        if (txn.getPaymentDetail() != null && txn.getPaymentDetail().getPaymentType() != null) {
            return txn.getPaymentDetail().getPaymentType().getId();
        }
        return null;
    }

    private class JournalEntryPostingHelper {
        final long officeId;
        final Long productId;
        final String currencyCode;
        final LocalDate transactionDate;
        final Long paymentTypeId;
        final Long loanId;
        final Long txnId;

        JournalEntryPostingHelper(final WorkingCapitalLoan loan, final WorkingCapitalLoanTransaction txn) {
            paymentTypeId = extractPaymentTypeId(txn);
            transactionDate = txn.getTransactionDate();
            currencyCode = loan.getLoanProductRelatedDetails().getCurrency().getCode();
            productId = loan.getLoanProduct().getId();
            officeId = loan.getOfficeId();
            loanId = loan.getId();
            txnId = txn.getId();
        }

        void postCreditJournalEntry(final CashAccountsForLoan accountType, final BigDecimal amount) {
            if (MathUtil.isGreaterThanZero(amount)) {
                journalPort.postCredit(officeId, productId, currencyCode, accountType.getValue(), paymentTypeId, loanId, txnId,
                        transactionDate, amount);
            }
        }

        void postDebitJournalEntry(final CashAccountsForLoan accountType, final BigDecimal amount) {
            if (MathUtil.isGreaterThanZero(amount)) {
                journalPort.postDebit(officeId, productId, currencyCode, accountType.getValue(), paymentTypeId, loanId, txnId,
                        transactionDate, amount);
            }
        }
    }

    public AccrualWithDeferredRevenueAmortizationAccountingProcessorForWorkingCapitalLoan(final WorkingCapitalLoanJournalPort journalPort) {
        this.journalPort = journalPort;
    }
}
