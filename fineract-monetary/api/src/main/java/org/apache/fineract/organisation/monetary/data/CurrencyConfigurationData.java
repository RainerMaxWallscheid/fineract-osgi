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
import java.util.List;

public class CurrencyConfigurationData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private List<CurrencyData> selectedCurrencyOptions;
    private List<CurrencyData> currencyOptions;


    @java.lang.SuppressWarnings("all")
        public static class CurrencyConfigurationDataBuilder {
        @java.lang.SuppressWarnings("all")
                private List<CurrencyData> selectedCurrencyOptions;
        @java.lang.SuppressWarnings("all")
                private List<CurrencyData> currencyOptions;

        @java.lang.SuppressWarnings("all")
                CurrencyConfigurationDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CurrencyConfigurationData.CurrencyConfigurationDataBuilder selectedCurrencyOptions(final List<CurrencyData> selectedCurrencyOptions) {
            this.selectedCurrencyOptions = selectedCurrencyOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CurrencyConfigurationData.CurrencyConfigurationDataBuilder currencyOptions(final List<CurrencyData> currencyOptions) {
            this.currencyOptions = currencyOptions;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public CurrencyConfigurationData build() {
            return new CurrencyConfigurationData(this.selectedCurrencyOptions, this.currencyOptions);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "CurrencyConfigurationData.CurrencyConfigurationDataBuilder(selectedCurrencyOptions=" + this.selectedCurrencyOptions + ", currencyOptions=" + this.currencyOptions + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static CurrencyConfigurationData.CurrencyConfigurationDataBuilder builder() {
        return new CurrencyConfigurationData.CurrencyConfigurationDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public List<CurrencyData> getSelectedCurrencyOptions() {
        return this.selectedCurrencyOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<CurrencyData> getCurrencyOptions() {
        return this.currencyOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setSelectedCurrencyOptions(final List<CurrencyData> selectedCurrencyOptions) {
        this.selectedCurrencyOptions = selectedCurrencyOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrencyOptions(final List<CurrencyData> currencyOptions) {
        this.currencyOptions = currencyOptions;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CurrencyConfigurationData)) return false;
        final CurrencyConfigurationData other = (CurrencyConfigurationData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$selectedCurrencyOptions = this.getSelectedCurrencyOptions();
        final java.lang.Object other$selectedCurrencyOptions = other.getSelectedCurrencyOptions();
        if (this$selectedCurrencyOptions == null ? other$selectedCurrencyOptions != null : !this$selectedCurrencyOptions.equals(other$selectedCurrencyOptions)) return false;
        final java.lang.Object this$currencyOptions = this.getCurrencyOptions();
        final java.lang.Object other$currencyOptions = other.getCurrencyOptions();
        if (this$currencyOptions == null ? other$currencyOptions != null : !this$currencyOptions.equals(other$currencyOptions)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof CurrencyConfigurationData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $selectedCurrencyOptions = this.getSelectedCurrencyOptions();
        result = result * PRIME + ($selectedCurrencyOptions == null ? 43 : $selectedCurrencyOptions.hashCode());
        final java.lang.Object $currencyOptions = this.getCurrencyOptions();
        result = result * PRIME + ($currencyOptions == null ? 43 : $currencyOptions.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CurrencyConfigurationData(selectedCurrencyOptions=" + this.getSelectedCurrencyOptions() + ", currencyOptions=" + this.getCurrencyOptions() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyConfigurationData() {
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyConfigurationData(final List<CurrencyData> selectedCurrencyOptions, final List<CurrencyData> currencyOptions) {
        this.selectedCurrencyOptions = selectedCurrencyOptions;
        this.currencyOptions = currencyOptions;
    }
}
