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
package org.apache.fineract.infrastructure.businessdate.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import jakarta.persistence.Version;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;

@Entity
@Table(name = "m_business_date", uniqueConstraints = {@UniqueConstraint(name = "uq_business_date_type", columnNames = {"type"})})
public class BusinessDate extends AbstractAuditableWithUTCDateTimeCustom<Long> {
    @Enumerated(EnumType.STRING)
    @Column(name = "type")
    private BusinessDateType type;
    @Column(name = "date", columnDefinition = "DATE")
    private LocalDate date;
    @Version
    private Long version;

    public static BusinessDate instance(@NotNull BusinessDateType businessDateType, @NotNull LocalDate date) {
        return new BusinessDate().setType(businessDateType).setDate(date);
    }

    @java.lang.SuppressWarnings("all")
        public BusinessDateType getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDate() {
        return this.date;
    }

    @java.lang.SuppressWarnings("all")
        public Long getVersion() {
        return this.version;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public BusinessDate setType(final BusinessDateType type) {
        this.type = type;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public BusinessDate setDate(final LocalDate date) {
        this.date = date;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public BusinessDate setVersion(final Long version) {
        this.version = version;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public BusinessDate() {
    }
}
