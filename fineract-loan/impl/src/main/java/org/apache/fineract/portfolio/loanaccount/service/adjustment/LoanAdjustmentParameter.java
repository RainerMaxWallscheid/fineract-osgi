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
package org.apache.fineract.portfolio.loanaccount.service.adjustment;

import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.portfolio.paymentdetail.domain.PaymentDetail;

public class LoanAdjustmentParameter {

    private BigDecimal transactionAmount;
    private PaymentDetail paymentDetail;
    private LocalDate transactionDate;
    private ExternalId txnExternalId;
    private ExternalId reversalTxnExternalId;
    private String noteText;

    @java.lang.SuppressWarnings("all")
    LoanAdjustmentParameter(final BigDecimal transactionAmount, final PaymentDetail paymentDetail, final LocalDate transactionDate,
            final ExternalId txnExternalId, final ExternalId reversalTxnExternalId, final String noteText) {
        this.transactionAmount = transactionAmount;
        this.paymentDetail = paymentDetail;
        this.transactionDate = transactionDate;
        this.txnExternalId = txnExternalId;
        this.reversalTxnExternalId = reversalTxnExternalId;
        this.noteText = noteText;
    }

    @java.lang.SuppressWarnings("all")
    public static class LoanAdjustmentParameterBuilder {

        @java.lang.SuppressWarnings("all")
        private BigDecimal transactionAmount;
        @java.lang.SuppressWarnings("all")
        private PaymentDetail paymentDetail;
        @java.lang.SuppressWarnings("all")
        private LocalDate transactionDate;
        @java.lang.SuppressWarnings("all")
        private ExternalId txnExternalId;
        @java.lang.SuppressWarnings("all")
        private ExternalId reversalTxnExternalId;
        @java.lang.SuppressWarnings("all")
        private String noteText;

        @java.lang.SuppressWarnings("all")
        LoanAdjustmentParameterBuilder() {}

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
        public LoanAdjustmentParameter.LoanAdjustmentParameterBuilder transactionAmount(final BigDecimal transactionAmount) {
            this.transactionAmount = transactionAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
        public LoanAdjustmentParameter.LoanAdjustmentParameterBuilder paymentDetail(final PaymentDetail paymentDetail) {
            this.paymentDetail = paymentDetail;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
        public LoanAdjustmentParameter.LoanAdjustmentParameterBuilder transactionDate(final LocalDate transactionDate) {
            this.transactionDate = transactionDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
        public LoanAdjustmentParameter.LoanAdjustmentParameterBuilder txnExternalId(final ExternalId txnExternalId) {
            this.txnExternalId = txnExternalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
        public LoanAdjustmentParameter.LoanAdjustmentParameterBuilder reversalTxnExternalId(final ExternalId reversalTxnExternalId) {
            this.reversalTxnExternalId = reversalTxnExternalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
        public LoanAdjustmentParameter.LoanAdjustmentParameterBuilder noteText(final String noteText) {
            this.noteText = noteText;
            return this;
        }

        @java.lang.SuppressWarnings("all")
        public LoanAdjustmentParameter build() {
            return new LoanAdjustmentParameter(this.transactionAmount, this.paymentDetail, this.transactionDate, this.txnExternalId,
                    this.reversalTxnExternalId, this.noteText);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
            return "LoanAdjustmentParameter.LoanAdjustmentParameterBuilder(transactionAmount=" + this.transactionAmount + ", paymentDetail="
                    + this.paymentDetail + ", transactionDate=" + this.transactionDate + ", txnExternalId=" + this.txnExternalId
                    + ", reversalTxnExternalId=" + this.reversalTxnExternalId + ", noteText=" + this.noteText + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
    public static LoanAdjustmentParameter.LoanAdjustmentParameterBuilder builder() {
        return new LoanAdjustmentParameter.LoanAdjustmentParameterBuilder();
    }

    @java.lang.SuppressWarnings("all")
    public BigDecimal getTransactionAmount() {
        return this.transactionAmount;
    }

    @java.lang.SuppressWarnings("all")
    public PaymentDetail getPaymentDetail() {
        return this.paymentDetail;
    }

    @java.lang.SuppressWarnings("all")
    public LocalDate getTransactionDate() {
        return this.transactionDate;
    }

    @java.lang.SuppressWarnings("all")
    public ExternalId getTxnExternalId() {
        return this.txnExternalId;
    }

    @java.lang.SuppressWarnings("all")
    public ExternalId getReversalTxnExternalId() {
        return this.reversalTxnExternalId;
    }

    @java.lang.SuppressWarnings("all")
    public String getNoteText() {
        return this.noteText;
    }

    @java.lang.SuppressWarnings("all")
    public void setTransactionAmount(final BigDecimal transactionAmount) {
        this.transactionAmount = transactionAmount;
    }

    @java.lang.SuppressWarnings("all")
    public void setPaymentDetail(final PaymentDetail paymentDetail) {
        this.paymentDetail = paymentDetail;
    }

    @java.lang.SuppressWarnings("all")
    public void setTransactionDate(final LocalDate transactionDate) {
        this.transactionDate = transactionDate;
    }

    @java.lang.SuppressWarnings("all")
    public void setTxnExternalId(final ExternalId txnExternalId) {
        this.txnExternalId = txnExternalId;
    }

    @java.lang.SuppressWarnings("all")
    public void setReversalTxnExternalId(final ExternalId reversalTxnExternalId) {
        this.reversalTxnExternalId = reversalTxnExternalId;
    }

    @java.lang.SuppressWarnings("all")
    public void setNoteText(final String noteText) {
        this.noteText = noteText;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanAdjustmentParameter)) return false;
        final LoanAdjustmentParameter other = (LoanAdjustmentParameter) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$transactionAmount = this.getTransactionAmount();
        final java.lang.Object other$transactionAmount = other.getTransactionAmount();
        if (this$transactionAmount == null ? other$transactionAmount != null : !this$transactionAmount.equals(other$transactionAmount))
            return false;
        final java.lang.Object this$paymentDetail = this.getPaymentDetail();
        final java.lang.Object other$paymentDetail = other.getPaymentDetail();
        if (this$paymentDetail == null ? other$paymentDetail != null : !this$paymentDetail.equals(other$paymentDetail)) return false;
        final java.lang.Object this$transactionDate = this.getTransactionDate();
        final java.lang.Object other$transactionDate = other.getTransactionDate();
        if (this$transactionDate == null ? other$transactionDate != null : !this$transactionDate.equals(other$transactionDate))
            return false;
        final java.lang.Object this$txnExternalId = this.getTxnExternalId();
        final java.lang.Object other$txnExternalId = other.getTxnExternalId();
        if (this$txnExternalId == null ? other$txnExternalId != null : !this$txnExternalId.equals(other$txnExternalId)) return false;
        final java.lang.Object this$reversalTxnExternalId = this.getReversalTxnExternalId();
        final java.lang.Object other$reversalTxnExternalId = other.getReversalTxnExternalId();
        if (this$reversalTxnExternalId == null ? other$reversalTxnExternalId != null
                : !this$reversalTxnExternalId.equals(other$reversalTxnExternalId))
            return false;
        final java.lang.Object this$noteText = this.getNoteText();
        final java.lang.Object other$noteText = other.getNoteText();
        if (this$noteText == null ? other$noteText != null : !this$noteText.equals(other$noteText)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
    protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanAdjustmentParameter;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $transactionAmount = this.getTransactionAmount();
        result = result * PRIME + ($transactionAmount == null ? 43 : $transactionAmount.hashCode());
        final java.lang.Object $paymentDetail = this.getPaymentDetail();
        result = result * PRIME + ($paymentDetail == null ? 43 : $paymentDetail.hashCode());
        final java.lang.Object $transactionDate = this.getTransactionDate();
        result = result * PRIME + ($transactionDate == null ? 43 : $transactionDate.hashCode());
        final java.lang.Object $txnExternalId = this.getTxnExternalId();
        result = result * PRIME + ($txnExternalId == null ? 43 : $txnExternalId.hashCode());
        final java.lang.Object $reversalTxnExternalId = this.getReversalTxnExternalId();
        result = result * PRIME + ($reversalTxnExternalId == null ? 43 : $reversalTxnExternalId.hashCode());
        final java.lang.Object $noteText = this.getNoteText();
        result = result * PRIME + ($noteText == null ? 43 : $noteText.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
    public java.lang.String toString() {
        return "LoanAdjustmentParameter(transactionAmount=" + this.getTransactionAmount() + ", paymentDetail=" + this.getPaymentDetail()
                + ", transactionDate=" + this.getTransactionDate() + ", txnExternalId=" + this.getTxnExternalId()
                + ", reversalTxnExternalId=" + this.getReversalTxnExternalId() + ", noteText=" + this.getNoteText() + ")";
    }
}
