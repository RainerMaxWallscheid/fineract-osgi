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
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class AccountingBridgeLoanTransactionDTO {
    private Long id;
    private Long officeId;
    private LoanTransactionEnumData type;
    private boolean reversed;
    private LocalDate date;
    private String currencyCode;
    private BigDecimal amount;
    private BigDecimal netDisbursalAmount;
    private BigDecimal principalPortion;
    private BigDecimal interestPortion;
    private BigDecimal feeChargesPortion;
    private BigDecimal penaltyChargesPortion;
    private BigDecimal overPaymentPortion;
    private String chargeRefundChargeType;
    private Long paymentTypeId;
    private List<LoanChargePaidByDTO> loanChargesPaid = new ArrayList<>();
    private BigDecimal principalPaid;
    private BigDecimal feePaid;
    private BigDecimal penaltyPaid;
    private LoanChargeData loanChargeData;
    private boolean loanToLoanTransfer;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public LoanTransactionEnumData getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isReversed() {
        return this.reversed;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDate() {
        return this.date;
    }

    @java.lang.SuppressWarnings("all")
        public String getCurrencyCode() {
        return this.currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getNetDisbursalAmount() {
        return this.netDisbursalAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalPortion() {
        return this.principalPortion;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestPortion() {
        return this.interestPortion;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeChargesPortion() {
        return this.feeChargesPortion;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyChargesPortion() {
        return this.penaltyChargesPortion;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOverPaymentPortion() {
        return this.overPaymentPortion;
    }

    @java.lang.SuppressWarnings("all")
        public String getChargeRefundChargeType() {
        return this.chargeRefundChargeType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getPaymentTypeId() {
        return this.paymentTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public List<LoanChargePaidByDTO> getLoanChargesPaid() {
        return this.loanChargesPaid;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalPaid() {
        return this.principalPaid;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeePaid() {
        return this.feePaid;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyPaid() {
        return this.penaltyPaid;
    }

    @java.lang.SuppressWarnings("all")
        public LoanChargeData getLoanChargeData() {
        return this.loanChargeData;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isLoanToLoanTransfer() {
        return this.loanToLoanTransfer;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setOfficeId(final Long officeId) {
        this.officeId = officeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setType(final LoanTransactionEnumData type) {
        this.type = type;
    }

    @java.lang.SuppressWarnings("all")
        public void setReversed(final boolean reversed) {
        this.reversed = reversed;
    }

    @java.lang.SuppressWarnings("all")
        public void setDate(final LocalDate date) {
        this.date = date;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrencyCode(final String currencyCode) {
        this.currencyCode = currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmount(final BigDecimal amount) {
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public void setNetDisbursalAmount(final BigDecimal netDisbursalAmount) {
        this.netDisbursalAmount = netDisbursalAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setPrincipalPortion(final BigDecimal principalPortion) {
        this.principalPortion = principalPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setInterestPortion(final BigDecimal interestPortion) {
        this.interestPortion = interestPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setFeeChargesPortion(final BigDecimal feeChargesPortion) {
        this.feeChargesPortion = feeChargesPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setPenaltyChargesPortion(final BigDecimal penaltyChargesPortion) {
        this.penaltyChargesPortion = penaltyChargesPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setOverPaymentPortion(final BigDecimal overPaymentPortion) {
        this.overPaymentPortion = overPaymentPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargeRefundChargeType(final String chargeRefundChargeType) {
        this.chargeRefundChargeType = chargeRefundChargeType;
    }

    @java.lang.SuppressWarnings("all")
        public void setPaymentTypeId(final Long paymentTypeId) {
        this.paymentTypeId = paymentTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanChargesPaid(final List<LoanChargePaidByDTO> loanChargesPaid) {
        this.loanChargesPaid = loanChargesPaid;
    }

    @java.lang.SuppressWarnings("all")
        public void setPrincipalPaid(final BigDecimal principalPaid) {
        this.principalPaid = principalPaid;
    }

    @java.lang.SuppressWarnings("all")
        public void setFeePaid(final BigDecimal feePaid) {
        this.feePaid = feePaid;
    }

    @java.lang.SuppressWarnings("all")
        public void setPenaltyPaid(final BigDecimal penaltyPaid) {
        this.penaltyPaid = penaltyPaid;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanChargeData(final LoanChargeData loanChargeData) {
        this.loanChargeData = loanChargeData;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanToLoanTransfer(final boolean loanToLoanTransfer) {
        this.loanToLoanTransfer = loanToLoanTransfer;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AccountingBridgeLoanTransactionDTO)) return false;
        final AccountingBridgeLoanTransactionDTO other = (AccountingBridgeLoanTransactionDTO) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isReversed() != other.isReversed()) return false;
        if (this.isLoanToLoanTransfer() != other.isLoanToLoanTransfer()) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$paymentTypeId = this.getPaymentTypeId();
        final java.lang.Object other$paymentTypeId = other.getPaymentTypeId();
        if (this$paymentTypeId == null ? other$paymentTypeId != null : !this$paymentTypeId.equals(other$paymentTypeId)) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final java.lang.Object this$date = this.getDate();
        final java.lang.Object other$date = other.getDate();
        if (this$date == null ? other$date != null : !this$date.equals(other$date)) return false;
        final java.lang.Object this$currencyCode = this.getCurrencyCode();
        final java.lang.Object other$currencyCode = other.getCurrencyCode();
        if (this$currencyCode == null ? other$currencyCode != null : !this$currencyCode.equals(other$currencyCode)) return false;
        final java.lang.Object this$amount = this.getAmount();
        final java.lang.Object other$amount = other.getAmount();
        if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
        final java.lang.Object this$netDisbursalAmount = this.getNetDisbursalAmount();
        final java.lang.Object other$netDisbursalAmount = other.getNetDisbursalAmount();
        if (this$netDisbursalAmount == null ? other$netDisbursalAmount != null : !this$netDisbursalAmount.equals(other$netDisbursalAmount)) return false;
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
        final java.lang.Object this$overPaymentPortion = this.getOverPaymentPortion();
        final java.lang.Object other$overPaymentPortion = other.getOverPaymentPortion();
        if (this$overPaymentPortion == null ? other$overPaymentPortion != null : !this$overPaymentPortion.equals(other$overPaymentPortion)) return false;
        final java.lang.Object this$chargeRefundChargeType = this.getChargeRefundChargeType();
        final java.lang.Object other$chargeRefundChargeType = other.getChargeRefundChargeType();
        if (this$chargeRefundChargeType == null ? other$chargeRefundChargeType != null : !this$chargeRefundChargeType.equals(other$chargeRefundChargeType)) return false;
        final java.lang.Object this$loanChargesPaid = this.getLoanChargesPaid();
        final java.lang.Object other$loanChargesPaid = other.getLoanChargesPaid();
        if (this$loanChargesPaid == null ? other$loanChargesPaid != null : !this$loanChargesPaid.equals(other$loanChargesPaid)) return false;
        final java.lang.Object this$principalPaid = this.getPrincipalPaid();
        final java.lang.Object other$principalPaid = other.getPrincipalPaid();
        if (this$principalPaid == null ? other$principalPaid != null : !this$principalPaid.equals(other$principalPaid)) return false;
        final java.lang.Object this$feePaid = this.getFeePaid();
        final java.lang.Object other$feePaid = other.getFeePaid();
        if (this$feePaid == null ? other$feePaid != null : !this$feePaid.equals(other$feePaid)) return false;
        final java.lang.Object this$penaltyPaid = this.getPenaltyPaid();
        final java.lang.Object other$penaltyPaid = other.getPenaltyPaid();
        if (this$penaltyPaid == null ? other$penaltyPaid != null : !this$penaltyPaid.equals(other$penaltyPaid)) return false;
        final java.lang.Object this$loanChargeData = this.getLoanChargeData();
        final java.lang.Object other$loanChargeData = other.getLoanChargeData();
        if (this$loanChargeData == null ? other$loanChargeData != null : !this$loanChargeData.equals(other$loanChargeData)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AccountingBridgeLoanTransactionDTO;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isReversed() ? 79 : 97);
        result = result * PRIME + (this.isLoanToLoanTransfer() ? 79 : 97);
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $officeId = this.getOfficeId();
        result = result * PRIME + ($officeId == null ? 43 : $officeId.hashCode());
        final java.lang.Object $paymentTypeId = this.getPaymentTypeId();
        result = result * PRIME + ($paymentTypeId == null ? 43 : $paymentTypeId.hashCode());
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final java.lang.Object $date = this.getDate();
        result = result * PRIME + ($date == null ? 43 : $date.hashCode());
        final java.lang.Object $currencyCode = this.getCurrencyCode();
        result = result * PRIME + ($currencyCode == null ? 43 : $currencyCode.hashCode());
        final java.lang.Object $amount = this.getAmount();
        result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
        final java.lang.Object $netDisbursalAmount = this.getNetDisbursalAmount();
        result = result * PRIME + ($netDisbursalAmount == null ? 43 : $netDisbursalAmount.hashCode());
        final java.lang.Object $principalPortion = this.getPrincipalPortion();
        result = result * PRIME + ($principalPortion == null ? 43 : $principalPortion.hashCode());
        final java.lang.Object $interestPortion = this.getInterestPortion();
        result = result * PRIME + ($interestPortion == null ? 43 : $interestPortion.hashCode());
        final java.lang.Object $feeChargesPortion = this.getFeeChargesPortion();
        result = result * PRIME + ($feeChargesPortion == null ? 43 : $feeChargesPortion.hashCode());
        final java.lang.Object $penaltyChargesPortion = this.getPenaltyChargesPortion();
        result = result * PRIME + ($penaltyChargesPortion == null ? 43 : $penaltyChargesPortion.hashCode());
        final java.lang.Object $overPaymentPortion = this.getOverPaymentPortion();
        result = result * PRIME + ($overPaymentPortion == null ? 43 : $overPaymentPortion.hashCode());
        final java.lang.Object $chargeRefundChargeType = this.getChargeRefundChargeType();
        result = result * PRIME + ($chargeRefundChargeType == null ? 43 : $chargeRefundChargeType.hashCode());
        final java.lang.Object $loanChargesPaid = this.getLoanChargesPaid();
        result = result * PRIME + ($loanChargesPaid == null ? 43 : $loanChargesPaid.hashCode());
        final java.lang.Object $principalPaid = this.getPrincipalPaid();
        result = result * PRIME + ($principalPaid == null ? 43 : $principalPaid.hashCode());
        final java.lang.Object $feePaid = this.getFeePaid();
        result = result * PRIME + ($feePaid == null ? 43 : $feePaid.hashCode());
        final java.lang.Object $penaltyPaid = this.getPenaltyPaid();
        result = result * PRIME + ($penaltyPaid == null ? 43 : $penaltyPaid.hashCode());
        final java.lang.Object $loanChargeData = this.getLoanChargeData();
        result = result * PRIME + ($loanChargeData == null ? 43 : $loanChargeData.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AccountingBridgeLoanTransactionDTO(id=" + this.getId() + ", officeId=" + this.getOfficeId() + ", type=" + this.getType() + ", reversed=" + this.isReversed() + ", date=" + this.getDate() + ", currencyCode=" + this.getCurrencyCode() + ", amount=" + this.getAmount() + ", netDisbursalAmount=" + this.getNetDisbursalAmount() + ", principalPortion=" + this.getPrincipalPortion() + ", interestPortion=" + this.getInterestPortion() + ", feeChargesPortion=" + this.getFeeChargesPortion() + ", penaltyChargesPortion=" + this.getPenaltyChargesPortion() + ", overPaymentPortion=" + this.getOverPaymentPortion() + ", chargeRefundChargeType=" + this.getChargeRefundChargeType() + ", paymentTypeId=" + this.getPaymentTypeId() + ", loanChargesPaid=" + this.getLoanChargesPaid() + ", principalPaid=" + this.getPrincipalPaid() + ", feePaid=" + this.getFeePaid() + ", penaltyPaid=" + this.getPenaltyPaid() + ", loanChargeData=" + this.getLoanChargeData() + ", loanToLoanTransfer=" + this.isLoanToLoanTransfer() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AccountingBridgeLoanTransactionDTO() {
    }

    @java.lang.SuppressWarnings("all")
        public AccountingBridgeLoanTransactionDTO(final Long id, final Long officeId, final LoanTransactionEnumData type, final boolean reversed, final LocalDate date, final String currencyCode, final BigDecimal amount, final BigDecimal netDisbursalAmount, final BigDecimal principalPortion, final BigDecimal interestPortion, final BigDecimal feeChargesPortion, final BigDecimal penaltyChargesPortion, final BigDecimal overPaymentPortion, final String chargeRefundChargeType, final Long paymentTypeId, final List<LoanChargePaidByDTO> loanChargesPaid, final BigDecimal principalPaid, final BigDecimal feePaid, final BigDecimal penaltyPaid, final LoanChargeData loanChargeData, final boolean loanToLoanTransfer) {
        this.id = id;
        this.officeId = officeId;
        this.type = type;
        this.reversed = reversed;
        this.date = date;
        this.currencyCode = currencyCode;
        this.amount = amount;
        this.netDisbursalAmount = netDisbursalAmount;
        this.principalPortion = principalPortion;
        this.interestPortion = interestPortion;
        this.feeChargesPortion = feeChargesPortion;
        this.penaltyChargesPortion = penaltyChargesPortion;
        this.overPaymentPortion = overPaymentPortion;
        this.chargeRefundChargeType = chargeRefundChargeType;
        this.paymentTypeId = paymentTypeId;
        this.loanChargesPaid = loanChargesPaid;
        this.principalPaid = principalPaid;
        this.feePaid = feePaid;
        this.penaltyPaid = penaltyPaid;
        this.loanChargeData = loanChargeData;
        this.loanToLoanTransfer = loanToLoanTransfer;
    }
}
