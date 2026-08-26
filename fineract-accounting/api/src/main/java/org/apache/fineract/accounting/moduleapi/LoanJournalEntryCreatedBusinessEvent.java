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

import org.apache.fineract.infrastructure.event.business.domain.AbstractBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.NoExternalEvent;

/**
 * Loan journal-created event wrapping journal-entry and loan-transaction ids
 * (no leftover {@code JournalEntry} JPA on accounting-api).
 */
public class LoanJournalEntryCreatedBusinessEvent extends AbstractBusinessEvent<Long> implements NoExternalEvent {

    private static final String TYPE = "JournalEntryCreatedBusinessEvent";
    private static final String CATEGORY = "Accounting";

    private final Long loanTransactionId;

    public LoanJournalEntryCreatedBusinessEvent(final Long journalEntryId, final Long loanTransactionId) {
        super(journalEntryId);
        this.loanTransactionId = loanTransactionId;
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
        return loanTransactionId;
    }
}
