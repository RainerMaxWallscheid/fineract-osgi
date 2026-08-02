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
package org.apache.fineract.portfolio.savings.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.portfolio.savings.service.DepositApplicationProcessWritePlatformService;
import org.apache.fineract.portfolio.savings.service.DepositProductReadPlatformService;
import org.apache.fineract.portfolio.savings.service.SavingsApplicationProcessWritePlatformService;
import org.apache.fineract.portfolio.savings.service.SavingsProductReadPlatformService;
import org.apache.fineract.portfolio.savings.service.SavingsProductWritePlatformService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/**
 * Spring ↔ OSGi bridge for primary savings ports (ADR-022 / savings plan).
 *
 * <p>Entity-typed account write/read ports remain composition-root residual on impl.
 */
@Component
public class SavingsOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(SavingsOsgiServiceRegistrar.class);

    private final ObjectProvider<SavingsProductReadPlatformService> productRead;
    private final ObjectProvider<SavingsProductWritePlatformService> productWrite;
    private final ObjectProvider<SavingsApplicationProcessWritePlatformService> applicationWrite;
    private final ObjectProvider<DepositProductReadPlatformService> depositProductRead;
    private final ObjectProvider<DepositApplicationProcessWritePlatformService> depositApplicationWrite;
    private final List<Object> registrations = new ArrayList<>();

    public SavingsOsgiServiceRegistrar(final ObjectProvider<SavingsProductReadPlatformService> productRead,
            final ObjectProvider<SavingsProductWritePlatformService> productWrite,
            final ObjectProvider<SavingsApplicationProcessWritePlatformService> applicationWrite,
            final ObjectProvider<DepositProductReadPlatformService> depositProductRead,
            final ObjectProvider<DepositApplicationProcessWritePlatformService> depositApplicationWrite) {
        this.productRead = productRead;
        this.productWrite = productWrite;
        this.applicationWrite = applicationWrite;
        this.depositProductRead = depositProductRead;
        this.depositApplicationWrite = depositApplicationWrite;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, SavingsOsgiServiceRegistrar.class);
            if (bundle == null) {
                LOG.debug("OSGi Bundle not available; skipping savings service registration");
                return;
            }
            final Method getBundleContext = bundle.getClass().getMethod("getBundleContext");
            final Object context = getBundleContext.invoke(bundle);
            if (context == null) {
                LOG.debug("OSGi BundleContext is null; skipping savings service registration");
                return;
            }

            register(context, SavingsProductReadPlatformService.class, productRead.getIfAvailable());
            register(context, SavingsProductWritePlatformService.class, productWrite.getIfAvailable());
            register(context, SavingsApplicationProcessWritePlatformService.class, applicationWrite.getIfAvailable());
            register(context, DepositProductReadPlatformService.class, depositProductRead.getIfAvailable());
            register(context, DepositApplicationProcessWritePlatformService.class, depositApplicationWrite.getIfAvailable());
            LOG.info("Registered {} savings OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only savings wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register savings OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            LOG.debug("No Spring bean for {}; not registered in OSGi", type.getName());
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-savings-impl");
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
