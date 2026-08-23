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
package org.apache.fineract.portfolio.calendar.domain;

import jakarta.persistence.EntityManager;
import java.util.List;
import org.apache.fineract.portfolio.loanaccount.domain.LoanStatus;

public class CalendarInstanceRepositoryImpl implements CalendarInstanceRepositoryCustom {

    private static final int LOAN_ENTITY_TYPE = CalendarEntityType.LOANS.getValue();
    private static final String ACTIVE_LOAN_STATUSES = LoanStatus.SUBMITTED_AND_PENDING_APPROVAL.getValue() + ", "
            + LoanStatus.APPROVED.getValue() + ", " + LoanStatus.ACTIVE.getValue();

    private final EntityManager entityManager;

    public CalendarInstanceRepositoryImpl(final EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<CalendarInstance> findCalendarInstancesForLoansByGroupIdAndClientIdAndStatuses(Long groupId, Long clientId) {
        return entityManager.createNativeQuery(
                "select ci.* from m_calendar_instance ci where ci.entity_id in (select loan.id from m_loan loan where loan.client_id = ? and loan.group_id = ? and loan.loan_status_id in ("
                        + ACTIVE_LOAN_STATUSES + ")) and ci.entity_type_enum = " + LOAN_ENTITY_TYPE,
                CalendarInstance.class).setParameter(1, clientId).setParameter(2, groupId).getResultList();
    }

    @Override
    public Integer countOfLoansSyncedWithCalendar(Long calendarId) {
        Object result = entityManager.createNativeQuery(
                "select count(ci.id) from m_calendar_instance ci inner join m_loan loan on loan.id = ci.entity_id where ci.entity_type_enum = "
                        + LOAN_ENTITY_TYPE + " and ci.calendar_id = ? and loan.loan_status_id in (" + ACTIVE_LOAN_STATUSES + ")")
                .setParameter(1, calendarId).getSingleResult();
        return result == null ? 0 : ((Number) result).intValue();
    }
}
