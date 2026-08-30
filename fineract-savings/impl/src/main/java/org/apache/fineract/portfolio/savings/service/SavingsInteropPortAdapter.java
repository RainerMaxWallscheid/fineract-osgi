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

import static org.apache.fineract.interoperation.util.InteropUtil.DEFAULT_LOCALE;
import static org.apache.fineract.interoperation.util.InteropUtil.DEFAULT_ROUTING_CODE;
import static org.apache.fineract.portfolio.paymentdetail.domain.PaymentDetail.instance;
import static org.apache.fineract.portfolio.savings.SavingsAccountTransactionType.AMOUNT_HOLD;
import static org.apache.fineract.portfolio.savings.SavingsAccountTransactionType.DEPOSIT;
import static org.apache.fineract.portfolio.savings.SavingsAccountTransactionType.WITHDRAWAL;
import static org.apache.fineract.portfolio.savings.domain.SavingsAccountTransaction.releaseAmount;

import jakarta.persistence.PersistenceException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;
import java.util.function.Consumer;
import java.util.function.Predicate;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.apache.fineract.infrastructure.configuration.domain.ConfigurationDomainService;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.exception.ErrorHandler;
import org.apache.fineract.infrastructure.core.exception.PlatformDataIntegrityException;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.core.service.ExternalIdFactory;
import org.apache.fineract.infrastructure.core.service.MathUtil;
import org.apache.fineract.interoperation.data.InteropAccountData;
import org.apache.fineract.interoperation.data.InteropDataFactory;
import org.apache.fineract.interoperation.data.InteropIdentifierAccountResponseData;
import org.apache.fineract.interoperation.data.InteropIdentifierRequestData;
import org.apache.fineract.interoperation.data.InteropIdentifiersResponseData;
import org.apache.fineract.interoperation.data.InteropQuoteRequestData;
import org.apache.fineract.interoperation.data.InteropQuoteResponseData;
import org.apache.fineract.interoperation.data.InteropRequestData;
import org.apache.fineract.interoperation.data.InteropTransactionsData;
import org.apache.fineract.interoperation.data.InteropTransferRequestData;
import org.apache.fineract.interoperation.data.InteropTransferResponseData;
import org.apache.fineract.interoperation.data.MoneyData;
import org.apache.fineract.interoperation.domain.InteropActionState;
import org.apache.fineract.interoperation.domain.InteropIdentifier;
import org.apache.fineract.interoperation.domain.InteropIdentifierRepository;
import org.apache.fineract.interoperation.domain.InteropIdentifierType;
import org.apache.fineract.interoperation.exception.InteropAccountNotFoundException;
import org.apache.fineract.interoperation.exception.InteropAccountTransactionNotAllowedException;
import org.apache.fineract.interoperation.exception.InteropTransferAlreadyCommittedException;
import org.apache.fineract.interoperation.exception.InteropTransferAlreadyOnHoldException;
import org.apache.fineract.interoperation.exception.InteropTransferMissingException;
import org.apache.fineract.organisation.monetary.domain.ApplicationCurrency;
import org.apache.fineract.organisation.monetary.domain.ApplicationCurrencyRepository;
import org.apache.fineract.organisation.monetary.domain.MonetaryCurrency;
import org.apache.fineract.organisation.monetary.domain.Money;
import org.apache.fineract.portfolio.account.exception.DifferentCurrenciesException;
import org.apache.fineract.portfolio.client.moduleapi.ClientActivePort;
import org.apache.fineract.portfolio.group.moduleapi.GroupActivePort;
import org.apache.fineract.portfolio.paymentdetail.domain.PaymentDetail;
import org.apache.fineract.portfolio.paymenttype.domain.PaymentType;
import org.apache.fineract.portfolio.paymenttype.domain.PaymentTypeRepository;
import org.apache.fineract.portfolio.savings.SavingsAccountTransactionType;
import org.apache.fineract.portfolio.savings.SavingsTransactionBooleanValues;
import org.apache.fineract.portfolio.savings.domain.SavingsAccount;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountRepository;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountTransaction;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountTransactionRepository;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountTransactionSummaryWrapper;
import org.apache.fineract.portfolio.savings.domain.SavingsHelper;
import org.apache.fineract.portfolio.savings.exception.InsufficientAccountBalanceException;
import org.apache.fineract.portfolio.savings.exception.SavingsAccountNotFoundException;
import org.apache.fineract.portfolio.savings.moduleapi.SavingsInteropPort;
import org.apache.fineract.portfolio.tax.service.ChargeTaxApplicationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.lang.NonNull;
import org.springframework.orm.jpa.JpaSystemException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SavingsInteropPortAdapter implements SavingsInteropPort {

    @java.lang.SuppressWarnings("all")
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(SavingsInteropPortAdapter.class);

    private final SavingsAccountRepository savingsAccountRepository;
    private final SavingsAccountTransactionRepository savingsAccountTransactionRepository;
    private final ApplicationCurrencyRepository currencyRepository;
    private final PaymentTypeRepository paymentTypeRepository;
    private final InteropIdentifierRepository identifierRepository;
    private final SavingsHelper savingsHelper;
    private final SavingsAccountTransactionSummaryWrapper savingsAccountTransactionSummaryWrapper;
    private final SavingsAccountDomainService savingsAccountService;
    private final ConfigurationDomainService configurationDomainService;
    private final ChargeTaxApplicationService chargeTaxApplicationService;
    private ClientActivePort clientActivePort;
    private GroupActivePort groupActivePort;

    public SavingsInteropPortAdapter(final SavingsAccountRepository savingsAccountRepository,
            final SavingsAccountTransactionRepository savingsAccountTransactionRepository,
            final ApplicationCurrencyRepository currencyRepository, final PaymentTypeRepository paymentTypeRepository,
            final InteropIdentifierRepository identifierRepository, final SavingsHelper savingsHelper,
            final SavingsAccountTransactionSummaryWrapper savingsAccountTransactionSummaryWrapper,
            final SavingsAccountDomainService savingsAccountService, final ConfigurationDomainService configurationDomainService,
            final ChargeTaxApplicationService chargeTaxApplicationService) {
        this.savingsAccountRepository = savingsAccountRepository;
        this.savingsAccountTransactionRepository = savingsAccountTransactionRepository;
        this.currencyRepository = currencyRepository;
        this.paymentTypeRepository = paymentTypeRepository;
        this.identifierRepository = identifierRepository;
        this.savingsHelper = savingsHelper;
        this.savingsAccountTransactionSummaryWrapper = savingsAccountTransactionSummaryWrapper;
        this.savingsAccountService = savingsAccountService;
        this.configurationDomainService = configurationDomainService;
        this.chargeTaxApplicationService = chargeTaxApplicationService;
    }

    @Autowired
    public void setClientActivePort(final ClientActivePort clientActivePort) {
        this.clientActivePort = clientActivePort;
    }

    @Autowired
    public void setGroupActivePort(final GroupActivePort groupActivePort) {
        this.groupActivePort = groupActivePort;
    }

    @Override
    @NonNull
    @Transactional
    public InteropAccountData accountDetails(@NonNull final String accountId) {
        return InteropDataFactory.account(validateAndGetSavingAccount(accountId));
    }

    @Override
    @NonNull
    @Transactional
    public InteropTransactionsData accountTransactions(@NonNull final String accountId, final boolean debit, final boolean credit,
            final LocalDateTime transactionsFrom, final LocalDateTime transactionsTo) {
        final SavingsAccount savingsAccount = validateAndGetSavingAccount(accountId);
        final Predicate<SavingsAccountTransaction> transFilter = t -> {
            final SavingsAccountTransactionType transactionType = t.getTransactionType();
            if (debit != transactionType.isDebit() && credit != transactionType.isCredit()) {
                return false;
            }
            if (transactionsFrom == null && transactionsTo == null) {
                return true;
            }
            final LocalDateTime transactionDate = t.getTransactionDate().atStartOfDay(ZoneId.systemDefault()).toLocalDateTime();
            return (transactionsTo == null || transactionsTo.compareTo(transactionDate) > 0) && (transactionsFrom == null
                    || transactionsFrom.compareTo(transactionDate.withHour(23).withMinute(59).withSecond(59)) <= 0);
        };
        return InteropDataFactory.transactions(savingsAccount, transFilter);
    }

    @Override
    @NonNull
    @Transactional
    public InteropIdentifiersResponseData identifiers(@NonNull final String accountId) {
        return InteropDataFactory.identifiers(validateAndGetSavingAccount(accountId));
    }

    @Override
    @NonNull
    @Transactional
    public InteropIdentifierAccountResponseData accountByIdentifier(@NonNull final InteropIdentifierType idType,
            @NonNull final String idValue, final String subIdOrType) {
        final InteropIdentifier identifier = findIdentifier(idType, idValue, subIdOrType);
        if (identifier == null) {
            throw new InteropAccountNotFoundException(idType, idValue, subIdOrType);
        }
        return InteropIdentifierAccountResponseData.build(identifier.getId(), identifier.getAccount().getExternalId().getValue());
    }

    @Override
    @NonNull
    @Transactional
    public InteropIdentifierAccountResponseData registerIdentifier(@NonNull final InteropIdentifierRequestData request,
            @NonNull final String createdBy) {
        final SavingsAccount savingsAccount = validateAndGetSavingAccount(request.getAccountId());
        try {
            final InteropIdentifier identifier = new InteropIdentifier(savingsAccount, request.getIdType(), request.getIdValue(),
                    request.getSubIdOrType(), createdBy);
            identifierRepository.saveAndFlush(identifier);
            return InteropIdentifierAccountResponseData.build(identifier.getId(), savingsAccount.getExternalId().getValue());
        } catch (final JpaSystemException | DataIntegrityViolationException dve) {
            handleInteropDataIntegrityIssues(request.getIdType(), request.getAccountId(), dve.getMostSpecificCause(), dve);
            return InteropIdentifierAccountResponseData.empty();
        } catch (final PersistenceException dve) {
            final Throwable throwable = ExceptionUtils.getRootCause(dve.getCause());
            handleInteropDataIntegrityIssues(request.getIdType(), request.getAccountId(), throwable, dve);
            return InteropIdentifierAccountResponseData.empty();
        }
    }

    @Override
    @NonNull
    @Transactional
    public InteropIdentifierAccountResponseData deleteIdentifier(@NonNull final InteropIdentifierType idType, @NonNull final String idValue,
            final String subIdOrType) {
        final InteropIdentifier identifier = findIdentifier(idType, idValue, subIdOrType);
        if (identifier == null) {
            throw new InteropAccountNotFoundException(idType, idValue, subIdOrType);
        }
        final String accountId = identifier.getAccount().getExternalId().getValue();
        final Long id = identifier.getId();
        identifierRepository.delete(identifier);
        return InteropIdentifierAccountResponseData.build(id, accountId);
    }

    @Override
    public void validateForRequest(@NonNull final InteropRequestData request) {
        validateAndGetSavingAccount(request, request::normalizeAmounts);
    }

    @Override
    @NonNull
    @Transactional
    public InteropQuoteResponseData createQuote(@NonNull final JsonCommand command, @NonNull final InteropQuoteRequestData request) {
        final SavingsAccount savingsAccount = validateAndGetSavingAccount(request.getRequest(), request::normalizeAmounts);
        final SavingsAccountTransactionType transactionType = request.getTransactionRole().getTransactionType();
        final BigDecimal fee;
        if (transactionType.isDebit()) {
            fee = savingsAccount.calculateWithdrawalFee(request.getAmount().getAmount());
            if (MathUtil.isLessThan(savingsAccount.getWithdrawableBalance(), request.getAmount().getAmount().add(fee))) {
                throw new InsufficientAccountBalanceException(savingsAccount.getExternalId().getValue(),
                        savingsAccount.getWithdrawableBalance(), fee, request.getAmount().getAmount());
            }
        } else {
            fee = BigDecimal.ZERO;
        }
        return InteropQuoteResponseData.build(command.commandId(), request.getTransactionCode(), InteropActionState.ACCEPTED,
                request.getExpiration(), request.getExtensionList(), request.getQuoteCode(),
                MoneyData.build(fee, savingsAccount.getCurrency().getCode()), null);
    }

    @Override
    @NonNull
    @Transactional
    public InteropTransferResponseData prepareTransfer(@NonNull final JsonCommand command,
            @NonNull final InteropTransferRequestData request) {
        final String transferCode = request.getTransferCode();
        final LocalDate transactionDate = DateUtils.getBusinessLocalDate();
        final SavingsAccountTransactionType transactionType = request.getTransactionRole().getTransactionType();
        if (transactionType.isDebit()) {
            final SavingsAccount savingsAccount = validateAndGetSavingAccount(request.getRequest(), request::normalizeAmounts);
            final BigDecimal total = calculateTotalTransferAmount(request, savingsAccount);
            if (MathUtil.isLessThan(savingsAccount.getWithdrawableBalance(), total)) {
                throw new InsufficientAccountBalanceException(savingsAccount.getExternalId().getValue(),
                        savingsAccount.getWithdrawableBalance(), null, total);
            }
            if (findTransaction(savingsAccount, transferCode, AMOUNT_HOLD.getValue()) != null) {
                throw new InteropTransferAlreadyOnHoldException(savingsAccount.getExternalId().getValue(), transferCode);
            }
            final PaymentDetail paymentDetail = instance(findPaymentType(), savingsAccount.getExternalId().getValue(), null,
                    getRoutingCode(), transferCode, null);
            final SavingsAccountTransaction holdTransaction = SavingsAccountTransaction.holdAmount(savingsAccount, savingsAccount.office(),
                    paymentDetail, transactionDate, Money.of(savingsAccount.getCurrency(), total), false);
            final MonetaryCurrency accountCurrency = savingsAccount.getCurrency().copy();
            holdTransaction
                    .setRunningBalance(Money.of(accountCurrency, savingsAccount.getWithdrawableBalance().subtract(holdTransaction.getAmount())));
            holdTransaction.updateCumulativeBalanceAndDates(accountCurrency, transactionDate);
            savingsAccount.holdAmount(total);
            savingsAccount.addTransaction(holdTransaction);
            savingsAccountRepository.save(savingsAccount);
        }
        return InteropTransferResponseData.build(command.commandId(), request.getTransactionCode(), InteropActionState.ACCEPTED,
                request.getExpiration(), request.getExtensionList(), transferCode, DateUtils.getLocalDateTimeOfTenant());
    }

    @Override
    @NonNull
    @Transactional
    public CommitTransferResult commitTransfer(@NonNull final JsonCommand command, @NonNull final InteropTransferRequestData request) {
        final boolean isDebit = request.getTransactionRole().getTransactionType().isDebit();
        final SavingsAccount savingsAccount = validateAndGetSavingAccount(request.getRequest(), request::normalizeAmounts);
        final String transferCode = request.getTransferCode();
        if (findTransaction(savingsAccount, transferCode, (isDebit ? WITHDRAWAL : DEPOSIT).getValue()) != null) {
            throw new InteropTransferAlreadyCommittedException(savingsAccount.getExternalId().getValue(), transferCode);
        }
        final LocalDateTime transactionDateTime = DateUtils.getLocalDateTimeOfTenant();
        final LocalDate transactionDate = DateUtils.getBusinessLocalDate();
        final DateTimeFormatter fmt = getDateTimeFormatter(command);
        final SavingsAccountTransaction transaction;
        final boolean backdatedTxnsAllowedTill = false;
        if (isDebit) {
            final SavingsAccountTransaction holdTransaction = findTransaction(savingsAccount, transferCode, AMOUNT_HOLD.getValue());
            if (holdTransaction == null) {
                throw new InteropTransferMissingException(savingsAccount.getExternalId().getValue(), transferCode);
            }
            final BigDecimal totalTransferAmount = calculateTotalTransferAmount(request, savingsAccount);
            if (holdTransaction.getAmount().compareTo(totalTransferAmount) != 0) {
                throw new InteropTransferMissingException(savingsAccount.getExternalId().getValue(), transferCode);
            }
            if (MathUtil.isLessThan(savingsAccount.getWithdrawableBalance().add(holdTransaction.getAmount()), totalTransferAmount)) {
                throw new InsufficientAccountBalanceException(savingsAccount.getExternalId().getValue(),
                        savingsAccount.getWithdrawableBalance(), null, totalTransferAmount);
            }
            if (holdTransaction.getReleaseIdOfHoldAmountTransaction() == null) {
                final SavingsAccountTransaction releaseTransaction = savingsAccountTransactionRepository
                        .saveAndFlush(releaseAmount(holdTransaction, transactionDate));
                holdTransaction.updateReleaseId(releaseTransaction.getId());
                savingsAccount.releaseOnHoldAmount(holdTransaction.getAmount());
                savingsAccount.addTransaction(releaseTransaction);
                savingsAccountRepository.save(savingsAccount);
            }
            final SavingsTransactionBooleanValues transactionValues = new SavingsTransactionBooleanValues(false, true, true, false, false);
            transaction = savingsAccountService.handleWithdrawal(savingsAccount, fmt, transactionDate, request.getAmount().getAmount(),
                    instance(findPaymentType(), savingsAccount.getExternalId().getValue(), null, getRoutingCode(), transferCode, null),
                    transactionValues, backdatedTxnsAllowedTill);
        } else {
            transaction = savingsAccountService.handleDeposit(savingsAccount, fmt, transactionDate, request.getAmount().getAmount(),
                    instance(findPaymentType(), savingsAccount.getExternalId().getValue(), null, getRoutingCode(), transferCode, null),
                    false, true, backdatedTxnsAllowedTill);
        }
        return new CommitTransferResult(InteropTransferResponseData.build(command.commandId(), request.getTransactionCode(),
                InteropActionState.ACCEPTED, request.getExpiration(), request.getExtensionList(), request.getTransferCode(),
                transactionDateTime), transaction.getId());
    }

    @Override
    @NonNull
    @Transactional
    public InteropTransferResponseData releaseTransfer(@NonNull final JsonCommand command,
            @NonNull final InteropTransferRequestData request) {
        final SavingsAccount savingsAccount = validateAndGetSavingAccount(request.getRequest(), request::normalizeAmounts);
        final LocalDateTime transactionDateTime = DateUtils.getLocalDateTimeOfTenant();
        final LocalDate transactionDate = DateUtils.getBusinessLocalDate();
        final SavingsAccountTransaction holdTransaction = findTransaction(savingsAccount, request.getTransferCode(), AMOUNT_HOLD.getValue());
        if (holdTransaction != null && holdTransaction.getReleaseIdOfHoldAmountTransaction() == null) {
            SavingsAccountTransaction releaseTransaction = releaseAmount(holdTransaction, transactionDate);
            final MonetaryCurrency accountCurrency = savingsAccount.getCurrency().copy();
            releaseTransaction
                    .setRunningBalance(Money.of(accountCurrency, savingsAccount.getWithdrawableBalance().add(holdTransaction.getAmount())));
            releaseTransaction.updateCumulativeBalanceAndDates(accountCurrency, transactionDate);
            releaseTransaction = savingsAccountTransactionRepository.saveAndFlush(releaseTransaction);
            holdTransaction.updateReleaseId(releaseTransaction.getId());
            savingsAccount.releaseOnHoldAmount(holdTransaction.getAmount());
            savingsAccount.addTransaction(releaseTransaction);
            savingsAccountRepository.save(savingsAccount);
        } else {
            throw new InteropTransferMissingException(savingsAccount.getExternalId().getValue(), request.getTransferCode());
        }
        return InteropTransferResponseData.build(command.commandId(), request.getTransactionCode(), InteropActionState.ACCEPTED,
                request.getExpiration(), request.getExtensionList(), request.getTransferCode(), transactionDateTime);
    }

    @Override
    @NonNull
    public Long clientIdByAccountExternalId(@NonNull final String accountId) {
        return validateAndGetSavingAccount(accountId).clientId();
    }

    private SavingsAccount validateAndGetSavingAccount(final String accountId) {
        final SavingsAccount savingsAccount = savingsAccountRepository.findByExternalId(ExternalIdFactory.produce(accountId));
        if (savingsAccount == null) {
            throw new SavingsAccountNotFoundException(accountId);
        }
        return savingsAccount;
    }

    private SavingsAccount validateAndGetSavingAccount(@NonNull final InteropRequestData request,
            @NonNull final Consumer<MonetaryCurrency> amountNormalizer) {
        final SavingsAccount savingsAccount = validateAndGetSavingAccount(request.getAccountId());
        savingsAccount.setHelpers(savingsAccountTransactionSummaryWrapper, savingsHelper, configurationDomainService, this.clientActivePort,
                this.groupActivePort);
        savingsAccount.setChargeTaxApplicationService(this.chargeTaxApplicationService);
        final ApplicationCurrency requestCurrency = currencyRepository.findOneByCode(request.getAmount().getCurrency());
        if (!savingsAccount.getCurrency().getCode().equals(requestCurrency.getCode())) {
            throw new DifferentCurrenciesException(savingsAccount.getCurrency().getCode(), requestCurrency.getCode());
        }
        final SavingsAccountTransactionType transactionType = request.getTransactionRole().getTransactionType();
        if (!savingsAccount.isTransactionAllowed(transactionType, request.getExpirationLocalDate())) {
            throw new InteropAccountTransactionNotAllowedException(request.getAccountId());
        }
        amountNormalizer.accept(savingsAccount.getCurrency());
        return savingsAccount;
    }

    private BigDecimal calculateTotalTransferAmount(@NonNull final InteropTransferRequestData request,
            @NonNull final SavingsAccount savingsAccount) {
        BigDecimal total = request.getAmount().getAmount();
        final MoneyData requestFee = request.getFspFee();
        if (requestFee != null) {
            if (!savingsAccount.getCurrency().getCode().equals(requestFee.getCurrency())) {
                throw new DifferentCurrenciesException(savingsAccount.getCurrency().getCode(), requestFee.getCurrency());
            }
            total = MathUtil.add(total, requestFee.getAmount());
        }
        final MoneyData requestCommission = request.getFspCommission();
        if (requestCommission != null) {
            if (!savingsAccount.getCurrency().getCode().equals(requestCommission.getCurrency())) {
                throw new DifferentCurrenciesException(savingsAccount.getCurrency().getCode(), requestCommission.getCurrency());
            }
            total = MathUtil.subtractToZero(total, requestCommission.getAmount());
        }
        return total;
    }

    private DateTimeFormatter getDateTimeFormatter(@NonNull final JsonCommand command) {
        Locale locale = command.extractLocale();
        if (locale == null) {
            locale = DEFAULT_LOCALE;
        }
        String dateFormat = command.dateFormat();
        if (StringUtils.isEmpty(dateFormat)) {
            dateFormat = "yyyy-MM-dd HH:mm:ss.SSS";
        }
        return DateTimeFormatter.ofPattern(dateFormat).withLocale(locale);
    }

    private PaymentType findPaymentType() {
        final List<PaymentType> paymentTypes = paymentTypeRepository.findAll();
        for (final PaymentType paymentType : paymentTypes) {
            if (!paymentType.getIsCashPayment()) {
                return paymentType;
            }
        }
        return null;
    }

    private SavingsAccountTransaction findTransaction(final SavingsAccount savingsAccount, final String transactionCode,
            final Integer transactionTypeValue) {
        return savingsAccount.getTransactions().stream().filter(t -> transactionTypeValue.equals(t.getTypeOf())).filter(t -> {
            final PaymentDetail detail = t.getPaymentDetail();
            return detail != null && getRoutingCode().equals(detail.getRoutingCode()) && transactionCode.equals(detail.getReceiptNumber());
        }).findFirst().orElse(null);
    }

    private InteropIdentifier findIdentifier(@NonNull final InteropIdentifierType idType, @NonNull final String idValue,
            final String subIdOrType) {
        return identifierRepository.findOneByTypeAndValueAndSubType(idType, idValue, subIdOrType);
    }

    private void handleInteropDataIntegrityIssues(final InteropIdentifierType idType, final String accountId, final Throwable realCause,
            final Exception dve) {
        if (realCause.getMessage().contains("uk_interop_identifier_account")) {
            throw new PlatformDataIntegrityException("error.msg.interop.duplicate.account.identifier",
                    "Account identifier of type `" + idType.name() + "' already exists for account with externalId `" + accountId + "`",
                    "idType", idType.name(), accountId);
        }
        log.error("Error occured.", dve);
        throw ErrorHandler.getMappable(dve, "error.msg.interop.unknown.data.integrity.issue",
                "Unknown data integrity issue with resource: " + realCause.getMessage());
    }

    private String getRoutingCode() {
        return DEFAULT_ROUTING_CODE;
    }
}
