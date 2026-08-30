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
package org.apache.fineract.interoperation.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import org.apache.commons.lang3.StringUtils;
import org.apache.fineract.commands.domain.CommandWrapper;
import org.apache.fineract.commands.service.CommandWrapperBuilder;
import org.apache.fineract.commands.service.PortfolioCommandSourceWritePlatformService;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;
import org.apache.fineract.infrastructure.core.serialization.DefaultToApiJsonSerializer;
import org.apache.fineract.infrastructure.core.service.database.DatabaseSpecificSQLGenerator;
import org.apache.fineract.infrastructure.security.service.PlatformSecurityContext;
import org.apache.fineract.interoperation.data.InteropAccountData;
import org.apache.fineract.interoperation.data.InteropIdentifierAccountResponseData;
import org.apache.fineract.interoperation.data.InteropIdentifierRequestData;
import org.apache.fineract.interoperation.data.InteropIdentifiersResponseData;
import org.apache.fineract.interoperation.data.InteropKycData;
import org.apache.fineract.interoperation.data.InteropKycResponseData;
import org.apache.fineract.interoperation.data.InteropQuoteRequestData;
import org.apache.fineract.interoperation.data.InteropQuoteResponseData;
import org.apache.fineract.interoperation.data.InteropTransactionData;
import org.apache.fineract.interoperation.data.InteropTransactionRequestData;
import org.apache.fineract.interoperation.data.InteropTransactionRequestResponseData;
import org.apache.fineract.interoperation.data.InteropTransactionsData;
import org.apache.fineract.interoperation.data.InteropTransferRequestData;
import org.apache.fineract.interoperation.data.InteropTransferResponseData;
import org.apache.fineract.interoperation.domain.InteropActionState;
import org.apache.fineract.interoperation.domain.InteropIdentifierType;
import org.apache.fineract.interoperation.exception.InteropKycDataNotFoundException;
import org.apache.fineract.interoperation.serialization.InteropDataValidator;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanExistencePort;
import org.apache.fineract.portfolio.note.data.NoteCreateRequest;
import org.apache.fineract.portfolio.note.data.NoteData;
import org.apache.fineract.portfolio.note.domain.NoteType;
import org.apache.fineract.portfolio.note.service.NoteReadPlatformService;
import org.apache.fineract.portfolio.note.service.NoteWritePlatformService;
import org.apache.fineract.portfolio.savings.moduleapi.SavingsInteropPort;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.NonNull;
import org.springframework.transaction.annotation.Transactional;

public class InteropServiceImpl implements InteropService {

    @java.lang.SuppressWarnings("all")
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(InteropServiceImpl.class);

    private final PlatformSecurityContext securityContext;
    private final InteropDataValidator dataValidator;
    private final NoteReadPlatformService noteReadPlatformService;
    private final NoteWritePlatformService noteWritePlatformService;
    private final LoanExistencePort loanExistencePort;
    private final SavingsInteropPort savingsInteropPort;
    private final JdbcTemplate jdbcTemplate;
    private final PortfolioCommandSourceWritePlatformService commandsSourceWritePlatformService;
    private final DefaultToApiJsonSerializer<CommandProcessingResult> toApiJsonSerializer;
    private final DatabaseSpecificSQLGenerator sqlGenerator;

    public InteropServiceImpl(final PlatformSecurityContext securityContext, final InteropDataValidator dataValidator,
            final NoteReadPlatformService noteReadPlatformService, final NoteWritePlatformService noteWritePlatformService,
            final LoanExistencePort loanExistencePort, final SavingsInteropPort savingsInteropPort, final JdbcTemplate jdbcTemplate,
            final PortfolioCommandSourceWritePlatformService commandsSourceWritePlatformService,
            final DefaultToApiJsonSerializer<CommandProcessingResult> toApiJsonSerializer,
            final DatabaseSpecificSQLGenerator sqlGenerator) {
        this.securityContext = securityContext;
        this.dataValidator = dataValidator;
        this.noteReadPlatformService = noteReadPlatformService;
        this.noteWritePlatformService = noteWritePlatformService;
        this.loanExistencePort = loanExistencePort;
        this.savingsInteropPort = savingsInteropPort;
        this.jdbcTemplate = jdbcTemplate;
        this.commandsSourceWritePlatformService = commandsSourceWritePlatformService;
        this.toApiJsonSerializer = toApiJsonSerializer;
        this.sqlGenerator = sqlGenerator;
    }

    private static final class KycMapper implements RowMapper<InteropKycData> {
        private final DatabaseSpecificSQLGenerator sqlGenerator;

        KycMapper(final DatabaseSpecificSQLGenerator sqlGenerator) {
            this.sqlGenerator = sqlGenerator;
        }

        public String schema() {
            return " country.code_value as nationality, c.date_of_birth as dateOfBirth, c.mobile_no as contactPhone, gender.code_value as gender, c.email_address as email, "
                    + "kyc.code_value as idType, ci.document_key as idNo, ci." + sqlGenerator.escape("description") + " as description, "
                    + "country.code_value as country, a.`address_line_1`, a.`address_line_2`, "
                    + "a.city, state.code_value as stateProvince, a.postal_code as postalCode, c.firstname as firstName, c.middlename as middleName,"
                    + "c.lastname as lastName, c.display_name as displayName" + " from " + "m_client c "
                    + "left join m_client_address ca on c.id=ca.client_id " + "left join m_address a on a.id = ca.address_id "
                    + "inner join m_code_value gender on gender.id=c.gender_cv_id "
                    + "left join m_code_value country on country.id=a.country_id "
                    + "left join m_code_value state on state.id = a.state_province_id "
                    + "left join m_client_identifier ci on c.id=ci.client_id " + "left join m_code_value kyc on kyc.id = ci.document_type_id ";
        }

        @Override
        public InteropKycData mapRow(final ResultSet rs, @SuppressWarnings("unused") final int rowNum) throws SQLException {
            return InteropKycData.instance(rs.getString("nationality"), rs.getString("dateOfBirth"), rs.getString("contactPhone"),
                    rs.getString("gender"), rs.getString("email"), rs.getString("idType"), rs.getString("idNo"),
                    rs.getString("description"), rs.getString("country"), rs.getString("address_line_1"), rs.getString("address_line_2"),
                    rs.getString("city"), rs.getString("stateProvince"), rs.getString("postalCode"), rs.getString("firstName"),
                    rs.getString("middleName"), rs.getString("lastName"), rs.getString("displayName"));
        }
    }

    @NonNull
    @Override
    @Transactional
    public InteropAccountData getAccountDetails(@NonNull final String accountId) {
        return savingsInteropPort.accountDetails(accountId);
    }

    @NonNull
    @Override
    @Transactional
    public InteropTransactionsData getAccountTransactions(@NonNull final String accountId, final boolean debit, final boolean credit,
            final LocalDateTime transactionsFrom, final LocalDateTime transactionsTo) {
        final InteropTransactionsData interopTransactionsData = savingsInteropPort.accountTransactions(accountId, debit, credit,
                transactionsFrom, transactionsTo);
        for (final InteropTransactionData interopTransactionData : interopTransactionsData.getTransactions()) {
            final List<NoteData> transactionNotes = this.noteReadPlatformService.retrieveNotesByResource(
                    Long.valueOf(interopTransactionData.getSavingTransactionId()), NoteType.SAVINGS_TRANSACTION.getValue());
            final StringBuilder sb = new StringBuilder();
            for (final NoteData note : transactionNotes) {
                final String s = note.getNote();
                if (s == null) {
                    continue;
                }
                sb.append(s + " ");
            }
            if (sb.toString().length() > 0) {
                String text = interopTransactionData.getNote() + " " + sb.toString();
                if (text.length() > 500) {
                    text = text.substring(0, 500);
                }
                interopTransactionData.updateNote(text);
            }
        }
        return interopTransactionsData;
    }

    @NonNull
    @Override
    @Transactional
    public InteropIdentifiersResponseData getAccountIdentifiers(@NonNull final String accountId) {
        return savingsInteropPort.identifiers(accountId);
    }

    @NonNull
    @Transactional
    @Override
    public InteropIdentifierAccountResponseData getAccountByIdentifier(@NonNull final InteropIdentifierType idType,
            @NonNull final String idValue, final String subIdOrType) {
        return savingsInteropPort.accountByIdentifier(idType, idValue, subIdOrType);
    }

    @NonNull
    @Transactional
    @Override
    public InteropIdentifierAccountResponseData registerAccountIdentifier(@NonNull final InteropIdentifierType idType,
            @NonNull final String idValue, final String subIdOrType, @NonNull final JsonCommand command) {
        final InteropIdentifierRequestData request = dataValidator.validateAndParseCreateIdentifier(idType, idValue, subIdOrType, command);
        return savingsInteropPort.registerIdentifier(request, securityContext.authenticatedUser().getUsername());
    }

    @NonNull
    @Transactional
    @Override
    public InteropIdentifierAccountResponseData deleteAccountIdentifier(@NonNull final InteropIdentifierType idType,
            @NonNull final String idValue, final String subIdOrType) {
        return savingsInteropPort.deleteIdentifier(idType, idValue, subIdOrType);
    }

    @Override
    public InteropTransactionRequestResponseData getTransactionRequest(@NonNull final String transactionCode,
            @NonNull final String requestCode) {
        return InteropTransactionRequestResponseData.build(transactionCode, InteropActionState.REJECTED, requestCode);
    }

    @Override
    @NonNull
    @Transactional
    public InteropTransactionRequestResponseData createTransactionRequest(@NonNull final JsonCommand command) {
        final InteropTransactionRequestData request = dataValidator.validateAndParseCreateRequest(command);
        savingsInteropPort.validateForRequest(request.getRequest());
        return InteropTransactionRequestResponseData.build(command.commandId(), request.getTransactionCode(), InteropActionState.ACCEPTED,
                request.getExpiration(), request.getExtensionList(), request.getRequestCode());
    }

    @Override
    public InteropQuoteResponseData getQuote(@NonNull final String transactionCode, @NonNull final String quoteCode) {
        return null;
    }

    @Override
    @NonNull
    @Transactional
    public InteropQuoteResponseData createQuote(@NonNull final JsonCommand command) {
        final InteropQuoteRequestData request = dataValidator.validateAndParseCreateQuote(command);
        return savingsInteropPort.createQuote(command, request);
    }

    @Override
    public InteropTransferResponseData getTransfer(@NonNull final String transactionCode, @NonNull final String transferCode) {
        return null;
    }

    @Override
    @NonNull
    @Transactional
    public InteropTransferResponseData prepareTransfer(@NonNull final JsonCommand command) {
        final InteropTransferRequestData request = dataValidator.validateAndParseTransferRequest(command);
        return savingsInteropPort.prepareTransfer(command, request);
    }

    @Override
    @NonNull
    @Transactional
    public InteropTransferResponseData commitTransfer(@NonNull final JsonCommand command) {
        final InteropTransferRequestData request = dataValidator.validateAndParseTransferRequest(command);
        final SavingsInteropPort.CommitTransferResult result = savingsInteropPort.commitTransfer(command, request);
        final String note = request.getNote();
        if (!StringUtils.isBlank(note)) {
            this.noteWritePlatformService.createNote(NoteCreateRequest.builder().resourceId(result.savingsTransactionId())
                    .type(NoteType.SAVINGS_TRANSACTION).note(note).build());
        }
        return result.response();
    }

    @Override
    @Transactional
    @NonNull
    public InteropTransferResponseData releaseTransfer(@NonNull final JsonCommand command) {
        final InteropTransferRequestData request = dataValidator.validateAndParseTransferRequest(command);
        return savingsInteropPort.releaseTransfer(command, request);
    }

    @Override
    @NonNull
    public InteropKycResponseData getKyc(@NonNull final String accountId) {
        final Long clientId = savingsInteropPort.clientIdByAccountExternalId(accountId);
        try {
            final InteropServiceImpl.KycMapper rm = new InteropServiceImpl.KycMapper(sqlGenerator);
            final String sql = "select " + rm.schema() + " where c.id = ?";
            final InteropKycData accountKyc = this.jdbcTemplate.queryForObject(sql, rm, new Object[] { clientId }); // NOSONAR
            return InteropKycResponseData.build(accountKyc);
        } catch (final EmptyResultDataAccessException e) {
            throw new InteropKycDataNotFoundException(clientId, e);
        }
    }

    @Override
    @NonNull
    public String disburseLoan(@NonNull final String accountId, final String apiRequestBodyAsJson) {
        final Long loanId = loanExistencePort.requireNonClosedIdByAccountNumber(accountId);
        final CommandWrapperBuilder builder = new CommandWrapperBuilder().withJson(apiRequestBodyAsJson);
        final CommandWrapper commandRequest = builder.disburseLoanApplication(loanId).build();
        final CommandProcessingResult result = this.commandsSourceWritePlatformService.logCommandSource(commandRequest);
        return this.toApiJsonSerializer.serialize(result);
    }

    @Override
    @NonNull
    public String loanRepayment(@NonNull final String accountId, final String apiRequestBodyAsJson) {
        final Long loanId = loanExistencePort.requireNonClosedIdByAccountNumber(accountId);
        final CommandWrapperBuilder builder = new CommandWrapperBuilder().withJson(apiRequestBodyAsJson);
        final CommandWrapper commandRequest = builder.loanRepaymentTransaction(loanId).build();
        final CommandProcessingResult result = this.commandsSourceWritePlatformService.logCommandSource(commandRequest);
        return this.toApiJsonSerializer.serialize(result);
    }
}
