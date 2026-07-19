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
package org.apache.fineract.cob.data;

import com.fasterxml.jackson.annotation.JsonTypeInfo;

@JsonTypeInfo(use = JsonTypeInfo.Id.CLASS)
@Deprecated
public class LoanCOBParameter {
    private Long minLoanId;
    private Long maxLoanId;

    public COBParameter toCOBParameter() {
        return new COBParameter(this.minLoanId, this.maxLoanId);
    }

    @java.lang.SuppressWarnings("all")
        public LoanCOBParameter(final Long minLoanId, final Long maxLoanId) {
        this.minLoanId = minLoanId;
        this.maxLoanId = maxLoanId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getMinLoanId() {
        return this.minLoanId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getMaxLoanId() {
        return this.maxLoanId;
    }

    @java.lang.SuppressWarnings("all")
        public LoanCOBParameter() {
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanCOBParameter)) return false;
        final LoanCOBParameter other = (LoanCOBParameter) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$minLoanId = this.getMinLoanId();
        final java.lang.Object other$minLoanId = other.getMinLoanId();
        if (this$minLoanId == null ? other$minLoanId != null : !this$minLoanId.equals(other$minLoanId)) return false;
        final java.lang.Object this$maxLoanId = this.getMaxLoanId();
        final java.lang.Object other$maxLoanId = other.getMaxLoanId();
        if (this$maxLoanId == null ? other$maxLoanId != null : !this$maxLoanId.equals(other$maxLoanId)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanCOBParameter;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $minLoanId = this.getMinLoanId();
        result = result * PRIME + ($minLoanId == null ? 43 : $minLoanId.hashCode());
        final java.lang.Object $maxLoanId = this.getMaxLoanId();
        result = result * PRIME + ($maxLoanId == null ? 43 : $maxLoanId.hashCode());
        return result;
    }
}
