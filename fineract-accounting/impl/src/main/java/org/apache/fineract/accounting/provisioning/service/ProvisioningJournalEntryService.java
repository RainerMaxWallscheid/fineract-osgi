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
package org.apache.fineract.accounting.provisioning.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import org.apache.fineract.accounting.glaccount.domain.GLAccount;
import org.apache.fineract.accounting.journalentry.domain.JournalEntry;
import org.apache.fineract.accounting.journalentry.domain.JournalEntryRepository;
import org.apache.fineract.accounting.journalentry.domain.JournalEntryType;
import org.apache.fineract.accounting.journalentry.service.AccountingProcessorHelper;
import org.apache.fineract.accounting.provisioning.domain.LoanProductProvisioningEntry;
import org.apache.fineract.accounting.provisioning.domain.ProvisioningEntry;
import org.apache.fineract.organisation.office.domain.Office;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Provisioning journal posting extracted so provisioning write residual can live in accounting-impl without depending
 * on the provider residual {@code JournalEntryWritePlatformService}.
 */
@Service
public class ProvisioningJournalEntryService {

    private final JournalEntryRepository glJournalEntryRepository;
    private final AccountingProcessorHelper helper;

    public ProvisioningJournalEntryService(final JournalEntryRepository glJournalEntryRepository,
            final AccountingProcessorHelper helper) {
        this.glJournalEntryRepository = glJournalEntryRepository;
        this.helper = helper;
    }

    @Transactional
    public String revertProvisioningJournalEntries(final LocalDate reversalTransactionDate, final Long entityId,
            final Integer entityType) {
        List<JournalEntry> journalEntries = this.glJournalEntryRepository.findProvisioningJournalEntriesByEntityId(entityId, entityType);
        final String reversalTransactionId = journalEntries.get(0).getTransactionId();
        for (final JournalEntry journalEntry : journalEntries) {
            final JournalEntry reversalJournalEntry;
            final String reversalComment = "Reversal entry for Journal Entry with Entry Id  :" + journalEntry.getId()
                    + " and transaction Id " + journalEntry.getTransactionId();
            if (journalEntry.isDebitEntry()) {
                reversalJournalEntry = JournalEntry.createNew(journalEntry.getOffice(), journalEntry.getPaymentDetail(),
                        journalEntry.getGlAccount(), journalEntry.getCurrencyCode(), journalEntry.getTransactionId(), Boolean.FALSE,
                        reversalTransactionDate, JournalEntryType.CREDIT, journalEntry.getAmount(), reversalComment,
                        journalEntry.getEntityType(), journalEntry.getEntityId(), journalEntry.getReferenceNumber(),
                        journalEntry.getLoanTransactionId(), journalEntry.getSavingsTransactionId(), journalEntry.getClientTransactionId(),
                        journalEntry.getShareTransactionId());
            } else {
                reversalJournalEntry = JournalEntry.createNew(journalEntry.getOffice(), journalEntry.getPaymentDetail(),
                        journalEntry.getGlAccount(), journalEntry.getCurrencyCode(), journalEntry.getTransactionId(), Boolean.FALSE,
                        reversalTransactionDate, JournalEntryType.DEBIT, journalEntry.getAmount(), reversalComment,
                        journalEntry.getEntityType(), journalEntry.getEntityId(), journalEntry.getReferenceNumber(),
                        journalEntry.getLoanTransactionId(), journalEntry.getSavingsTransactionId(), journalEntry.getClientTransactionId(),
                        journalEntry.getShareTransactionId());
            }
            helper.persistJournalEntry(reversalJournalEntry);
            journalEntry.setReversalJournalEntry(reversalJournalEntry);
            journalEntry.setReversed(true);
            helper.persistJournalEntry(journalEntry);
        }
        return reversalTransactionId;
    }

    @Transactional
    public String createProvisioningJournalEntries(final ProvisioningEntry provisioningEntry) {
        Collection<LoanProductProvisioningEntry> provisioningEntries = provisioningEntry.getLoanProductProvisioningEntries();
        Map<OfficeCurrencyKey, List<LoanProductProvisioningEntry>> officeMap = new HashMap<>();
        for (LoanProductProvisioningEntry entry : provisioningEntries) {
            OfficeCurrencyKey key = new OfficeCurrencyKey(entry.getOffice(), entry.getCurrencyCode());
            if (officeMap.containsKey(key)) {
                officeMap.get(key).add(entry);
            } else {
                List<LoanProductProvisioningEntry> list = new ArrayList<>();
                list.add(entry);
                officeMap.put(key, list);
            }
        }
        Map<GLAccount, BigDecimal> liabilityMap = new HashMap<>();
        Map<GLAccount, BigDecimal> expenseMap = new HashMap<>();
        for (Map.Entry<OfficeCurrencyKey, List<LoanProductProvisioningEntry>> entry : officeMap.entrySet()) {
            liabilityMap.clear();
            expenseMap.clear();
            for (LoanProductProvisioningEntry lppEntry : entry.getValue()) {
                if (liabilityMap.containsKey(lppEntry.getLiabilityAccount())) {
                    BigDecimal amount = liabilityMap.get(lppEntry.getLiabilityAccount());
                    amount = amount.add(lppEntry.getReservedAmount());
                    liabilityMap.put(lppEntry.getLiabilityAccount(), amount);
                } else {
                    liabilityMap.put(lppEntry.getLiabilityAccount(), BigDecimal.ZERO.add(lppEntry.getReservedAmount()));
                }
                if (expenseMap.containsKey(lppEntry.getExpenseAccount())) {
                    BigDecimal amount = expenseMap.get(lppEntry.getExpenseAccount());
                    amount = amount.add(lppEntry.getReservedAmount());
                    expenseMap.put(lppEntry.getExpenseAccount(), amount);
                } else {
                    expenseMap.put(lppEntry.getExpenseAccount(), BigDecimal.ZERO.add(lppEntry.getReservedAmount()));
                }
            }
            createJournalEntry(provisioningEntry.getCreatedDate(), provisioningEntry.getId(), entry.getKey().office,
                    entry.getKey().currency, liabilityMap, expenseMap);
        }
        return "P" + provisioningEntry.getId();
    }

    private void createJournalEntry(final LocalDate transactionDate, final Long entryId, final Office office, final String currencyCode,
            final Map<GLAccount, BigDecimal> liabilityMap, final Map<GLAccount, BigDecimal> expenseMap) {
        for (Map.Entry<GLAccount, BigDecimal> entry : liabilityMap.entrySet()) {
            this.helper.createProvisioningCreditJournalEntry(transactionDate, entryId, office, currencyCode, entry.getKey(),
                    entry.getValue());
        }
        for (Map.Entry<GLAccount, BigDecimal> entry : expenseMap.entrySet()) {
            this.helper.createProvisioningDebitJournalEntry(transactionDate, entryId, office, currencyCode, entry.getKey(),
                    entry.getValue());
        }
    }

    private static final class OfficeCurrencyKey {

        private final Office office;
        private final String currency;

        OfficeCurrencyKey(final Office office, final String currency) {
            this.office = office;
            this.currency = currency;
        }

        @Override
        public boolean equals(final Object obj) {
            if (!(obj instanceof OfficeCurrencyKey copy)) {
                return false;
            }
            return Objects.equals(this.office.getId(), copy.office.getId()) && Objects.equals(this.currency, copy.currency);
        }

        @Override
        public int hashCode() {
            return Objects.hash(this.office.getId(), this.currency);
        }
    }
}
