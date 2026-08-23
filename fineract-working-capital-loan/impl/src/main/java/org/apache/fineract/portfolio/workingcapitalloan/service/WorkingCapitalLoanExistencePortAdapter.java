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
package org.apache.fineract.portfolio.workingcapitalloan.service;

import java.time.LocalDate;
import java.util.Collection;
import java.util.List;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.portfolio.loanaccount.domain.LoanStatus;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoan;
import org.apache.fineract.portfolio.workingcapitalloan.exception.WorkingCapitalLoanNotFoundException;
import org.apache.fineract.portfolio.workingcapitalloan.moduleapi.WorkingCapitalLoanExistencePort;
import org.apache.fineract.portfolio.workingcapitalloan.repository.WorkingCapitalLoanRepository;
import org.springframework.stereotype.Service;

@Service
public class WorkingCapitalLoanExistencePortAdapter implements WorkingCapitalLoanExistencePort {

    private static final Collection<LoanStatus> NON_CLOSED_LOAN_STATUSES = List.of(LoanStatus.SUBMITTED_AND_PENDING_APPROVAL,
            LoanStatus.APPROVED, LoanStatus.ACTIVE, LoanStatus.TRANSFER_IN_PROGRESS, LoanStatus.TRANSFER_ON_HOLD);

    private final WorkingCapitalLoanRepository workingCapitalLoanRepository;

    public WorkingCapitalLoanExistencePortAdapter(final WorkingCapitalLoanRepository workingCapitalLoanRepository) {
        this.workingCapitalLoanRepository = workingCapitalLoanRepository;
    }

    @Override
    public boolean existsById(final Long loanId) {
        return workingCapitalLoanRepository.existsById(loanId);
    }

    @Override
    public boolean isSubmittedAndPendingApproval(final Long loanId) {
        return requireLoan(loanId).getLoanStatus().isSubmittedAndPendingApproval();
    }

    @Override
    public String statusCode(final Long loanId) {
        return requireLoan(loanId).getLoanStatus().getCode();
    }

    @Override
    public ExternalId externalId(final Long loanId) {
        return requireLoan(loanId).getExternalId();
    }

    @Override
    public Long idByExternalId(final ExternalId externalId) {
        final Long loanId = findIdByExternalId(externalId);
        if (loanId == null) {
            throw new WorkingCapitalLoanNotFoundException(externalId);
        }
        return loanId;
    }

    @Override
    public Long findIdByExternalId(final ExternalId externalId) {
        return workingCapitalLoanRepository.findIdByExternalId(externalId);
    }

    @Override
    public boolean anyBehindCobDate(final LocalDate cobDate, final List<Long> loanIds) {
        if (loanIds == null || loanIds.isEmpty()) {
            return false;
        }
        return !workingCapitalLoanRepository.findAllLoansBehindByLoanIdsAndStatuses(cobDate, loanIds, NON_CLOSED_LOAN_STATUSES).isEmpty()
                || !workingCapitalLoanRepository.findAllLoansBehindOnDisbursementDate(cobDate, loanIds, NON_CLOSED_LOAN_STATUSES).isEmpty();
    }

    private WorkingCapitalLoan requireLoan(final Long loanId) {
        return workingCapitalLoanRepository.findById(loanId).orElseThrow(() -> new WorkingCapitalLoanNotFoundException(loanId));
    }
}
