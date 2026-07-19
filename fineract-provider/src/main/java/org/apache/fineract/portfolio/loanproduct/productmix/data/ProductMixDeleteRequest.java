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
package org.apache.fineract.portfolio.loanproduct.productmix.data;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.io.Serial;
import java.io.Serializable;

public class ProductMixDeleteRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @NotNull
    @Positive
    private Long productId;


    @java.lang.SuppressWarnings("all")
        public static class ProductMixDeleteRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long productId;

        @java.lang.SuppressWarnings("all")
                ProductMixDeleteRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProductMixDeleteRequest.ProductMixDeleteRequestBuilder productId(final Long productId) {
            this.productId = productId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ProductMixDeleteRequest build() {
            return new ProductMixDeleteRequest(this.productId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ProductMixDeleteRequest.ProductMixDeleteRequestBuilder(productId=" + this.productId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ProductMixDeleteRequest.ProductMixDeleteRequestBuilder builder() {
        return new ProductMixDeleteRequest.ProductMixDeleteRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getProductId() {
        return this.productId;
    }

    @java.lang.SuppressWarnings("all")
        public void setProductId(final Long productId) {
        this.productId = productId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ProductMixDeleteRequest)) return false;
        final ProductMixDeleteRequest other = (ProductMixDeleteRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$productId = this.getProductId();
        final java.lang.Object other$productId = other.getProductId();
        if (this$productId == null ? other$productId != null : !this$productId.equals(other$productId)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ProductMixDeleteRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $productId = this.getProductId();
        result = result * PRIME + ($productId == null ? 43 : $productId.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ProductMixDeleteRequest(productId=" + this.getProductId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ProductMixDeleteRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public ProductMixDeleteRequest(final Long productId) {
        this.productId = productId;
    }
}
