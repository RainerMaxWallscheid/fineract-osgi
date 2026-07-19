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
package org.apache.fineract.portfolio.loanaccount.data;

import java.time.LocalDate;

public class DelinquencyPausePeriod {
    private boolean active;
    private LocalDate pausePeriodStart;
    private LocalDate pausePeriodEnd;

    @java.lang.SuppressWarnings("all")
        public DelinquencyPausePeriod(final boolean active, final LocalDate pausePeriodStart, final LocalDate pausePeriodEnd) {
        this.active = active;
        this.pausePeriodStart = pausePeriodStart;
        this.pausePeriodEnd = pausePeriodEnd;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DelinquencyPausePeriod(active=" + this.isActive() + ", pausePeriodStart=" + this.getPausePeriodStart() + ", pausePeriodEnd=" + this.getPausePeriodEnd() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public boolean isActive() {
        return this.active;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getPausePeriodStart() {
        return this.pausePeriodStart;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getPausePeriodEnd() {
        return this.pausePeriodEnd;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof DelinquencyPausePeriod)) return false;
        final DelinquencyPausePeriod other = (DelinquencyPausePeriod) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isActive() != other.isActive()) return false;
        final java.lang.Object this$pausePeriodStart = this.getPausePeriodStart();
        final java.lang.Object other$pausePeriodStart = other.getPausePeriodStart();
        if (this$pausePeriodStart == null ? other$pausePeriodStart != null : !this$pausePeriodStart.equals(other$pausePeriodStart)) return false;
        final java.lang.Object this$pausePeriodEnd = this.getPausePeriodEnd();
        final java.lang.Object other$pausePeriodEnd = other.getPausePeriodEnd();
        if (this$pausePeriodEnd == null ? other$pausePeriodEnd != null : !this$pausePeriodEnd.equals(other$pausePeriodEnd)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof DelinquencyPausePeriod;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isActive() ? 79 : 97);
        final java.lang.Object $pausePeriodStart = this.getPausePeriodStart();
        result = result * PRIME + ($pausePeriodStart == null ? 43 : $pausePeriodStart.hashCode());
        final java.lang.Object $pausePeriodEnd = this.getPausePeriodEnd();
        result = result * PRIME + ($pausePeriodEnd == null ? 43 : $pausePeriodEnd.hashCode());
        return result;
    }
}
