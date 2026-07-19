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
package org.apache.fineract.portfolio.collectionsheet.data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;

public class RepaymentTransactionRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long loanId;
    private BigDecimal transactionAmount;
    private Long paymentTypeId;
    private String accountNumber;
    private String checkNumber;
    private String routingCode;
    private String receiptNumber;
    private String bankNumber;


    @java.lang.SuppressWarnings("all")
        public static class RepaymentTransactionRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long loanId;
        @java.lang.SuppressWarnings("all")
                private BigDecimal transactionAmount;
        @java.lang.SuppressWarnings("all")
                private Long paymentTypeId;
        @java.lang.SuppressWarnings("all")
                private String accountNumber;
        @java.lang.SuppressWarnings("all")
                private String checkNumber;
        @java.lang.SuppressWarnings("all")
                private String routingCode;
        @java.lang.SuppressWarnings("all")
                private String receiptNumber;
        @java.lang.SuppressWarnings("all")
                private String bankNumber;

        @java.lang.SuppressWarnings("all")
                RepaymentTransactionRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public RepaymentTransactionRequest.RepaymentTransactionRequestBuilder loanId(final Long loanId) {
            this.loanId = loanId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public RepaymentTransactionRequest.RepaymentTransactionRequestBuilder transactionAmount(final BigDecimal transactionAmount) {
            this.transactionAmount = transactionAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public RepaymentTransactionRequest.RepaymentTransactionRequestBuilder paymentTypeId(final Long paymentTypeId) {
            this.paymentTypeId = paymentTypeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public RepaymentTransactionRequest.RepaymentTransactionRequestBuilder accountNumber(final String accountNumber) {
            this.accountNumber = accountNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public RepaymentTransactionRequest.RepaymentTransactionRequestBuilder checkNumber(final String checkNumber) {
            this.checkNumber = checkNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public RepaymentTransactionRequest.RepaymentTransactionRequestBuilder routingCode(final String routingCode) {
            this.routingCode = routingCode;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public RepaymentTransactionRequest.RepaymentTransactionRequestBuilder receiptNumber(final String receiptNumber) {
            this.receiptNumber = receiptNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public RepaymentTransactionRequest.RepaymentTransactionRequestBuilder bankNumber(final String bankNumber) {
            this.bankNumber = bankNumber;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public RepaymentTransactionRequest build() {
            return new RepaymentTransactionRequest(this.loanId, this.transactionAmount, this.paymentTypeId, this.accountNumber, this.checkNumber, this.routingCode, this.receiptNumber, this.bankNumber);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "RepaymentTransactionRequest.RepaymentTransactionRequestBuilder(loanId=" + this.loanId + ", transactionAmount=" + this.transactionAmount + ", paymentTypeId=" + this.paymentTypeId + ", accountNumber=" + this.accountNumber + ", checkNumber=" + this.checkNumber + ", routingCode=" + this.routingCode + ", receiptNumber=" + this.receiptNumber + ", bankNumber=" + this.bankNumber + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static RepaymentTransactionRequest.RepaymentTransactionRequestBuilder builder() {
        return new RepaymentTransactionRequest.RepaymentTransactionRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTransactionAmount() {
        return this.transactionAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Long getPaymentTypeId() {
        return this.paymentTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getAccountNumber() {
        return this.accountNumber;
    }

    @java.lang.SuppressWarnings("all")
        public String getCheckNumber() {
        return this.checkNumber;
    }

    @java.lang.SuppressWarnings("all")
        public String getRoutingCode() {
        return this.routingCode;
    }

    @java.lang.SuppressWarnings("all")
        public String getReceiptNumber() {
        return this.receiptNumber;
    }

    @java.lang.SuppressWarnings("all")
        public String getBankNumber() {
        return this.bankNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanId(final Long loanId) {
        this.loanId = loanId;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransactionAmount(final BigDecimal transactionAmount) {
        this.transactionAmount = transactionAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setPaymentTypeId(final Long paymentTypeId) {
        this.paymentTypeId = paymentTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setAccountNumber(final String accountNumber) {
        this.accountNumber = accountNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setCheckNumber(final String checkNumber) {
        this.checkNumber = checkNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setRoutingCode(final String routingCode) {
        this.routingCode = routingCode;
    }

    @java.lang.SuppressWarnings("all")
        public void setReceiptNumber(final String receiptNumber) {
        this.receiptNumber = receiptNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setBankNumber(final String bankNumber) {
        this.bankNumber = bankNumber;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof RepaymentTransactionRequest)) return false;
        final RepaymentTransactionRequest other = (RepaymentTransactionRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$loanId = this.getLoanId();
        final java.lang.Object other$loanId = other.getLoanId();
        if (this$loanId == null ? other$loanId != null : !this$loanId.equals(other$loanId)) return false;
        final java.lang.Object this$paymentTypeId = this.getPaymentTypeId();
        final java.lang.Object other$paymentTypeId = other.getPaymentTypeId();
        if (this$paymentTypeId == null ? other$paymentTypeId != null : !this$paymentTypeId.equals(other$paymentTypeId)) return false;
        final java.lang.Object this$transactionAmount = this.getTransactionAmount();
        final java.lang.Object other$transactionAmount = other.getTransactionAmount();
        if (this$transactionAmount == null ? other$transactionAmount != null : !this$transactionAmount.equals(other$transactionAmount)) return false;
        final java.lang.Object this$accountNumber = this.getAccountNumber();
        final java.lang.Object other$accountNumber = other.getAccountNumber();
        if (this$accountNumber == null ? other$accountNumber != null : !this$accountNumber.equals(other$accountNumber)) return false;
        final java.lang.Object this$checkNumber = this.getCheckNumber();
        final java.lang.Object other$checkNumber = other.getCheckNumber();
        if (this$checkNumber == null ? other$checkNumber != null : !this$checkNumber.equals(other$checkNumber)) return false;
        final java.lang.Object this$routingCode = this.getRoutingCode();
        final java.lang.Object other$routingCode = other.getRoutingCode();
        if (this$routingCode == null ? other$routingCode != null : !this$routingCode.equals(other$routingCode)) return false;
        final java.lang.Object this$receiptNumber = this.getReceiptNumber();
        final java.lang.Object other$receiptNumber = other.getReceiptNumber();
        if (this$receiptNumber == null ? other$receiptNumber != null : !this$receiptNumber.equals(other$receiptNumber)) return false;
        final java.lang.Object this$bankNumber = this.getBankNumber();
        final java.lang.Object other$bankNumber = other.getBankNumber();
        if (this$bankNumber == null ? other$bankNumber != null : !this$bankNumber.equals(other$bankNumber)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof RepaymentTransactionRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $loanId = this.getLoanId();
        result = result * PRIME + ($loanId == null ? 43 : $loanId.hashCode());
        final java.lang.Object $paymentTypeId = this.getPaymentTypeId();
        result = result * PRIME + ($paymentTypeId == null ? 43 : $paymentTypeId.hashCode());
        final java.lang.Object $transactionAmount = this.getTransactionAmount();
        result = result * PRIME + ($transactionAmount == null ? 43 : $transactionAmount.hashCode());
        final java.lang.Object $accountNumber = this.getAccountNumber();
        result = result * PRIME + ($accountNumber == null ? 43 : $accountNumber.hashCode());
        final java.lang.Object $checkNumber = this.getCheckNumber();
        result = result * PRIME + ($checkNumber == null ? 43 : $checkNumber.hashCode());
        final java.lang.Object $routingCode = this.getRoutingCode();
        result = result * PRIME + ($routingCode == null ? 43 : $routingCode.hashCode());
        final java.lang.Object $receiptNumber = this.getReceiptNumber();
        result = result * PRIME + ($receiptNumber == null ? 43 : $receiptNumber.hashCode());
        final java.lang.Object $bankNumber = this.getBankNumber();
        result = result * PRIME + ($bankNumber == null ? 43 : $bankNumber.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "RepaymentTransactionRequest(loanId=" + this.getLoanId() + ", transactionAmount=" + this.getTransactionAmount() + ", paymentTypeId=" + this.getPaymentTypeId() + ", accountNumber=" + this.getAccountNumber() + ", checkNumber=" + this.getCheckNumber() + ", routingCode=" + this.getRoutingCode() + ", receiptNumber=" + this.getReceiptNumber() + ", bankNumber=" + this.getBankNumber() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public RepaymentTransactionRequest() {
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String loanId = "loanId";
        public static final java.lang.String transactionAmount = "transactionAmount";
        public static final java.lang.String paymentTypeId = "paymentTypeId";
        public static final java.lang.String accountNumber = "accountNumber";
        public static final java.lang.String checkNumber = "checkNumber";
        public static final java.lang.String routingCode = "routingCode";
        public static final java.lang.String receiptNumber = "receiptNumber";
        public static final java.lang.String bankNumber = "bankNumber";
    }

    @java.lang.SuppressWarnings("all")
        public RepaymentTransactionRequest(final Long loanId, final BigDecimal transactionAmount, final Long paymentTypeId, final String accountNumber, final String checkNumber, final String routingCode, final String receiptNumber, final String bankNumber) {
        this.loanId = loanId;
        this.transactionAmount = transactionAmount;
        this.paymentTypeId = paymentTypeId;
        this.accountNumber = accountNumber;
        this.checkNumber = checkNumber;
        this.routingCode = routingCode;
        this.receiptNumber = receiptNumber;
        this.bankNumber = bankNumber;
    }
}
