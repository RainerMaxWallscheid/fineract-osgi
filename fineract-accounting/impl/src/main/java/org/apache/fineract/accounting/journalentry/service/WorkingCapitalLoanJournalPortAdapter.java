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
import java.util.List;
import org.apache.fineract.accounting.glaccount.domain.GLAccount;
import org.apache.fineract.accounting.journalentry.domain.JournalEntry;
import org.apache.fineract.accounting.journalentry.domain.JournalEntryRepository;
import org.apache.fineract.accounting.journalentry.domain.JournalEntryType;
import org.apache.fineract.accounting.moduleapi.WorkingCapitalLoanJournalPort;
import org.apache.fineract.organisation.office.domain.Office;
import org.apache.fineract.organisation.office.domain.OfficeRepositoryWrapper;
import org.apache.fineract.portfolio.PortfolioProductType;
import org.springframework.stereotype.Service;

@Service
public class WorkingCapitalLoanJournalPortAdapter implements WorkingCapitalLoanJournalPort {

    private final AccountingProcessorHelper helper;
    private final JournalEntryRepository journalEntryRepository;
    private final OfficeRepositoryWrapper officeRepository;

    public WorkingCapitalLoanJournalPortAdapter(final AccountingProcessorHelper helper,
            final JournalEntryRepository journalEntryRepository, final OfficeRepositoryWrapper officeRepository) {
        this.helper = helper;
        this.journalEntryRepository = journalEntryRepository;
        this.officeRepository = officeRepository;
    }

    @Override
    public void ensureBranchNotClosed(final long officeId, final LocalDate transactionDate) {
        this.helper.checkForBranchClosures(this.helper.getLatestClosureByBranch(officeId), transactionDate);
    }

    @Override
    public void postCredit(final long officeId, final long productId, final String currencyCode, final int cashAccountType,
            final Long paymentTypeId, final long wcLoanId, final long wcTxnId, final LocalDate date, final BigDecimal amount) {
        final Office office = this.officeRepository.findOneWithNotFoundDetection(officeId);
        final GLAccount account = this.helper.getLinkedGLAccountForWorkingCapitalLoanProduct(productId, cashAccountType, paymentTypeId);
        this.helper.createCreditJournalEntryForWorkingCapitalLoan(office, currencyCode, account, wcLoanId, wcTxnId, date, amount, null);
    }

    @Override
    public void postDebit(final long officeId, final long productId, final String currencyCode, final int cashAccountType,
            final Long paymentTypeId, final long wcLoanId, final long wcTxnId, final LocalDate date, final BigDecimal amount) {
        final Office office = this.officeRepository.findOneWithNotFoundDetection(officeId);
        final GLAccount account = this.helper.getLinkedGLAccountForWorkingCapitalLoanProduct(productId, cashAccountType, paymentTypeId);
        this.helper.createDebitJournalEntryForWorkingCapitalLoan(office, currencyCode, account, wcLoanId, wcTxnId, date, amount, null);
    }

    @Override
    public void reverse(final long officeId, final long wcTxnId, final LocalDate reversalDate) {
        this.helper.checkForBranchClosures(this.helper.getLatestClosureByBranch(officeId), reversalDate);
        final String transactionId = AccountingProcessorHelper.WORKING_CAPITAL_LOAN_TRANSACTION_IDENTIFIER + wcTxnId;
        final List<JournalEntry> existingEntries = this.journalEntryRepository.findJournalEntries(transactionId,
                PortfolioProductType.WORKING_CAPITAL_LOAN.getValue());
        for (final JournalEntry journalEntry : existingEntries) {
            final JournalEntryType reversalType = journalEntry.isDebitEntry() ? JournalEntryType.CREDIT : JournalEntryType.DEBIT;
            final JournalEntry reversalEntry = JournalEntry.createNew(journalEntry.getOffice(), journalEntry.getPaymentDetail(),
                    journalEntry.getGlAccount(), journalEntry.getCurrencyCode(), transactionId, Boolean.FALSE, reversalDate, reversalType,
                    journalEntry.getAmount(), journalEntry.getDescription(), journalEntry.getEntityType(), journalEntry.getEntityId(),
                    journalEntry.getReferenceNumber(), journalEntry.getLoanTransactionId(), journalEntry.getSavingsTransactionId(),
                    journalEntry.getClientTransactionId(), journalEntry.getShareTransactionId());
            this.helper.persistJournalEntry(reversalEntry);
            journalEntry.setReversed(true);
            journalEntry.setReversalJournalEntry(reversalEntry);
            this.helper.persistJournalEntry(journalEntry);
        }
    }
}
