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
package org.apache.fineract.portfolio.loanproduct.service;

import org.apache.fineract.portfolio.loanaccount.data.LoanTransactionEnumData;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransactionType;

/**
 * Loan-api enum helpers for transaction types (used by accounting residual without loan-impl).
 */
public final class LoanTransactionEnumerations {

    private LoanTransactionEnumerations() {
    }

    public static LoanTransactionEnumData transactionType(final Integer id) {
        return transactionType(LoanTransactionType.fromInt(id));
    }

    public static LoanTransactionEnumData transactionType(final LoanTransactionType type) {
        return switch (type) {
            case INVALID -> new LoanTransactionEnumData(LoanTransactionType.INVALID.getValue().longValue(),
                    LoanTransactionType.INVALID.getCode(), "Invalid");
            case DISBURSEMENT -> new LoanTransactionEnumData(LoanTransactionType.DISBURSEMENT.getValue().longValue(),
                    LoanTransactionType.DISBURSEMENT.getCode(), "Disbursement");
            case REPAYMENT -> new LoanTransactionEnumData(LoanTransactionType.REPAYMENT.getValue().longValue(),
                    LoanTransactionType.REPAYMENT.getCode(), "Repayment");
            case REPAYMENT_AT_DISBURSEMENT ->
                new LoanTransactionEnumData(LoanTransactionType.REPAYMENT_AT_DISBURSEMENT.getValue().longValue(),
                        LoanTransactionType.REPAYMENT_AT_DISBURSEMENT.getCode(), "Repayment (at time of disbursement)");
            case CONTRA -> new LoanTransactionEnumData(LoanTransactionType.CONTRA.getValue().longValue(),
                    LoanTransactionType.CONTRA.getCode(), "Reversal");
            case WAIVE_INTEREST -> new LoanTransactionEnumData(LoanTransactionType.WAIVE_INTEREST.getValue().longValue(),
                    LoanTransactionType.WAIVE_INTEREST.getCode(), "Waive interest");
            case MARKED_FOR_RESCHEDULING -> new LoanTransactionEnumData(LoanTransactionType.MARKED_FOR_RESCHEDULING.getValue().longValue(),
                    LoanTransactionType.MARKED_FOR_RESCHEDULING.getCode(), "Close (as rescheduled)");
            case WRITEOFF -> new LoanTransactionEnumData(LoanTransactionType.WRITEOFF.getValue().longValue(),
                    LoanTransactionType.WRITEOFF.getCode(), "Close (as written-off)");
            case RECOVERY_REPAYMENT -> new LoanTransactionEnumData(LoanTransactionType.RECOVERY_REPAYMENT.getValue().longValue(),
                    LoanTransactionType.RECOVERY_REPAYMENT.getCode(), "Repayment (after write-off)");
            case WAIVE_CHARGES -> new LoanTransactionEnumData(LoanTransactionType.WAIVE_CHARGES.getValue().longValue(),
                    LoanTransactionType.WAIVE_CHARGES.getCode(), "Waive loan charges");
            case ACCRUAL -> new LoanTransactionEnumData(LoanTransactionType.ACCRUAL.getValue().longValue(),
                    LoanTransactionType.ACCRUAL.getCode(), "Accrual");
            case APPROVE_TRANSFER -> new LoanTransactionEnumData(LoanTransactionType.APPROVE_TRANSFER.getValue().longValue(),
                    LoanTransactionType.APPROVE_TRANSFER.getCode(), "Transfer approved");
            case INITIATE_TRANSFER -> new LoanTransactionEnumData(LoanTransactionType.INITIATE_TRANSFER.getValue().longValue(),
                    LoanTransactionType.INITIATE_TRANSFER.getCode(), "Transfer initiated");
            case WITHDRAW_TRANSFER -> new LoanTransactionEnumData(LoanTransactionType.WITHDRAW_TRANSFER.getValue().longValue(),
                    LoanTransactionType.WITHDRAW_TRANSFER.getCode(), "Transfer Withdrawn");
            case REJECT_TRANSFER -> new LoanTransactionEnumData(LoanTransactionType.REJECT_TRANSFER.getValue().longValue(),
                    LoanTransactionType.REJECT_TRANSFER.getCode(), "Transfer Rejected");
            case REFUND -> new LoanTransactionEnumData(LoanTransactionType.REFUND.getValue().longValue(),
                    LoanTransactionType.REFUND.getCode(), "Transfer Refund");
            case CHARGE_PAYMENT -> new LoanTransactionEnumData(LoanTransactionType.CHARGE_PAYMENT.getValue().longValue(),
                    LoanTransactionType.CHARGE_PAYMENT.getCode(), "Charge Payment");
            case REFUND_FOR_ACTIVE_LOAN -> new LoanTransactionEnumData(LoanTransactionType.REFUND_FOR_ACTIVE_LOAN.getValue().longValue(),
                    LoanTransactionType.REFUND_FOR_ACTIVE_LOAN.getCode(), "Refund");
            case INCOME_POSTING -> new LoanTransactionEnumData(LoanTransactionType.INCOME_POSTING.getValue().longValue(),
                    LoanTransactionType.INCOME_POSTING.getCode(), "Income Posting");
            case CREDIT_BALANCE_REFUND -> new LoanTransactionEnumData(LoanTransactionType.CREDIT_BALANCE_REFUND.getValue().longValue(),
                    LoanTransactionType.CREDIT_BALANCE_REFUND.getCode(), "Credit Balance Refund");
            case MERCHANT_ISSUED_REFUND -> new LoanTransactionEnumData(LoanTransactionType.MERCHANT_ISSUED_REFUND.getValue().longValue(),
                    LoanTransactionType.MERCHANT_ISSUED_REFUND.getCode(), "Merchant Issued Refund");
            case PAYOUT_REFUND -> new LoanTransactionEnumData(LoanTransactionType.PAYOUT_REFUND.getValue().longValue(),
                    LoanTransactionType.PAYOUT_REFUND.getCode(), "Payout Refund");
            case GOODWILL_CREDIT -> new LoanTransactionEnumData(LoanTransactionType.GOODWILL_CREDIT.getValue().longValue(),
                    LoanTransactionType.GOODWILL_CREDIT.getCode(), "Goodwill Credit");
            case INTEREST_PAYMENT_WAIVER -> new LoanTransactionEnumData(LoanTransactionType.INTEREST_PAYMENT_WAIVER.getValue().longValue(),
                    LoanTransactionType.INTEREST_PAYMENT_WAIVER.getCode(), "Interest Payment Waiver");
            case CHARGE_REFUND -> new LoanTransactionEnumData(LoanTransactionType.CHARGE_REFUND.getValue().longValue(),
                    LoanTransactionType.CHARGE_REFUND.getCode(), "Charge Refund");
            case CHARGEBACK -> new LoanTransactionEnumData(LoanTransactionType.CHARGEBACK.getValue().longValue(),
                    LoanTransactionType.CHARGEBACK.getCode(), "Chargeback");
            case CHARGE_ADJUSTMENT -> new LoanTransactionEnumData(LoanTransactionType.CHARGE_ADJUSTMENT.getValue().longValue(),
                    LoanTransactionType.CHARGE_ADJUSTMENT.getCode(), "Charge Adjustment");
            case CHARGE_OFF -> new LoanTransactionEnumData(LoanTransactionType.CHARGE_OFF.getValue().longValue(),
                    LoanTransactionType.CHARGE_OFF.getCode(), "Charge-off");
            case DOWN_PAYMENT -> new LoanTransactionEnumData(LoanTransactionType.DOWN_PAYMENT.getValue().longValue(),
                    LoanTransactionType.DOWN_PAYMENT.getCode(), "Down Payment");
            case REAGE -> new LoanTransactionEnumData(LoanTransactionType.REAGE.getValue().longValue(), LoanTransactionType.REAGE.getCode(),
                    "Re-age");
            case REAMORTIZE -> new LoanTransactionEnumData(LoanTransactionType.REAMORTIZE.getValue().longValue(),
                    LoanTransactionType.REAMORTIZE.getCode(), "Re-amortize");
            case ACCRUAL_ACTIVITY -> new LoanTransactionEnumData(LoanTransactionType.ACCRUAL_ACTIVITY.getValue().longValue(),
                    LoanTransactionType.ACCRUAL_ACTIVITY.getCode(), "Accrual Activity");
            case INTEREST_REFUND -> new LoanTransactionEnumData(LoanTransactionType.INTEREST_REFUND.getValue().longValue(),
                    LoanTransactionType.INTEREST_REFUND.getCode(), "Interest Refund");
            case ACCRUAL_ADJUSTMENT -> new LoanTransactionEnumData(LoanTransactionType.ACCRUAL_ADJUSTMENT.getValue().longValue(),
                    LoanTransactionType.ACCRUAL_ADJUSTMENT.getCode(), "Accrual Adjustment");
            case CAPITALIZED_INCOME -> new LoanTransactionEnumData(LoanTransactionType.CAPITALIZED_INCOME.getValue().longValue(),
                    LoanTransactionType.CAPITALIZED_INCOME.getCode(), "Capitalized Income");
            case CAPITALIZED_INCOME_AMORTIZATION ->
                new LoanTransactionEnumData(LoanTransactionType.CAPITALIZED_INCOME_AMORTIZATION.getValue().longValue(),
                        LoanTransactionType.CAPITALIZED_INCOME_AMORTIZATION.getCode(), "Capitalized Income Amortization");
            case CAPITALIZED_INCOME_ADJUSTMENT ->
                new LoanTransactionEnumData(LoanTransactionType.CAPITALIZED_INCOME_ADJUSTMENT.getValue().longValue(),
                        LoanTransactionType.CAPITALIZED_INCOME_ADJUSTMENT.getCode(), "Capitalized Income Adjustment");
            case CONTRACT_TERMINATION -> new LoanTransactionEnumData(LoanTransactionType.CONTRACT_TERMINATION.getValue().longValue(),
                    LoanTransactionType.CONTRACT_TERMINATION.getCode(), "Contract Termination");
            case CAPITALIZED_INCOME_AMORTIZATION_ADJUSTMENT -> new LoanTransactionEnumData(
                    LoanTransactionType.CAPITALIZED_INCOME_AMORTIZATION_ADJUSTMENT.getValue().longValue(),
                    LoanTransactionType.CAPITALIZED_INCOME_AMORTIZATION_ADJUSTMENT.getCode(), "Capitalized Income Amortization Adjustment");
            case BUY_DOWN_FEE -> new LoanTransactionEnumData(LoanTransactionType.BUY_DOWN_FEE.getValue().longValue(),
                    LoanTransactionType.BUY_DOWN_FEE.getCode(), "Buy Down Fee");
            case BUY_DOWN_FEE_ADJUSTMENT -> new LoanTransactionEnumData(LoanTransactionType.BUY_DOWN_FEE_ADJUSTMENT.getValue().longValue(),
                    LoanTransactionType.BUY_DOWN_FEE_ADJUSTMENT.getCode(), "Buy Down Fee Adjustment");
            case BUY_DOWN_FEE_AMORTIZATION ->
                new LoanTransactionEnumData(LoanTransactionType.BUY_DOWN_FEE_AMORTIZATION.getValue().longValue(),
                        LoanTransactionType.BUY_DOWN_FEE_AMORTIZATION.getCode(), "Buy Down Fee Amortization");
            case BUY_DOWN_FEE_AMORTIZATION_ADJUSTMENT ->
                new LoanTransactionEnumData(LoanTransactionType.BUY_DOWN_FEE_AMORTIZATION_ADJUSTMENT.getValue().longValue(),
                        LoanTransactionType.BUY_DOWN_FEE_AMORTIZATION_ADJUSTMENT.getCode(), "Buy Down Fee Amortization Adjustment");
            case DISCOUNT_FEE -> new LoanTransactionEnumData(LoanTransactionType.DISCOUNT_FEE.getValue().longValue(),
                    LoanTransactionType.DISCOUNT_FEE.getCode(), "Discount Fee");
            case DISCOUNT_FEE_AMORTIZATION ->
                new LoanTransactionEnumData(LoanTransactionType.DISCOUNT_FEE_AMORTIZATION.getValue().longValue(),
                        LoanTransactionType.DISCOUNT_FEE_AMORTIZATION.getCode(), "Discount Fee Amortization");
            case DISCOUNT_FEE_ADJUSTMENT -> new LoanTransactionEnumData(LoanTransactionType.DISCOUNT_FEE_ADJUSTMENT.getValue().longValue(),
                    LoanTransactionType.DISCOUNT_FEE_ADJUSTMENT.getCode(), "Discount Fee Adjustment");
            case DISCOUNT_FEE_AMORTIZATION_ADJUSTMENT ->
                new LoanTransactionEnumData(LoanTransactionType.DISCOUNT_FEE_AMORTIZATION_ADJUSTMENT.getValue().longValue(),
                        LoanTransactionType.DISCOUNT_FEE_AMORTIZATION_ADJUSTMENT.getCode(), "Discount Fee Amortization Adjustment");
        };
    }
}
