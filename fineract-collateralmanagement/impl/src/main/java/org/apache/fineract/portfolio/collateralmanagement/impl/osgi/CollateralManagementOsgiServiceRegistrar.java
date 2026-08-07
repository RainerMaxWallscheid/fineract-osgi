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
package org.apache.fineract.portfolio.collateralmanagement.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.portfolio.collateralmanagement.service.ClientCollateralManagementReadService;
import org.apache.fineract.portfolio.collateralmanagement.service.ClientCollateralManagementWriteService;
import org.apache.fineract.portfolio.collateralmanagement.service.CollateralManagementReadService;
import org.apache.fineract.portfolio.collateralmanagement.service.CollateralManagementWriteService;
import org.apache.fineract.portfolio.collateralmanagement.service.LoanCollateralManagementReadService;
import org.apache.fineract.portfolio.collateralmanagement.service.LoanCollateralManagementWriteService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/** Spring ↔ OSGi bridge for collateral management ports. */
@Component
public class CollateralManagementOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(CollateralManagementOsgiServiceRegistrar.class);

    private final ObjectProvider<CollateralManagementReadService> productRead;
    private final ObjectProvider<CollateralManagementWriteService> productWrite;
    private final ObjectProvider<ClientCollateralManagementReadService> clientRead;
    private final ObjectProvider<ClientCollateralManagementWriteService> clientWrite;
    private final ObjectProvider<LoanCollateralManagementReadService> loanRead;
    private final ObjectProvider<LoanCollateralManagementWriteService> loanWrite;
    private final List<Object> registrations = new ArrayList<>();

    public CollateralManagementOsgiServiceRegistrar(final ObjectProvider<CollateralManagementReadService> productRead,
            final ObjectProvider<CollateralManagementWriteService> productWrite,
            final ObjectProvider<ClientCollateralManagementReadService> clientRead,
            final ObjectProvider<ClientCollateralManagementWriteService> clientWrite,
            final ObjectProvider<LoanCollateralManagementReadService> loanRead,
            final ObjectProvider<LoanCollateralManagementWriteService> loanWrite) {
        this.productRead = productRead;
        this.productWrite = productWrite;
        this.clientRead = clientRead;
        this.clientWrite = clientWrite;
        this.loanRead = loanRead;
        this.loanWrite = loanWrite;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, CollateralManagementOsgiServiceRegistrar.class);
            if (bundle == null) {
                return;
            }
            final Object context = bundle.getClass().getMethod("getBundleContext").invoke(bundle);
            if (context == null) {
                return;
            }
            register(context, CollateralManagementReadService.class, productRead.getIfAvailable());
            register(context, CollateralManagementWriteService.class, productWrite.getIfAvailable());
            register(context, ClientCollateralManagementReadService.class, clientRead.getIfAvailable());
            register(context, ClientCollateralManagementWriteService.class, clientWrite.getIfAvailable());
            register(context, LoanCollateralManagementReadService.class, loanRead.getIfAvailable());
            register(context, LoanCollateralManagementWriteService.class, loanWrite.getIfAvailable());
            LOG.info("Registered {} collateralmanagement OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only collateralmanagement wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register collateralmanagement OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-collateralmanagement-impl");
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
