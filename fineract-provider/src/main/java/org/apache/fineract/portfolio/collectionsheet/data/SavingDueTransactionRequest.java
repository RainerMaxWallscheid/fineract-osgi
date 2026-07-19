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

public class SavingDueTransactionRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long savingsId;
    private BigDecimal transactionAmount;
    private Long depositAccountType;
    private Long paymentTypeId;
    private String accountNumber;
    private String checkNumber;
    private String routingCode;
    private String receiptNumber;
    private String bankNumber;


    @java.lang.SuppressWarnings("all")
        public static class SavingDueTransactionRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long savingsId;
        @java.lang.SuppressWarnings("all")
                private BigDecimal transactionAmount;
        @java.lang.SuppressWarnings("all")
                private Long depositAccountType;
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
                SavingDueTransactionRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingDueTransactionRequest.SavingDueTransactionRequestBuilder savingsId(final Long savingsId) {
            this.savingsId = savingsId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingDueTransactionRequest.SavingDueTransactionRequestBuilder transactionAmount(final BigDecimal transactionAmount) {
            this.transactionAmount = transactionAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingDueTransactionRequest.SavingDueTransactionRequestBuilder depositAccountType(final Long depositAccountType) {
            this.depositAccountType = depositAccountType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingDueTransactionRequest.SavingDueTransactionRequestBuilder paymentTypeId(final Long paymentTypeId) {
            this.paymentTypeId = paymentTypeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingDueTransactionRequest.SavingDueTransactionRequestBuilder accountNumber(final String accountNumber) {
            this.accountNumber = accountNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingDueTransactionRequest.SavingDueTransactionRequestBuilder checkNumber(final String checkNumber) {
            this.checkNumber = checkNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingDueTransactionRequest.SavingDueTransactionRequestBuilder routingCode(final String routingCode) {
            this.routingCode = routingCode;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingDueTransactionRequest.SavingDueTransactionRequestBuilder receiptNumber(final String receiptNumber) {
            this.receiptNumber = receiptNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingDueTransactionRequest.SavingDueTransactionRequestBuilder bankNumber(final String bankNumber) {
            this.bankNumber = bankNumber;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public SavingDueTransactionRequest build() {
            return new SavingDueTransactionRequest(this.savingsId, this.transactionAmount, this.depositAccountType, this.paymentTypeId, this.accountNumber, this.checkNumber, this.routingCode, this.receiptNumber, this.bankNumber);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "SavingDueTransactionRequest.SavingDueTransactionRequestBuilder(savingsId=" + this.savingsId + ", transactionAmount=" + this.transactionAmount + ", depositAccountType=" + this.depositAccountType + ", paymentTypeId=" + this.paymentTypeId + ", accountNumber=" + this.accountNumber + ", checkNumber=" + this.checkNumber + ", routingCode=" + this.routingCode + ", receiptNumber=" + this.receiptNumber + ", bankNumber=" + this.bankNumber + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static SavingDueTransactionRequest.SavingDueTransactionRequestBuilder builder() {
        return new SavingDueTransactionRequest.SavingDueTransactionRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getSavingsId() {
        return this.savingsId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTransactionAmount() {
        return this.transactionAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Long getDepositAccountType() {
        return this.depositAccountType;
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
        public void setSavingsId(final Long savingsId) {
        this.savingsId = savingsId;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransactionAmount(final BigDecimal transactionAmount) {
        this.transactionAmount = transactionAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setDepositAccountType(final Long depositAccountType) {
        this.depositAccountType = depositAccountType;
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
        if (!(o instanceof SavingDueTransactionRequest)) return false;
        final SavingDueTransactionRequest other = (SavingDueTransactionRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$savingsId = this.getSavingsId();
        final java.lang.Object other$savingsId = other.getSavingsId();
        if (this$savingsId == null ? other$savingsId != null : !this$savingsId.equals(other$savingsId)) return false;
        final java.lang.Object this$depositAccountType = this.getDepositAccountType();
        final java.lang.Object other$depositAccountType = other.getDepositAccountType();
        if (this$depositAccountType == null ? other$depositAccountType != null : !this$depositAccountType.equals(other$depositAccountType)) return false;
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
        return other instanceof SavingDueTransactionRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $savingsId = this.getSavingsId();
        result = result * PRIME + ($savingsId == null ? 43 : $savingsId.hashCode());
        final java.lang.Object $depositAccountType = this.getDepositAccountType();
        result = result * PRIME + ($depositAccountType == null ? 43 : $depositAccountType.hashCode());
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
        return "SavingDueTransactionRequest(savingsId=" + this.getSavingsId() + ", transactionAmount=" + this.getTransactionAmount() + ", depositAccountType=" + this.getDepositAccountType() + ", paymentTypeId=" + this.getPaymentTypeId() + ", accountNumber=" + this.getAccountNumber() + ", checkNumber=" + this.getCheckNumber() + ", routingCode=" + this.getRoutingCode() + ", receiptNumber=" + this.getReceiptNumber() + ", bankNumber=" + this.getBankNumber() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public SavingDueTransactionRequest() {
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String savingsId = "savingsId";
        public static final java.lang.String transactionAmount = "transactionAmount";
        public static final java.lang.String depositAccountType = "depositAccountType";
        public static final java.lang.String paymentTypeId = "paymentTypeId";
        public static final java.lang.String accountNumber = "accountNumber";
        public static final java.lang.String checkNumber = "checkNumber";
        public static final java.lang.String routingCode = "routingCode";
        public static final java.lang.String receiptNumber = "receiptNumber";
        public static final java.lang.String bankNumber = "bankNumber";
    }

    @java.lang.SuppressWarnings("all")
        public SavingDueTransactionRequest(final Long savingsId, final BigDecimal transactionAmount, final Long depositAccountType, final Long paymentTypeId, final String accountNumber, final String checkNumber, final String routingCode, final String receiptNumber, final String bankNumber) {
        this.savingsId = savingsId;
        this.transactionAmount = transactionAmount;
        this.depositAccountType = depositAccountType;
        this.paymentTypeId = paymentTypeId;
        this.accountNumber = accountNumber;
        this.checkNumber = checkNumber;
        this.routingCode = routingCode;
        this.receiptNumber = receiptNumber;
        this.bankNumber = bankNumber;
    }
}
