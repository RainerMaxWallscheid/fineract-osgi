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

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.interoperation.data.InteropAccountData;
import org.apache.fineract.interoperation.data.InteropIdentifierAccountResponseData;
import org.apache.fineract.interoperation.data.InteropIdentifiersResponseData;
import org.apache.fineract.interoperation.data.InteropKycResponseData;
import org.apache.fineract.interoperation.data.InteropQuoteResponseData;
import org.apache.fineract.interoperation.data.InteropTransactionRequestResponseData;
import org.apache.fineract.interoperation.data.InteropTransactionsData;
import org.apache.fineract.interoperation.data.InteropTransferResponseData;
import org.apache.fineract.interoperation.domain.InteropIdentifierType;
import org.apache.fineract.interoperation.service.InteropService;

/** Composition-root hosted interoperation for the Equinox bridge smoke. */
final class HostedInteropService implements InteropService {

    static final String HOSTED = "hosted";

    @Override
    public InteropIdentifiersResponseData getAccountIdentifiers(final String accountId) {
        return null;
    }

    @Override
    public InteropAccountData getAccountDetails(final String accountId) {
        return new InteropAccountData(HOSTED, HOSTED, HOSTED, HOSTED, HOSTED, BigDecimal.ZERO, BigDecimal.ZERO, null, null, null, null,
                LocalDate.EPOCH, null, null, null, List.of(), 1L);
    }

    @Override
    public InteropTransactionsData getAccountTransactions(final String accountId, final boolean debit, final boolean credit,
            final LocalDateTime transactionsFrom, final LocalDateTime transactionsTo) {
        return null;
    }

    @Override
    public InteropIdentifierAccountResponseData getAccountByIdentifier(final InteropIdentifierType idType, final String idValue,
            final String subIdOrType) {
        return null;
    }

    @Override
    public InteropIdentifierAccountResponseData registerAccountIdentifier(final InteropIdentifierType idType, final String idValue,
            final String subIdOrType, final JsonCommand command) {
        return null;
    }

    @Override
    public InteropIdentifierAccountResponseData deleteAccountIdentifier(final InteropIdentifierType idType, final String idValue,
            final String subIdOrType) {
        return null;
    }

    @Override
    public InteropTransactionRequestResponseData getTransactionRequest(final String transactionCode, final String requestCode) {
        return null;
    }

    @Override
    public InteropTransactionRequestResponseData createTransactionRequest(final JsonCommand command) {
        return null;
    }

    @Override
    public InteropQuoteResponseData getQuote(final String transactionCode, final String quoteCode) {
        return null;
    }

    @Override
    public InteropQuoteResponseData createQuote(final JsonCommand command) {
        return null;
    }

    @Override
    public InteropTransferResponseData getTransfer(final String transactionCode, final String transferCode) {
        return null;
    }

    @Override
    public InteropTransferResponseData prepareTransfer(final JsonCommand command) {
        return null;
    }

    @Override
    public InteropTransferResponseData commitTransfer(final JsonCommand command) {
        return null;
    }

    @Override
    public InteropTransferResponseData releaseTransfer(final JsonCommand command) {
        return null;
    }

    @Override
    public InteropKycResponseData getKyc(final String accountId) {
        return null;
    }

    @Override
    public String disburseLoan(final String accountId, final String apiRequestBodyAsJson) {
        return HOSTED;
    }

    @Override
    public String loanRepayment(final String accountId, final String apiRequestBodyAsJson) {
        return HOSTED;
    }
}
