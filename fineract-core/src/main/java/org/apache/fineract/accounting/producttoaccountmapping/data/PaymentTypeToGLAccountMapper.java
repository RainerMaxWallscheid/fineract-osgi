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
package org.apache.fineract.accounting.producttoaccountmapping.data;

import java.io.Serializable;
import org.apache.fineract.accounting.glaccount.data.GLAccountData;
import org.apache.fineract.portfolio.paymenttype.data.PaymentTypeData;

public class PaymentTypeToGLAccountMapper implements Serializable {
    private static final long serialVersionUID = 1L;
    private PaymentTypeData paymentType;
    private GLAccountData fundSourceAccount;

    @java.lang.SuppressWarnings("all")
        public PaymentTypeData getPaymentType() {
        return this.paymentType;
    }

    @java.lang.SuppressWarnings("all")
        public GLAccountData getFundSourceAccount() {
        return this.fundSourceAccount;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public PaymentTypeToGLAccountMapper setPaymentType(final PaymentTypeData paymentType) {
        this.paymentType = paymentType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public PaymentTypeToGLAccountMapper setFundSourceAccount(final GLAccountData fundSourceAccount) {
        this.fundSourceAccount = fundSourceAccount;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof PaymentTypeToGLAccountMapper)) return false;
        final PaymentTypeToGLAccountMapper other = (PaymentTypeToGLAccountMapper) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$paymentType = this.getPaymentType();
        final java.lang.Object other$paymentType = other.getPaymentType();
        if (this$paymentType == null ? other$paymentType != null : !this$paymentType.equals(other$paymentType)) return false;
        final java.lang.Object this$fundSourceAccount = this.getFundSourceAccount();
        final java.lang.Object other$fundSourceAccount = other.getFundSourceAccount();
        if (this$fundSourceAccount == null ? other$fundSourceAccount != null : !this$fundSourceAccount.equals(other$fundSourceAccount)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof PaymentTypeToGLAccountMapper;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $paymentType = this.getPaymentType();
        result = result * PRIME + ($paymentType == null ? 43 : $paymentType.hashCode());
        final java.lang.Object $fundSourceAccount = this.getFundSourceAccount();
        result = result * PRIME + ($fundSourceAccount == null ? 43 : $fundSourceAccount.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "PaymentTypeToGLAccountMapper(paymentType=" + this.getPaymentType() + ", fundSourceAccount=" + this.getFundSourceAccount() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public PaymentTypeToGLAccountMapper() {
    }
}
