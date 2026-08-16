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
package org.apache.fineract.commands.provider;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.commands.annotation.CommandType;
import org.springframework.context.ApplicationContext;
import org.springframework.core.annotation.AnnotationUtils;

/**
 * Builds a {@link CommandHandlerProvider} without the composition-root Spring harness.
 */
final class CommandHandlerProviderFixtures {

    private static final String VALID_HANDLER_BEAN = "validCommandHandler";

    private CommandHandlerProviderFixtures() {}

    static CommandHandlerProvider createProvider() {
        ValidCommandHandler handler = new ValidCommandHandler();
        CommandType commandType = AnnotationUtils.findAnnotation(ValidCommandHandler.class, CommandType.class);

        ApplicationContext applicationContext = mock(ApplicationContext.class);
        when(applicationContext.getBeanNamesForAnnotation(CommandType.class)).thenReturn(new String[] { VALID_HANDLER_BEAN });
        when(applicationContext.findAnnotationOnBean(VALID_HANDLER_BEAN, CommandType.class)).thenReturn(commandType);
        when(applicationContext.getBean(VALID_HANDLER_BEAN)).thenReturn(handler);

        CommandHandlerProvider provider = new CommandHandlerProvider();
        provider.setApplicationContext(applicationContext);
        try {
            provider.afterPropertiesSet();
        } catch (Exception e) {
            throw new IllegalStateException("Failed to initialize CommandHandlerProvider for cucumber", e);
        }
        return provider;
    }
}
