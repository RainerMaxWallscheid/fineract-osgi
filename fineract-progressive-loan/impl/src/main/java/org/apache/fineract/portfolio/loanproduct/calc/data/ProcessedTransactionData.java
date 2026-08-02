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
import java.util.Optional;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransactionType;

public final class ProcessedTransactionData {
    private final LoanTransactionType transactionType;
    private final LocalDate transactionDate;
    private final LoanReAgeParameterData reAgeParameter;

    public static ProcessedTransactionData of(LoanTransactionType transactionType, LocalDate transactionDate, LoanReAgeParameterData reAgeParameter) {
        return ProcessedTransactionData.builder().transactionType(transactionType).transactionDate(transactionDate).reAgeParameter(reAgeParameter).build();
    }

    public static ProcessedTransactionData of(LoanTransactionType transactionType, LocalDate transactionDate) {
        return of(transactionType, transactionDate, null);
    }

    public boolean isReAge() {
        return LoanTransactionType.REAGE.equals(transactionType);
    }

    public Optional<LoanReAgeParameterData> getReAgeParameterOptional() {
        return Optional.ofNullable(reAgeParameter);
    }

    @java.lang.SuppressWarnings("all")
        ProcessedTransactionData(final LoanTransactionType transactionType, final LocalDate transactionDate, final LoanReAgeParameterData reAgeParameter) {
        this.transactionType = transactionType;
        this.transactionDate = transactionDate;
        this.reAgeParameter = reAgeParameter;
    }


    @java.lang.SuppressWarnings("all")
        public static class ProcessedTransactionDataBuilder {
        @java.lang.SuppressWarnings("all")
                private LoanTransactionType transactionType;
        @java.lang.SuppressWarnings("all")
                private LocalDate transactionDate;
        @java.lang.SuppressWarnings("all")
                private LoanReAgeParameterData reAgeParameter;

        @java.lang.SuppressWarnings("all")
                ProcessedTransactionDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProcessedTransactionData.ProcessedTransactionDataBuilder transactionType(final LoanTransactionType transactionType) {
            this.transactionType = transactionType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProcessedTransactionData.ProcessedTransactionDataBuilder transactionDate(final LocalDate transactionDate) {
            this.transactionDate = transactionDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProcessedTransactionData.ProcessedTransactionDataBuilder reAgeParameter(final LoanReAgeParameterData reAgeParameter) {
            this.reAgeParameter = reAgeParameter;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ProcessedTransactionData build() {
            return new ProcessedTransactionData(this.transactionType, this.transactionDate, this.reAgeParameter);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ProcessedTransactionData.ProcessedTransactionDataBuilder(transactionType=" + this.transactionType + ", transactionDate=" + this.transactionDate + ", reAgeParameter=" + this.reAgeParameter + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ProcessedTransactionData.ProcessedTransactionDataBuilder builder() {
        return new ProcessedTransactionData.ProcessedTransactionDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public LoanTransactionType getTransactionType() {
        return this.transactionType;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getTransactionDate() {
        return this.transactionDate;
    }

    @java.lang.SuppressWarnings("all")
        public LoanReAgeParameterData getReAgeParameter() {
        return this.reAgeParameter;
    }
}
