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
package org.apache.fineract.infrastructure.creditbureau.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.infrastructure.creditbureau.service.CreditBureauLoanProductMappingReadPlatformService;
import org.apache.fineract.infrastructure.creditbureau.service.CreditBureauReadPlatformService;
import org.apache.fineract.infrastructure.creditbureau.service.CreditReportReadPlatformService;
import org.apache.fineract.infrastructure.creditbureau.service.OrganisationCreditBureauReadPlatformService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/** Spring ↔ OSGi bridge for credit bureau ports. */
@Component
public class CreditBureauOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(CreditBureauOsgiServiceRegistrar.class);

    private final ObjectProvider<CreditBureauReadPlatformService> read;
    private final ObjectProvider<CreditBureauLoanProductMappingReadPlatformService> loanProductMappingRead;
    private final ObjectProvider<OrganisationCreditBureauReadPlatformService> organisationRead;
    private final ObjectProvider<CreditReportReadPlatformService> reportRead;
    private final List<Object> registrations = new ArrayList<>();

    public CreditBureauOsgiServiceRegistrar(final ObjectProvider<CreditBureauReadPlatformService> read,
            final ObjectProvider<CreditBureauLoanProductMappingReadPlatformService> loanProductMappingRead,
            final ObjectProvider<OrganisationCreditBureauReadPlatformService> organisationRead,
            final ObjectProvider<CreditReportReadPlatformService> reportRead) {
        this.read = read;
        this.loanProductMappingRead = loanProductMappingRead;
        this.organisationRead = organisationRead;
        this.reportRead = reportRead;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, CreditBureauOsgiServiceRegistrar.class);
            if (bundle == null) {
                return;
            }
            final Object context = bundle.getClass().getMethod("getBundleContext").invoke(bundle);
            if (context == null) {
                return;
            }
            register(context, CreditBureauReadPlatformService.class, read.getIfAvailable());
            register(context, CreditBureauLoanProductMappingReadPlatformService.class, loanProductMappingRead.getIfAvailable());
            register(context, OrganisationCreditBureauReadPlatformService.class, organisationRead.getIfAvailable());
            register(context, CreditReportReadPlatformService.class, reportRead.getIfAvailable());
            LOG.info("Registered {} creditbureau OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only creditbureau wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register creditbureau OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-creditbureau-impl");
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
