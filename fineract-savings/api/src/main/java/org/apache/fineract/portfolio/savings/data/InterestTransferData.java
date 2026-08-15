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
package org.apache.fineract.portfolio.savings.data;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * ID-only interest-to-savings transfer row. Avoids leftover provider
 * {@code AccountTransferDTO} entity edges so the transfer job can live in
 * savings-impl.
 */
public final class InterestTransferData {

    private final LocalDate transactionDate;
    private final BigDecimal transactionAmount;
    private final Long fromAccountId;
    private final Long toAccountId;
    private final boolean isRegularTransaction;
    private final boolean isExceptionForBalanceCheck;

    public InterestTransferData(final LocalDate transactionDate, final BigDecimal transactionAmount, final Long fromAccountId,
            final Long toAccountId, final boolean isRegularTransaction, final boolean isExceptionForBalanceCheck) {
        this.transactionDate = transactionDate;
        this.transactionAmount = transactionAmount;
        this.fromAccountId = fromAccountId;
        this.toAccountId = toAccountId;
        this.isRegularTransaction = isRegularTransaction;
        this.isExceptionForBalanceCheck = isExceptionForBalanceCheck;
    }

    public LocalDate getTransactionDate() {
        return this.transactionDate;
    }

    public BigDecimal getTransactionAmount() {
        return this.transactionAmount;
    }

    public Long getFromAccountId() {
        return this.fromAccountId;
    }

    public Long getToAccountId() {
        return this.toAccountId;
    }

    public boolean isRegularTransaction() {
        return this.isRegularTransaction;
    }

    public boolean isExceptionForBalanceCheck() {
        return this.isExceptionForBalanceCheck;
    }
}
