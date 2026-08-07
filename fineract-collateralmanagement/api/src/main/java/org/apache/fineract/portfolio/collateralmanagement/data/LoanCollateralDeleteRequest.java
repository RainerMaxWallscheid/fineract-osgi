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

import io.swagger.v3.oas.annotations.Hidden;
import java.io.Serial;
import java.io.Serializable;

public class LoanCollateralDeleteRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Hidden
    private Long id;
    @Hidden
    private Long loanId;


    @java.lang.SuppressWarnings("all")
        public static class LoanCollateralDeleteRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private Long loanId;

        @java.lang.SuppressWarnings("all")
                LoanCollateralDeleteRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanCollateralDeleteRequest.LoanCollateralDeleteRequestBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanCollateralDeleteRequest.LoanCollateralDeleteRequestBuilder loanId(final Long loanId) {
            this.loanId = loanId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public LoanCollateralDeleteRequest build() {
            return new LoanCollateralDeleteRequest(this.id, this.loanId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "LoanCollateralDeleteRequest.LoanCollateralDeleteRequestBuilder(id=" + this.id + ", loanId=" + this.loanId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static LoanCollateralDeleteRequest.LoanCollateralDeleteRequestBuilder builder() {
        return new LoanCollateralDeleteRequest.LoanCollateralDeleteRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanId(final Long loanId) {
        this.loanId = loanId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanCollateralDeleteRequest)) return false;
        final LoanCollateralDeleteRequest other = (LoanCollateralDeleteRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$loanId = this.getLoanId();
        final java.lang.Object other$loanId = other.getLoanId();
        if (this$loanId == null ? other$loanId != null : !this$loanId.equals(other$loanId)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanCollateralDeleteRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $loanId = this.getLoanId();
        result = result * PRIME + ($loanId == null ? 43 : $loanId.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanCollateralDeleteRequest(id=" + this.getId() + ", loanId=" + this.getLoanId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanCollateralDeleteRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public LoanCollateralDeleteRequest(final Long id, final Long loanId) {
        this.id = id;
        this.loanId = loanId;
    }
}
