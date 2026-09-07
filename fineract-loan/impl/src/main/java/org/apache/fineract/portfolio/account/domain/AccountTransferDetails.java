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
package org.apache.fineract.portfolio.account.domain;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import java.util.ArrayList;
import java.util.List;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.organisation.office.moduleapi.OfficeAssociation;
import org.apache.fineract.portfolio.client.moduleapi.ClientAssociation;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;

@Entity
@Table(name = "m_account_transfer_details")
public class AccountTransferDetails extends AbstractPersistableCustom<Long> {

    /**
     * From-office id (no JPA association to leftover Office — ADR-021).
     */
    @Column(name = "from_office_id", nullable = false)
    private Long fromOfficeId;

    /**
     * From-client id (no JPA association to leftover Client — ADR-021).
     */
    @Column(name = "from_client_id", nullable = false)
    private Long fromClientId;

    @Column(name = "from_savings_account_id")
    private Long fromSavingsAccountId;

    /**
     * To-office id (no JPA association to leftover Office — ADR-021).
     */
    @Column(name = "to_office_id", nullable = false)
    private Long toOfficeId;

    /**
     * To-client id (no JPA association to leftover Client — ADR-021).
     */
    @Column(name = "to_client_id", nullable = false)
    private Long toClientId;

    @Column(name = "to_savings_account_id")
    private Long toSavingsAccountId;

    @ManyToOne
    @JoinColumn(name = "to_loan_account_id", nullable = true)
    private Loan toLoanAccount;

    @ManyToOne
    @JoinColumn(name = "from_loan_account_id", nullable = true)
    private Loan fromLoanAccount;

    @Column(name = "transfer_type")
    private Integer transferType;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "accountTransferDetails", orphanRemoval = true, fetch = FetchType.EAGER)
    private List<AccountTransferTransaction> accountTransferTransactions = new ArrayList<>();

    @OneToOne(mappedBy = "accountTransferDetails", cascade = CascadeType.ALL, optional = true, orphanRemoval = true, fetch = FetchType.EAGER)
    private AccountTransferStandingInstruction accountTransferStandingInstruction;

    public static AccountTransferDetails savingsToSavingsTransfer(final Object fromOffice, final Object fromClient,
            final Long fromSavingsAccountId, final Object toOffice, final Object toClient, final Long toSavingsAccountId,
            Integer transferType) {

        return new AccountTransferDetails(fromOffice, fromClient, fromSavingsAccountId, null, toOffice, toClient, toSavingsAccountId, null,
                transferType, null);
    }

    public static AccountTransferDetails savingsToLoanTransfer(final Object fromOffice, final Object fromClient,
            final Long fromSavingsAccountId, final Object toOffice, final Object toClient, final Loan toLoanAccount, Integer transferType) {
        return new AccountTransferDetails(fromOffice, fromClient, fromSavingsAccountId, null, toOffice, toClient, null, toLoanAccount,
                transferType, null);
    }

    public static AccountTransferDetails loanTosavingsTransfer(final Object fromOffice, final Object fromClient, final Loan fromLoanAccount,
            final Object toOffice, final Object toClient, final Long toSavingsAccountId, Integer transferType) {
        return new AccountTransferDetails(fromOffice, fromClient, null, fromLoanAccount, toOffice, toClient, toSavingsAccountId, null,
                transferType, null);
    }

    protected AccountTransferDetails() {
        //
    }

    private AccountTransferDetails(final Object fromOffice, final Object fromClient, final Long fromSavingsAccountId,
            final Loan fromLoanAccount, final Object toOffice, final Object toClient, final Long toSavingsAccountId,
            final Loan toLoanAccount, final Integer transferType,
            final AccountTransferStandingInstruction accountTransferStandingInstruction) {
        this.fromOfficeId = OfficeAssociation.id(fromOffice);
        this.fromClientId = ClientAssociation.id(fromClient);
        this.fromSavingsAccountId = fromSavingsAccountId;
        this.fromLoanAccount = fromLoanAccount;
        this.toOfficeId = OfficeAssociation.id(toOffice);
        this.toClientId = ClientAssociation.id(toClient);
        this.toSavingsAccountId = toSavingsAccountId;
        this.toLoanAccount = toLoanAccount;
        this.transferType = transferType;
        this.accountTransferStandingInstruction = accountTransferStandingInstruction;
    }

    public Long toSavingsAccountId() {
        return this.toSavingsAccountId;
    }

    public Long fromSavingsAccountId() {
        return this.fromSavingsAccountId;
    }

    public void addAccountTransferTransaction(AccountTransferTransaction accountTransferTransaction) {
        this.accountTransferTransactions.add(accountTransferTransaction);
    }

    public void updateAccountTransferStandingInstruction(final AccountTransferStandingInstruction accountTransferStandingInstruction) {
        this.accountTransferStandingInstruction = accountTransferStandingInstruction;
    }

    public Loan toLoanAccount() {
        return this.toLoanAccount;
    }

    public Loan fromLoanAccount() {
        return this.fromLoanAccount;
    }

    public AccountTransferStandingInstruction accountTransferStandingInstruction() {
        return this.accountTransferStandingInstruction;
    }

    public AccountTransferType transferType() {
        return AccountTransferType.fromInt(this.transferType);
    }

    public static AccountTransferDetails loanToLoanTransfer(Object fromOffice, Object fromClient, Loan fromLoanAccount, Object toOffice,
            Object toClient, Loan toLoanAccount, Integer transferType) {
        return new AccountTransferDetails(fromOffice, fromClient, null, fromLoanAccount, toOffice, toClient, null, toLoanAccount,
                transferType, null);
    }

    public List<AccountTransferTransaction> getAccountTransferTransactions() {
        return accountTransferTransactions;
    }
}
