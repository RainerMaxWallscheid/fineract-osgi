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

import java.io.Serial;
import java.io.Serializable;
import java.util.Collection;
import org.apache.fineract.portfolio.loanproduct.data.LoanProductData;

public class ProductMixData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long productId;
    private String productName;
    private Collection<LoanProductData> restrictedProducts;
    private Collection<LoanProductData> allowedProducts;
    private Collection<LoanProductData> productOptions;


    @java.lang.SuppressWarnings("all")
        public static class ProductMixDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long productId;
        @java.lang.SuppressWarnings("all")
                private String productName;
        @java.lang.SuppressWarnings("all")
                private Collection<LoanProductData> restrictedProducts;
        @java.lang.SuppressWarnings("all")
                private Collection<LoanProductData> allowedProducts;
        @java.lang.SuppressWarnings("all")
                private Collection<LoanProductData> productOptions;

        @java.lang.SuppressWarnings("all")
                ProductMixDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProductMixData.ProductMixDataBuilder productId(final Long productId) {
            this.productId = productId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProductMixData.ProductMixDataBuilder productName(final String productName) {
            this.productName = productName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProductMixData.ProductMixDataBuilder restrictedProducts(final Collection<LoanProductData> restrictedProducts) {
            this.restrictedProducts = restrictedProducts;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProductMixData.ProductMixDataBuilder allowedProducts(final Collection<LoanProductData> allowedProducts) {
            this.allowedProducts = allowedProducts;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProductMixData.ProductMixDataBuilder productOptions(final Collection<LoanProductData> productOptions) {
            this.productOptions = productOptions;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ProductMixData build() {
            return new ProductMixData(this.productId, this.productName, this.restrictedProducts, this.allowedProducts, this.productOptions);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ProductMixData.ProductMixDataBuilder(productId=" + this.productId + ", productName=" + this.productName + ", restrictedProducts=" + this.restrictedProducts + ", allowedProducts=" + this.allowedProducts + ", productOptions=" + this.productOptions + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ProductMixData.ProductMixDataBuilder builder() {
        return new ProductMixData.ProductMixDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getProductId() {
        return this.productId;
    }

    @java.lang.SuppressWarnings("all")
        public String getProductName() {
        return this.productName;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LoanProductData> getRestrictedProducts() {
        return this.restrictedProducts;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LoanProductData> getAllowedProducts() {
        return this.allowedProducts;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LoanProductData> getProductOptions() {
        return this.productOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setProductId(final Long productId) {
        this.productId = productId;
    }

    @java.lang.SuppressWarnings("all")
        public void setProductName(final String productName) {
        this.productName = productName;
    }

    @java.lang.SuppressWarnings("all")
        public void setRestrictedProducts(final Collection<LoanProductData> restrictedProducts) {
        this.restrictedProducts = restrictedProducts;
    }

    @java.lang.SuppressWarnings("all")
        public void setAllowedProducts(final Collection<LoanProductData> allowedProducts) {
        this.allowedProducts = allowedProducts;
    }

    @java.lang.SuppressWarnings("all")
        public void setProductOptions(final Collection<LoanProductData> productOptions) {
        this.productOptions = productOptions;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ProductMixData)) return false;
        final ProductMixData other = (ProductMixData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$productId = this.getProductId();
        final java.lang.Object other$productId = other.getProductId();
        if (this$productId == null ? other$productId != null : !this$productId.equals(other$productId)) return false;
        final java.lang.Object this$productName = this.getProductName();
        final java.lang.Object other$productName = other.getProductName();
        if (this$productName == null ? other$productName != null : !this$productName.equals(other$productName)) return false;
        final java.lang.Object this$restrictedProducts = this.getRestrictedProducts();
        final java.lang.Object other$restrictedProducts = other.getRestrictedProducts();
        if (this$restrictedProducts == null ? other$restrictedProducts != null : !this$restrictedProducts.equals(other$restrictedProducts)) return false;
        final java.lang.Object this$allowedProducts = this.getAllowedProducts();
        final java.lang.Object other$allowedProducts = other.getAllowedProducts();
        if (this$allowedProducts == null ? other$allowedProducts != null : !this$allowedProducts.equals(other$allowedProducts)) return false;
        final java.lang.Object this$productOptions = this.getProductOptions();
        final java.lang.Object other$productOptions = other.getProductOptions();
        if (this$productOptions == null ? other$productOptions != null : !this$productOptions.equals(other$productOptions)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ProductMixData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $productId = this.getProductId();
        result = result * PRIME + ($productId == null ? 43 : $productId.hashCode());
        final java.lang.Object $productName = this.getProductName();
        result = result * PRIME + ($productName == null ? 43 : $productName.hashCode());
        final java.lang.Object $restrictedProducts = this.getRestrictedProducts();
        result = result * PRIME + ($restrictedProducts == null ? 43 : $restrictedProducts.hashCode());
        final java.lang.Object $allowedProducts = this.getAllowedProducts();
        result = result * PRIME + ($allowedProducts == null ? 43 : $allowedProducts.hashCode());
        final java.lang.Object $productOptions = this.getProductOptions();
        result = result * PRIME + ($productOptions == null ? 43 : $productOptions.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ProductMixData(productId=" + this.getProductId() + ", productName=" + this.getProductName() + ", restrictedProducts=" + this.getRestrictedProducts() + ", allowedProducts=" + this.getAllowedProducts() + ", productOptions=" + this.getProductOptions() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ProductMixData() {
    }

    @java.lang.SuppressWarnings("all")
        public ProductMixData(final Long productId, final String productName, final Collection<LoanProductData> restrictedProducts, final Collection<LoanProductData> allowedProducts, final Collection<LoanProductData> productOptions) {
        this.productId = productId;
        this.productName = productName;
        this.restrictedProducts = restrictedProducts;
        this.allowedProducts = allowedProducts;
        this.productOptions = productOptions;
    }
}
