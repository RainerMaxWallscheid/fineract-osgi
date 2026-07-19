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
package org.apache.fineract.integrationtests.common.externalevents;

import java.time.format.DateTimeFormatter;
import java.util.Objects;
import org.apache.fineract.infrastructure.event.external.data.ExternalEventResponse;

public class LoanTransactionMinimalBusinessEvent extends BusinessEvent {
    public Double amount;
    public Boolean reversed;

    public LoanTransactionMinimalBusinessEvent(String type, String businessDate, Double amount, Boolean reversed) {
        super(type, businessDate);
        this.amount = amount;
        this.reversed = reversed;
    }

    @Override
    public boolean verify(ExternalEventResponse externalEvent, DateTimeFormatter formatter) {
        Object actualAmount = externalEvent.getPayLoad().get("amount");
        Object actualReversed = externalEvent.getPayLoad().get("reversed");
        return super.verify(externalEvent, formatter) && Objects.equals(actualAmount, getAmount()) && Objects.equals(actualReversed, getReversed());
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanTransactionMinimalBusinessEvent)) return false;
        final LoanTransactionMinimalBusinessEvent other = (LoanTransactionMinimalBusinessEvent) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (!super.equals(o)) return false;
        final java.lang.Object this$amount = this.getAmount();
        final java.lang.Object other$amount = other.getAmount();
        if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
        final java.lang.Object this$reversed = this.getReversed();
        final java.lang.Object other$reversed = other.getReversed();
        if (this$reversed == null ? other$reversed != null : !this$reversed.equals(other$reversed)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanTransactionMinimalBusinessEvent;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = super.hashCode();
        final java.lang.Object $amount = this.getAmount();
        result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
        final java.lang.Object $reversed = this.getReversed();
        result = result * PRIME + ($reversed == null ? 43 : $reversed.hashCode());
        return result;
    }

    @java.lang.SuppressWarnings("all")
        public Double getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getReversed() {
        return this.reversed;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmount(final Double amount) {
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public void setReversed(final Boolean reversed) {
        this.reversed = reversed;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanTransactionMinimalBusinessEvent(amount=" + this.getAmount() + ", reversed=" + this.getReversed() + ")";
    }
}
