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

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.infrastructure.core.service.MathUtil;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.portfolio.charge.data.ChargeData;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeCalculationType;
import org.apache.fineract.portfolio.charge.moduleapi.ChargePaymentMode;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeTimeType;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeEnumerations;

public final class WorkingCapitalLoanChargeData {
    private final Long id;
    private final Long chargeId;
    private final String name;
    private final EnumOptionData chargeTimeType;
    private final LocalDate submittedOnDate;
    private final LocalDate dueDate;
    private final EnumOptionData chargeCalculationType;
    private final CurrencyData currency;
    private final BigDecimal amount;
    private final BigDecimal amountPaid;
    private final BigDecimal amountOutstanding;
    private final List<ChargeData> chargeOptions;
    private final boolean penalty;
    private final EnumOptionData chargePaymentMode;
    private final boolean paid;
    private final Long loanId;
    private final ExternalId externalId;
    private final ExternalId externalLoanId;

    public WorkingCapitalLoanChargeData(Long id, Long chargeId, String name, ChargeTimeType chargeTimeType, LocalDate submittedOnDate, LocalDate dueDate, ChargeCalculationType chargeCalculationType, String cCode, String cName, Integer cDecimalPlaces, Integer cInMultiplesOf, String cDisplaySymbol, String cNameCode, BigDecimal amount, BigDecimal amountPaid, boolean penalty, ChargePaymentMode chargePaymentMode, boolean paid, Long loanId, ExternalId externalId, ExternalId externalLoanId) {
        this.id = id;
        this.chargeId = chargeId;
        this.name = name;
        this.chargeTimeType = ChargeEnumerations.chargeTimeType(chargeTimeType);
        this.submittedOnDate = submittedOnDate;
        this.dueDate = dueDate;
        this.chargeCalculationType = ChargeEnumerations.chargeCalculationType(chargeCalculationType);
        this.currency = new CurrencyData(cCode, cName, cDecimalPlaces, cInMultiplesOf, cDisplaySymbol, cNameCode);
        this.amount = amount;
        this.amountPaid = amountPaid;
        this.amountOutstanding = MathUtil.subtract(amount, amountPaid);
        this.chargeOptions = null;
        this.penalty = penalty;
        this.chargePaymentMode = ChargeEnumerations.chargePaymentMode(chargePaymentMode);
        this.paid = paid;
        this.loanId = loanId;
        this.externalId = externalId;
        this.externalLoanId = externalLoanId;
    }

    public static WorkingCapitalLoanChargeData template(final List<ChargeData> chargeOptions) {
        return WorkingCapitalLoanChargeData.builder().chargeOptions(chargeOptions).build();
    }


    @java.lang.SuppressWarnings("all")
        public static class WorkingCapitalLoanChargeDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private Long chargeId;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private EnumOptionData chargeTimeType;
        @java.lang.SuppressWarnings("all")
                private LocalDate submittedOnDate;
        @java.lang.SuppressWarnings("all")
                private LocalDate dueDate;
        @java.lang.SuppressWarnings("all")
                private EnumOptionData chargeCalculationType;
        @java.lang.SuppressWarnings("all")
                private CurrencyData currency;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amountPaid;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amountOutstanding;
        @java.lang.SuppressWarnings("all")
                private List<ChargeData> chargeOptions;
        @java.lang.SuppressWarnings("all")
                private boolean penalty;
        @java.lang.SuppressWarnings("all")
                private EnumOptionData chargePaymentMode;
        @java.lang.SuppressWarnings("all")
                private boolean paid;
        @java.lang.SuppressWarnings("all")
                private Long loanId;
        @java.lang.SuppressWarnings("all")
                private ExternalId externalId;
        @java.lang.SuppressWarnings("all")
                private ExternalId externalLoanId;

        @java.lang.SuppressWarnings("all")
                WorkingCapitalLoanChargeDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder chargeId(final Long chargeId) {
            this.chargeId = chargeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder chargeTimeType(final EnumOptionData chargeTimeType) {
            this.chargeTimeType = chargeTimeType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder submittedOnDate(final LocalDate submittedOnDate) {
            this.submittedOnDate = submittedOnDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder dueDate(final LocalDate dueDate) {
            this.dueDate = dueDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder chargeCalculationType(final EnumOptionData chargeCalculationType) {
            this.chargeCalculationType = chargeCalculationType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder currency(final CurrencyData currency) {
            this.currency = currency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder amount(final BigDecimal amount) {
            this.amount = amount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder amountPaid(final BigDecimal amountPaid) {
            this.amountPaid = amountPaid;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder amountOutstanding(final BigDecimal amountOutstanding) {
            this.amountOutstanding = amountOutstanding;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder chargeOptions(final List<ChargeData> chargeOptions) {
            this.chargeOptions = chargeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder penalty(final boolean penalty) {
            this.penalty = penalty;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder chargePaymentMode(final EnumOptionData chargePaymentMode) {
            this.chargePaymentMode = chargePaymentMode;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder paid(final boolean paid) {
            this.paid = paid;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder loanId(final Long loanId) {
            this.loanId = loanId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder externalId(final ExternalId externalId) {
            this.externalId = externalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder externalLoanId(final ExternalId externalLoanId) {
            this.externalLoanId = externalLoanId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanChargeData build() {
            return new WorkingCapitalLoanChargeData(this.id, this.chargeId, this.name, this.chargeTimeType, this.submittedOnDate, this.dueDate, this.chargeCalculationType, this.currency, this.amount, this.amountPaid, this.amountOutstanding, this.chargeOptions, this.penalty, this.chargePaymentMode, this.paid, this.loanId, this.externalId, this.externalLoanId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder(id=" + this.id + ", chargeId=" + this.chargeId + ", name=" + this.name + ", chargeTimeType=" + this.chargeTimeType + ", submittedOnDate=" + this.submittedOnDate + ", dueDate=" + this.dueDate + ", chargeCalculationType=" + this.chargeCalculationType + ", currency=" + this.currency + ", amount=" + this.amount + ", amountPaid=" + this.amountPaid + ", amountOutstanding=" + this.amountOutstanding + ", chargeOptions=" + this.chargeOptions + ", penalty=" + this.penalty + ", chargePaymentMode=" + this.chargePaymentMode + ", paid=" + this.paid + ", loanId=" + this.loanId + ", externalId=" + this.externalId + ", externalLoanId=" + this.externalLoanId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder builder() {
        return new WorkingCapitalLoanChargeData.WorkingCapitalLoanChargeDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getChargeId() {
        return this.chargeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getChargeTimeType() {
        return this.chargeTimeType;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSubmittedOnDate() {
        return this.submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDueDate() {
        return this.dueDate;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getChargeCalculationType() {
        return this.chargeCalculationType;
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountPaid() {
        return this.amountPaid;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountOutstanding() {
        return this.amountOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public List<ChargeData> getChargeOptions() {
        return this.chargeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isPenalty() {
        return this.penalty;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getChargePaymentMode() {
        return this.chargePaymentMode;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isPaid() {
        return this.paid;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getExternalLoanId() {
        return this.externalLoanId;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanChargeData(final Long id, final Long chargeId, final String name, final EnumOptionData chargeTimeType, final LocalDate submittedOnDate, final LocalDate dueDate, final EnumOptionData chargeCalculationType, final CurrencyData currency, final BigDecimal amount, final BigDecimal amountPaid, final BigDecimal amountOutstanding, final List<ChargeData> chargeOptions, final boolean penalty, final EnumOptionData chargePaymentMode, final boolean paid, final Long loanId, final ExternalId externalId, final ExternalId externalLoanId) {
        this.id = id;
        this.chargeId = chargeId;
        this.name = name;
        this.chargeTimeType = chargeTimeType;
        this.submittedOnDate = submittedOnDate;
        this.dueDate = dueDate;
        this.chargeCalculationType = chargeCalculationType;
        this.currency = currency;
        this.amount = amount;
        this.amountPaid = amountPaid;
        this.amountOutstanding = amountOutstanding;
        this.chargeOptions = chargeOptions;
        this.penalty = penalty;
        this.chargePaymentMode = chargePaymentMode;
        this.paid = paid;
        this.loanId = loanId;
        this.externalId = externalId;
        this.externalLoanId = externalLoanId;
    }
}
