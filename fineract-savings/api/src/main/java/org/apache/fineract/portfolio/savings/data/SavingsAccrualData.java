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
package org.apache.fineract.portfolio.savings.data;

import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.portfolio.savings.DepositAccountType;
import org.apache.fineract.portfolio.savings.service.SavingsEnumerations;

public class SavingsAccrualData {
    private final Long id;
    private final String accountNo;
    private final LocalDate accruedTill;
    private final Boolean isTypeInterestReceivable;
    private final Boolean isAllowOverdraft;
    private final Integer depositType;

    public DepositAccountType getDepositType() {
        final EnumOptionData depositType = SavingsEnumerations.depositType(this.depositType);
        DepositAccountType depositAccountType = DepositAccountType.fromInt(depositType.getId().intValue());
        return depositAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getAccountNo() {
        return this.accountNo;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getAccruedTill() {
        return this.accruedTill;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsTypeInterestReceivable() {
        return this.isTypeInterestReceivable;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsAllowOverdraft() {
        return this.isAllowOverdraft;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof SavingsAccrualData)) return false;
        final SavingsAccrualData other = (SavingsAccrualData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$isTypeInterestReceivable = this.getIsTypeInterestReceivable();
        final java.lang.Object other$isTypeInterestReceivable = other.getIsTypeInterestReceivable();
        if (this$isTypeInterestReceivable == null ? other$isTypeInterestReceivable != null : !this$isTypeInterestReceivable.equals(other$isTypeInterestReceivable)) return false;
        final java.lang.Object this$isAllowOverdraft = this.getIsAllowOverdraft();
        final java.lang.Object other$isAllowOverdraft = other.getIsAllowOverdraft();
        if (this$isAllowOverdraft == null ? other$isAllowOverdraft != null : !this$isAllowOverdraft.equals(other$isAllowOverdraft)) return false;
        final java.lang.Object this$depositType = this.getDepositType();
        final java.lang.Object other$depositType = other.getDepositType();
        if (this$depositType == null ? other$depositType != null : !this$depositType.equals(other$depositType)) return false;
        final java.lang.Object this$accountNo = this.getAccountNo();
        final java.lang.Object other$accountNo = other.getAccountNo();
        if (this$accountNo == null ? other$accountNo != null : !this$accountNo.equals(other$accountNo)) return false;
        final java.lang.Object this$accruedTill = this.getAccruedTill();
        final java.lang.Object other$accruedTill = other.getAccruedTill();
        if (this$accruedTill == null ? other$accruedTill != null : !this$accruedTill.equals(other$accruedTill)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof SavingsAccrualData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $isTypeInterestReceivable = this.getIsTypeInterestReceivable();
        result = result * PRIME + ($isTypeInterestReceivable == null ? 43 : $isTypeInterestReceivable.hashCode());
        final java.lang.Object $isAllowOverdraft = this.getIsAllowOverdraft();
        result = result * PRIME + ($isAllowOverdraft == null ? 43 : $isAllowOverdraft.hashCode());
        final java.lang.Object $depositType = this.getDepositType();
        result = result * PRIME + ($depositType == null ? 43 : $depositType.hashCode());
        final java.lang.Object $accountNo = this.getAccountNo();
        result = result * PRIME + ($accountNo == null ? 43 : $accountNo.hashCode());
        final java.lang.Object $accruedTill = this.getAccruedTill();
        result = result * PRIME + ($accruedTill == null ? 43 : $accruedTill.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "SavingsAccrualData(id=" + this.getId() + ", accountNo=" + this.getAccountNo() + ", accruedTill=" + this.getAccruedTill() + ", isTypeInterestReceivable=" + this.getIsTypeInterestReceivable() + ", isAllowOverdraft=" + this.getIsAllowOverdraft() + ", depositType=" + this.getDepositType() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public SavingsAccrualData(final Long id, final String accountNo, final LocalDate accruedTill, final Boolean isTypeInterestReceivable, final Boolean isAllowOverdraft, final Integer depositType) {
        this.id = id;
        this.accountNo = accountNo;
        this.accruedTill = accruedTill;
        this.isTypeInterestReceivable = isTypeInterestReceivable;
        this.isAllowOverdraft = isAllowOverdraft;
        this.depositType = depositType;
    }
}
