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
import java.time.format.DateTimeFormatter;
import java.util.List;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.portfolio.savings.data.SavingsAccountTransactionDTO;

/**
 * Object-free savings projection for loan-linked account validation (ADR-021).
 * Foreign BCs must not depend on leftover {@code SavingsAccount} /
 * {@code SavingsAccountRepositoryWrapper} graphs.
 */
public interface LinkedSavingsAccountPort {

    record AccountNumberSource(Long id, String officeName, String productShortName) {}

    record ShareAccountNumberSource(Long id, String productShortName) {}

    record TransferTxn(Long transactionId, Long savingsAccountId, String currencyCode, int digitsAfterDecimal, Integer inMultiplesOf) {}

    /**
     * Loads the savings account for loan-link validation.
     *
     * @throws org.apache.fineract.portfolio.savings.exception.SavingsAccountNotFoundException
     *             when the id does not exist
     */
    LinkedSavingsAccountView requireById(Long savingsAccountId);

    /**
     * Persistable savings account for association writes (Object-typed, ADR-021).
     *
     * @throws org.apache.fineract.portfolio.savings.exception.SavingsAccountNotFoundException
     *             when the id does not exist
     */
    Object persistableById(Long savingsAccountId);

    /**
     * Child savings account id for a GSIM parent and client member. Returns
     * {@code null} when the client is not a GSIM member.
     */
    Long childAccountIdForGsimClient(Long gsimAccountId, Long clientId);

    AccountNumberSource accountNumberSource(Object savingsAccount);

    boolean existsByAccountNumber(String accountNumber);

    ShareAccountNumberSource shareAccountNumberSource(Object shareAccount);

    boolean shareExistsByAccountNumber(String accountNumber);

    boolean belongsToClient(Long savingsAccountId, Long clientId);

    boolean hasNonClosedForClient(Long clientId);

    boolean hasOpenForClient(Long clientId);

    List<Long> nonClosedIdsByClientId(Long clientId);

    boolean hasOpenForGroup(Long groupId);

    LocalDate closedOnDate(Long savingsAccountId);

    boolean hasGroupSavings(Long clientId, Long groupId);

    TransferTxn handleDeposit(Long savingsAccountId, DateTimeFormatter fmt, LocalDate transactionDate, BigDecimal amount,
            Object paymentDetail, boolean isAccountTransfer, boolean isRegularTransaction, boolean backdatedTxnsAllowedTill);

    TransferTxn handleWithdrawal(Long savingsAccountId, DateTimeFormatter fmt, LocalDate transactionDate, BigDecimal amount,
            Object paymentDetail, boolean isAccountTransfer, boolean isRegularTransaction, boolean isInterestTransfer,
            boolean isExceptionForBalanceCheck, boolean backdatedTxnsAllowedTill);

    void undoTransaction(Long savingsAccountId, Long transactionId, boolean allowAccountTransferModification);

    Long handleDividendPayout(Long savingsAccountId, LocalDate transactionDate, BigDecimal amount);

    List<Long> mandatoryDeposits(JsonCommand command, Object paymentDetail);

    void initiateTransfer(Long savingsAccountId, LocalDate transferDate);

    void withdrawTransfer(Long savingsAccountId, LocalDate transferDate);

    void rejectTransfer(Long savingsAccountId);

    void acceptTransfer(Long savingsAccountId, LocalDate lastTransactionDate, Object office, Object staff);

    void reassignOfficer(Long savingsAccountId, Object staff, LocalDate date);

    void addToGsimParentDeposit(Long savingsAccountId, BigDecimal amount);

    Object office(Long savingsAccountId);

    void setHelpers(Object savingsAccount);
}
