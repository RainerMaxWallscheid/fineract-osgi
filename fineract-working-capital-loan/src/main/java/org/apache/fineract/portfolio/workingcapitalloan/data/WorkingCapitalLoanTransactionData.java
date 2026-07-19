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
package org.apache.fineract.portfolio.workingcapitalloan.data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.codes.data.CodeValueData;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.portfolio.loanaccount.data.LoanTransactionEnumData;
import org.apache.fineract.portfolio.paymentdetail.data.PaymentDetailData;

public class WorkingCapitalLoanTransactionData implements Serializable {
    private Long id;
    private Long wcLoanId;
    private CurrencyData currency;
    private LoanTransactionEnumData type;
    private LocalDate transactionDate;
    private LocalDate submittedOnDate;
    private BigDecimal transactionAmount;
    private ExternalId externalId;
    private Boolean reversed;
    private ExternalId reversalExternalId;
    private LocalDate reversedOnDate;
    private CodeValueData classification;
    private PaymentDetailData paymentDetailData;
    // Portions from allocation (principal, fee, penalty).
    private BigDecimal principalPortion;
    private BigDecimal feeChargesPortion;
    private BigDecimal penaltyChargesPortion;


    @java.lang.SuppressWarnings("all")
        public static class WorkingCapitalLoanTransactionDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private Long wcLoanId;
        @java.lang.SuppressWarnings("all")
                private CurrencyData currency;
        @java.lang.SuppressWarnings("all")
                private LoanTransactionEnumData type;
        @java.lang.SuppressWarnings("all")
                private LocalDate transactionDate;
        @java.lang.SuppressWarnings("all")
                private LocalDate submittedOnDate;
        @java.lang.SuppressWarnings("all")
                private BigDecimal transactionAmount;
        @java.lang.SuppressWarnings("all")
                private ExternalId externalId;
        @java.lang.SuppressWarnings("all")
                private Boolean reversed;
        @java.lang.SuppressWarnings("all")
                private ExternalId reversalExternalId;
        @java.lang.SuppressWarnings("all")
                private LocalDate reversedOnDate;
        @java.lang.SuppressWarnings("all")
                private CodeValueData classification;
        @java.lang.SuppressWarnings("all")
                private PaymentDetailData paymentDetailData;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principalPortion;
        @java.lang.SuppressWarnings("all")
                private BigDecimal feeChargesPortion;
        @java.lang.SuppressWarnings("all")
                private BigDecimal penaltyChargesPortion;

        @java.lang.SuppressWarnings("all")
                WorkingCapitalLoanTransactionDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder wcLoanId(final Long wcLoanId) {
            this.wcLoanId = wcLoanId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder currency(final CurrencyData currency) {
            this.currency = currency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder type(final LoanTransactionEnumData type) {
            this.type = type;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder transactionDate(final LocalDate transactionDate) {
            this.transactionDate = transactionDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder submittedOnDate(final LocalDate submittedOnDate) {
            this.submittedOnDate = submittedOnDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder transactionAmount(final BigDecimal transactionAmount) {
            this.transactionAmount = transactionAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder externalId(final ExternalId externalId) {
            this.externalId = externalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder reversed(final Boolean reversed) {
            this.reversed = reversed;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder reversalExternalId(final ExternalId reversalExternalId) {
            this.reversalExternalId = reversalExternalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder reversedOnDate(final LocalDate reversedOnDate) {
            this.reversedOnDate = reversedOnDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder classification(final CodeValueData classification) {
            this.classification = classification;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder paymentDetailData(final PaymentDetailData paymentDetailData) {
            this.paymentDetailData = paymentDetailData;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder principalPortion(final BigDecimal principalPortion) {
            this.principalPortion = principalPortion;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder feeChargesPortion(final BigDecimal feeChargesPortion) {
            this.feeChargesPortion = feeChargesPortion;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder penaltyChargesPortion(final BigDecimal penaltyChargesPortion) {
            this.penaltyChargesPortion = penaltyChargesPortion;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTransactionData build() {
            return new WorkingCapitalLoanTransactionData(this.id, this.wcLoanId, this.currency, this.type, this.transactionDate, this.submittedOnDate, this.transactionAmount, this.externalId, this.reversed, this.reversalExternalId, this.reversedOnDate, this.classification, this.paymentDetailData, this.principalPortion, this.feeChargesPortion, this.penaltyChargesPortion);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder(id=" + this.id + ", wcLoanId=" + this.wcLoanId + ", currency=" + this.currency + ", type=" + this.type + ", transactionDate=" + this.transactionDate + ", submittedOnDate=" + this.submittedOnDate + ", transactionAmount=" + this.transactionAmount + ", externalId=" + this.externalId + ", reversed=" + this.reversed + ", reversalExternalId=" + this.reversalExternalId + ", reversedOnDate=" + this.reversedOnDate + ", classification=" + this.classification + ", paymentDetailData=" + this.paymentDetailData + ", principalPortion=" + this.principalPortion + ", feeChargesPortion=" + this.feeChargesPortion + ", penaltyChargesPortion=" + this.penaltyChargesPortion + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder builder() {
        return new WorkingCapitalLoanTransactionData.WorkingCapitalLoanTransactionDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getWcLoanId() {
        return this.wcLoanId;
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public LoanTransactionEnumData getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getTransactionDate() {
        return this.transactionDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSubmittedOnDate() {
        return this.submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTransactionAmount() {
        return this.transactionAmount;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getReversed() {
        return this.reversed;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getReversalExternalId() {
        return this.reversalExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getReversedOnDate() {
        return this.reversedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public CodeValueData getClassification() {
        return this.classification;
    }

    @java.lang.SuppressWarnings("all")
        public PaymentDetailData getPaymentDetailData() {
        return this.paymentDetailData;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalPortion() {
        return this.principalPortion;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeChargesPortion() {
        return this.feeChargesPortion;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyChargesPortion() {
        return this.penaltyChargesPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setWcLoanId(final Long wcLoanId) {
        this.wcLoanId = wcLoanId;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrency(final CurrencyData currency) {
        this.currency = currency;
    }

    @java.lang.SuppressWarnings("all")
        public void setType(final LoanTransactionEnumData type) {
        this.type = type;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransactionDate(final LocalDate transactionDate) {
        this.transactionDate = transactionDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setSubmittedOnDate(final LocalDate submittedOnDate) {
        this.submittedOnDate = submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransactionAmount(final BigDecimal transactionAmount) {
        this.transactionAmount = transactionAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalId(final ExternalId externalId) {
        this.externalId = externalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setReversed(final Boolean reversed) {
        this.reversed = reversed;
    }

    @java.lang.SuppressWarnings("all")
        public void setReversalExternalId(final ExternalId reversalExternalId) {
        this.reversalExternalId = reversalExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setReversedOnDate(final LocalDate reversedOnDate) {
        this.reversedOnDate = reversedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setClassification(final CodeValueData classification) {
        this.classification = classification;
    }

    @java.lang.SuppressWarnings("all")
        public void setPaymentDetailData(final PaymentDetailData paymentDetailData) {
        this.paymentDetailData = paymentDetailData;
    }

    @java.lang.SuppressWarnings("all")
        public void setPrincipalPortion(final BigDecimal principalPortion) {
        this.principalPortion = principalPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setFeeChargesPortion(final BigDecimal feeChargesPortion) {
        this.feeChargesPortion = feeChargesPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setPenaltyChargesPortion(final BigDecimal penaltyChargesPortion) {
        this.penaltyChargesPortion = penaltyChargesPortion;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanTransactionData() {
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanTransactionData(final Long id, final Long wcLoanId, final CurrencyData currency, final LoanTransactionEnumData type, final LocalDate transactionDate, final LocalDate submittedOnDate, final BigDecimal transactionAmount, final ExternalId externalId, final Boolean reversed, final ExternalId reversalExternalId, final LocalDate reversedOnDate, final CodeValueData classification, final PaymentDetailData paymentDetailData, final BigDecimal principalPortion, final BigDecimal feeChargesPortion, final BigDecimal penaltyChargesPortion) {
        this.id = id;
        this.wcLoanId = wcLoanId;
        this.currency = currency;
        this.type = type;
        this.transactionDate = transactionDate;
        this.submittedOnDate = submittedOnDate;
        this.transactionAmount = transactionAmount;
        this.externalId = externalId;
        this.reversed = reversed;
        this.reversalExternalId = reversalExternalId;
        this.reversedOnDate = reversedOnDate;
        this.classification = classification;
        this.paymentDetailData = paymentDetailData;
        this.principalPortion = principalPortion;
        this.feeChargesPortion = feeChargesPortion;
        this.penaltyChargesPortion = penaltyChargesPortion;
    }
}
