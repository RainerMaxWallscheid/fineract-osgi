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

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import org.springframework.integration.annotation.Default;

public class LoanChargePaidByData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private BigDecimal amount;
    private Integer installmentNumber;
    private Long chargeId;
    private Long transactionId;
    private String name;

    @Default
    public LoanChargePaidByData(Long id, BigDecimal amount, Integer installmentNumber, Long chargeId, Long transactionId, String name) {
        this.id = id;
        this.amount = amount;
        this.installmentNumber = installmentNumber;
        this.chargeId = chargeId;
        this.transactionId = transactionId;
        this.name = name;
    }

    public LoanChargePaidByData(final Long id, final BigDecimal amount, final Integer installmentNumber, final Long chargeId, final Long transactionId) {
        this.id = id;
        this.amount = amount;
        this.installmentNumber = installmentNumber;
        this.chargeId = chargeId;
        this.transactionId = transactionId;
        this.name = null;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmount(final BigDecimal amount) {
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public void setInstallmentNumber(final Integer installmentNumber) {
        this.installmentNumber = installmentNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargeId(final Long chargeId) {
        this.chargeId = chargeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransactionId(final Long transactionId) {
        this.transactionId = transactionId;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanChargePaidByData)) return false;
        final LoanChargePaidByData other = (LoanChargePaidByData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$installmentNumber = this.getInstallmentNumber();
        final java.lang.Object other$installmentNumber = other.getInstallmentNumber();
        if (this$installmentNumber == null ? other$installmentNumber != null : !this$installmentNumber.equals(other$installmentNumber)) return false;
        final java.lang.Object this$chargeId = this.getChargeId();
        final java.lang.Object other$chargeId = other.getChargeId();
        if (this$chargeId == null ? other$chargeId != null : !this$chargeId.equals(other$chargeId)) return false;
        final java.lang.Object this$transactionId = this.getTransactionId();
        final java.lang.Object other$transactionId = other.getTransactionId();
        if (this$transactionId == null ? other$transactionId != null : !this$transactionId.equals(other$transactionId)) return false;
        final java.lang.Object this$amount = this.getAmount();
        final java.lang.Object other$amount = other.getAmount();
        if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanChargePaidByData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $installmentNumber = this.getInstallmentNumber();
        result = result * PRIME + ($installmentNumber == null ? 43 : $installmentNumber.hashCode());
        final java.lang.Object $chargeId = this.getChargeId();
        result = result * PRIME + ($chargeId == null ? 43 : $chargeId.hashCode());
        final java.lang.Object $transactionId = this.getTransactionId();
        result = result * PRIME + ($transactionId == null ? 43 : $transactionId.hashCode());
        final java.lang.Object $amount = this.getAmount();
        result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanChargePaidByData(id=" + this.getId() + ", amount=" + this.getAmount() + ", installmentNumber=" + this.getInstallmentNumber() + ", chargeId=" + this.getChargeId() + ", transactionId=" + this.getTransactionId() + ", name=" + this.getName() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getInstallmentNumber() {
        return this.installmentNumber;
    }

    @java.lang.SuppressWarnings("all")
        public Long getChargeId() {
        return this.chargeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getTransactionId() {
        return this.transactionId;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }
}
