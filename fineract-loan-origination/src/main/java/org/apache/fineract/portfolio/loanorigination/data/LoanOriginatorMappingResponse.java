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
package org.apache.fineract.portfolio.loanorigination.data;

import java.io.Serial;
import java.io.Serializable;

public class LoanOriginatorMappingResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long loanId;
    private String loanExternalId;
    private Long originatorId;
    private String originatorExternalId;

    public static LoanOriginatorMappingResponse of(Long loanId, String loanExternalId, Long originatorId, String originatorExternalId) {
        return LoanOriginatorMappingResponse.builder().loanId(loanId).loanExternalId(loanExternalId).originatorId(originatorId).originatorExternalId(originatorExternalId).build();
    }


    @java.lang.SuppressWarnings("all")
        public static class LoanOriginatorMappingResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private Long loanId;
        @java.lang.SuppressWarnings("all")
                private String loanExternalId;
        @java.lang.SuppressWarnings("all")
                private Long originatorId;
        @java.lang.SuppressWarnings("all")
                private String originatorExternalId;

        @java.lang.SuppressWarnings("all")
                LoanOriginatorMappingResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanOriginatorMappingResponse.LoanOriginatorMappingResponseBuilder loanId(final Long loanId) {
            this.loanId = loanId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanOriginatorMappingResponse.LoanOriginatorMappingResponseBuilder loanExternalId(final String loanExternalId) {
            this.loanExternalId = loanExternalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanOriginatorMappingResponse.LoanOriginatorMappingResponseBuilder originatorId(final Long originatorId) {
            this.originatorId = originatorId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public LoanOriginatorMappingResponse.LoanOriginatorMappingResponseBuilder originatorExternalId(final String originatorExternalId) {
            this.originatorExternalId = originatorExternalId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public LoanOriginatorMappingResponse build() {
            return new LoanOriginatorMappingResponse(this.loanId, this.loanExternalId, this.originatorId, this.originatorExternalId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "LoanOriginatorMappingResponse.LoanOriginatorMappingResponseBuilder(loanId=" + this.loanId + ", loanExternalId=" + this.loanExternalId + ", originatorId=" + this.originatorId + ", originatorExternalId=" + this.originatorExternalId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static LoanOriginatorMappingResponse.LoanOriginatorMappingResponseBuilder builder() {
        return new LoanOriginatorMappingResponse.LoanOriginatorMappingResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public String getLoanExternalId() {
        return this.loanExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOriginatorId() {
        return this.originatorId;
    }

    @java.lang.SuppressWarnings("all")
        public String getOriginatorExternalId() {
        return this.originatorExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanId(final Long loanId) {
        this.loanId = loanId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanExternalId(final String loanExternalId) {
        this.loanExternalId = loanExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setOriginatorId(final Long originatorId) {
        this.originatorId = originatorId;
    }

    @java.lang.SuppressWarnings("all")
        public void setOriginatorExternalId(final String originatorExternalId) {
        this.originatorExternalId = originatorExternalId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanOriginatorMappingResponse)) return false;
        final LoanOriginatorMappingResponse other = (LoanOriginatorMappingResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$loanId = this.getLoanId();
        final java.lang.Object other$loanId = other.getLoanId();
        if (this$loanId == null ? other$loanId != null : !this$loanId.equals(other$loanId)) return false;
        final java.lang.Object this$originatorId = this.getOriginatorId();
        final java.lang.Object other$originatorId = other.getOriginatorId();
        if (this$originatorId == null ? other$originatorId != null : !this$originatorId.equals(other$originatorId)) return false;
        final java.lang.Object this$loanExternalId = this.getLoanExternalId();
        final java.lang.Object other$loanExternalId = other.getLoanExternalId();
        if (this$loanExternalId == null ? other$loanExternalId != null : !this$loanExternalId.equals(other$loanExternalId)) return false;
        final java.lang.Object this$originatorExternalId = this.getOriginatorExternalId();
        final java.lang.Object other$originatorExternalId = other.getOriginatorExternalId();
        if (this$originatorExternalId == null ? other$originatorExternalId != null : !this$originatorExternalId.equals(other$originatorExternalId)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanOriginatorMappingResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $loanId = this.getLoanId();
        result = result * PRIME + ($loanId == null ? 43 : $loanId.hashCode());
        final java.lang.Object $originatorId = this.getOriginatorId();
        result = result * PRIME + ($originatorId == null ? 43 : $originatorId.hashCode());
        final java.lang.Object $loanExternalId = this.getLoanExternalId();
        result = result * PRIME + ($loanExternalId == null ? 43 : $loanExternalId.hashCode());
        final java.lang.Object $originatorExternalId = this.getOriginatorExternalId();
        result = result * PRIME + ($originatorExternalId == null ? 43 : $originatorExternalId.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanOriginatorMappingResponse(loanId=" + this.getLoanId() + ", loanExternalId=" + this.getLoanExternalId() + ", originatorId=" + this.getOriginatorId() + ", originatorExternalId=" + this.getOriginatorExternalId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanOriginatorMappingResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public LoanOriginatorMappingResponse(final Long loanId, final String loanExternalId, final Long originatorId, final String originatorExternalId) {
        this.loanId = loanId;
        this.loanExternalId = loanExternalId;
        this.originatorId = originatorId;
        this.originatorExternalId = originatorExternalId;
    }
}
