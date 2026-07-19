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
package org.apache.fineract.mix.data;

import java.io.Serial;
import java.io.Serializable;

public class MixTaxonomyMappingUpdateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private String identifier;
    private String config;
    private String currency;


    @java.lang.SuppressWarnings("all")
        public static class MixTaxonomyMappingUpdateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String identifier;
        @java.lang.SuppressWarnings("all")
                private String config;
        @java.lang.SuppressWarnings("all")
                private String currency;

        @java.lang.SuppressWarnings("all")
                MixTaxonomyMappingUpdateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixTaxonomyMappingUpdateRequest.MixTaxonomyMappingUpdateRequestBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixTaxonomyMappingUpdateRequest.MixTaxonomyMappingUpdateRequestBuilder identifier(final String identifier) {
            this.identifier = identifier;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixTaxonomyMappingUpdateRequest.MixTaxonomyMappingUpdateRequestBuilder config(final String config) {
            this.config = config;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixTaxonomyMappingUpdateRequest.MixTaxonomyMappingUpdateRequestBuilder currency(final String currency) {
            this.currency = currency;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public MixTaxonomyMappingUpdateRequest build() {
            return new MixTaxonomyMappingUpdateRequest(this.id, this.identifier, this.config, this.currency);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "MixTaxonomyMappingUpdateRequest.MixTaxonomyMappingUpdateRequestBuilder(id=" + this.id + ", identifier=" + this.identifier + ", config=" + this.config + ", currency=" + this.currency + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static MixTaxonomyMappingUpdateRequest.MixTaxonomyMappingUpdateRequestBuilder builder() {
        return new MixTaxonomyMappingUpdateRequest.MixTaxonomyMappingUpdateRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getIdentifier() {
        return this.identifier;
    }

    @java.lang.SuppressWarnings("all")
        public String getConfig() {
        return this.config;
    }

    @java.lang.SuppressWarnings("all")
        public String getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setIdentifier(final String identifier) {
        this.identifier = identifier;
    }

    @java.lang.SuppressWarnings("all")
        public void setConfig(final String config) {
        this.config = config;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrency(final String currency) {
        this.currency = currency;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof MixTaxonomyMappingUpdateRequest)) return false;
        final MixTaxonomyMappingUpdateRequest other = (MixTaxonomyMappingUpdateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$identifier = this.getIdentifier();
        final java.lang.Object other$identifier = other.getIdentifier();
        if (this$identifier == null ? other$identifier != null : !this$identifier.equals(other$identifier)) return false;
        final java.lang.Object this$config = this.getConfig();
        final java.lang.Object other$config = other.getConfig();
        if (this$config == null ? other$config != null : !this$config.equals(other$config)) return false;
        final java.lang.Object this$currency = this.getCurrency();
        final java.lang.Object other$currency = other.getCurrency();
        if (this$currency == null ? other$currency != null : !this$currency.equals(other$currency)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof MixTaxonomyMappingUpdateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $identifier = this.getIdentifier();
        result = result * PRIME + ($identifier == null ? 43 : $identifier.hashCode());
        final java.lang.Object $config = this.getConfig();
        result = result * PRIME + ($config == null ? 43 : $config.hashCode());
        final java.lang.Object $currency = this.getCurrency();
        result = result * PRIME + ($currency == null ? 43 : $currency.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "MixTaxonomyMappingUpdateRequest(id=" + this.getId() + ", identifier=" + this.getIdentifier() + ", config=" + this.getConfig() + ", currency=" + this.getCurrency() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public MixTaxonomyMappingUpdateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public MixTaxonomyMappingUpdateRequest(final Long id, final String identifier, final String config, final String currency) {
        this.id = id;
        this.identifier = identifier;
        this.config = config;
        this.currency = currency;
    }
}
