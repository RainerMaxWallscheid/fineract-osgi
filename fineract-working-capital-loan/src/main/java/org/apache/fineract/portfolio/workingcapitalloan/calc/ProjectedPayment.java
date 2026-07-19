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
package org.apache.fineract.portfolio.workingcapitalloan.calc;

import com.google.gson.annotations.SerializedName;
import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.organisation.monetary.domain.Money;

/**
 * Single payment of a Working Capital loan's projected amortization schedule.
 */
public class ProjectedPayment {
    /**
     * 1-based payment number (0 = disbursement row).
     */
    private final int paymentNo;
    private final LocalDate date;
    /**
     * Exponent for discount factor: {@code DF = 1/(1+EIR)^paymentsLeft}. Zero for paid periods.
     */
    private final long paymentsLeft;
    /**
     * {@code (TPV × periodRate) / dayCount / 100}; negated disbursement for row 0.
     */
    private final Money expectedPaymentAmount;
    /**
     * {@code 1 / (1 + EIR)^paymentsLeft}
     */
    private final BigDecimal discountFactor;
    /**
     * {@code npvSource × discountFactor}
     */
    private final Money npvValue;
    /**
     * Running balance of net disbursement based on expected payments.
     */
    @SerializedName(value = "expectedBalance", alternate = "balance")
    private final Money expectedBalance;
    /**
     * Running balance of net disbursement based on actual payments.
     */
    private final Money actualBalance;
    /**
     * {@code balance[i] + expectedPayment - balance[i-1]} (equivalent to {@code prevBalance × EIR})
     */
    private final Money expectedAmortizationAmount;
    private final Money actualPaymentAmount;
    /**
     * Cursor-based consumption of expected amortization proportional to payment ratio.
     */
    private final Money actualAmortizationAmount;
    /**
     * {@code actualAmortization - expectedAmortization}
     */
    private final Money incomeModification;
    /**
     * Running balance of discount fee based on expected amortizations.
     */
    @SerializedName(value = "expectedDiscountFeeBalance", alternate = "deferredBalance")
    private final Money expectedDiscountFeeBalance;
    /**
     * Running balance of discount fee based on actual amortizations.
     */
    private final Money actualDiscountFeeBalance;

    /**
     * 1-based payment number (0 = disbursement row).
     */
    @java.lang.SuppressWarnings("all")
        public int paymentNo() {
        return this.paymentNo;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate date() {
        return this.date;
    }

    /**
     * Exponent for discount factor: {@code DF = 1/(1+EIR)^paymentsLeft}. Zero for paid periods.
     */
    @java.lang.SuppressWarnings("all")
        public long paymentsLeft() {
        return this.paymentsLeft;
    }

    /**
     * {@code (TPV × periodRate) / dayCount / 100}; negated disbursement for row 0.
     */
    @java.lang.SuppressWarnings("all")
        public Money expectedPaymentAmount() {
        return this.expectedPaymentAmount;
    }

    /**
     * {@code 1 / (1 + EIR)^paymentsLeft}
     */
    @java.lang.SuppressWarnings("all")
        public BigDecimal discountFactor() {
        return this.discountFactor;
    }

    /**
     * {@code npvSource × discountFactor}
     */
    @java.lang.SuppressWarnings("all")
        public Money npvValue() {
        return this.npvValue;
    }

    /**
     * Running balance of net disbursement based on expected payments.
     */
    @java.lang.SuppressWarnings("all")
        public Money expectedBalance() {
        return this.expectedBalance;
    }

    /**
     * Running balance of net disbursement based on actual payments.
     */
    @java.lang.SuppressWarnings("all")
        public Money actualBalance() {
        return this.actualBalance;
    }

    /**
     * {@code balance[i] + expectedPayment - balance[i-1]} (equivalent to {@code prevBalance × EIR})
     */
    @java.lang.SuppressWarnings("all")
        public Money expectedAmortizationAmount() {
        return this.expectedAmortizationAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Money actualPaymentAmount() {
        return this.actualPaymentAmount;
    }

    /**
     * Cursor-based consumption of expected amortization proportional to payment ratio.
     */
    @java.lang.SuppressWarnings("all")
        public Money actualAmortizationAmount() {
        return this.actualAmortizationAmount;
    }

    /**
     * {@code actualAmortization - expectedAmortization}
     */
    @java.lang.SuppressWarnings("all")
        public Money incomeModification() {
        return this.incomeModification;
    }

    /**
     * Running balance of discount fee based on expected amortizations.
     */
    @java.lang.SuppressWarnings("all")
        public Money expectedDiscountFeeBalance() {
        return this.expectedDiscountFeeBalance;
    }

    /**
     * Running balance of discount fee based on actual amortizations.
     */
    @java.lang.SuppressWarnings("all")
        public Money actualDiscountFeeBalance() {
        return this.actualDiscountFeeBalance;
    }

    /**
     * Creates a new {@code ProjectedPayment} instance.
     *
     * @param paymentNo 1-based payment number (0 = disbursement row).
     * @param date
     * @param paymentsLeft Exponent for discount factor: {@code DF = 1/(1+EIR)^paymentsLeft}. Zero for paid periods.
     * @param expectedPaymentAmount {@code (TPV × periodRate) / dayCount / 100}; negated disbursement for row 0.
     * @param discountFactor {@code 1 / (1 + EIR)^paymentsLeft}
     * @param npvValue {@code npvSource × discountFactor}
     * @param expectedBalance Running balance of net disbursement based on expected payments.
     * @param actualBalance Running balance of net disbursement based on actual payments.
     * @param expectedAmortizationAmount {@code balance[i] + expectedPayment - balance[i-1]} (equivalent to {@code prevBalance × EIR})
     * @param actualPaymentAmount
     * @param actualAmortizationAmount Cursor-based consumption of expected amortization proportional to payment ratio.
     * @param incomeModification {@code actualAmortization - expectedAmortization}
     * @param expectedDiscountFeeBalance Running balance of discount fee based on expected amortizations.
     * @param actualDiscountFeeBalance Running balance of discount fee based on actual amortizations.
     */
    @java.lang.SuppressWarnings("all")
        public ProjectedPayment(final int paymentNo, final LocalDate date, final long paymentsLeft, final Money expectedPaymentAmount, final BigDecimal discountFactor, final Money npvValue, final Money expectedBalance, final Money actualBalance, final Money expectedAmortizationAmount, final Money actualPaymentAmount, final Money actualAmortizationAmount, final Money incomeModification, final Money expectedDiscountFeeBalance, final Money actualDiscountFeeBalance) {
        this.paymentNo = paymentNo;
        this.date = date;
        this.paymentsLeft = paymentsLeft;
        this.expectedPaymentAmount = expectedPaymentAmount;
        this.discountFactor = discountFactor;
        this.npvValue = npvValue;
        this.expectedBalance = expectedBalance;
        this.actualBalance = actualBalance;
        this.expectedAmortizationAmount = expectedAmortizationAmount;
        this.actualPaymentAmount = actualPaymentAmount;
        this.actualAmortizationAmount = actualAmortizationAmount;
        this.incomeModification = incomeModification;
        this.expectedDiscountFeeBalance = expectedDiscountFeeBalance;
        this.actualDiscountFeeBalance = actualDiscountFeeBalance;
    }
}
