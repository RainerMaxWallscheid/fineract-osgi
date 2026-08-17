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
package org.apache.fineract.portfolio.loanaccount.progressiveloan.data;

import java.math.BigDecimal;

public class CapitalizedIncomeDetails {
    private BigDecimal amount;
    private BigDecimal amortizedAmount;
    private BigDecimal unrecognizedAmount;
    private BigDecimal amountAdjustment;
    private BigDecimal chargedOffAmount;

    @java.lang.SuppressWarnings("all")
        public CapitalizedIncomeDetails(final BigDecimal amount, final BigDecimal amortizedAmount, final BigDecimal unrecognizedAmount, final BigDecimal amountAdjustment, final BigDecimal chargedOffAmount) {
        this.amount = amount;
        this.amortizedAmount = amortizedAmount;
        this.unrecognizedAmount = unrecognizedAmount;
        this.amountAdjustment = amountAdjustment;
        this.chargedOffAmount = chargedOffAmount;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CapitalizedIncomeDetails(amount=" + this.getAmount() + ", amortizedAmount=" + this.getAmortizedAmount() + ", unrecognizedAmount=" + this.getUnrecognizedAmount() + ", amountAdjustment=" + this.getAmountAdjustment() + ", chargedOffAmount=" + this.getChargedOffAmount() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmortizedAmount() {
        return this.amortizedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getUnrecognizedAmount() {
        return this.unrecognizedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountAdjustment() {
        return this.amountAdjustment;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getChargedOffAmount() {
        return this.chargedOffAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmount(final BigDecimal amount) {
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmortizedAmount(final BigDecimal amortizedAmount) {
        this.amortizedAmount = amortizedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setUnrecognizedAmount(final BigDecimal unrecognizedAmount) {
        this.unrecognizedAmount = unrecognizedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmountAdjustment(final BigDecimal amountAdjustment) {
        this.amountAdjustment = amountAdjustment;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargedOffAmount(final BigDecimal chargedOffAmount) {
        this.chargedOffAmount = chargedOffAmount;
    }
}
