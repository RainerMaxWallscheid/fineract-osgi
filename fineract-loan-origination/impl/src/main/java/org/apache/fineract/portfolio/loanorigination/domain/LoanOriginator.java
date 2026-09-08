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
package org.apache.fineract.portfolio.loanorigination.domain;

import org.apache.fineract.portfolio.loanorigination.moduleapi.LoanOriginatorStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import org.apache.fineract.infrastructure.codes.moduleapi.CodeValueAssociation;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;
import org.apache.fineract.infrastructure.core.domain.ExternalId;

@Entity
@Table(name = "m_loan_originator")
public class LoanOriginator extends AbstractAuditableWithUTCDateTimeCustom<Long> {
    @Column(name = "external_id", nullable = false, length = 100, unique = true)
    private ExternalId externalId;
    @Column(name = "name", length = 255)
    private String name;
    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 20)
    private LoanOriginatorStatus status;
    /**
     * Code-value id (no JPA association to leftover CodeValue — ADR-021).
     */
    @Column(name = "originator_type_cv_id")
    private Long originatorTypeId;
    /**
     * Code-value id (no JPA association to leftover CodeValue — ADR-021).
     */
    @Column(name = "channel_type_cv_id")
    private Long channelTypeId;

    public static LoanOriginator create(ExternalId externalId, String name, LoanOriginatorStatus status, Object originatorType, Object channelType) {
        LoanOriginator originator = new LoanOriginator();
        originator.setExternalId(externalId);
        originator.setName(name);
        originator.setStatus(status);
        originator.setOriginatorType(originatorType);
        originator.setChannelType(channelType);
        return originator;
    }

    public void update(String name, LoanOriginatorStatus status, Object originatorType, Object channelType) {
        this.name = name;
        this.status = status;
        this.originatorTypeId = CodeValueAssociation.id(originatorType);
        this.channelTypeId = CodeValueAssociation.id(channelType);
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public LoanOriginatorStatus getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOriginatorTypeId() {
        return this.originatorTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getChannelTypeId() {
        return this.channelTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalId(final ExternalId externalId) {
        this.externalId = externalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setStatus(final LoanOriginatorStatus status) {
        this.status = status;
    }

    @java.lang.SuppressWarnings("all")
        public void setOriginatorType(final Object originatorType) {
        this.originatorTypeId = CodeValueAssociation.id(originatorType);
    }

    @java.lang.SuppressWarnings("all")
        public void setChannelType(final Object channelType) {
        this.channelTypeId = CodeValueAssociation.id(channelType);
    }

    @java.lang.SuppressWarnings("all")
        public LoanOriginator() {
    }
}
