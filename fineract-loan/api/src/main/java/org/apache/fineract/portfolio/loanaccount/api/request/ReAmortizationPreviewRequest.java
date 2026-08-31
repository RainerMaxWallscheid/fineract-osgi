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
package org.apache.fineract.portfolio.loanaccount.api.request;

import io.swagger.v3.oas.annotations.Parameter;
import jakarta.validation.constraints.NotBlank;
import jakarta.ws.rs.QueryParam;
import java.io.Serial;
import java.io.Serializable;
import org.apache.fineract.portfolio.loanaccount.domain.reamortization.LoanReAmortizationInterestHandlingType;
import org.apache.fineract.validation.constraints.EnumValue;

public class ReAmortizationPreviewRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @QueryParam("reAmortizationInterestHandling")
    @Parameter(description = "The interest handling type (DEFAULT, WAIVE_INTEREST, EQUAL_AMORTIZATION_INTEREST_SPLIT)", required = true)
    @NotBlank(message = "{org.apache.fineract.reamortization.interest-handling-type.not-blank}")
    @EnumValue(enumClass = LoanReAmortizationInterestHandlingType.class, message = "{org.apache.fineract.interest-handling-type.invalid}")
    private String reAmortizationInterestHandling;


    @java.lang.SuppressWarnings("all")
        public static class ReAmortizationPreviewRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private String reAmortizationInterestHandling;

        @java.lang.SuppressWarnings("all")
                ReAmortizationPreviewRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ReAmortizationPreviewRequest.ReAmortizationPreviewRequestBuilder reAmortizationInterestHandling(final String reAmortizationInterestHandling) {
            this.reAmortizationInterestHandling = reAmortizationInterestHandling;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ReAmortizationPreviewRequest build() {
            return new ReAmortizationPreviewRequest(this.reAmortizationInterestHandling);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ReAmortizationPreviewRequest.ReAmortizationPreviewRequestBuilder(reAmortizationInterestHandling=" + this.reAmortizationInterestHandling + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ReAmortizationPreviewRequest.ReAmortizationPreviewRequestBuilder builder() {
        return new ReAmortizationPreviewRequest.ReAmortizationPreviewRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getReAmortizationInterestHandling() {
        return this.reAmortizationInterestHandling;
    }

    @java.lang.SuppressWarnings("all")
        public void setReAmortizationInterestHandling(final String reAmortizationInterestHandling) {
        this.reAmortizationInterestHandling = reAmortizationInterestHandling;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ReAmortizationPreviewRequest)) return false;
        final ReAmortizationPreviewRequest other = (ReAmortizationPreviewRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$reAmortizationInterestHandling = this.getReAmortizationInterestHandling();
        final java.lang.Object other$reAmortizationInterestHandling = other.getReAmortizationInterestHandling();
        if (this$reAmortizationInterestHandling == null ? other$reAmortizationInterestHandling != null : !this$reAmortizationInterestHandling.equals(other$reAmortizationInterestHandling)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ReAmortizationPreviewRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $reAmortizationInterestHandling = this.getReAmortizationInterestHandling();
        result = result * PRIME + ($reAmortizationInterestHandling == null ? 43 : $reAmortizationInterestHandling.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ReAmortizationPreviewRequest(reAmortizationInterestHandling=" + this.getReAmortizationInterestHandling() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ReAmortizationPreviewRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public ReAmortizationPreviewRequest(final String reAmortizationInterestHandling) {
        this.reAmortizationInterestHandling = reAmortizationInterestHandling;
    }
}
