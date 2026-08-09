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
package org.apache.fineract.infrastructure.configuration.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.infrastructure.configuration.domain.ConfigurationDomainService;
import org.apache.fineract.infrastructure.configuration.service.ConfigurationReadPlatformService;
import org.apache.fineract.infrastructure.configuration.service.ExternalServiceWritePlatformService;
import org.apache.fineract.infrastructure.configuration.service.ExternalServicesPropertiesReadPlatformService;
import org.apache.fineract.infrastructure.configuration.service.ExternalServicesReadPlatformService;
import org.apache.fineract.infrastructure.configuration.service.GlobalConfigurationWritePlatformService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/** Spring ↔ OSGi bridge for configuration ports. */
@Component
public class ConfigurationOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(ConfigurationOsgiServiceRegistrar.class);

    private final ObjectProvider<ConfigurationDomainService> domain;
    private final ObjectProvider<ConfigurationReadPlatformService> read;
    private final ObjectProvider<GlobalConfigurationWritePlatformService> globalWrite;
    private final ObjectProvider<ExternalServicesPropertiesReadPlatformService> externalPropsRead;
    private final ObjectProvider<ExternalServicesReadPlatformService> externalRead;
    private final ObjectProvider<ExternalServiceWritePlatformService> externalWrite;
    private final List<Object> registrations = new ArrayList<>();

    public ConfigurationOsgiServiceRegistrar(final ObjectProvider<ConfigurationDomainService> domain,
            final ObjectProvider<ConfigurationReadPlatformService> read,
            final ObjectProvider<GlobalConfigurationWritePlatformService> globalWrite,
            final ObjectProvider<ExternalServicesPropertiesReadPlatformService> externalPropsRead,
            final ObjectProvider<ExternalServicesReadPlatformService> externalRead,
            final ObjectProvider<ExternalServiceWritePlatformService> externalWrite) {
        this.domain = domain;
        this.read = read;
        this.globalWrite = globalWrite;
        this.externalPropsRead = externalPropsRead;
        this.externalRead = externalRead;
        this.externalWrite = externalWrite;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, ConfigurationOsgiServiceRegistrar.class);
            if (bundle == null) {
                return;
            }
            final Object context = bundle.getClass().getMethod("getBundleContext").invoke(bundle);
            if (context == null) {
                return;
            }
            register(context, ConfigurationDomainService.class, domain.getIfAvailable());
            register(context, ConfigurationReadPlatformService.class, read.getIfAvailable());
            register(context, GlobalConfigurationWritePlatformService.class, globalWrite.getIfAvailable());
            register(context, ExternalServicesPropertiesReadPlatformService.class, externalPropsRead.getIfAvailable());
            register(context, ExternalServicesReadPlatformService.class, externalRead.getIfAvailable());
            register(context, ExternalServiceWritePlatformService.class, externalWrite.getIfAvailable());
            LOG.info("Registered {} configuration OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only configuration wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register configuration OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-configuration-impl");
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
