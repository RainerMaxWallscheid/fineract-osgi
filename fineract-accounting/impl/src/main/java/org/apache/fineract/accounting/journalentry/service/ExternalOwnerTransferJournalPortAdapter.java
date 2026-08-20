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
import org.apache.fineract.accounting.common.AccountingConstants;
import org.apache.fineract.accounting.common.AccountingConstants.FinancialActivity;
import org.apache.fineract.accounting.financialactivityaccount.domain.FinancialActivityAccount;
import org.apache.fineract.accounting.financialactivityaccount.domain.FinancialActivityAccountRepositoryWrapper;
import org.apache.fineract.accounting.glaccount.domain.GLAccount;
import org.apache.fineract.accounting.journalentry.domain.JournalEntry;
import org.apache.fineract.accounting.journalentry.domain.JournalEntryRepository;
import org.apache.fineract.accounting.journalentry.domain.JournalEntryType;
import org.apache.fineract.accounting.journalentry.exception.JournalEntryNotFoundException;
import org.apache.fineract.accounting.moduleapi.ExternalOwnerTransferJournalPort;
import org.apache.fineract.accounting.producttoaccountmapping.domain.ProductToGLAccountMapping;
import org.apache.fineract.accounting.producttoaccountmapping.domain.ProductToGLAccountMappingRepository;
import org.apache.fineract.accounting.producttoaccountmapping.exception.ProductToGLAccountMappingNotFoundException;
import org.apache.fineract.organisation.office.domain.Office;
import org.apache.fineract.portfolio.PortfolioProductType;
import org.springframework.stereotype.Service;

@Service
public class ExternalOwnerTransferJournalPortAdapter implements ExternalOwnerTransferJournalPort {

    private final ExternalAssetOwnerJournalPort externalAssetOwnerJournalPort;
    private final JournalEntryRepository journalEntryRepository;
    private final ProductToGLAccountMappingRepository accountMappingRepository;
    private final FinancialActivityAccountRepositoryWrapper financialActivityAccountRepository;

    public ExternalOwnerTransferJournalPortAdapter(final ExternalAssetOwnerJournalPort externalAssetOwnerJournalPort,
            final JournalEntryRepository journalEntryRepository, final ProductToGLAccountMappingRepository accountMappingRepository,
            final FinancialActivityAccountRepositoryWrapper financialActivityAccountRepository) {
        this.externalAssetOwnerJournalPort = externalAssetOwnerJournalPort;
        this.journalEntryRepository = journalEntryRepository;
        this.accountMappingRepository = accountMappingRepository;
        this.financialActivityAccountRepository = financialActivityAccountRepository;
    }

    @Override
    public void postTransfer(final Object loan, final Object externalAssetOwnerTransfer, final Object previousOwner) {
        this.externalAssetOwnerJournalPort.createJournalEntriesForExternalOwnerTransfer(loan, externalAssetOwnerTransfer, previousOwner);
    }

    @Override
    public Object postInvestorCredit(final Object office, final String currencyCode, final Object glAccount, final String transactionId,
            final LocalDate transactionDate, final BigDecimal amount, final Long loanId) {
        return persist(office, currencyCode, glAccount, transactionId, transactionDate, amount, loanId, JournalEntryType.CREDIT);
    }

    @Override
    public Object postInvestorDebit(final Object office, final String currencyCode, final Object glAccount, final String transactionId,
            final LocalDate transactionDate, final BigDecimal amount, final Long loanId) {
        return persist(office, currencyCode, glAccount, transactionId, transactionDate, amount, loanId, JournalEntryType.DEBIT);
    }

    private Object persist(final Object office, final String currencyCode, final Object glAccount, final String transactionId,
            final LocalDate transactionDate, final BigDecimal amount, final Long loanId, final JournalEntryType type) {
        final boolean manualEntry = false;
        final JournalEntry journalEntry = JournalEntry.createNew((Office) office, null, (GLAccount) glAccount, currencyCode, transactionId,
                manualEntry, transactionDate, type, amount, null, PortfolioProductType.LOAN.getValue(), loanId, null, null, null, null, null);
        return this.journalEntryRepository.saveAndFlush(journalEntry);
    }

    @Override
    public Object linkedGlAccountForLoanProduct(final Long loanProductId, final int accountMappingTypeId) {
        if (FinancialActivity.fromInt(accountMappingTypeId) != null) {
            final FinancialActivityAccount financialActivityAccount = this.financialActivityAccountRepository
                    .findByFinancialActivityTypeWithNotFoundDetection(accountMappingTypeId);
            return financialActivityAccount.getGlAccount();
        }
        final ProductToGLAccountMapping accountMapping = this.accountMappingRepository.findCoreProductToFinAccountMapping(loanProductId,
                PortfolioProductType.LOAN.getValue(), accountMappingTypeId);
        if (accountMapping == null) {
            throw new ProductToGLAccountMappingNotFoundException(PortfolioProductType.LOAN, loanProductId,
                    AccountingConstants.AccrualAccountsForLoan.fromInt(accountMappingTypeId).toString());
        }
        return accountMapping.getGlAccount();
    }

    @Override
    public Object chargeOffMapping(final Long loanProductId, final int productTypeValue, final Long chargeOffReasonId) {
        return this.accountMappingRepository.findChargeOffReasonMapping(loanProductId, productTypeValue, chargeOffReasonId);
    }

    @Override
    public Object chargeOffGlAccount(final Long loanProductId, final int productTypeValue, final Long chargeOffReasonId) {
        final ProductToGLAccountMapping mapping = (ProductToGLAccountMapping) chargeOffMapping(loanProductId, productTypeValue,
                chargeOffReasonId);
        return mapping == null ? null : mapping.getGlAccount();
    }

    @Override
    public Object journalEntryById(final Long journalEntryId) {
        return this.journalEntryRepository.findById(journalEntryId)
                .orElseThrow(() -> new JournalEntryNotFoundException(journalEntryId));
    }
}
