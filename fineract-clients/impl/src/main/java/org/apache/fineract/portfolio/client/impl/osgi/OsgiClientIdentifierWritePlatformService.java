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
package org.apache.fineract.portfolio.client.impl.osgi;

import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;
import org.apache.fineract.portfolio.client.service.ClientIdentifierWritePlatformService;

/**
 * Empty client-identifier write port for Equinox without Spring/JPA.
 * Published by {@code OSGI-INF/clients.xml} (ADR-022 B6).
 */
public final class OsgiClientIdentifierWritePlatformService implements ClientIdentifierWritePlatformService {

    @Override
    public CommandProcessingResult addClientIdentifier(final Long clientId, final JsonCommand command) {
        return CommandProcessingResult.empty();
    }

    @Override
    public CommandProcessingResult updateClientIdentifier(final Long clientId, final Long clientIdentifierId, final JsonCommand command) {
        return CommandProcessingResult.empty();
    }

    @Override
    public CommandProcessingResult deleteClientIdentifier(final Long clientId, final Long clientIdentifierId, final Long commandId) {
        return CommandProcessingResult.empty();
    }
}
