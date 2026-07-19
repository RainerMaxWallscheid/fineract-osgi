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
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.portfolio.charge.data.ChargeData;
import org.apache.fineract.portfolio.charge.domain.ChargePaymentMode;
import org.apache.fineract.portfolio.charge.domain.ChargeTimeType;

/**
 * Immutable data object for loan charge data.
 */
public class LoanChargeData {
    private final Long id;
    private final Long chargeId;
    private final String name;
    private final EnumOptionData chargeTimeType;
    private final LocalDate submittedOnDate;
    private final LocalDate dueDate;
    private final EnumOptionData chargeCalculationType;
    private final BigDecimal percentage;
    private final BigDecimal amountPercentageAppliedTo;
    private final CurrencyData currency;
    private final BigDecimal amount;
    private final BigDecimal amountPaid;
    private final BigDecimal amountWaived;
    private final BigDecimal amountWrittenOff;
    private final BigDecimal amountOutstanding;
    private final BigDecimal amountOrPercentage;
    private final List<ChargeData> chargeOptions;
    private final boolean penalty;
    private final EnumOptionData chargePaymentMode;
    private final boolean paid;
    private final boolean waived;
    private final boolean chargePayable;
    private final Long loanId;
    private final BigDecimal minCap;
    private final BigDecimal maxCap;
    private final List<LoanInstallmentChargeData> installmentChargeData;
    private BigDecimal amountAccrued;
    private BigDecimal amountUnrecognized;
    private final ExternalId externalId;
    private final ExternalId externalLoanId;

    public static LoanChargeData template(final List<ChargeData> chargeOptions) {
        return new LoanChargeData(null, null, null, null, null, null, null, null, chargeOptions, false, null, false, false, null, ExternalId.empty(), null, null, null, null, ExternalId.empty());
    }

    /**
     * used when populating with details from charge definition (for crud on charges)
     */
    public static LoanChargeData newLoanChargeDetails(final Long chargeId, final String name, final CurrencyData currency, final BigDecimal amount, final BigDecimal percentage, final EnumOptionData chargeTimeType, final EnumOptionData chargeCalculationType, final boolean penalty, final EnumOptionData chargePaymentMode, final BigDecimal minCap, final BigDecimal maxCap, final ExternalId externalId) {
        return new LoanChargeData(null, chargeId, name, currency, amount, percentage, chargeTimeType, chargeCalculationType, null, penalty, chargePaymentMode, false, false, null, ExternalId.empty(), minCap, maxCap, null, null, externalId);
    }

    public LoanChargeData(final Long id, final Long chargeId, final String name, final CurrencyData currency, final BigDecimal amount, final BigDecimal amountPaid, final BigDecimal amountWaived, final BigDecimal amountWrittenOff, final BigDecimal amountOutstanding, final EnumOptionData chargeTimeType, final LocalDate submittedOnDate, final LocalDate dueDate, final EnumOptionData chargeCalculationType, final BigDecimal percentage, final BigDecimal amountPercentageAppliedTo, final boolean penalty, final EnumOptionData chargePaymentMode, final boolean paid, final boolean waived, final Long loanId, final ExternalId externalLoanId, final BigDecimal minCap, final BigDecimal maxCap, final BigDecimal amountOrPercentage, List<LoanInstallmentChargeData> installmentChargeData, final ExternalId externalId) {
        this.id = id;
        this.chargeId = chargeId;
        this.name = name;
        this.currency = currency;
        this.amount = amount;
        this.amountPaid = amountPaid;
        this.amountWaived = amountWaived;
        this.amountWrittenOff = amountWrittenOff;
        this.amountOutstanding = amountOutstanding;
        this.chargeTimeType = chargeTimeType;
        this.submittedOnDate = submittedOnDate;
        this.dueDate = dueDate;
        this.chargeCalculationType = chargeCalculationType;
        this.percentage = percentage;
        this.amountPercentageAppliedTo = amountPercentageAppliedTo;
        this.penalty = penalty;
        this.chargePaymentMode = chargePaymentMode;
        this.paid = paid;
        this.waived = waived;
        this.minCap = minCap;
        this.maxCap = maxCap;
        if (amountOrPercentage == null) {
            if (chargeCalculationType != null && chargeCalculationType.getId().intValue() > 1) {
                this.amountOrPercentage = this.percentage;
            } else {
                this.amountOrPercentage = amount;
            }
        } else {
            this.amountOrPercentage = amountOrPercentage;
        }
        this.chargeOptions = null;
        this.chargePayable = isChargePayable();
        this.loanId = loanId;
        this.installmentChargeData = installmentChargeData;
        this.amountAccrued = null;
        this.amountUnrecognized = null;
        this.externalId = externalId;
        this.externalLoanId = externalLoanId;
    }

    private LoanChargeData(final Long id, final Long chargeId, final String name, final CurrencyData currency, final BigDecimal amount, final BigDecimal percentage, final EnumOptionData chargeTimeType, final EnumOptionData chargeCalculationType, final List<ChargeData> chargeOptions, final boolean penalty, final EnumOptionData chargePaymentMode, final boolean paid, final boolean waived, final Long loanId, final ExternalId externalLoanId, final BigDecimal minCap, final BigDecimal maxCap, final BigDecimal amountOrPercentage, List<LoanInstallmentChargeData> installmentChargeData, final ExternalId externalId) {
        this.id = id;
        this.chargeId = chargeId;
        this.name = name;
        this.currency = currency;
        this.amount = amount;
        this.amountPaid = BigDecimal.ZERO;
        this.amountWaived = BigDecimal.ZERO;
        this.amountWrittenOff = BigDecimal.ZERO;
        this.amountOutstanding = amount;
        this.chargeTimeType = chargeTimeType;
        this.submittedOnDate = null;
        this.dueDate = null;
        this.chargeCalculationType = chargeCalculationType;
        this.percentage = percentage;
        this.amountPercentageAppliedTo = null;
        this.penalty = penalty;
        this.chargePaymentMode = chargePaymentMode;
        this.paid = paid;
        this.waived = waived;
        if (amountOrPercentage == null) {
            if (chargeCalculationType != null && chargeCalculationType.getId().intValue() > 1) {
                this.amountOrPercentage = this.percentage;
            } else {
                this.amountOrPercentage = amount;
            }
        } else {
            this.amountOrPercentage = amountOrPercentage;
        }
        this.chargeOptions = chargeOptions;
        this.chargePayable = isChargePayable();
        this.loanId = loanId;
        this.externalLoanId = externalLoanId;
        this.minCap = minCap;
        this.maxCap = maxCap;
        this.installmentChargeData = installmentChargeData;
        this.amountAccrued = null;
        this.amountUnrecognized = null;
        this.externalId = externalId;
    }

    public LoanChargeData(final Long id, final LocalDate dueAsOfDate, final LocalDate submittedOnDate, final BigDecimal amountOutstanding, EnumOptionData chargeTimeType, final Long loanId, final ExternalId externalLoanId, List<LoanInstallmentChargeData> installmentChargeData, final ExternalId externalId) {
        this.id = id;
        this.chargeId = null;
        this.name = null;
        this.currency = null;
        this.amount = null;
        this.amountPaid = null;
        this.amountWaived = null;
        this.amountWrittenOff = null;
        this.amountOutstanding = amountOutstanding;
        this.chargeTimeType = chargeTimeType;
        this.submittedOnDate = submittedOnDate;
        this.dueDate = dueAsOfDate;
        this.chargeCalculationType = null;
        this.percentage = null;
        this.amountPercentageAppliedTo = null;
        this.penalty = false;
        this.chargePaymentMode = null;
        this.paid = false;
        this.waived = false;
        this.amountOrPercentage = null;
        this.chargeOptions = null;
        this.chargePayable = false;
        this.loanId = loanId;
        this.minCap = null;
        this.maxCap = null;
        this.installmentChargeData = installmentChargeData;
        this.amountAccrued = null;
        this.amountUnrecognized = null;
        this.externalId = externalId;
        this.externalLoanId = externalLoanId;
    }

    public LoanChargeData(final Long id, final Long chargeId, final LocalDate dueAsOfDate, final LocalDate submittedOnDate, EnumOptionData chargeTimeType, final BigDecimal amount, final BigDecimal amountAccrued, final BigDecimal amountWaived, final boolean penalty, final ExternalId externalId) {
        this.id = id;
        this.chargeId = chargeId;
        this.name = null;
        this.currency = null;
        this.amount = amount;
        this.amountPaid = null;
        this.amountWaived = amountWaived;
        this.amountWrittenOff = null;
        this.amountOutstanding = null;
        this.chargeTimeType = chargeTimeType;
        this.submittedOnDate = submittedOnDate;
        this.dueDate = dueAsOfDate;
        this.chargeCalculationType = null;
        this.percentage = null;
        this.amountPercentageAppliedTo = null;
        this.penalty = penalty;
        this.chargePaymentMode = null;
        this.paid = false;
        this.waived = false;
        this.amountOrPercentage = null;
        this.chargeOptions = null;
        this.chargePayable = false;
        this.loanId = null;
        this.externalLoanId = ExternalId.empty();
        this.minCap = null;
        this.maxCap = null;
        this.installmentChargeData = null;
        this.amountAccrued = amountAccrued;
        this.amountUnrecognized = null;
        this.externalId = externalId;
    }

    public LoanChargeData(final BigDecimal amountUnrecognized, final LoanChargeData chargeData) {
        this.id = chargeData.id;
        this.chargeId = chargeData.chargeId;
        this.name = null;
        this.currency = null;
        this.amount = chargeData.amount;
        this.amountPaid = null;
        this.amountWaived = chargeData.amountWaived;
        this.amountWrittenOff = null;
        this.amountOutstanding = null;
        this.chargeTimeType = chargeData.chargeTimeType;
        this.submittedOnDate = chargeData.submittedOnDate;
        this.dueDate = chargeData.dueDate;
        this.chargeCalculationType = null;
        this.percentage = null;
        this.amountPercentageAppliedTo = null;
        this.penalty = chargeData.penalty;
        this.chargePaymentMode = null;
        this.paid = false;
        this.waived = false;
        this.amountOrPercentage = null;
        this.chargeOptions = null;
        this.chargePayable = false;
        this.loanId = null;
        this.externalLoanId = ExternalId.empty();
        this.minCap = null;
        this.maxCap = null;
        this.installmentChargeData = null;
        this.amountAccrued = chargeData.amountAccrued;
        this.amountUnrecognized = amountUnrecognized;
        this.externalId = chargeData.externalId;
    }

    public LoanChargeData(LoanChargeData chargeData, List<LoanInstallmentChargeData> installmentChargeData) {
        this.id = chargeData.id;
        this.chargeId = chargeData.chargeId;
        this.name = chargeData.name;
        this.currency = chargeData.currency;
        this.amount = chargeData.amount;
        this.amountPaid = chargeData.amountPaid;
        this.amountWaived = chargeData.amountWaived;
        this.amountWrittenOff = chargeData.amountWrittenOff;
        this.amountOutstanding = chargeData.amountOutstanding;
        this.chargeTimeType = chargeData.chargeTimeType;
        this.submittedOnDate = chargeData.submittedOnDate;
        this.dueDate = chargeData.dueDate;
        this.chargeCalculationType = chargeData.chargeCalculationType;
        this.percentage = chargeData.percentage;
        this.amountPercentageAppliedTo = chargeData.amountPercentageAppliedTo;
        this.penalty = chargeData.penalty;
        this.chargePaymentMode = chargeData.chargePaymentMode;
        this.paid = chargeData.paid;
        this.waived = chargeData.waived;
        this.minCap = chargeData.minCap;
        this.maxCap = chargeData.maxCap;
        this.amountOrPercentage = chargeData.amountOrPercentage;
        this.chargeOptions = chargeData.chargeOptions;
        this.chargePayable = chargeData.chargePayable;
        this.loanId = chargeData.loanId;
        this.externalLoanId = chargeData.externalLoanId;
        this.installmentChargeData = installmentChargeData;
        this.amountAccrued = chargeData.amountAccrued;
        this.amountUnrecognized = chargeData.amountUnrecognized;
        this.externalId = chargeData.externalId;
    }

    public LoanChargeData(final Long id, final LocalDate dueAsOfDate, final BigDecimal amount, final EnumOptionData chargeCalculationType, final EnumOptionData chargeTimeType) {
        this.id = null;
        this.chargeId = id;
        this.name = null;
        this.currency = null;
        this.amount = amount;
        this.amountPaid = null;
        this.amountWaived = null;
        this.amountWrittenOff = null;
        this.amountOutstanding = null;
        this.chargeTimeType = chargeTimeType;
        this.submittedOnDate = null;
        this.dueDate = dueAsOfDate;
        this.chargeCalculationType = chargeCalculationType;
        this.percentage = null;
        this.amountPercentageAppliedTo = null;
        this.penalty = false;
        this.chargePaymentMode = null;
        this.paid = false;
        this.waived = false;
        this.amountOrPercentage = null;
        this.chargeOptions = null;
        this.chargePayable = false;
        this.loanId = null;
        this.externalLoanId = ExternalId.empty();
        this.minCap = null;
        this.maxCap = null;
        this.installmentChargeData = null;
        this.amountAccrued = null;
        this.amountUnrecognized = null;
        this.externalId = ExternalId.empty();
    }

    public LoanChargeData(final Long id, final LocalDate dueAsOfDate, final BigDecimal amountOrPercentage) {
        this.id = id;
        this.chargeId = null;
        this.name = null;
        this.currency = null;
        this.amount = null;
        this.amountPaid = null;
        this.amountWaived = null;
        this.amountWrittenOff = null;
        this.amountOutstanding = null;
        this.chargeTimeType = null;
        this.submittedOnDate = null;
        this.dueDate = dueAsOfDate;
        this.chargeCalculationType = null;
        this.percentage = null;
        this.amountPercentageAppliedTo = null;
        this.penalty = false;
        this.chargePaymentMode = null;
        this.paid = false;
        this.waived = false;
        this.amountOrPercentage = amountOrPercentage;
        this.chargeOptions = null;
        this.chargePayable = false;
        this.loanId = null;
        this.externalLoanId = ExternalId.empty();
        this.minCap = null;
        this.maxCap = null;
        this.installmentChargeData = null;
        this.amountAccrued = null;
        this.amountUnrecognized = null;
        this.externalId = ExternalId.empty();
    }

    public boolean isChargePayable() {
        boolean isAccountTransfer = false;
        if (this.chargePaymentMode != null) {
            isAccountTransfer = ChargePaymentMode.fromInt(this.chargePaymentMode.getId().intValue()).isPaymentModeAccountTransfer();
        }
        return isAccountTransfer && !this.paid && !this.waived;
    }

    public boolean isInstallmentFee() {
        boolean isInstalmentFee = false;
        if (this.chargeTimeType != null) {
            isInstalmentFee = ChargeTimeType.fromInt(this.chargeTimeType.getId().intValue()).isInstalmentFee();
        }
        return isInstalmentFee;
    }

    public void updateAmountAccrued(BigDecimal amountAccrued) {
        this.amountAccrued = amountAccrued;
    }


    @java.lang.SuppressWarnings("all")
        public static class LoanChargeDataBuilder {
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
                private BigDecimal percentage;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amountPercentageAppliedTo;
        @java.lang.SuppressWarnings("all")
                private CurrencyData currency;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amountPaid;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amountWaived;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amountWrittenOff;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amountOutstanding;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amountOrPercentage;
        @java.lang.SuppressWarnings("all")
                private List<ChargeData> chargeOptions;
        @java.lang.SuppressWarnings("all")
                private boolean penalty;
        @java.lang.SuppressWarnings("all")
                private EnumOptionData chargePaymentMode;
        @java.lang.SuppressWarnings("all")
                private boolean paid;
        @java.lang.SuppressWarnings("all")
                private boolean waived;
        @java.lang.SuppressWarnings("all")
                private boolean chargePayable;
        @java.lang.SuppressWarnings("all")
                private Long loanId;
        @java.lang.SuppressWarnings("all")
                private BigDecimal minCap;
        @java.lang.SuppressWarnings("all")
                private BigDecimal maxCap;
        @java.lang.SuppressWarnings("all")
                private List<LoanInstallmentChargeData> installmentChargeData;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amountAccrued;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amountUnrecognized;
        @java.lang.SuppressWarnings("all")
                private ExternalId externalId;
        @java.lang.SuppressWarnings("all")
                private ExternalId externalLoanId;

        @java.lang.SuppressWarnings("all")
                LoanChargeDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder chargeId(final Long chargeId) {
            this.chargeId = chargeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder chargeTimeType(final EnumOptionData chargeTimeType) {
            this.chargeTimeType = chargeTimeType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder submittedOnDate(final LocalDate submittedOnDate) {
            this.submittedOnDate = submittedOnDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder dueDate(final LocalDate dueDate) {
            this.dueDate = dueDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder chargeCalculationType(final EnumOptionData chargeCalculationType) {
            this.chargeCalculationType = chargeCalculationType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder percentage(final BigDecimal percentage) {
            this.percentage = percentage;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder amountPercentageAppliedTo(final BigDecimal amountPercentageAppliedTo) {
            this.amountPercentageAppliedTo = amountPercentageAppliedTo;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder currency(final CurrencyData currency) {
            this.currency = currency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder amount(final BigDecimal amount) {
            this.amount = amount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder amountPaid(final BigDecimal amountPaid) {
            this.amountPaid = amountPaid;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder amountWaived(final BigDecimal amountWaived) {
            this.amountWaived = amountWaived;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder amountWrittenOff(final BigDecimal amountWrittenOff) {
            this.amountWrittenOff = amountWrittenOff;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder amountOutstanding(final BigDecimal amountOutstanding) {
            this.amountOutstanding = amountOutstanding;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder amountOrPercentage(final BigDecimal amountOrPercentage) {
            this.amountOrPercentage = amountOrPercentage;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder chargeOptions(final List<ChargeData> chargeOptions) {
            this.chargeOptions = chargeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder penalty(final boolean penalty) {
            this.penalty = penalty;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder chargePaymentMode(final EnumOptionData chargePaymentMode) {
            this.chargePaymentMode = chargePaymentMode;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder paid(final boolean paid) {
            this.paid = paid;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder waived(final boolean waived) {
            this.waived = waived;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder chargePayable(final boolean chargePayable) {
            this.chargePayable = chargePayable;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder loanId(final Long loanId) {
            this.loanId = loanId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder minCap(final BigDecimal minCap) {
            this.minCap = minCap;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder maxCap(final BigDecimal maxCap) {
            this.maxCap = maxCap;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder installmentChargeData(final List<LoanInstallmentChargeData> installmentChargeData) {
            this.installmentChargeData = installmentChargeData;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder amountAccrued(final BigDecimal amountAccrued) {
            this.amountAccrued = amountAccrued;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder amountUnrecognized(final BigDecimal amountUnrecognized) {
            this.amountUnrecognized = amountUnrecognized;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder externalId(final ExternalId externalId) {
            this.externalId = externalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanChargeData.LoanChargeDataBuilder externalLoanId(final ExternalId externalLoanId) {
            this.externalLoanId = externalLoanId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public LoanChargeData build() {
            return new LoanChargeData(this.id, this.chargeId, this.name, this.chargeTimeType, this.submittedOnDate, this.dueDate, this.chargeCalculationType, this.percentage, this.amountPercentageAppliedTo, this.currency, this.amount, this.amountPaid, this.amountWaived, this.amountWrittenOff, this.amountOutstanding, this.amountOrPercentage, this.chargeOptions, this.penalty, this.chargePaymentMode, this.paid, this.waived, this.chargePayable, this.loanId, this.minCap, this.maxCap, this.installmentChargeData, this.amountAccrued, this.amountUnrecognized, this.externalId, this.externalLoanId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "LoanChargeData.LoanChargeDataBuilder(id=" + this.id + ", chargeId=" + this.chargeId + ", name=" + this.name + ", chargeTimeType=" + this.chargeTimeType + ", submittedOnDate=" + this.submittedOnDate + ", dueDate=" + this.dueDate + ", chargeCalculationType=" + this.chargeCalculationType + ", percentage=" + this.percentage + ", amountPercentageAppliedTo=" + this.amountPercentageAppliedTo + ", currency=" + this.currency + ", amount=" + this.amount + ", amountPaid=" + this.amountPaid + ", amountWaived=" + this.amountWaived + ", amountWrittenOff=" + this.amountWrittenOff + ", amountOutstanding=" + this.amountOutstanding + ", amountOrPercentage=" + this.amountOrPercentage + ", chargeOptions=" + this.chargeOptions + ", penalty=" + this.penalty + ", chargePaymentMode=" + this.chargePaymentMode + ", paid=" + this.paid + ", waived=" + this.waived + ", chargePayable=" + this.chargePayable + ", loanId=" + this.loanId + ", minCap=" + this.minCap + ", maxCap=" + this.maxCap + ", installmentChargeData=" + this.installmentChargeData + ", amountAccrued=" + this.amountAccrued + ", amountUnrecognized=" + this.amountUnrecognized + ", externalId=" + this.externalId + ", externalLoanId=" + this.externalLoanId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static LoanChargeData.LoanChargeDataBuilder builder() {
        return new LoanChargeData.LoanChargeDataBuilder();
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
        public BigDecimal getPercentage() {
        return this.percentage;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountPercentageAppliedTo() {
        return this.amountPercentageAppliedTo;
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
        public BigDecimal getAmountWaived() {
        return this.amountWaived;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountWrittenOff() {
        return this.amountWrittenOff;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountOutstanding() {
        return this.amountOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountOrPercentage() {
        return this.amountOrPercentage;
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
        public boolean isWaived() {
        return this.waived;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMinCap() {
        return this.minCap;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMaxCap() {
        return this.maxCap;
    }

    @java.lang.SuppressWarnings("all")
        public List<LoanInstallmentChargeData> getInstallmentChargeData() {
        return this.installmentChargeData;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountAccrued() {
        return this.amountAccrued;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountUnrecognized() {
        return this.amountUnrecognized;
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
        public LoanChargeData(final Long id, final Long chargeId, final String name, final EnumOptionData chargeTimeType, final LocalDate submittedOnDate, final LocalDate dueDate, final EnumOptionData chargeCalculationType, final BigDecimal percentage, final BigDecimal amountPercentageAppliedTo, final CurrencyData currency, final BigDecimal amount, final BigDecimal amountPaid, final BigDecimal amountWaived, final BigDecimal amountWrittenOff, final BigDecimal amountOutstanding, final BigDecimal amountOrPercentage, final List<ChargeData> chargeOptions, final boolean penalty, final EnumOptionData chargePaymentMode, final boolean paid, final boolean waived, final boolean chargePayable, final Long loanId, final BigDecimal minCap, final BigDecimal maxCap, final List<LoanInstallmentChargeData> installmentChargeData, final BigDecimal amountAccrued, final BigDecimal amountUnrecognized, final ExternalId externalId, final ExternalId externalLoanId) {
        this.id = id;
        this.chargeId = chargeId;
        this.name = name;
        this.chargeTimeType = chargeTimeType;
        this.submittedOnDate = submittedOnDate;
        this.dueDate = dueDate;
        this.chargeCalculationType = chargeCalculationType;
        this.percentage = percentage;
        this.amountPercentageAppliedTo = amountPercentageAppliedTo;
        this.currency = currency;
        this.amount = amount;
        this.amountPaid = amountPaid;
        this.amountWaived = amountWaived;
        this.amountWrittenOff = amountWrittenOff;
        this.amountOutstanding = amountOutstanding;
        this.amountOrPercentage = amountOrPercentage;
        this.chargeOptions = chargeOptions;
        this.penalty = penalty;
        this.chargePaymentMode = chargePaymentMode;
        this.paid = paid;
        this.waived = waived;
        this.chargePayable = chargePayable;
        this.loanId = loanId;
        this.minCap = minCap;
        this.maxCap = maxCap;
        this.installmentChargeData = installmentChargeData;
        this.amountAccrued = amountAccrued;
        this.amountUnrecognized = amountUnrecognized;
        this.externalId = externalId;
        this.externalLoanId = externalLoanId;
    }
}
