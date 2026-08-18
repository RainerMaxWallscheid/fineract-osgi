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
package org.apache.fineract.infrastructure.document.impl.osgi;

import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.infrastructure.contentstore.moduleapi.ContentStreamPort;
import org.apache.fineract.infrastructure.contentstore.service.ContentStoreService;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceRegistration;

/**
 * Equinox start path for document / content-store ports (ADR-022 B3). Registers
 * {@link ContentStoreService} and {@link ContentStreamPort} without Spring/FS/S3.
 * Lowest {@code service.ranking} so a composition-root hosted store wins.
 * {@link DocumentOsgiServiceRegistrar} remains the Spring Boot path.
 */
public class DocumentOsgiBundleActivator implements BundleActivator {

    private final List<ServiceRegistration<?>> registrations = new ArrayList<>();

    @Override
    public void start(final BundleContext context) {
        register(context, ContentStoreService.class, new OsgiContentStoreService());
        register(context, ContentStreamPort.class, new OsgiContentStreamPort());
    }

    @Override
    public void stop(final BundleContext context) {
        for (ServiceRegistration<?> registration : registrations) {
            try {
                registration.unregister();
            } catch (final IllegalStateException ignored) {
                // already unregistered
            }
        }
        registrations.clear();
    }

    private <T> void register(final BundleContext context, final Class<T> type, final T service) {
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-document-impl");
        props.put(Constants.SERVICE_RANKING, Integer.MIN_VALUE);
        registrations.add(context.registerService(type, service, props));
    }
}
