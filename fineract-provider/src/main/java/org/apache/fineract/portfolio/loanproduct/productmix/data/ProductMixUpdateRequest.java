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
import java.util.List;

public class ProductMixUpdateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long productId;
    @NotNull
    private List<@NotNull @Positive Long> restrictedProducts;


    @java.lang.SuppressWarnings("all")
        public static class ProductMixUpdateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long productId;
        @java.lang.SuppressWarnings("all")
                private List<@NotNull @Positive Long> restrictedProducts;

        @java.lang.SuppressWarnings("all")
                ProductMixUpdateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProductMixUpdateRequest.ProductMixUpdateRequestBuilder productId(final Long productId) {
            this.productId = productId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProductMixUpdateRequest.ProductMixUpdateRequestBuilder restrictedProducts(final List<@NotNull @Positive Long> restrictedProducts) {
            this.restrictedProducts = restrictedProducts;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ProductMixUpdateRequest build() {
            return new ProductMixUpdateRequest(this.productId, this.restrictedProducts);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ProductMixUpdateRequest.ProductMixUpdateRequestBuilder(productId=" + this.productId + ", restrictedProducts=" + this.restrictedProducts + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ProductMixUpdateRequest.ProductMixUpdateRequestBuilder builder() {
        return new ProductMixUpdateRequest.ProductMixUpdateRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getProductId() {
        return this.productId;
    }

    @java.lang.SuppressWarnings("all")
        public List<@NotNull @Positive Long> getRestrictedProducts() {
        return this.restrictedProducts;
    }

    @java.lang.SuppressWarnings("all")
        public void setProductId(final Long productId) {
        this.productId = productId;
    }

    @java.lang.SuppressWarnings("all")
        public void setRestrictedProducts(final List<@NotNull @Positive Long> restrictedProducts) {
        this.restrictedProducts = restrictedProducts;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ProductMixUpdateRequest)) return false;
        final ProductMixUpdateRequest other = (ProductMixUpdateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$productId = this.getProductId();
        final java.lang.Object other$productId = other.getProductId();
        if (this$productId == null ? other$productId != null : !this$productId.equals(other$productId)) return false;
        final java.lang.Object this$restrictedProducts = this.getRestrictedProducts();
        final java.lang.Object other$restrictedProducts = other.getRestrictedProducts();
        if (this$restrictedProducts == null ? other$restrictedProducts != null : !this$restrictedProducts.equals(other$restrictedProducts)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ProductMixUpdateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $productId = this.getProductId();
        result = result * PRIME + ($productId == null ? 43 : $productId.hashCode());
        final java.lang.Object $restrictedProducts = this.getRestrictedProducts();
        result = result * PRIME + ($restrictedProducts == null ? 43 : $restrictedProducts.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ProductMixUpdateRequest(productId=" + this.getProductId() + ", restrictedProducts=" + this.getRestrictedProducts() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ProductMixUpdateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public ProductMixUpdateRequest(final Long productId, final List<@NotNull @Positive Long> restrictedProducts) {
        this.productId = productId;
        this.restrictedProducts = restrictedProducts;
    }
}
