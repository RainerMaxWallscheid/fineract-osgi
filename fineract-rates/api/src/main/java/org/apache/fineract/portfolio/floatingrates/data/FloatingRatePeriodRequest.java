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
package org.apache.fineract.portfolio.floatingrates.data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;

public class FloatingRatePeriodRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String fromDate;
    private BigDecimal interestRate;
    private Boolean isDifferentialToBaseLendingRate;
    private String locale;
    private String dateFormat;

    @java.lang.SuppressWarnings("all")
        public String getFromDate() {
        return this.fromDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestRate() {
        return this.interestRate;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsDifferentialToBaseLendingRate() {
        return this.isDifferentialToBaseLendingRate;
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
        public void setFromDate(final String fromDate) {
        this.fromDate = fromDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setInterestRate(final BigDecimal interestRate) {
        this.interestRate = interestRate;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsDifferentialToBaseLendingRate(final Boolean isDifferentialToBaseLendingRate) {
        this.isDifferentialToBaseLendingRate = isDifferentialToBaseLendingRate;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof FloatingRatePeriodRequest)) return false;
        final FloatingRatePeriodRequest other = (FloatingRatePeriodRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$isDifferentialToBaseLendingRate = this.getIsDifferentialToBaseLendingRate();
        final java.lang.Object other$isDifferentialToBaseLendingRate = other.getIsDifferentialToBaseLendingRate();
        if (this$isDifferentialToBaseLendingRate == null ? other$isDifferentialToBaseLendingRate != null : !this$isDifferentialToBaseLendingRate.equals(other$isDifferentialToBaseLendingRate)) return false;
        final java.lang.Object this$fromDate = this.getFromDate();
        final java.lang.Object other$fromDate = other.getFromDate();
        if (this$fromDate == null ? other$fromDate != null : !this$fromDate.equals(other$fromDate)) return false;
        final java.lang.Object this$interestRate = this.getInterestRate();
        final java.lang.Object other$interestRate = other.getInterestRate();
        if (this$interestRate == null ? other$interestRate != null : !this$interestRate.equals(other$interestRate)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof FloatingRatePeriodRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $isDifferentialToBaseLendingRate = this.getIsDifferentialToBaseLendingRate();
        result = result * PRIME + ($isDifferentialToBaseLendingRate == null ? 43 : $isDifferentialToBaseLendingRate.hashCode());
        final java.lang.Object $fromDate = this.getFromDate();
        result = result * PRIME + ($fromDate == null ? 43 : $fromDate.hashCode());
        final java.lang.Object $interestRate = this.getInterestRate();
        result = result * PRIME + ($interestRate == null ? 43 : $interestRate.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "FloatingRatePeriodRequest(fromDate=" + this.getFromDate() + ", interestRate=" + this.getInterestRate() + ", isDifferentialToBaseLendingRate=" + this.getIsDifferentialToBaseLendingRate() + ", locale=" + this.getLocale() + ", dateFormat=" + this.getDateFormat() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public FloatingRatePeriodRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public FloatingRatePeriodRequest(final String fromDate, final BigDecimal interestRate, final Boolean isDifferentialToBaseLendingRate, final String locale, final String dateFormat) {
        this.fromDate = fromDate;
        this.interestRate = interestRate;
        this.isDifferentialToBaseLendingRate = isDifferentialToBaseLendingRate;
        this.locale = locale;
        this.dateFormat = dateFormat;
    }
}
