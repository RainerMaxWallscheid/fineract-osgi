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
package org.apache.fineract.portfolio.search.data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public class AdHocQuerySearchRequest implements Serializable {
    private String locale;
    private String dateFormat;
    private List<String> entities;
    private List<String> loanStatus;
    private List<Long> loanProducts;
    private List<Long> offices;
    private String loanDateOption;
    private LocalDate loanFromDate;
    private LocalDate loanToDate;
    private Boolean includeOutStandingAmountPercentage;
    private String outStandingAmountPercentageCondition;
    private BigDecimal minOutStandingAmountPercentage;
    private BigDecimal maxOutStandingAmountPercentage;
    private BigDecimal outStandingAmountPercentage;
    private Boolean includeOutstandingAmount;
    private String outstandingAmountCondition;
    private BigDecimal minOutstandingAmount;
    private BigDecimal maxOutstandingAmount;
    private BigDecimal outstandingAmount;


    @java.lang.SuppressWarnings("all")
        public static class AdHocQuerySearchRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private String locale;
        @java.lang.SuppressWarnings("all")
                private String dateFormat;
        @java.lang.SuppressWarnings("all")
                private List<String> entities;
        @java.lang.SuppressWarnings("all")
                private List<String> loanStatus;
        @java.lang.SuppressWarnings("all")
                private List<Long> loanProducts;
        @java.lang.SuppressWarnings("all")
                private List<Long> offices;
        @java.lang.SuppressWarnings("all")
                private String loanDateOption;
        @java.lang.SuppressWarnings("all")
                private LocalDate loanFromDate;
        @java.lang.SuppressWarnings("all")
                private LocalDate loanToDate;
        @java.lang.SuppressWarnings("all")
                private Boolean includeOutStandingAmountPercentage;
        @java.lang.SuppressWarnings("all")
                private String outStandingAmountPercentageCondition;
        @java.lang.SuppressWarnings("all")
                private BigDecimal minOutStandingAmountPercentage;
        @java.lang.SuppressWarnings("all")
                private BigDecimal maxOutStandingAmountPercentage;
        @java.lang.SuppressWarnings("all")
                private BigDecimal outStandingAmountPercentage;
        @java.lang.SuppressWarnings("all")
                private Boolean includeOutstandingAmount;
        @java.lang.SuppressWarnings("all")
                private String outstandingAmountCondition;
        @java.lang.SuppressWarnings("all")
                private BigDecimal minOutstandingAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal maxOutstandingAmount;
        @java.lang.SuppressWarnings("all")
                private BigDecimal outstandingAmount;

        @java.lang.SuppressWarnings("all")
                AdHocQuerySearchRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder locale(final String locale) {
            this.locale = locale;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder dateFormat(final String dateFormat) {
            this.dateFormat = dateFormat;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder entities(final List<String> entities) {
            this.entities = entities;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder loanStatus(final List<String> loanStatus) {
            this.loanStatus = loanStatus;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder loanProducts(final List<Long> loanProducts) {
            this.loanProducts = loanProducts;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder offices(final List<Long> offices) {
            this.offices = offices;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder loanDateOption(final String loanDateOption) {
            this.loanDateOption = loanDateOption;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder loanFromDate(final LocalDate loanFromDate) {
            this.loanFromDate = loanFromDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder loanToDate(final LocalDate loanToDate) {
            this.loanToDate = loanToDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder includeOutStandingAmountPercentage(final Boolean includeOutStandingAmountPercentage) {
            this.includeOutStandingAmountPercentage = includeOutStandingAmountPercentage;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder outStandingAmountPercentageCondition(final String outStandingAmountPercentageCondition) {
            this.outStandingAmountPercentageCondition = outStandingAmountPercentageCondition;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder minOutStandingAmountPercentage(final BigDecimal minOutStandingAmountPercentage) {
            this.minOutStandingAmountPercentage = minOutStandingAmountPercentage;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder maxOutStandingAmountPercentage(final BigDecimal maxOutStandingAmountPercentage) {
            this.maxOutStandingAmountPercentage = maxOutStandingAmountPercentage;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder outStandingAmountPercentage(final BigDecimal outStandingAmountPercentage) {
            this.outStandingAmountPercentage = outStandingAmountPercentage;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder includeOutstandingAmount(final Boolean includeOutstandingAmount) {
            this.includeOutstandingAmount = includeOutstandingAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder outstandingAmountCondition(final String outstandingAmountCondition) {
            this.outstandingAmountCondition = outstandingAmountCondition;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder minOutstandingAmount(final BigDecimal minOutstandingAmount) {
            this.minOutstandingAmount = minOutstandingAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder maxOutstandingAmount(final BigDecimal maxOutstandingAmount) {
            this.maxOutstandingAmount = maxOutstandingAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder outstandingAmount(final BigDecimal outstandingAmount) {
            this.outstandingAmount = outstandingAmount;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public AdHocQuerySearchRequest build() {
            return new AdHocQuerySearchRequest(this.locale, this.dateFormat, this.entities, this.loanStatus, this.loanProducts, this.offices, this.loanDateOption, this.loanFromDate, this.loanToDate, this.includeOutStandingAmountPercentage, this.outStandingAmountPercentageCondition, this.minOutStandingAmountPercentage, this.maxOutStandingAmountPercentage, this.outStandingAmountPercentage, this.includeOutstandingAmount, this.outstandingAmountCondition, this.minOutstandingAmount, this.maxOutstandingAmount, this.outstandingAmount);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder(locale=" + this.locale + ", dateFormat=" + this.dateFormat + ", entities=" + this.entities + ", loanStatus=" + this.loanStatus + ", loanProducts=" + this.loanProducts + ", offices=" + this.offices + ", loanDateOption=" + this.loanDateOption + ", loanFromDate=" + this.loanFromDate + ", loanToDate=" + this.loanToDate + ", includeOutStandingAmountPercentage=" + this.includeOutStandingAmountPercentage + ", outStandingAmountPercentageCondition=" + this.outStandingAmountPercentageCondition + ", minOutStandingAmountPercentage=" + this.minOutStandingAmountPercentage + ", maxOutStandingAmountPercentage=" + this.maxOutStandingAmountPercentage + ", outStandingAmountPercentage=" + this.outStandingAmountPercentage + ", includeOutstandingAmount=" + this.includeOutstandingAmount + ", outstandingAmountCondition=" + this.outstandingAmountCondition + ", minOutstandingAmount=" + this.minOutstandingAmount + ", maxOutstandingAmount=" + this.maxOutstandingAmount + ", outstandingAmount=" + this.outstandingAmount + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder builder() {
        return new AdHocQuerySearchRequest.AdHocQuerySearchRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public List<String> getEntities() {
        return this.entities;
    }

    @java.lang.SuppressWarnings("all")
        public List<String> getLoanStatus() {
        return this.loanStatus;
    }

    @java.lang.SuppressWarnings("all")
        public List<Long> getLoanProducts() {
        return this.loanProducts;
    }

    @java.lang.SuppressWarnings("all")
        public List<Long> getOffices() {
        return this.offices;
    }

    @java.lang.SuppressWarnings("all")
        public String getLoanDateOption() {
        return this.loanDateOption;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getLoanFromDate() {
        return this.loanFromDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getLoanToDate() {
        return this.loanToDate;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIncludeOutStandingAmountPercentage() {
        return this.includeOutStandingAmountPercentage;
    }

    @java.lang.SuppressWarnings("all")
        public String getOutStandingAmountPercentageCondition() {
        return this.outStandingAmountPercentageCondition;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMinOutStandingAmountPercentage() {
        return this.minOutStandingAmountPercentage;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMaxOutStandingAmountPercentage() {
        return this.maxOutStandingAmountPercentage;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOutStandingAmountPercentage() {
        return this.outStandingAmountPercentage;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIncludeOutstandingAmount() {
        return this.includeOutstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
        public String getOutstandingAmountCondition() {
        return this.outstandingAmountCondition;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMinOutstandingAmount() {
        return this.minOutstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMaxOutstandingAmount() {
        return this.maxOutstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOutstandingAmount() {
        return this.outstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntities(final List<String> entities) {
        this.entities = entities;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanStatus(final List<String> loanStatus) {
        this.loanStatus = loanStatus;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanProducts(final List<Long> loanProducts) {
        this.loanProducts = loanProducts;
    }

    @java.lang.SuppressWarnings("all")
        public void setOffices(final List<Long> offices) {
        this.offices = offices;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanDateOption(final String loanDateOption) {
        this.loanDateOption = loanDateOption;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanFromDate(final LocalDate loanFromDate) {
        this.loanFromDate = loanFromDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanToDate(final LocalDate loanToDate) {
        this.loanToDate = loanToDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setIncludeOutStandingAmountPercentage(final Boolean includeOutStandingAmountPercentage) {
        this.includeOutStandingAmountPercentage = includeOutStandingAmountPercentage;
    }

    @java.lang.SuppressWarnings("all")
        public void setOutStandingAmountPercentageCondition(final String outStandingAmountPercentageCondition) {
        this.outStandingAmountPercentageCondition = outStandingAmountPercentageCondition;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinOutStandingAmountPercentage(final BigDecimal minOutStandingAmountPercentage) {
        this.minOutStandingAmountPercentage = minOutStandingAmountPercentage;
    }

    @java.lang.SuppressWarnings("all")
        public void setMaxOutStandingAmountPercentage(final BigDecimal maxOutStandingAmountPercentage) {
        this.maxOutStandingAmountPercentage = maxOutStandingAmountPercentage;
    }

    @java.lang.SuppressWarnings("all")
        public void setOutStandingAmountPercentage(final BigDecimal outStandingAmountPercentage) {
        this.outStandingAmountPercentage = outStandingAmountPercentage;
    }

    @java.lang.SuppressWarnings("all")
        public void setIncludeOutstandingAmount(final Boolean includeOutstandingAmount) {
        this.includeOutstandingAmount = includeOutstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setOutstandingAmountCondition(final String outstandingAmountCondition) {
        this.outstandingAmountCondition = outstandingAmountCondition;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinOutstandingAmount(final BigDecimal minOutstandingAmount) {
        this.minOutstandingAmount = minOutstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setMaxOutstandingAmount(final BigDecimal maxOutstandingAmount) {
        this.maxOutstandingAmount = maxOutstandingAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setOutstandingAmount(final BigDecimal outstandingAmount) {
        this.outstandingAmount = outstandingAmount;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AdHocQuerySearchRequest)) return false;
        final AdHocQuerySearchRequest other = (AdHocQuerySearchRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$includeOutStandingAmountPercentage = this.getIncludeOutStandingAmountPercentage();
        final java.lang.Object other$includeOutStandingAmountPercentage = other.getIncludeOutStandingAmountPercentage();
        if (this$includeOutStandingAmountPercentage == null ? other$includeOutStandingAmountPercentage != null : !this$includeOutStandingAmountPercentage.equals(other$includeOutStandingAmountPercentage)) return false;
        final java.lang.Object this$includeOutstandingAmount = this.getIncludeOutstandingAmount();
        final java.lang.Object other$includeOutstandingAmount = other.getIncludeOutstandingAmount();
        if (this$includeOutstandingAmount == null ? other$includeOutstandingAmount != null : !this$includeOutstandingAmount.equals(other$includeOutstandingAmount)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$entities = this.getEntities();
        final java.lang.Object other$entities = other.getEntities();
        if (this$entities == null ? other$entities != null : !this$entities.equals(other$entities)) return false;
        final java.lang.Object this$loanStatus = this.getLoanStatus();
        final java.lang.Object other$loanStatus = other.getLoanStatus();
        if (this$loanStatus == null ? other$loanStatus != null : !this$loanStatus.equals(other$loanStatus)) return false;
        final java.lang.Object this$loanProducts = this.getLoanProducts();
        final java.lang.Object other$loanProducts = other.getLoanProducts();
        if (this$loanProducts == null ? other$loanProducts != null : !this$loanProducts.equals(other$loanProducts)) return false;
        final java.lang.Object this$offices = this.getOffices();
        final java.lang.Object other$offices = other.getOffices();
        if (this$offices == null ? other$offices != null : !this$offices.equals(other$offices)) return false;
        final java.lang.Object this$loanDateOption = this.getLoanDateOption();
        final java.lang.Object other$loanDateOption = other.getLoanDateOption();
        if (this$loanDateOption == null ? other$loanDateOption != null : !this$loanDateOption.equals(other$loanDateOption)) return false;
        final java.lang.Object this$loanFromDate = this.getLoanFromDate();
        final java.lang.Object other$loanFromDate = other.getLoanFromDate();
        if (this$loanFromDate == null ? other$loanFromDate != null : !this$loanFromDate.equals(other$loanFromDate)) return false;
        final java.lang.Object this$loanToDate = this.getLoanToDate();
        final java.lang.Object other$loanToDate = other.getLoanToDate();
        if (this$loanToDate == null ? other$loanToDate != null : !this$loanToDate.equals(other$loanToDate)) return false;
        final java.lang.Object this$outStandingAmountPercentageCondition = this.getOutStandingAmountPercentageCondition();
        final java.lang.Object other$outStandingAmountPercentageCondition = other.getOutStandingAmountPercentageCondition();
        if (this$outStandingAmountPercentageCondition == null ? other$outStandingAmountPercentageCondition != null : !this$outStandingAmountPercentageCondition.equals(other$outStandingAmountPercentageCondition)) return false;
        final java.lang.Object this$minOutStandingAmountPercentage = this.getMinOutStandingAmountPercentage();
        final java.lang.Object other$minOutStandingAmountPercentage = other.getMinOutStandingAmountPercentage();
        if (this$minOutStandingAmountPercentage == null ? other$minOutStandingAmountPercentage != null : !this$minOutStandingAmountPercentage.equals(other$minOutStandingAmountPercentage)) return false;
        final java.lang.Object this$maxOutStandingAmountPercentage = this.getMaxOutStandingAmountPercentage();
        final java.lang.Object other$maxOutStandingAmountPercentage = other.getMaxOutStandingAmountPercentage();
        if (this$maxOutStandingAmountPercentage == null ? other$maxOutStandingAmountPercentage != null : !this$maxOutStandingAmountPercentage.equals(other$maxOutStandingAmountPercentage)) return false;
        final java.lang.Object this$outStandingAmountPercentage = this.getOutStandingAmountPercentage();
        final java.lang.Object other$outStandingAmountPercentage = other.getOutStandingAmountPercentage();
        if (this$outStandingAmountPercentage == null ? other$outStandingAmountPercentage != null : !this$outStandingAmountPercentage.equals(other$outStandingAmountPercentage)) return false;
        final java.lang.Object this$outstandingAmountCondition = this.getOutstandingAmountCondition();
        final java.lang.Object other$outstandingAmountCondition = other.getOutstandingAmountCondition();
        if (this$outstandingAmountCondition == null ? other$outstandingAmountCondition != null : !this$outstandingAmountCondition.equals(other$outstandingAmountCondition)) return false;
        final java.lang.Object this$minOutstandingAmount = this.getMinOutstandingAmount();
        final java.lang.Object other$minOutstandingAmount = other.getMinOutstandingAmount();
        if (this$minOutstandingAmount == null ? other$minOutstandingAmount != null : !this$minOutstandingAmount.equals(other$minOutstandingAmount)) return false;
        final java.lang.Object this$maxOutstandingAmount = this.getMaxOutstandingAmount();
        final java.lang.Object other$maxOutstandingAmount = other.getMaxOutstandingAmount();
        if (this$maxOutstandingAmount == null ? other$maxOutstandingAmount != null : !this$maxOutstandingAmount.equals(other$maxOutstandingAmount)) return false;
        final java.lang.Object this$outstandingAmount = this.getOutstandingAmount();
        final java.lang.Object other$outstandingAmount = other.getOutstandingAmount();
        if (this$outstandingAmount == null ? other$outstandingAmount != null : !this$outstandingAmount.equals(other$outstandingAmount)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AdHocQuerySearchRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $includeOutStandingAmountPercentage = this.getIncludeOutStandingAmountPercentage();
        result = result * PRIME + ($includeOutStandingAmountPercentage == null ? 43 : $includeOutStandingAmountPercentage.hashCode());
        final java.lang.Object $includeOutstandingAmount = this.getIncludeOutstandingAmount();
        result = result * PRIME + ($includeOutstandingAmount == null ? 43 : $includeOutstandingAmount.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $entities = this.getEntities();
        result = result * PRIME + ($entities == null ? 43 : $entities.hashCode());
        final java.lang.Object $loanStatus = this.getLoanStatus();
        result = result * PRIME + ($loanStatus == null ? 43 : $loanStatus.hashCode());
        final java.lang.Object $loanProducts = this.getLoanProducts();
        result = result * PRIME + ($loanProducts == null ? 43 : $loanProducts.hashCode());
        final java.lang.Object $offices = this.getOffices();
        result = result * PRIME + ($offices == null ? 43 : $offices.hashCode());
        final java.lang.Object $loanDateOption = this.getLoanDateOption();
        result = result * PRIME + ($loanDateOption == null ? 43 : $loanDateOption.hashCode());
        final java.lang.Object $loanFromDate = this.getLoanFromDate();
        result = result * PRIME + ($loanFromDate == null ? 43 : $loanFromDate.hashCode());
        final java.lang.Object $loanToDate = this.getLoanToDate();
        result = result * PRIME + ($loanToDate == null ? 43 : $loanToDate.hashCode());
        final java.lang.Object $outStandingAmountPercentageCondition = this.getOutStandingAmountPercentageCondition();
        result = result * PRIME + ($outStandingAmountPercentageCondition == null ? 43 : $outStandingAmountPercentageCondition.hashCode());
        final java.lang.Object $minOutStandingAmountPercentage = this.getMinOutStandingAmountPercentage();
        result = result * PRIME + ($minOutStandingAmountPercentage == null ? 43 : $minOutStandingAmountPercentage.hashCode());
        final java.lang.Object $maxOutStandingAmountPercentage = this.getMaxOutStandingAmountPercentage();
        result = result * PRIME + ($maxOutStandingAmountPercentage == null ? 43 : $maxOutStandingAmountPercentage.hashCode());
        final java.lang.Object $outStandingAmountPercentage = this.getOutStandingAmountPercentage();
        result = result * PRIME + ($outStandingAmountPercentage == null ? 43 : $outStandingAmountPercentage.hashCode());
        final java.lang.Object $outstandingAmountCondition = this.getOutstandingAmountCondition();
        result = result * PRIME + ($outstandingAmountCondition == null ? 43 : $outstandingAmountCondition.hashCode());
        final java.lang.Object $minOutstandingAmount = this.getMinOutstandingAmount();
        result = result * PRIME + ($minOutstandingAmount == null ? 43 : $minOutstandingAmount.hashCode());
        final java.lang.Object $maxOutstandingAmount = this.getMaxOutstandingAmount();
        result = result * PRIME + ($maxOutstandingAmount == null ? 43 : $maxOutstandingAmount.hashCode());
        final java.lang.Object $outstandingAmount = this.getOutstandingAmount();
        result = result * PRIME + ($outstandingAmount == null ? 43 : $outstandingAmount.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AdHocQuerySearchRequest(locale=" + this.getLocale() + ", dateFormat=" + this.getDateFormat() + ", entities=" + this.getEntities() + ", loanStatus=" + this.getLoanStatus() + ", loanProducts=" + this.getLoanProducts() + ", offices=" + this.getOffices() + ", loanDateOption=" + this.getLoanDateOption() + ", loanFromDate=" + this.getLoanFromDate() + ", loanToDate=" + this.getLoanToDate() + ", includeOutStandingAmountPercentage=" + this.getIncludeOutStandingAmountPercentage() + ", outStandingAmountPercentageCondition=" + this.getOutStandingAmountPercentageCondition() + ", minOutStandingAmountPercentage=" + this.getMinOutStandingAmountPercentage() + ", maxOutStandingAmountPercentage=" + this.getMaxOutStandingAmountPercentage() + ", outStandingAmountPercentage=" + this.getOutStandingAmountPercentage() + ", includeOutstandingAmount=" + this.getIncludeOutstandingAmount() + ", outstandingAmountCondition=" + this.getOutstandingAmountCondition() + ", minOutstandingAmount=" + this.getMinOutstandingAmount() + ", maxOutstandingAmount=" + this.getMaxOutstandingAmount() + ", outstandingAmount=" + this.getOutstandingAmount() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AdHocQuerySearchRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public AdHocQuerySearchRequest(final String locale, final String dateFormat, final List<String> entities, final List<String> loanStatus, final List<Long> loanProducts, final List<Long> offices, final String loanDateOption, final LocalDate loanFromDate, final LocalDate loanToDate, final Boolean includeOutStandingAmountPercentage, final String outStandingAmountPercentageCondition, final BigDecimal minOutStandingAmountPercentage, final BigDecimal maxOutStandingAmountPercentage, final BigDecimal outStandingAmountPercentage, final Boolean includeOutstandingAmount, final String outstandingAmountCondition, final BigDecimal minOutstandingAmount, final BigDecimal maxOutstandingAmount, final BigDecimal outstandingAmount) {
        this.locale = locale;
        this.dateFormat = dateFormat;
        this.entities = entities;
        this.loanStatus = loanStatus;
        this.loanProducts = loanProducts;
        this.offices = offices;
        this.loanDateOption = loanDateOption;
        this.loanFromDate = loanFromDate;
        this.loanToDate = loanToDate;
        this.includeOutStandingAmountPercentage = includeOutStandingAmountPercentage;
        this.outStandingAmountPercentageCondition = outStandingAmountPercentageCondition;
        this.minOutStandingAmountPercentage = minOutStandingAmountPercentage;
        this.maxOutStandingAmountPercentage = maxOutStandingAmountPercentage;
        this.outStandingAmountPercentage = outStandingAmountPercentage;
        this.includeOutstandingAmount = includeOutstandingAmount;
        this.outstandingAmountCondition = outstandingAmountCondition;
        this.minOutstandingAmount = minOutstandingAmount;
        this.maxOutstandingAmount = maxOutstandingAmount;
        this.outstandingAmount = outstandingAmount;
    }
}
