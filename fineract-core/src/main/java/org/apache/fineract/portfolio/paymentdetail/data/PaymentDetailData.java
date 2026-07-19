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
package org.apache.fineract.portfolio.paymentdetail.data;

import java.io.Serializable;
import org.apache.fineract.portfolio.paymenttype.data.PaymentTypeData;

/**
 * Immutable data object representing a payment.
 */
public class PaymentDetailData implements Serializable {
    private final Long id;
    private final PaymentTypeData paymentType;
    private final String accountNumber;
    private final String checkNumber;
    private final String routingCode;
    private final String receiptNumber;
    private final String bankNumber;


    @java.lang.SuppressWarnings("all")
        public static class PaymentDetailDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private PaymentTypeData paymentType;
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
                PaymentDetailDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public PaymentDetailData.PaymentDetailDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public PaymentDetailData.PaymentDetailDataBuilder paymentType(final PaymentTypeData paymentType) {
            this.paymentType = paymentType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public PaymentDetailData.PaymentDetailDataBuilder accountNumber(final String accountNumber) {
            this.accountNumber = accountNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public PaymentDetailData.PaymentDetailDataBuilder checkNumber(final String checkNumber) {
            this.checkNumber = checkNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public PaymentDetailData.PaymentDetailDataBuilder routingCode(final String routingCode) {
            this.routingCode = routingCode;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public PaymentDetailData.PaymentDetailDataBuilder receiptNumber(final String receiptNumber) {
            this.receiptNumber = receiptNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public PaymentDetailData.PaymentDetailDataBuilder bankNumber(final String bankNumber) {
            this.bankNumber = bankNumber;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public PaymentDetailData build() {
            return new PaymentDetailData(this.id, this.paymentType, this.accountNumber, this.checkNumber, this.routingCode, this.receiptNumber, this.bankNumber);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "PaymentDetailData.PaymentDetailDataBuilder(id=" + this.id + ", paymentType=" + this.paymentType + ", accountNumber=" + this.accountNumber + ", checkNumber=" + this.checkNumber + ", routingCode=" + this.routingCode + ", receiptNumber=" + this.receiptNumber + ", bankNumber=" + this.bankNumber + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static PaymentDetailData.PaymentDetailDataBuilder builder() {
        return new PaymentDetailData.PaymentDetailDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public PaymentTypeData getPaymentType() {
        return this.paymentType;
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

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof PaymentDetailData)) return false;
        final PaymentDetailData other = (PaymentDetailData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$paymentType = this.getPaymentType();
        final java.lang.Object other$paymentType = other.getPaymentType();
        if (this$paymentType == null ? other$paymentType != null : !this$paymentType.equals(other$paymentType)) return false;
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
        return other instanceof PaymentDetailData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $paymentType = this.getPaymentType();
        result = result * PRIME + ($paymentType == null ? 43 : $paymentType.hashCode());
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

    @java.lang.SuppressWarnings("all")
        public PaymentDetailData(final Long id, final PaymentTypeData paymentType, final String accountNumber, final String checkNumber, final String routingCode, final String receiptNumber, final String bankNumber) {
        this.id = id;
        this.paymentType = paymentType;
        this.accountNumber = accountNumber;
        this.checkNumber = checkNumber;
        this.routingCode = routingCode;
        this.receiptNumber = receiptNumber;
        this.bankNumber = bankNumber;
    }
}
