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

import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.command.core.CommandDispatcher;
import org.apache.fineract.command.core.CommandHandlerManager;
import org.apache.fineract.command.core.CommandHookManager;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceRegistration;

/**
 * Equinox start path for the command pilot (ADR-022 B3). Registers the
 * command ports in the Service Registry without a Spring context.
 * {@link CommandOsgiServiceRegistrar} remains the Spring Boot path.
 */
public class CommandOsgiBundleActivator implements BundleActivator {

    private final List<ServiceRegistration<?>> registrations = new ArrayList<>();

    @Override
    public void start(final BundleContext context) {
        final CommandHookManager hooks = new OsgiCommandHookManager();
        final CommandHandlerManager handlers = new OsgiCommandHandlerManager();
        final CommandDispatcher dispatcher = new OsgiCommandDispatcher(handlers, hooks);
        register(context, CommandHookManager.class, hooks, null);
        register(context, CommandHandlerManager.class, handlers, null);
        register(context, CommandDispatcher.class, dispatcher, "sync");
    }

    @Override
    public void stop(final BundleContext context) {
        for (ServiceRegistration<?> registration : registrations) {
            try {
                registration.unregister();
            } catch (final IllegalStateException ignored) {
                // already unregistered
            }
        }
        registrations.clear();
    }

    private <T> void register(final BundleContext context, final Class<T> type, final T service, final String dispatcherKind) {
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-command-impl");
        props.put(Constants.SERVICE_RANKING, Integer.MIN_VALUE);
        if (dispatcherKind != null) {
            props.put("dispatcher", dispatcherKind);
        }
        registrations.add(context.registerService(type, service, props));
    }
}
