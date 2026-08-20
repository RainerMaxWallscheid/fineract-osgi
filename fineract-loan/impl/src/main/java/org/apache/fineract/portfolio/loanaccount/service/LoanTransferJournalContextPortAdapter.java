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

import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanTransferJournalContextPort;
import org.springframework.stereotype.Service;

@Service
public class LoanTransferJournalContextPortAdapter implements LoanTransferJournalContextPort {

    @Override
    public Long productId(final Object loanObj) {
        return ((Loan) loanObj).productId();
    }

    @Override
    public Long loanId(final Object loanObj) {
        return ((Loan) loanObj).getId();
    }

    @Override
    public Long officeId(final Object loanObj) {
        return ((Loan) loanObj).getOffice().getId();
    }

    @Override
    public Object office(final Object loanObj) {
        return ((Loan) loanObj).getOffice();
    }

    @Override
    public String currencyCode(final Object loanObj) {
        return ((Loan) loanObj).getCurrencyCode();
    }

    @Override
    public boolean chargedOff(final Object loanObj) {
        return ((Loan) loanObj).isChargedOff();
    }

    @Override
    public boolean fraud(final Object loanObj) {
        return ((Loan) loanObj).isFraud();
    }

    @Override
    public Long chargeOffReasonId(final Object loanObj) {
        return ((Loan) loanObj).fetchChargeOffReasonId();
    }
}
