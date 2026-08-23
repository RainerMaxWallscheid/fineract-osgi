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
package org.apache.fineract.portfolio.loanaccount.service;

import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.domain.LoanRepository;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransaction;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransactionRepository;
import org.apache.fineract.portfolio.loanaccount.exception.LoanNotFoundException;
import org.apache.fineract.portfolio.loanaccount.exception.LoanTransactionNotFoundException;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanExistencePort;
import org.springframework.stereotype.Service;

@Service
public class LoanExistencePortAdapter implements LoanExistencePort {

    private final LoanRepository loanRepository;
    private final LoanTransactionRepository loanTransactionRepository;

    public LoanExistencePortAdapter(final LoanRepository loanRepository, final LoanTransactionRepository loanTransactionRepository) {
        this.loanRepository = loanRepository;
        this.loanTransactionRepository = loanTransactionRepository;
    }

    @Override
    public boolean existsById(final Long loanId) {
        return loanRepository.existsById(loanId);
    }

    @Override
    public boolean isSubmittedAndPendingApproval(final Long loanId) {
        return requireLoan(loanId).isSubmittedAndPendingApproval();
    }

    @Override
    public String statusCode(final Long loanId) {
        return requireLoan(loanId).getStatus().getCode();
    }

    @Override
    public ExternalId externalId(final Long loanId) {
        return requireLoan(loanId).getExternalId();
    }

    @Override
    public LoanNoteRef require(final Long loanId) {
        final Loan loan = requireLoan(loanId);
        return new LoanNoteRef(loan.getId(), loan.getClientId(), loan.getOfficeId());
    }

    @Override
    public LoanTransactionNoteRef requireTransaction(final Long loanTransactionId) {
        final LoanTransaction transaction = loanTransactionRepository.findById(loanTransactionId)
                .orElseThrow(() -> new LoanTransactionNotFoundException(loanTransactionId));
        final Loan loan = transaction.getLoan();
        return new LoanTransactionNoteRef(loan.getId(), transaction.getId(), loan.getClientId(), loan.getOfficeId());
    }

    private Loan requireLoan(final Long loanId) {
        return loanRepository.findById(loanId).orElseThrow(() -> new LoanNotFoundException(loanId));
    }
}
