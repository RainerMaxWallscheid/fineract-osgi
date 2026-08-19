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
package org.apache.fineract.command.impl.osgi;

import static java.util.Objects.requireNonNull;
import java.util.function.Supplier;
import org.apache.fineract.command.core.Command;
import org.apache.fineract.command.core.CommandDispatcher;
import org.apache.fineract.command.core.CommandHandlerManager;
import org.apache.fineract.command.core.CommandHookManager;

/**
 * Synchronous dispatcher with no Spring types, so Equinox can load it
 * without staging Spring jars.
 * Published by {@code OSGI-INF/command-dispatcher.xml} (ADR-022 B6).
 */
public final class OsgiCommandDispatcher implements CommandDispatcher {

    private final CommandHandlerManager handlerManager;
    private final CommandHookManager hookManager;

    public OsgiCommandDispatcher() {
        this(new OsgiCommandHandlerManager(), new OsgiCommandHookManager());
    }

    public OsgiCommandDispatcher(final CommandHandlerManager handlerManager, final CommandHookManager hookManager) {
        this.handlerManager = requireNonNull(handlerManager, "handlerManager");
        this.hookManager = requireNonNull(hookManager, "hookManager");
    }

    @Override
    public <REQ, RES> Supplier<RES> dispatch(final Command<REQ> command) {
        requireNonNull(command, "Command must not be null");
        return () -> {
            try {
                hookManager.before(command);
                RES response = handlerManager.handle(command);
                hookManager.after(command, response);
                return response;
            } catch (Exception e) {
                hookManager.error(command, e);
                throw e;
            }
        };
    }
}
