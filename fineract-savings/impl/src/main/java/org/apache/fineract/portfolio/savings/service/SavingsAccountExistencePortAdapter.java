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

import java.util.List;
import org.apache.fineract.portfolio.savings.domain.SavingsAccount;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountRepository;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountTransaction;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountTransactionRepository;
import org.apache.fineract.portfolio.savings.exception.SavingsAccountNotFoundException;
import org.apache.fineract.portfolio.savings.exception.SavingsAccountTransactionNotFoundException;
import org.apache.fineract.portfolio.savings.moduleapi.SavingsAccountExistencePort;
import org.springframework.stereotype.Service;

@Service
public class SavingsAccountExistencePortAdapter implements SavingsAccountExistencePort {

    private final SavingsAccountRepository savingsAccountRepository;
    private final SavingsAccountTransactionRepository savingsAccountTransactionRepository;

    public SavingsAccountExistencePortAdapter(final SavingsAccountRepository savingsAccountRepository,
            final SavingsAccountTransactionRepository savingsAccountTransactionRepository) {
        this.savingsAccountRepository = savingsAccountRepository;
        this.savingsAccountTransactionRepository = savingsAccountTransactionRepository;
    }

    @Override
    public SavingsNoteRef require(final Long savingsAccountId) {
        final SavingsAccount account = savingsAccountRepository.findById(savingsAccountId)
                .orElseThrow(() -> new SavingsAccountNotFoundException(savingsAccountId));
        return new SavingsNoteRef(account.getId(), account.clientId(), account.officeId());
    }

    @Override
    public SavingsTransactionNoteRef requireTransaction(final Long savingsTransactionId) {
        final SavingsAccountTransaction transaction = savingsAccountTransactionRepository.findById(savingsTransactionId)
                .orElseThrow(() -> new SavingsAccountTransactionNotFoundException(null, savingsTransactionId));
        final SavingsAccount account = transaction.getSavingsAccount();
        return new SavingsTransactionNoteRef(account.getId(), transaction.getId(), account.clientId(), account.officeId());
    }

    @Override
    public CampaignSource campaignSource(final Object savingsAccount) {
        final SavingsAccount account = (SavingsAccount) savingsAccount;
        return new CampaignSource(account.getId(), account.clientId());
    }

    @Override
    public TransactionSmsView transactionSmsView(final Object savingsTransaction) {
        final SavingsAccountTransaction transaction = (SavingsAccountTransaction) savingsTransaction;
        final SavingsAccount account = transaction.getSavingsAccount();
        final String receiptNumber = transaction.getPaymentDetail() != null ? transaction.getPaymentDetail().getReceiptNumber() : null;
        return new TransactionSmsView(account.getId(), account.clientId(), account.getAccountNumber(),
                transaction.getAmount(account.getCurrency()), account.getWithdrawableBalance(), transaction.getTransactionDate(),
                transaction.getId(), receiptNumber);
    }

    @Override
    public List<Long> activeIdsByClientId(final Long clientId) {
        return savingsAccountRepository.findSavingAccountByClientId(clientId).stream().filter(SavingsAccount::isActive)
                .map(SavingsAccount::getId).toList();
    }
}
