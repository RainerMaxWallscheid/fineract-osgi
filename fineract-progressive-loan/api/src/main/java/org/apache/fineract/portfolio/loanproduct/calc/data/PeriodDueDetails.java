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

public class PeriodDueDetails {
    private final Money emi;
    private final Money duePrincipal;
    private final Money dueInterest;

    @java.lang.SuppressWarnings("all")
        public PeriodDueDetails(final Money emi, final Money duePrincipal, final Money dueInterest) {
        this.emi = emi;
        this.duePrincipal = duePrincipal;
        this.dueInterest = dueInterest;
    }

    @java.lang.SuppressWarnings("all")
        public Money getEmi() {
        return this.emi;
    }

    @java.lang.SuppressWarnings("all")
        public Money getDuePrincipal() {
        return this.duePrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public Money getDueInterest() {
        return this.dueInterest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof PeriodDueDetails)) return false;
        final PeriodDueDetails other = (PeriodDueDetails) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$emi = this.getEmi();
        final java.lang.Object other$emi = other.getEmi();
        if (this$emi == null ? other$emi != null : !this$emi.equals(other$emi)) return false;
        final java.lang.Object this$duePrincipal = this.getDuePrincipal();
        final java.lang.Object other$duePrincipal = other.getDuePrincipal();
        if (this$duePrincipal == null ? other$duePrincipal != null : !this$duePrincipal.equals(other$duePrincipal)) return false;
        final java.lang.Object this$dueInterest = this.getDueInterest();
        final java.lang.Object other$dueInterest = other.getDueInterest();
        if (this$dueInterest == null ? other$dueInterest != null : !this$dueInterest.equals(other$dueInterest)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof PeriodDueDetails;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $emi = this.getEmi();
        result = result * PRIME + ($emi == null ? 43 : $emi.hashCode());
        final java.lang.Object $duePrincipal = this.getDuePrincipal();
        result = result * PRIME + ($duePrincipal == null ? 43 : $duePrincipal.hashCode());
        final java.lang.Object $dueInterest = this.getDueInterest();
        result = result * PRIME + ($dueInterest == null ? 43 : $dueInterest.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "PeriodDueDetails(emi=" + this.getEmi() + ", duePrincipal=" + this.getDuePrincipal() + ", dueInterest=" + this.getDueInterest() + ")";
    }
}
