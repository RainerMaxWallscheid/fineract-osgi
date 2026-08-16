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
package org.apache.fineract.portfolio.client.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.portfolio.client.service.ClientChargeWritePlatformService;
import org.apache.fineract.portfolio.client.service.ClientFamilyMembersReadPlatformService;
import org.apache.fineract.portfolio.client.service.ClientFamilyMembersWritePlatformService;
import org.apache.fineract.portfolio.client.service.ClientIdentifierReadPlatformService;
import org.apache.fineract.portfolio.client.service.ClientIdentifierWritePlatformService;
import org.apache.fineract.portfolio.client.service.ClientReadPlatformService;
import org.apache.fineract.portfolio.client.service.ClientTemplateReadPlatformService;
import org.apache.fineract.portfolio.client.service.ClientTransactionReadPlatformService;
import org.apache.fineract.portfolio.client.service.ClientTransactionWritePlatformService;
import org.apache.fineract.portfolio.client.service.ClientWritePlatformService;
import org.apache.fineract.portfolio.client.service.search.ClientSearchService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/** Spring ↔ OSGi bridge for client ports. */
@Component
public class ClientsOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(ClientsOsgiServiceRegistrar.class);

    private final ObjectProvider<ClientReadPlatformService> read;
    private final ObjectProvider<ClientWritePlatformService> write;
    private final ObjectProvider<ClientTemplateReadPlatformService> template;
    private final ObjectProvider<ClientFamilyMembersReadPlatformService> familyRead;
    private final ObjectProvider<ClientFamilyMembersWritePlatformService> familyWrite;
    private final ObjectProvider<ClientIdentifierReadPlatformService> idRead;
    private final ObjectProvider<ClientIdentifierWritePlatformService> idWrite;
    private final ObjectProvider<ClientTransactionReadPlatformService> txnRead;
    private final ObjectProvider<ClientTransactionWritePlatformService> txnWrite;
    private final ObjectProvider<ClientChargeWritePlatformService> chargeWrite;
    private final ObjectProvider<ClientSearchService> search;
    private final List<Object> registrations = new ArrayList<>();

    public ClientsOsgiServiceRegistrar(final ObjectProvider<ClientReadPlatformService> read,
            final ObjectProvider<ClientWritePlatformService> write,
            final ObjectProvider<ClientTemplateReadPlatformService> template,
            final ObjectProvider<ClientFamilyMembersReadPlatformService> familyRead,
            final ObjectProvider<ClientFamilyMembersWritePlatformService> familyWrite,
            final ObjectProvider<ClientIdentifierReadPlatformService> idRead,
            final ObjectProvider<ClientIdentifierWritePlatformService> idWrite,
            final ObjectProvider<ClientTransactionReadPlatformService> txnRead,
            final ObjectProvider<ClientTransactionWritePlatformService> txnWrite,
            final ObjectProvider<ClientChargeWritePlatformService> chargeWrite,
            final ObjectProvider<ClientSearchService> search) {
        this.read = read;
        this.write = write;
        this.template = template;
        this.familyRead = familyRead;
        this.familyWrite = familyWrite;
        this.idRead = idRead;
        this.idWrite = idWrite;
        this.txnRead = txnRead;
        this.txnWrite = txnWrite;
        this.chargeWrite = chargeWrite;
        this.search = search;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, ClientsOsgiServiceRegistrar.class);
            if (bundle == null) {
                return;
            }
            final Object context = bundle.getClass().getMethod("getBundleContext").invoke(bundle);
            if (context == null) {
                return;
            }
            register(context, ClientReadPlatformService.class, read.getIfAvailable());
            register(context, ClientWritePlatformService.class, write.getIfAvailable());
            register(context, ClientTemplateReadPlatformService.class, template.getIfAvailable());
            register(context, ClientFamilyMembersReadPlatformService.class, familyRead.getIfAvailable());
            register(context, ClientFamilyMembersWritePlatformService.class, familyWrite.getIfAvailable());
            register(context, ClientIdentifierReadPlatformService.class, idRead.getIfAvailable());
            register(context, ClientIdentifierWritePlatformService.class, idWrite.getIfAvailable());
            register(context, ClientTransactionReadPlatformService.class, txnRead.getIfAvailable());
            register(context, ClientTransactionWritePlatformService.class, txnWrite.getIfAvailable());
            register(context, ClientChargeWritePlatformService.class, chargeWrite.getIfAvailable());
            register(context, ClientSearchService.class, search.getIfAvailable());
            LOG.info("Registered {} client OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only client wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register client OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-clients-impl");
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
