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
package org.apache.fineract.portfolio.loanaccount.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.portfolio.loanaccount.service.LoanApplicationWritePlatformService;
import org.apache.fineract.portfolio.loanaccount.service.LoanChargeWritePlatformService;
import org.apache.fineract.portfolio.loanproduct.service.LoanDropdownReadPlatformService;
import org.apache.fineract.portfolio.loanproduct.service.LoanProductReadBasicDetailsService;
import org.apache.fineract.portfolio.loanproduct.service.LoanProductWritePlatformService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/**
 * Spring ↔ OSGi bridge for primary pure loan ports (ADR-022 / loan plan).
 *
 * <p>
 * Entity-typed account services remain composition-root residual on impl.
 */
@Component
public class LoanOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(LoanOsgiServiceRegistrar.class);

    private final ObjectProvider<LoanProductWritePlatformService> productWrite;
    private final ObjectProvider<LoanProductReadBasicDetailsService> productReadBasic;
    private final ObjectProvider<LoanDropdownReadPlatformService> dropdownRead;
    private final ObjectProvider<LoanApplicationWritePlatformService> applicationWrite;
    private final ObjectProvider<LoanChargeWritePlatformService> chargeWrite;
    private final List<Object> registrations = new ArrayList<>();

    public LoanOsgiServiceRegistrar(final ObjectProvider<LoanProductWritePlatformService> productWrite,
            final ObjectProvider<LoanProductReadBasicDetailsService> productReadBasic,
            final ObjectProvider<LoanDropdownReadPlatformService> dropdownRead,
            final ObjectProvider<LoanApplicationWritePlatformService> applicationWrite,
            final ObjectProvider<LoanChargeWritePlatformService> chargeWrite) {
        this.productWrite = productWrite;
        this.productReadBasic = productReadBasic;
        this.dropdownRead = dropdownRead;
        this.applicationWrite = applicationWrite;
        this.chargeWrite = chargeWrite;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, LoanOsgiServiceRegistrar.class);
            if (bundle == null) {
                LOG.debug("OSGi Bundle not available; skipping loan service registration");
                return;
            }
            final Method getBundleContext = bundle.getClass().getMethod("getBundleContext");
            final Object context = getBundleContext.invoke(bundle);
            if (context == null) {
                LOG.debug("OSGi BundleContext is null; skipping loan service registration");
                return;
            }

            register(context, LoanProductWritePlatformService.class, productWrite.getIfAvailable());
            register(context, LoanProductReadBasicDetailsService.class, productReadBasic.getIfAvailable());
            register(context, LoanDropdownReadPlatformService.class, dropdownRead.getIfAvailable());
            register(context, LoanApplicationWritePlatformService.class, applicationWrite.getIfAvailable());
            register(context, LoanChargeWritePlatformService.class, chargeWrite.getIfAvailable());
            LOG.info("Registered {} loan OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only loan wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register loan OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            LOG.debug("No Spring bean for {}; not registered in OSGi", type.getName());
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-loan-impl");
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
