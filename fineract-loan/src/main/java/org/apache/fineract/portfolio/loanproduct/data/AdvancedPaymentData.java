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
package org.apache.fineract.portfolio.loanproduct.data;

import java.io.Serializable;
import java.util.List;

public class AdvancedPaymentData implements Serializable {
    private final String transactionType;
    private final String futureInstallmentAllocationRule;
    private final List<PaymentAllocationOrder> paymentAllocationOrder;


    public static class PaymentAllocationOrder implements Serializable {
        private final String paymentAllocationRule;
        private final Integer order;

        @java.lang.SuppressWarnings("all")
                public String getPaymentAllocationRule() {
            return this.paymentAllocationRule;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getOrder() {
            return this.order;
        }

        @java.lang.SuppressWarnings("all")
                public PaymentAllocationOrder(final String paymentAllocationRule, final Integer order) {
            this.paymentAllocationRule = paymentAllocationRule;
            this.order = order;
        }
    }

    @java.lang.SuppressWarnings("all")
        public String getTransactionType() {
        return this.transactionType;
    }

    @java.lang.SuppressWarnings("all")
        public String getFutureInstallmentAllocationRule() {
        return this.futureInstallmentAllocationRule;
    }

    @java.lang.SuppressWarnings("all")
        public List<PaymentAllocationOrder> getPaymentAllocationOrder() {
        return this.paymentAllocationOrder;
    }

    @java.lang.SuppressWarnings("all")
        public AdvancedPaymentData(final String transactionType, final String futureInstallmentAllocationRule, final List<PaymentAllocationOrder> paymentAllocationOrder) {
        this.transactionType = transactionType;
        this.futureInstallmentAllocationRule = futureInstallmentAllocationRule;
        this.paymentAllocationOrder = paymentAllocationOrder;
    }
}
