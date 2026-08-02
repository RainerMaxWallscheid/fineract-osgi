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
package org.apache.fineract.portfolio.loanaccount.data;

import java.io.Serial;
import java.io.Serializable;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransactionType;

/**
 * Immutable data object represent loan status enumerations.
 */
public class LoanTransactionEnumData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private final Long id;
    private final String code;
    private final String value;
    private final boolean disbursement;
    private final boolean repaymentAtDisbursement;
    private final boolean repayment;
    private final boolean merchantIssuedRefund;
    private final boolean payoutRefund;
    private final boolean goodwillCredit;
    private final boolean interestPaymentWaiver;
    private final boolean chargeRefund;
    private final boolean contra;
    private final boolean waiveInterest;
    private final boolean waiveCharges;
    private final boolean accrual;
    private final boolean writeOff;
    private final boolean recoveryRepayment;
    private final boolean initiateTransfer;
    private final boolean approveTransfer;
    private final boolean withdrawTransfer;
    private final boolean rejectTransfer;
    private final boolean chargePayment;
    private final boolean refund;
    private final boolean refundForActiveLoans;
    private final boolean creditBalanceRefund;
    private final boolean chargeAdjustment;
    private final boolean chargeback;
    private final boolean chargeoff;
    private final boolean downPayment;
    private final boolean reAge;
    private final boolean reAmortize;
    private final boolean accrualActivity;
    private final boolean interestRefund;
    private final boolean accrualAdjustment;
    private final boolean capitalizedIncome;
    private final boolean capitalizedIncomeAmortization;
    private final boolean capitalizedIncomeAdjustment;
    private final boolean capitalizedIncomeAmortizationAdjustment;
    private final boolean contractTermination;
    private final boolean buyDownFee;
    private final boolean buyDownFeeAdjustment;
    private final boolean buyDownFeeAmortization;
    private final boolean buyDownFeeAmortizationAdjustment;

    public LoanTransactionEnumData(final Long id, final String code, final String value) {
        this.id = id;
        this.code = code;
        this.value = value;
        this.disbursement = Long.valueOf(1).equals(this.id);
        this.repaymentAtDisbursement = Long.valueOf(5).equals(this.id);
        this.repayment = Long.valueOf(2).equals(this.id);
        this.merchantIssuedRefund = Long.valueOf(21).equals(this.id);
        this.payoutRefund = Long.valueOf(22).equals(this.id);
        this.goodwillCredit = Long.valueOf(23).equals(this.id);
        this.chargeRefund = Long.valueOf(24).equals(this.id);
        this.contra = Long.valueOf(3).equals(this.id);
        this.waiveInterest = Long.valueOf(4).equals(this.id);
        this.waiveCharges = Long.valueOf(9).equals(this.id);
        this.accrual = Long.valueOf(10).equals(this.id);
        this.writeOff = Long.valueOf(6).equals(this.id);
        this.recoveryRepayment = Long.valueOf(8).equals(this.id);
        this.initiateTransfer = Long.valueOf(12).equals(this.id);
        this.approveTransfer = Long.valueOf(13).equals(this.id);
        this.withdrawTransfer = Long.valueOf(14).equals(this.id);
        this.rejectTransfer = Long.valueOf(15).equals(this.id);
        this.refund = Long.valueOf(16).equals(this.id);
        this.chargePayment = Long.valueOf(17).equals(this.id);
        this.refundForActiveLoans = Long.valueOf(18).equals(this.id);
        this.creditBalanceRefund = Long.valueOf(20).equals(this.id);
        this.chargeback = Long.valueOf(25).equals(this.id);
        this.chargeAdjustment = Long.valueOf(26).equals(this.id);
        this.chargeoff = Long.valueOf(27).equals(this.id);
        this.downPayment = Long.valueOf(28).equals(this.id);
        this.interestPaymentWaiver = Long.valueOf(31).equals(this.id);
        this.accrualActivity = Long.valueOf(32).equals(this.id);
        this.reAge = Long.valueOf(LoanTransactionType.REAGE.getValue()).equals(this.id);
        this.reAmortize = Long.valueOf(LoanTransactionType.REAMORTIZE.getValue()).equals(this.id);
        this.interestRefund = Long.valueOf(LoanTransactionType.INTEREST_REFUND.getValue()).equals(this.id);
        this.accrualAdjustment = Long.valueOf(LoanTransactionType.ACCRUAL_ADJUSTMENT.getValue()).equals(this.id);
        this.capitalizedIncome = Long.valueOf(LoanTransactionType.CAPITALIZED_INCOME.getValue()).equals(this.id);
        this.capitalizedIncomeAmortization = Long.valueOf(LoanTransactionType.CAPITALIZED_INCOME_AMORTIZATION.getValue()).equals(this.id);
        this.capitalizedIncomeAdjustment = Long.valueOf(LoanTransactionType.CAPITALIZED_INCOME_ADJUSTMENT.getValue()).equals(this.id);
        this.capitalizedIncomeAmortizationAdjustment = Long.valueOf(LoanTransactionType.CAPITALIZED_INCOME_AMORTIZATION_ADJUSTMENT.getValue()).equals(this.id);
        this.contractTermination = Long.valueOf(LoanTransactionType.CONTRACT_TERMINATION.getValue()).equals(this.id);
        this.buyDownFee = Long.valueOf(LoanTransactionType.BUY_DOWN_FEE.getValue()).equals(this.id);
        this.buyDownFeeAdjustment = Long.valueOf(LoanTransactionType.BUY_DOWN_FEE_ADJUSTMENT.getValue()).equals(this.id);
        this.buyDownFeeAmortization = Long.valueOf(LoanTransactionType.BUY_DOWN_FEE_AMORTIZATION.getValue()).equals(this.id);
        this.buyDownFeeAmortizationAdjustment = Long.valueOf(LoanTransactionType.BUY_DOWN_FEE_AMORTIZATION_ADJUSTMENT.getValue()).equals(this.id);
    }

    public boolean isRepaymentType() {
        if (isRepayment() || isMerchantIssuedRefund() || isPayoutRefund() || isGoodwillCredit() || isChargeRefund() || isChargeAdjustment() || isDownPayment()) {
            return true;
        }
        return false;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getCode() {
        return this.code;
    }

    @java.lang.SuppressWarnings("all")
        public String getValue() {
        return this.value;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isDisbursement() {
        return this.disbursement;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isRepaymentAtDisbursement() {
        return this.repaymentAtDisbursement;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isRepayment() {
        return this.repayment;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isMerchantIssuedRefund() {
        return this.merchantIssuedRefund;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isPayoutRefund() {
        return this.payoutRefund;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isGoodwillCredit() {
        return this.goodwillCredit;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isInterestPaymentWaiver() {
        return this.interestPaymentWaiver;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isChargeRefund() {
        return this.chargeRefund;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isContra() {
        return this.contra;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isWaiveInterest() {
        return this.waiveInterest;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isWaiveCharges() {
        return this.waiveCharges;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isAccrual() {
        return this.accrual;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isWriteOff() {
        return this.writeOff;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isRecoveryRepayment() {
        return this.recoveryRepayment;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isInitiateTransfer() {
        return this.initiateTransfer;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isApproveTransfer() {
        return this.approveTransfer;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isWithdrawTransfer() {
        return this.withdrawTransfer;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isRejectTransfer() {
        return this.rejectTransfer;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isChargePayment() {
        return this.chargePayment;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isRefund() {
        return this.refund;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isRefundForActiveLoans() {
        return this.refundForActiveLoans;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isCreditBalanceRefund() {
        return this.creditBalanceRefund;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isChargeAdjustment() {
        return this.chargeAdjustment;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isChargeback() {
        return this.chargeback;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isChargeoff() {
        return this.chargeoff;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isDownPayment() {
        return this.downPayment;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isReAge() {
        return this.reAge;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isReAmortize() {
        return this.reAmortize;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isAccrualActivity() {
        return this.accrualActivity;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isInterestRefund() {
        return this.interestRefund;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isAccrualAdjustment() {
        return this.accrualAdjustment;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isCapitalizedIncome() {
        return this.capitalizedIncome;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isCapitalizedIncomeAmortization() {
        return this.capitalizedIncomeAmortization;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isCapitalizedIncomeAdjustment() {
        return this.capitalizedIncomeAdjustment;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isCapitalizedIncomeAmortizationAdjustment() {
        return this.capitalizedIncomeAmortizationAdjustment;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isContractTermination() {
        return this.contractTermination;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isBuyDownFee() {
        return this.buyDownFee;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isBuyDownFeeAdjustment() {
        return this.buyDownFeeAdjustment;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isBuyDownFeeAmortization() {
        return this.buyDownFeeAmortization;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isBuyDownFeeAmortizationAdjustment() {
        return this.buyDownFeeAmortizationAdjustment;
    }
}
