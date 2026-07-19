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

import jakarta.validation.constraints.NotNull;
import java.beans.Transient;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.interoperation.domain.InteropActionState;

/**
 * Shared interop response fields. Specialized responses compose this type and
 * flatten its fields for Gson serialization (they also extend
 * {@link org.apache.fineract.infrastructure.core.data.CommandProcessingResult}).
 */
public final class InteropResponseData {

    public static final String ISO_DATE_TIME_PATTERN = "yyyy-MM-dd'T'HH:mm:ssZ";
    public static final DateTimeFormatter ISO_DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern(ISO_DATE_TIME_PATTERN);

    @NotNull
    private final String transactionCode;

    @NotNull
    private final InteropActionState state;

    private final String expiration;

    private final List<ExtensionData> extensionList;

    public InteropResponseData(@NotNull String transactionCode, @NotNull InteropActionState state, LocalDateTime expiration,
            List<ExtensionData> extensionList) {
        this.transactionCode = transactionCode;
        this.state = state;
        this.expiration = format(expiration);
        this.extensionList = extensionList;
    }

    public static InteropResponseData of(@NotNull String transactionCode, @NotNull InteropActionState state, LocalDateTime expiration,
            List<ExtensionData> extensionList) {
        return new InteropResponseData(transactionCode, state, expiration, extensionList);
    }

    public static InteropResponseData of(@NotNull String transactionCode, @NotNull InteropActionState state) {
        return of(transactionCode, state, null, null);
    }

    public String getTransactionCode() {
        return transactionCode;
    }

    public InteropActionState getState() {
        return state;
    }

    public String getExpiration() {
        return expiration;
    }

    @Transient
    public LocalDateTime getExpirationDate() {
        return parse(expiration);
    }

    public List<ExtensionData> getExtensionList() {
        return extensionList;
    }

    public static LocalDateTime parse(String date) {
        return date == null ? null : LocalDateTime.parse(date, ISO_DATE_TIME_FORMATTER);
    }

    public static String format(LocalDateTime date) {
        return date == null ? null : ZonedDateTime.of(date, DateUtils.getDateTimeZoneOfTenant()).format(ISO_DATE_TIME_FORMATTER);
    }
}
