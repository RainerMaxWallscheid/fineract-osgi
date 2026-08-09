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
package org.apache.fineract.infrastructure.campaigns.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.infrastructure.campaigns.email.service.EmailCampaignReadPlatformService;
import org.apache.fineract.infrastructure.campaigns.email.service.EmailCampaignWritePlatformService;
import org.apache.fineract.infrastructure.campaigns.email.service.EmailConfigurationReadPlatformService;
import org.apache.fineract.infrastructure.campaigns.email.service.EmailConfigurationWritePlatformService;
import org.apache.fineract.infrastructure.campaigns.email.service.EmailReadPlatformService;
import org.apache.fineract.infrastructure.campaigns.email.service.EmailWritePlatformService;
import org.apache.fineract.infrastructure.campaigns.sms.service.SmsCampaignDropdownReadPlatformService;
import org.apache.fineract.infrastructure.campaigns.sms.service.SmsCampaignReadPlatformService;
import org.apache.fineract.infrastructure.campaigns.sms.service.SmsCampaignWritePlatformService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/** Spring ↔ OSGi bridge for campaign ports. */
@Component
public class CampaignsOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(CampaignsOsgiServiceRegistrar.class);

    private final ObjectProvider<SmsCampaignReadPlatformService> smsRead;
    private final ObjectProvider<SmsCampaignWritePlatformService> smsWrite;
    private final ObjectProvider<SmsCampaignDropdownReadPlatformService> smsDropdown;
    private final ObjectProvider<EmailCampaignReadPlatformService> emailCampaignRead;
    private final ObjectProvider<EmailCampaignWritePlatformService> emailCampaignWrite;
    private final ObjectProvider<EmailReadPlatformService> emailRead;
    private final ObjectProvider<EmailWritePlatformService> emailWrite;
    private final ObjectProvider<EmailConfigurationReadPlatformService> emailConfigRead;
    private final ObjectProvider<EmailConfigurationWritePlatformService> emailConfigWrite;
    private final List<Object> registrations = new ArrayList<>();

    public CampaignsOsgiServiceRegistrar(final ObjectProvider<SmsCampaignReadPlatformService> smsRead,
            final ObjectProvider<SmsCampaignWritePlatformService> smsWrite,
            final ObjectProvider<SmsCampaignDropdownReadPlatformService> smsDropdown,
            final ObjectProvider<EmailCampaignReadPlatformService> emailCampaignRead,
            final ObjectProvider<EmailCampaignWritePlatformService> emailCampaignWrite,
            final ObjectProvider<EmailReadPlatformService> emailRead, final ObjectProvider<EmailWritePlatformService> emailWrite,
            final ObjectProvider<EmailConfigurationReadPlatformService> emailConfigRead,
            final ObjectProvider<EmailConfigurationWritePlatformService> emailConfigWrite) {
        this.smsRead = smsRead;
        this.smsWrite = smsWrite;
        this.smsDropdown = smsDropdown;
        this.emailCampaignRead = emailCampaignRead;
        this.emailCampaignWrite = emailCampaignWrite;
        this.emailRead = emailRead;
        this.emailWrite = emailWrite;
        this.emailConfigRead = emailConfigRead;
        this.emailConfigWrite = emailConfigWrite;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, CampaignsOsgiServiceRegistrar.class);
            if (bundle == null) {
                return;
            }
            final Object context = bundle.getClass().getMethod("getBundleContext").invoke(bundle);
            if (context == null) {
                return;
            }
            register(context, SmsCampaignReadPlatformService.class, smsRead.getIfAvailable());
            register(context, SmsCampaignWritePlatformService.class, smsWrite.getIfAvailable());
            register(context, SmsCampaignDropdownReadPlatformService.class, smsDropdown.getIfAvailable());
            register(context, EmailCampaignReadPlatformService.class, emailCampaignRead.getIfAvailable());
            register(context, EmailCampaignWritePlatformService.class, emailCampaignWrite.getIfAvailable());
            register(context, EmailReadPlatformService.class, emailRead.getIfAvailable());
            register(context, EmailWritePlatformService.class, emailWrite.getIfAvailable());
            register(context, EmailConfigurationReadPlatformService.class, emailConfigRead.getIfAvailable());
            register(context, EmailConfigurationWritePlatformService.class, emailConfigWrite.getIfAvailable());
            LOG.info("Registered {} campaigns OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only campaigns wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register campaigns OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-campaigns-impl");
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
