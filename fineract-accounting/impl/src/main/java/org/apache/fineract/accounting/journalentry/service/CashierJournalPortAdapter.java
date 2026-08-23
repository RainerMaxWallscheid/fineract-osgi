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
import org.apache.fineract.accounting.common.AccountingConstants.FinancialActivity;
import org.apache.fineract.accounting.financialactivityaccount.domain.FinancialActivityAccount;
import org.apache.fineract.accounting.financialactivityaccount.domain.FinancialActivityAccountRepositoryWrapper;
import org.apache.fineract.accounting.glaccount.domain.GLAccount;
import org.apache.fineract.accounting.journalentry.domain.JournalEntry;
import org.apache.fineract.accounting.journalentry.domain.JournalEntryRepository;
import org.apache.fineract.accounting.journalentry.domain.JournalEntryType;
import org.apache.fineract.accounting.moduleapi.CashierJournalPort;
import org.apache.fineract.organisation.office.domain.Office;
import org.apache.fineract.organisation.office.domain.OfficeRepositoryWrapper;
import org.springframework.stereotype.Service;

@Service
public class CashierJournalPortAdapter implements CashierJournalPort {

    private final FinancialActivityAccountRepositoryWrapper financialActivityAccountRepositoryWrapper;
    private final JournalEntryRepository journalEntryRepository;
    private final OfficeRepositoryWrapper officeRepositoryWrapper;

    public CashierJournalPortAdapter(final FinancialActivityAccountRepositoryWrapper financialActivityAccountRepositoryWrapper,
            final JournalEntryRepository journalEntryRepository, final OfficeRepositoryWrapper officeRepositoryWrapper) {
        this.financialActivityAccountRepositoryWrapper = financialActivityAccountRepositoryWrapper;
        this.journalEntryRepository = journalEntryRepository;
        this.officeRepositoryWrapper = officeRepositoryWrapper;
    }

    @Override
    public void postAllocateOrSettle(final boolean allocate, final Long officeId, final String currencyCode,
            final LocalDate transactionDate, final BigDecimal amount, final String description, final String transactionId) {
        final FinancialActivityAccount mainVault = this.financialActivityAccountRepositoryWrapper
                .findByFinancialActivityTypeWithNotFoundDetection(FinancialActivity.CASH_AT_MAINVAULT.getValue());
        final FinancialActivityAccount tellerCash = this.financialActivityAccountRepositoryWrapper
                .findByFinancialActivityTypeWithNotFoundDetection(FinancialActivity.CASH_AT_TELLER.getValue());
        final GLAccount debitAccount;
        final GLAccount creditAccount;
        if (allocate) {
            debitAccount = tellerCash.getGlAccount();
            creditAccount = mainVault.getGlAccount();
        } else {
            debitAccount = mainVault.getGlAccount();
            creditAccount = tellerCash.getGlAccount();
        }
        final Office office = this.officeRepositoryWrapper.findOneWithNotFoundDetection(officeId);
        final JournalEntry debitJournalEntry = JournalEntry.createNew(office, null, debitAccount, currencyCode, transactionId, false,
                transactionDate, JournalEntryType.DEBIT, amount, description, null, null, null, null, null, null, null);
        final JournalEntry creditJournalEntry = JournalEntry.createNew(office, null, creditAccount, currencyCode, transactionId, false,
                transactionDate, JournalEntryType.CREDIT, amount, description, null, null, null, null, null, null, null);
        this.journalEntryRepository.saveAndFlush(debitJournalEntry);
        this.journalEntryRepository.saveAndFlush(creditJournalEntry);
    }
}
