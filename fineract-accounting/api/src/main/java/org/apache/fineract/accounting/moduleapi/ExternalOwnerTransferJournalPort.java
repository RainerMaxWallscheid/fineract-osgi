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
package org.apache.fineract.accounting.moduleapi;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * Object-typed external-owner transfer journal posting (ADR-021). Lives on
 * accounting-api so loan posters need not depend on leftover
 * {@code JournalEntryWritePlatformService}. Object params avoid accounting-api
 * → loan-api / investor-api cycles.
 */
public interface ExternalOwnerTransferJournalPort {

    void postTransfer(Object loan, Object externalAssetOwnerTransfer, Object previousOwner);

    /**
     * Persists an investor credit journal. Object params avoid leftover
     * {@code JournalEntry} / {@code GLAccount} types on foreign BCs.
     *
     * @return persisted journal entry as {@code Object}
     */
    Object postInvestorCredit(Object office, String currencyCode, Object glAccount, String transactionId, LocalDate transactionDate,
            BigDecimal amount, Long loanId);

    /**
     * Persists an investor debit journal. Object params avoid leftover
     * {@code JournalEntry} / {@code GLAccount} types on foreign BCs.
     *
     * @return persisted journal entry as {@code Object}
     */
    Object postInvestorDebit(Object office, String currencyCode, Object glAccount, String transactionId, LocalDate transactionDate,
            BigDecimal amount, Long loanId);
}
