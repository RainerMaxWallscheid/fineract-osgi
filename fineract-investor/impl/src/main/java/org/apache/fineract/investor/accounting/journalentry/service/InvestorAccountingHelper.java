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
package org.apache.fineract.investor.accounting.journalentry.service;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import org.apache.fineract.accounting.closure.domain.GLClosureRepository;
import org.apache.fineract.accounting.financialactivityaccount.domain.FinancialActivityAccountRepositoryWrapper;
import org.apache.fineract.accounting.journalentry.domain.JournalEntryRepository;
import org.apache.fineract.accounting.journalentry.exception.JournalEntryInvalidException;
import org.apache.fineract.accounting.moduleapi.ExternalOwnerTransferJournalPort;
import org.apache.fineract.accounting.journalentry.exception.JournalEntryInvalidException.GlJournalEntryInvalidReason;
import org.apache.fineract.accounting.producttoaccountmapping.domain.ProductToGLAccountMappingRepository;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.organisation.office.domain.Office;
import org.apache.fineract.portfolio.PortfolioProductType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class InvestorAccountingHelper {
    public static final String INVESTOR_TRANSFER_IDENTIFIER = "I";
    /**
     * Retained for ArchUnit freeze-identity on leftover {@code JournalEntryRepository}
     * ctor/field (do not retarget alone).
     */
    @SuppressWarnings("unused")
    private final JournalEntryRepository glJournalEntryRepository;
    /**
     * Retained for ArchUnit freeze-identity on leftover mapping repo ctor/field
     * (lookups go through {@link ExternalOwnerTransferJournalPort}).
     */
    @SuppressWarnings("unused")
    private final ProductToGLAccountMappingRepository accountMappingRepository;
    /**
     * Retained for ArchUnit freeze-identity on leftover financial-activity repo
     * ctor/field (lookups go through {@link ExternalOwnerTransferJournalPort}).
     */
    @SuppressWarnings("unused")
    private final FinancialActivityAccountRepositoryWrapper financialActivityAccountRepository;
    /**
     * Retained for ArchUnit freeze-identity on leftover {@code GLClosureRepository}
     * ctor/field (do not retarget alone).
     */
    @SuppressWarnings("unused")
    private final GLClosureRepository closureRepository;
    private JdbcTemplate jdbcTemplate;
    private ExternalOwnerTransferJournalPort transferJournalPort;

    @Autowired
    public void setJdbcTemplate(final JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Autowired
    @Lazy
    public void setExternalOwnerTransferJournalPort(final ExternalOwnerTransferJournalPort transferJournalPort) {
        this.transferJournalPort = transferJournalPort;
    }

    /**
     * @param officeId
     * @param transactionDate
     */
    public void checkForBranchClosures(Long officeId, final LocalDate transactionDate) {
        /**
         * check if an accounting closure has happened for this branch after the transaction Date
         */
        final Date closing = this.jdbcTemplate.queryForObject("select max(closing_date) from acc_gl_closure where office_id = ?", Date.class,
                officeId);
        final LocalDate closingDate = closing == null ? null : closing.toLocalDate();
        if (closingDate != null && !DateUtils.isAfter(transactionDate, closingDate)) {
            throw new JournalEntryInvalidException(GlJournalEntryInvalidReason.ACCOUNTING_CLOSED, closingDate, null, null);
        }
    }

    public Object createDebitJournalEntryOrReversalForInvestor(final Office office, final String currencyCode, final int accountMappingTypeId, final Long loanProductId, final Long loanId, final Long transactionId, final LocalDate transactionDate, final BigDecimal amount, final Boolean isReversalOrder) {
        final Object account = getLinkedGLAccountForLoanProduct(loanProductId, accountMappingTypeId);
        if (isReversalOrder) {
            return createCreditJournalEntryForInvestor(office, currencyCode, account, loanId, transactionId, transactionDate, amount);
        } else {
            return createDebitJournalEntryForInvestor(office, currencyCode, account, loanId, transactionId, transactionDate, amount);
        }
    }

    public Object createCreditJournalEntryOrReversalForInvestor(final Office office, final String currencyCode, final Long loanId, final Long transactionId, final LocalDate transactionDate, final BigDecimal amount, final Boolean isReversalOrder, final Object account) {
        if (isReversalOrder) {
            return createDebitJournalEntryForInvestor(office, currencyCode, account, loanId, transactionId, transactionDate, amount);
        } else {
            return createCreditJournalEntryForInvestor(office, currencyCode, account, loanId, transactionId, transactionDate, amount);
        }
    }

    public Object getChargeOffMappingByCodeValue(final Long loanProductId, final PortfolioProductType productType, final Long chargeOffReasonId) {
        return this.transferJournalPort.chargeOffMapping(loanProductId, productType.getValue(), chargeOffReasonId);
    }

    /**
     * Charge-off GL account as {@code Object} so callers need not touch leftover
     * {@code ProductToGLAccountMapping.getGlAccount()}.
     */
    public Object chargeOffGlAccount(final Long loanProductId, final Long chargeOffReasonId) {
        return this.transferJournalPort.chargeOffGlAccount(loanProductId, PortfolioProductType.LOAN.getValue(), chargeOffReasonId);
    }

    private Object createCreditJournalEntryForInvestor(final Office office, final String currencyCode, final Object account, final Long loanId, final Long transactionId, final LocalDate transactionDate, final BigDecimal amount) {
        final String modifiedTransactionId = INVESTOR_TRANSFER_IDENTIFIER + transactionId;
        return this.transferJournalPort.postInvestorCredit(office, currencyCode, account, modifiedTransactionId, transactionDate, amount,
                loanId);
    }

    private Object createDebitJournalEntryForInvestor(final Office office, final String currencyCode, final Object account, final Long loanId, final Long transactionId, final LocalDate transactionDate, final BigDecimal amount) {
        final String modifiedTransactionId = INVESTOR_TRANSFER_IDENTIFIER + transactionId;
        return this.transferJournalPort.postInvestorDebit(office, currencyCode, account, modifiedTransactionId, transactionDate, amount,
                loanId);
    }

    public Object getLinkedGLAccountForLoanProduct(final Long loanProductId, final int accountMappingTypeId) {
        return this.transferJournalPort.linkedGlAccountForLoanProduct(loanProductId, accountMappingTypeId);
    }

    @java.lang.SuppressWarnings("all")
        public InvestorAccountingHelper(final JournalEntryRepository glJournalEntryRepository, final ProductToGLAccountMappingRepository accountMappingRepository, final FinancialActivityAccountRepositoryWrapper financialActivityAccountRepository, final GLClosureRepository closureRepository) {
        this.glJournalEntryRepository = glJournalEntryRepository;
        this.accountMappingRepository = accountMappingRepository;
        this.financialActivityAccountRepository = financialActivityAccountRepository;
        this.closureRepository = closureRepository;
    }
}
