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
package org.apache.fineract.portfolio.charge.moduleapi;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Objects;

/**
 * Stable catalog projection of a charge definition for other bounded contexts.
 *
 * <p>
 * Pure Java (no JPA / Spring). Enumerations are integer codes matching the catalog
 * ({@code charge_applies_to_enum}, {@code charge_time_enum}, etc.) so foreign modules need not
 * import {@code charge.domain} types. Prefer this over the fat {@code ChargeData} template DTO
 * for inter-module use.
 * </p>
 *
 * @see ChargeDefinitionPort
 * @see docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md
 */
public final class ChargeDefinitionData implements Serializable {

    private static final long serialVersionUID = 2L;

    private final Long id;
    private final String name;
    private final BigDecimal amount;
    private final String currencyCode;
    private final Integer chargeAppliesTo;
    private final Integer chargeTimeType;
    private final Integer chargeCalculationType;
    private final Integer chargePaymentMode;
    private final boolean penalty;
    private final boolean active;
    private final BigDecimal minCap;
    private final BigDecimal maxCap;
    private final Integer feeInterval;
    private final Integer feeFrequency;
    private final Long incomeOrLiabilityAccountId;
    private final Long taxGroupId;
    /** Day-of-month for annual/monthly fee schedules (nullable). */
    private final Integer feeOnDay;
    /** Month for annual fee schedules (nullable). */
    private final Integer feeOnMonth;
    private final boolean enableFreeWithdrawal;
    private final boolean enablePaymentType;
    private final Integer freeWithdrawalFrequency;
    private final Integer restartFrequency;
    private final Integer restartFrequencyEnum;
    private final Long paymentTypeId;
    private final String paymentTypeName;

    public ChargeDefinitionData(final Long id, final String name, final BigDecimal amount, final String currencyCode,
            final Integer chargeAppliesTo, final Integer chargeTimeType, final Integer chargeCalculationType,
            final Integer chargePaymentMode, final boolean penalty, final boolean active, final BigDecimal minCap, final BigDecimal maxCap,
            final Integer feeInterval, final Integer feeFrequency, final Long incomeOrLiabilityAccountId, final Long taxGroupId) {
        this(id, name, amount, currencyCode, chargeAppliesTo, chargeTimeType, chargeCalculationType, chargePaymentMode, penalty, active,
                minCap, maxCap, feeInterval, feeFrequency, incomeOrLiabilityAccountId, taxGroupId, null, null, false, false, null, null,
                null, null, null);
    }

    public ChargeDefinitionData(final Long id, final String name, final BigDecimal amount, final String currencyCode,
            final Integer chargeAppliesTo, final Integer chargeTimeType, final Integer chargeCalculationType,
            final Integer chargePaymentMode, final boolean penalty, final boolean active, final BigDecimal minCap, final BigDecimal maxCap,
            final Integer feeInterval, final Integer feeFrequency, final Long incomeOrLiabilityAccountId, final Long taxGroupId,
            final Integer feeOnDay, final Integer feeOnMonth, final boolean enableFreeWithdrawal, final boolean enablePaymentType,
            final Integer freeWithdrawalFrequency, final Integer restartFrequency, final Integer restartFrequencyEnum,
            final Long paymentTypeId, final String paymentTypeName) {
        this.id = id;
        this.name = name;
        this.amount = amount;
        this.currencyCode = currencyCode;
        this.chargeAppliesTo = chargeAppliesTo;
        this.chargeTimeType = chargeTimeType;
        this.chargeCalculationType = chargeCalculationType;
        this.chargePaymentMode = chargePaymentMode;
        this.penalty = penalty;
        this.active = active;
        this.minCap = minCap;
        this.maxCap = maxCap;
        this.feeInterval = feeInterval;
        this.feeFrequency = feeFrequency;
        this.incomeOrLiabilityAccountId = incomeOrLiabilityAccountId;
        this.taxGroupId = taxGroupId;
        this.feeOnDay = feeOnDay;
        this.feeOnMonth = feeOnMonth;
        this.enableFreeWithdrawal = enableFreeWithdrawal;
        this.enablePaymentType = enablePaymentType;
        this.freeWithdrawalFrequency = freeWithdrawalFrequency;
        this.restartFrequency = restartFrequency;
        this.restartFrequencyEnum = restartFrequencyEnum;
        this.paymentTypeId = paymentTypeId;
        this.paymentTypeName = paymentTypeName;
    }

    public Long getId() {
        return this.id;
    }

    public String getName() {
        return this.name;
    }

    public BigDecimal getAmount() {
        return this.amount;
    }

    public String getCurrencyCode() {
        return this.currencyCode;
    }

    public Integer getChargeAppliesTo() {
        return this.chargeAppliesTo;
    }

    public Integer getChargeTimeType() {
        return this.chargeTimeType;
    }

    public Integer getChargeCalculationType() {
        return this.chargeCalculationType;
    }

    public Integer getChargePaymentMode() {
        return this.chargePaymentMode;
    }

    public boolean isPenalty() {
        return this.penalty;
    }

    public boolean isActive() {
        return this.active;
    }

    public BigDecimal getMinCap() {
        return this.minCap;
    }

    public BigDecimal getMaxCap() {
        return this.maxCap;
    }

    public Integer getFeeInterval() {
        return this.feeInterval;
    }

    public Integer getFeeFrequency() {
        return this.feeFrequency;
    }

    public Long getIncomeOrLiabilityAccountId() {
        return this.incomeOrLiabilityAccountId;
    }

    public Long getTaxGroupId() {
        return this.taxGroupId;
    }

    public Integer getFeeOnDay() {
        return this.feeOnDay;
    }

    public Integer getFeeOnMonth() {
        return this.feeOnMonth;
    }

    public boolean isEnableFreeWithdrawal() {
        return this.enableFreeWithdrawal;
    }

    public boolean isEnablePaymentType() {
        return this.enablePaymentType;
    }

    public Integer getFreeWithdrawalFrequency() {
        return this.freeWithdrawalFrequency;
    }

    public Integer getRestartFrequency() {
        return this.restartFrequency;
    }

    public Integer getRestartFrequencyEnum() {
        return this.restartFrequencyEnum;
    }

    public Long getPaymentTypeId() {
        return this.paymentTypeId;
    }

    public String getPaymentTypeName() {
        return this.paymentTypeName;
    }

    /**
     * Reconstructs fee schedule day when both month and day are present.
     */
    public java.time.MonthDay getFeeOnMonthDay() {
        if (this.feeOnDay == null || this.feeOnMonth == null) {
            return null;
        }
        return java.time.MonthDay.of(this.feeOnMonth, this.feeOnDay);
    }

    @Override
    public boolean equals(final Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof ChargeDefinitionData)) {
            return false;
        }
        final ChargeDefinitionData that = (ChargeDefinitionData) o;
        return Objects.equals(this.id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }

    @Override
    public String toString() {
        return "ChargeDefinitionData{id=" + this.id + ", name='" + this.name + "'}";
    }
}
