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
package org.apache.fineract.portfolio.accounts.data.request;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;

public class AccountChargesRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long chargeId;
    private BigDecimal amount;

    @java.lang.SuppressWarnings("all")
        public Long getChargeId() {
        return this.chargeId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargeId(final Long chargeId) {
        this.chargeId = chargeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmount(final BigDecimal amount) {
        this.amount = amount;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AccountChargesRequest)) return false;
        final AccountChargesRequest other = (AccountChargesRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$chargeId = this.getChargeId();
        final java.lang.Object other$chargeId = other.getChargeId();
        if (this$chargeId == null ? other$chargeId != null : !this$chargeId.equals(other$chargeId)) return false;
        final java.lang.Object this$amount = this.getAmount();
        final java.lang.Object other$amount = other.getAmount();
        if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AccountChargesRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $chargeId = this.getChargeId();
        result = result * PRIME + ($chargeId == null ? 43 : $chargeId.hashCode());
        final java.lang.Object $amount = this.getAmount();
        result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AccountChargesRequest(chargeId=" + this.getChargeId() + ", amount=" + this.getAmount() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AccountChargesRequest() {
    }
}
