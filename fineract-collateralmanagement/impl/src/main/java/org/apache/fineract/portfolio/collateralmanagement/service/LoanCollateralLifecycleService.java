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
package org.apache.fineract.portfolio.collateralmanagement.service;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.apache.fineract.portfolio.collateralmanagement.domain.ClientCollateralManagement;
import org.apache.fineract.portfolio.collateralmanagement.domain.LoanCollateralManagement;
import org.apache.fineract.portfolio.collateralmanagement.domain.LoanCollateralManagementRepository;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransaction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Lifecycle operations for loan↔collateral links after {@link Loan} no longer owns an inverse collection.
 */
@Service
public class LoanCollateralLifecycleService {

    private final LoanCollateralManagementRepository loanCollateralManagementRepository;

    public LoanCollateralLifecycleService(final LoanCollateralManagementRepository loanCollateralManagementRepository) {
        this.loanCollateralManagementRepository = loanCollateralManagementRepository;
    }

    public List<LoanCollateralManagement> findByLoan(final Loan loan) {
        return this.loanCollateralManagementRepository.findByLoanId(loan.getId());
    }

    public Set<LoanCollateralManagement> findByLoanAsSet(final Loan loan) {
        return new HashSet<>(findByLoan(loan));
    }

    @Transactional
    public void associateWithLoan(final Loan loan, final Set<LoanCollateralManagement> collaterals) {
        if (collaterals == null || collaterals.isEmpty()) {
            return;
        }
        for (final LoanCollateralManagement item : collaterals) {
            item.setLoanId(loan.getId());
        }
        this.loanCollateralManagementRepository.saveAll(collaterals);
    }

    /**
     * Replaces all collaterals for the loan (orphan-remove semantics of former {@code Loan.updateLoanCollateral}).
     */
    @Transactional
    public void replaceLoanCollaterals(final Loan loan, final Set<LoanCollateralManagement> collaterals) {
        final List<LoanCollateralManagement> existing = findByLoan(loan);
        if (!existing.isEmpty()) {
            this.loanCollateralManagementRepository.deleteAll(existing);
            this.loanCollateralManagementRepository.flush();
        }
        associateWithLoan(loan, collaterals);
    }

    @Transactional
    public void updateLoanCollateralStatus(final Set<LoanCollateralManagement> loanCollateralManagementSet, final boolean isReleased) {
        if (loanCollateralManagementSet == null || loanCollateralManagementSet.isEmpty()) {
            return;
        }
        for (final LoanCollateralManagement loanCollateralManagement : loanCollateralManagementSet) {
            loanCollateralManagement.setIsReleased(isReleased);
        }
        this.loanCollateralManagementRepository.saveAll(loanCollateralManagementSet);
    }

    @Transactional
    public void updateAndSaveLoanCollateralTransactionsForIndividualAccounts(final Loan loan, final LoanTransaction loanTransaction) {
        if (!loan.getLoanType().isIndividualAccount()) {
            return;
        }
        final List<LoanCollateralManagement> loanCollateralManagements = findByLoan(loan);
        for (final LoanCollateralManagement loanCollateralManagement : loanCollateralManagements) {
            if (loanTransaction != null) {
                loanCollateralManagement.setLoanTransactionData(loanTransaction);
            }
            final ClientCollateralManagement clientCollateralManagement = loanCollateralManagement.getClientCollateralManagement();
            if (loan.getStatus().isClosed()) {
                loanCollateralManagement.setIsReleased(true);
                final BigDecimal quantity = loanCollateralManagement.getQuantity();
                clientCollateralManagement.updateQuantity(clientCollateralManagement.getQuantity().add(quantity));
                loanCollateralManagement.setClientCollateralManagement(clientCollateralManagement);
            }
        }
        this.loanCollateralManagementRepository.saveAll(loanCollateralManagements);
    }
}
