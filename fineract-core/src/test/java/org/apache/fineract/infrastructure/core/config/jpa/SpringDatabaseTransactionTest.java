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
import static org.springframework.transaction.TransactionDefinition.PROPAGATION_REQUIRED;
import static org.springframework.transaction.TransactionDefinition.PROPAGATION_REQUIRES_NEW;

import java.util.ArrayList;
import java.util.List;
import org.apache.fineract.infrastructure.core.exception.DatabaseTransactionException;
import org.apache.fineract.infrastructure.core.service.DatabaseTransaction;
import org.junit.jupiter.api.Test;
import org.springframework.transaction.CannotCreateTransactionException;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.support.AbstractPlatformTransactionManager;
import org.springframework.transaction.support.DefaultTransactionStatus;

class SpringDatabaseTransactionTest {

    @Test
    void callCommitsRequiredTransactionAndReturnsValue() {
        RecordingTransactionManager manager = new RecordingTransactionManager();
        DatabaseTransaction transactions = new SpringDatabaseTransaction(manager);

        assertThat(transactions.call(() -> 7)).isEqualTo(7);

        assertThat(manager.begins()).containsExactly(new Begin(PROPAGATION_REQUIRED, false));
        assertThat(manager.commitCount()).isEqualTo(1);
        assertThat(manager.rollbackCount()).isZero();
        assertThat(manager.suspendCount()).isZero();
    }

    @Test
    void callReadOnlyStartsReadOnlyTransaction() {
        RecordingTransactionManager manager = new RecordingTransactionManager();
        DatabaseTransaction transactions = new SpringDatabaseTransaction(manager);

        transactions.callReadOnly(() -> null);

        assertThat(manager.begins()).containsExactly(new Begin(PROPAGATION_REQUIRED, true));
        assertThat(manager.commitCount()).isEqualTo(1);
    }

    @Test
    void callJoinsCurrentTransaction() {
        RecordingTransactionManager manager = new RecordingTransactionManager();
        DatabaseTransaction transactions = new SpringDatabaseTransaction(manager);

        String value = transactions.call(() -> transactions.call(() -> "inner"));

        assertThat(value).isEqualTo("inner");
        assertThat(manager.begins()).containsExactly(new Begin(PROPAGATION_REQUIRED, false));
        assertThat(manager.commitCount()).isEqualTo(1);
        assertThat(manager.rollbackCount()).isZero();
        assertThat(manager.suspendCount()).isZero();
    }

    @Test
    void callNewSuspendsCurrentTransactionAndCommitsIndependently() {
        RecordingTransactionManager manager = new RecordingTransactionManager();
        DatabaseTransaction transactions = new SpringDatabaseTransaction(manager);

        String value = transactions.call(() -> {
            String inner = transactions.callNew(() -> "new");
            return inner + "-outer";
        });

        assertThat(value).isEqualTo("new-outer");
        assertThat(manager.begins()).containsExactly(new Begin(PROPAGATION_REQUIRED, false), new Begin(PROPAGATION_REQUIRES_NEW, false));
        assertThat(manager.commitCount()).isEqualTo(2);
        assertThat(manager.rollbackCount()).isZero();
        assertThat(manager.suspendCount()).isEqualTo(1);
    }

    @Test
    void uncheckedExceptionRollsBackAndPropagates() {
        RecordingTransactionManager manager = new RecordingTransactionManager();
        DatabaseTransaction transactions = new SpringDatabaseTransaction(manager);

        assertThatThrownBy(() -> transactions.call(() -> {
            throw new IllegalStateException("work failed");
        })).isInstanceOf(IllegalStateException.class).hasMessage("work failed");

        assertThat(manager.commitCount()).isZero();
        assertThat(manager.rollbackCount()).isEqualTo(1);
    }

    @Test
    void failedCallNewDoesNotRollBackOuterTransactionWhenCaught() {
        RecordingTransactionManager manager = new RecordingTransactionManager();
        DatabaseTransaction transactions = new SpringDatabaseTransaction(manager);

        String value = transactions.call(() -> {
            try {
                return transactions.callNew(() -> {
                    throw new IllegalStateException("inner");
                });
            } catch (IllegalStateException expected) {
                return "kept";
            }
        });

        assertThat(value).isEqualTo("kept");
        assertThat(manager.begins()).containsExactly(new Begin(PROPAGATION_REQUIRED, false), new Begin(PROPAGATION_REQUIRES_NEW, false));
        assertThat(manager.commitCount()).isEqualTo(1);
        assertThat(manager.rollbackCount()).isEqualTo(1);
        assertThat(manager.suspendCount()).isEqualTo(1);
    }

    @Test
    void transactionInfrastructureFailureIsWrapped() {
        RecordingTransactionManager manager = new RecordingTransactionManager();
        manager.failBegin = true;
        DatabaseTransaction transactions = new SpringDatabaseTransaction(manager);

        assertThatThrownBy(() -> transactions.call(() -> "unused")).isInstanceOf(DatabaseTransactionException.class)
                .hasCauseInstanceOf(CannotCreateTransactionException.class);
        assertThat(manager.commitCount()).isZero();
        assertThat(manager.rollbackCount()).isZero();
    }

    private record Begin(int propagationBehavior, boolean readOnly) {
    }

    private static final class RecordingTransactionManager extends AbstractPlatformTransactionManager {

        private final List<Begin> begins = new ArrayList<>();
        private int commitCount;
        private int rollbackCount;
        private int suspendCount;
        private boolean active;
        private boolean failBegin;

        @Override
        protected Object doGetTransaction() {
            return Boolean.valueOf(active);
        }

        @Override
        protected boolean isExistingTransaction(Object transaction) {
            return (Boolean) transaction;
        }

        @Override
        protected void doBegin(Object transaction, TransactionDefinition definition) {
            if (failBegin) {
                throw new CannotCreateTransactionException("down");
            }
            begins.add(new Begin(definition.getPropagationBehavior(), definition.isReadOnly()));
            active = true;
        }

        @Override
        protected void doCommit(DefaultTransactionStatus status) {
            commitCount++;
            active = false;
        }

        @Override
        protected void doRollback(DefaultTransactionStatus status) {
            rollbackCount++;
            active = false;
        }

        @Override
        protected Object doSuspend(Object transaction) {
            suspendCount++;
            boolean suspended = active;
            active = false;
            return suspended;
        }

        @Override
        protected void doResume(Object transaction, Object suspendedResources) {
            active = (Boolean) suspendedResources;
        }

        private List<Begin> begins() {
            return begins;
        }

        private int commitCount() {
            return commitCount;
        }

        private int rollbackCount() {
            return rollbackCount;
        }

        private int suspendCount() {
            return suspendCount;
        }
    }
}
