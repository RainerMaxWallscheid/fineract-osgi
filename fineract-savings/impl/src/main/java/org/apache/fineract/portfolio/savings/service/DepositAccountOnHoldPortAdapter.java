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
package org.apache.fineract.portfolio.savings.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import org.apache.fineract.infrastructure.configuration.domain.ConfigurationDomainService;
import org.apache.fineract.infrastructure.core.exception.PlatformInternalServerException;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.portfolio.savings.domain.DepositAccountOnHoldTransaction;
import org.apache.fineract.portfolio.savings.domain.DepositAccountOnHoldTransactionRepository;
import org.apache.fineract.portfolio.savings.domain.SavingsAccount;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountRepositoryWrapper;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountTransaction;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountTransactionSummaryWrapper;
import org.apache.fineract.portfolio.savings.domain.SavingsHelper;
import org.apache.fineract.portfolio.savings.moduleapi.DepositAccountOnHoldPort;
import org.apache.fineract.portfolio.savings.moduleapi.OnHoldReverseResult;
import org.springframework.stereotype.Service;

@Service
public class DepositAccountOnHoldPortAdapter implements DepositAccountOnHoldPort {

    private final DepositAccountOnHoldTransactionRepository depositAccountOnHoldTransactionRepository;
    private final SavingsAccountRepositoryWrapper savingsAccountRepository;
    private final SavingsAccountTransactionSummaryWrapper savingsAccountTransactionSummaryWrapper;
    private final SavingsHelper savingsHelper;
    private final ConfigurationDomainService configurationDomainService;

    public DepositAccountOnHoldPortAdapter(final DepositAccountOnHoldTransactionRepository depositAccountOnHoldTransactionRepository,
            final SavingsAccountRepositoryWrapper savingsAccountRepository,
            final SavingsAccountTransactionSummaryWrapper savingsAccountTransactionSummaryWrapper, final SavingsHelper savingsHelper,
            final ConfigurationDomainService configurationDomainService) {
        this.depositAccountOnHoldTransactionRepository = depositAccountOnHoldTransactionRepository;
        this.savingsAccountRepository = savingsAccountRepository;
        this.savingsAccountTransactionSummaryWrapper = savingsAccountTransactionSummaryWrapper;
        this.savingsHelper = savingsHelper;
        this.configurationDomainService = configurationDomainService;
    }

    @Override
    public Object hold(final Long savingsAccountId, final BigDecimal amount, final LocalDate date) {
        final SavingsAccount savingsAccount = this.savingsAccountRepository.findOneWithNotFoundDetection(savingsAccountId);
        savingsAccount.holdFunds(amount);
        return DepositAccountOnHoldTransaction.hold(savingsAccount, amount, date);
    }

    @Override
    public Object release(final Long savingsAccountId, final BigDecimal amount, final LocalDate date) {
        final SavingsAccount savingsAccount = this.savingsAccountRepository.findOneWithNotFoundDetection(savingsAccountId);
        savingsAccount.releaseFunds(amount);
        return DepositAccountOnHoldTransaction.release(savingsAccount, amount, date);
    }

    @Override
    public BigDecimal withdrawableBalance(final Long savingsAccountId) {
        return this.savingsAccountRepository.findOneWithNotFoundDetection(savingsAccountId).getWithdrawableBalance();
    }

    @Override
    public Object persist(final Object onHoldTransaction) {
        return this.depositAccountOnHoldTransactionRepository.saveAndFlush((DepositAccountOnHoldTransaction) onHoldTransaction);
    }

    @Override
    @SuppressWarnings("unchecked")
    public void persistAll(final List<Object> onHoldTransactions) {
        this.depositAccountOnHoldTransactionRepository.saveAll((List<DepositAccountOnHoldTransaction>) (List<?>) onHoldTransactions);
        this.depositAccountOnHoldTransactionRepository.flush();
    }

    @Override
    public void rebuildSummaryUntil(final Long savingsAccountId, final LocalDate until) {
        final SavingsAccount savingsAccount = attachHelpers(savingsAccountId);
        final List<SavingsAccountTransaction> transactions = new ArrayList<>();
        for (final SavingsAccountTransaction transaction : savingsAccount.getTransactions()) {
            if (!DateUtils.isAfter(transaction.getTransactionDate(), until)) {
                transactions.add(transaction);
            }
        }
        savingsAccount.updateSavingsAccountSummary(transactions);
    }

    @Override
    public void refreshSummary(final Long savingsAccountId) {
        final SavingsAccount savingsAccount = attachHelpers(savingsAccountId);
        savingsAccount.updateSavingsAccountSummary(savingsAccount.getTransactions());
    }

    private SavingsAccount attachHelpers(final Long savingsAccountId) {
        final SavingsAccount savingsAccount = this.savingsAccountRepository.findOneWithNotFoundDetection(savingsAccountId);
        savingsAccount.setHelpers(this.savingsAccountTransactionSummaryWrapper, this.savingsHelper, this.configurationDomainService);
        return savingsAccount;
    }

    @Override
    public OnHoldReverseResult reverse(final Long onHoldTransactionId) {
        final DepositAccountOnHoldTransaction onHoldTransaction = this.depositAccountOnHoldTransactionRepository.findById(onHoldTransactionId)
                .orElseThrow(() -> new PlatformInternalServerException("error.msg.deposit.onhold.transaction.not.found",
                        "Deposit account on-hold transaction with identifier " + onHoldTransactionId + " does not exist",
                        onHoldTransactionId));
        final OnHoldReverseResult result = new OnHoldReverseResult(onHoldTransaction.getAmount(),
                onHoldTransaction.getTransactionType().isRelease());
        onHoldTransaction.reverseTransaction();
        this.depositAccountOnHoldTransactionRepository.save(onHoldTransaction);
        return result;
    }
}
