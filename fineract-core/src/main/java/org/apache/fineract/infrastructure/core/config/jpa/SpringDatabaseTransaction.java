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

import static org.springframework.transaction.TransactionDefinition.PROPAGATION_REQUIRED;
import static org.springframework.transaction.TransactionDefinition.PROPAGATION_REQUIRES_NEW;

import java.util.Objects;
import org.apache.fineract.infrastructure.core.exception.DatabaseTransactionException;
import org.apache.fineract.infrastructure.core.service.DatabaseTransaction;
import org.apache.fineract.infrastructure.core.service.DatabaseWork;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionException;
import org.springframework.transaction.support.TransactionTemplate;

/**
 * The only {@link DatabaseTransaction}. The manager must be the JPA transaction manager so JDBC and JPA share its
 * connection. Templates are configured once and then left unchanged.
 */
public class SpringDatabaseTransaction implements DatabaseTransaction {

    private final TransactionTemplate required;
    private final TransactionTemplate requiredReadOnly;
    private final TransactionTemplate requiresNew;

    public SpringDatabaseTransaction(PlatformTransactionManager transactionManager) {
        Objects.requireNonNull(transactionManager, "transactionManager");
        this.required = template(transactionManager, PROPAGATION_REQUIRED, false);
        this.requiredReadOnly = template(transactionManager, PROPAGATION_REQUIRED, true);
        this.requiresNew = template(transactionManager, PROPAGATION_REQUIRES_NEW, false);
    }

    @Override
    public <T> T call(DatabaseWork<T> work) {
        return execute(required, work);
    }

    @Override
    public <T> T callReadOnly(DatabaseWork<T> work) {
        return execute(requiredReadOnly, work);
    }

    @Override
    public <T> T callNew(DatabaseWork<T> work) {
        return execute(requiresNew, work);
    }

    private static TransactionTemplate template(PlatformTransactionManager transactionManager, int propagation, boolean readOnly) {
        TransactionTemplate transactionTemplate = new TransactionTemplate(transactionManager);
        transactionTemplate.setPropagationBehavior(propagation);
        transactionTemplate.setReadOnly(readOnly);
        return transactionTemplate;
    }

    private static <T> T execute(TransactionTemplate transactionTemplate, DatabaseWork<T> work) {
        Objects.requireNonNull(work, "work");
        try {
            return transactionTemplate.execute(status -> work.execute());
        } catch (TransactionException ex) {
            throw new DatabaseTransactionException(ex.getMessage() == null ? "Transaction failed" : ex.getMessage(), ex);
        }
    }
}
