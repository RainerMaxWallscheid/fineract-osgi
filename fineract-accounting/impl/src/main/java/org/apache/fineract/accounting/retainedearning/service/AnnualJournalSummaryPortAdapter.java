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
package org.apache.fineract.accounting.retainedearning.service;

import java.time.LocalDate;
import java.util.List;
import org.apache.fineract.accounting.moduleapi.AnnualJournalSummaryPort;
import org.apache.fineract.accounting.retainedearning.domain.AccountGLJournalEntryAnnualSummary;
import org.apache.fineract.accounting.retainedearning.domain.AccountGLJournalEntryAnnualSummaryRepository;
import org.springframework.stereotype.Service;

@Service
public class AnnualJournalSummaryPortAdapter implements AnnualJournalSummaryPort {

    private final AccountGLJournalEntryAnnualSummaryRepository annualSummaryRepository;

    public AnnualJournalSummaryPortAdapter(final AccountGLJournalEntryAnnualSummaryRepository annualSummaryRepository) {
        this.annualSummaryRepository = annualSummaryRepository;
    }

    @Override
    public boolean existsByYearEndDate(final LocalDate yearEndDate) {
        return !this.annualSummaryRepository.findByYearEndDate(yearEndDate).isEmpty();
    }

    @Override
    public void saveAll(final List<AnnualJournalSummaryWrite> entries) {
        if (entries == null || entries.isEmpty()) {
            return;
        }
        this.annualSummaryRepository.saveAll(entries.stream().map(this::toEntity).toList());
    }

    private AccountGLJournalEntryAnnualSummary toEntity(final AnnualJournalSummaryWrite write) {
        final AccountGLJournalEntryAnnualSummary entry = new AccountGLJournalEntryAnnualSummary();
        entry.setGlCode(write.glCode());
        entry.setProductId(write.productId());
        entry.setOfficeId(write.officeId());
        entry.setOpeningBalanceAmount(write.openingBalanceAmount());
        entry.setCurrencyCode(write.currencyCode());
        entry.setOwnerExternalId(write.ownerExternalId());
        entry.setYearEndDate(write.yearEndDate());
        return entry;
    }
}
