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
package org.apache.fineract.portfolio.loanaccount.jobs.transferfeechargeforloans;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.jobs.exception.JobExecutionException;
import org.apache.fineract.portfolio.account.PortfolioAccountType;
import org.apache.fineract.portfolio.account.data.AccountTransferFundsData;
import org.apache.fineract.portfolio.account.data.PortfolioAccountData;
import org.apache.fineract.portfolio.account.domain.AccountTransferType;
import org.apache.fineract.portfolio.account.service.AccountAssociationsReadPlatformService;
import org.apache.fineract.portfolio.account.service.AccountTransferFundsWritePort;
import org.apache.fineract.portfolio.charge.moduleapi.ChargePaymentMode;
import org.apache.fineract.portfolio.loanaccount.data.LoanChargeData;
import org.apache.fineract.portfolio.loanaccount.data.LoanInstallmentChargeData;
import org.apache.fineract.portfolio.loanaccount.domain.LoanStatus;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransactionType;
import org.apache.fineract.portfolio.loanaccount.service.LoanChargeReadPlatformService;
import org.apache.fineract.portfolio.loanproduct.exception.LinkedAccountRequiredException;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

public class TransferFeeChargeForLoansTasklet implements Tasklet {
    @java.lang.SuppressWarnings("all")
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(TransferFeeChargeForLoansTasklet.class);
    private final LoanChargeReadPlatformService loanChargeReadPlatformService;
    private final AccountAssociationsReadPlatformService accountAssociationsReadPlatformService;
    private final AccountTransferFundsWritePort accountTransferFundsWritePort;

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        final Collection<LoanChargeData> chargeDatas = loanChargeReadPlatformService
                .retrieveLoanChargesForFeePayment(ChargePaymentMode.ACCOUNT_TRANSFER.getValue(), LoanStatus.ACTIVE.getValue());
        final boolean isRegularTransaction = true;
        List<Throwable> errors = new ArrayList<>();
        if (chargeDatas != null) {
            for (final LoanChargeData chargeData : chargeDatas) {
                if (chargeData.isInstallmentFee()) {
                    final Collection<LoanInstallmentChargeData> chargePerInstallments = loanChargeReadPlatformService
                            .retrieveInstallmentLoanCharges(chargeData.getId(), true);
                    PortfolioAccountData portfolioAccountData = null;
                    for (final LoanInstallmentChargeData installmentChargeData : chargePerInstallments) {
                        if (!DateUtils.isDateInTheFuture(installmentChargeData.getDueDate())) {
                            if (portfolioAccountData == null) {
                                portfolioAccountData = accountAssociationsReadPlatformService
                                        .retriveLoanLinkedAssociation(chargeData.getLoanId());
                            }
                            if (portfolioAccountData == null) {
                                errors.add(new LinkedAccountRequiredException("loan.transfer.fee.charge",
                                        "Loan with id:" + chargeData.getLoanId()
                                                + " has a charge payable by account transfer but no linked savings account",
                                        chargeData.getLoanId()));
                                break;
                            }
                            final boolean isExceptionForBalanceCheck = false;
                            final AccountTransferFundsData fundsData = new AccountTransferFundsData(DateUtils.getBusinessLocalDate(),
                                    installmentChargeData.getAmountOutstanding(), PortfolioAccountType.SAVINGS, PortfolioAccountType.LOAN,
                                    portfolioAccountData.getId(), chargeData.getLoanId(), "Loan Charge Payment",
                                    LoanTransactionType.CHARGE_PAYMENT.getValue(), chargeData.getId(),
                                    installmentChargeData.getInstallmentNumber(), AccountTransferType.CHARGE_PAYMENT.getValue(),
                                    isRegularTransaction, isExceptionForBalanceCheck);
                            transferFeeCharge(fundsData, errors);
                        }
                    }
                } else if (chargeData.getDueDate() != null && !DateUtils.isDateInTheFuture(chargeData.getDueDate())) {
                    final PortfolioAccountData portfolioAccountData = accountAssociationsReadPlatformService
                            .retriveLoanLinkedAssociation(chargeData.getLoanId());
                    if (portfolioAccountData == null) {
                        errors.add(new LinkedAccountRequiredException("loan.transfer.fee.charge",
                                "Loan with id:" + chargeData.getLoanId()
                                        + " has a charge payable by account transfer but no linked savings account",
                                chargeData.getLoanId()));
                        continue;
                    }
                    final boolean isExceptionForBalanceCheck = false;
                    final AccountTransferFundsData fundsData = new AccountTransferFundsData(DateUtils.getBusinessLocalDate(),
                            chargeData.getAmountOutstanding(), PortfolioAccountType.SAVINGS, PortfolioAccountType.LOAN,
                            portfolioAccountData.getId(), chargeData.getLoanId(), "Loan Charge Payment",
                            LoanTransactionType.CHARGE_PAYMENT.getValue(), chargeData.getId(), null,
                            AccountTransferType.CHARGE_PAYMENT.getValue(), isRegularTransaction, isExceptionForBalanceCheck);
                    transferFeeCharge(fundsData, errors);
                }
            }
        }
        if (!errors.isEmpty()) {
            throw new JobExecutionException(errors);
        }
        return RepeatStatus.FINISHED;
    }

    private void transferFeeCharge(final AccountTransferFundsData fundsData, List<Throwable> errors) {
        try {
            accountTransferFundsWritePort.transferFunds(fundsData);
        } catch (RuntimeException e) {
            log.error("Exception while paying charge {} for loan id {}", fundsData.getChargeId(), fundsData.getToAccountId(), e);
            errors.add(e);
        }
    }

    @java.lang.SuppressWarnings("all")
    public TransferFeeChargeForLoansTasklet(final LoanChargeReadPlatformService loanChargeReadPlatformService,
            final AccountAssociationsReadPlatformService accountAssociationsReadPlatformService,
            final AccountTransferFundsWritePort accountTransferFundsWritePort) {
        this.loanChargeReadPlatformService = loanChargeReadPlatformService;
        this.accountAssociationsReadPlatformService = accountAssociationsReadPlatformService;
        this.accountTransferFundsWritePort = accountTransferFundsWritePort;
    }
}
