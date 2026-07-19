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
package org.apache.fineract.portfolio.loanproduct.calc.data;

import java.time.LocalDate;

public final class RepaymentScheduleInstallmentData {
    private final LocalDate fromDate;
    private final LocalDate dueDate;
    private final boolean downPayment;
    private final boolean additional;

    public static RepaymentScheduleInstallmentData of(LocalDate fromDate, LocalDate dueDate, boolean downPayment, boolean additional) {
        return RepaymentScheduleInstallmentData.builder().fromDate(fromDate).dueDate(dueDate).downPayment(downPayment).additional(additional).build();
    }

    @java.lang.SuppressWarnings("all")
        RepaymentScheduleInstallmentData(final LocalDate fromDate, final LocalDate dueDate, final boolean downPayment, final boolean additional) {
        this.fromDate = fromDate;
        this.dueDate = dueDate;
        this.downPayment = downPayment;
        this.additional = additional;
    }


    @java.lang.SuppressWarnings("all")
        public static class RepaymentScheduleInstallmentDataBuilder {
        @java.lang.SuppressWarnings("all")
                private LocalDate fromDate;
        @java.lang.SuppressWarnings("all")
                private LocalDate dueDate;
        @java.lang.SuppressWarnings("all")
                private boolean downPayment;
        @java.lang.SuppressWarnings("all")
                private boolean additional;

        @java.lang.SuppressWarnings("all")
                RepaymentScheduleInstallmentDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public RepaymentScheduleInstallmentData.RepaymentScheduleInstallmentDataBuilder fromDate(final LocalDate fromDate) {
            this.fromDate = fromDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public RepaymentScheduleInstallmentData.RepaymentScheduleInstallmentDataBuilder dueDate(final LocalDate dueDate) {
            this.dueDate = dueDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public RepaymentScheduleInstallmentData.RepaymentScheduleInstallmentDataBuilder downPayment(final boolean downPayment) {
            this.downPayment = downPayment;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public RepaymentScheduleInstallmentData.RepaymentScheduleInstallmentDataBuilder additional(final boolean additional) {
            this.additional = additional;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public RepaymentScheduleInstallmentData build() {
            return new RepaymentScheduleInstallmentData(this.fromDate, this.dueDate, this.downPayment, this.additional);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "RepaymentScheduleInstallmentData.RepaymentScheduleInstallmentDataBuilder(fromDate=" + this.fromDate + ", dueDate=" + this.dueDate + ", downPayment=" + this.downPayment + ", additional=" + this.additional + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static RepaymentScheduleInstallmentData.RepaymentScheduleInstallmentDataBuilder builder() {
        return new RepaymentScheduleInstallmentData.RepaymentScheduleInstallmentDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getFromDate() {
        return this.fromDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDueDate() {
        return this.dueDate;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isDownPayment() {
        return this.downPayment;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isAdditional() {
        return this.additional;
    }
}
