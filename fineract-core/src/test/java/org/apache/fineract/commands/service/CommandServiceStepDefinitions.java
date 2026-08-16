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
package org.apache.fineract.commands.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.nullable;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import io.cucumber.java8.En;
import io.github.resilience4j.retry.Retry;
import io.github.resilience4j.retry.RetryConfig;
import io.github.resilience4j.retry.RetryRegistry;
import io.github.resilience4j.retry.event.RetryEvent;
import jakarta.servlet.http.HttpServletRequest;
import java.time.Duration;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.function.BiConsumer;
import org.apache.fineract.batch.exception.ErrorInfo;
import org.apache.fineract.commands.configuration.RetryConfigurationAssembler;
import org.apache.fineract.commands.domain.CommandSource;
import org.apache.fineract.commands.domain.CommandWrapper;
import org.apache.fineract.commands.exception.RollbackTransactionNotApprovedException;
import org.apache.fineract.commands.handler.NewCommandSourceHandler;
import org.apache.fineract.commands.provider.CommandHandlerProvider;
import org.apache.fineract.infrastructure.configuration.domain.ConfigurationDomainService;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.config.FineractProperties;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;
import org.apache.fineract.infrastructure.core.domain.FineractRequestContextHolder;
import org.apache.fineract.infrastructure.core.exception.IdempotentCommandProcessUnderProcessingException;
import org.apache.fineract.infrastructure.core.serialization.ToApiJsonSerializer;
import org.apache.fineract.infrastructure.core.service.TransactionBoundApplicationEventPublisher;
import org.apache.fineract.infrastructure.security.service.PlatformSecurityContext;
import org.apache.fineract.useradministration.domain.AppUser;
import org.mockito.Mockito;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.CannotAcquireLockException;
import org.springframework.dao.ConcurrencyFailureException;
import org.springframework.orm.ObjectOptimisticLockingFailureException;
import org.springframework.test.util.ReflectionTestUtils;

public class CommandServiceStepDefinitions implements En {

    private static final Logger log = LoggerFactory.getLogger(CommandServiceStepDefinitions.class);

    private CommandProcessingService processAndLogCommandService;
    private RetryConfigurationAssembler retryConfigurationAssembler;
    private PortfolioCommandSourceWritePlatformService commandSourceWritePlatformService;
    private DummyCommand command;
    private RetryEvent retryEvent;
    private final AtomicInteger counter = new AtomicInteger();

    public CommandServiceStepDefinitions() {
        Given("/^A command source write service$/", () -> {
            counter.set(0);
            retryEvent = null;
            processAndLogCommandService = createCommandProcessingService();
            this.commandSourceWritePlatformService = new DummyCommandSourceWriteService(processAndLogCommandService);
            this.command = new DummyCommand();

            FineractRequestContextHolder contextHolder = Mockito.spy(new FineractRequestContextHolder());
            ReflectionTestUtils.setField(processAndLogCommandService, "fineractRequestContextHolder", contextHolder);
            // Also replace the holder used by RetryConfigurationAssembler#setLastException.
            ReflectionTestUtils.setField(retryConfigurationAssembler, "fineractRequestContextHolder", contextHolder);
            Mockito.when(contextHolder.getAttribute(anyString(), nullable(HttpServletRequest.class)))
                    .thenThrow(new CannotAcquireLockException("BLOW IT UP!!!"))
                    .thenThrow(new ObjectOptimisticLockingFailureException("Dummy", new RuntimeException("BLOW IT UP!!!")))
                    .thenThrow(new RollbackTransactionNotApprovedException(1L, null));

            Retry retry1 = retryConfigurationAssembler.getRetryConfigurationForExecuteCommand();
            assertNotNull(retry1);
            retry1.getEventPublisher().onRetry(event -> {
                log.warn("... retry event: {}", event);
                counter.incrementAndGet();
                CommandServiceStepDefinitions.this.retryEvent = event;
            });
        });

        When("/^The user executes the command via a command write service with exceptions$/", () -> {
            try {
                this.commandSourceWritePlatformService.logCommandSource(command);
            } catch (Exception e) {
                log.warn("At the moment mocking data access is so incredibly hard... it's easier to just ignore this exception: {}",
                        e.getMessage());
            }
        });

        Then("/^The command processing service should fallback as expected$/", () -> {
            assertNotNull(retryEvent);
            assertEquals("executeCommand", retryEvent.getName());
            assertEquals(2, retryEvent.getNumberOfRetryAttempts());
        });

        Then("/^The command processing service execute function should be called 2 times$/", () -> {
            assertEquals(2, counter.get());
        });
    }

    private CommandProcessingService createCommandProcessingService() {
        PlatformSecurityContext context = mock(PlatformSecurityContext.class);
        ApplicationContext applicationContext = mock(ApplicationContext.class);
        TransactionBoundApplicationEventPublisher eventPublisher = mock(TransactionBoundApplicationEventPublisher.class);
        @SuppressWarnings("unchecked")
        ToApiJsonSerializer<Map<String, Object>> toApiJsonSerializer = mock(ToApiJsonSerializer.class);
        @SuppressWarnings("unchecked")
        ToApiJsonSerializer<CommandProcessingResult> toApiResultJsonSerializer = mock(ToApiJsonSerializer.class);
        ConfigurationDomainService configurationDomainService = mock(ConfigurationDomainService.class);
        CommandHandlerProvider commandHandlerProvider = mock(CommandHandlerProvider.class);
        IdempotencyKeyResolver idempotencyKeyResolver = mock(IdempotencyKeyResolver.class);
        CommandSourceService commandSourceService = mock(CommandSourceService.class);
        FineractRequestContextHolder requestContextHolder = new FineractRequestContextHolder();

        RetryRegistry retryRegistry = mock(RetryRegistry.class);
        Map<String, Retry> retries = new HashMap<>();
        when(retryRegistry.retry(anyString(), any(RetryConfig.class))).thenAnswer(i -> {
            String name = i.getArgument(0);
            RetryConfig config = i.getArgument(1);
            return retries.computeIfAbsent(name, n -> Retry.of(n, config));
        });

        FineractProperties fineractProperties = new FineractProperties();
        FineractProperties.RetryProperties settings = new FineractProperties.RetryProperties();
        settings.setInstances(new FineractProperties.RetryProperties.InstancesProperties());
        settings.getInstances().setExecuteCommand(new FineractProperties.RetryProperties.InstancesProperties.ExecuteCommandProperties());
        settings.getInstances().getExecuteCommand().setMaxAttempts(3);
        settings.getInstances().getExecuteCommand().setWaitDuration(Duration.ofMillis(1));
        settings.getInstances().getExecuteCommand().setEnableExponentialBackoff(false);
        settings.getInstances().getExecuteCommand()
                .setRetryExceptions(new Class[] { ConcurrencyFailureException.class, IdempotentCommandProcessUnderProcessingException.class });
        fineractProperties.setRetry(settings);

        this.retryConfigurationAssembler = new RetryConfigurationAssembler(retryRegistry, fineractProperties, requestContextHolder);

        ErrorInfo errorInfo = mock(ErrorInfo.class);
        when(errorInfo.getMessage()).thenReturn("Failed");
        when(errorInfo.getStatusCode()).thenReturn(500);
        when(commandSourceService.generateErrorInfo(any())).thenReturn(errorInfo);

        AppUser appUser = mock(AppUser.class);
        when(context.authenticatedUser(any(CommandWrapper.class))).thenReturn(appUser);
        when(idempotencyKeyResolver.resolve(any(CommandWrapper.class))).thenReturn("idk");
        CommandSource commandSource = mock(CommandSource.class);
        when(commandSource.getId()).thenReturn(1L);
        when(commandSourceService.findCommandSource(any(), anyString())).thenReturn(null);
        when(commandSourceService.saveInitial(any(), any(), any(), anyString())).thenReturn(commandSource);
        when(commandSourceService.getCommandSource(any())).thenReturn(commandSource);
        when(commandSourceService.saveResult(any())).thenReturn(commandSource);

        NewCommandSourceHandler handler = mock(NewCommandSourceHandler.class);
        when(commandHandlerProvider.getHandler(any(), any())).thenReturn(handler);
        when(configurationDomainService.isMakerCheckerEnabledForTask(any())).thenReturn(false);

        when(commandSourceService.processCommandAndSaveResult(any(NewCommandSourceHandler.class), any(JsonCommand.class),
                any(CommandSource.class), any(AppUser.class), Mockito.anyBoolean(),
                Mockito.<BiConsumer<CommandSource, CommandProcessingResult>>any())).thenAnswer(invocation -> {
                    NewCommandSourceHandler h = invocation.getArgument(0);
                    JsonCommand command = invocation.getArgument(1);
                    CommandSource source = invocation.getArgument(2);
                    BiConsumer<CommandSource, CommandProcessingResult> resultUpdater = invocation.getArgument(5);
                    CommandProcessingResult result = h.processCommand(command);
                    resultUpdater.accept(source, result);
                    return new CommandSourceService.CommandExecutionResult(result, source);
                });

        return new SynchronousCommandProcessingService(context, applicationContext, eventPublisher, toApiJsonSerializer,
                toApiResultJsonSerializer, configurationDomainService, commandHandlerProvider, idempotencyKeyResolver, commandSourceService,
                retryConfigurationAssembler, requestContextHolder);
    }

    public static class DummyCommand extends CommandWrapper {

        public DummyCommand() {
            super(null, null, null, null, null, null, null, null, null, null, "{}", null, null, null, null, null, null,
                    UUID.randomUUID().toString(), null, null);
        }

        @Override
        public String actionName() {
            return "dummy";
        }
    }

    public static class DummyCommandSourceWriteService implements PortfolioCommandSourceWritePlatformService {

        private final CommandProcessingService processAndLogCommandService;

        public DummyCommandSourceWriteService(CommandProcessingService processAndLogCommandService) {
            this.processAndLogCommandService = processAndLogCommandService;
        }

        @Override
        public CommandProcessingResult logCommandSource(CommandWrapper wrapper) {
            final String json = wrapper.getJson();
            JsonCommand command = JsonCommand.from(json, null, null, wrapper.getEntityName(), wrapper.getEntityId(),
                    wrapper.getSubentityId(), wrapper.getGroupId(), wrapper.getClientId(), wrapper.getLoanId(), wrapper.getSavingsId(),
                    wrapper.getTransactionId(), wrapper.getHref(), wrapper.getProductId(), wrapper.getCreditBureauId(),
                    wrapper.getOrganisationCreditBureauId(), wrapper.getJobName(), wrapper.getLoanExternalId());

            return this.processAndLogCommandService.executeCommand(wrapper, command, true);
        }

        @Override
        public CommandProcessingResult approveEntry(Long id) {
            return null;
        }

        @Override
        public Long rejectEntry(Long id) {
            return null;
        }

        @Override
        public Long deleteEntry(Long makerCheckerId) {
            return null;
        }
    }
}
