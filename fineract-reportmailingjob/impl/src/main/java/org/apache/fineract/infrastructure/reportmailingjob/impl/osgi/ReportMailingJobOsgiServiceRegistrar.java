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
package org.apache.fineract.infrastructure.reportmailingjob.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.infrastructure.reportmailingjob.service.ReportMailingJobConfigurationReadPlatformService;
import org.apache.fineract.infrastructure.reportmailingjob.service.ReportMailingJobEmailService;
import org.apache.fineract.infrastructure.reportmailingjob.service.ReportMailingJobReadPlatformService;
import org.apache.fineract.infrastructure.reportmailingjob.service.ReportMailingJobRunHistoryReadPlatformService;
import org.apache.fineract.infrastructure.reportmailingjob.service.ReportMailingJobWritePlatformService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/** Spring ↔ OSGi bridge for report mailing job ports. */
@Component
public class ReportMailingJobOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(ReportMailingJobOsgiServiceRegistrar.class);

    private final ObjectProvider<ReportMailingJobReadPlatformService> read;
    private final ObjectProvider<ReportMailingJobWritePlatformService> write;
    private final ObjectProvider<ReportMailingJobRunHistoryReadPlatformService> runHistory;
    private final ObjectProvider<ReportMailingJobConfigurationReadPlatformService> configuration;
    private final ObjectProvider<ReportMailingJobEmailService> email;
    private final List<Object> registrations = new ArrayList<>();

    public ReportMailingJobOsgiServiceRegistrar(final ObjectProvider<ReportMailingJobReadPlatformService> read,
            final ObjectProvider<ReportMailingJobWritePlatformService> write,
            final ObjectProvider<ReportMailingJobRunHistoryReadPlatformService> runHistory,
            final ObjectProvider<ReportMailingJobConfigurationReadPlatformService> configuration,
            final ObjectProvider<ReportMailingJobEmailService> email) {
        this.read = read;
        this.write = write;
        this.runHistory = runHistory;
        this.configuration = configuration;
        this.email = email;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, ReportMailingJobOsgiServiceRegistrar.class);
            if (bundle == null) {
                return;
            }
            final Object context = bundle.getClass().getMethod("getBundleContext").invoke(bundle);
            if (context == null) {
                return;
            }
            register(context, ReportMailingJobReadPlatformService.class, read.getIfAvailable());
            register(context, ReportMailingJobWritePlatformService.class, write.getIfAvailable());
            register(context, ReportMailingJobRunHistoryReadPlatformService.class, runHistory.getIfAvailable());
            register(context, ReportMailingJobConfigurationReadPlatformService.class, configuration.getIfAvailable());
            register(context, ReportMailingJobEmailService.class, email.getIfAvailable());
            LOG.info("Registered {} report mailing job OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only report mailing job wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register report mailing job OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-reportmailingjob-impl");
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
