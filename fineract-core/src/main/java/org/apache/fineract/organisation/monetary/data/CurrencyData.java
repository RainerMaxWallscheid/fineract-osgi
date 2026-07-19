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
package org.apache.fineract.organisation.monetary.data;

import java.io.Serial;
import java.io.Serializable;

public class CurrencyData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String code;
    private String name;
    private int decimalPlaces;
    private Integer inMultiplesOf;
    private String displaySymbol;
    private String nameCode;
    private String displayLabel;

    public static CurrencyData blank() {
        return new CurrencyData("", "", 0, 0, "", "");
    }

    public CurrencyData(String code) {
        this.code = code;
        this.name = null;
        this.decimalPlaces = 0;
        this.inMultiplesOf = null;
        this.displaySymbol = null;
        this.nameCode = null;
        this.displayLabel = null;
    }

    public CurrencyData(final String code, final String name, final int decimalPlaces, final Integer inMultiplesOf, final String displaySymbol, final String nameCode) {
        this.code = code;
        this.name = name;
        this.decimalPlaces = decimalPlaces;
        this.inMultiplesOf = inMultiplesOf;
        this.displaySymbol = displaySymbol;
        this.nameCode = nameCode;
        this.displayLabel = generateDisplayLabel();
    }

    public CurrencyData(final String code, final int decimalPlaces, final Integer inMultiplesOf) {
        this.code = code;
        this.name = null;
        this.decimalPlaces = decimalPlaces;
        this.inMultiplesOf = inMultiplesOf;
        this.displaySymbol = null;
        this.nameCode = null;
        this.displayLabel = null;
    }

    private String generateDisplayLabel() {
        final StringBuilder builder = new StringBuilder(20);
        if (this.name != null) {
            builder.append(this.name).append(' ');
        }
        if (this.displaySymbol != null && !"".equalsIgnoreCase(this.displaySymbol.trim())) {
            builder.append('(').append(this.displaySymbol).append(')');
        } else {
            builder.append('[').append(this.code).append(']');
        }
        return builder.toString();
    }


    @java.lang.SuppressWarnings("all")
        public static class CurrencyDataBuilder {
        @java.lang.SuppressWarnings("all")
                private String code;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private int decimalPlaces;
        @java.lang.SuppressWarnings("all")
                private Integer inMultiplesOf;
        @java.lang.SuppressWarnings("all")
                private String displaySymbol;
        @java.lang.SuppressWarnings("all")
                private String nameCode;
        @java.lang.SuppressWarnings("all")
                private String displayLabel;

        @java.lang.SuppressWarnings("all")
                CurrencyDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CurrencyData.CurrencyDataBuilder code(final String code) {
            this.code = code;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CurrencyData.CurrencyDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CurrencyData.CurrencyDataBuilder decimalPlaces(final int decimalPlaces) {
            this.decimalPlaces = decimalPlaces;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CurrencyData.CurrencyDataBuilder inMultiplesOf(final Integer inMultiplesOf) {
            this.inMultiplesOf = inMultiplesOf;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CurrencyData.CurrencyDataBuilder displaySymbol(final String displaySymbol) {
            this.displaySymbol = displaySymbol;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CurrencyData.CurrencyDataBuilder nameCode(final String nameCode) {
            this.nameCode = nameCode;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CurrencyData.CurrencyDataBuilder displayLabel(final String displayLabel) {
            this.displayLabel = displayLabel;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public CurrencyData build() {
            return new CurrencyData(this.code, this.name, this.decimalPlaces, this.inMultiplesOf, this.displaySymbol, this.nameCode, this.displayLabel);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "CurrencyData.CurrencyDataBuilder(code=" + this.code + ", name=" + this.name + ", decimalPlaces=" + this.decimalPlaces + ", inMultiplesOf=" + this.inMultiplesOf + ", displaySymbol=" + this.displaySymbol + ", nameCode=" + this.nameCode + ", displayLabel=" + this.displayLabel + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static CurrencyData.CurrencyDataBuilder builder() {
        return new CurrencyData.CurrencyDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getCode() {
        return this.code;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public int getDecimalPlaces() {
        return this.decimalPlaces;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getInMultiplesOf() {
        return this.inMultiplesOf;
    }

    @java.lang.SuppressWarnings("all")
        public String getDisplaySymbol() {
        return this.displaySymbol;
    }

    @java.lang.SuppressWarnings("all")
        public String getNameCode() {
        return this.nameCode;
    }

    @java.lang.SuppressWarnings("all")
        public String getDisplayLabel() {
        return this.displayLabel;
    }

    @java.lang.SuppressWarnings("all")
        public void setCode(final String code) {
        this.code = code;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setDecimalPlaces(final int decimalPlaces) {
        this.decimalPlaces = decimalPlaces;
    }

    @java.lang.SuppressWarnings("all")
        public void setInMultiplesOf(final Integer inMultiplesOf) {
        this.inMultiplesOf = inMultiplesOf;
    }

    @java.lang.SuppressWarnings("all")
        public void setDisplaySymbol(final String displaySymbol) {
        this.displaySymbol = displaySymbol;
    }

    @java.lang.SuppressWarnings("all")
        public void setNameCode(final String nameCode) {
        this.nameCode = nameCode;
    }

    @java.lang.SuppressWarnings("all")
        public void setDisplayLabel(final String displayLabel) {
        this.displayLabel = displayLabel;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CurrencyData)) return false;
        final CurrencyData other = (CurrencyData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.getDecimalPlaces() != other.getDecimalPlaces()) return false;
        final java.lang.Object this$inMultiplesOf = this.getInMultiplesOf();
        final java.lang.Object other$inMultiplesOf = other.getInMultiplesOf();
        if (this$inMultiplesOf == null ? other$inMultiplesOf != null : !this$inMultiplesOf.equals(other$inMultiplesOf)) return false;
        final java.lang.Object this$code = this.getCode();
        final java.lang.Object other$code = other.getCode();
        if (this$code == null ? other$code != null : !this$code.equals(other$code)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$displaySymbol = this.getDisplaySymbol();
        final java.lang.Object other$displaySymbol = other.getDisplaySymbol();
        if (this$displaySymbol == null ? other$displaySymbol != null : !this$displaySymbol.equals(other$displaySymbol)) return false;
        final java.lang.Object this$nameCode = this.getNameCode();
        final java.lang.Object other$nameCode = other.getNameCode();
        if (this$nameCode == null ? other$nameCode != null : !this$nameCode.equals(other$nameCode)) return false;
        final java.lang.Object this$displayLabel = this.getDisplayLabel();
        final java.lang.Object other$displayLabel = other.getDisplayLabel();
        if (this$displayLabel == null ? other$displayLabel != null : !this$displayLabel.equals(other$displayLabel)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof CurrencyData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + this.getDecimalPlaces();
        final java.lang.Object $inMultiplesOf = this.getInMultiplesOf();
        result = result * PRIME + ($inMultiplesOf == null ? 43 : $inMultiplesOf.hashCode());
        final java.lang.Object $code = this.getCode();
        result = result * PRIME + ($code == null ? 43 : $code.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $displaySymbol = this.getDisplaySymbol();
        result = result * PRIME + ($displaySymbol == null ? 43 : $displaySymbol.hashCode());
        final java.lang.Object $nameCode = this.getNameCode();
        result = result * PRIME + ($nameCode == null ? 43 : $nameCode.hashCode());
        final java.lang.Object $displayLabel = this.getDisplayLabel();
        result = result * PRIME + ($displayLabel == null ? 43 : $displayLabel.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CurrencyData(code=" + this.getCode() + ", name=" + this.getName() + ", decimalPlaces=" + this.getDecimalPlaces() + ", inMultiplesOf=" + this.getInMultiplesOf() + ", displaySymbol=" + this.getDisplaySymbol() + ", nameCode=" + this.getNameCode() + ", displayLabel=" + this.getDisplayLabel() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData() {
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData(final String code, final String name, final int decimalPlaces, final Integer inMultiplesOf, final String displaySymbol, final String nameCode, final String displayLabel) {
        this.code = code;
        this.name = name;
        this.decimalPlaces = decimalPlaces;
        this.inMultiplesOf = inMultiplesOf;
        this.displaySymbol = displaySymbol;
        this.nameCode = nameCode;
        this.displayLabel = displayLabel;
    }
}
