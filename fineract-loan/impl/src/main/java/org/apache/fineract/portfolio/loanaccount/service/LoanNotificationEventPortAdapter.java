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

import java.util.function.Consumer;
import org.apache.fineract.infrastructure.event.business.domain.loan.LoanApprovedBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.loan.LoanChargebackTransactionBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.loan.LoanCloseAsRescheduleBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.loan.LoanCloseBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.loan.LoanCreatedBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.loan.product.LoanProductCreateBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.loan.transaction.LoanTransactionMakeRepaymentPostBusinessEvent;
import org.apache.fineract.infrastructure.event.business.service.BusinessEventNotifierService;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransaction;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanNotificationEventPort;
import org.springframework.stereotype.Service;

@Service
public class LoanNotificationEventPortAdapter implements LoanNotificationEventPort {

    private final BusinessEventNotifierService businessEventNotifierService;

    public LoanNotificationEventPortAdapter(final BusinessEventNotifierService businessEventNotifierService) {
        this.businessEventNotifierService = businessEventNotifierService;
    }

    @Override
    public void onLoanNotifications(final Consumer<LoanNotification> handler) {
        businessEventNotifierService.addPostBusinessEventListener(LoanCreatedBusinessEvent.class, event -> {
            final Loan loan = (Loan) event.get();
            handler.accept(new LoanNotification("APPROVE_LOAN", "loan", loan.getId(), "New loan created", "created", loan.getOfficeId()));
        });
        businessEventNotifierService.addPostBusinessEventListener(LoanApprovedBusinessEvent.class, event -> {
            final Loan loan = (Loan) event.get();
            handler.accept(new LoanNotification("DISBURSE_LOAN", "loan", loan.getId(), "New loan approved", "approved", loan.getOfficeId()));
        });
        businessEventNotifierService.addPostBusinessEventListener(LoanCloseBusinessEvent.class, event -> {
            final Loan loan = (Loan) event.get();
            handler.accept(new LoanNotification("READ_LOAN", "loan", loan.getId(), "Loan closed", "loanClosed", loan.getOfficeId()));
        });
        businessEventNotifierService.addPostBusinessEventListener(LoanCloseAsRescheduleBusinessEvent.class, event -> {
            final Loan loan = (Loan) event.get();
            handler.accept(new LoanNotification("READ_Rescheduled Loans", "loan", loan.getId(), "Loan has been rescheduled",
                    "loanRescheduled", loan.getOfficeId()));
        });
        businessEventNotifierService.addPostBusinessEventListener(LoanChargebackTransactionBusinessEvent.class, event -> {
            final LoanTransaction transaction = (LoanTransaction) event.get();
            handler.accept(new LoanNotification(LoanChargebackTransactionBusinessEvent.LOAN_CHARGEBACK_TRANSACTION_PERMISSION,
                    LoanChargebackTransactionBusinessEvent.LOAN_CHARGEBACK_TRANSACTION_OBJECT_TYPE, transaction.getId(),
                    LoanChargebackTransactionBusinessEvent.LOAN_CHARGEBACK_TRANSACTION_NOTIFICATION,
                    LoanChargebackTransactionBusinessEvent.LOAN_CHARGEBACK_TRANSACTION_EVENT_TYPE, transaction.getLoan().getOfficeId()));
        });
        businessEventNotifierService.addPostBusinessEventListener(LoanTransactionMakeRepaymentPostBusinessEvent.class, event -> {
            final Loan loan = (Loan) ((LoanTransaction) event.get()).getLoan();
            handler.accept(new LoanNotification("READ_LOAN", "loan", loan.getId(), "Repayment made", "repaymentMade", loan.getOfficeId()));
        });
        businessEventNotifierService.addPostBusinessEventListener(LoanProductCreateBusinessEvent.class, event -> handler.accept(
                new LoanNotification("READ_LOANPRODUCT", "loanProduct", event.getAggregateRootId(), "New loan product created", "created", null)));
    }
}
