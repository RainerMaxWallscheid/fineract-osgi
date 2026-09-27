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
import org.apache.fineract.accounting.journalentry.domain.JournalEntry;
import org.apache.fineract.accounting.journalentry.domain.JournalEntryRepository;
import org.apache.fineract.accounting.journalentry.domain.JournalEntryType;
import org.apache.fineract.accounting.moduleapi.CashierJournalPort;
import org.apache.fineract.accounting.moduleapi.GLAccountAssociation;
import org.apache.fineract.organisation.office.exception.OfficeNotFoundException;
import org.apache.fineract.organisation.office.moduleapi.OfficePersistablePort;
import org.springframework.stereotype.Service;

@Service
public class CashierJournalPortAdapter implements CashierJournalPort {

    private final FinancialActivityAccountRepositoryWrapper financialActivityAccountRepositoryWrapper;
    private final JournalEntryRepository journalEntryRepository;
    private final OfficePersistablePort officePersistablePort;

    public CashierJournalPortAdapter(final FinancialActivityAccountRepositoryWrapper financialActivityAccountRepositoryWrapper,
            final JournalEntryRepository journalEntryRepository, final OfficePersistablePort officePersistablePort) {
        this.financialActivityAccountRepositoryWrapper = financialActivityAccountRepositoryWrapper;
        this.journalEntryRepository = journalEntryRepository;
        this.officePersistablePort = officePersistablePort;
    }

    @Override
    public void postAllocateOrSettle(final boolean allocate, final Long officeId, final String currencyCode,
            final LocalDate transactionDate, final BigDecimal amount, final String description, final String transactionId) {
        final FinancialActivityAccount mainVault = this.financialActivityAccountRepositoryWrapper
                .findByFinancialActivityTypeWithNotFoundDetection(FinancialActivity.CASH_AT_MAINVAULT.getValue());
        final FinancialActivityAccount tellerCash = this.financialActivityAccountRepositoryWrapper
                .findByFinancialActivityTypeWithNotFoundDetection(FinancialActivity.CASH_AT_TELLER.getValue());
        final Object debitAccount;
        final Object creditAccount;
        if (allocate) {
            debitAccount = GLAccountAssociation.persistableById(tellerCash.getGlAccountId());
            creditAccount = GLAccountAssociation.persistableById(mainVault.getGlAccountId());
        } else {
            debitAccount = GLAccountAssociation.persistableById(mainVault.getGlAccountId());
            creditAccount = GLAccountAssociation.persistableById(tellerCash.getGlAccountId());
        }
        final Object office = officeById(officeId);
        final JournalEntry debitJournalEntry = JournalEntry.createNew(office, null, debitAccount, currencyCode, transactionId, false,
                transactionDate, JournalEntryType.DEBIT, amount, description, null, null, null, null, null, null, null);
        final JournalEntry creditJournalEntry = JournalEntry.createNew(office, null, creditAccount, currencyCode, transactionId, false,
                transactionDate, JournalEntryType.CREDIT, amount, description, null, null, null, null, null, null, null);
        this.journalEntryRepository.saveAndFlush(debitJournalEntry);
        this.journalEntryRepository.saveAndFlush(creditJournalEntry);
    }

    private Object officeById(final Long officeId) {
        if (officeId == null) {
            throw new IllegalArgumentException("The given id must not be null!");
        }
        final Object office = this.officePersistablePort.persistableById(officeId);
        if (office == null) {
            throw new OfficeNotFoundException(officeId);
        }
        return office;
    }
}
