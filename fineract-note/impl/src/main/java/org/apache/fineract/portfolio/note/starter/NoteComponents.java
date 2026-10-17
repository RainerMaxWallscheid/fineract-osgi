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
package org.apache.fineract.portfolio.note.starter;

import org.apache.fineract.command.core.CommandDispatcher;
import org.apache.fineract.infrastructure.core.service.DatabaseTransaction;
import org.apache.fineract.infrastructure.core.service.JdbcDatabase;
import org.apache.fineract.infrastructure.core.service.JpaSession;
import org.apache.fineract.portfolio.client.moduleapi.ClientActivePort;
import org.apache.fineract.portfolio.group.moduleapi.GroupActivePort;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanExistencePort;
import org.apache.fineract.portfolio.note.api.NotesApiResource;
import org.apache.fineract.portfolio.note.data.NoteCreateRequest;
import org.apache.fineract.portfolio.note.domain.NoteRepository;
import org.apache.fineract.portfolio.note.domain.NoteRepositoryImpl;
import org.apache.fineract.portfolio.note.handler.NoteCreateCommandHandler;
import org.apache.fineract.portfolio.note.handler.NoteDeleteCommandHandler;
import org.apache.fineract.portfolio.note.handler.NoteUpdateCommandHandler;
import org.apache.fineract.portfolio.note.impl.osgi.NoteOsgiServiceRegistrar;
import org.apache.fineract.portfolio.note.listener.NoteListener;
import org.apache.fineract.portfolio.note.service.NoteReadPlatformService;
import org.apache.fineract.portfolio.note.service.NoteReadPlatformServiceImpl;
import org.apache.fineract.portfolio.note.service.NoteWritePlatformService;
import org.apache.fineract.portfolio.note.service.NoteWritePlatformServiceImpl;
import org.apache.fineract.portfolio.note.service.ShareAccountNoteSupport;
import org.apache.fineract.portfolio.savings.moduleapi.SavingsAccountExistencePort;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.EventListener;

/**
 * Boot composition for notes. Component classes are not Spring stereotypes.
 * Jersey, the command-handler list, Resilience4j {@code @Retry}, and application
 * events still require beans while Equinox is off. The empty catalog in
 * {@code OSGI-INF/note.xml} stays the Equinox stand-in and is not this class.
 */
@Configuration
public class NoteComponents {

    @Bean
    @ConditionalOnMissingBean(NoteRepository.class)
    public NoteRepository noteRepository(JpaSession jpaSession) {
        return new NoteRepositoryImpl(jpaSession);
    }

    @Bean
    @ConditionalOnMissingBean(NoteWritePlatformService.class)
    public NoteWritePlatformService noteWritePlatformService(NoteRepository noteRepository, ClientActivePort clientActivePort,
            GroupActivePort groupActivePort, LoanExistencePort loanExistencePort,
            SavingsAccountExistencePort savingsAccountExistencePort, ObjectProvider<ShareAccountNoteSupport> shareAccountNoteSupport) {
        return new NoteWritePlatformServiceImpl(noteRepository, clientActivePort, groupActivePort, loanExistencePort,
                savingsAccountExistencePort, shareAccountNoteSupport.getIfAvailable());
    }

    @Bean
    public NoteReadPlatformService noteReadPlatformService(JdbcDatabase jdbcDatabase, DatabaseTransaction databaseTransaction) {
        return new NoteReadPlatformServiceImpl(jdbcDatabase, databaseTransaction);
    }

    @Bean
    public NoteCreateCommandHandler noteCreateCommandHandler(NoteWritePlatformService noteWritePlatformService,
            DatabaseTransaction databaseTransaction) {
        return new NoteCreateCommandHandler(noteWritePlatformService, databaseTransaction);
    }

    @Bean
    public NoteUpdateCommandHandler noteUpdateCommandHandler(NoteWritePlatformService noteWritePlatformService,
            DatabaseTransaction databaseTransaction) {
        return new NoteUpdateCommandHandler(noteWritePlatformService, databaseTransaction);
    }

    @Bean
    public NoteDeleteCommandHandler noteDeleteCommandHandler(NoteWritePlatformService noteWritePlatformService,
            DatabaseTransaction databaseTransaction) {
        return new NoteDeleteCommandHandler(noteWritePlatformService, databaseTransaction);
    }

    @Bean
    public NotesApiResource notesApiResource(NoteReadPlatformService noteReadPlatformService, CommandDispatcher commandDispatcher) {
        return new NotesApiResource(noteReadPlatformService, commandDispatcher);
    }

    @Bean
    public NoteEvents noteEvents(NoteWritePlatformService noteWritePlatformService) {
        return new NoteEvents(new NoteListener(noteWritePlatformService));
    }

    @Bean(initMethod = "afterPropertiesSet", destroyMethod = "destroy")
    public NoteOsgiServiceRegistrar noteOsgiServiceRegistrar(NoteReadPlatformService noteReadPlatformService,
            NoteWritePlatformService noteWritePlatformService) {
        return new NoteOsgiServiceRegistrar(noteReadPlatformService, noteWritePlatformService);
    }

    public static class NoteEvents {

        private final NoteListener listener;

        public NoteEvents(NoteListener listener) {
            this.listener = listener;
        }

        @EventListener
        public void onCreate(NoteCreateRequest request) {
            listener.onCreate(request);
        }

        @EventListener
        public void onUpdate(NoteCreateRequest request) {
            listener.onUpdate(request);
        }

        @EventListener
        public void onDelete(NoteCreateRequest request) {
            listener.onDelete(request);
        }
    }
}
