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
package org.apache.fineract.portfolio.account.data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Collection;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.organisation.office.data.OfficeData;
import org.apache.fineract.portfolio.client.data.ClientData;

/**
 * Immutable data object representing a savings account.
 */
public final class AccountTransferData implements Serializable {
    private final Long id;
    private final Boolean reversed;
    private final CurrencyData currency;
    private final BigDecimal transferAmount;
    private final LocalDate transferDate;
    private final String transferDescription;
    private final OfficeData fromOffice;
    private final ClientData fromClient;
    private final EnumOptionData fromAccountType;
    private final PortfolioAccountData fromAccount;
    private final OfficeData toOffice;
    private final ClientData toClient;
    private final EnumOptionData toAccountType;
    private final PortfolioAccountData toAccount;
    // template
    private final Collection<OfficeData> fromOfficeOptions;
    private final Collection<ClientData> fromClientOptions;
    private final Collection<EnumOptionData> fromAccountTypeOptions;
    private final Collection<PortfolioAccountData> fromAccountOptions;
    private final Collection<OfficeData> toOfficeOptions;
    private final Collection<ClientData> toClientOptions;
    private final Collection<EnumOptionData> toAccountTypeOptions;
    private final Collection<PortfolioAccountData> toAccountOptions;

    public static AccountTransferData template(final OfficeData fromOffice, final ClientData fromClient, final EnumOptionData fromAccountType, final PortfolioAccountData fromAccount, final LocalDate transferDate, final OfficeData toOffice, final ClientData toClient, final EnumOptionData toAccountType, final PortfolioAccountData toAccount, final Collection<OfficeData> fromOfficeOptions, final Collection<ClientData> fromClientOptions, final Collection<EnumOptionData> fromAccountTypeOptions, final Collection<PortfolioAccountData> fromAccountOptions, final Collection<OfficeData> toOfficeOptions, final Collection<ClientData> toClientOptions, final Collection<EnumOptionData> toAccountTypeOptions, final Collection<PortfolioAccountData> toAccountOptions) {
        final Long id = null;
        CurrencyData currency = null;
        BigDecimal transferAmount = BigDecimal.ZERO;
        if (fromAccount != null) {
            currency = fromAccount.getCurrency();
            if (fromAccount.getAmtForTransfer() != null) {
                transferAmount = fromAccount.getAmtForTransfer();
            }
        }
        final String transferDescription = null;
        final Boolean reversed = null;
        return new AccountTransferData(id, reversed, fromOffice, fromClient, fromAccountType, fromAccount, currency, transferAmount, transferDate, transferDescription, toOffice, toClient, toAccountType, toAccount, fromOfficeOptions, fromClientOptions, fromAccountTypeOptions, fromAccountOptions, toOfficeOptions, toClientOptions, toAccountTypeOptions, toAccountOptions);
    }

    public static AccountTransferData instance(final Long id, final Boolean reversed, final LocalDate transferDate, final CurrencyData currency, final BigDecimal transferAmount, final String transferDescription, final OfficeData fromOffice, final OfficeData toOffice, final ClientData fromClient, final ClientData toClient, final EnumOptionData fromAccountType, final PortfolioAccountData fromAccount, final EnumOptionData toAccountType, final PortfolioAccountData toAccount) {
        return new AccountTransferData(id, reversed, fromOffice, fromClient, fromAccountType, fromAccount, currency, transferAmount, transferDate, transferDescription, toOffice, toClient, toAccountType, toAccount, null, null, null, null, null, null, null, null);
    }

    public static AccountTransferData transferBasicDetails(final Long id, final CurrencyData currency, final BigDecimal transferAmount, final LocalDate transferDate, final String description, final Boolean reversed) {
        final EnumOptionData fromAccountType = null;
        final EnumOptionData toAccountType = null;
        return new AccountTransferData(id, reversed, null, null, fromAccountType, null, currency, transferAmount, transferDate, description, null, null, toAccountType, null, null, null, null, null, null, null, null, null);
    }

    private AccountTransferData(final Long id, final Boolean reversed, final OfficeData fromOffice, final ClientData fromClient, final EnumOptionData fromAccountType, final PortfolioAccountData fromAccount, final CurrencyData currency, final BigDecimal transferAmount, final LocalDate transferDate, final String transferDescription, final OfficeData toOffice, final ClientData toClient, final EnumOptionData toAccountType, final PortfolioAccountData toAccount, final Collection<OfficeData> fromOfficeOptions, final Collection<ClientData> fromClientOptions, final Collection<EnumOptionData> fromAccountTypeOptions, final Collection<PortfolioAccountData> fromAccountOptions, final Collection<OfficeData> toOfficeOptions, final Collection<ClientData> toClientOptions, final Collection<EnumOptionData> toAccountTypeOptions, final Collection<PortfolioAccountData> toAccountOptions) {
        this.id = id;
        this.reversed = reversed;
        this.fromOffice = fromOffice;
        this.fromClient = fromClient;
        this.fromAccountType = fromAccountType;
        this.fromAccount = fromAccount;
        this.toOffice = toOffice;
        this.toClient = toClient;
        this.toAccountType = toAccountType;
        this.toAccount = toAccount;
        this.currency = currency;
        this.transferAmount = transferAmount;
        this.transferDate = transferDate;
        this.transferDescription = transferDescription;
        this.fromOfficeOptions = fromOfficeOptions;
        this.fromClientOptions = fromClientOptions;
        this.fromAccountTypeOptions = fromAccountTypeOptions;
        this.fromAccountOptions = fromAccountOptions;
        this.toOfficeOptions = toOfficeOptions;
        this.toClientOptions = toClientOptions;
        this.toAccountTypeOptions = toAccountTypeOptions;
        this.toAccountOptions = toAccountOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getReversed() {
        return this.reversed;
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTransferAmount() {
        return this.transferAmount;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getTransferDate() {
        return this.transferDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransferDescription() {
        return this.transferDescription;
    }

    @java.lang.SuppressWarnings("all")
        public OfficeData getFromOffice() {
        return this.fromOffice;
    }

    @java.lang.SuppressWarnings("all")
        public ClientData getFromClient() {
        return this.fromClient;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getFromAccountType() {
        return this.fromAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public PortfolioAccountData getFromAccount() {
        return this.fromAccount;
    }

    @java.lang.SuppressWarnings("all")
        public OfficeData getToOffice() {
        return this.toOffice;
    }

    @java.lang.SuppressWarnings("all")
        public ClientData getToClient() {
        return this.toClient;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getToAccountType() {
        return this.toAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public PortfolioAccountData getToAccount() {
        return this.toAccount;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<OfficeData> getFromOfficeOptions() {
        return this.fromOfficeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<ClientData> getFromClientOptions() {
        return this.fromClientOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<EnumOptionData> getFromAccountTypeOptions() {
        return this.fromAccountTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<PortfolioAccountData> getFromAccountOptions() {
        return this.fromAccountOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<OfficeData> getToOfficeOptions() {
        return this.toOfficeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<ClientData> getToClientOptions() {
        return this.toClientOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<EnumOptionData> getToAccountTypeOptions() {
        return this.toAccountTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<PortfolioAccountData> getToAccountOptions() {
        return this.toAccountOptions;
    }
}
