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
package org.apache.fineract.portfolio.paymenttype.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;

@Entity
@Table(name = "m_payment_type")
public class PaymentType extends AbstractPersistableCustom<Long> {
    @Column(name = "value")
    private String name;
    @Column(name = "description")
    private String description;
    @Column(name = "is_cash_payment")
    private Boolean isCashPayment;
    @Column(name = "order_position")
    private Long position;
    @Column(name = "code_name")
    private String codeName;
    @Column(name = "is_system_defined")
    private Boolean isSystemDefined;

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsCashPayment() {
        return this.isCashPayment;
    }

    @java.lang.SuppressWarnings("all")
        public Long getPosition() {
        return this.position;
    }

    @java.lang.SuppressWarnings("all")
        public String getCodeName() {
        return this.codeName;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsSystemDefined() {
        return this.isSystemDefined;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setDescription(final String description) {
        this.description = description;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsCashPayment(final Boolean isCashPayment) {
        this.isCashPayment = isCashPayment;
    }

    @java.lang.SuppressWarnings("all")
        public void setPosition(final Long position) {
        this.position = position;
    }

    @java.lang.SuppressWarnings("all")
        public void setCodeName(final String codeName) {
        this.codeName = codeName;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsSystemDefined(final Boolean isSystemDefined) {
        this.isSystemDefined = isSystemDefined;
    }

    @java.lang.SuppressWarnings("all")
        public PaymentType() {
    }

    @java.lang.SuppressWarnings("all")
        public PaymentType(final String name, final String description, final Boolean isCashPayment, final Long position, final String codeName, final Boolean isSystemDefined) {
        this.name = name;
        this.description = description;
        this.isCashPayment = isCashPayment;
        this.position = position;
        this.codeName = codeName;
        this.isSystemDefined = isSystemDefined;
    }
}
