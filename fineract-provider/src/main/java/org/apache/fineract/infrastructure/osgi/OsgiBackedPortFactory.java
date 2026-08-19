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

import java.lang.reflect.Proxy;

/**
 * Lazy OSGi→Spring port (ADR-022 B3 / playbook §15.5). Each call resolves the
 * highest-ranked Service Registry entry. Missing Equinox or service uses
 * {@code missing} (no-op). Equinox starts after Spring refresh, so lookup
 * cannot be eager.
 */
public final class OsgiBackedPortFactory {

    private OsgiBackedPortFactory() {}

    public static <T> T of(final OsgiServiceLookup lookup, final Class<T> type, final T missing) {
        final Object proxy = Proxy.newProxyInstance(type.getClassLoader(), new Class<?>[] { type, OsgiBackedPort.class }, (p, method, args) -> {
            if (method.getDeclaringClass() == Object.class) {
                return switch (method.getName()) {
                    case "toString" -> "OsgiBackedPort(" + type.getName() + ")";
                    case "hashCode" -> System.identityHashCode(p);
                    case "equals" -> Boolean.valueOf(p == args[0]);
                    default -> throw new UnsupportedOperationException(method.getName());
                };
            }
            T service = lookup.find(type).orElse(missing);
            if (service instanceof OsgiBackedPort) {
                service = missing;
            }
            return method.invoke(service, args);
        });
        return type.cast(proxy);
    }
}
