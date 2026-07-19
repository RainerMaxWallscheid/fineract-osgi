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

public class LoanTransactionBusinessEvent extends BusinessEvent {
    private Double amount;
    private Double outstandingLoanBalance;
    private Double principalPortion;
    private Double interestPortion;
    private Double feeChargesPortion;
    private Double penaltyChargesPortion;

    public LoanTransactionBusinessEvent(String type, String businessDate, Double amount, Double outstandingLoanBalance, Double principalPortion, Double interestPortion, Double feeChargesPortion, Double penaltyChargesPortion) {
        super(type, businessDate);
        this.amount = amount;
        this.outstandingLoanBalance = outstandingLoanBalance;
        this.principalPortion = principalPortion;
        this.interestPortion = interestPortion;
        this.feeChargesPortion = feeChargesPortion;
        this.penaltyChargesPortion = penaltyChargesPortion;
    }

    @Override
    public boolean verify(ExternalEventResponse externalEvent, DateTimeFormatter formatter) {
        Object amount = externalEvent.getPayLoad().get("amount");
        Object outstandingLoanBalance = externalEvent.getPayLoad().get("outstandingLoanBalance");
        Object principalPortion = externalEvent.getPayLoad().get("principalPortion");
        Object interestPortion = externalEvent.getPayLoad().get("interestPortion");
        Object feePortion = externalEvent.getPayLoad().get("feeChargesPortion");
        Object penaltyPortion = externalEvent.getPayLoad().get("penaltyChargesPortion");
        return super.verify(externalEvent, formatter) && Objects.equals(amount, getAmount()) && Objects.equals(outstandingLoanBalance, getOutstandingLoanBalance()) && Objects.equals(principalPortion, getPrincipalPortion()) && Objects.equals(interestPortion, getInterestPortion()) && Objects.equals(feePortion, getFeeChargesPortion()) && Objects.equals(penaltyPortion, getPenaltyChargesPortion());
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanTransactionBusinessEvent)) return false;
        final LoanTransactionBusinessEvent other = (LoanTransactionBusinessEvent) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (!super.equals(o)) return false;
        final java.lang.Object this$amount = this.getAmount();
        final java.lang.Object other$amount = other.getAmount();
        if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
        final java.lang.Object this$outstandingLoanBalance = this.getOutstandingLoanBalance();
        final java.lang.Object other$outstandingLoanBalance = other.getOutstandingLoanBalance();
        if (this$outstandingLoanBalance == null ? other$outstandingLoanBalance != null : !this$outstandingLoanBalance.equals(other$outstandingLoanBalance)) return false;
        final java.lang.Object this$principalPortion = this.getPrincipalPortion();
        final java.lang.Object other$principalPortion = other.getPrincipalPortion();
        if (this$principalPortion == null ? other$principalPortion != null : !this$principalPortion.equals(other$principalPortion)) return false;
        final java.lang.Object this$interestPortion = this.getInterestPortion();
        final java.lang.Object other$interestPortion = other.getInterestPortion();
        if (this$interestPortion == null ? other$interestPortion != null : !this$interestPortion.equals(other$interestPortion)) return false;
        final java.lang.Object this$feeChargesPortion = this.getFeeChargesPortion();
        final java.lang.Object other$feeChargesPortion = other.getFeeChargesPortion();
        if (this$feeChargesPortion == null ? other$feeChargesPortion != null : !this$feeChargesPortion.equals(other$feeChargesPortion)) return false;
        final java.lang.Object this$penaltyChargesPortion = this.getPenaltyChargesPortion();
        final java.lang.Object other$penaltyChargesPortion = other.getPenaltyChargesPortion();
        if (this$penaltyChargesPortion == null ? other$penaltyChargesPortion != null : !this$penaltyChargesPortion.equals(other$penaltyChargesPortion)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanTransactionBusinessEvent;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = super.hashCode();
        final java.lang.Object $amount = this.getAmount();
        result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
        final java.lang.Object $outstandingLoanBalance = this.getOutstandingLoanBalance();
        result = result * PRIME + ($outstandingLoanBalance == null ? 43 : $outstandingLoanBalance.hashCode());
        final java.lang.Object $principalPortion = this.getPrincipalPortion();
        result = result * PRIME + ($principalPortion == null ? 43 : $principalPortion.hashCode());
        final java.lang.Object $interestPortion = this.getInterestPortion();
        result = result * PRIME + ($interestPortion == null ? 43 : $interestPortion.hashCode());
        final java.lang.Object $feeChargesPortion = this.getFeeChargesPortion();
        result = result * PRIME + ($feeChargesPortion == null ? 43 : $feeChargesPortion.hashCode());
        final java.lang.Object $penaltyChargesPortion = this.getPenaltyChargesPortion();
        result = result * PRIME + ($penaltyChargesPortion == null ? 43 : $penaltyChargesPortion.hashCode());
        return result;
    }

    @java.lang.SuppressWarnings("all")
        public Double getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public Double getOutstandingLoanBalance() {
        return this.outstandingLoanBalance;
    }

    @java.lang.SuppressWarnings("all")
        public Double getPrincipalPortion() {
        return this.principalPortion;
    }

    @java.lang.SuppressWarnings("all")
        public Double getInterestPortion() {
        return this.interestPortion;
    }

    @java.lang.SuppressWarnings("all")
        public Double getFeeChargesPortion() {
        return this.feeChargesPortion;
    }

    @java.lang.SuppressWarnings("all")
        public Double getPenaltyChargesPortion() {
        return this.penaltyChargesPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmount(final Double amount) {
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public void setOutstandingLoanBalance(final Double outstandingLoanBalance) {
        this.outstandingLoanBalance = outstandingLoanBalance;
    }

    @java.lang.SuppressWarnings("all")
        public void setPrincipalPortion(final Double principalPortion) {
        this.principalPortion = principalPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setInterestPortion(final Double interestPortion) {
        this.interestPortion = interestPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setFeeChargesPortion(final Double feeChargesPortion) {
        this.feeChargesPortion = feeChargesPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setPenaltyChargesPortion(final Double penaltyChargesPortion) {
        this.penaltyChargesPortion = penaltyChargesPortion;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanTransactionBusinessEvent(amount=" + this.getAmount() + ", outstandingLoanBalance=" + this.getOutstandingLoanBalance() + ", principalPortion=" + this.getPrincipalPortion() + ", interestPortion=" + this.getInterestPortion() + ", feeChargesPortion=" + this.getFeeChargesPortion() + ", penaltyChargesPortion=" + this.getPenaltyChargesPortion() + ")";
    }
}
