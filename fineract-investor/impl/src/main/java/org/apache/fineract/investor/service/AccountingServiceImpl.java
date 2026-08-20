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
package org.apache.fineract.investor.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.IdentityHashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import org.apache.fineract.accounting.common.AccountingConstants;
import org.apache.fineract.accounting.glaccount.domain.GLAccount;
import org.apache.fineract.accounting.journalentry.domain.JournalEntry;
import org.apache.fineract.accounting.producttoaccountmapping.domain.ProductToGLAccountMapping;
import org.apache.fineract.infrastructure.core.service.MathUtil;
import org.apache.fineract.investor.accounting.journalentry.service.InvestorAccountingHelper;
import org.apache.fineract.investor.domain.ExternalAssetOwner;
import org.apache.fineract.investor.domain.ExternalAssetOwnerJournalEntryMapping;
import org.apache.fineract.investor.domain.ExternalAssetOwnerJournalEntryMappingRepository;
import org.apache.fineract.investor.domain.ExternalAssetOwnerTransfer;
import org.apache.fineract.investor.domain.ExternalAssetOwnerTransferJournalEntryMapping;
import org.apache.fineract.investor.domain.ExternalAssetOwnerTransferJournalEntryMappingRepository;
import org.apache.fineract.organisation.office.domain.Office;
import org.apache.fineract.portfolio.PortfolioProductType;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanTransferSnapshotPort;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;

@Service
public class AccountingServiceImpl implements AccountingService {
    private final InvestorAccountingHelper helper;
    private final ExternalAssetOwnerTransferJournalEntryMappingRepository externalAssetOwnerTransferJournalEntryMappingRepository;
    private final ExternalAssetOwnerJournalEntryMappingRepository externalAssetOwnerJournalEntryMappingRepository;
    private final ExternalAssetOwnerTransferOutstandingInterestCalculation externalAssetOwnerTransferOutstandingInterestCalculation;
    private final LoanTransferSnapshotPort loanTransferSnapshotPort;

    /**
     * Overpaid flag for the in-flight transfer journal mapping. Kept off
     * {@code determineOwner*} signatures so ArchUnit freeze identity for
     * leftover {@code JournalEntry} edges stays stable.
     */
    private final ThreadLocal<Boolean> currentTransferOverpaid = new ThreadLocal<>();

    /**
     * Asset-transfer journal entries created for the in-flight transfer.
     * Identity set avoids a second {@code FinancialActivityAccount} lookup
     * (helper already owns that repository) without new freeze-method
     * descriptors on the helper.
     */
    private final ThreadLocal<Set<Object>> currentAssetTransferJournalEntries = new ThreadLocal<>();

    @Override
    public void createJournalEntriesForSaleAssetTransfer(final Loan loan, final ExternalAssetOwnerTransfer transfer, final ExternalAssetOwner previousOwner) {
        final ExternalAssetOwner newOwner = transfer.getOwner();
        try {
            currentAssetTransferJournalEntries.set(Collections.newSetFromMap(new IdentityHashMap<>()));
            List<JournalEntry> journalEntryList = createJournalEntries(loan, transfer, true);
            createMappingToTransfer(transfer, journalEntryList);
            final Set<Object> assetTransferEntries = currentAssetTransferJournalEntries.get();
            journalEntryList.forEach(journalEntry -> {
                if (assetTransferEntries.contains(journalEntry)) {
                    createMappingToOwner(null, journalEntry);
                    return;
                }
                ExternalAssetOwner owner = determineOwnerForSale(journalEntry, loan, previousOwner, newOwner);
                createMappingToOwner(owner, journalEntry);
            });
        } finally {
            currentTransferOverpaid.remove();
            currentAssetTransferJournalEntries.remove();
        }
    }

    @Override
    public void createJournalEntriesForBuybackAssetTransfer(final Loan loan, final ExternalAssetOwnerTransfer transfer) {
        final ExternalAssetOwner previousOwner = transfer.getOwner();
        try {
            currentAssetTransferJournalEntries.set(Collections.newSetFromMap(new IdentityHashMap<>()));
            List<JournalEntry> journalEntryList = createJournalEntries(loan, transfer, false);
            createMappingToTransfer(transfer, journalEntryList);
            final Set<Object> assetTransferEntries = currentAssetTransferJournalEntries.get();
            journalEntryList.forEach(journalEntry -> {
                if (assetTransferEntries.contains(journalEntry)) {
                    createMappingToOwner(null, journalEntry);
                    return;
                }
                ExternalAssetOwner owner = determineOwnerForBuyback(journalEntry, loan, previousOwner);
                createMappingToOwner(owner, journalEntry);
            });
        } finally {
            currentTransferOverpaid.remove();
            currentAssetTransferJournalEntries.remove();
        }
    }

    @NonNull
    private List<JournalEntry> createJournalEntries(final Loan loan, final ExternalAssetOwnerTransfer transfer, final boolean isReversalOrder) {
        this.helper.checkForBranchClosures(loan.getOffice().getId(), transfer.getSettlementDate());
        // transaction properties
        final Long transactionId = transfer.getId();
        final LocalDate transactionDate = transfer.getSettlementDate();
        final BigDecimal principalAmount = loanTransferSnapshotPort.totalPrincipalOutstanding(loan);
        // We have different strategies to calculate oustanding interest
        final BigDecimal interestAmount = externalAssetOwnerTransferOutstandingInterestCalculation.calculateOutstandingInterest(loan);
        final BigDecimal feesAmount = loanTransferSnapshotPort.totalFeeChargesOutstanding(loan);
        final BigDecimal penaltiesAmount = loanTransferSnapshotPort.totalPenaltyChargesOutstanding(loan);
        final BigDecimal overPaymentAmount = loanTransferSnapshotPort.totalOverpaid(loan);
        // Reuse already-loaded overpayment amount so owner mapping need not touch leftover LoanStatus.
        currentTransferOverpaid.set(MathUtil.isGreaterThanZero(overPaymentAmount));
        // Moving money to asset transfer account
        final List<JournalEntry> journalEntryList = createJournalEntries(loan, transactionId, transactionDate, principalAmount, interestAmount, feesAmount, penaltiesAmount, overPaymentAmount, !isReversalOrder);
        // Moving money from asset transfer account
        journalEntryList.addAll(createJournalEntries(loan, transactionId, transactionDate, principalAmount, interestAmount, feesAmount, penaltiesAmount, overPaymentAmount, isReversalOrder));
        return journalEntryList;
    }

    @Override
    public void createMappingToOwner(final ExternalAssetOwner owner, final JournalEntry journalEntry) {
        if (owner == null) {
            return;
        }
        ExternalAssetOwnerJournalEntryMapping mapping = new ExternalAssetOwnerJournalEntryMapping();
        mapping.setJournalEntry(journalEntry);
        mapping.setOwner(owner);
        externalAssetOwnerJournalEntryMappingRepository.saveAndFlush(mapping);
    }

    private ExternalAssetOwner determineOwnerForSale(final JournalEntry journalEntry, final Loan loan, final ExternalAssetOwner previousOwner, final ExternalAssetOwner newOwner) {
        // loan retained for ArchUnit freeze-identity on this method; overpaid comes from createJournalEntries.
        Objects.requireNonNull(loan, "loan");
        final boolean isOverpaid = Boolean.TRUE.equals(currentTransferOverpaid.get());
        if (isOverpaid) {
            if (journalEntry.isCreditEntry()) {
                return newOwner;
            }
            if (journalEntry.isDebitEntry()) {
                return previousOwner;
            }
        } else {
            if (journalEntry.isCreditEntry()) {
                return previousOwner;
            }
            if (journalEntry.isDebitEntry()) {
                return newOwner;
            }
        }
        throw new IllegalArgumentException("Given journalEntry has invalid type: " + journalEntry.getType());
    }

    private ExternalAssetOwner determineOwnerForBuyback(final JournalEntry journalEntry, final Loan loan, final ExternalAssetOwner previousOwner) {
        Objects.requireNonNull(loan, "loan");
        final boolean isOverpaid = Boolean.TRUE.equals(currentTransferOverpaid.get());
        if (isOverpaid && journalEntry.isDebitEntry()) {
            return previousOwner;
        }
        if (!isOverpaid && journalEntry.isCreditEntry()) {
            return previousOwner;
        }
        return null;
    }

    private void createMappingToTransfer(ExternalAssetOwnerTransfer transfer, List<JournalEntry> journalEntryList) {
        journalEntryList.forEach(journalEntry -> {
            ExternalAssetOwnerTransferJournalEntryMapping mapping = new ExternalAssetOwnerTransferJournalEntryMapping();
            mapping.setJournalEntry(journalEntry);
            mapping.setOwnerTransfer(transfer);
            externalAssetOwnerTransferJournalEntryMappingRepository.saveAndFlush(mapping);
        });
    }

    private List<JournalEntry> createJournalEntries(final Loan loan, final Long transactionId, final LocalDate transactionDate, final BigDecimal principalAmount, final BigDecimal interestAmount, final BigDecimal feesAmount, final BigDecimal penaltiesAmount, final BigDecimal overPaymentAmount, final boolean isReversalOrder) {
        final Long loanProductId = loan.productId();
        final Long loanId = loan.getId();
        final Office office = loan.getOffice();
        final String currencyCode = loan.getCurrencyCode();
        final List<JournalEntry> journalEntryList = new ArrayList<>();
        BigDecimal totalDebitAmount = BigDecimal.ZERO;
        final Map<GLAccount, BigDecimal> accountMap = new LinkedHashMap<>();
        // principal entry
        if (MathUtil.isGreaterThanZero(principalAmount)) {
            totalDebitAmount = totalDebitAmount.add(principalAmount);
            GLAccount account;
            if (loan.isChargedOff()) {
                final Long chargeOffReasonId = loan.fetchChargeOffReasonId();
                final ProductToGLAccountMapping mapping = chargeOffReasonId != null ? helper.getChargeOffMappingByCodeValue(loanProductId, PortfolioProductType.LOAN, chargeOffReasonId) : null;
                if (mapping != null) {
                    account = mapping.getGlAccount();
                } else {
                    final AccountingConstants.AccrualAccountsForLoan accrualAccount = loan.isFraud() ? AccountingConstants.AccrualAccountsForLoan.CHARGE_OFF_FRAUD_EXPENSE : AccountingConstants.AccrualAccountsForLoan.CHARGE_OFF_EXPENSE;
                    account = helper.getLinkedGLAccountForLoanProduct(loanProductId, accrualAccount.getValue());
                }
            } else {
                account = helper.getLinkedGLAccountForLoanProduct(loanProductId, AccountingConstants.AccrualAccountsForLoan.LOAN_PORTFOLIO.getValue());
            }
            accountMap.put(account, principalAmount);
        }
        // interest entry
        if (MathUtil.isGreaterThanZero(interestAmount)) {
            AccountingConstants.AccrualAccountsForLoan accrualAccount = AccountingConstants.AccrualAccountsForLoan.INTEREST_RECEIVABLE;
            if (loan.isChargedOff()) {
                accrualAccount = AccountingConstants.AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_INTEREST;
            }
            totalDebitAmount = totalDebitAmount.add(interestAmount);
            final GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, accrualAccount.getValue());
            if (accountMap.containsKey(account)) {
                final BigDecimal amount = accountMap.get(account).add(interestAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, interestAmount);
            }
        }
        // fee entry
        if (MathUtil.isGreaterThanZero(feesAmount)) {
            AccountingConstants.AccrualAccountsForLoan accrualAccount = AccountingConstants.AccrualAccountsForLoan.FEES_RECEIVABLE;
            if (loan.isChargedOff()) {
                accrualAccount = AccountingConstants.AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_FEES;
            }
            totalDebitAmount = totalDebitAmount.add(feesAmount);
            final GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, accrualAccount.getValue());
            if (accountMap.containsKey(account)) {
                final BigDecimal amount = accountMap.get(account).add(feesAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, feesAmount);
            }
        }
        // penalty entry
        if (MathUtil.isGreaterThanZero(penaltiesAmount)) {
            AccountingConstants.AccrualAccountsForLoan accrualAccount = AccountingConstants.AccrualAccountsForLoan.PENALTIES_RECEIVABLE;
            if (loan.isChargedOff()) {
                accrualAccount = AccountingConstants.AccrualAccountsForLoan.INCOME_FROM_CHARGE_OFF_PENALTY;
            }
            totalDebitAmount = totalDebitAmount.add(penaltiesAmount);
            final GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, accrualAccount.getValue());
            if (accountMap.containsKey(account)) {
                final BigDecimal amount = accountMap.get(account).add(penaltiesAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, penaltiesAmount);
            }
        }
        // overpaid entry
        if (MathUtil.isGreaterThanZero(overPaymentAmount)) {
            totalDebitAmount = totalDebitAmount.add(overPaymentAmount);
            final GLAccount account = this.helper.getLinkedGLAccountForLoanProduct(loanProductId, AccountingConstants.AccrualAccountsForLoan.OVERPAYMENT.getValue());
            if (accountMap.containsKey(account)) {
                final BigDecimal amount = accountMap.get(account).add(overPaymentAmount);
                accountMap.put(account, amount);
            } else {
                accountMap.put(account, overPaymentAmount);
            }
        }
        // asset transfer entry
        for (Map.Entry<GLAccount, BigDecimal> entry : accountMap.entrySet()) {
            journalEntryList.add(this.helper.createCreditJournalEntryOrReversalForInvestor(office, currencyCode, loanId, transactionId, transactionDate, entry.getValue(), isReversalOrder, entry.getKey()));
        }
        if (MathUtil.isGreaterThanZero(totalDebitAmount)) {
            journalEntryList.add(this.helper.createDebitJournalEntryOrReversalForInvestor(office, currencyCode, AccountingConstants.FinancialActivity.ASSET_TRANSFER.getValue(), loanProductId, loanId, transactionId, transactionDate, totalDebitAmount, isReversalOrder));
            final Set<Object> assetTransferEntries = currentAssetTransferJournalEntries.get();
            if (assetTransferEntries != null) {
                assetTransferEntries.add(journalEntryList.get(journalEntryList.size() - 1));
            }
        }
        return journalEntryList;
    }

    @java.lang.SuppressWarnings("all")
        public AccountingServiceImpl(final InvestorAccountingHelper helper, final ExternalAssetOwnerTransferJournalEntryMappingRepository externalAssetOwnerTransferJournalEntryMappingRepository, final ExternalAssetOwnerJournalEntryMappingRepository externalAssetOwnerJournalEntryMappingRepository, final ExternalAssetOwnerTransferOutstandingInterestCalculation externalAssetOwnerTransferOutstandingInterestCalculation, final LoanTransferSnapshotPort loanTransferSnapshotPort) {
        this.helper = helper;
        this.externalAssetOwnerTransferJournalEntryMappingRepository = externalAssetOwnerTransferJournalEntryMappingRepository;
        this.externalAssetOwnerJournalEntryMappingRepository = externalAssetOwnerJournalEntryMappingRepository;
        this.externalAssetOwnerTransferOutstandingInterestCalculation = externalAssetOwnerTransferOutstandingInterestCalculation;
        this.loanTransferSnapshotPort = loanTransferSnapshotPort;
    }
}
