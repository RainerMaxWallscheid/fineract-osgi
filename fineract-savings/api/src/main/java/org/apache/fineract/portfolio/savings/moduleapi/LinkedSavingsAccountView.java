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
package org.apache.fineract.portfolio.savings.moduleapi;

/**
 * ID-only projection for loan-linked savings validation (ADR-021).
 */
public final class LinkedSavingsAccountView {

    private final Long id;
    private final Long clientId;
    private final boolean active;

    public LinkedSavingsAccountView(final Long id, final Long clientId, final boolean active) {
        this.id = id;
        this.clientId = clientId;
        this.active = active;
    }

    public Long getId() {
        return this.id;
    }

    public Long getClientId() {
        return this.clientId;
    }

    public boolean isActive() {
        return this.active;
    }
}
