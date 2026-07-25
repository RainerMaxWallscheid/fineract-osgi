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

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.command.core.CommandDispatcher;
import org.apache.fineract.command.core.CommandHandlerManager;
import org.apache.fineract.command.core.CommandHookManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/**
 * Spring ↔ OSGi bridge for the command stack (ADR-022).
 *
 * <p>
 * Uses reflection so this class loads under plain Spring Boot without OSGi on the classpath.
 * When loaded as an OSGi bundle, registers default command services under api interfaces.
 * Inter-bundle access is the OSGi Service Registry only (no Karaf Features).
 * </p>
 */
@Component
public class CommandOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(CommandOsgiServiceRegistrar.class);

    private final ObjectProvider<CommandDispatcher> commandDispatcher;
    private final ObjectProvider<CommandHandlerManager> commandHandlerManager;
    private final ObjectProvider<CommandHookManager> commandHookManager;

    private final List<Object> registrations = new ArrayList<>();

    public CommandOsgiServiceRegistrar(final ObjectProvider<CommandDispatcher> commandDispatcher,
            final ObjectProvider<CommandHandlerManager> commandHandlerManager,
            final ObjectProvider<CommandHookManager> commandHookManager) {
        this.commandDispatcher = commandDispatcher;
        this.commandHandlerManager = commandHandlerManager;
        this.commandHookManager = commandHookManager;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, CommandOsgiServiceRegistrar.class);
            if (bundle == null) {
                LOG.debug("OSGi Bundle not available; skipping command service registration");
                return;
            }
            final Method getBundleContext = bundle.getClass().getMethod("getBundleContext");
            final Object context = getBundleContext.invoke(bundle);
            if (context == null) {
                LOG.debug("OSGi BundleContext is null; skipping command service registration");
                return;
            }

            register(context, CommandDispatcher.class, commandDispatcher.getIfAvailable(), "sync");
            register(context, CommandHandlerManager.class, commandHandlerManager.getIfAvailable(), null);
            register(context, CommandHookManager.class, commandHookManager.getIfAvailable(), null);
            LOG.info("Registered {} command OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only command wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register command OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service, final String dispatcherKind)
            throws ReflectiveOperationException {
        if (service == null) {
            LOG.debug("No Spring bean for {}; not registered in OSGi", type.getName());
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-command-impl");
        if (dispatcherKind != null) {
            props.put("dispatcher", dispatcherKind);
        }
        final Method registerService = context.getClass().getMethod("registerService", Class.class, Object.class, Dictionary.class);
        final Object registration = registerService.invoke(context, type, service, props);
        registrations.add(registration);
        LOG.info("Registered OSGi service {}", type.getName());
    }

    @Override
    public void destroy() {
        for (final Object registration : registrations) {
            try {
                final Method unregister = registration.getClass().getMethod("unregister");
                unregister.invoke(registration);
            } catch (final ReflectiveOperationException | RuntimeException ex) {
                LOG.debug("Service already unregistered: {}", ex.toString());
            }
        }
        registrations.clear();
    }
}
