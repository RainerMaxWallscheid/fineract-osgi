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

import jakarta.annotation.PostConstruct;
import org.apache.fineract.accounting.journalentry.domain.JournalEntry;
import org.apache.fineract.infrastructure.event.business.domain.journalentry.LoanJournalEntryCreatedBusinessEvent;
import org.apache.fineract.infrastructure.event.business.service.BusinessEventNotifierService;
import org.apache.fineract.investor.config.InvestorModuleIsEnabledCondition;
import org.apache.fineract.investor.domain.ExternalAssetOwnerJournalEntryMapping;
import org.apache.fineract.investor.domain.ExternalAssetOwnerJournalEntryMappingRepository;
import org.apache.fineract.investor.domain.ExternalAssetOwnerTransferLoanMappingRepository;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanReadPlatformServiceCommon;
import org.springframework.context.annotation.Conditional;
import org.springframework.stereotype.Service;

@Service
@Conditional(InvestorModuleIsEnabledCondition.class)
public class ExternalAssetOwnerJournalEntryServiceImpl implements ExternalAssetOwnerJournalEntryService {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(ExternalAssetOwnerJournalEntryServiceImpl.class);
    private final BusinessEventNotifierService businessEventNotifierService;
    private final ExternalAssetOwnerJournalEntryMappingRepository externalAssetOwnerJournalEntryMappingRepository;
    private final ExternalAssetOwnerTransferLoanMappingRepository externalAssetOwnerTransferLoanMappingRepository;
    private final LoanReadPlatformServiceCommon loanReadPlatformService;

    @PostConstruct
    public void addListeners() {
        businessEventNotifierService.addPostBusinessEventListener(LoanJournalEntryCreatedBusinessEvent.class, event -> {
            JournalEntry journalEntry = event.get();
            Long loanId = loanReadPlatformService.findLoanIdByTransactionId(event.getAggregateRootId()).orElseThrow();
            externalAssetOwnerTransferLoanMappingRepository.findByLoanId(loanId).ifPresent(transferLoanMapping -> {
                ExternalAssetOwnerJournalEntryMapping mapping = new ExternalAssetOwnerJournalEntryMapping();
                mapping.setJournalEntry(journalEntry);
                mapping.setOwner(transferLoanMapping.getOwnerTransfer().getOwner());
                externalAssetOwnerJournalEntryMappingRepository.saveAndFlush(mapping);
            });
        });
    }

    @java.lang.SuppressWarnings("all")
        public ExternalAssetOwnerJournalEntryServiceImpl(final BusinessEventNotifierService businessEventNotifierService, final ExternalAssetOwnerJournalEntryMappingRepository externalAssetOwnerJournalEntryMappingRepository, final ExternalAssetOwnerTransferLoanMappingRepository externalAssetOwnerTransferLoanMappingRepository, final LoanReadPlatformServiceCommon loanReadPlatformService) {
        this.businessEventNotifierService = businessEventNotifierService;
        this.externalAssetOwnerJournalEntryMappingRepository = externalAssetOwnerJournalEntryMappingRepository;
        this.externalAssetOwnerTransferLoanMappingRepository = externalAssetOwnerTransferLoanMappingRepository;
        this.loanReadPlatformService = loanReadPlatformService;
    }
}
