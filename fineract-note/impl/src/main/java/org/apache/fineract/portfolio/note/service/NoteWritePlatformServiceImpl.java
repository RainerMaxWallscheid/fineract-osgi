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
package org.apache.fineract.portfolio.note.service;

import org.apache.commons.lang3.Strings;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.fineract.portfolio.client.domain.Client;
import org.apache.fineract.portfolio.client.domain.ClientRepository;
import org.apache.fineract.portfolio.client.exception.ClientNotFoundException;
import org.apache.fineract.portfolio.group.domain.GroupRepository;
import org.apache.fineract.portfolio.group.exception.GroupNotFoundException;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanExistencePort;
import org.apache.fineract.portfolio.savings.moduleapi.SavingsAccountExistencePort;
import org.apache.fineract.portfolio.note.data.NoteCreateRequest;
import org.apache.fineract.portfolio.note.data.NoteCreateResponse;
import org.apache.fineract.portfolio.note.data.NoteDeleteRequest;
import org.apache.fineract.portfolio.note.data.NoteDeleteResponse;
import org.apache.fineract.portfolio.note.data.NoteUpdateRequest;
import org.apache.fineract.portfolio.note.data.NoteUpdateResponse;
import org.apache.fineract.portfolio.note.domain.Note;
import org.apache.fineract.portfolio.note.domain.NoteRepository;
import org.apache.fineract.portfolio.note.domain.NoteType;
import org.apache.fineract.portfolio.note.exception.NoteNotFoundException;
import org.apache.fineract.portfolio.note.exception.NoteResourceNotSupportedException;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.stereotype.Service;

@Service
@ConditionalOnMissingBean(value = NoteWritePlatformService.class, ignored = NoteWritePlatformServiceImpl.class)
public class NoteWritePlatformServiceImpl implements NoteWritePlatformService {

    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(NoteWritePlatformServiceImpl.class);

    private final NoteRepository noteRepository;
    private final ClientRepository clientRepository;
    private final GroupRepository groupRepository;
    private final LoanExistencePort loanExistencePort;
    private final SavingsAccountExistencePort savingsAccountExistencePort;
    private final ObjectProvider<ShareAccountNoteSupport> shareAccountNoteSupport;

    public NoteWritePlatformServiceImpl(final NoteRepository noteRepository, final ClientRepository clientRepository,
            final GroupRepository groupRepository, final LoanExistencePort loanExistencePort,
            final SavingsAccountExistencePort savingsAccountExistencePort, final ObjectProvider<ShareAccountNoteSupport> shareAccountNoteSupport) {
        this.noteRepository = noteRepository;
        this.clientRepository = clientRepository;
        this.groupRepository = groupRepository;
        this.loanExistencePort = loanExistencePort;
        this.savingsAccountExistencePort = savingsAccountExistencePort;
        this.shareAccountNoteSupport = shareAccountNoteSupport;
    }

    @Override
    public NoteCreateResponse createNote(final NoteCreateRequest request) {
        Note note;
        Long officeId;
        switch (request.getType()) {
            case CLIENT -> {
                final Client client = this.clientRepository.findById(request.getResourceId())
                        .orElseThrow(() -> new ClientNotFoundException(request.getResourceId()));
                note = noteRepository.saveAndFlush(Note.clientNote(client, request.getNote()));
                officeId = client.officeId();
            }
            case GROUP -> {
                final var group = groupRepository.findById(request.getResourceId())
                        .orElseThrow(() -> new GroupNotFoundException(request.getResourceId()));
                note = noteRepository.saveAndFlush(Note.groupNote(group, request.getNote()));
                officeId = group.officeId();
            }
            case LOAN -> {
                final var ref = loanExistencePort.require(request.getResourceId());
                note = noteRepository.saveAndFlush(Note.loanNote(ref.loanId(), ref.clientId(), request.getNote()));
                officeId = ref.officeId();
            }
            case LOAN_TRANSACTION -> {
                final var ref = loanExistencePort.requireTransaction(request.getResourceId());
                note = noteRepository.saveAndFlush(Note.loanTransactionNote(ref.loanId(), ref.loanTransactionId(), ref.clientId(),
                        request.getNote()));
                officeId = ref.officeId();
            }
            case SAVING_ACCOUNT -> {
                final var ref = savingsAccountExistencePort.require(request.getResourceId());
                note = noteRepository.saveAndFlush(Note.savingNote(ref.savingsAccountId(), ref.clientId(), request.getNote()));
                officeId = ref.officeId();
            }
            case SAVINGS_TRANSACTION -> {
                final var ref = savingsAccountExistencePort.requireTransaction(request.getResourceId());
                note = noteRepository.saveAndFlush(Note.savingsTransactionNote(ref.savingsAccountId(), ref.savingsTransactionId(),
                        ref.clientId(), request.getNote()));
                officeId = ref.officeId();
            }
            case SHARE_ACCOUNT -> {
                final ShareAccountNoteSupport support = shareAccountNoteSupport.getIfAvailable();
                if (support == null) {
                    throw new NoteResourceNotSupportedException(request.getType().getApiUrl());
                }
                final var ref = support.require(request.getResourceId());
                note = noteRepository.saveAndFlush(Note.shareNote(ref.shareAccountId(), ref.clientId(), request.getNote()));
                officeId = ref.officeId();
            }
            default -> throw new NoteResourceNotSupportedException(request.getType().getApiUrl());
        }
        return NoteCreateResponse.builder().entityId(note.getId()).resourceId(note.getId()).officeId(officeId).build();
    }

    @Override
    public NoteUpdateResponse updateNote(final NoteUpdateRequest request) {
        final var result = getNote(request.getType(), request.getResourceId(), request.getId());
        final var note = result.getLeft();
        final var response = NoteUpdateResponse.builder().officeId(result.getRight()).resourceId(request.getResourceId());
        if (!Strings.CI.equals(note.getNote(), request.getNote())) {
            response.changes(note.update(request.getNote()));
            noteRepository.saveAndFlush(note);
        }
        return response.build();
    }

    @Override
    public NoteDeleteResponse deleteNote(final NoteDeleteRequest request) {
        var note = getNote(request.getType(), request.getResourceId(), request.getId());
        noteRepository.delete(note.getLeft());
        return NoteDeleteResponse.builder().resourceId(request.getId()).build();
    }

    private Pair<Note, Long> getNote(NoteType type, Long resourceId, Long noteId) {
        Note note = null;
        Long officeId = null;
        switch (type) {
            case CLIENT -> {
                final var client = clientRepository.findById(resourceId).orElseThrow(() -> new ClientNotFoundException(resourceId));
                note = noteRepository.findByClientIdAndId(client.getId(), noteId);
                officeId = client.officeId();
            }
            case GROUP -> {
                final var group = groupRepository.findById(resourceId).orElseThrow(() -> new GroupNotFoundException(resourceId));
                note = noteRepository.findByGroupIdAndId(group.getId(), noteId);
                officeId = group.officeId();
            }
            case LOAN -> {
                final var ref = loanExistencePort.require(resourceId);
                note = noteRepository.findByLoanIdAndId(ref.loanId(), noteId);
                officeId = ref.officeId();
            }
            case LOAN_TRANSACTION -> {
                final var ref = loanExistencePort.requireTransaction(resourceId);
                note = noteRepository.findByLoanTransactionIdAndId(ref.loanTransactionId(), noteId);
                officeId = ref.officeId();
            }
            case SAVING_ACCOUNT -> {
                final var ref = savingsAccountExistencePort.require(resourceId);
                note = noteRepository.findBySavingsAccountIdAndId(ref.savingsAccountId(), noteId);
                officeId = ref.officeId();
            }
            case SAVINGS_TRANSACTION -> {
                final var ref = savingsAccountExistencePort.requireTransaction(resourceId);
                note = noteRepository.findBySavingsTransactionIdAndId(ref.savingsTransactionId(), noteId);
                officeId = ref.officeId();
            }
            case SHARE_ACCOUNT -> {
                final ShareAccountNoteSupport support = shareAccountNoteSupport.getIfAvailable();
                if (support == null) {
                    break;
                }
                final var ref = support.require(resourceId);
                note = noteRepository.findByShareAccountIdAndId(ref.shareAccountId(), noteId);
                officeId = ref.officeId();
            }
            default -> log.error("Not yet implemented: {}", type);
        }
        if (note == null) {
            throw new NoteNotFoundException(noteId, resourceId, type.name().toLowerCase());
        }
        return Pair.of(note, officeId);
    }
}
