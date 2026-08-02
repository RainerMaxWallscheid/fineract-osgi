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
package org.apache.fineract.cob.domain;

import jakarta.persistence.Column;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.PostLoad;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Transient;
import jakarta.persistence.Version;
import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.springframework.data.domain.Persistable;

@MappedSuperclass
public abstract class AccountLock implements Persistable<Long>, Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "loan_id", nullable = false)
    private Long loanId;
    @Version
    @Column(name = "version")
    private Long version;
    @Enumerated(EnumType.STRING)
    @Column(name = "lock_owner", nullable = false)
    private LockOwner lockOwner;
    @Column(name = "lock_placed_on", nullable = false)
    private OffsetDateTime lockPlacedOn;
    @Column(name = "error")
    private String error;
    @Column(name = "stacktrace")
    private String stacktrace;
    @Column(name = "lock_placed_on_cob_business_date")
    private LocalDate lockPlacedOnCobBusinessDate;
    @Transient
    private boolean isNew = true;

    @PrePersist
    @PostLoad
    void markNotNew() {
        this.isNew = false;
    }

    @Override
    public Long getId() {
        return loanId;
    }

    public AccountLock(Long loanId, LockOwner lockOwner, LocalDate lockPlacedOnCobBusinessDate) {
        this.loanId = loanId;
        this.lockOwner = lockOwner;
        this.lockPlacedOn = DateUtils.getAuditOffsetDateTime();
        this.lockPlacedOnCobBusinessDate = lockPlacedOnCobBusinessDate;
    }

    public void setError(String errorMessage, String stacktrace) {
        this.error = errorMessage;
        this.stacktrace = stacktrace;
    }

    public void setNewLockOwner(LockOwner newLockOwner) {
        this.lockOwner = newLockOwner;
        this.lockPlacedOn = DateUtils.getAuditOffsetDateTime();
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getVersion() {
        return this.version;
    }

    @java.lang.SuppressWarnings("all")
        public LockOwner getLockOwner() {
        return this.lockOwner;
    }

    @java.lang.SuppressWarnings("all")
        public OffsetDateTime getLockPlacedOn() {
        return this.lockPlacedOn;
    }

    @java.lang.SuppressWarnings("all")
        public String getError() {
        return this.error;
    }

    @java.lang.SuppressWarnings("all")
        public String getStacktrace() {
        return this.stacktrace;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getLockPlacedOnCobBusinessDate() {
        return this.lockPlacedOnCobBusinessDate;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isNew() {
        return this.isNew;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanId(final Long loanId) {
        this.loanId = loanId;
    }

    @java.lang.SuppressWarnings("all")
        public void setVersion(final Long version) {
        this.version = version;
    }

    @java.lang.SuppressWarnings("all")
        public void setLockOwner(final LockOwner lockOwner) {
        this.lockOwner = lockOwner;
    }

    @java.lang.SuppressWarnings("all")
        public void setLockPlacedOn(final OffsetDateTime lockPlacedOn) {
        this.lockPlacedOn = lockPlacedOn;
    }

    @java.lang.SuppressWarnings("all")
        public void setError(final String error) {
        this.error = error;
    }

    @java.lang.SuppressWarnings("all")
        public void setStacktrace(final String stacktrace) {
        this.stacktrace = stacktrace;
    }

    @java.lang.SuppressWarnings("all")
        public void setLockPlacedOnCobBusinessDate(final LocalDate lockPlacedOnCobBusinessDate) {
        this.lockPlacedOnCobBusinessDate = lockPlacedOnCobBusinessDate;
    }

    @java.lang.SuppressWarnings("all")
        public AccountLock() {
    }
}
