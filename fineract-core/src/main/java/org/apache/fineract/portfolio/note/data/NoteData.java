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
package org.apache.fineract.portfolio.note.data;

import java.io.Serial;
import java.io.Serializable;
import java.time.OffsetDateTime;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;

public class NoteData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private Long clientId;
    private Long groupId;
    private Long loanId;
    private Long loanTransactionId;
    private Long depositAccountId;
    private Long savingAccountId;
    private EnumOptionData noteType;
    private String note;
    private Long createdById;
    private String createdByUsername;
    private OffsetDateTime createdOn;
    private Long updatedById;
    private String updatedByUsername;
    private OffsetDateTime updatedOn;


    @java.lang.SuppressWarnings("all")
        public static class NoteDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private Long clientId;
        @java.lang.SuppressWarnings("all")
                private Long groupId;
        @java.lang.SuppressWarnings("all")
                private Long loanId;
        @java.lang.SuppressWarnings("all")
                private Long loanTransactionId;
        @java.lang.SuppressWarnings("all")
                private Long depositAccountId;
        @java.lang.SuppressWarnings("all")
                private Long savingAccountId;
        @java.lang.SuppressWarnings("all")
                private EnumOptionData noteType;
        @java.lang.SuppressWarnings("all")
                private String note;
        @java.lang.SuppressWarnings("all")
                private Long createdById;
        @java.lang.SuppressWarnings("all")
                private String createdByUsername;
        @java.lang.SuppressWarnings("all")
                private OffsetDateTime createdOn;
        @java.lang.SuppressWarnings("all")
                private Long updatedById;
        @java.lang.SuppressWarnings("all")
                private String updatedByUsername;
        @java.lang.SuppressWarnings("all")
                private OffsetDateTime updatedOn;

        @java.lang.SuppressWarnings("all")
                NoteDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteData.NoteDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteData.NoteDataBuilder clientId(final Long clientId) {
            this.clientId = clientId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteData.NoteDataBuilder groupId(final Long groupId) {
            this.groupId = groupId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteData.NoteDataBuilder loanId(final Long loanId) {
            this.loanId = loanId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteData.NoteDataBuilder loanTransactionId(final Long loanTransactionId) {
            this.loanTransactionId = loanTransactionId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteData.NoteDataBuilder depositAccountId(final Long depositAccountId) {
            this.depositAccountId = depositAccountId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteData.NoteDataBuilder savingAccountId(final Long savingAccountId) {
            this.savingAccountId = savingAccountId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteData.NoteDataBuilder noteType(final EnumOptionData noteType) {
            this.noteType = noteType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteData.NoteDataBuilder note(final String note) {
            this.note = note;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteData.NoteDataBuilder createdById(final Long createdById) {
            this.createdById = createdById;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteData.NoteDataBuilder createdByUsername(final String createdByUsername) {
            this.createdByUsername = createdByUsername;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteData.NoteDataBuilder createdOn(final OffsetDateTime createdOn) {
            this.createdOn = createdOn;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteData.NoteDataBuilder updatedById(final Long updatedById) {
            this.updatedById = updatedById;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteData.NoteDataBuilder updatedByUsername(final String updatedByUsername) {
            this.updatedByUsername = updatedByUsername;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteData.NoteDataBuilder updatedOn(final OffsetDateTime updatedOn) {
            this.updatedOn = updatedOn;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public NoteData build() {
            return new NoteData(this.id, this.clientId, this.groupId, this.loanId, this.loanTransactionId, this.depositAccountId, this.savingAccountId, this.noteType, this.note, this.createdById, this.createdByUsername, this.createdOn, this.updatedById, this.updatedByUsername, this.updatedOn);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "NoteData.NoteDataBuilder(id=" + this.id + ", clientId=" + this.clientId + ", groupId=" + this.groupId + ", loanId=" + this.loanId + ", loanTransactionId=" + this.loanTransactionId + ", depositAccountId=" + this.depositAccountId + ", savingAccountId=" + this.savingAccountId + ", noteType=" + this.noteType + ", note=" + this.note + ", createdById=" + this.createdById + ", createdByUsername=" + this.createdByUsername + ", createdOn=" + this.createdOn + ", updatedById=" + this.updatedById + ", updatedByUsername=" + this.updatedByUsername + ", updatedOn=" + this.updatedOn + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static NoteData.NoteDataBuilder builder() {
        return new NoteData.NoteDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getGroupId() {
        return this.groupId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanTransactionId() {
        return this.loanTransactionId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getDepositAccountId() {
        return this.depositAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getSavingAccountId() {
        return this.savingAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getNoteType() {
        return this.noteType;
    }

    @java.lang.SuppressWarnings("all")
        public String getNote() {
        return this.note;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCreatedById() {
        return this.createdById;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreatedByUsername() {
        return this.createdByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public OffsetDateTime getCreatedOn() {
        return this.createdOn;
    }

    @java.lang.SuppressWarnings("all")
        public Long getUpdatedById() {
        return this.updatedById;
    }

    @java.lang.SuppressWarnings("all")
        public String getUpdatedByUsername() {
        return this.updatedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public OffsetDateTime getUpdatedOn() {
        return this.updatedOn;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientId(final Long clientId) {
        this.clientId = clientId;
    }

    @java.lang.SuppressWarnings("all")
        public void setGroupId(final Long groupId) {
        this.groupId = groupId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanId(final Long loanId) {
        this.loanId = loanId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanTransactionId(final Long loanTransactionId) {
        this.loanTransactionId = loanTransactionId;
    }

    @java.lang.SuppressWarnings("all")
        public void setDepositAccountId(final Long depositAccountId) {
        this.depositAccountId = depositAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public void setSavingAccountId(final Long savingAccountId) {
        this.savingAccountId = savingAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public void setNoteType(final EnumOptionData noteType) {
        this.noteType = noteType;
    }

    @java.lang.SuppressWarnings("all")
        public void setNote(final String note) {
        this.note = note;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreatedById(final Long createdById) {
        this.createdById = createdById;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreatedByUsername(final String createdByUsername) {
        this.createdByUsername = createdByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreatedOn(final OffsetDateTime createdOn) {
        this.createdOn = createdOn;
    }

    @java.lang.SuppressWarnings("all")
        public void setUpdatedById(final Long updatedById) {
        this.updatedById = updatedById;
    }

    @java.lang.SuppressWarnings("all")
        public void setUpdatedByUsername(final String updatedByUsername) {
        this.updatedByUsername = updatedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public void setUpdatedOn(final OffsetDateTime updatedOn) {
        this.updatedOn = updatedOn;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof NoteData)) return false;
        final NoteData other = (NoteData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$clientId = this.getClientId();
        final java.lang.Object other$clientId = other.getClientId();
        if (this$clientId == null ? other$clientId != null : !this$clientId.equals(other$clientId)) return false;
        final java.lang.Object this$groupId = this.getGroupId();
        final java.lang.Object other$groupId = other.getGroupId();
        if (this$groupId == null ? other$groupId != null : !this$groupId.equals(other$groupId)) return false;
        final java.lang.Object this$loanId = this.getLoanId();
        final java.lang.Object other$loanId = other.getLoanId();
        if (this$loanId == null ? other$loanId != null : !this$loanId.equals(other$loanId)) return false;
        final java.lang.Object this$loanTransactionId = this.getLoanTransactionId();
        final java.lang.Object other$loanTransactionId = other.getLoanTransactionId();
        if (this$loanTransactionId == null ? other$loanTransactionId != null : !this$loanTransactionId.equals(other$loanTransactionId)) return false;
        final java.lang.Object this$depositAccountId = this.getDepositAccountId();
        final java.lang.Object other$depositAccountId = other.getDepositAccountId();
        if (this$depositAccountId == null ? other$depositAccountId != null : !this$depositAccountId.equals(other$depositAccountId)) return false;
        final java.lang.Object this$savingAccountId = this.getSavingAccountId();
        final java.lang.Object other$savingAccountId = other.getSavingAccountId();
        if (this$savingAccountId == null ? other$savingAccountId != null : !this$savingAccountId.equals(other$savingAccountId)) return false;
        final java.lang.Object this$createdById = this.getCreatedById();
        final java.lang.Object other$createdById = other.getCreatedById();
        if (this$createdById == null ? other$createdById != null : !this$createdById.equals(other$createdById)) return false;
        final java.lang.Object this$updatedById = this.getUpdatedById();
        final java.lang.Object other$updatedById = other.getUpdatedById();
        if (this$updatedById == null ? other$updatedById != null : !this$updatedById.equals(other$updatedById)) return false;
        final java.lang.Object this$noteType = this.getNoteType();
        final java.lang.Object other$noteType = other.getNoteType();
        if (this$noteType == null ? other$noteType != null : !this$noteType.equals(other$noteType)) return false;
        final java.lang.Object this$note = this.getNote();
        final java.lang.Object other$note = other.getNote();
        if (this$note == null ? other$note != null : !this$note.equals(other$note)) return false;
        final java.lang.Object this$createdByUsername = this.getCreatedByUsername();
        final java.lang.Object other$createdByUsername = other.getCreatedByUsername();
        if (this$createdByUsername == null ? other$createdByUsername != null : !this$createdByUsername.equals(other$createdByUsername)) return false;
        final java.lang.Object this$createdOn = this.getCreatedOn();
        final java.lang.Object other$createdOn = other.getCreatedOn();
        if (this$createdOn == null ? other$createdOn != null : !this$createdOn.equals(other$createdOn)) return false;
        final java.lang.Object this$updatedByUsername = this.getUpdatedByUsername();
        final java.lang.Object other$updatedByUsername = other.getUpdatedByUsername();
        if (this$updatedByUsername == null ? other$updatedByUsername != null : !this$updatedByUsername.equals(other$updatedByUsername)) return false;
        final java.lang.Object this$updatedOn = this.getUpdatedOn();
        final java.lang.Object other$updatedOn = other.getUpdatedOn();
        if (this$updatedOn == null ? other$updatedOn != null : !this$updatedOn.equals(other$updatedOn)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof NoteData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $clientId = this.getClientId();
        result = result * PRIME + ($clientId == null ? 43 : $clientId.hashCode());
        final java.lang.Object $groupId = this.getGroupId();
        result = result * PRIME + ($groupId == null ? 43 : $groupId.hashCode());
        final java.lang.Object $loanId = this.getLoanId();
        result = result * PRIME + ($loanId == null ? 43 : $loanId.hashCode());
        final java.lang.Object $loanTransactionId = this.getLoanTransactionId();
        result = result * PRIME + ($loanTransactionId == null ? 43 : $loanTransactionId.hashCode());
        final java.lang.Object $depositAccountId = this.getDepositAccountId();
        result = result * PRIME + ($depositAccountId == null ? 43 : $depositAccountId.hashCode());
        final java.lang.Object $savingAccountId = this.getSavingAccountId();
        result = result * PRIME + ($savingAccountId == null ? 43 : $savingAccountId.hashCode());
        final java.lang.Object $createdById = this.getCreatedById();
        result = result * PRIME + ($createdById == null ? 43 : $createdById.hashCode());
        final java.lang.Object $updatedById = this.getUpdatedById();
        result = result * PRIME + ($updatedById == null ? 43 : $updatedById.hashCode());
        final java.lang.Object $noteType = this.getNoteType();
        result = result * PRIME + ($noteType == null ? 43 : $noteType.hashCode());
        final java.lang.Object $note = this.getNote();
        result = result * PRIME + ($note == null ? 43 : $note.hashCode());
        final java.lang.Object $createdByUsername = this.getCreatedByUsername();
        result = result * PRIME + ($createdByUsername == null ? 43 : $createdByUsername.hashCode());
        final java.lang.Object $createdOn = this.getCreatedOn();
        result = result * PRIME + ($createdOn == null ? 43 : $createdOn.hashCode());
        final java.lang.Object $updatedByUsername = this.getUpdatedByUsername();
        result = result * PRIME + ($updatedByUsername == null ? 43 : $updatedByUsername.hashCode());
        final java.lang.Object $updatedOn = this.getUpdatedOn();
        result = result * PRIME + ($updatedOn == null ? 43 : $updatedOn.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "NoteData(id=" + this.getId() + ", clientId=" + this.getClientId() + ", groupId=" + this.getGroupId() + ", loanId=" + this.getLoanId() + ", loanTransactionId=" + this.getLoanTransactionId() + ", depositAccountId=" + this.getDepositAccountId() + ", savingAccountId=" + this.getSavingAccountId() + ", noteType=" + this.getNoteType() + ", note=" + this.getNote() + ", createdById=" + this.getCreatedById() + ", createdByUsername=" + this.getCreatedByUsername() + ", createdOn=" + this.getCreatedOn() + ", updatedById=" + this.getUpdatedById() + ", updatedByUsername=" + this.getUpdatedByUsername() + ", updatedOn=" + this.getUpdatedOn() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public NoteData() {
    }

    @java.lang.SuppressWarnings("all")
        public NoteData(final Long id, final Long clientId, final Long groupId, final Long loanId, final Long loanTransactionId, final Long depositAccountId, final Long savingAccountId, final EnumOptionData noteType, final String note, final Long createdById, final String createdByUsername, final OffsetDateTime createdOn, final Long updatedById, final String updatedByUsername, final OffsetDateTime updatedOn) {
        this.id = id;
        this.clientId = clientId;
        this.groupId = groupId;
        this.loanId = loanId;
        this.loanTransactionId = loanTransactionId;
        this.depositAccountId = depositAccountId;
        this.savingAccountId = savingAccountId;
        this.noteType = noteType;
        this.note = note;
        this.createdById = createdById;
        this.createdByUsername = createdByUsername;
        this.createdOn = createdOn;
        this.updatedById = updatedById;
        this.updatedByUsername = updatedByUsername;
        this.updatedOn = updatedOn;
    }
}
