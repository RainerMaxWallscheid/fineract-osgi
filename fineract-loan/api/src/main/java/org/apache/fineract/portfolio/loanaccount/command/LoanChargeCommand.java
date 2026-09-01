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
package org.apache.fineract.portfolio.loanaccount.command;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * Java object representation of loan charge API JSON.
 */
public class LoanChargeCommand implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @SuppressWarnings("unused")
    private Long id;
    private Long chargeId;
    private BigDecimal amount;
    @SuppressWarnings("unused")
    private Integer chargeTimeType;
    @SuppressWarnings("unused")
    private Integer chargeCalculationType;
    @SuppressWarnings("unused")
    private LocalDate dueDate;

    @java.lang.SuppressWarnings("all")
        public LoanChargeCommand() {
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getChargeId() {
        return this.chargeId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getChargeTimeType() {
        return this.chargeTimeType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getChargeCalculationType() {
        return this.chargeCalculationType;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDueDate() {
        return this.dueDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargeId(final Long chargeId) {
        this.chargeId = chargeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmount(final BigDecimal amount) {
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargeTimeType(final Integer chargeTimeType) {
        this.chargeTimeType = chargeTimeType;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargeCalculationType(final Integer chargeCalculationType) {
        this.chargeCalculationType = chargeCalculationType;
    }

    @java.lang.SuppressWarnings("all")
        public void setDueDate(final LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanChargeCommand)) return false;
        final LoanChargeCommand other = (LoanChargeCommand) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$chargeId = this.getChargeId();
        final java.lang.Object other$chargeId = other.getChargeId();
        if (this$chargeId == null ? other$chargeId != null : !this$chargeId.equals(other$chargeId)) return false;
        final java.lang.Object this$chargeTimeType = this.getChargeTimeType();
        final java.lang.Object other$chargeTimeType = other.getChargeTimeType();
        if (this$chargeTimeType == null ? other$chargeTimeType != null : !this$chargeTimeType.equals(other$chargeTimeType)) return false;
        final java.lang.Object this$chargeCalculationType = this.getChargeCalculationType();
        final java.lang.Object other$chargeCalculationType = other.getChargeCalculationType();
        if (this$chargeCalculationType == null ? other$chargeCalculationType != null : !this$chargeCalculationType.equals(other$chargeCalculationType)) return false;
        final java.lang.Object this$amount = this.getAmount();
        final java.lang.Object other$amount = other.getAmount();
        if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
        final java.lang.Object this$dueDate = this.getDueDate();
        final java.lang.Object other$dueDate = other.getDueDate();
        if (this$dueDate == null ? other$dueDate != null : !this$dueDate.equals(other$dueDate)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanChargeCommand;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $chargeId = this.getChargeId();
        result = result * PRIME + ($chargeId == null ? 43 : $chargeId.hashCode());
        final java.lang.Object $chargeTimeType = this.getChargeTimeType();
        result = result * PRIME + ($chargeTimeType == null ? 43 : $chargeTimeType.hashCode());
        final java.lang.Object $chargeCalculationType = this.getChargeCalculationType();
        result = result * PRIME + ($chargeCalculationType == null ? 43 : $chargeCalculationType.hashCode());
        final java.lang.Object $amount = this.getAmount();
        result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
        final java.lang.Object $dueDate = this.getDueDate();
        result = result * PRIME + ($dueDate == null ? 43 : $dueDate.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanChargeCommand(id=" + this.getId() + ", chargeId=" + this.getChargeId() + ", amount=" + this.getAmount() + ", chargeTimeType=" + this.getChargeTimeType() + ", chargeCalculationType=" + this.getChargeCalculationType() + ", dueDate=" + this.getDueDate() + ")";
    }
}
