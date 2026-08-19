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

import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.portfolio.savings.DepositAccountOnHoldTransactionType;
import org.apache.fineract.portfolio.savings.SavingsAccountTransactionType;
import org.apache.fineract.portfolio.savings.data.SavingsAccountTransactionEnumData;

/**
 * Savings-api transaction-type helper for foreign BCs (ADR-021). Accounting
 * journal reads use this instead of leftover {@code SavingsEnumerations}.
 */
public final class SavingsTransactionEnumerations {

    private SavingsTransactionEnumerations() {}

    public static SavingsAccountTransactionEnumData transactionType(final Integer id) {
        return transactionType(SavingsAccountTransactionType.fromInt(id));
    }

    public static SavingsAccountTransactionEnumData transactionType(final SavingsAccountTransactionType type) {
        final SavingsAccountTransactionType resolved = type == null ? SavingsAccountTransactionType.INVALID : type;
        return switch (resolved) {
            case INVALID -> data(resolved, "Invalid");
            case DEPOSIT -> data(resolved, "Deposit");
            case WITHDRAWAL -> data(resolved, "Withdrawal");
            case ACCRUAL -> data(resolved, "Accrual");
            case INTEREST_POSTING -> data(resolved, "Interest posting");
            case WITHDRAWAL_FEE -> data(resolved, "Withdrawal fee");
            case ANNUAL_FEE -> data(resolved, "Annual fee");
            case APPROVE_TRANSFER -> data(resolved, "Transfer approved");
            case INITIATE_TRANSFER -> data(resolved, "Transfer initiated");
            case REJECT_TRANSFER -> data(resolved, "Transfer Rejected");
            case WITHDRAW_TRANSFER -> data(resolved, "Transfer Withdrawn");
            case PAY_CHARGE -> data(resolved, "Pay Charge");
            case WAIVE_CHARGES -> data(resolved, "Waive Charge");
            case WRITTEN_OFF -> data(resolved, "writtenoff");
            case OVERDRAFT_INTEREST -> data(resolved, "Overdraft Interest");
            case WITHHOLD_TAX -> data(resolved, "Withhold Tax");
            case DIVIDEND_PAYOUT -> data(resolved, "Dividend Payout");
            case ESCHEAT -> data(resolved, "Escheat");
            case AMOUNT_HOLD -> data(resolved, "Amount on hold");
            case AMOUNT_RELEASE -> data(resolved, "Release Amount");
        };
    }

    private static SavingsAccountTransactionEnumData data(final SavingsAccountTransactionType type, final String value) {
        return new SavingsAccountTransactionEnumData(type.getValue().longValue(), type.getCode(), value);
    }

    public static EnumOptionData onHoldTransactionType(final Integer id) {
        return onHoldTransactionType(DepositAccountOnHoldTransactionType.fromInt(id));
    }

    public static EnumOptionData onHoldTransactionType(final DepositAccountOnHoldTransactionType type) {
        final DepositAccountOnHoldTransactionType resolved = type == null ? DepositAccountOnHoldTransactionType.INVALID : type;
        return switch (resolved) {
            case INVALID -> new EnumOptionData(resolved.getValue().longValue(), resolved.getCode(), "Invalid");
            case HOLD -> new EnumOptionData(resolved.getValue().longValue(), resolved.getCode(), "hold");
            case RELEASE -> new EnumOptionData(resolved.getValue().longValue(), resolved.getCode(), "release");
        };
    }
}
