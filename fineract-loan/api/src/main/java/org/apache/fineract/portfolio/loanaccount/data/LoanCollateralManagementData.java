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

import java.math.BigDecimal;

public class LoanCollateralManagementData {
    private Long clientCollateralId;
    private BigDecimal quantity;
    private BigDecimal total;
    private BigDecimal totalCollateral;
    private Long id;

    @java.lang.SuppressWarnings("all")
        public Long getClientCollateralId() {
        return this.clientCollateralId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getQuantity() {
        return this.quantity;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotal() {
        return this.total;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalCollateral() {
        return this.totalCollateral;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientCollateralId(final Long clientCollateralId) {
        this.clientCollateralId = clientCollateralId;
    }

    @java.lang.SuppressWarnings("all")
        public void setQuantity(final BigDecimal quantity) {
        this.quantity = quantity;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotal(final BigDecimal total) {
        this.total = total;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalCollateral(final BigDecimal totalCollateral) {
        this.totalCollateral = totalCollateral;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanCollateralManagementData)) return false;
        final LoanCollateralManagementData other = (LoanCollateralManagementData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$clientCollateralId = this.getClientCollateralId();
        final java.lang.Object other$clientCollateralId = other.getClientCollateralId();
        if (this$clientCollateralId == null ? other$clientCollateralId != null : !this$clientCollateralId.equals(other$clientCollateralId)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$quantity = this.getQuantity();
        final java.lang.Object other$quantity = other.getQuantity();
        if (this$quantity == null ? other$quantity != null : !this$quantity.equals(other$quantity)) return false;
        final java.lang.Object this$total = this.getTotal();
        final java.lang.Object other$total = other.getTotal();
        if (this$total == null ? other$total != null : !this$total.equals(other$total)) return false;
        final java.lang.Object this$totalCollateral = this.getTotalCollateral();
        final java.lang.Object other$totalCollateral = other.getTotalCollateral();
        if (this$totalCollateral == null ? other$totalCollateral != null : !this$totalCollateral.equals(other$totalCollateral)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanCollateralManagementData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $clientCollateralId = this.getClientCollateralId();
        result = result * PRIME + ($clientCollateralId == null ? 43 : $clientCollateralId.hashCode());
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $quantity = this.getQuantity();
        result = result * PRIME + ($quantity == null ? 43 : $quantity.hashCode());
        final java.lang.Object $total = this.getTotal();
        result = result * PRIME + ($total == null ? 43 : $total.hashCode());
        final java.lang.Object $totalCollateral = this.getTotalCollateral();
        result = result * PRIME + ($totalCollateral == null ? 43 : $totalCollateral.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanCollateralManagementData(clientCollateralId=" + this.getClientCollateralId() + ", quantity=" + this.getQuantity() + ", total=" + this.getTotal() + ", totalCollateral=" + this.getTotalCollateral() + ", id=" + this.getId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanCollateralManagementData(final Long clientCollateralId, final BigDecimal quantity, final BigDecimal total, final BigDecimal totalCollateral, final Long id) {
        this.clientCollateralId = clientCollateralId;
        this.quantity = quantity;
        this.total = total;
        this.totalCollateral = totalCollateral;
        this.id = id;
    }
}
