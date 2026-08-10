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
package org.apache.fineract.interoperation.data;

import static org.apache.fineract.interoperation.util.InteropUtil.PARAM_ACCOUNT_ID;
import static org.apache.fineract.interoperation.util.InteropUtil.PARAM_AMOUNT;
import static org.apache.fineract.interoperation.util.InteropUtil.PARAM_DATE_FORMAT;
import static org.apache.fineract.interoperation.util.InteropUtil.PARAM_EXPIRATION;
import static org.apache.fineract.interoperation.util.InteropUtil.PARAM_EXTENSION_LIST;
import static org.apache.fineract.interoperation.util.InteropUtil.PARAM_GEO_CODE;
import static org.apache.fineract.interoperation.util.InteropUtil.PARAM_LOCALE;
import static org.apache.fineract.interoperation.util.InteropUtil.PARAM_NOTE;
import static org.apache.fineract.interoperation.util.InteropUtil.PARAM_REQUEST_CODE;
import static org.apache.fineract.interoperation.util.InteropUtil.PARAM_TRANSACTION_CODE;
import static org.apache.fineract.interoperation.util.InteropUtil.PARAM_TRANSACTION_ROLE;
import static org.apache.fineract.interoperation.util.InteropUtil.PARAM_TRANSACTION_TYPE;

import com.google.gson.JsonObject;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import org.apache.fineract.infrastructure.core.data.DataValidatorBuilder;
import org.apache.fineract.infrastructure.core.serialization.FromJsonHelper;
import org.apache.fineract.interoperation.domain.InteropTransactionRole;
import org.apache.fineract.organisation.monetary.domain.MonetaryCurrency;

/**
 * Transaction-request payload composed around shared {@link InteropRequestData}
 * (PAYER role, required requestCode / transactionType).
 */
public final class InteropTransactionRequestData {

    static final String[] PARAMS = { PARAM_TRANSACTION_CODE, PARAM_REQUEST_CODE, PARAM_ACCOUNT_ID, PARAM_AMOUNT, PARAM_TRANSACTION_ROLE,
            PARAM_TRANSACTION_TYPE, PARAM_NOTE, PARAM_GEO_CODE, PARAM_EXPIRATION, PARAM_EXTENSION_LIST, PARAM_LOCALE, PARAM_DATE_FORMAT };

    @NotNull
    private final InteropRequestData request;

    public InteropTransactionRequestData(@NotNull InteropRequestData request) {
        this.request = request;
    }

    public InteropTransactionRequestData(@NotNull String transactionCode, @NotNull String requestCode, @NotNull String accountId,
            @NotNull MoneyData amount, @NotNull InteropTransactionTypeData transactionType, String note, GeoCodeData geoCode,
            LocalDateTime expiration, List<ExtensionData> extensionList) {
        this(new InteropRequestData(transactionCode, requestCode, accountId, amount, InteropTransactionRole.PAYER, transactionType, note,
                geoCode, expiration, extensionList));
    }

    public InteropTransactionRequestData(@NotNull String transactionCode, @NotNull String requestCode, @NotNull String accountId,
            @NotNull MoneyData amount, @NotNull InteropTransactionTypeData transactionType) {
        this(transactionCode, requestCode, accountId, amount, transactionType, null, null, null, null);
    }

    @NotNull
    public InteropRequestData getRequest() {
        return request;
    }

    @NotNull
    public String getTransactionCode() {
        return request.getTransactionCode();
    }

    public String getRequestCode() {
        return request.getRequestCode();
    }

    @NotNull
    public String getAccountId() {
        return request.getAccountId();
    }

    @NotNull
    public MoneyData getAmount() {
        return request.getAmount();
    }

    public InteropTransactionTypeData getTransactionType() {
        return request.getTransactionType();
    }

    @NotNull
    public InteropTransactionRole getTransactionRole() {
        return request.getTransactionRole();
    }

    public String getNote() {
        return request.getNote();
    }

    public GeoCodeData getGeoCode() {
        return request.getGeoCode();
    }

    public LocalDateTime getExpiration() {
        return request.getExpiration();
    }

    public LocalDate getExpirationLocalDate() {
        return request.getExpirationLocalDate();
    }

    public List<ExtensionData> getExtensionList() {
        return request.getExtensionList();
    }

    public void normalizeAmounts(@NotNull MonetaryCurrency currency) {
        request.normalizeAmounts(currency);
    }

    public static InteropTransactionRequestData validateAndParse(final DataValidatorBuilder dataValidator, JsonObject element,
            FromJsonHelper jsonHelper) {
        if (element == null) {
            return null;
        }

        jsonHelper.checkForUnsupportedParameters(element, Arrays.asList(PARAMS));

        InteropRequestData interopRequestData = InteropRequestData.validateAndParse(dataValidator, element, jsonHelper);
        if (interopRequestData == null) {
            return null;
        }

        DataValidatorBuilder dataValidatorCopy = dataValidator.reset().parameter(PARAM_REQUEST_CODE)
                .value(interopRequestData.getRequestCode()).notNull();
        dataValidatorCopy = dataValidatorCopy.reset().parameter(PARAM_TRANSACTION_TYPE).value(interopRequestData.getTransactionType())
                .notNull();
        dataValidatorCopy = dataValidatorCopy.reset().parameter(PARAM_TRANSACTION_ROLE).value(interopRequestData.getTransactionRole())
                .ignoreIfNull().isOneOfTheseValues(InteropTransactionRole.PAYER);

        dataValidator.merge(dataValidatorCopy);
        return dataValidator.hasError() ? null : new InteropTransactionRequestData(interopRequestData);
    }
}
