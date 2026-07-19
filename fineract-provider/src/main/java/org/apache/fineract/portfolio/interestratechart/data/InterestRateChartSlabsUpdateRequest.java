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
package org.apache.fineract.portfolio.interestratechart.data;

import io.swagger.v3.oas.annotations.Hidden;
import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

public class InterestRateChartSlabsUpdateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Hidden
    private Long chartId;
    @Hidden
    private Long chartSlabId;
    private Integer periodType;
    private Integer fromPeriod;
    private Integer toPeriod;
    private BigDecimal amountRangeFrom;
    private BigDecimal amountRangeTo;
    private Double annualInterestRate;
    private String currencyCode;
    private String description;
    private String locale;
    private List<Incentive> incentives;


    public static class Incentive implements Serializable {
        @Serial
        private static final long serialVersionUID = 1L;
        private Long id;
        private String description;
        private Integer entityType;
        private Integer attributeName;
        private Integer conditionType;
        private String attributeValue;
        private Integer incentiveType;
        private BigDecimal amount;


        @java.lang.SuppressWarnings("all")
                public static class IncentiveBuilder {
            @java.lang.SuppressWarnings("all")
                        private Long id;
            @java.lang.SuppressWarnings("all")
                        private String description;
            @java.lang.SuppressWarnings("all")
                        private Integer entityType;
            @java.lang.SuppressWarnings("all")
                        private Integer attributeName;
            @java.lang.SuppressWarnings("all")
                        private Integer conditionType;
            @java.lang.SuppressWarnings("all")
                        private String attributeValue;
            @java.lang.SuppressWarnings("all")
                        private Integer incentiveType;
            @java.lang.SuppressWarnings("all")
                        private BigDecimal amount;

            @java.lang.SuppressWarnings("all")
                        IncentiveBuilder() {
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public InterestRateChartSlabsUpdateRequest.Incentive.IncentiveBuilder id(final Long id) {
                this.id = id;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public InterestRateChartSlabsUpdateRequest.Incentive.IncentiveBuilder description(final String description) {
                this.description = description;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public InterestRateChartSlabsUpdateRequest.Incentive.IncentiveBuilder entityType(final Integer entityType) {
                this.entityType = entityType;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public InterestRateChartSlabsUpdateRequest.Incentive.IncentiveBuilder attributeName(final Integer attributeName) {
                this.attributeName = attributeName;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public InterestRateChartSlabsUpdateRequest.Incentive.IncentiveBuilder conditionType(final Integer conditionType) {
                this.conditionType = conditionType;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public InterestRateChartSlabsUpdateRequest.Incentive.IncentiveBuilder attributeValue(final String attributeValue) {
                this.attributeValue = attributeValue;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public InterestRateChartSlabsUpdateRequest.Incentive.IncentiveBuilder incentiveType(final Integer incentiveType) {
                this.incentiveType = incentiveType;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public InterestRateChartSlabsUpdateRequest.Incentive.IncentiveBuilder amount(final BigDecimal amount) {
                this.amount = amount;
                return this;
            }

            @java.lang.SuppressWarnings("all")
                        public InterestRateChartSlabsUpdateRequest.Incentive build() {
                return new InterestRateChartSlabsUpdateRequest.Incentive(this.id, this.description, this.entityType, this.attributeName, this.conditionType, this.attributeValue, this.incentiveType, this.amount);
            }

            @java.lang.Override
            @java.lang.SuppressWarnings("all")
                        public java.lang.String toString() {
                return "InterestRateChartSlabsUpdateRequest.Incentive.IncentiveBuilder(id=" + this.id + ", description=" + this.description + ", entityType=" + this.entityType + ", attributeName=" + this.attributeName + ", conditionType=" + this.conditionType + ", attributeValue=" + this.attributeValue + ", incentiveType=" + this.incentiveType + ", amount=" + this.amount + ")";
            }
        }

        @java.lang.SuppressWarnings("all")
                public static InterestRateChartSlabsUpdateRequest.Incentive.IncentiveBuilder builder() {
            return new InterestRateChartSlabsUpdateRequest.Incentive.IncentiveBuilder();
        }

        @java.lang.SuppressWarnings("all")
                public Incentive(final Long id, final String description, final Integer entityType, final Integer attributeName, final Integer conditionType, final String attributeValue, final Integer incentiveType, final BigDecimal amount) {
            this.id = id;
            this.description = description;
            this.entityType = entityType;
            this.attributeName = attributeName;
            this.conditionType = conditionType;
            this.attributeValue = attributeValue;
            this.incentiveType = incentiveType;
            this.amount = amount;
        }

        @java.lang.SuppressWarnings("all")
                public Incentive() {
        }

        @java.lang.SuppressWarnings("all")
                public Long getId() {
            return this.id;
        }

        @java.lang.SuppressWarnings("all")
                public String getDescription() {
            return this.description;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getEntityType() {
            return this.entityType;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getAttributeName() {
            return this.attributeName;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getConditionType() {
            return this.conditionType;
        }

        @java.lang.SuppressWarnings("all")
                public String getAttributeValue() {
            return this.attributeValue;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getIncentiveType() {
            return this.incentiveType;
        }

        @java.lang.SuppressWarnings("all")
                public BigDecimal getAmount() {
            return this.amount;
        }

        @java.lang.SuppressWarnings("all")
                public void setId(final Long id) {
            this.id = id;
        }

        @java.lang.SuppressWarnings("all")
                public void setDescription(final String description) {
            this.description = description;
        }

        @java.lang.SuppressWarnings("all")
                public void setEntityType(final Integer entityType) {
            this.entityType = entityType;
        }

        @java.lang.SuppressWarnings("all")
                public void setAttributeName(final Integer attributeName) {
            this.attributeName = attributeName;
        }

        @java.lang.SuppressWarnings("all")
                public void setConditionType(final Integer conditionType) {
            this.conditionType = conditionType;
        }

        @java.lang.SuppressWarnings("all")
                public void setAttributeValue(final String attributeValue) {
            this.attributeValue = attributeValue;
        }

        @java.lang.SuppressWarnings("all")
                public void setIncentiveType(final Integer incentiveType) {
            this.incentiveType = incentiveType;
        }

        @java.lang.SuppressWarnings("all")
                public void setAmount(final BigDecimal amount) {
            this.amount = amount;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public boolean equals(final java.lang.Object o) {
            if (o == this) return true;
            if (!(o instanceof InterestRateChartSlabsUpdateRequest.Incentive)) return false;
            final InterestRateChartSlabsUpdateRequest.Incentive other = (InterestRateChartSlabsUpdateRequest.Incentive) o;
            if (!other.canEqual((java.lang.Object) this)) return false;
            final java.lang.Object this$id = this.getId();
            final java.lang.Object other$id = other.getId();
            if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
            final java.lang.Object this$entityType = this.getEntityType();
            final java.lang.Object other$entityType = other.getEntityType();
            if (this$entityType == null ? other$entityType != null : !this$entityType.equals(other$entityType)) return false;
            final java.lang.Object this$attributeName = this.getAttributeName();
            final java.lang.Object other$attributeName = other.getAttributeName();
            if (this$attributeName == null ? other$attributeName != null : !this$attributeName.equals(other$attributeName)) return false;
            final java.lang.Object this$conditionType = this.getConditionType();
            final java.lang.Object other$conditionType = other.getConditionType();
            if (this$conditionType == null ? other$conditionType != null : !this$conditionType.equals(other$conditionType)) return false;
            final java.lang.Object this$incentiveType = this.getIncentiveType();
            final java.lang.Object other$incentiveType = other.getIncentiveType();
            if (this$incentiveType == null ? other$incentiveType != null : !this$incentiveType.equals(other$incentiveType)) return false;
            final java.lang.Object this$description = this.getDescription();
            final java.lang.Object other$description = other.getDescription();
            if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
            final java.lang.Object this$attributeValue = this.getAttributeValue();
            final java.lang.Object other$attributeValue = other.getAttributeValue();
            if (this$attributeValue == null ? other$attributeValue != null : !this$attributeValue.equals(other$attributeValue)) return false;
            final java.lang.Object this$amount = this.getAmount();
            final java.lang.Object other$amount = other.getAmount();
            if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
            return true;
        }

        @java.lang.SuppressWarnings("all")
                protected boolean canEqual(final java.lang.Object other) {
            return other instanceof InterestRateChartSlabsUpdateRequest.Incentive;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public int hashCode() {
            final int PRIME = 59;
            int result = 1;
            final java.lang.Object $id = this.getId();
            result = result * PRIME + ($id == null ? 43 : $id.hashCode());
            final java.lang.Object $entityType = this.getEntityType();
            result = result * PRIME + ($entityType == null ? 43 : $entityType.hashCode());
            final java.lang.Object $attributeName = this.getAttributeName();
            result = result * PRIME + ($attributeName == null ? 43 : $attributeName.hashCode());
            final java.lang.Object $conditionType = this.getConditionType();
            result = result * PRIME + ($conditionType == null ? 43 : $conditionType.hashCode());
            final java.lang.Object $incentiveType = this.getIncentiveType();
            result = result * PRIME + ($incentiveType == null ? 43 : $incentiveType.hashCode());
            final java.lang.Object $description = this.getDescription();
            result = result * PRIME + ($description == null ? 43 : $description.hashCode());
            final java.lang.Object $attributeValue = this.getAttributeValue();
            result = result * PRIME + ($attributeValue == null ? 43 : $attributeValue.hashCode());
            final java.lang.Object $amount = this.getAmount();
            result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
            return result;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "InterestRateChartSlabsUpdateRequest.Incentive(id=" + this.getId() + ", description=" + this.getDescription() + ", entityType=" + this.getEntityType() + ", attributeName=" + this.getAttributeName() + ", conditionType=" + this.getConditionType() + ", attributeValue=" + this.getAttributeValue() + ", incentiveType=" + this.getIncentiveType() + ", amount=" + this.getAmount() + ")";
        }
    }


    @java.lang.SuppressWarnings("all")
        public static class InterestRateChartSlabsUpdateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long chartId;
        @java.lang.SuppressWarnings("all")
                private Long chartSlabId;
        @java.lang.SuppressWarnings("all")
                private Integer periodType;
        @java.lang.SuppressWarnings("all")
                private Integer fromPeriod;
        @java.lang.SuppressWarnings("all")
                private Integer toPeriod;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amountRangeFrom;
        @java.lang.SuppressWarnings("all")
                private BigDecimal amountRangeTo;
        @java.lang.SuppressWarnings("all")
                private Double annualInterestRate;
        @java.lang.SuppressWarnings("all")
                private String currencyCode;
        @java.lang.SuppressWarnings("all")
                private String description;
        @java.lang.SuppressWarnings("all")
                private String locale;
        @java.lang.SuppressWarnings("all")
                private List<Incentive> incentives;

        @java.lang.SuppressWarnings("all")
                InterestRateChartSlabsUpdateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateRequest.InterestRateChartSlabsUpdateRequestBuilder chartId(final Long chartId) {
            this.chartId = chartId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateRequest.InterestRateChartSlabsUpdateRequestBuilder chartSlabId(final Long chartSlabId) {
            this.chartSlabId = chartSlabId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateRequest.InterestRateChartSlabsUpdateRequestBuilder periodType(final Integer periodType) {
            this.periodType = periodType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateRequest.InterestRateChartSlabsUpdateRequestBuilder fromPeriod(final Integer fromPeriod) {
            this.fromPeriod = fromPeriod;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateRequest.InterestRateChartSlabsUpdateRequestBuilder toPeriod(final Integer toPeriod) {
            this.toPeriod = toPeriod;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateRequest.InterestRateChartSlabsUpdateRequestBuilder amountRangeFrom(final BigDecimal amountRangeFrom) {
            this.amountRangeFrom = amountRangeFrom;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateRequest.InterestRateChartSlabsUpdateRequestBuilder amountRangeTo(final BigDecimal amountRangeTo) {
            this.amountRangeTo = amountRangeTo;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateRequest.InterestRateChartSlabsUpdateRequestBuilder annualInterestRate(final Double annualInterestRate) {
            this.annualInterestRate = annualInterestRate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateRequest.InterestRateChartSlabsUpdateRequestBuilder currencyCode(final String currencyCode) {
            this.currencyCode = currencyCode;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateRequest.InterestRateChartSlabsUpdateRequestBuilder description(final String description) {
            this.description = description;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateRequest.InterestRateChartSlabsUpdateRequestBuilder locale(final String locale) {
            this.locale = locale;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateRequest.InterestRateChartSlabsUpdateRequestBuilder incentives(final List<Incentive> incentives) {
            this.incentives = incentives;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public InterestRateChartSlabsUpdateRequest build() {
            return new InterestRateChartSlabsUpdateRequest(this.chartId, this.chartSlabId, this.periodType, this.fromPeriod, this.toPeriod, this.amountRangeFrom, this.amountRangeTo, this.annualInterestRate, this.currencyCode, this.description, this.locale, this.incentives);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "InterestRateChartSlabsUpdateRequest.InterestRateChartSlabsUpdateRequestBuilder(chartId=" + this.chartId + ", chartSlabId=" + this.chartSlabId + ", periodType=" + this.periodType + ", fromPeriod=" + this.fromPeriod + ", toPeriod=" + this.toPeriod + ", amountRangeFrom=" + this.amountRangeFrom + ", amountRangeTo=" + this.amountRangeTo + ", annualInterestRate=" + this.annualInterestRate + ", currencyCode=" + this.currencyCode + ", description=" + this.description + ", locale=" + this.locale + ", incentives=" + this.incentives + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static InterestRateChartSlabsUpdateRequest.InterestRateChartSlabsUpdateRequestBuilder builder() {
        return new InterestRateChartSlabsUpdateRequest.InterestRateChartSlabsUpdateRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public InterestRateChartSlabsUpdateRequest(final Long chartId, final Long chartSlabId, final Integer periodType, final Integer fromPeriod, final Integer toPeriod, final BigDecimal amountRangeFrom, final BigDecimal amountRangeTo, final Double annualInterestRate, final String currencyCode, final String description, final String locale, final List<Incentive> incentives) {
        this.chartId = chartId;
        this.chartSlabId = chartSlabId;
        this.periodType = periodType;
        this.fromPeriod = fromPeriod;
        this.toPeriod = toPeriod;
        this.amountRangeFrom = amountRangeFrom;
        this.amountRangeTo = amountRangeTo;
        this.annualInterestRate = annualInterestRate;
        this.currencyCode = currencyCode;
        this.description = description;
        this.locale = locale;
        this.incentives = incentives;
    }

    @java.lang.SuppressWarnings("all")
        public InterestRateChartSlabsUpdateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public Long getChartId() {
        return this.chartId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getChartSlabId() {
        return this.chartSlabId;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getPeriodType() {
        return this.periodType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getFromPeriod() {
        return this.fromPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getToPeriod() {
        return this.toPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountRangeFrom() {
        return this.amountRangeFrom;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountRangeTo() {
        return this.amountRangeTo;
    }

    @java.lang.SuppressWarnings("all")
        public Double getAnnualInterestRate() {
        return this.annualInterestRate;
    }

    @java.lang.SuppressWarnings("all")
        public String getCurrencyCode() {
        return this.currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public List<Incentive> getIncentives() {
        return this.incentives;
    }

    @java.lang.SuppressWarnings("all")
        public void setChartId(final Long chartId) {
        this.chartId = chartId;
    }

    @java.lang.SuppressWarnings("all")
        public void setChartSlabId(final Long chartSlabId) {
        this.chartSlabId = chartSlabId;
    }

    @java.lang.SuppressWarnings("all")
        public void setPeriodType(final Integer periodType) {
        this.periodType = periodType;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromPeriod(final Integer fromPeriod) {
        this.fromPeriod = fromPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public void setToPeriod(final Integer toPeriod) {
        this.toPeriod = toPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmountRangeFrom(final BigDecimal amountRangeFrom) {
        this.amountRangeFrom = amountRangeFrom;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmountRangeTo(final BigDecimal amountRangeTo) {
        this.amountRangeTo = amountRangeTo;
    }

    @java.lang.SuppressWarnings("all")
        public void setAnnualInterestRate(final Double annualInterestRate) {
        this.annualInterestRate = annualInterestRate;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrencyCode(final String currencyCode) {
        this.currencyCode = currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public void setDescription(final String description) {
        this.description = description;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setIncentives(final List<Incentive> incentives) {
        this.incentives = incentives;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof InterestRateChartSlabsUpdateRequest)) return false;
        final InterestRateChartSlabsUpdateRequest other = (InterestRateChartSlabsUpdateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$chartId = this.getChartId();
        final java.lang.Object other$chartId = other.getChartId();
        if (this$chartId == null ? other$chartId != null : !this$chartId.equals(other$chartId)) return false;
        final java.lang.Object this$chartSlabId = this.getChartSlabId();
        final java.lang.Object other$chartSlabId = other.getChartSlabId();
        if (this$chartSlabId == null ? other$chartSlabId != null : !this$chartSlabId.equals(other$chartSlabId)) return false;
        final java.lang.Object this$periodType = this.getPeriodType();
        final java.lang.Object other$periodType = other.getPeriodType();
        if (this$periodType == null ? other$periodType != null : !this$periodType.equals(other$periodType)) return false;
        final java.lang.Object this$fromPeriod = this.getFromPeriod();
        final java.lang.Object other$fromPeriod = other.getFromPeriod();
        if (this$fromPeriod == null ? other$fromPeriod != null : !this$fromPeriod.equals(other$fromPeriod)) return false;
        final java.lang.Object this$toPeriod = this.getToPeriod();
        final java.lang.Object other$toPeriod = other.getToPeriod();
        if (this$toPeriod == null ? other$toPeriod != null : !this$toPeriod.equals(other$toPeriod)) return false;
        final java.lang.Object this$annualInterestRate = this.getAnnualInterestRate();
        final java.lang.Object other$annualInterestRate = other.getAnnualInterestRate();
        if (this$annualInterestRate == null ? other$annualInterestRate != null : !this$annualInterestRate.equals(other$annualInterestRate)) return false;
        final java.lang.Object this$amountRangeFrom = this.getAmountRangeFrom();
        final java.lang.Object other$amountRangeFrom = other.getAmountRangeFrom();
        if (this$amountRangeFrom == null ? other$amountRangeFrom != null : !this$amountRangeFrom.equals(other$amountRangeFrom)) return false;
        final java.lang.Object this$amountRangeTo = this.getAmountRangeTo();
        final java.lang.Object other$amountRangeTo = other.getAmountRangeTo();
        if (this$amountRangeTo == null ? other$amountRangeTo != null : !this$amountRangeTo.equals(other$amountRangeTo)) return false;
        final java.lang.Object this$currencyCode = this.getCurrencyCode();
        final java.lang.Object other$currencyCode = other.getCurrencyCode();
        if (this$currencyCode == null ? other$currencyCode != null : !this$currencyCode.equals(other$currencyCode)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$incentives = this.getIncentives();
        final java.lang.Object other$incentives = other.getIncentives();
        if (this$incentives == null ? other$incentives != null : !this$incentives.equals(other$incentives)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof InterestRateChartSlabsUpdateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $chartId = this.getChartId();
        result = result * PRIME + ($chartId == null ? 43 : $chartId.hashCode());
        final java.lang.Object $chartSlabId = this.getChartSlabId();
        result = result * PRIME + ($chartSlabId == null ? 43 : $chartSlabId.hashCode());
        final java.lang.Object $periodType = this.getPeriodType();
        result = result * PRIME + ($periodType == null ? 43 : $periodType.hashCode());
        final java.lang.Object $fromPeriod = this.getFromPeriod();
        result = result * PRIME + ($fromPeriod == null ? 43 : $fromPeriod.hashCode());
        final java.lang.Object $toPeriod = this.getToPeriod();
        result = result * PRIME + ($toPeriod == null ? 43 : $toPeriod.hashCode());
        final java.lang.Object $annualInterestRate = this.getAnnualInterestRate();
        result = result * PRIME + ($annualInterestRate == null ? 43 : $annualInterestRate.hashCode());
        final java.lang.Object $amountRangeFrom = this.getAmountRangeFrom();
        result = result * PRIME + ($amountRangeFrom == null ? 43 : $amountRangeFrom.hashCode());
        final java.lang.Object $amountRangeTo = this.getAmountRangeTo();
        result = result * PRIME + ($amountRangeTo == null ? 43 : $amountRangeTo.hashCode());
        final java.lang.Object $currencyCode = this.getCurrencyCode();
        result = result * PRIME + ($currencyCode == null ? 43 : $currencyCode.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $incentives = this.getIncentives();
        result = result * PRIME + ($incentives == null ? 43 : $incentives.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "InterestRateChartSlabsUpdateRequest(chartId=" + this.getChartId() + ", chartSlabId=" + this.getChartSlabId() + ", periodType=" + this.getPeriodType() + ", fromPeriod=" + this.getFromPeriod() + ", toPeriod=" + this.getToPeriod() + ", amountRangeFrom=" + this.getAmountRangeFrom() + ", amountRangeTo=" + this.getAmountRangeTo() + ", annualInterestRate=" + this.getAnnualInterestRate() + ", currencyCode=" + this.getCurrencyCode() + ", description=" + this.getDescription() + ", locale=" + this.getLocale() + ", incentives=" + this.getIncentives() + ")";
    }
}
