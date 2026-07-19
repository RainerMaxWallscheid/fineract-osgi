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
package org.apache.fineract.portfolio.client.domain.search;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import org.apache.fineract.infrastructure.core.domain.ExternalId;

public class SearchedClient {
    private final Long id;
    private final String displayName;
    private final ExternalId externalId;
    private final String accountNumber;
    private final Long officeId;
    private final String officeName;
    private final String mobileNo;
    private final Integer status;
    private final LocalDate activationDate;
    private final OffsetDateTime createdDate;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getDisplayName() {
        return this.displayName;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public String getAccountNumber() {
        return this.accountNumber;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getOfficeName() {
        return this.officeName;
    }

    @java.lang.SuppressWarnings("all")
        public String getMobileNo() {
        return this.mobileNo;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getActivationDate() {
        return this.activationDate;
    }

    @java.lang.SuppressWarnings("all")
        public OffsetDateTime getCreatedDate() {
        return this.createdDate;
    }

    @java.lang.SuppressWarnings("all")
        public SearchedClient(final Long id, final String displayName, final ExternalId externalId, final String accountNumber, final Long officeId, final String officeName, final String mobileNo, final Integer status, final LocalDate activationDate, final OffsetDateTime createdDate) {
        this.id = id;
        this.displayName = displayName;
        this.externalId = externalId;
        this.accountNumber = accountNumber;
        this.officeId = officeId;
        this.officeName = officeName;
        this.mobileNo = mobileNo;
        this.status = status;
        this.activationDate = activationDate;
        this.createdDate = createdDate;
    }
}
