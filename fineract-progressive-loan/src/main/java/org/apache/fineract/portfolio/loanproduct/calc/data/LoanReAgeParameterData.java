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
import org.apache.fineract.portfolio.common.domain.PeriodFrequencyType;
import org.apache.fineract.portfolio.loanaccount.domain.reaging.LoanReAgeInterestHandlingType;

public final class LoanReAgeParameterData {
    private final PeriodFrequencyType frequencyType;
    private final Integer frequencyNumber;
    private final LocalDate startDate;
    private final Integer numberOfInstallments;
    private final LoanReAgeInterestHandlingType interestHandlingType;

    public static LoanReAgeParameterData of(PeriodFrequencyType frequencyType, Integer frequencyNumber, LocalDate startDate, Integer numberOfInstallments, LoanReAgeInterestHandlingType interestHandlingType) {
        return LoanReAgeParameterData.builder().frequencyType(frequencyType).frequencyNumber(frequencyNumber).startDate(startDate).numberOfInstallments(numberOfInstallments).interestHandlingType(interestHandlingType).build();
    }

    @java.lang.SuppressWarnings("all")
        LoanReAgeParameterData(final PeriodFrequencyType frequencyType, final Integer frequencyNumber, final LocalDate startDate, final Integer numberOfInstallments, final LoanReAgeInterestHandlingType interestHandlingType) {
        this.frequencyType = frequencyType;
        this.frequencyNumber = frequencyNumber;
        this.startDate = startDate;
        this.numberOfInstallments = numberOfInstallments;
        this.interestHandlingType = interestHandlingType;
    }


    @java.lang.SuppressWarnings("all")
        public static class LoanReAgeParameterDataBuilder {
        @java.lang.SuppressWarnings("all")
                private PeriodFrequencyType frequencyType;
        @java.lang.SuppressWarnings("all")
                private Integer frequencyNumber;
        @java.lang.SuppressWarnings("all")
                private LocalDate startDate;
        @java.lang.SuppressWarnings("all")
                private Integer numberOfInstallments;
        @java.lang.SuppressWarnings("all")
                private LoanReAgeInterestHandlingType interestHandlingType;

        @java.lang.SuppressWarnings("all")
                LoanReAgeParameterDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanReAgeParameterData.LoanReAgeParameterDataBuilder frequencyType(final PeriodFrequencyType frequencyType) {
            this.frequencyType = frequencyType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanReAgeParameterData.LoanReAgeParameterDataBuilder frequencyNumber(final Integer frequencyNumber) {
            this.frequencyNumber = frequencyNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanReAgeParameterData.LoanReAgeParameterDataBuilder startDate(final LocalDate startDate) {
            this.startDate = startDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanReAgeParameterData.LoanReAgeParameterDataBuilder numberOfInstallments(final Integer numberOfInstallments) {
            this.numberOfInstallments = numberOfInstallments;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanReAgeParameterData.LoanReAgeParameterDataBuilder interestHandlingType(final LoanReAgeInterestHandlingType interestHandlingType) {
            this.interestHandlingType = interestHandlingType;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public LoanReAgeParameterData build() {
            return new LoanReAgeParameterData(this.frequencyType, this.frequencyNumber, this.startDate, this.numberOfInstallments, this.interestHandlingType);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "LoanReAgeParameterData.LoanReAgeParameterDataBuilder(frequencyType=" + this.frequencyType + ", frequencyNumber=" + this.frequencyNumber + ", startDate=" + this.startDate + ", numberOfInstallments=" + this.numberOfInstallments + ", interestHandlingType=" + this.interestHandlingType + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static LoanReAgeParameterData.LoanReAgeParameterDataBuilder builder() {
        return new LoanReAgeParameterData.LoanReAgeParameterDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public PeriodFrequencyType getFrequencyType() {
        return this.frequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getFrequencyNumber() {
        return this.frequencyNumber;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getStartDate() {
        return this.startDate;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getNumberOfInstallments() {
        return this.numberOfInstallments;
    }

    @java.lang.SuppressWarnings("all")
        public LoanReAgeInterestHandlingType getInterestHandlingType() {
        return this.interestHandlingType;
    }
}
