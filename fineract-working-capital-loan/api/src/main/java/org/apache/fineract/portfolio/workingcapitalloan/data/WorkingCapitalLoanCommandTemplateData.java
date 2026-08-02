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
import java.util.Collection;
import org.apache.fineract.infrastructure.codes.data.CodeValueData;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.portfolio.paymenttype.data.PaymentTypeData;

/**
 * Data Transfer Object for Working Capital Loan Transactions.
 */
public class WorkingCapitalLoanCommandTemplateData implements Serializable {
    private Long loanId;
    private LocalDate approvalDate;
    private BigDecimal approvalAmount;
    private BigDecimal discountAmount;
    private Boolean overrideDiscountDisabled;
    private LocalDate expectedDisbursementDate;
    private BigDecimal expectedAmount;
    private LocalDate expectedMaturityDate;
    private CurrencyData currency;
    private Collection<PaymentTypeData> paymentTypeOptions;
    private Collection<CodeValueData> classificationOptions;


    @java.lang.SuppressWarnings("all")
        public static class WorkingCapitalLoanCommandTemplateDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long loanId;
        @java.lang.SuppressWarnings("all")
                private LocalDate approvalDate;
        @java.lang.SuppressWarnings("all")
                private BigDecimal approvalAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal discountAmount;
        @java.lang.SuppressWarnings("all")
                private Boolean overrideDiscountDisabled;
        @java.lang.SuppressWarnings("all")
                private LocalDate expectedDisbursementDate;
        @java.lang.SuppressWarnings("all")
                private BigDecimal expectedAmount;
        @java.lang.SuppressWarnings("all")
                private LocalDate expectedMaturityDate;
        @java.lang.SuppressWarnings("all")
                private CurrencyData currency;
        @java.lang.SuppressWarnings("all")
                private Collection<PaymentTypeData> paymentTypeOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<CodeValueData> classificationOptions;

        @java.lang.SuppressWarnings("all")
                WorkingCapitalLoanCommandTemplateDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanCommandTemplateData.WorkingCapitalLoanCommandTemplateDataBuilder loanId(final Long loanId) {
            this.loanId = loanId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanCommandTemplateData.WorkingCapitalLoanCommandTemplateDataBuilder approvalDate(final LocalDate approvalDate) {
            this.approvalDate = approvalDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanCommandTemplateData.WorkingCapitalLoanCommandTemplateDataBuilder approvalAmount(final BigDecimal approvalAmount) {
            this.approvalAmount = approvalAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanCommandTemplateData.WorkingCapitalLoanCommandTemplateDataBuilder discountAmount(final BigDecimal discountAmount) {
            this.discountAmount = discountAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanCommandTemplateData.WorkingCapitalLoanCommandTemplateDataBuilder overrideDiscountDisabled(final Boolean overrideDiscountDisabled) {
            this.overrideDiscountDisabled = overrideDiscountDisabled;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanCommandTemplateData.WorkingCapitalLoanCommandTemplateDataBuilder expectedDisbursementDate(final LocalDate expectedDisbursementDate) {
            this.expectedDisbursementDate = expectedDisbursementDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanCommandTemplateData.WorkingCapitalLoanCommandTemplateDataBuilder expectedAmount(final BigDecimal expectedAmount) {
            this.expectedAmount = expectedAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanCommandTemplateData.WorkingCapitalLoanCommandTemplateDataBuilder expectedMaturityDate(final LocalDate expectedMaturityDate) {
            this.expectedMaturityDate = expectedMaturityDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanCommandTemplateData.WorkingCapitalLoanCommandTemplateDataBuilder currency(final CurrencyData currency) {
            this.currency = currency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanCommandTemplateData.WorkingCapitalLoanCommandTemplateDataBuilder paymentTypeOptions(final Collection<PaymentTypeData> paymentTypeOptions) {
            this.paymentTypeOptions = paymentTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanCommandTemplateData.WorkingCapitalLoanCommandTemplateDataBuilder classificationOptions(final Collection<CodeValueData> classificationOptions) {
            this.classificationOptions = classificationOptions;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanCommandTemplateData build() {
            return new WorkingCapitalLoanCommandTemplateData(this.loanId, this.approvalDate, this.approvalAmount, this.discountAmount, this.overrideDiscountDisabled, this.expectedDisbursementDate, this.expectedAmount, this.expectedMaturityDate, this.currency, this.paymentTypeOptions, this.classificationOptions);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "WorkingCapitalLoanCommandTemplateData.WorkingCapitalLoanCommandTemplateDataBuilder(loanId=" + this.loanId + ", approvalDate=" + this.approvalDate + ", approvalAmount=" + this.approvalAmount + ", discountAmount=" + this.discountAmount + ", overrideDiscountDisabled=" + this.overrideDiscountDisabled + ", expectedDisbursementDate=" + this.expectedDisbursementDate + ", expectedAmount=" + this.expectedAmount + ", expectedMaturityDate=" + this.expectedMaturityDate + ", currency=" + this.currency + ", paymentTypeOptions=" + this.paymentTypeOptions + ", classificationOptions=" + this.classificationOptions + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static WorkingCapitalLoanCommandTemplateData.WorkingCapitalLoanCommandTemplateDataBuilder builder() {
        return new WorkingCapitalLoanCommandTemplateData.WorkingCapitalLoanCommandTemplateDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getApprovalDate() {
        return this.approvalDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getApprovalAmount() {
        return this.approvalAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDiscountAmount() {
        return this.discountAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getOverrideDiscountDisabled() {
        return this.overrideDiscountDisabled;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getExpectedDisbursementDate() {
        return this.expectedDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getExpectedAmount() {
        return this.expectedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getExpectedMaturityDate() {
        return this.expectedMaturityDate;
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<PaymentTypeData> getPaymentTypeOptions() {
        return this.paymentTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getClassificationOptions() {
        return this.classificationOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanId(final Long loanId) {
        this.loanId = loanId;
    }

    @java.lang.SuppressWarnings("all")
        public void setApprovalDate(final LocalDate approvalDate) {
        this.approvalDate = approvalDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setApprovalAmount(final BigDecimal approvalAmount) {
        this.approvalAmount = approvalAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setDiscountAmount(final BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setOverrideDiscountDisabled(final Boolean overrideDiscountDisabled) {
        this.overrideDiscountDisabled = overrideDiscountDisabled;
    }

    @java.lang.SuppressWarnings("all")
        public void setExpectedDisbursementDate(final LocalDate expectedDisbursementDate) {
        this.expectedDisbursementDate = expectedDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setExpectedAmount(final BigDecimal expectedAmount) {
        this.expectedAmount = expectedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setExpectedMaturityDate(final LocalDate expectedMaturityDate) {
        this.expectedMaturityDate = expectedMaturityDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrency(final CurrencyData currency) {
        this.currency = currency;
    }

    @java.lang.SuppressWarnings("all")
        public void setPaymentTypeOptions(final Collection<PaymentTypeData> paymentTypeOptions) {
        this.paymentTypeOptions = paymentTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setClassificationOptions(final Collection<CodeValueData> classificationOptions) {
        this.classificationOptions = classificationOptions;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanCommandTemplateData() {
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanCommandTemplateData(final Long loanId, final LocalDate approvalDate, final BigDecimal approvalAmount, final BigDecimal discountAmount, final Boolean overrideDiscountDisabled, final LocalDate expectedDisbursementDate, final BigDecimal expectedAmount, final LocalDate expectedMaturityDate, final CurrencyData currency, final Collection<PaymentTypeData> paymentTypeOptions, final Collection<CodeValueData> classificationOptions) {
        this.loanId = loanId;
        this.approvalDate = approvalDate;
        this.approvalAmount = approvalAmount;
        this.discountAmount = discountAmount;
        this.overrideDiscountDisabled = overrideDiscountDisabled;
        this.expectedDisbursementDate = expectedDisbursementDate;
        this.expectedAmount = expectedAmount;
        this.expectedMaturityDate = expectedMaturityDate;
        this.currency = currency;
        this.paymentTypeOptions = paymentTypeOptions;
        this.classificationOptions = classificationOptions;
    }
}
