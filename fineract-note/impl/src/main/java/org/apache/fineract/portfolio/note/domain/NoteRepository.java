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

import java.util.List;

/**
 * Note persistence used by the write service. Not a Spring Data repository.
 */
public interface NoteRepository {

    Note save(Note note);

    Note saveAndFlush(Note note);

    void delete(Note note);

    void deleteAllInBatch(Iterable<Note> notes);

    List<Note> findByLoanId(Long loanId);

    List<Note> findByClientId(Long clientId);

    List<Note> findByGroupId(Long groupId);

    Note findByLoanIdAndId(Long loanId, Long id);

    Note findByClientIdAndId(Long clientId, Long id);

    Note findByGroupIdAndId(Long groupId, Long id);

    Note findByLoanTransactionIdAndId(Long loanTransactionId, Long id);

    Note findBySavingsAccountIdAndId(Long savingsAccountId, Long id);

    Note findBySavingsTransactionIdAndId(Long savingsTransactionId, Long id);

    Note findByShareAccountIdAndId(Long shareAccountId, Long id);

    void deleteAllBySavingsAccountId(Long savingsAccountId);
}
