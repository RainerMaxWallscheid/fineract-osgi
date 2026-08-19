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

import java.util.Optional;
import java.util.function.Supplier;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;

/**
 * OSGi→Spring lookup (ADR-022 B3 / playbook §15.5). Resolves the highest-ranked
 * Service Registry entry. Missing Equinox, missing service, or a stopped
 * framework yields empty — never fails Boot.
 */
public final class OsgiServiceLookup {

    private final Supplier<BundleContext> context;

    public OsgiServiceLookup(final Supplier<BundleContext> context) {
        this.context = context;
    }

    public <T> Optional<T> find(final Class<T> type) {
        final BundleContext ctx;
        try {
            ctx = context.get();
        } catch (final RuntimeException ignored) {
            return Optional.empty();
        }
        if (ctx == null) {
            return Optional.empty();
        }
        try {
            final ServiceReference<T> ref = ctx.getServiceReference(type);
            if (ref == null) {
                return Optional.empty();
            }
            final T service = ctx.getService(ref);
            if (service != null) {
                ctx.ungetService(ref);
            }
            return Optional.ofNullable(service);
        } catch (final IllegalStateException ignored) {
            return Optional.empty();
        }
    }
}
