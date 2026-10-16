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
package org.apache.fineract.portfolio.note.domain;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import java.util.List;
import org.apache.fineract.infrastructure.core.service.JpaSession;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

class NoteRepositoryImplTest {

    private final JpaSession jpaSession = mock(JpaSession.class);
    private final EntityManager entityManager = mock(EntityManager.class);
    private NoteRepositoryImpl repository;

    @BeforeEach
    void setUp() {
        when(jpaSession.current()).thenReturn(entityManager);
        repository = new NoteRepositoryImpl(jpaSession);
    }

    @Test
    void saveAndFlushDelegatesToTheSession() {
        Note note = mock(Note.class);
        when(jpaSession.saveAndFlush(note)).thenReturn(note);

        assertThat(repository.saveAndFlush(note)).isSameAs(note);
    }

    @Test
    void findByClientIdAndIdReturnsNullWhenNothingMatches() {
        @SuppressWarnings("unchecked")
        TypedQuery<Note> query = mock(TypedQuery.class);
        when(entityManager.createQuery("select n from Note n where n.clientId = :clientId and n.id = :id", Note.class)).thenReturn(query);
        when(query.setParameter(any(String.class), any())).thenReturn(query);
        when(query.getSingleResult()).thenThrow(new NoResultException());

        assertThat(repository.findByClientIdAndId(5L, 9L)).isNull();

        verify(query).setParameter("clientId", 5L);
        verify(query).setParameter("id", 9L);
    }

    @Test
    void deleteAllInBatchSkipsAnEmptyIterable() {
        repository.deleteAllInBatch(List.of());

        verify(jpaSession, never()).current();
    }

    @Test
    void deleteAllInBatchDeletesById() {
        Note first = mock(Note.class);
        Note second = mock(Note.class);
        when(first.getId()).thenReturn(3L);
        when(second.getId()).thenReturn(4L);
        Query update = mock(Query.class);
        when(entityManager.createQuery("delete from Note n where n.id in :ids")).thenReturn(update);
        when(update.setParameter(any(String.class), any())).thenReturn(update);

        repository.deleteAllInBatch(List.of(first, second));

        @SuppressWarnings("unchecked")
        ArgumentCaptor<List<Long>> ids = ArgumentCaptor.forClass(List.class);
        verify(update).setParameter(eq("ids"), ids.capture());
        assertThat(ids.getValue()).containsExactly(3L, 4L);
        verify(update).executeUpdate();
    }

    @Test
    void deleteSkipsANewNote() {
        Note note = mock(Note.class);
        when(note.isNew()).thenReturn(true);

        repository.delete(note);

        verify(jpaSession, never()).current();
    }

    @Test
    void deleteAllBySavingsAccountIdRunsBulkDelete() {
        Query update = mock(Query.class);
        when(entityManager.createQuery("delete from Note n where n.savingsAccountId = :savingsAccountId")).thenReturn(update);
        when(update.setParameter(any(String.class), any())).thenReturn(update);

        repository.deleteAllBySavingsAccountId(8L);

        verify(update).setParameter("savingsAccountId", 8L);
        verify(update).executeUpdate();
    }
}
