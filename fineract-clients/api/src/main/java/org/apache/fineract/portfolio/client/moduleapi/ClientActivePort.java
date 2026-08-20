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
package org.apache.fineract.portfolio.client.moduleapi;

import java.time.LocalDate;
import java.util.List;
import org.apache.fineract.infrastructure.core.domain.ExternalId;

/**
 * ID-only client activity / transfer-date probes (ADR-021). Foreign BCs must
 * not depend on leftover {@code Client} graphs.
 */
public interface ClientActivePort {

    boolean isActive(Long clientId);

    boolean exists(Long clientId);

    boolean isActivatedAfter(Long clientId, LocalDate date);

    LocalDate activationDate(Long clientId);

    LocalDate officeJoiningDate(Long clientId);

    Long officeId(Long clientId);

    String displayName(Long clientId);

    String accountNumber(Long clientId);

    ExternalId externalId(Long clientId);

    List<Long> groupIds(Long clientId);

    /**
     * Client id from a persistable client instance (Object-typed, ADR-021).
     */
    Long id(Object client);
}
