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
package org.apache.fineract.portfolio.loanaccount.progressiveloan.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.portfolio.loanaccount.service.BuyDownFeeReadPlatformService;
import org.apache.fineract.portfolio.loanaccount.service.CapitalizedIncomeBalanceReadService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/**
 * Spring ↔ OSGi bridge for pure progressive-loan ports (ADR-022).
 */
@Component
public class ProgressiveLoanOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(ProgressiveLoanOsgiServiceRegistrar.class);

    private final ObjectProvider<CapitalizedIncomeBalanceReadService> capitalizedIncomeRead;
    private final ObjectProvider<BuyDownFeeReadPlatformService> buyDownFeeRead;
    private final List<Object> registrations = new ArrayList<>();

    public ProgressiveLoanOsgiServiceRegistrar(final ObjectProvider<CapitalizedIncomeBalanceReadService> capitalizedIncomeRead,
            final ObjectProvider<BuyDownFeeReadPlatformService> buyDownFeeRead) {
        this.capitalizedIncomeRead = capitalizedIncomeRead;
        this.buyDownFeeRead = buyDownFeeRead;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, ProgressiveLoanOsgiServiceRegistrar.class);
            if (bundle == null) {
                LOG.debug("OSGi Bundle not available; skipping progressive-loan service registration");
                return;
            }
            final Method getBundleContext = bundle.getClass().getMethod("getBundleContext");
            final Object context = getBundleContext.invoke(bundle);
            if (context == null) {
                LOG.debug("OSGi BundleContext is null; skipping progressive-loan service registration");
                return;
            }
            register(context, CapitalizedIncomeBalanceReadService.class, capitalizedIncomeRead.getIfAvailable());
            register(context, BuyDownFeeReadPlatformService.class, buyDownFeeRead.getIfAvailable());
            LOG.info("Registered {} progressive-loan OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only progressive-loan wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register progressive-loan OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            LOG.debug("No Spring bean for {}; not registered in OSGi", type.getName());
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-progressive-loan-impl");
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
