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

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

/**
 * Interop savings account details. Composes command-result identifiers instead of extending
 * {@code CommandProcessingResult}. Entity mapping lives in interoperation-impl ({@code InteropDataFactory}).
 * <p>
 * Leftover savings catalog enums ({@code SavingsAccountStatusType}, {@code SavingsAccountSubStatusEnum},
 * {@code AccountType}, {@code DepositAccountType}) are Object-typed — unpublished in savings-api-exported packages
 * (ADR-021).
 */
public final class InteropAccountData {

    private final Long resourceId;
    private final Long officeId;
    private final Long commandId;
    private final Map<String, Object> changes;
    private final Long clientId;

    private final String accountId;
    private final String savingProductId;
    private final String productName;
    private final String shortProductName;
    private final String currency;
    private final BigDecimal accountBalance;
    private final BigDecimal availableBalance;
    private final Object status;
    private final Object subStatus;
    private final Object accountType;
    private final Object depositType;
    private final LocalDate activatedOn;
    private final LocalDate statusUpdateOn;
    private final LocalDate withdrawnOn;
    private final LocalDate balanceOn;
    private List<InteropIdentifierData> identifiers;

    public InteropAccountData(Long resourceId, Long officeId, Long commandId, Map<String, Object> changesOnly, String accountId,
            String productId, String productName, String shortProductName, String currency, BigDecimal accountBalance,
            BigDecimal availableBalance, Object status, Object subStatus, Object accountType, Object depositType, LocalDate activatedOn,
            LocalDate statusUpdateOn, LocalDate withdrawnOn, LocalDate balanceOn, List<InteropIdentifierData> identifiers, long clientId) {
        this.resourceId = resourceId;
        this.officeId = officeId;
        this.commandId = commandId;
        this.changes = changesOnly;
        this.clientId = clientId;
        this.accountId = accountId;
        this.savingProductId = productId;
        this.productName = productName;
        this.shortProductName = shortProductName;
        this.currency = currency;
        this.accountBalance = accountBalance;
        this.availableBalance = availableBalance;
        this.status = status;
        this.subStatus = subStatus;
        this.accountType = accountType;
        this.depositType = depositType;
        this.activatedOn = activatedOn;
        this.statusUpdateOn = statusUpdateOn;
        this.withdrawnOn = withdrawnOn;
        this.balanceOn = balanceOn;
        this.identifiers = identifiers;
    }

    public InteropAccountData(String accountId, String productId, String productName, String shortProductName, String currency,
            BigDecimal accountBalance, BigDecimal availableBalance, Object status, Object subStatus, Object accountType, Object depositType,
            LocalDate activatedOn, LocalDate statusUpdateOn, LocalDate withdrawnOn, LocalDate balanceOn,
            List<InteropIdentifierData> identifiers, long clientId) {
        this(null, null, null, null, accountId, productId, productName, shortProductName, currency, accountBalance, availableBalance,
                status, subStatus, accountType, depositType, activatedOn, statusUpdateOn, withdrawnOn, balanceOn, identifiers, clientId);
    }

    public Long getResourceId() {
        return resourceId;
    }

    public Long getOfficeId() {
        return officeId;
    }

    public Long getCommandId() {
        return commandId;
    }

    public Map<String, Object> getChanges() {
        return changes;
    }

    public Long getClientId() {
        return clientId;
    }

    public String getAccountId() {
        return accountId;
    }

    public String getSavingProductId() {
        return savingProductId;
    }

    public String getProductName() {
        return productName;
    }

    public String getShortProductName() {
        return shortProductName;
    }

    public String getCurrency() {
        return currency;
    }

    public BigDecimal getAccountBalance() {
        return accountBalance;
    }

    public BigDecimal getAvailableBalance() {
        return availableBalance;
    }

    public Object getStatus() {
        return status;
    }

    public Object getSubStatus() {
        return subStatus;
    }

    public Object getAccountType() {
        return accountType;
    }

    public Object getDepositType() {
        return depositType;
    }

    public LocalDate getActivatedOn() {
        return activatedOn;
    }

    public LocalDate getStatusUpdateOn() {
        return statusUpdateOn;
    }

    public LocalDate getWithdrawnOn() {
        return withdrawnOn;
    }

    public LocalDate getBalanceOn() {
        return balanceOn;
    }

    public List<InteropIdentifierData> getIdentifiers() {
        return identifiers;
    }
}
