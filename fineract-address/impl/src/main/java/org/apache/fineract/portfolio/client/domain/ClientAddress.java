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
package org.apache.fineract.portfolio.client.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import org.apache.fineract.infrastructure.codes.moduleapi.CodeValueAssociation;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.portfolio.address.domain.Address;
import org.apache.fineract.portfolio.client.moduleapi.ClientAssociation;

@Entity
@Table(name = "m_client_address")
public class ClientAddress extends AbstractPersistableCustom<Long> {

    /**
     * Client id (no JPA association to leftover Client — ADR-021).
     */
    @Column(name = "client_id")
    private Long clientId;

    @ManyToOne
    private Address address;

    /**
     * Code-value id (no JPA association to leftover CodeValue — ADR-021).
     */
    @Column(name = "address_type_id")
    private Long addressTypeId;

    @Column(name = "is_active")
    private boolean isActive;

    private ClientAddress(final Object client, final Address address, final Object addressType, final boolean isActive) {
        this.clientId = ClientAssociation.id(client);
        this.address = address;
        this.addressTypeId = CodeValueAssociation.id(addressType);
        this.isActive = isActive;

    }

    public ClientAddress() {

    }

    public static ClientAddress fromJson(final boolean isActive, final Object client, final Address address, final Object address_type) {

        return new ClientAddress(client, address, address_type, isActive);
    }

    public Long getClientId() {
        return this.clientId;
    }

    public Address getAddress() {
        return this.address;
    }

    public Long getAddressTypeId() {
        return this.addressTypeId;
    }

    public void setAddressType(final Object addressType) {
        this.addressTypeId = CodeValueAssociation.id(addressType);
    }

    public boolean isIs_active() {
        return this.isActive;
    }

    public void setClient(final Object client) {
        this.clientId = ClientAssociation.id(client);
    }

    public void setAddress(final Address address) {
        this.address = address;
    }

    public void setIs_active(final boolean isActive) {
        this.isActive = isActive;
    }

}
