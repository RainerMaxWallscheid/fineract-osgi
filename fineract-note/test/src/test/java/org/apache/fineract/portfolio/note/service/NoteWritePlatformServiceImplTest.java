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

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.Map;
import org.apache.fineract.portfolio.client.domain.ClientRepository;
import org.apache.fineract.portfolio.group.domain.GroupRepository;
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
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.ObjectProvider;

@ExtendWith(MockitoExtension.class)
class NoteWritePlatformServiceImplTest {

    @Mock
    private NoteRepository noteRepository;
    @Mock
    private ClientRepository clientRepository;
    @Mock
    private GroupRepository groupRepository;
    @Mock
    private LoanExistencePort loanExistencePort;
    @Mock
    private SavingsAccountExistencePort savingsAccountExistencePort;
    @Mock
    private ObjectProvider<ShareAccountNoteSupport> shareAccountNoteSupport;
    @Mock
    private ShareAccountNoteSupport shareSupport;
    @Mock
    private Note note;

    private NoteWritePlatformServiceImpl subject;

    @BeforeEach
    void setUp() {
        subject = new NoteWritePlatformServiceImpl(noteRepository, clientRepository, groupRepository, loanExistencePort,
                savingsAccountExistencePort, shareAccountNoteSupport);
    }

    @Test
    void createNoteShouldSupportShareAccount() {
        NoteCreateRequest request = NoteCreateRequest.builder().resourceId(10L).type(NoteType.SHARE_ACCOUNT).note("share note").build();
        when(shareAccountNoteSupport.getIfAvailable()).thenReturn(shareSupport);
        when(shareSupport.require(10L)).thenReturn(new ShareAccountNoteSupport.ShareAccountNoteRef(10L, 5L, 7L));
        when(noteRepository.saveAndFlush(any(Note.class))).thenReturn(note);
        when(note.getId()).thenReturn(101L);

        NoteCreateResponse response = subject.createNote(request);

        assertEquals(101L, response.getResourceId());
        assertEquals(7L, response.getOfficeId());
        verify(noteRepository).saveAndFlush(any(Note.class));
    }

    @Test
    void createNoteShouldSupportSavingsTransaction() {
        NoteCreateRequest request = NoteCreateRequest.builder().resourceId(22L).type(NoteType.SAVINGS_TRANSACTION)
                .note("savings transaction note").build();
        when(savingsAccountExistencePort.requireTransaction(22L))
                .thenReturn(new SavingsAccountExistencePort.SavingsTransactionNoteRef(11L, 22L, 5L, 8L));
        when(noteRepository.saveAndFlush(any(Note.class))).thenReturn(note);
        when(note.getId()).thenReturn(202L);

        NoteCreateResponse response = subject.createNote(request);

        assertEquals(202L, response.getResourceId());
        assertEquals(8L, response.getOfficeId());
        verify(noteRepository).saveAndFlush(any(Note.class));
    }

    @Test
    void updateNoteShouldSupportShareAccount() {
        NoteUpdateRequest request = NoteUpdateRequest.builder().id(9L).resourceId(10L).type(NoteType.SHARE_ACCOUNT).note("updated").build();
        when(shareAccountNoteSupport.getIfAvailable()).thenReturn(shareSupport);
        when(shareSupport.require(10L)).thenReturn(new ShareAccountNoteSupport.ShareAccountNoteRef(10L, 5L, 7L));
        when(noteRepository.findByShareAccountIdAndId(10L, 9L)).thenReturn(note);
        when(note.getNote()).thenReturn("old");
        when(note.update("updated")).thenReturn(Map.of("note", "updated"));

        NoteUpdateResponse response = subject.updateNote(request);

        assertEquals(10L, response.getResourceId());
        assertEquals(7L, response.getOfficeId());
        assertEquals(Map.of("note", "updated"), response.getChanges());
        verify(noteRepository).saveAndFlush(note);
    }

    @Test
    void deleteNoteShouldSupportSavingsTransaction() {
        NoteDeleteRequest request = NoteDeleteRequest.builder().id(3L).resourceId(22L).type(NoteType.SAVINGS_TRANSACTION).build();
        when(savingsAccountExistencePort.requireTransaction(22L))
                .thenReturn(new SavingsAccountExistencePort.SavingsTransactionNoteRef(11L, 22L, 5L, 8L));
        when(noteRepository.findBySavingsTransactionIdAndId(22L, 3L)).thenReturn(note);

        NoteDeleteResponse response = subject.deleteNote(request);

        assertEquals(3L, response.getResourceId());
        verify(noteRepository).delete(note);
    }
}
