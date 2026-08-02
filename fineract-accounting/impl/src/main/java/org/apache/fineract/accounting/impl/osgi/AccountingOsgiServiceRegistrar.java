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
package org.apache.fineract.accounting.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.accounting.common.AccountingDropdownReadPlatformService;
import org.apache.fineract.accounting.glaccount.service.GLAccountReadPlatformService;
import org.apache.fineract.accounting.journalentry.service.JournalEntryReadPlatformService;
import org.apache.fineract.accounting.producttoaccountmapping.service.ProductToGLAccountMappingReadPlatformService;
import org.apache.fineract.accounting.producttoaccountmapping.service.ProductToGLAccountMappingWritePlatformService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/**
 * Spring ↔ OSGi bridge for primary accounting ports (ADR-022 / accounting plan).
 *
 * <p>Uses reflection so this class loads under plain Spring Boot without OSGi on the classpath.
 */
@Component
public class AccountingOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(AccountingOsgiServiceRegistrar.class);

    private final ObjectProvider<GLAccountReadPlatformService> glAccountRead;
    private final ObjectProvider<JournalEntryReadPlatformService> journalEntryRead;
    private final ObjectProvider<ProductToGLAccountMappingReadPlatformService> productMappingRead;
    private final ObjectProvider<ProductToGLAccountMappingWritePlatformService> productMappingWrite;
    private final ObjectProvider<AccountingDropdownReadPlatformService> dropdownRead;
    private final List<Object> registrations = new ArrayList<>();

    public AccountingOsgiServiceRegistrar(final ObjectProvider<GLAccountReadPlatformService> glAccountRead,
            final ObjectProvider<JournalEntryReadPlatformService> journalEntryRead,
            final ObjectProvider<ProductToGLAccountMappingReadPlatformService> productMappingRead,
            final ObjectProvider<ProductToGLAccountMappingWritePlatformService> productMappingWrite,
            final ObjectProvider<AccountingDropdownReadPlatformService> dropdownRead) {
        this.glAccountRead = glAccountRead;
        this.journalEntryRead = journalEntryRead;
        this.productMappingRead = productMappingRead;
        this.productMappingWrite = productMappingWrite;
        this.dropdownRead = dropdownRead;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, AccountingOsgiServiceRegistrar.class);
            if (bundle == null) {
                LOG.debug("OSGi Bundle not available; skipping accounting service registration");
                return;
            }
            final Method getBundleContext = bundle.getClass().getMethod("getBundleContext");
            final Object context = getBundleContext.invoke(bundle);
            if (context == null) {
                LOG.debug("OSGi BundleContext is null; skipping accounting service registration");
                return;
            }

            register(context, GLAccountReadPlatformService.class, glAccountRead.getIfAvailable());
            register(context, JournalEntryReadPlatformService.class, journalEntryRead.getIfAvailable());
            register(context, ProductToGLAccountMappingReadPlatformService.class, productMappingRead.getIfAvailable());
            register(context, ProductToGLAccountMappingWritePlatformService.class, productMappingWrite.getIfAvailable());
            register(context, AccountingDropdownReadPlatformService.class, dropdownRead.getIfAvailable());
            LOG.info("Registered {} accounting OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only accounting wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register accounting OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            LOG.debug("No Spring bean for {}; not registered in OSGi", type.getName());
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-accounting-impl");
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
