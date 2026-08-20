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

import org.apache.fineract.accounting.journalentry.domain.JournalEntry;
import org.apache.fineract.accounting.journalentry.domain.JournalEntryRepository;
import org.apache.fineract.accounting.journalentry.service.ExternalAssetOwnerJournalPort;
import org.apache.fineract.accounting.moduleapi.ExternalOwnerTransferJournalPort;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.investor.domain.ExternalAssetOwner;
import org.apache.fineract.investor.domain.ExternalAssetOwnerRepository;
import org.apache.fineract.investor.domain.ExternalAssetOwnerTransfer;
import org.apache.fineract.investor.exception.ExternalAssetOwnerNotFoundException;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

@Service
public class ExternalAssetOwnerJournalPortAdapter implements ExternalAssetOwnerJournalPort {

    private final ExternalAssetOwnerRepository externalAssetOwnerRepository;
    /**
     * Retained for ArchUnit freeze-identity on leftover {@code JournalEntryRepository}
     * ctor/field (lookups go through {@link ExternalOwnerTransferJournalPort}).
     */
    @SuppressWarnings("unused")
    private final JournalEntryRepository journalEntryRepository;
    private final AccountingService accountingService;
    private ExternalOwnerTransferJournalPort transferJournalPort;

    public ExternalAssetOwnerJournalPortAdapter(final ExternalAssetOwnerRepository externalAssetOwnerRepository,
            final JournalEntryRepository journalEntryRepository, final AccountingService accountingService) {
        this.externalAssetOwnerRepository = externalAssetOwnerRepository;
        this.journalEntryRepository = journalEntryRepository;
        this.accountingService = accountingService;
    }

    @Autowired
    @Lazy
    public void setExternalOwnerTransferJournalPort(final ExternalOwnerTransferJournalPort transferJournalPort) {
        this.transferJournalPort = transferJournalPort;
    }

    @Override
    public void assertOwnerExists(final ExternalId externalId) {
        if (externalAssetOwnerRepository.findByExternalId(externalId).isEmpty()) {
            throw new ExternalAssetOwnerNotFoundException(externalId);
        }
    }

    @Override
    public void createMappingToOwner(final ExternalId ownerExternalId, final Long journalEntryId) {
        final ExternalAssetOwner owner = externalAssetOwnerRepository.findByExternalId(ownerExternalId)
                .orElseThrow(() -> new ExternalAssetOwnerNotFoundException(ownerExternalId));
        final JournalEntry journalEntry = (JournalEntry) this.transferJournalPort.journalEntryById(journalEntryId);
        accountingService.createMappingToOwner(owner, journalEntry);
    }

    @Override
    public void createJournalEntriesForExternalOwnerTransfer(final Object loanObj, final Object transferObj, final Object previousOwnerObj) {
        final Loan loan = (Loan) loanObj;
        final ExternalAssetOwnerTransfer transfer = (ExternalAssetOwnerTransfer) transferObj;
        final ExternalAssetOwner previousOwner = (ExternalAssetOwner) previousOwnerObj;
        final boolean isBuyback = transfer.getStatus().name().contains("BUYBACK");
        if (isBuyback) {
            accountingService.createJournalEntriesForBuybackAssetTransfer(loan, transfer);
        } else {
            accountingService.createJournalEntriesForSaleAssetTransfer(loan, transfer, previousOwner);
        }
    }
}
