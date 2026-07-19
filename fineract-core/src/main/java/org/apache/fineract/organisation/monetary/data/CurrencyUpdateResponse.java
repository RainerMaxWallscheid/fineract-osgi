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

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.oas.annotations.media.Schema;
import java.io.Serial;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class CurrencyUpdateResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Schema(example = """
        [
            \"KES\",
            \"BND\",
            \"LBP\",
            \"GHC\",
            \"USD\",
            \"XOF\",
            \"AED\",
            \"AMD\"
        ]
        """)
    private List<String> currencies;

    @Deprecated(forRemoval = true)
    @JsonProperty("changes")
    public Map<String, Object> getChanges() {
        // TODO: remove this one day... we should never use hashmaps in such trivial cases!!!
        return Map.of("currencies", currencies);
    }


    @java.lang.SuppressWarnings("all")
        public static class CurrencyUpdateResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private List<String> currencies;

        @java.lang.SuppressWarnings("all")
                CurrencyUpdateResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CurrencyUpdateResponse.CurrencyUpdateResponseBuilder currencies(final List<String> currencies) {
            this.currencies = currencies;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public CurrencyUpdateResponse build() {
            return new CurrencyUpdateResponse(this.currencies);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "CurrencyUpdateResponse.CurrencyUpdateResponseBuilder(currencies=" + this.currencies + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static CurrencyUpdateResponse.CurrencyUpdateResponseBuilder builder() {
        return new CurrencyUpdateResponse.CurrencyUpdateResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public List<String> getCurrencies() {
        return this.currencies;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrencies(final List<String> currencies) {
        this.currencies = currencies;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CurrencyUpdateResponse)) return false;
        final CurrencyUpdateResponse other = (CurrencyUpdateResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$currencies = this.getCurrencies();
        final java.lang.Object other$currencies = other.getCurrencies();
        if (this$currencies == null ? other$currencies != null : !this$currencies.equals(other$currencies)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof CurrencyUpdateResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $currencies = this.getCurrencies();
        result = result * PRIME + ($currencies == null ? 43 : $currencies.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CurrencyUpdateResponse(currencies=" + this.getCurrencies() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyUpdateResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyUpdateResponse(final List<String> currencies) {
        this.currencies = currencies;
    }
}
