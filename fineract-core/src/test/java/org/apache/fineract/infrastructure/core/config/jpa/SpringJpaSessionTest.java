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
package org.apache.fineract.infrastructure.core.config.jpa;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import org.apache.fineract.infrastructure.core.exception.JpaSessionException;
import org.apache.fineract.infrastructure.core.service.JpaSession;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.data.auditing.AuditingHandler;
import org.springframework.data.domain.Persistable;
import org.springframework.orm.jpa.EntityManagerHolder;
import org.springframework.transaction.support.TransactionSynchronizationManager;

class SpringJpaSessionTest {

    private final EntityManagerFactory entityManagerFactory = mock(EntityManagerFactory.class);
    private final EntityManager entityManager = mock(EntityManager.class);
    private final AuditingHandler auditingHandler = mock(AuditingHandler.class);
    private final JpaSession session = new SpringJpaSession(entityManagerFactory, handlerProvider(auditingHandler));

    @AfterEach
    void clearTransactionState() {
        if (TransactionSynchronizationManager.hasResource(entityManagerFactory)) {
            TransactionSynchronizationManager.unbindResource(entityManagerFactory);
        }
    }

    @Test
    void currentReturnsTheEntityManagerBoundToTheTransaction() {
        bind();

        assertThat(session.current()).isSameAs(entityManager);
    }

    @Test
    void currentFailsWhenNoSessionIsBound() {
        assertThatThrownBy(session::current).isInstanceOf(JpaSessionException.class);
    }

    @Test
    void savePersistsANewEntityAfterMarkingItCreated() {
        bind();
        Probe entity = new Probe(true);
        when(auditingHandler.markCreated(entity)).thenReturn(entity);

        assertThat(session.save(entity)).isSameAs(entity);

        verify(auditingHandler).markCreated(entity);
        verify(entityManager).persist(entity);
        verify(entityManager, never()).merge(entity);
    }

    @Test
    void saveMergesAnExistingEntityAfterMarkingItModified() {
        bind();
        Probe entity = new Probe(false);
        when(auditingHandler.markModified(entity)).thenReturn(entity);
        when(entityManager.merge(entity)).thenReturn(entity);

        assertThat(session.save(entity)).isSameAs(entity);

        verify(auditingHandler).markModified(entity);
        verify(entityManager).merge(entity);
        verify(entityManager, never()).persist(entity);
    }

    @Test
    void saveAndFlushFlushesAfterSave() {
        bind();
        Probe entity = new Probe(true);
        when(auditingHandler.markCreated(entity)).thenReturn(entity);

        assertThat(session.saveAndFlush(entity)).isSameAs(entity);

        verify(entityManager).persist(entity);
        verify(entityManager).flush();
    }

    private void bind() {
        TransactionSynchronizationManager.bindResource(entityManagerFactory, new EntityManagerHolder(entityManager));
    }

    @SuppressWarnings("unchecked")
    private static ObjectProvider<AuditingHandler> handlerProvider(AuditingHandler handler) {
        ObjectProvider<AuditingHandler> provider = mock(ObjectProvider.class);
        when(provider.getObject()).thenReturn(handler);
        return provider;
    }

    private static final class Probe implements Persistable<Long> {

        private final boolean isNew;

        private Probe(boolean isNew) {
            this.isNew = isNew;
        }

        @Override
        public Long getId() {
            return isNew ? null : 1L;
        }

        @Override
        public boolean isNew() {
            return isNew;
        }
    }
}
