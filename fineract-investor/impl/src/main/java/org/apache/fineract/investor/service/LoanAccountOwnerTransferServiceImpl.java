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
package org.apache.fineract.investor.service;

import static org.apache.fineract.infrastructure.core.service.DateUtils.getBusinessLocalDate;
import static org.apache.fineract.investor.data.ExternalTransferStatus.ACTIVE;
import static org.apache.fineract.investor.data.ExternalTransferStatus.ACTIVE_INTERMEDIATE;
import static org.apache.fineract.investor.data.ExternalTransferStatus.BUYBACK;
import static org.apache.fineract.investor.data.ExternalTransferStatus.BUYBACK_INTERMEDIATE;
import static org.apache.fineract.investor.data.ExternalTransferStatus.CANCELLED;
import static org.apache.fineract.investor.data.ExternalTransferStatus.DECLINED;
import static org.apache.fineract.investor.data.ExternalTransferStatus.PENDING;
import static org.apache.fineract.investor.data.ExternalTransferStatus.PENDING_INTERMEDIATE;
import static org.apache.fineract.investor.data.ExternalTransferSubStatus.BALANCE_NEGATIVE;
import static org.apache.fineract.investor.data.ExternalTransferSubStatus.BALANCE_ZERO;
import static org.apache.fineract.investor.data.ExternalTransferSubStatus.SAMEDAY_TRANSFERS;
import static org.apache.fineract.investor.data.ExternalTransferSubStatus.UNSOLD;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import org.apache.fineract.infrastructure.core.service.MathUtil;
import org.apache.fineract.infrastructure.event.business.domain.loan.LoanAccountSnapshotBusinessEvent;
import org.apache.fineract.infrastructure.event.business.service.BusinessEventNotifierService;
import org.apache.fineract.investor.data.ExternalTransferSubStatus;
import org.apache.fineract.investor.domain.ExternalAssetOwnerTransfer;
import org.apache.fineract.investor.domain.ExternalAssetOwnerTransferDetails;
import org.apache.fineract.investor.domain.ExternalAssetOwnerTransferLoanMappingRepository;
import org.apache.fineract.investor.domain.ExternalAssetOwnerTransferRepository;
import org.apache.fineract.investor.domain.LoanOwnershipTransferBusinessEvent;
import org.apache.fineract.accounting.moduleapi.ExternalOwnerTransferJournalPort;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanTransferBalancePort;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanTransferSnapshotPort;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@Transactional
public class LoanAccountOwnerTransferServiceImpl implements LoanAccountOwnerTransferService {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(LoanAccountOwnerTransferServiceImpl.class);
    public static final LocalDate FUTURE_DATE_9999_12_31 = LocalDate.of(9999, 12, 31);
    private final ExternalAssetOwnerTransferRepository externalAssetOwnerTransferRepository;
    private final ExternalAssetOwnerTransferLoanMappingRepository externalAssetOwnerTransferLoanMappingRepository;
    private final ExternalOwnerTransferJournalPort externalOwnerTransferJournalPort;
    private final BusinessEventNotifierService businessEventNotifierService;
    private final ExternalAssetOwnerTransferOutstandingInterestCalculation externalAssetOwnerTransferOutstandingInterestCalculation;
    private final LoanTransferSnapshotPort loanTransferSnapshotPort;
    private final LoanTransferBalancePort loanTransferBalancePort;

    @Override
    public void handleLoanClosedOrOverpaid(Loan loan) {
        Long loanId = loanTransferBalancePort.loanId(loan);
        List<ExternalAssetOwnerTransfer> transferDataList = findAllPendingOrBuybackOrIntermediateTransfers(loanId);
        if (transferDataList.size() > 1) {
            if (isSameDayTransfers(transferDataList)) {
                transferDataList.forEach(externalAssetOwnerTransfer -> cancelTransfer(loan, externalAssetOwnerTransfer, SAMEDAY_TRANSFERS));
            } else {
                // decline first and cancel the rest
                declineTransfer(loan, transferDataList.get(0));
                transferDataList.stream().skip(1).forEach(assetOwnerTransfer -> cancelTransfer(loan, assetOwnerTransfer, UNSOLD));
            }
        } else if (transferDataList.size() == 1) {
            ExternalAssetOwnerTransfer transfer = transferDataList.get(0);
            if (PENDING.equals(transfer.getStatus()) || PENDING_INTERMEDIATE.equals(transfer.getStatus())) {
                declineTransfer(loan, transfer);
            } else if (BUYBACK.equals(transfer.getStatus()) || BUYBACK_INTERMEDIATE.equals(transfer.getStatus())) {
                executePendingBuybackTransfer(loan, transfer);
            }
        }
    }

    private void cancelTransfer(Loan loan, ExternalAssetOwnerTransfer pendingTransfer, ExternalTransferSubStatus subStatus) {
        updatePendingTransfer(pendingTransfer);
        ExternalAssetOwnerTransfer cancelledTransfer = createCancelledTransfer(pendingTransfer, subStatus);
        businessEventNotifierService.notifyPostBusinessEvent(new LoanOwnershipTransferBusinessEvent(cancelledTransfer, loan));
    }

    private void declineTransfer(Loan loan, ExternalAssetOwnerTransfer pendingTransfer) {
        ExternalAssetOwnerTransfer declinedSaleTransfer = createDeclinedTransfer(pendingTransfer, loan);
        updatePendingTransfer(pendingTransfer);
        businessEventNotifierService.notifyPostBusinessEvent(new LoanOwnershipTransferBusinessEvent(declinedSaleTransfer, loan));
    }

    private void executePendingBuybackTransfer(final Loan loan, ExternalAssetOwnerTransfer buybackTransfer) {
        ExternalAssetOwnerTransfer activeTransfer = findActiveOrActiveIntermediateTransfer(loan, buybackTransfer);
        updateActiveTransfer(activeTransfer);
        buybackTransfer = updatePendingBuybackTransfer(loan, buybackTransfer);
        externalAssetOwnerTransferLoanMappingRepository.deleteByLoanIdAndOwnerTransfer(loanTransferBalancePort.loanId(loan), activeTransfer);
        externalOwnerTransferJournalPort.postTransfer(loan, buybackTransfer, null);
        businessEventNotifierService.notifyPostBusinessEvent(new LoanOwnershipTransferBusinessEvent(buybackTransfer, loan));
        businessEventNotifierService.notifyPostBusinessEvent(new LoanAccountSnapshotBusinessEvent(loan));
    }

    private ExternalAssetOwnerTransfer createCancelledTransfer(ExternalAssetOwnerTransfer pendingTransfer, ExternalTransferSubStatus subStatus) {
        ExternalAssetOwnerTransfer cancelledTransfer = new ExternalAssetOwnerTransfer();
        cancelledTransfer.setOwner(pendingTransfer.getOwner());
        cancelledTransfer.setExternalId(pendingTransfer.getExternalId());
        cancelledTransfer.setExternalGroupId(pendingTransfer.getExternalGroupId());
        cancelledTransfer.setStatus(CANCELLED);
        cancelledTransfer.setSubStatus(subStatus);
        cancelledTransfer.setSettlementDate(pendingTransfer.getSettlementDate());
        cancelledTransfer.setLoanId(pendingTransfer.getLoanId());
        cancelledTransfer.setExternalLoanId(pendingTransfer.getExternalLoanId());
        cancelledTransfer.setPurchasePriceRatio(pendingTransfer.getPurchasePriceRatio());
        cancelledTransfer.setEffectiveDateFrom(getBusinessLocalDate());
        cancelledTransfer.setEffectiveDateTo(getBusinessLocalDate());
        return externalAssetOwnerTransferRepository.save(cancelledTransfer);
    }

    private ExternalAssetOwnerTransfer createDeclinedTransfer(ExternalAssetOwnerTransfer pendingSaleTransfer, Loan loan) {
        ExternalAssetOwnerTransfer declinedTransfer = new ExternalAssetOwnerTransfer();
        declinedTransfer.setOwner(pendingSaleTransfer.getOwner());
        declinedTransfer.setExternalId(pendingSaleTransfer.getExternalId());
        declinedTransfer.setExternalGroupId(pendingSaleTransfer.getExternalGroupId());
        declinedTransfer.setStatus(DECLINED);
        declinedTransfer.setSubStatus(isBiggerThanZero(loanTransferSnapshotPort.totalOverpaid(loan)) ? BALANCE_NEGATIVE : BALANCE_ZERO);
        declinedTransfer.setSettlementDate(pendingSaleTransfer.getSettlementDate());
        declinedTransfer.setLoanId(pendingSaleTransfer.getLoanId());
        declinedTransfer.setExternalLoanId(pendingSaleTransfer.getExternalLoanId());
        declinedTransfer.setPurchasePriceRatio(pendingSaleTransfer.getPurchasePriceRatio());
        declinedTransfer.setEffectiveDateFrom(getBusinessLocalDate());
        declinedTransfer.setEffectiveDateTo(getBusinessLocalDate());
        return externalAssetOwnerTransferRepository.save(declinedTransfer);
    }

    private void updatePendingTransfer(ExternalAssetOwnerTransfer pendingTransfer) {
        pendingTransfer.setEffectiveDateTo(getBusinessLocalDate());
        externalAssetOwnerTransferRepository.save(pendingTransfer);
    }

    private ExternalAssetOwnerTransfer updatePendingBuybackTransfer(Loan loan, ExternalAssetOwnerTransfer buybackTransfer) {
        buybackTransfer.setEffectiveDateTo(getBusinessLocalDate());
        buybackTransfer.setExternalAssetOwnerTransferDetails(createAssetOwnerTransferDetails(loan, buybackTransfer));
        return externalAssetOwnerTransferRepository.save(buybackTransfer);
    }

    private void updateActiveTransfer(ExternalAssetOwnerTransfer activeTransfer) {
        activeTransfer.setEffectiveDateTo(getBusinessLocalDate());
        externalAssetOwnerTransferRepository.save(activeTransfer);
    }

    private ExternalAssetOwnerTransferDetails createAssetOwnerTransferDetails(final Object loan,
            final ExternalAssetOwnerTransfer externalAssetOwnerTransfer) {
        ExternalAssetOwnerTransferDetails details = new ExternalAssetOwnerTransferDetails();
        details.setExternalAssetOwnerTransfer(externalAssetOwnerTransfer);
        details.setTotalPrincipalOutstanding(loanTransferSnapshotPort.totalPrincipalOutstanding(loan));
        final BigDecimal interestAmount = externalAssetOwnerTransferOutstandingInterestCalculation.calculateOutstandingInterest(loan);
        details.setTotalInterestOutstanding(interestAmount);
        details.setTotalFeeChargesOutstanding(loanTransferSnapshotPort.totalFeeChargesOutstanding(loan));
        details.setTotalPenaltyChargesOutstanding(loanTransferSnapshotPort.totalPenaltyChargesOutstanding(loan));
        details.setTotalOverpaid(loanTransferSnapshotPort.totalOverpaid(loan));
        return details;
    }

    private ExternalAssetOwnerTransfer findActiveOrActiveIntermediateTransfer(Loan loan, ExternalAssetOwnerTransfer buybackTransfer) {
        return externalAssetOwnerTransferRepository.findOne((root, query, criteriaBuilder) -> criteriaBuilder.and(criteriaBuilder.equal(root.get("loanId"), loanTransferBalancePort.loanId(loan)), criteriaBuilder.equal(root.get("owner"), buybackTransfer.getOwner()), root.get("status").in(List.of(ACTIVE, ACTIVE_INTERMEDIATE)), criteriaBuilder.equal(root.get("effectiveDateTo"), FUTURE_DATE_9999_12_31))).orElseThrow();
    }

    private List<ExternalAssetOwnerTransfer> findAllPendingOrBuybackOrIntermediateTransfers(Long loanId) {
        return externalAssetOwnerTransferRepository.findAll((root, query, criteriaBuilder) -> criteriaBuilder.and(criteriaBuilder.equal(root.get("loanId"), loanId), root.get("status").in(List.of(PENDING, BUYBACK, PENDING_INTERMEDIATE, BUYBACK_INTERMEDIATE)), criteriaBuilder.equal(root.get("effectiveDateTo"), FUTURE_DATE_9999_12_31)), Sort.by(Sort.Direction.ASC, "id"));
    }

    private boolean isBiggerThanZero(BigDecimal loanTotalOverpaid) {
        return MathUtil.nullToDefault(loanTotalOverpaid, BigDecimal.ZERO).compareTo(BigDecimal.ZERO) > 0;
    }

    private static boolean isSameDayTransfers(List<ExternalAssetOwnerTransfer> transferDataList) {
        return (transferDataList.stream().map(ExternalAssetOwnerTransfer::getSettlementDate).distinct().count() == 1);
    }

    @java.lang.SuppressWarnings("all")
        public LoanAccountOwnerTransferServiceImpl(final ExternalAssetOwnerTransferRepository externalAssetOwnerTransferRepository, final ExternalAssetOwnerTransferLoanMappingRepository externalAssetOwnerTransferLoanMappingRepository, final ExternalOwnerTransferJournalPort externalOwnerTransferJournalPort, final BusinessEventNotifierService businessEventNotifierService, final ExternalAssetOwnerTransferOutstandingInterestCalculation externalAssetOwnerTransferOutstandingInterestCalculation, final LoanTransferSnapshotPort loanTransferSnapshotPort, final LoanTransferBalancePort loanTransferBalancePort) {
        this.externalAssetOwnerTransferRepository = externalAssetOwnerTransferRepository;
        this.externalAssetOwnerTransferLoanMappingRepository = externalAssetOwnerTransferLoanMappingRepository;
        this.externalOwnerTransferJournalPort = externalOwnerTransferJournalPort;
        this.businessEventNotifierService = businessEventNotifierService;
        this.externalAssetOwnerTransferOutstandingInterestCalculation = externalAssetOwnerTransferOutstandingInterestCalculation;
        this.loanTransferSnapshotPort = loanTransferSnapshotPort;
        this.loanTransferBalancePort = loanTransferBalancePort;
    }
}
