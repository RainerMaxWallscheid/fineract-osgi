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

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.function.Consumer;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.infrastructure.event.business.domain.loan.LoanApprovedBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.loan.LoanRejectedBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.loan.transaction.LoanTransactionMakeRepaymentPostBusinessEvent;
import org.apache.fineract.infrastructure.event.business.service.BusinessEventNotifierService;
import org.apache.fineract.portfolio.calendar.domain.Calendar;
import org.apache.fineract.portfolio.calendar.domain.CalendarRepositoryWrapper;
import org.apache.fineract.portfolio.loanaccount.domain.GLIMAccountInfoRepository;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.domain.LoanRepository;
import org.apache.fineract.portfolio.loanaccount.domain.LoanStatus;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransaction;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransactionRepository;
import org.apache.fineract.portfolio.loanaccount.exception.LoanNotFoundException;
import org.apache.fineract.portfolio.loanaccount.exception.LoanTransactionNotFoundException;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanExistencePort;
import org.apache.fineract.portfolio.loanaccount.rescheduleloan.domain.LoanRescheduleRequestRepository;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

@Service
public class LoanExistencePortAdapter implements LoanExistencePort {

    private static final Collection<LoanStatus> NON_CLOSED_LOAN_STATUSES = List.of(LoanStatus.SUBMITTED_AND_PENDING_APPROVAL,
            LoanStatus.APPROVED, LoanStatus.ACTIVE, LoanStatus.TRANSFER_IN_PROGRESS, LoanStatus.TRANSFER_ON_HOLD);

    private final LoanRepository loanRepository;
    private final LoanTransactionRepository loanTransactionRepository;
    private final CalendarRepositoryWrapper calendarRepositoryWrapper;
    private final LoanWritePlatformService loanWritePlatformService;
    private final LoanRescheduleRequestRepository loanRescheduleRequestRepository;
    private final GLIMAccountInfoRepository glimAccountInfoRepository;
    private final BusinessEventNotifierService businessEventNotifierService;

    public LoanExistencePortAdapter(final LoanRepository loanRepository, final LoanTransactionRepository loanTransactionRepository,
            final CalendarRepositoryWrapper calendarRepositoryWrapper, @Lazy final LoanWritePlatformService loanWritePlatformService,
            final LoanRescheduleRequestRepository loanRescheduleRequestRepository,
            final GLIMAccountInfoRepository glimAccountInfoRepository, final BusinessEventNotifierService businessEventNotifierService) {
        this.loanRepository = loanRepository;
        this.loanTransactionRepository = loanTransactionRepository;
        this.calendarRepositoryWrapper = calendarRepositoryWrapper;
        this.loanWritePlatformService = loanWritePlatformService;
        this.loanRescheduleRequestRepository = loanRescheduleRequestRepository;
        this.glimAccountInfoRepository = glimAccountInfoRepository;
        this.businessEventNotifierService = businessEventNotifierService;
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

    @Override
    public LoanCalendarDates requireCalendarDates(final Long loanId) {
        final Loan loan = requireLoan(loanId);
        return new LoanCalendarDates(loan.getSubmittedOnDate(), loan.getApprovedOnDate());
    }

    @Override
    public void applyMeetingDateChanges(final Long calendarId, final Collection<Long> loanIds, final Boolean reschedulebasedOnMeetingDates,
            final LocalDate presentMeetingDate, final LocalDate newMeetingDate) {
        final Calendar calendar = this.calendarRepositoryWrapper.findOneWithNotFoundDetection(calendarId);
        final List<Long> ids = loanIds == null ? List.of() : new ArrayList<>(loanIds);
        this.loanWritePlatformService.applyMeetingDateChangesForLoanIds(calendar, ids, reschedulebasedOnMeetingDates, presentMeetingDate,
                newMeetingDate);
    }

    @Override
    public LoanTransactionCollateralRef requireTransactionCollateral(final Long loanTransactionId) {
        final LoanTransaction transaction = loanTransactionRepository.findById(loanTransactionId)
                .orElseThrow(() -> new LoanTransactionNotFoundException(loanTransactionId));
        return new LoanTransactionCollateralRef(transaction.getLoan().getId(), transaction.getCreatedDate().orElse(null),
                transaction.getOutstandingLoanBalance(), transaction.getPrincipalPortion());
    }

    @Override
    public Long requireNonClosedIdByAccountNumber(final String accountNumber) {
        final Loan loan = loanRepository.findLoanByAccountNumberAndStatuses(accountNumber, NON_CLOSED_LOAN_STATUSES);
        if (loan == null) {
            throw new LoanNotFoundException(accountNumber);
        }
        return loan.getId();
    }

    @Override
    public Long findIdByExternalId(final ExternalId externalId) {
        return loanRepository.findIdByExternalId(externalId);
    }

    @Override
    public Long findIdByRescheduleRequestId(final Long rescheduleRequestId) {
        return loanRescheduleRequestRepository.getLoanIdByRescheduleRequestId(rescheduleRequestId).orElse(null);
    }

    @Override
    public List<Long> findGlimChildLoanIds(final Long glimAccountId) {
        final List<Long> ids = glimAccountInfoRepository.findChildLoanIdsByIsAcceptingChildAndApplicationId(true,
                BigDecimal.valueOf(glimAccountId));
        return ids == null ? List.of() : ids;
    }

    @Override
    public CampaignSource campaignSource(final Object loan) {
        final Loan leftover = (Loan) loan;
        return new CampaignSource(leftover.getId(), leftover.getClientId(), leftover.getGroupId(), leftover.isGroupLoan(),
                leftover.hasInvalidLoanType());
    }

    @Override
    public RepaymentSmsView repaymentSmsView(final Object loanTransaction) {
        final LoanTransaction transaction = (LoanTransaction) loanTransaction;
        final Loan loan = transaction.getLoan();
        final String receiptNumber = transaction.getPaymentDetail() != null ? transaction.getPaymentDetail().getReceiptNumber() : null;
        return new RepaymentSmsView(loan.getId(), transaction.getId(), loan.getClientId(), loan.getGroupId(), loan.hasInvalidLoanType(),
                loan.isGroupLoan(), loan.isIndividualLoan(), loan.getPrincipal(), transaction.getOutstandingLoanBalance(),
                loan.getAccountNumber(), transaction.getAmount(loan.getCurrency()), transaction.getCreatedDate().orElse(null),
                receiptNumber);
    }

    @Override
    public List<Long> openIdsByClientId(final Long clientId) {
        return loanRepository.findLoanByClientId(clientId).stream().filter(Loan::isOpen).map(Loan::getId).toList();
    }

    @Override
    public void onApproved(final Consumer<Object> handler) {
        businessEventNotifierService.addPostBusinessEventListener(LoanApprovedBusinessEvent.class, event -> handler.accept(event.get()));
    }

    @Override
    public void onRejected(final Consumer<Object> handler) {
        businessEventNotifierService.addPostBusinessEventListener(LoanRejectedBusinessEvent.class, event -> handler.accept(event.get()));
    }

    @Override
    public void onRepayment(final Consumer<Object> handler) {
        businessEventNotifierService.addPostBusinessEventListener(LoanTransactionMakeRepaymentPostBusinessEvent.class,
                event -> handler.accept(event.get()));
    }

    private Loan requireLoan(final Long loanId) {
        return loanRepository.findById(loanId).orElseThrow(() -> new LoanNotFoundException(loanId));
    }
}
