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
package org.apache.fineract.portfolio.account.domain;

import static org.apache.fineract.portfolio.account.api.AccountTransfersApiConstants.transferAmountParamName;
import static org.apache.fineract.portfolio.account.api.AccountTransfersApiConstants.transferDateParamName;
import static org.apache.fineract.portfolio.account.api.AccountTransfersApiConstants.transferDescriptionParamName;

import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.organisation.monetary.domain.MonetaryCurrency;
import org.apache.fineract.organisation.monetary.domain.Money;
import org.apache.fineract.portfolio.account.data.AccountTransferDTO;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransaction;
import org.apache.fineract.portfolio.savings.moduleapi.LinkedSavingsAccountPort;
import org.apache.fineract.portfolio.savings.moduleapi.LinkedSavingsAccountView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AccountTransferAssembler {

    private final AccountTransferDetailAssembler accountTransferDetailAssembler;
    private LinkedSavingsAccountPort linkedSavingsAccountPort;

    @Autowired
    public AccountTransferAssembler(final AccountTransferDetailAssembler accountTransferDetailAssembler) {
        this.accountTransferDetailAssembler = accountTransferDetailAssembler;
    }

    @Autowired
    public void setLinkedSavingsAccountPort(final LinkedSavingsAccountPort linkedSavingsAccountPort) {
        this.linkedSavingsAccountPort = linkedSavingsAccountPort;
    }

    private Money moneyOf(final Long savingsAccountId, final BigDecimal amount) {
        final LinkedSavingsAccountView view = this.linkedSavingsAccountPort.requireById(savingsAccountId);
        return Money.of(new MonetaryCurrency(view.getCurrencyCode(), view.getDigitsAfterDecimal(), view.getInMultiplesOf()), amount);
    }

    public AccountTransferDetails assembleSavingsToSavingsTransfer(final JsonCommand command, final Long fromSavingsAccountId,
            final Long toSavingsAccountId, final Long withdrawalId, final Long depositId) {

        final AccountTransferDetails accountTransferDetails = this.accountTransferDetailAssembler.assembleSavingsToSavingsTransfer(command,
                fromSavingsAccountId, toSavingsAccountId);

        final LocalDate transactionDate = command.localDateValueOfParameterNamed(transferDateParamName);
        final BigDecimal transactionAmount = command.bigDecimalValueOfParameterNamed(transferAmountParamName);
        final Money transactionMonetaryAmount = moneyOf(fromSavingsAccountId, transactionAmount);

        final String description = command.stringValueOfParameterNamed(transferDescriptionParamName);
        AccountTransferTransaction accountTransferTransaction = AccountTransferTransaction.savingsToSavingsTransfer(accountTransferDetails,
                withdrawalId, depositId, transactionDate, transactionMonetaryAmount, description);
        accountTransferDetails.addAccountTransferTransaction(accountTransferTransaction);
        return accountTransferDetails;
    }

    public AccountTransferDetails assembleSavingsToLoanTransfer(final JsonCommand command, final Long fromSavingsAccountId,
            final Loan toLoanAccount, final Long withdrawalId, final LoanTransaction loanRepaymentTransaction) {

        final AccountTransferDetails accountTransferDetails = this.accountTransferDetailAssembler.assembleSavingsToLoanTransfer(command,
                fromSavingsAccountId, toLoanAccount);
        final LocalDate transactionDate = command.localDateValueOfParameterNamed(transferDateParamName);
        final BigDecimal transactionAmount = command.bigDecimalValueOfParameterNamed(transferAmountParamName);
        final Money transactionMonetaryAmount = moneyOf(fromSavingsAccountId, transactionAmount);

        final String description = command.stringValueOfParameterNamed(transferDescriptionParamName);

        AccountTransferTransaction accountTransferTransaction = AccountTransferTransaction.savingsToLoanTransfer(accountTransferDetails,
                withdrawalId, loanRepaymentTransaction, transactionDate, transactionMonetaryAmount, description);
        accountTransferDetails.addAccountTransferTransaction(accountTransferTransaction);
        return accountTransferDetails;
    }

    public AccountTransferDetails assembleLoanToSavingsTransfer(final JsonCommand command, final Loan fromLoanAccount,
            final Long toSavingsAccountId, final Long depositId, final LoanTransaction loanRefundTransaction) {

        final AccountTransferDetails accountTransferDetails = this.accountTransferDetailAssembler.assembleLoanToSavingsTransfer(command,
                fromLoanAccount, toSavingsAccountId);

        final LocalDate transactionDate = command.localDateValueOfParameterNamed(transferDateParamName);
        final BigDecimal transactionAmount = command.bigDecimalValueOfParameterNamed(transferAmountParamName);
        final Money transactionMonetaryAmount = moneyOf(toSavingsAccountId, transactionAmount);

        final String description = command.stringValueOfParameterNamed(transferDescriptionParamName);

        AccountTransferTransaction accountTransferTransaction = AccountTransferTransaction.loanTosavingsTransfer(accountTransferDetails,
                depositId, loanRefundTransaction, transactionDate, transactionMonetaryAmount, description);
        accountTransferDetails.addAccountTransferTransaction(accountTransferTransaction);
        return accountTransferDetails;
    }

    public AccountTransferDetails assembleSavingsToLoanTransfer(final AccountTransferDTO accountTransferDTO,
            final Long fromSavingsAccountId, final Loan toLoanAccount, final Long savingsTransactionId,
            final LoanTransaction loanTransaction) {
        final Money transactionMonetaryAmount = moneyOf(fromSavingsAccountId, accountTransferDTO.getTransactionAmount());
        AccountTransferDetails accountTransferDetails = accountTransferDTO.getAccountTransferDetails();
        if (accountTransferDetails == null) {
            accountTransferDetails = this.accountTransferDetailAssembler.assembleSavingsToLoanTransfer(fromSavingsAccountId, toLoanAccount,
                    accountTransferDTO.getTransferType());
        }
        AccountTransferTransaction accountTransferTransaction = AccountTransferTransaction.savingsToLoanTransfer(accountTransferDetails,
                savingsTransactionId, loanTransaction, accountTransferDTO.getTransactionDate(), transactionMonetaryAmount,
                accountTransferDTO.getDescription());
        accountTransferDetails.addAccountTransferTransaction(accountTransferTransaction);
        return accountTransferDetails;
    }

    public AccountTransferDetails assembleSavingsToSavingsTransfer(final AccountTransferDTO accountTransferDTO,
            final Long fromSavingsAccountId, final Long toSavingsAccountId, final Long withdrawalId, final Long depositId) {
        final Money transactionMonetaryAmount = moneyOf(fromSavingsAccountId, accountTransferDTO.getTransactionAmount());
        AccountTransferDetails accountTransferDetails = accountTransferDTO.getAccountTransferDetails();
        if (accountTransferDetails == null) {
            accountTransferDetails = this.accountTransferDetailAssembler.assembleSavingsToSavingsTransfer(fromSavingsAccountId,
                    toSavingsAccountId, accountTransferDTO.getTransferType());
        }

        AccountTransferTransaction accountTransferTransaction = AccountTransferTransaction.savingsToSavingsTransfer(accountTransferDetails,
                withdrawalId, depositId, accountTransferDTO.getTransactionDate(), transactionMonetaryAmount,
                accountTransferDTO.getDescription());
        accountTransferDetails.addAccountTransferTransaction(accountTransferTransaction);
        return accountTransferDetails;
    }

    public AccountTransferDetails assembleLoanToSavingsTransfer(final AccountTransferDTO accountTransferDTO, final Loan fromLoanAccount,
            final Long toSavingsAccountId, final Long depositId, final LoanTransaction loanRefundTransaction) {
        final Money transactionMonetaryAmount = Money.of(fromLoanAccount.getCurrency(), accountTransferDTO.getTransactionAmount());
        AccountTransferDetails accountTransferDetails = accountTransferDTO.getAccountTransferDetails();
        if (accountTransferDetails == null) {
            accountTransferDetails = this.accountTransferDetailAssembler.assembleLoanToSavingsTransfer(fromLoanAccount, toSavingsAccountId,
                    accountTransferDTO.getTransferType());
        }
        AccountTransferTransaction accountTransferTransaction = AccountTransferTransaction.loanTosavingsTransfer(accountTransferDetails,
                depositId, loanRefundTransaction, accountTransferDTO.getTransactionDate(), transactionMonetaryAmount,
                accountTransferDTO.getDescription());
        accountTransferDetails.addAccountTransferTransaction(accountTransferTransaction);
        return accountTransferDetails;
    }

    public AccountTransferDetails assembleLoanToLoanTransfer(final AccountTransferDTO accountTransferDTO, final Loan fromLoanAccount,
            final Loan toLoanAccount, final LoanTransaction disburseTransaction, final LoanTransaction repaymentTransaction) {
        final Money transactionMonetaryAmount = Money.of(fromLoanAccount.getCurrency(), accountTransferDTO.getTransactionAmount());
        AccountTransferDetails accountTransferDetails = accountTransferDTO.getAccountTransferDetails();
        if (accountTransferDetails == null) {
            accountTransferDetails = this.accountTransferDetailAssembler.assembleLoanToLoanTransfer(fromLoanAccount, toLoanAccount,
                    accountTransferDTO.getFromTransferType());
        }
        AccountTransferTransaction accountTransferTransaction = AccountTransferTransaction.loanToLoanTransfer(accountTransferDetails,
                disburseTransaction, repaymentTransaction, accountTransferDTO.getTransactionDate(), transactionMonetaryAmount,
                accountTransferDTO.getDescription());
        accountTransferDetails.addAccountTransferTransaction(accountTransferTransaction);
        return accountTransferDetails;
    }

}
