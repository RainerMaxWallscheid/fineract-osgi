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
package org.apache.fineract.interoperation.data;

import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.core.service.MathUtil;
import org.apache.fineract.interoperation.domain.InteropIdentifier;
import org.apache.fineract.portfolio.savings.SavingsAccountTransactionType;
import org.apache.fineract.portfolio.savings.domain.SavingsAccount;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountChargePaidBy;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountSubStatusEnum;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountTransaction;
import org.apache.fineract.portfolio.savings.domain.SavingsProduct;
import org.apache.fineract.portfolio.savings.service.SavingsEnumerations;

/** Maps savings residual entities into pure interoperation DTOs. */
public final class InteropDataFactory {

    private InteropDataFactory() {}

    public static InteropIdentifierData identifier(InteropIdentifier identifier) {
        return new InteropIdentifierData(identifier.getType(), identifier.getValue(), identifier.getSubType());
    }

    public static InteropAccountData account(SavingsAccount account) {
        if (account == null) {
            return null;
        }
        List<InteropIdentifierData> ids = new ArrayList<>();
        for (InteropIdentifier id : account.getIdentifiers()) {
            ids.add(identifier(id));
        }
        SavingsProduct product = account.savingsProduct();
        SavingsAccountSubStatusEnum subStatus = SavingsAccountSubStatusEnum.fromInt(account.getSubStatus());
        return new InteropAccountData(account.getExternalId().getValue(), product.getId().toString(), product.getName(),
                product.getShortName(), account.getCurrency().getCode(), account.getAccountBalance(), account.getWithdrawableBalance(),
                account.getStatus(), subStatus, account.getAccountType(), account.depositAccountType(), account.getActivationDate(),
                calcStatusUpdateOn(account), account.getWithdrawnOnDate(), account.retrieveLastTransactionDate(), ids,
                account.getClient().getId());
    }

    public static InteropIdentifiersResponseData identifiers(SavingsAccount account) {
        List<InteropIdentifierData> result = new ArrayList<>();
        if (account != null) {
            for (InteropIdentifier id : account.getIdentifiers()) {
                result.add(identifier(id));
            }
        }
        return new InteropIdentifiersResponseData(result);
    }

    public static InteropTransactionData transaction(SavingsAccountTransaction transaction) {
        if (transaction == null) {
            return null;
        }
        SavingsAccount savingsAccount = transaction.getSavingsAccount();
        String transactionId = transaction.getId().toString();
        SavingsAccountTransactionType transactionType = transaction.getTransactionType();
        BigDecimal amount = transaction.getAmount();
        BigDecimal chargeAmount = null;
        for (SavingsAccountChargePaidBy charge : transaction.getSavingsAccountChargesPaid()) {
            chargeAmount = MathUtil.add(chargeAmount, charge.getAmount());
        }
        String currency = savingsAccount.getCurrency().getCode();
        BigDecimal runningBalance = transaction.getRunningBalance(savingsAccount.getCurrency()).getAmount();
        LocalDate bookingDateTime = transaction.getTransactionDate();
        LocalDate endOfBalanceLocalDate = transaction.getEndOfBalanceDate();
        LocalDate valueDateTime = endOfBalanceLocalDate == null ? bookingDateTime : endOfBalanceLocalDate;
        String note = SavingsEnumerations.transactionType(transactionType).getValue();
        return new InteropTransactionData(savingsAccount.getId(), savingsAccount.getExternalId().getValue(), transactionId, transactionType,
                amount, chargeAmount, currency, runningBalance, bookingDateTime, valueDateTime, note);
    }

    public static InteropTransactionsData transactions(SavingsAccount account, @NotNull Predicate<SavingsAccountTransaction> filter) {
        if (account == null) {
            return null;
        }
        List<InteropTransactionData> trans = account.getTransactions().stream().filter(filter).sorted((t1, t2) -> {
            int i = DateUtils.compare(t2.getDateOf(), t1.getDateOf());
            return i != 0 ? i : Long.signum(t2.getId() - t1.getId());
        }).map(InteropDataFactory::transaction).collect(Collectors.toList());
        return new InteropTransactionsData(account.getId(), trans);
    }

    private static LocalDate calcStatusUpdateOn(@NotNull SavingsAccount account) {
        if (account.getClosedOnDate() != null) {
            return account.getClosedOnDate();
        }
        if (account.getWithdrawnOnDate() != null) {
            return account.getWithdrawnOnDate();
        }
        if (account.getActivationDate() != null) {
            return account.getActivationDate();
        }
        if (account.getRejectedOnDate() != null) {
            return account.getRejectedOnDate();
        }
        if (account.getApprovedOnDate() != null) {
            return account.getApprovedOnDate();
        }
        if (account.getSubmittedOnDate() != null) {
            return account.getSubmittedOnDate();
        }
        return null;
    }
}
