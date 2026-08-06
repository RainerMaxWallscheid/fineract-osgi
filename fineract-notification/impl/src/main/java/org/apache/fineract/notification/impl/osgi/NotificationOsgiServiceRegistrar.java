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
package org.apache.fineract.notification.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.notification.eventandlistener.NotificationEventPublisher;
import org.apache.fineract.notification.service.NotificationReadPlatformService;
import org.apache.fineract.notification.service.NotificationWritePlatformService;
import org.apache.fineract.notification.service.UserNotificationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/** Spring ↔ OSGi bridge for notification ports. */
@Component
public class NotificationOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(NotificationOsgiServiceRegistrar.class);

    private final ObjectProvider<UserNotificationService> userNotification;
    private final ObjectProvider<NotificationReadPlatformService> read;
    private final ObjectProvider<NotificationWritePlatformService> write;
    private final ObjectProvider<NotificationEventPublisher> publisher;
    private final List<Object> registrations = new ArrayList<>();

    public NotificationOsgiServiceRegistrar(final ObjectProvider<UserNotificationService> userNotification,
            final ObjectProvider<NotificationReadPlatformService> read, final ObjectProvider<NotificationWritePlatformService> write,
            final ObjectProvider<NotificationEventPublisher> publisher) {
        this.userNotification = userNotification;
        this.read = read;
        this.write = write;
        this.publisher = publisher;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, NotificationOsgiServiceRegistrar.class);
            if (bundle == null) {
                return;
            }
            final Object context = bundle.getClass().getMethod("getBundleContext").invoke(bundle);
            if (context == null) {
                return;
            }
            register(context, UserNotificationService.class, userNotification.getIfAvailable());
            register(context, NotificationReadPlatformService.class, read.getIfAvailable());
            register(context, NotificationWritePlatformService.class, write.getIfAvailable());
            register(context, NotificationEventPublisher.class, publisher.getIfAvailable());
            LOG.info("Registered {} notification OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only notification wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register notification OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-notification-impl");
        final Object registration = context.getClass().getMethod("registerService", Class.class, Object.class, Dictionary.class)
                .invoke(context, type, service, props);
        registrations.add(registration);
    }

    @Override
    public void destroy() {
        for (final Object registration : registrations) {
            try {
                registration.getClass().getMethod("unregister").invoke(registration);
            } catch (final ReflectiveOperationException | RuntimeException ignored) {
                // already unregistered
            }
        }
        registrations.clear();
    }
}
