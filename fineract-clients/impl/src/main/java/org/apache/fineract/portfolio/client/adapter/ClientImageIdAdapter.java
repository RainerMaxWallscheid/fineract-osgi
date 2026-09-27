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
package org.apache.fineract.portfolio.client.adapter;

import static java.util.Objects.nonNull;
import java.util.Optional;
import org.apache.fineract.infrastructure.documentmanagement.adapter.EntityImageIdAdapter;
import org.apache.fineract.portfolio.client.domain.Client;
import org.apache.fineract.portfolio.client.domain.ClientRepository;
import org.apache.fineract.portfolio.client.exception.ClientNotFoundException;
import org.apache.fineract.portfolio.client.moduleapi.ClientActivePort;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@Deprecated
class ClientImageIdAdapter implements EntityImageIdAdapter {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(ClientImageIdAdapter.class);
    private static final String ENTITY_TYPE = "clients";
    private final ClientRepository repository;
    private final ClientActivePort clientActivePort;

    @Override
    public boolean accept(String entityType) {
        return ENTITY_TYPE.equalsIgnoreCase(entityType);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<ImageIdResult> get(Long entityId) {
        if (entityId == null) {
            throw new IllegalArgumentException("The given id must not be null!");
        }
        final Object client;
        try {
            // persistableById throws when missing; image reads historically return empty.
            client = this.clientActivePort.persistableById(entityId);
        } catch (final ClientNotFoundException ex) {
            return Optional.empty();
        }
        if (!(client instanceof Client persisted) || !nonNull(persisted.getImageId())) {
            return Optional.empty();
        }
        return Optional.of(ImageIdResult.builder().id(persisted.getImageId()).displayName(persisted.getDisplayName()).build());
    }

    @Override
    @Transactional
    public Optional<ImageIdResult> set(Long entityId, Long imageId) {
        final var result = get(entityId);
        if (imageId == null) {
            repository.removeImageId(entityId);
        } else {
            repository.updateByIdAndImageId(entityId, imageId);
        }
        return result;
    }

    @java.lang.SuppressWarnings("all")
        public ClientImageIdAdapter(final ClientRepository repository, final ClientActivePort clientActivePort) {
        this.repository = repository;
        this.clientActivePort = clientActivePort;
    }
}
