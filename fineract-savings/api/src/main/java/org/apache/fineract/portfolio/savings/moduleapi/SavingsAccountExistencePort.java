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
package org.apache.fineract.portfolio.savings.moduleapi;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

/**
 * ID-only savings-account existence check (ADR-021). Foreign BCs must not
 * depend on leftover {@code SavingsAccountRepository} /
 * {@code SavingsAccountTransactionRepository}.
 */
public interface SavingsAccountExistencePort {

    record SavingsNoteRef(Long savingsAccountId, Long clientId, Long officeId) {}

    record SavingsTransactionNoteRef(Long savingsAccountId, Long savingsTransactionId, Long clientId, Long officeId) {}

    record CampaignSource(Long savingsAccountId, Long clientId) {}

    record TransactionSmsView(Long savingsAccountId, Long clientId, String accountNumber, Object amount, BigDecimal balance,
            LocalDate transactionDate, Long transactionId, String receiptNumber) {}

    /**
     * Throws {@code SavingsAccountNotFoundException} when {@code savingsAccountId} is unknown.
     */
    SavingsNoteRef require(Long savingsAccountId);

    /**
     * Throws {@code SavingsAccountTransactionNotFoundException} when
     * {@code savingsTransactionId} is unknown.
     */
    SavingsTransactionNoteRef requireTransaction(Long savingsTransactionId);

    CampaignSource campaignSource(Object savingsAccount);

    TransactionSmsView transactionSmsView(Object savingsTransaction);

    List<Long> activeIdsByClientId(Long clientId);
}
