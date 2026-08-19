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
package org.apache.fineract.infrastructure.osgi;

import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.osgi.framework.BundleContext;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceRegistration;

/**
 * Spring→OSGi registration of Boot-owned Wave-1 through Wave-4 catalog ports
 * (ADR-022 B3 / playbook §15.5). Ranks above empty catalog activators.
 * Spring 6 is not staged as Equinox bundles.
 */
public final class SpringOsgiPortBridge {

    public static final String PROVIDER = "fineract-osgi-bridge";
    public static final int RANKING = 1;

    public static final class Binding<T> {

        private final Class<T> type;
        private final T service;

        Binding(final Class<T> type, final T service) {
            this.type = type;
            this.service = service;
        }
    }

    public static <T> Binding<T> bind(final Class<T> type, final T service) {
        return new Binding<>(type, service);
    }

    private final List<Binding<?>> bindings;
    private final List<ServiceRegistration<?>> registrations = new ArrayList<>();

    public SpringOsgiPortBridge(final List<Binding<?>> bindings) {
        this.bindings = List.copyOf(bindings);
    }

    public void start(final BundleContext context) {
        for (final Binding<?> binding : bindings) {
            register(context, binding);
        }
    }

    private <T> void register(final BundleContext context, final Binding<T> binding) {
        if (binding.service == null) {
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", PROVIDER);
        props.put(Constants.SERVICE_RANKING, RANKING);
        registrations.add(context.registerService(binding.type, binding.service, props));
    }

    public void stop() {
        for (int i = registrations.size() - 1; i >= 0; i--) {
            try {
                registrations.get(i).unregister();
            } catch (final IllegalStateException ignored) {
                // already unregistered
            }
        }
        registrations.clear();
    }
}
