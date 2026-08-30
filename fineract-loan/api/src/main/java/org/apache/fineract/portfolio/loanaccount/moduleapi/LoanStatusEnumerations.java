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

import org.apache.fineract.portfolio.loanaccount.data.LoanStatusEnumData;
import org.apache.fineract.portfolio.loanaccount.domain.LoanStatus;

/**
 * Leftover-JPA-free loan-status helper for foreign BCs (ADR-021).
 */
public final class LoanStatusEnumerations {

    private LoanStatusEnumerations() {}

    public static LoanStatusEnumData status(final Integer statusId) {
        return status(LoanStatus.fromInt(statusId));
    }

    public static LoanStatusEnumData status(final LoanStatus status) {
        return switch (status) {
            case INVALID -> new LoanStatusEnumData(LoanStatus.INVALID.getValue().longValue(), LoanStatus.INVALID.getCode(), "Invalid");
            case SUBMITTED_AND_PENDING_APPROVAL -> new LoanStatusEnumData(LoanStatus.SUBMITTED_AND_PENDING_APPROVAL.getValue().longValue(),
                    LoanStatus.SUBMITTED_AND_PENDING_APPROVAL.getCode(), "Submitted and pending approval");
            case APPROVED -> new LoanStatusEnumData(LoanStatus.APPROVED.getValue().longValue(), LoanStatus.APPROVED.getCode(), "Approved");
            case ACTIVE -> new LoanStatusEnumData(LoanStatus.ACTIVE.getValue().longValue(), LoanStatus.ACTIVE.getCode(), "Active");
            case REJECTED -> new LoanStatusEnumData(LoanStatus.REJECTED.getValue().longValue(), LoanStatus.REJECTED.getCode(), "Rejected");
            case WITHDRAWN_BY_CLIENT -> new LoanStatusEnumData(LoanStatus.WITHDRAWN_BY_CLIENT.getValue().longValue(),
                    LoanStatus.WITHDRAWN_BY_CLIENT.getCode(), "Withdrawn by applicant");
            case CLOSED_OBLIGATIONS_MET -> new LoanStatusEnumData(LoanStatus.CLOSED_OBLIGATIONS_MET.getValue().longValue(),
                    LoanStatus.CLOSED_OBLIGATIONS_MET.getCode(), "Closed (obligations met)");
            case CLOSED_WRITTEN_OFF -> new LoanStatusEnumData(LoanStatus.CLOSED_WRITTEN_OFF.getValue().longValue(),
                    LoanStatus.CLOSED_WRITTEN_OFF.getCode(), "Closed (written off)");
            case CLOSED_RESCHEDULE_OUTSTANDING_AMOUNT ->
                new LoanStatusEnumData(LoanStatus.CLOSED_RESCHEDULE_OUTSTANDING_AMOUNT.getValue().longValue(),
                        LoanStatus.CLOSED_RESCHEDULE_OUTSTANDING_AMOUNT.getCode(), "Closed (rescheduled)");
            case OVERPAID -> new LoanStatusEnumData(LoanStatus.OVERPAID.getValue().longValue(), LoanStatus.OVERPAID.getCode(), "Overpaid");
            case TRANSFER_IN_PROGRESS -> new LoanStatusEnumData(LoanStatus.TRANSFER_IN_PROGRESS.getValue().longValue(),
                    LoanStatus.TRANSFER_IN_PROGRESS.getCode(), "Transfer in progress");
            case TRANSFER_ON_HOLD -> new LoanStatusEnumData(LoanStatus.TRANSFER_ON_HOLD.getValue().longValue(),
                    LoanStatus.TRANSFER_ON_HOLD.getCode(), "Transfer on hold");
        };
    }
}
