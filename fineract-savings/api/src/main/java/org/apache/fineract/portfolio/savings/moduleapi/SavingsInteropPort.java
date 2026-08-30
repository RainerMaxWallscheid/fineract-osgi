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
package org.apache.fineract.portfolio.savings.moduleapi;

import java.time.LocalDateTime;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.interoperation.data.InteropAccountData;
import org.apache.fineract.interoperation.data.InteropIdentifierAccountResponseData;
import org.apache.fineract.interoperation.data.InteropIdentifierRequestData;
import org.apache.fineract.interoperation.data.InteropIdentifiersResponseData;
import org.apache.fineract.interoperation.data.InteropQuoteRequestData;
import org.apache.fineract.interoperation.data.InteropQuoteResponseData;
import org.apache.fineract.interoperation.data.InteropRequestData;
import org.apache.fineract.interoperation.data.InteropTransactionsData;
import org.apache.fineract.interoperation.data.InteropTransferRequestData;
import org.apache.fineract.interoperation.data.InteropTransferResponseData;
import org.apache.fineract.interoperation.domain.InteropIdentifierType;
import org.springframework.lang.NonNull;

/**
 * Leftover savings lookup/hold/transfer for interoperation without leftover
 * {@code SavingsAccount} / {@code InteropIdentifier} JPA on foreign BCs.
 */
public interface SavingsInteropPort {

    record CommitTransferResult(InteropTransferResponseData response, Long savingsTransactionId) {}

    @NonNull
    InteropAccountData accountDetails(@NonNull String accountId);

    @NonNull
    InteropTransactionsData accountTransactions(@NonNull String accountId, boolean debit, boolean credit, LocalDateTime transactionsFrom,
            LocalDateTime transactionsTo);

    @NonNull
    InteropIdentifiersResponseData identifiers(@NonNull String accountId);

    @NonNull
    InteropIdentifierAccountResponseData accountByIdentifier(@NonNull InteropIdentifierType idType, @NonNull String idValue,
            String subIdOrType);

    @NonNull
    InteropIdentifierAccountResponseData registerIdentifier(@NonNull InteropIdentifierRequestData request, @NonNull String createdBy);

    @NonNull
    InteropIdentifierAccountResponseData deleteIdentifier(@NonNull InteropIdentifierType idType, @NonNull String idValue,
            String subIdOrType);

    void validateForRequest(@NonNull InteropRequestData request);

    @NonNull
    InteropQuoteResponseData createQuote(@NonNull JsonCommand command, @NonNull InteropQuoteRequestData request);

    @NonNull
    InteropTransferResponseData prepareTransfer(@NonNull JsonCommand command, @NonNull InteropTransferRequestData request);

    @NonNull
    CommitTransferResult commitTransfer(@NonNull JsonCommand command, @NonNull InteropTransferRequestData request);

    @NonNull
    InteropTransferResponseData releaseTransfer(@NonNull JsonCommand command, @NonNull InteropTransferRequestData request);

    @NonNull
    Long clientIdByAccountExternalId(@NonNull String accountId);
}
