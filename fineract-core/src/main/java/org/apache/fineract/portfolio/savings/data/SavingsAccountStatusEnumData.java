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
package org.apache.fineract.portfolio.savings.data;

import java.io.Serializable;

/**
 * Immutable data object represent savings account status enumerations.
 */
public class SavingsAccountStatusEnumData implements Serializable {
    private final Long id;
    private final String code;
    private final String value;
    private final boolean submittedAndPendingApproval;
    private final boolean approved;
    private final boolean rejected;
    private final boolean withdrawnByApplicant;
    private final boolean active;
    private final boolean closed;
    private final boolean prematureClosed;
    private final boolean transferInProgress;
    private final boolean transferOnHold;
    private final boolean matured;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getCode() {
        return this.code;
    }

    @java.lang.SuppressWarnings("all")
        public String getValue() {
        return this.value;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isSubmittedAndPendingApproval() {
        return this.submittedAndPendingApproval;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isApproved() {
        return this.approved;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isRejected() {
        return this.rejected;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isWithdrawnByApplicant() {
        return this.withdrawnByApplicant;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isActive() {
        return this.active;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isClosed() {
        return this.closed;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isPrematureClosed() {
        return this.prematureClosed;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isTransferInProgress() {
        return this.transferInProgress;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isTransferOnHold() {
        return this.transferOnHold;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isMatured() {
        return this.matured;
    }

    @java.lang.SuppressWarnings("all")
        public SavingsAccountStatusEnumData(final Long id, final String code, final String value, final boolean submittedAndPendingApproval, final boolean approved, final boolean rejected, final boolean withdrawnByApplicant, final boolean active, final boolean closed, final boolean prematureClosed, final boolean transferInProgress, final boolean transferOnHold, final boolean matured) {
        this.id = id;
        this.code = code;
        this.value = value;
        this.submittedAndPendingApproval = submittedAndPendingApproval;
        this.approved = approved;
        this.rejected = rejected;
        this.withdrawnByApplicant = withdrawnByApplicant;
        this.active = active;
        this.closed = closed;
        this.prematureClosed = prematureClosed;
        this.transferInProgress = transferInProgress;
        this.transferOnHold = transferOnHold;
        this.matured = matured;
    }
}
