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

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import java.util.Objects;
import org.apache.fineract.infrastructure.core.exception.JpaSessionException;
import org.apache.fineract.infrastructure.core.service.JpaSession;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.data.auditing.AuditingHandler;
import org.springframework.data.domain.Persistable;
import org.springframework.orm.jpa.EntityManagerFactoryUtils;

/**
 * The only {@link JpaSession}. The factory must be the {@code jpa-pu} factory. The handler is the prototype
 * {@code jpaAuditingHandler}, taken fresh on each save because it stores the date-time provider on itself.
 */
public class SpringJpaSession implements JpaSession {

    private final EntityManagerFactory entityManagerFactory;
    private final ObjectProvider<AuditingHandler> auditingHandler;

    public SpringJpaSession(EntityManagerFactory entityManagerFactory, ObjectProvider<AuditingHandler> auditingHandler) {
        this.entityManagerFactory = Objects.requireNonNull(entityManagerFactory, "entityManagerFactory");
        this.auditingHandler = Objects.requireNonNull(auditingHandler, "auditingHandler");
    }

    @Override
    public EntityManager current() {
        EntityManager entityManager = EntityManagerFactoryUtils.getTransactionalEntityManager(entityManagerFactory);
        if (entityManager == null) {
            throw new JpaSessionException("No JPA session is bound to the current transaction");
        }
        return entityManager;
    }

    @Override
    public <T> T save(T entity) {
        Objects.requireNonNull(entity, "entity");
        EntityManager entityManager = current();
        boolean isNew = isNew(entity);
        AuditingHandler handler = auditingHandler.getObject();
        T audited = isNew ? handler.markCreated(entity) : handler.markModified(entity);
        if (isNew) {
            entityManager.persist(audited);
            return audited;
        }
        return entityManager.merge(audited);
    }

    @Override
    public <T> T saveAndFlush(T entity) {
        T saved = save(entity);
        current().flush();
        return saved;
    }

    private static boolean isNew(Object entity) {
        if (entity instanceof Persistable<?> persistable) {
            return persistable.isNew();
        }
        return true;
    }
}
