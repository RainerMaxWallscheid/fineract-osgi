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
package org.apache.fineract.portfolio.loanproduct.calc.data;

import org.apache.fineract.organisation.monetary.domain.Money;

public class OutstandingDetails {
    private final Money outstandingPrincipal;
    private final Money outstandingInterest;

    @java.lang.SuppressWarnings("all")
        public OutstandingDetails(final Money outstandingPrincipal, final Money outstandingInterest) {
        this.outstandingPrincipal = outstandingPrincipal;
        this.outstandingInterest = outstandingInterest;
    }

    @java.lang.SuppressWarnings("all")
        public Money getOutstandingPrincipal() {
        return this.outstandingPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public Money getOutstandingInterest() {
        return this.outstandingInterest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof OutstandingDetails)) return false;
        final OutstandingDetails other = (OutstandingDetails) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$outstandingPrincipal = this.getOutstandingPrincipal();
        final java.lang.Object other$outstandingPrincipal = other.getOutstandingPrincipal();
        if (this$outstandingPrincipal == null ? other$outstandingPrincipal != null : !this$outstandingPrincipal.equals(other$outstandingPrincipal)) return false;
        final java.lang.Object this$outstandingInterest = this.getOutstandingInterest();
        final java.lang.Object other$outstandingInterest = other.getOutstandingInterest();
        if (this$outstandingInterest == null ? other$outstandingInterest != null : !this$outstandingInterest.equals(other$outstandingInterest)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof OutstandingDetails;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $outstandingPrincipal = this.getOutstandingPrincipal();
        result = result * PRIME + ($outstandingPrincipal == null ? 43 : $outstandingPrincipal.hashCode());
        final java.lang.Object $outstandingInterest = this.getOutstandingInterest();
        result = result * PRIME + ($outstandingInterest == null ? 43 : $outstandingInterest.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "OutstandingDetails(outstandingPrincipal=" + this.getOutstandingPrincipal() + ", outstandingInterest=" + this.getOutstandingInterest() + ")";
    }
}
