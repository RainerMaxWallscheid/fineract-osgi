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
import static org.mockito.Mockito.mock;

import java.lang.annotation.Annotation;
import java.util.Arrays;
import org.apache.fineract.command.core.CommandDispatcher;
import org.apache.fineract.infrastructure.core.service.DatabaseTransaction;
import org.apache.fineract.infrastructure.core.service.JdbcDatabase;
import org.apache.fineract.infrastructure.core.service.JpaSession;
import org.apache.fineract.portfolio.client.moduleapi.ClientActivePort;
import org.apache.fineract.portfolio.group.moduleapi.GroupActivePort;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanExistencePort;
import org.apache.fineract.portfolio.note.api.NotesApiResource;
import org.apache.fineract.portfolio.note.handler.NoteCreateCommandHandler;
import org.apache.fineract.portfolio.note.handler.NoteDeleteCommandHandler;
import org.apache.fineract.portfolio.note.handler.NoteUpdateCommandHandler;
import org.apache.fineract.portfolio.note.impl.osgi.NoteOsgiServiceRegistrar;
import org.apache.fineract.portfolio.note.listener.NoteListener;
import org.apache.fineract.portfolio.note.service.NoteReadPlatformService;
import org.apache.fineract.portfolio.note.service.NoteReadPlatformServiceImpl;
import org.apache.fineract.portfolio.note.service.NoteWritePlatformService;
import org.apache.fineract.portfolio.note.service.NoteWritePlatformServiceImpl;
import org.apache.fineract.portfolio.note.starter.NoteComponents;
import org.apache.fineract.portfolio.savings.moduleapi.SavingsAccountExistencePort;
import org.junit.jupiter.api.Test;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

class NoteRepositoryConditionTest {

    @Test
    void compositionRegistersTheRepository() {
        try (AnnotationConfigApplicationContext context = context(Dependencies.class)) {
            assertThat(context.getBean(NoteRepository.class)).isInstanceOf(NoteRepositoryImpl.class);
            assertThat(context.getBean(NoteWritePlatformService.class)).isInstanceOf(NoteWritePlatformServiceImpl.class);
            assertThat(context.getBean(NoteReadPlatformService.class)).isInstanceOf(NoteReadPlatformServiceImpl.class);
            assertThat(context.getBean(NoteCreateCommandHandler.class)).isNotNull();
            assertThat(context.getBean(NoteUpdateCommandHandler.class)).isNotNull();
            assertThat(context.getBean(NoteDeleteCommandHandler.class)).isNotNull();
            assertThat(context.getBean(NotesApiResource.class)).isNotNull();
            assertThat(context.getBean(NoteComponents.NoteEvents.class)).isNotNull();
            assertThat(context.getBean(NoteOsgiServiceRegistrar.class)).isNotNull();
        }
    }

    @Test
    void customRepositoryReplacesTheDefault() {
        try (AnnotationConfigApplicationContext context = context(CustomRepository.class, Dependencies.class)) {
            assertThat(context.getBean(NoteRepository.class)).isSameAs(CustomRepository.REPOSITORY);
            assertThat(context.getBean(NoteWritePlatformService.class)).isInstanceOf(NoteWritePlatformServiceImpl.class);
        }
    }

    @Test
    void customWriteServiceReplacesTheDefault() {
        try (AnnotationConfigApplicationContext context = context(CustomWriteService.class, Dependencies.class)) {
            assertThat(context.getBean(NoteWritePlatformService.class)).isSameAs(CustomWriteService.WRITE);
            assertThat(context.getBean(NoteRepository.class)).isInstanceOf(NoteRepositoryImpl.class);
            assertThat(context.getBean(NoteCreateCommandHandler.class)).isNotNull();
        }
    }

    @Test
    void componentClassesDoNotUseSpring() {
        assertThat(springAnnotations(NoteRepositoryImpl.class)).isEmpty();
        assertThat(springAnnotations(NoteWritePlatformServiceImpl.class)).isEmpty();
        assertThat(springAnnotations(NoteReadPlatformServiceImpl.class)).isEmpty();
        assertThat(springAnnotations(NoteCreateCommandHandler.class)).isEmpty();
        assertThat(springAnnotations(NoteUpdateCommandHandler.class)).isEmpty();
        assertThat(springAnnotations(NoteDeleteCommandHandler.class)).isEmpty();
        assertThat(springAnnotations(NotesApiResource.class)).isEmpty();
        assertThat(springAnnotations(NoteListener.class)).isEmpty();
        assertThat(springAnnotations(NoteOsgiServiceRegistrar.class)).isEmpty();
    }

    private static AnnotationConfigApplicationContext context(Class<?>... configurations) {
        AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext();
        for (Class<?> configuration : configurations) {
            context.register(configuration);
        }
        context.register(NoteComponents.class);
        context.refresh();
        return context;
    }

    private static String[] springAnnotations(Class<?> type) {
        return Arrays.stream(type.getAnnotations()).map(Annotation::annotationType).map(Class::getName)
                .filter(name -> name.startsWith("org.springframework.")).toArray(String[]::new);
    }

    @Configuration
    static class Dependencies {

        @Bean
        JpaSession jpaSession() {
            return mock(JpaSession.class);
        }

        @Bean
        ClientActivePort clientActivePort() {
            return mock(ClientActivePort.class);
        }

        @Bean
        GroupActivePort groupActivePort() {
            return mock(GroupActivePort.class);
        }

        @Bean
        LoanExistencePort loanExistencePort() {
            return mock(LoanExistencePort.class);
        }

        @Bean
        SavingsAccountExistencePort savingsAccountExistencePort() {
            return mock(SavingsAccountExistencePort.class);
        }

        @Bean
        JdbcDatabase jdbcDatabase() {
            return mock(JdbcDatabase.class);
        }

        @Bean
        DatabaseTransaction databaseTransaction() {
            return mock(DatabaseTransaction.class);
        }

        @Bean
        CommandDispatcher commandDispatcher() {
            return mock(CommandDispatcher.class);
        }
    }

    @Configuration
    static class CustomRepository {

        static final NoteRepository REPOSITORY = mock(NoteRepository.class);

        @Bean
        NoteRepository customNoteRepository() {
            return REPOSITORY;
        }
    }

    @Configuration
    static class CustomWriteService {

        static final NoteWritePlatformService WRITE = mock(NoteWritePlatformService.class);

        @Bean
        NoteWritePlatformService customNoteWritePlatformService() {
            return WRITE;
        }
    }
}
