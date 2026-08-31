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
package org.apache.fineract.infrastructure.event.business.domain.loan;

import org.apache.fineract.infrastructure.event.business.domain.AbstractBusinessEvent;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanOwnedEventId;

public class LoanAdjustTransactionBusinessEvent extends AbstractBusinessEvent<LoanAdjustTransactionBusinessEvent.Data> {
    private static final String TYPE = "LoanAdjustTransactionBusinessEvent";
    private static final String CATEGORY = "Loan";

    public LoanAdjustTransactionBusinessEvent(Data value) {
        super(value);
    }

    @Override
    public String getType() {
        return TYPE;
    }

    @Override
    public String getCategory() {
        return CATEGORY;
    }

    @Override
    public Long getAggregateRootId() {
        final Object transaction = get().getTransactionToAdjust();
        if (transaction instanceof LoanOwnedEventId id) {
            return id.getId();
        }
        throw new IllegalStateException("Unsupported loan-adjust transaction payload: "
                + (transaction == null ? "null" : transaction.getClass().getName()));
    }


    public static class Data {
        private final Object transactionToAdjust;
        private Object newTransactionDetail;

        @java.lang.SuppressWarnings("all")
                public Data(final Object transactionToAdjust) {
            this.transactionToAdjust = transactionToAdjust;
        }

        @java.lang.SuppressWarnings("all")
                public Object getTransactionToAdjust() {
            return this.transactionToAdjust;
        }

        @java.lang.SuppressWarnings("all")
                public Object getNewTransactionDetail() {
            return this.newTransactionDetail;
        }

        @java.lang.SuppressWarnings("all")
                public void setNewTransactionDetail(final Object newTransactionDetail) {
            this.newTransactionDetail = newTransactionDetail;
        }
    }
}
