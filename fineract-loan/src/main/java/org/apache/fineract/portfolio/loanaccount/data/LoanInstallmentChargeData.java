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

import java.math.BigDecimal;
import java.time.LocalDate;

public class LoanInstallmentChargeData {
    private final Integer installmentNumber;
    private final LocalDate dueDate;
    private final BigDecimal amount;
    private final BigDecimal amountOutstanding;
    private final BigDecimal amountWaived;
    private final boolean paid;
    private final boolean waived;
    private BigDecimal amountAccrued;
    private BigDecimal amountUnrecognized;

    @java.lang.SuppressWarnings("all")
        LoanInstallmentChargeData(final Integer installmentNumber, final LocalDate dueDate, final BigDecimal amount, final BigDecimal amountOutstanding, final BigDecimal amountWaived, final boolean paid, final boolean waived, final BigDecimal amountAccrued, final BigDecimal amountUnrecognized) {
        this.installmentNumber = installmentNumber;
        this.dueDate = dueDate;
        this.amount = amount;
        this.amountOutstanding = amountOutstanding;
        this.amountWaived = amountWaived;
        this.paid = paid;
        this.waived = waived;
        this.amountAccrued = amountAccrued;
        this.amountUnrecognized = amountUnrecognized;
    }


    @java.lang.SuppressWarnings("all")
        public static class LoanInstallmentChargeDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Integer installmentNumber;
        @java.lang.SuppressWarnings("all")
                private LocalDate dueDate;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amountOutstanding;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amountWaived;
        @java.lang.SuppressWarnings("all")
                private boolean paid;
        @java.lang.SuppressWarnings("all")
                private boolean waived;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amountAccrued;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amountUnrecognized;

        @java.lang.SuppressWarnings("all")
                LoanInstallmentChargeDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanInstallmentChargeData.LoanInstallmentChargeDataBuilder installmentNumber(final Integer installmentNumber) {
            this.installmentNumber = installmentNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanInstallmentChargeData.LoanInstallmentChargeDataBuilder dueDate(final LocalDate dueDate) {
            this.dueDate = dueDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanInstallmentChargeData.LoanInstallmentChargeDataBuilder amount(final BigDecimal amount) {
            this.amount = amount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanInstallmentChargeData.LoanInstallmentChargeDataBuilder amountOutstanding(final BigDecimal amountOutstanding) {
            this.amountOutstanding = amountOutstanding;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanInstallmentChargeData.LoanInstallmentChargeDataBuilder amountWaived(final BigDecimal amountWaived) {
            this.amountWaived = amountWaived;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanInstallmentChargeData.LoanInstallmentChargeDataBuilder paid(final boolean paid) {
            this.paid = paid;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanInstallmentChargeData.LoanInstallmentChargeDataBuilder waived(final boolean waived) {
            this.waived = waived;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanInstallmentChargeData.LoanInstallmentChargeDataBuilder amountAccrued(final BigDecimal amountAccrued) {
            this.amountAccrued = amountAccrued;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanInstallmentChargeData.LoanInstallmentChargeDataBuilder amountUnrecognized(final BigDecimal amountUnrecognized) {
            this.amountUnrecognized = amountUnrecognized;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public LoanInstallmentChargeData build() {
            return new LoanInstallmentChargeData(this.installmentNumber, this.dueDate, this.amount, this.amountOutstanding, this.amountWaived, this.paid, this.waived, this.amountAccrued, this.amountUnrecognized);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "LoanInstallmentChargeData.LoanInstallmentChargeDataBuilder(installmentNumber=" + this.installmentNumber + ", dueDate=" + this.dueDate + ", amount=" + this.amount + ", amountOutstanding=" + this.amountOutstanding + ", amountWaived=" + this.amountWaived + ", paid=" + this.paid + ", waived=" + this.waived + ", amountAccrued=" + this.amountAccrued + ", amountUnrecognized=" + this.amountUnrecognized + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static LoanInstallmentChargeData.LoanInstallmentChargeDataBuilder builder() {
        return new LoanInstallmentChargeData.LoanInstallmentChargeDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Integer getInstallmentNumber() {
        return this.installmentNumber;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDueDate() {
        return this.dueDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountOutstanding() {
        return this.amountOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountWaived() {
        return this.amountWaived;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isPaid() {
        return this.paid;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isWaived() {
        return this.waived;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountAccrued() {
        return this.amountAccrued;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountUnrecognized() {
        return this.amountUnrecognized;
    }
}
