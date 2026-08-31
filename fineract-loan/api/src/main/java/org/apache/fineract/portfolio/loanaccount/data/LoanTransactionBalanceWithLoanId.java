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
package org.apache.fineract.portfolio.loanaccount.data;

import java.math.BigDecimal;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransactionType;

/**
 * Loan-scoped transaction balance aggregate.
 * <p>
 * Intentionally <strong>not</strong> a subclass of {@link LoanTransactionBalance}: composition of the same conceptual
 * fields plus {@code loanId}. Fields are flat so JPA {@code CriteriaBuilder.construct} can materialize this type.
 * JSON is flat (same shape as before inheritance, plus {@code loanId}).
 */
public record LoanTransactionBalanceWithLoanId(LoanTransactionType transactionType, boolean reversed, boolean manuallyAdjustedOrReversed,
        BigDecimal amount, Long loanId) implements LoanTransactionBalanceView {

    @Override
    public LoanTransactionType getTransactionType() {
        return transactionType;
    }

    @Override
    public boolean isReversed() {
        return reversed;
    }

    @Override
    public boolean isManuallyAdjustedOrReversed() {
        return manuallyAdjustedOrReversed;
    }

    @Override
    public BigDecimal getAmount() {
        return amount;
    }

    public Long getLoanId() {
        return loanId;
    }

    /** Composition: project to the loan-agnostic balance view. */
    public LoanTransactionBalance toBalance() {
        return new LoanTransactionBalance(transactionType, reversed, manuallyAdjustedOrReversed, amount);
    }
}
