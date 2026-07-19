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
package org.apache.fineract.portfolio.charge.request;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;

public class ChargeRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Integer chargeAppliesTo;
    private String name;
    private String currencyCode;
    private Integer chargeTimeType;
    private Integer chargeCalculationType;
    private Double amount;
    private Boolean active;
    private Boolean penalty;
    private Integer chargePaymentMode;
    private String monthDayFormat;
    private String locale;
    private String feeOnMonthDay;
    private String feeInterval;
    private String feeFrequency;
    private Long paymentTypeId;
    private Boolean enablePaymentType;
    private BigDecimal minCap;
    private BigDecimal maxCap;
    private Long taxGroupId;

    @java.lang.SuppressWarnings("all")
        public Integer getChargeAppliesTo() {
        return this.chargeAppliesTo;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getCurrencyCode() {
        return this.currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getChargeTimeType() {
        return this.chargeTimeType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getChargeCalculationType() {
        return this.chargeCalculationType;
    }

    @java.lang.SuppressWarnings("all")
        public Double getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getActive() {
        return this.active;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getPenalty() {
        return this.penalty;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getChargePaymentMode() {
        return this.chargePaymentMode;
    }

    @java.lang.SuppressWarnings("all")
        public String getMonthDayFormat() {
        return this.monthDayFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getFeeOnMonthDay() {
        return this.feeOnMonthDay;
    }

    @java.lang.SuppressWarnings("all")
        public String getFeeInterval() {
        return this.feeInterval;
    }

    @java.lang.SuppressWarnings("all")
        public String getFeeFrequency() {
        return this.feeFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public Long getPaymentTypeId() {
        return this.paymentTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getEnablePaymentType() {
        return this.enablePaymentType;
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
        public Long getTaxGroupId() {
        return this.taxGroupId;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setChargeAppliesTo(final Integer chargeAppliesTo) {
        this.chargeAppliesTo = chargeAppliesTo;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setCurrencyCode(final String currencyCode) {
        this.currencyCode = currencyCode;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setChargeTimeType(final Integer chargeTimeType) {
        this.chargeTimeType = chargeTimeType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setChargeCalculationType(final Integer chargeCalculationType) {
        this.chargeCalculationType = chargeCalculationType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setAmount(final Double amount) {
        this.amount = amount;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setActive(final Boolean active) {
        this.active = active;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setPenalty(final Boolean penalty) {
        this.penalty = penalty;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setChargePaymentMode(final Integer chargePaymentMode) {
        this.chargePaymentMode = chargePaymentMode;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setMonthDayFormat(final String monthDayFormat) {
        this.monthDayFormat = monthDayFormat;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setLocale(final String locale) {
        this.locale = locale;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setFeeOnMonthDay(final String feeOnMonthDay) {
        this.feeOnMonthDay = feeOnMonthDay;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setFeeInterval(final String feeInterval) {
        this.feeInterval = feeInterval;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setFeeFrequency(final String feeFrequency) {
        this.feeFrequency = feeFrequency;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setPaymentTypeId(final Long paymentTypeId) {
        this.paymentTypeId = paymentTypeId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setEnablePaymentType(final Boolean enablePaymentType) {
        this.enablePaymentType = enablePaymentType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setMinCap(final BigDecimal minCap) {
        this.minCap = minCap;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setMaxCap(final BigDecimal maxCap) {
        this.maxCap = maxCap;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeRequest setTaxGroupId(final Long taxGroupId) {
        this.taxGroupId = taxGroupId;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ChargeRequest)) return false;
        final ChargeRequest other = (ChargeRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$chargeAppliesTo = this.getChargeAppliesTo();
        final java.lang.Object other$chargeAppliesTo = other.getChargeAppliesTo();
        if (this$chargeAppliesTo == null ? other$chargeAppliesTo != null : !this$chargeAppliesTo.equals(other$chargeAppliesTo)) return false;
        final java.lang.Object this$chargeTimeType = this.getChargeTimeType();
        final java.lang.Object other$chargeTimeType = other.getChargeTimeType();
        if (this$chargeTimeType == null ? other$chargeTimeType != null : !this$chargeTimeType.equals(other$chargeTimeType)) return false;
        final java.lang.Object this$chargeCalculationType = this.getChargeCalculationType();
        final java.lang.Object other$chargeCalculationType = other.getChargeCalculationType();
        if (this$chargeCalculationType == null ? other$chargeCalculationType != null : !this$chargeCalculationType.equals(other$chargeCalculationType)) return false;
        final java.lang.Object this$amount = this.getAmount();
        final java.lang.Object other$amount = other.getAmount();
        if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
        final java.lang.Object this$active = this.getActive();
        final java.lang.Object other$active = other.getActive();
        if (this$active == null ? other$active != null : !this$active.equals(other$active)) return false;
        final java.lang.Object this$penalty = this.getPenalty();
        final java.lang.Object other$penalty = other.getPenalty();
        if (this$penalty == null ? other$penalty != null : !this$penalty.equals(other$penalty)) return false;
        final java.lang.Object this$chargePaymentMode = this.getChargePaymentMode();
        final java.lang.Object other$chargePaymentMode = other.getChargePaymentMode();
        if (this$chargePaymentMode == null ? other$chargePaymentMode != null : !this$chargePaymentMode.equals(other$chargePaymentMode)) return false;
        final java.lang.Object this$paymentTypeId = this.getPaymentTypeId();
        final java.lang.Object other$paymentTypeId = other.getPaymentTypeId();
        if (this$paymentTypeId == null ? other$paymentTypeId != null : !this$paymentTypeId.equals(other$paymentTypeId)) return false;
        final java.lang.Object this$enablePaymentType = this.getEnablePaymentType();
        final java.lang.Object other$enablePaymentType = other.getEnablePaymentType();
        if (this$enablePaymentType == null ? other$enablePaymentType != null : !this$enablePaymentType.equals(other$enablePaymentType)) return false;
        final java.lang.Object this$taxGroupId = this.getTaxGroupId();
        final java.lang.Object other$taxGroupId = other.getTaxGroupId();
        if (this$taxGroupId == null ? other$taxGroupId != null : !this$taxGroupId.equals(other$taxGroupId)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$currencyCode = this.getCurrencyCode();
        final java.lang.Object other$currencyCode = other.getCurrencyCode();
        if (this$currencyCode == null ? other$currencyCode != null : !this$currencyCode.equals(other$currencyCode)) return false;
        final java.lang.Object this$monthDayFormat = this.getMonthDayFormat();
        final java.lang.Object other$monthDayFormat = other.getMonthDayFormat();
        if (this$monthDayFormat == null ? other$monthDayFormat != null : !this$monthDayFormat.equals(other$monthDayFormat)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$feeOnMonthDay = this.getFeeOnMonthDay();
        final java.lang.Object other$feeOnMonthDay = other.getFeeOnMonthDay();
        if (this$feeOnMonthDay == null ? other$feeOnMonthDay != null : !this$feeOnMonthDay.equals(other$feeOnMonthDay)) return false;
        final java.lang.Object this$feeInterval = this.getFeeInterval();
        final java.lang.Object other$feeInterval = other.getFeeInterval();
        if (this$feeInterval == null ? other$feeInterval != null : !this$feeInterval.equals(other$feeInterval)) return false;
        final java.lang.Object this$feeFrequency = this.getFeeFrequency();
        final java.lang.Object other$feeFrequency = other.getFeeFrequency();
        if (this$feeFrequency == null ? other$feeFrequency != null : !this$feeFrequency.equals(other$feeFrequency)) return false;
        final java.lang.Object this$minCap = this.getMinCap();
        final java.lang.Object other$minCap = other.getMinCap();
        if (this$minCap == null ? other$minCap != null : !this$minCap.equals(other$minCap)) return false;
        final java.lang.Object this$maxCap = this.getMaxCap();
        final java.lang.Object other$maxCap = other.getMaxCap();
        if (this$maxCap == null ? other$maxCap != null : !this$maxCap.equals(other$maxCap)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ChargeRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $chargeAppliesTo = this.getChargeAppliesTo();
        result = result * PRIME + ($chargeAppliesTo == null ? 43 : $chargeAppliesTo.hashCode());
        final java.lang.Object $chargeTimeType = this.getChargeTimeType();
        result = result * PRIME + ($chargeTimeType == null ? 43 : $chargeTimeType.hashCode());
        final java.lang.Object $chargeCalculationType = this.getChargeCalculationType();
        result = result * PRIME + ($chargeCalculationType == null ? 43 : $chargeCalculationType.hashCode());
        final java.lang.Object $amount = this.getAmount();
        result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
        final java.lang.Object $active = this.getActive();
        result = result * PRIME + ($active == null ? 43 : $active.hashCode());
        final java.lang.Object $penalty = this.getPenalty();
        result = result * PRIME + ($penalty == null ? 43 : $penalty.hashCode());
        final java.lang.Object $chargePaymentMode = this.getChargePaymentMode();
        result = result * PRIME + ($chargePaymentMode == null ? 43 : $chargePaymentMode.hashCode());
        final java.lang.Object $paymentTypeId = this.getPaymentTypeId();
        result = result * PRIME + ($paymentTypeId == null ? 43 : $paymentTypeId.hashCode());
        final java.lang.Object $enablePaymentType = this.getEnablePaymentType();
        result = result * PRIME + ($enablePaymentType == null ? 43 : $enablePaymentType.hashCode());
        final java.lang.Object $taxGroupId = this.getTaxGroupId();
        result = result * PRIME + ($taxGroupId == null ? 43 : $taxGroupId.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $currencyCode = this.getCurrencyCode();
        result = result * PRIME + ($currencyCode == null ? 43 : $currencyCode.hashCode());
        final java.lang.Object $monthDayFormat = this.getMonthDayFormat();
        result = result * PRIME + ($monthDayFormat == null ? 43 : $monthDayFormat.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $feeOnMonthDay = this.getFeeOnMonthDay();
        result = result * PRIME + ($feeOnMonthDay == null ? 43 : $feeOnMonthDay.hashCode());
        final java.lang.Object $feeInterval = this.getFeeInterval();
        result = result * PRIME + ($feeInterval == null ? 43 : $feeInterval.hashCode());
        final java.lang.Object $feeFrequency = this.getFeeFrequency();
        result = result * PRIME + ($feeFrequency == null ? 43 : $feeFrequency.hashCode());
        final java.lang.Object $minCap = this.getMinCap();
        result = result * PRIME + ($minCap == null ? 43 : $minCap.hashCode());
        final java.lang.Object $maxCap = this.getMaxCap();
        result = result * PRIME + ($maxCap == null ? 43 : $maxCap.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ChargeRequest(chargeAppliesTo=" + this.getChargeAppliesTo() + ", name=" + this.getName() + ", currencyCode=" + this.getCurrencyCode() + ", chargeTimeType=" + this.getChargeTimeType() + ", chargeCalculationType=" + this.getChargeCalculationType() + ", amount=" + this.getAmount() + ", active=" + this.getActive() + ", penalty=" + this.getPenalty() + ", chargePaymentMode=" + this.getChargePaymentMode() + ", monthDayFormat=" + this.getMonthDayFormat() + ", locale=" + this.getLocale() + ", feeOnMonthDay=" + this.getFeeOnMonthDay() + ", feeInterval=" + this.getFeeInterval() + ", feeFrequency=" + this.getFeeFrequency() + ", paymentTypeId=" + this.getPaymentTypeId() + ", enablePaymentType=" + this.getEnablePaymentType() + ", minCap=" + this.getMinCap() + ", maxCap=" + this.getMaxCap() + ", taxGroupId=" + this.getTaxGroupId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ChargeRequest() {
    }
}
