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
package org.apache.fineract.portfolio.collateralmanagement.data;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;

public class CollateralProductCreateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @NotBlank
    private String name;
    @NotBlank
    private String quality;
    @NotNull
    @Positive
    private BigDecimal basePrice;
    @NotNull
    @Positive
    private BigDecimal pctToBase;
    @NotBlank
    private String unitType;
    @NotBlank
    private String currency;
    @NotBlank
    private String locale;


    @java.lang.SuppressWarnings("all")
        public static class CollateralProductCreateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private String quality;
        @java.lang.SuppressWarnings("all")
                private BigDecimal basePrice;
        @java.lang.SuppressWarnings("all")
                private BigDecimal pctToBase;
        @java.lang.SuppressWarnings("all")
                private String unitType;
        @java.lang.SuppressWarnings("all")
                private String currency;
        @java.lang.SuppressWarnings("all")
                private String locale;

        @java.lang.SuppressWarnings("all")
                CollateralProductCreateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollateralProductCreateRequest.CollateralProductCreateRequestBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollateralProductCreateRequest.CollateralProductCreateRequestBuilder quality(final String quality) {
            this.quality = quality;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollateralProductCreateRequest.CollateralProductCreateRequestBuilder basePrice(final BigDecimal basePrice) {
            this.basePrice = basePrice;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollateralProductCreateRequest.CollateralProductCreateRequestBuilder pctToBase(final BigDecimal pctToBase) {
            this.pctToBase = pctToBase;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollateralProductCreateRequest.CollateralProductCreateRequestBuilder unitType(final String unitType) {
            this.unitType = unitType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollateralProductCreateRequest.CollateralProductCreateRequestBuilder currency(final String currency) {
            this.currency = currency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollateralProductCreateRequest.CollateralProductCreateRequestBuilder locale(final String locale) {
            this.locale = locale;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public CollateralProductCreateRequest build() {
            return new CollateralProductCreateRequest(this.name, this.quality, this.basePrice, this.pctToBase, this.unitType, this.currency, this.locale);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "CollateralProductCreateRequest.CollateralProductCreateRequestBuilder(name=" + this.name + ", quality=" + this.quality + ", basePrice=" + this.basePrice + ", pctToBase=" + this.pctToBase + ", unitType=" + this.unitType + ", currency=" + this.currency + ", locale=" + this.locale + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static CollateralProductCreateRequest.CollateralProductCreateRequestBuilder builder() {
        return new CollateralProductCreateRequest.CollateralProductCreateRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getQuality() {
        return this.quality;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getBasePrice() {
        return this.basePrice;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPctToBase() {
        return this.pctToBase;
    }

    @java.lang.SuppressWarnings("all")
        public String getUnitType() {
        return this.unitType;
    }

    @java.lang.SuppressWarnings("all")
        public String getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setQuality(final String quality) {
        this.quality = quality;
    }

    @java.lang.SuppressWarnings("all")
        public void setBasePrice(final BigDecimal basePrice) {
        this.basePrice = basePrice;
    }

    @java.lang.SuppressWarnings("all")
        public void setPctToBase(final BigDecimal pctToBase) {
        this.pctToBase = pctToBase;
    }

    @java.lang.SuppressWarnings("all")
        public void setUnitType(final String unitType) {
        this.unitType = unitType;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrency(final String currency) {
        this.currency = currency;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CollateralProductCreateRequest)) return false;
        final CollateralProductCreateRequest other = (CollateralProductCreateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$quality = this.getQuality();
        final java.lang.Object other$quality = other.getQuality();
        if (this$quality == null ? other$quality != null : !this$quality.equals(other$quality)) return false;
        final java.lang.Object this$basePrice = this.getBasePrice();
        final java.lang.Object other$basePrice = other.getBasePrice();
        if (this$basePrice == null ? other$basePrice != null : !this$basePrice.equals(other$basePrice)) return false;
        final java.lang.Object this$pctToBase = this.getPctToBase();
        final java.lang.Object other$pctToBase = other.getPctToBase();
        if (this$pctToBase == null ? other$pctToBase != null : !this$pctToBase.equals(other$pctToBase)) return false;
        final java.lang.Object this$unitType = this.getUnitType();
        final java.lang.Object other$unitType = other.getUnitType();
        if (this$unitType == null ? other$unitType != null : !this$unitType.equals(other$unitType)) return false;
        final java.lang.Object this$currency = this.getCurrency();
        final java.lang.Object other$currency = other.getCurrency();
        if (this$currency == null ? other$currency != null : !this$currency.equals(other$currency)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof CollateralProductCreateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $quality = this.getQuality();
        result = result * PRIME + ($quality == null ? 43 : $quality.hashCode());
        final java.lang.Object $basePrice = this.getBasePrice();
        result = result * PRIME + ($basePrice == null ? 43 : $basePrice.hashCode());
        final java.lang.Object $pctToBase = this.getPctToBase();
        result = result * PRIME + ($pctToBase == null ? 43 : $pctToBase.hashCode());
        final java.lang.Object $unitType = this.getUnitType();
        result = result * PRIME + ($unitType == null ? 43 : $unitType.hashCode());
        final java.lang.Object $currency = this.getCurrency();
        result = result * PRIME + ($currency == null ? 43 : $currency.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CollateralProductCreateRequest(name=" + this.getName() + ", quality=" + this.getQuality() + ", basePrice=" + this.getBasePrice() + ", pctToBase=" + this.getPctToBase() + ", unitType=" + this.getUnitType() + ", currency=" + this.getCurrency() + ", locale=" + this.getLocale() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CollateralProductCreateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public CollateralProductCreateRequest(final String name, final String quality, final BigDecimal basePrice, final BigDecimal pctToBase, final String unitType, final String currency, final String locale) {
        this.name = name;
        this.quality = quality;
        this.basePrice = basePrice;
        this.pctToBase = pctToBase;
        this.unitType = unitType;
        this.currency = currency;
        this.locale = locale;
    }
}
