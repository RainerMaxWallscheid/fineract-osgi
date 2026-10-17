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

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import org.apache.fineract.infrastructure.core.service.JpaSession;

public class NoteRepositoryImpl implements NoteRepository {

    private final JpaSession jpaSession;

    public NoteRepositoryImpl(JpaSession jpaSession) {
        this.jpaSession = jpaSession;
    }

    @Override
    public Note save(Note note) {
        return jpaSession.save(note);
    }

    @Override
    public Note saveAndFlush(Note note) {
        return jpaSession.saveAndFlush(note);
    }

    @Override
    public void delete(Note note) {
        Objects.requireNonNull(note, "note");
        if (note.isNew()) {
            return;
        }
        EntityManager entityManager = jpaSession.current();
        entityManager.remove(entityManager.contains(note) ? note : entityManager.merge(note));
    }

    @Override
    public void deleteAllInBatch(Iterable<Note> notes) {
        Objects.requireNonNull(notes, "notes");
        List<Long> ids = new ArrayList<>();
        for (Note note : notes) {
            if (note != null && note.getId() != null) {
                ids.add(note.getId());
            }
        }
        if (ids.isEmpty()) {
            return;
        }
        bulk("delete from Note n where n.id in :ids", "ids", ids);
    }

    @Override
    public List<Note> findByLoanId(Long loanId) {
        return list("select n from Note n where n.loanId = :loanId", "loanId", loanId);
    }

    @Override
    public List<Note> findByClientId(Long clientId) {
        return list("select n from Note n where n.clientId = :clientId", "clientId", clientId);
    }

    @Override
    public List<Note> findByGroupId(Long groupId) {
        return list("select n from Note n where n.groupId = :groupId", "groupId", groupId);
    }

    @Override
    public Note findByLoanIdAndId(Long loanId, Long id) {
        return one("select n from Note n where n.loanId = :loanId and n.id = :id", "loanId", loanId, id);
    }

    @Override
    public Note findByClientIdAndId(Long clientId, Long id) {
        return one("select n from Note n where n.clientId = :clientId and n.id = :id", "clientId", clientId, id);
    }

    @Override
    public Note findByGroupIdAndId(Long groupId, Long id) {
        return one("select n from Note n where n.groupId = :groupId and n.id = :id", "groupId", groupId, id);
    }

    @Override
    public Note findByLoanTransactionIdAndId(Long loanTransactionId, Long id) {
        return one("select n from Note n where n.loanTransactionId = :loanTransactionId and n.id = :id", "loanTransactionId",
                loanTransactionId, id);
    }

    @Override
    public Note findBySavingsAccountIdAndId(Long savingsAccountId, Long id) {
        return one("select n from Note n where n.savingsAccountId = :savingsAccountId and n.id = :id", "savingsAccountId",
                savingsAccountId, id);
    }

    @Override
    public Note findBySavingsTransactionIdAndId(Long savingsTransactionId, Long id) {
        return one("select n from Note n where n.savingsTransactionId = :savingsTransactionId and n.id = :id", "savingsTransactionId",
                savingsTransactionId, id);
    }

    @Override
    public Note findByShareAccountIdAndId(Long shareAccountId, Long id) {
        return one("select n from Note n where n.shareAccountId = :shareAccountId and n.id = :id", "shareAccountId", shareAccountId, id);
    }

    @Override
    public void deleteAllBySavingsAccountId(Long savingsAccountId) {
        bulk("delete from Note n where n.savingsAccountId = :savingsAccountId", "savingsAccountId", savingsAccountId);
    }

    private List<Note> list(String jpql, String name, Long value) {
        TypedQuery<Note> query = jpaSession.current().createQuery(jpql, Note.class);
        query.setParameter(name, value);
        return query.getResultList();
    }

    private Note one(String jpql, String name, Long value, Long id) {
        TypedQuery<Note> query = jpaSession.current().createQuery(jpql, Note.class);
        query.setParameter(name, value);
        query.setParameter("id", id);
        try {
            return query.getSingleResult();
        } catch (NoResultException ignore) {
            return null;
        }
    }

    private void bulk(String jpql, String name, Object value) {
        jpaSession.current().createQuery(jpql).setParameter(name, value).executeUpdate();
    }
}
