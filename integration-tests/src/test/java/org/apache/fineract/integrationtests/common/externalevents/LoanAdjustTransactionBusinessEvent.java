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
import java.util.Collections;
import java.util.Map;
import java.util.Objects;
import org.apache.fineract.infrastructure.event.external.data.ExternalEventResponse;

public class LoanAdjustTransactionBusinessEvent extends BusinessEvent {
    private String transactionTypeCode;
    private String transactionDate;
    private Double oldAmount;
    private Double newAmount;
    private Double oldPrincipalPortion;
    private Double newPrincipalPortion;
    private Double oldInterestPortion;
    private Double newInterestPortion;
    private Double oldFeePortion;
    private Double newFeePortion;
    private Double oldPenaltyPortion;
    private Double newPenaltyPortion;

    // minimum data for checking if transaction was reversed
    public LoanAdjustTransactionBusinessEvent(String type, String businessDate, String transactionTypeCode, String transactionDate) {
        super(type, businessDate);
        this.transactionTypeCode = transactionTypeCode;
        this.transactionDate = transactionDate;
    }

    // minimum data for checking if transaction was adjusted
    public LoanAdjustTransactionBusinessEvent(String type, String businessDate, String transactionTypeCode, String transactionDate, Double oldAmount, Double newAmount) {
        super(type, businessDate);
        this.transactionTypeCode = transactionTypeCode;
        this.transactionDate = transactionDate;
        this.oldAmount = oldAmount;
        this.newAmount = newAmount;
    }

    public LoanAdjustTransactionBusinessEvent(String type, String businessDate, String transactionTypeCode, String transactionDate, Double oldAmount, Double newAmount, Double oldPrincipalPortion, Double newPrincipalPortion, Double oldInterestPortion, Double newInterestPortion, Double oldFeePortion, Double newFeePortion, Double oldPenaltyPortion, Double newPenaltyPortion) {
        super(type, businessDate);
        this.transactionTypeCode = transactionTypeCode;
        this.transactionDate = transactionDate;
        this.oldAmount = oldAmount;
        this.newAmount = newAmount;
        this.oldPrincipalPortion = oldPrincipalPortion;
        this.newPrincipalPortion = newPrincipalPortion;
        this.oldInterestPortion = oldInterestPortion;
        this.newInterestPortion = newInterestPortion;
        this.oldFeePortion = oldFeePortion;
        this.newFeePortion = newFeePortion;
        this.oldPenaltyPortion = oldPenaltyPortion;
        this.newPenaltyPortion = newPenaltyPortion;
    }

    @Override
    public boolean verify(ExternalEventResponse externalEvent, DateTimeFormatter formatter) {
        final Object transactionToAdjust = externalEvent.getPayLoad().get("transactionToAdjust");
        final Map<?, Object> transActionToAdjustMap = transactionToAdjust instanceof Map ? (Map<String, Object>) transactionToAdjust : Collections.emptyMap();
        Object actualOldAmount = transActionToAdjustMap.get("amount");
        Object actualOldPrincipalPortion = transActionToAdjustMap.get("principalPortion");
        Object actualOldInterestPortion = transActionToAdjustMap.get("interestPortion");
        Object actualOldFeePortion = transActionToAdjustMap.get("feeChargesPortion");
        Object actualOldPenaltyPortion = transActionToAdjustMap.get("penaltyChargesPortion");
        final Object newTransactionDetail = externalEvent.getPayLoad().get("newTransactionDetail");
        final Map<?, Object> newTransactionDetailMap = newTransactionDetail instanceof Map ? (Map<String, Object>) newTransactionDetail : Collections.emptyMap();
        Object actualNewAmount = newTransactionDetailMap.get("amount");
        Object actualNewPrincipalPortion = newTransactionDetailMap.get("principalPortion");
        Object actualNewInterestPortion = newTransactionDetailMap.get("interestPortion");
        Object actualNewFeePortion = newTransactionDetailMap.get("feeChargesPortion");
        Object actualNewPenaltyPortion = newTransactionDetailMap.get("penaltyChargesPortion");
        final Object actualTransactionDate = transActionToAdjustMap.get("date");
        final Object transactionType = transActionToAdjustMap.get("type");
        final Map<?, Object> transactionTypeMap = transactionType instanceof Map ? (Map<String, Object>) transactionType : Collections.emptyMap();
        final Object actualTransactionTypeCode = transactionTypeMap.get("code");
        return //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        super.verify(externalEvent, formatter) && Objects.equals(actualTransactionTypeCode, transactionTypeCode) && Objects.equals(actualTransactionDate, transactionDate) && (oldAmount == null || Objects.equals(actualOldAmount, oldAmount)) && (newAmount == null || Objects.equals(actualNewAmount, newAmount)) && (oldPrincipalPortion == null || Objects.equals(actualOldPrincipalPortion, oldPrincipalPortion)) && (newPrincipalPortion == null || Objects.equals(actualNewPrincipalPortion, newPrincipalPortion)) && (oldInterestPortion == null || Objects.equals(actualOldInterestPortion, oldInterestPortion)) && (newInterestPortion == null || Objects.equals(actualNewInterestPortion, newInterestPortion)) && (oldFeePortion == null || Objects.equals(actualOldFeePortion, oldFeePortion)) && (newFeePortion == null || Objects.equals(actualNewFeePortion, newFeePortion)) && (oldPenaltyPortion == null || Objects.equals(actualOldPenaltyPortion, oldPenaltyPortion)) && (newPenaltyPortion == null || Objects.equals(actualNewPenaltyPortion, newPenaltyPortion));
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanAdjustTransactionBusinessEvent)) return false;
        final LoanAdjustTransactionBusinessEvent other = (LoanAdjustTransactionBusinessEvent) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (!super.equals(o)) return false;
        final java.lang.Object this$oldAmount = this.getOldAmount();
        final java.lang.Object other$oldAmount = other.getOldAmount();
        if (this$oldAmount == null ? other$oldAmount != null : !this$oldAmount.equals(other$oldAmount)) return false;
        final java.lang.Object this$newAmount = this.getNewAmount();
        final java.lang.Object other$newAmount = other.getNewAmount();
        if (this$newAmount == null ? other$newAmount != null : !this$newAmount.equals(other$newAmount)) return false;
        final java.lang.Object this$oldPrincipalPortion = this.getOldPrincipalPortion();
        final java.lang.Object other$oldPrincipalPortion = other.getOldPrincipalPortion();
        if (this$oldPrincipalPortion == null ? other$oldPrincipalPortion != null : !this$oldPrincipalPortion.equals(other$oldPrincipalPortion)) return false;
        final java.lang.Object this$newPrincipalPortion = this.getNewPrincipalPortion();
        final java.lang.Object other$newPrincipalPortion = other.getNewPrincipalPortion();
        if (this$newPrincipalPortion == null ? other$newPrincipalPortion != null : !this$newPrincipalPortion.equals(other$newPrincipalPortion)) return false;
        final java.lang.Object this$oldInterestPortion = this.getOldInterestPortion();
        final java.lang.Object other$oldInterestPortion = other.getOldInterestPortion();
        if (this$oldInterestPortion == null ? other$oldInterestPortion != null : !this$oldInterestPortion.equals(other$oldInterestPortion)) return false;
        final java.lang.Object this$newInterestPortion = this.getNewInterestPortion();
        final java.lang.Object other$newInterestPortion = other.getNewInterestPortion();
        if (this$newInterestPortion == null ? other$newInterestPortion != null : !this$newInterestPortion.equals(other$newInterestPortion)) return false;
        final java.lang.Object this$oldFeePortion = this.getOldFeePortion();
        final java.lang.Object other$oldFeePortion = other.getOldFeePortion();
        if (this$oldFeePortion == null ? other$oldFeePortion != null : !this$oldFeePortion.equals(other$oldFeePortion)) return false;
        final java.lang.Object this$newFeePortion = this.getNewFeePortion();
        final java.lang.Object other$newFeePortion = other.getNewFeePortion();
        if (this$newFeePortion == null ? other$newFeePortion != null : !this$newFeePortion.equals(other$newFeePortion)) return false;
        final java.lang.Object this$oldPenaltyPortion = this.getOldPenaltyPortion();
        final java.lang.Object other$oldPenaltyPortion = other.getOldPenaltyPortion();
        if (this$oldPenaltyPortion == null ? other$oldPenaltyPortion != null : !this$oldPenaltyPortion.equals(other$oldPenaltyPortion)) return false;
        final java.lang.Object this$newPenaltyPortion = this.getNewPenaltyPortion();
        final java.lang.Object other$newPenaltyPortion = other.getNewPenaltyPortion();
        if (this$newPenaltyPortion == null ? other$newPenaltyPortion != null : !this$newPenaltyPortion.equals(other$newPenaltyPortion)) return false;
        final java.lang.Object this$transactionTypeCode = this.getTransactionTypeCode();
        final java.lang.Object other$transactionTypeCode = other.getTransactionTypeCode();
        if (this$transactionTypeCode == null ? other$transactionTypeCode != null : !this$transactionTypeCode.equals(other$transactionTypeCode)) return false;
        final java.lang.Object this$transactionDate = this.getTransactionDate();
        final java.lang.Object other$transactionDate = other.getTransactionDate();
        if (this$transactionDate == null ? other$transactionDate != null : !this$transactionDate.equals(other$transactionDate)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanAdjustTransactionBusinessEvent;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = super.hashCode();
        final java.lang.Object $oldAmount = this.getOldAmount();
        result = result * PRIME + ($oldAmount == null ? 43 : $oldAmount.hashCode());
        final java.lang.Object $newAmount = this.getNewAmount();
        result = result * PRIME + ($newAmount == null ? 43 : $newAmount.hashCode());
        final java.lang.Object $oldPrincipalPortion = this.getOldPrincipalPortion();
        result = result * PRIME + ($oldPrincipalPortion == null ? 43 : $oldPrincipalPortion.hashCode());
        final java.lang.Object $newPrincipalPortion = this.getNewPrincipalPortion();
        result = result * PRIME + ($newPrincipalPortion == null ? 43 : $newPrincipalPortion.hashCode());
        final java.lang.Object $oldInterestPortion = this.getOldInterestPortion();
        result = result * PRIME + ($oldInterestPortion == null ? 43 : $oldInterestPortion.hashCode());
        final java.lang.Object $newInterestPortion = this.getNewInterestPortion();
        result = result * PRIME + ($newInterestPortion == null ? 43 : $newInterestPortion.hashCode());
        final java.lang.Object $oldFeePortion = this.getOldFeePortion();
        result = result * PRIME + ($oldFeePortion == null ? 43 : $oldFeePortion.hashCode());
        final java.lang.Object $newFeePortion = this.getNewFeePortion();
        result = result * PRIME + ($newFeePortion == null ? 43 : $newFeePortion.hashCode());
        final java.lang.Object $oldPenaltyPortion = this.getOldPenaltyPortion();
        result = result * PRIME + ($oldPenaltyPortion == null ? 43 : $oldPenaltyPortion.hashCode());
        final java.lang.Object $newPenaltyPortion = this.getNewPenaltyPortion();
        result = result * PRIME + ($newPenaltyPortion == null ? 43 : $newPenaltyPortion.hashCode());
        final java.lang.Object $transactionTypeCode = this.getTransactionTypeCode();
        result = result * PRIME + ($transactionTypeCode == null ? 43 : $transactionTypeCode.hashCode());
        final java.lang.Object $transactionDate = this.getTransactionDate();
        result = result * PRIME + ($transactionDate == null ? 43 : $transactionDate.hashCode());
        return result;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransactionTypeCode() {
        return this.transactionTypeCode;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransactionDate() {
        return this.transactionDate;
    }

    @java.lang.SuppressWarnings("all")
        public Double getOldAmount() {
        return this.oldAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Double getNewAmount() {
        return this.newAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Double getOldPrincipalPortion() {
        return this.oldPrincipalPortion;
    }

    @java.lang.SuppressWarnings("all")
        public Double getNewPrincipalPortion() {
        return this.newPrincipalPortion;
    }

    @java.lang.SuppressWarnings("all")
        public Double getOldInterestPortion() {
        return this.oldInterestPortion;
    }

    @java.lang.SuppressWarnings("all")
        public Double getNewInterestPortion() {
        return this.newInterestPortion;
    }

    @java.lang.SuppressWarnings("all")
        public Double getOldFeePortion() {
        return this.oldFeePortion;
    }

    @java.lang.SuppressWarnings("all")
        public Double getNewFeePortion() {
        return this.newFeePortion;
    }

    @java.lang.SuppressWarnings("all")
        public Double getOldPenaltyPortion() {
        return this.oldPenaltyPortion;
    }

    @java.lang.SuppressWarnings("all")
        public Double getNewPenaltyPortion() {
        return this.newPenaltyPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransactionTypeCode(final String transactionTypeCode) {
        this.transactionTypeCode = transactionTypeCode;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransactionDate(final String transactionDate) {
        this.transactionDate = transactionDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setOldAmount(final Double oldAmount) {
        this.oldAmount = oldAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setNewAmount(final Double newAmount) {
        this.newAmount = newAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setOldPrincipalPortion(final Double oldPrincipalPortion) {
        this.oldPrincipalPortion = oldPrincipalPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setNewPrincipalPortion(final Double newPrincipalPortion) {
        this.newPrincipalPortion = newPrincipalPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setOldInterestPortion(final Double oldInterestPortion) {
        this.oldInterestPortion = oldInterestPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setNewInterestPortion(final Double newInterestPortion) {
        this.newInterestPortion = newInterestPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setOldFeePortion(final Double oldFeePortion) {
        this.oldFeePortion = oldFeePortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setNewFeePortion(final Double newFeePortion) {
        this.newFeePortion = newFeePortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setOldPenaltyPortion(final Double oldPenaltyPortion) {
        this.oldPenaltyPortion = oldPenaltyPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setNewPenaltyPortion(final Double newPenaltyPortion) {
        this.newPenaltyPortion = newPenaltyPortion;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanAdjustTransactionBusinessEvent(transactionTypeCode=" + this.getTransactionTypeCode() + ", transactionDate=" + this.getTransactionDate() + ", oldAmount=" + this.getOldAmount() + ", newAmount=" + this.getNewAmount() + ", oldPrincipalPortion=" + this.getOldPrincipalPortion() + ", newPrincipalPortion=" + this.getNewPrincipalPortion() + ", oldInterestPortion=" + this.getOldInterestPortion() + ", newInterestPortion=" + this.getNewInterestPortion() + ", oldFeePortion=" + this.getOldFeePortion() + ", newFeePortion=" + this.getNewFeePortion() + ", oldPenaltyPortion=" + this.getOldPenaltyPortion() + ", newPenaltyPortion=" + this.getNewPenaltyPortion() + ")";
    }
}
