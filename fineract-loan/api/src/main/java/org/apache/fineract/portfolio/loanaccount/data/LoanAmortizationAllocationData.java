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
import java.util.List;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.portfolio.loanaccount.domain.AmortizationType;

/**
 * Data transfer object for loan amortization allocation information
 */
public class LoanAmortizationAllocationData {
    private Long loanId;
    private ExternalId loanExternalId;
    private Long baseLoanTransactionId;
    private LocalDate baseLoanTransactionDate;
    private BigDecimal baseLoanTransactionAmount;
    private BigDecimal unrecognizedAmount;
    private BigDecimal chargedOffAmount;
    private BigDecimal adjustmentAmount;
    private List<AmortizationMappingData> amortizationMappings;


    /**
     * Data transfer object for amortization mapping details
     */
    public static class AmortizationMappingData {
        private Long amortizationLoanTransactionId;
        private ExternalId amortizationLoanTransactionExternalId;
        private LocalDate date;
        private AmortizationType type; // AM or AM_ADJ
        private BigDecimal amount;


        @java.lang.SuppressWarnings("all")
                public static class AmortizationMappingDataBuilder {
            @java.lang.SuppressWarnings("all")
                        private Long amortizationLoanTransactionId;
            @java.lang.SuppressWarnings("all")
                        private ExternalId amortizationLoanTransactionExternalId;
            @java.lang.SuppressWarnings("all")
                        private LocalDate date;
            @java.lang.SuppressWarnings("all")
                        private AmortizationType type;
            @java.lang.SuppressWarnings("all")
                        private BigDecimal amount;

            @java.lang.SuppressWarnings("all")
                        AmortizationMappingDataBuilder() {
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public LoanAmortizationAllocationData.AmortizationMappingData.AmortizationMappingDataBuilder amortizationLoanTransactionId(final Long amortizationLoanTransactionId) {
                this.amortizationLoanTransactionId = amortizationLoanTransactionId;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public LoanAmortizationAllocationData.AmortizationMappingData.AmortizationMappingDataBuilder amortizationLoanTransactionExternalId(final ExternalId amortizationLoanTransactionExternalId) {
                this.amortizationLoanTransactionExternalId = amortizationLoanTransactionExternalId;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public LoanAmortizationAllocationData.AmortizationMappingData.AmortizationMappingDataBuilder date(final LocalDate date) {
                this.date = date;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public LoanAmortizationAllocationData.AmortizationMappingData.AmortizationMappingDataBuilder type(final AmortizationType type) {
                this.type = type;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public LoanAmortizationAllocationData.AmortizationMappingData.AmortizationMappingDataBuilder amount(final BigDecimal amount) {
                this.amount = amount;
                return this;
            }

            @java.lang.SuppressWarnings("all")
                        public LoanAmortizationAllocationData.AmortizationMappingData build() {
                return new LoanAmortizationAllocationData.AmortizationMappingData(this.amortizationLoanTransactionId, this.amortizationLoanTransactionExternalId, this.date, this.type, this.amount);
            }

            @java.lang.Override
            @java.lang.SuppressWarnings("all")
                        public java.lang.String toString() {
                return "LoanAmortizationAllocationData.AmortizationMappingData.AmortizationMappingDataBuilder(amortizationLoanTransactionId=" + this.amortizationLoanTransactionId + ", amortizationLoanTransactionExternalId=" + this.amortizationLoanTransactionExternalId + ", date=" + this.date + ", type=" + this.type + ", amount=" + this.amount + ")";
            }
        }

        @java.lang.SuppressWarnings("all")
                public static LoanAmortizationAllocationData.AmortizationMappingData.AmortizationMappingDataBuilder builder() {
            return new LoanAmortizationAllocationData.AmortizationMappingData.AmortizationMappingDataBuilder();
        }

        @java.lang.SuppressWarnings("all")
                public Long getAmortizationLoanTransactionId() {
            return this.amortizationLoanTransactionId;
        }

        @java.lang.SuppressWarnings("all")
                public ExternalId getAmortizationLoanTransactionExternalId() {
            return this.amortizationLoanTransactionExternalId;
        }

        @java.lang.SuppressWarnings("all")
                public LocalDate getDate() {
            return this.date;
        }

        @java.lang.SuppressWarnings("all")
                public AmortizationType getType() {
            return this.type;
        }

        @java.lang.SuppressWarnings("all")
                public BigDecimal getAmount() {
            return this.amount;
        }

        @java.lang.SuppressWarnings("all")
                public AmortizationMappingData(final Long amortizationLoanTransactionId, final ExternalId amortizationLoanTransactionExternalId, final LocalDate date, final AmortizationType type, final BigDecimal amount) {
            this.amortizationLoanTransactionId = amortizationLoanTransactionId;
            this.amortizationLoanTransactionExternalId = amortizationLoanTransactionExternalId;
            this.date = date;
            this.type = type;
            this.amount = amount;
        }
    }


    @java.lang.SuppressWarnings("all")
        public static class LoanAmortizationAllocationDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long loanId;
        @java.lang.SuppressWarnings("all")
                private ExternalId loanExternalId;
        @java.lang.SuppressWarnings("all")
                private Long baseLoanTransactionId;
        @java.lang.SuppressWarnings("all")
                private LocalDate baseLoanTransactionDate;
        @java.lang.SuppressWarnings("all")
                private BigDecimal baseLoanTransactionAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal unrecognizedAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal chargedOffAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal adjustmentAmount;
        @java.lang.SuppressWarnings("all")
                private List<AmortizationMappingData> amortizationMappings;

        @java.lang.SuppressWarnings("all")
                LoanAmortizationAllocationDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanAmortizationAllocationData.LoanAmortizationAllocationDataBuilder loanId(final Long loanId) {
            this.loanId = loanId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanAmortizationAllocationData.LoanAmortizationAllocationDataBuilder loanExternalId(final ExternalId loanExternalId) {
            this.loanExternalId = loanExternalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanAmortizationAllocationData.LoanAmortizationAllocationDataBuilder baseLoanTransactionId(final Long baseLoanTransactionId) {
            this.baseLoanTransactionId = baseLoanTransactionId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanAmortizationAllocationData.LoanAmortizationAllocationDataBuilder baseLoanTransactionDate(final LocalDate baseLoanTransactionDate) {
            this.baseLoanTransactionDate = baseLoanTransactionDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanAmortizationAllocationData.LoanAmortizationAllocationDataBuilder baseLoanTransactionAmount(final BigDecimal baseLoanTransactionAmount) {
            this.baseLoanTransactionAmount = baseLoanTransactionAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanAmortizationAllocationData.LoanAmortizationAllocationDataBuilder unrecognizedAmount(final BigDecimal unrecognizedAmount) {
            this.unrecognizedAmount = unrecognizedAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanAmortizationAllocationData.LoanAmortizationAllocationDataBuilder chargedOffAmount(final BigDecimal chargedOffAmount) {
            this.chargedOffAmount = chargedOffAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanAmortizationAllocationData.LoanAmortizationAllocationDataBuilder adjustmentAmount(final BigDecimal adjustmentAmount) {
            this.adjustmentAmount = adjustmentAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanAmortizationAllocationData.LoanAmortizationAllocationDataBuilder amortizationMappings(final List<AmortizationMappingData> amortizationMappings) {
            this.amortizationMappings = amortizationMappings;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public LoanAmortizationAllocationData build() {
            return new LoanAmortizationAllocationData(this.loanId, this.loanExternalId, this.baseLoanTransactionId, this.baseLoanTransactionDate, this.baseLoanTransactionAmount, this.unrecognizedAmount, this.chargedOffAmount, this.adjustmentAmount, this.amortizationMappings);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "LoanAmortizationAllocationData.LoanAmortizationAllocationDataBuilder(loanId=" + this.loanId + ", loanExternalId=" + this.loanExternalId + ", baseLoanTransactionId=" + this.baseLoanTransactionId + ", baseLoanTransactionDate=" + this.baseLoanTransactionDate + ", baseLoanTransactionAmount=" + this.baseLoanTransactionAmount + ", unrecognizedAmount=" + this.unrecognizedAmount + ", chargedOffAmount=" + this.chargedOffAmount + ", adjustmentAmount=" + this.adjustmentAmount + ", amortizationMappings=" + this.amortizationMappings + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static LoanAmortizationAllocationData.LoanAmortizationAllocationDataBuilder builder() {
        return new LoanAmortizationAllocationData.LoanAmortizationAllocationDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getLoanExternalId() {
        return this.loanExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getBaseLoanTransactionId() {
        return this.baseLoanTransactionId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getBaseLoanTransactionDate() {
        return this.baseLoanTransactionDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getBaseLoanTransactionAmount() {
        return this.baseLoanTransactionAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getUnrecognizedAmount() {
        return this.unrecognizedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getChargedOffAmount() {
        return this.chargedOffAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAdjustmentAmount() {
        return this.adjustmentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public List<AmortizationMappingData> getAmortizationMappings() {
        return this.amortizationMappings;
    }

    @java.lang.SuppressWarnings("all")
        public LoanAmortizationAllocationData(final Long loanId, final ExternalId loanExternalId, final Long baseLoanTransactionId, final LocalDate baseLoanTransactionDate, final BigDecimal baseLoanTransactionAmount, final BigDecimal unrecognizedAmount, final BigDecimal chargedOffAmount, final BigDecimal adjustmentAmount, final List<AmortizationMappingData> amortizationMappings) {
        this.loanId = loanId;
        this.loanExternalId = loanExternalId;
        this.baseLoanTransactionId = baseLoanTransactionId;
        this.baseLoanTransactionDate = baseLoanTransactionDate;
        this.baseLoanTransactionAmount = baseLoanTransactionAmount;
        this.unrecognizedAmount = unrecognizedAmount;
        this.chargedOffAmount = chargedOffAmount;
        this.adjustmentAmount = adjustmentAmount;
        this.amortizationMappings = amortizationMappings;
    }
}
