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
import java.util.Map;

public class ProductMixUpdateResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long productId;
    private Map<String, Object> changes;


    @java.lang.SuppressWarnings("all")
        public static class ProductMixUpdateResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private Long productId;
        @java.lang.SuppressWarnings("all")
                private Map<String, Object> changes;

        @java.lang.SuppressWarnings("all")
                ProductMixUpdateResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProductMixUpdateResponse.ProductMixUpdateResponseBuilder productId(final Long productId) {
            this.productId = productId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ProductMixUpdateResponse.ProductMixUpdateResponseBuilder changes(final Map<String, Object> changes) {
            this.changes = changes;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ProductMixUpdateResponse build() {
            return new ProductMixUpdateResponse(this.productId, this.changes);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ProductMixUpdateResponse.ProductMixUpdateResponseBuilder(productId=" + this.productId + ", changes=" + this.changes + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ProductMixUpdateResponse.ProductMixUpdateResponseBuilder builder() {
        return new ProductMixUpdateResponse.ProductMixUpdateResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getProductId() {
        return this.productId;
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, Object> getChanges() {
        return this.changes;
    }

    @java.lang.SuppressWarnings("all")
        public void setProductId(final Long productId) {
        this.productId = productId;
    }

    @java.lang.SuppressWarnings("all")
        public void setChanges(final Map<String, Object> changes) {
        this.changes = changes;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ProductMixUpdateResponse)) return false;
        final ProductMixUpdateResponse other = (ProductMixUpdateResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$productId = this.getProductId();
        final java.lang.Object other$productId = other.getProductId();
        if (this$productId == null ? other$productId != null : !this$productId.equals(other$productId)) return false;
        final java.lang.Object this$changes = this.getChanges();
        final java.lang.Object other$changes = other.getChanges();
        if (this$changes == null ? other$changes != null : !this$changes.equals(other$changes)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ProductMixUpdateResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $productId = this.getProductId();
        result = result * PRIME + ($productId == null ? 43 : $productId.hashCode());
        final java.lang.Object $changes = this.getChanges();
        result = result * PRIME + ($changes == null ? 43 : $changes.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ProductMixUpdateResponse(productId=" + this.getProductId() + ", changes=" + this.getChanges() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ProductMixUpdateResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public ProductMixUpdateResponse(final Long productId, final Map<String, Object> changes) {
        this.productId = productId;
        this.changes = changes;
    }
}
