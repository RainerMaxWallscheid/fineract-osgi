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
package org.apache.fineract.portfolio.note.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.Strings;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;
import org.apache.fineract.portfolio.client.domain.Client;
import org.apache.fineract.portfolio.group.domain.Group;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransaction;
import org.apache.fineract.portfolio.savings.domain.SavingsAccount;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountTransaction;

/**
 * Note entity. Foreign keys are stored as Long columns (no cross-module
 * {@code @ManyToOne}) for static weaving safety across loan/savings/share peels.
 * Factory helpers still accept aggregate roots for call-site convenience.
 */
@Entity
@Table(name = "m_note")
public class Note extends AbstractAuditableWithUTCDateTimeCustom<Long> {

    @Column(name = "client_id")
    private Long clientId;

    @Column(name = "group_id")
    private Long groupId;

    @Column(name = "loan_id")
    private Long loanId;

    @Column(name = "loan_transaction_id")
    private Long loanTransactionId;

    @Column(name = "note", length = 1000)
    private String note;

    @Column(name = "note_type_enum")
    private Integer noteTypeId;

    @Column(name = "savings_account_id")
    private Long savingsAccountId;

    @Column(name = "savings_account_transaction_id")
    private Long savingsTransactionId;

    @Column(name = "share_account_id")
    private Long shareAccountId;

    public static Note clientNote(final Client client, final String note) {
        return new Note(client.getId(), null, null, null, note, NoteType.CLIENT.getValue(), null, null, null);
    }

    public static Note groupNote(final Group group, final String note) {
        return new Note(null, group.getId(), null, null, note, NoteType.GROUP.getValue(), null, null, null);
    }

    public static Note loanNote(final Loan loan, final String note) {
        final Long clientId = loan.client() == null ? null : loan.client().getId();
        return new Note(clientId, null, loan.getId(), null, note, NoteType.LOAN.getValue(), null, null, null);
    }

    public static Note loanTransactionNote(final Loan loan, final LoanTransaction loanTransaction, final String note) {
        final Long clientId = loan.client() == null ? null : loan.client().getId();
        return new Note(clientId, null, loan.getId(), loanTransaction.getId(), note, NoteType.LOAN_TRANSACTION.getValue(), null, null,
                null);
    }

    public static Note savingNote(final SavingsAccount account, final String note) {
        final Long clientId = account.getClient() == null ? null : account.getClient().getId();
        return new Note(clientId, null, null, null, note, NoteType.SAVING_ACCOUNT.getValue(), account.getId(), null, null);
    }

    public static Note savingsTransactionNote(final SavingsAccount savingsAccount, final SavingsAccountTransaction savingsTransaction,
            final String note) {
        final Long clientId = savingsAccount.getClient() == null ? null : savingsAccount.getClient().getId();
        return new Note(clientId, null, null, null, note, NoteType.SAVINGS_TRANSACTION.getValue(), savingsAccount.getId(),
                savingsTransaction.getId(), null);
    }

    public static Note shareNote(final Long shareAccountId, final Long clientId, final String note) {
        return new Note(clientId, null, null, null, note, NoteType.SHARE_ACCOUNT.getValue(), null, null, shareAccountId);
    }

    private Note(final Long clientId, final Long groupId, final Long loanId, final Long loanTransactionId, final String note,
            final Integer noteTypeId, final Long savingsAccountId, final Long savingsTransactionId, final Long shareAccountId) {
        this.clientId = clientId;
        this.groupId = groupId;
        this.loanId = loanId;
        this.loanTransactionId = loanTransactionId;
        this.note = note;
        this.noteTypeId = noteTypeId;
        this.savingsAccountId = savingsAccountId;
        this.savingsTransactionId = savingsTransactionId;
        this.shareAccountId = shareAccountId;
    }

    protected Note() {
    }

    public Map<String, Object> update(final String note) {
        if (!Strings.CI.equals(note, this.note)) {
            this.note = StringUtils.defaultIfEmpty(note, null);
            return Map.of("note", note);
        }
        return Map.of();
    }

    public String getNote() {
        return note;
    }

    public Long getClientId() {
        return clientId;
    }

    public Long getGroupId() {
        return groupId;
    }

    public Long getLoanId() {
        return loanId;
    }

    public Long getLoanTransactionId() {
        return loanTransactionId;
    }

    public Long getSavingsAccountId() {
        return savingsAccountId;
    }

    public Long getSavingsTransactionId() {
        return savingsTransactionId;
    }

    public Long getShareAccountId() {
        return shareAccountId;
    }
}
