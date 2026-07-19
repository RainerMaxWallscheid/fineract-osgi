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

public class CreditAllocationData implements Serializable {
    private final String transactionType;
    private final List<CreditAllocationOrder> creditAllocationOrder;


    public static class CreditAllocationOrder implements Serializable {
        private final String creditAllocationRule;
        private final Integer order;

        @java.lang.SuppressWarnings("all")
                public String getCreditAllocationRule() {
            return this.creditAllocationRule;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getOrder() {
            return this.order;
        }

        @java.lang.SuppressWarnings("all")
                public CreditAllocationOrder(final String creditAllocationRule, final Integer order) {
            this.creditAllocationRule = creditAllocationRule;
            this.order = order;
        }
    }

    @java.lang.SuppressWarnings("all")
        public String getTransactionType() {
        return this.transactionType;
    }

    @java.lang.SuppressWarnings("all")
        public List<CreditAllocationOrder> getCreditAllocationOrder() {
        return this.creditAllocationOrder;
    }

    @java.lang.SuppressWarnings("all")
        public CreditAllocationData(final String transactionType, final List<CreditAllocationOrder> creditAllocationOrder) {
        this.transactionType = transactionType;
        this.creditAllocationOrder = creditAllocationOrder;
    }
}
