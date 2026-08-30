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
package org.apache.fineract.portfolio.savings.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.organisation.office.domain.Office;
import org.apache.fineract.organisation.staff.domain.Staff;
import org.apache.fineract.portfolio.paymentdetail.domain.PaymentDetail;
import org.apache.fineract.portfolio.savings.SavingsTransactionBooleanValues;
import org.apache.fineract.portfolio.savings.data.GroupSavingsIndividualMonitoringAccountData;
import org.apache.fineract.portfolio.savings.data.SavingsAccountTransactionDTO;
import org.apache.fineract.portfolio.savings.domain.DepositAccountAssembler;
import org.apache.fineract.portfolio.savings.domain.GroupSavingsIndividualMonitoring;
import org.apache.fineract.portfolio.savings.domain.GSIMRepositoy;
import org.apache.fineract.portfolio.savings.domain.SavingsAccount;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountAssembler;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountRepository;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountRepositoryWrapper;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountTransaction;
import org.apache.fineract.portfolio.savings.moduleapi.LinkedSavingsAccountPort;
import org.apache.fineract.portfolio.savings.moduleapi.LinkedSavingsAccountView;
import org.apache.fineract.shares.shareaccounts.domain.ShareAccount;
import org.apache.fineract.shares.shareaccounts.domain.ShareAccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LinkedSavingsAccountPortAdapter implements LinkedSavingsAccountPort {

    private final SavingsAccountRepositoryWrapper savingsAccountRepository;
    private final SavingsAccountRepository savingsAccountJpaRepository;
    private final GSIMReadPlatformService gsimReadPlatformService;
    private final SavingsAccountAssembler savingsAccountAssembler;
    private final SavingsAccountDomainService savingsAccountDomainService;
    private final DepositAccountAssembler depositAccountAssembler;
    private final DepositAccountWritePlatformService depositAccountWritePlatformService;
    private final GSIMRepositoy gsimRepository;
    private final ShareAccountRepository shareAccountRepository;
    private SavingsAccountWritePlatformService savingsAccountWritePlatformService;

    public LinkedSavingsAccountPortAdapter(final SavingsAccountRepositoryWrapper savingsAccountRepository,
            final SavingsAccountRepository savingsAccountJpaRepository, final GSIMReadPlatformService gsimReadPlatformService,
            final SavingsAccountAssembler savingsAccountAssembler, final SavingsAccountDomainService savingsAccountDomainService,
            final DepositAccountAssembler depositAccountAssembler, final DepositAccountWritePlatformService depositAccountWritePlatformService,
            final GSIMRepositoy gsimRepository, final ShareAccountRepository shareAccountRepository) {
        this.savingsAccountRepository = savingsAccountRepository;
        this.savingsAccountJpaRepository = savingsAccountJpaRepository;
        this.gsimReadPlatformService = gsimReadPlatformService;
        this.savingsAccountAssembler = savingsAccountAssembler;
        this.savingsAccountDomainService = savingsAccountDomainService;
        this.depositAccountAssembler = depositAccountAssembler;
        this.depositAccountWritePlatformService = depositAccountWritePlatformService;
        this.gsimRepository = gsimRepository;
        this.shareAccountRepository = shareAccountRepository;
    }

    @Autowired
    public void setSavingsAccountWritePlatformService(final SavingsAccountWritePlatformService savingsAccountWritePlatformService) {
        this.savingsAccountWritePlatformService = savingsAccountWritePlatformService;
    }

    @Override
    public LinkedSavingsAccountView requireById(final Long savingsAccountId) {
        final SavingsAccount savingsAccount = savingsAccountRepository.findOneWithNotFoundDetection(savingsAccountId);
        return toView(savingsAccount);
    }

    private LinkedSavingsAccountView toView(final SavingsAccount savingsAccount) {
        return new LinkedSavingsAccountView(savingsAccount.getId(), savingsAccount.clientId(), !savingsAccount.isNotActive(),
                savingsAccount.getActivationDate(), savingsAccount.getAccountNumber(), savingsAccount.getCurrency().getCode(),
                savingsAccount.getCurrency().getDigitsAfterDecimal(), savingsAccount.getCurrency().getInMultiplesOf(),
                savingsAccount.isWithdrawalFeeApplicableForTransfer(), savingsAccount.retrieveLastTransactionDate());
    }

    @Override
    public Object persistableById(final Long savingsAccountId) {
        return this.savingsAccountRepository.findOneWithNotFoundDetection(savingsAccountId);
    }

    @Override
    public Long childAccountIdForGsimClient(final Long gsimAccountId, final Long clientId) {
        if (gsimAccountId == null || clientId == null) {
            return null;
        }
        final Collection<GroupSavingsIndividualMonitoringAccountData> childSavings = this.gsimReadPlatformService
                .findGSIMAccountsByGSIMId(gsimAccountId);
        final BigDecimal clientIdValue = BigDecimal.valueOf(clientId);
        for (final GroupSavingsIndividualMonitoringAccountData childSaving : childSavings) {
            if (clientIdValue.equals(childSaving.getClientId()) && childSaving.getChildAccountId() != null) {
                return childSaving.getChildAccountId().longValue();
            }
        }
        return null;
    }

    @Override
    public AccountNumberSource accountNumberSource(final Object savingsAccount) {
        final SavingsAccount account = (SavingsAccount) savingsAccount;
        final String officeName = account.office() == null ? "" : account.office().getName();
        final String productShortName = account.savingsProduct() == null ? "" : account.savingsProduct().getShortName();
        return new AccountNumberSource(account.getId(), officeName, productShortName);
    }

    @Override
    public boolean existsByAccountNumber(final String accountNumber) {
        return this.savingsAccountJpaRepository.findSavingsAccountByAccountNumber(accountNumber) != null;
    }

    @Override
    public ShareAccountNumberSource shareAccountNumberSource(final Object shareAccount) {
        final ShareAccount account = (ShareAccount) shareAccount;
        final String productShortName = account.getShareProduct() == null ? "" : account.getShareProduct().getShortName();
        return new ShareAccountNumberSource(account.getId(), productShortName);
    }

    @Override
    public boolean shareExistsByAccountNumber(final String accountNumber) {
        return this.shareAccountRepository.findAll().stream().anyMatch(a -> accountNumber.equals(a.getAccountNumber()));
    }

    @Override
    public boolean belongsToClient(final Long savingsAccountId, final Long clientId) {
        return clientId != null && clientId.equals(requireById(savingsAccountId).getClientId());
    }

    @Override
    public boolean hasNonClosedForClient(final Long clientId) {
        return this.savingsAccountRepository.doNonClosedSavingAccountsExistForClient(clientId);
    }

    @Override
    public boolean hasOpenForClient(final Long clientId) {
        return this.savingsAccountRepository.findSavingAccountByClientId(clientId).stream()
                .anyMatch(s -> s.isActive() || s.isSubmittedAndPendingApproval() || s.isApproved());
    }

    @Override
    public List<Long> nonClosedIdsByClientId(final Long clientId) {
        return this.savingsAccountRepository.findSavingAccountByClientId(clientId).stream().filter(s -> !s.isClosed())
                .map(SavingsAccount::getId).toList();
    }

    @Override
    public boolean hasOpenForGroup(final Long groupId) {
        return this.savingsAccountRepository.findByGroupId(groupId).stream()
                .anyMatch(s -> s.isActive() || s.isSubmittedAndPendingApproval() || s.isApproved());
    }

    @Override
    public LocalDate closedOnDate(final Long savingsAccountId) {
        return this.savingsAccountRepository.findOneWithNotFoundDetection(savingsAccountId).getClosedOnDate();
    }

    @Override
    public boolean hasGroupSavings(final Long clientId, final Long groupId) {
        return !this.savingsAccountRepository.findByClientIdAndGroupId(clientId, groupId).isEmpty();
    }

    @Override
    public TransferTxn handleDeposit(final Long savingsAccountId, final DateTimeFormatter fmt, final LocalDate transactionDate,
            final BigDecimal amount, final Object paymentDetail, final boolean isAccountTransfer, final boolean isRegularTransaction,
            final boolean backdatedTxnsAllowedTill) {
        final SavingsAccount account = this.savingsAccountAssembler.assembleFrom(savingsAccountId, backdatedTxnsAllowedTill);
        final SavingsAccountTransaction txn = this.savingsAccountDomainService.handleDeposit(account, fmt, transactionDate, amount,
                (PaymentDetail) paymentDetail, isAccountTransfer, isRegularTransaction, backdatedTxnsAllowedTill);
        return toTxn(account, txn);
    }

    @Override
    public TransferTxn handleWithdrawal(final Long savingsAccountId, final DateTimeFormatter fmt, final LocalDate transactionDate,
            final BigDecimal amount, final Object paymentDetail, final boolean isAccountTransfer, final boolean isRegularTransaction,
            final boolean isInterestTransfer, final boolean isExceptionForBalanceCheck, final boolean backdatedTxnsAllowedTill) {
        final SavingsAccount account = this.savingsAccountAssembler.assembleFrom(savingsAccountId, backdatedTxnsAllowedTill);
        final SavingsTransactionBooleanValues values = new SavingsTransactionBooleanValues(isAccountTransfer, isRegularTransaction,
                account.isWithdrawalFeeApplicableForTransfer(), isInterestTransfer, isExceptionForBalanceCheck);
        final SavingsAccountTransaction txn = this.savingsAccountDomainService.handleWithdrawal(account, fmt, transactionDate, amount,
                (PaymentDetail) paymentDetail, values, backdatedTxnsAllowedTill);
        return toTxn(account, txn);
    }

    @Override
    public void undoTransaction(final Long savingsAccountId, final Long transactionId, final boolean allowAccountTransferModification) {
        this.savingsAccountWritePlatformService.undoTransaction(savingsAccountId, transactionId, allowAccountTransferModification);
    }

    @Override
    public Long handleDividendPayout(final Long savingsAccountId, final LocalDate transactionDate, final BigDecimal amount) {
        final SavingsAccount account = this.savingsAccountAssembler.assembleFrom(savingsAccountId, false);
        final SavingsAccountTransaction txn = this.savingsAccountDomainService.handleDividendPayout(account, transactionDate, amount, false);
        return txn.getId();
    }

    @Override
    public List<Long> mandatoryDeposits(final JsonCommand command, final Object paymentDetail) {
        final Collection<SavingsAccountTransactionDTO> savingsTransactions = this.depositAccountAssembler
                .assembleBulkMandatorySavingsAccountTransactionDTOs(command, (PaymentDetail) paymentDetail);
        final List<Long> ids = new ArrayList<>();
        for (final SavingsAccountTransactionDTO dto : savingsTransactions) {
            try {
                ids.add(this.depositAccountWritePlatformService.mandatorySavingsAccountDeposit(dto).getId());
            } catch (final Exception ignored) {
                // collection sheet continues remaining deposits
            }
        }
        return ids;
    }

    @Override
    public void initiateTransfer(final Long savingsAccountId, final LocalDate transferDate) {
        final SavingsAccount account = this.savingsAccountAssembler.assembleFrom(savingsAccountId, false);
        this.savingsAccountWritePlatformService.initiateSavingsTransfer(account, transferDate);
    }

    @Override
    public void withdrawTransfer(final Long savingsAccountId, final LocalDate transferDate) {
        final SavingsAccount account = this.savingsAccountAssembler.assembleFrom(savingsAccountId, false);
        this.savingsAccountWritePlatformService.withdrawSavingsTransfer(account, transferDate);
    }

    @Override
    public void rejectTransfer(final Long savingsAccountId) {
        final SavingsAccount account = this.savingsAccountAssembler.assembleFrom(savingsAccountId, false);
        this.savingsAccountWritePlatformService.rejectSavingsTransfer(account);
    }

    @Override
    public void acceptTransfer(final Long savingsAccountId, final LocalDate lastTransactionDate, final Object office, final Object staff) {
        final SavingsAccount account = this.savingsAccountAssembler.assembleFrom(savingsAccountId, false);
        this.savingsAccountWritePlatformService.acceptSavingsTransfer(account, lastTransactionDate, (Office) office, (Staff) staff);
    }

    @Override
    public void reassignOfficer(final Long savingsAccountId, final Object staff, final LocalDate date) {
        final SavingsAccount account = this.savingsAccountRepository.findOneWithNotFoundDetection(savingsAccountId);
        account.reassignSavingsOfficer((Staff) staff, date);
        this.savingsAccountRepository.save(account);
    }

    @Override
    public void addToGsimParentDeposit(final Long savingsAccountId, final BigDecimal amount) {
        final SavingsAccount account = this.savingsAccountRepository.findOneWithNotFoundDetection(savingsAccountId);
        if (account.getGsim() == null) {
            return;
        }
        final GroupSavingsIndividualMonitoring gsim = this.gsimRepository.findById(account.getGsim().getId()).orElseThrow();
        gsim.setParentDeposit(gsim.getParentDeposit().add(amount));
        this.gsimRepository.save(gsim);
    }

    @Override
    public Object office(final Long savingsAccountId) {
        return this.savingsAccountRepository.findOneWithNotFoundDetection(savingsAccountId).office();
    }

    @Override
    public void setHelpers(final Object savingsAccount) {
        this.savingsAccountAssembler.setHelpers((SavingsAccount) savingsAccount);
    }

    private TransferTxn toTxn(final SavingsAccount account, final SavingsAccountTransaction txn) {
        return new TransferTxn(txn.getId(), account.getId(), account.getCurrency().getCode(), account.getCurrency().getDigitsAfterDecimal(),
                account.getCurrency().getInMultiplesOf());
    }
}
