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
package org.apache.fineract.portfolio.loanaccount.moduleapi;

import java.time.LocalDate;
import java.util.Collection;
import org.apache.fineract.infrastructure.core.domain.ExternalId;

/**
 * ID-only loan existence/status check (ADR-021). Foreign BCs must not depend
 * on leftover {@code LoanRepositoryWrapper}.
 */
public interface LoanExistencePort {

    boolean existsById(Long loanId);

    /**
     * Throws {@code LoanNotFoundException} when {@code loanId} is unknown.
     */
    boolean isSubmittedAndPendingApproval(Long loanId);

    /**
     * Throws {@code LoanNotFoundException} when {@code loanId} is unknown.
     */
    String statusCode(Long loanId);

    /**
     * Throws {@code LoanNotFoundException} when {@code loanId} is unknown.
     */
    ExternalId externalId(Long loanId);

    record LoanNoteRef(Long loanId, Long clientId, Long officeId) {}

    record LoanTransactionNoteRef(Long loanId, Long loanTransactionId, Long clientId, Long officeId) {}

    /**
     * Throws {@code LoanNotFoundException} when {@code loanId} is unknown.
     */
    LoanNoteRef require(Long loanId);

    /**
     * Throws {@code LoanTransactionNotFoundException} when {@code loanTransactionId} is unknown.
     */
    LoanTransactionNoteRef requireTransaction(Long loanTransactionId);

    record LoanCalendarDates(LocalDate submittedOnDate, LocalDate approvedOnDate) {}

    /**
     * Throws {@code LoanNotFoundException} when {@code loanId} is unknown.
     */
    LoanCalendarDates requireCalendarDates(Long loanId);

    /**
     * Reschedules loan repayment dates for loans linked to the calendar.
     */
    void applyMeetingDateChanges(Long calendarId, Collection<Long> loanIds, Boolean reschedulebasedOnMeetingDates,
            LocalDate presentMeetingDate, LocalDate newMeetingDate);
}
