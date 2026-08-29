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
package org.apache.fineract.infrastructure.event.business.domain.savings.transaction;

import org.apache.fineract.infrastructure.event.business.domain.AbstractBusinessEvent;
import org.apache.fineract.portfolio.savings.DepositAccountType;

public abstract class SavingsAccountTransactionBusinessEvent extends AbstractBusinessEvent<Object> {

    private static final String CATEGORY = "Savings";
    private final Long savingsAccountId;
    private final Long transactionId;
    private final Long officeId;
    private final DepositAccountType depositAccountType;

    public SavingsAccountTransactionBusinessEvent(final Object value, final Long savingsAccountId, final Long transactionId,
            final Long officeId, final DepositAccountType depositAccountType) {
        super(value);
        this.savingsAccountId = savingsAccountId;
        this.transactionId = transactionId;
        this.officeId = officeId;
        this.depositAccountType = depositAccountType;
    }

    @Override
    public String getCategory() {
        return CATEGORY;
    }

    @Override
    public Long getAggregateRootId() {
        return savingsAccountId;
    }

    public Long transactionId() {
        return transactionId;
    }

    public Long officeId() {
        return officeId;
    }

    public DepositAccountType depositAccountType() {
        return depositAccountType;
    }
}
