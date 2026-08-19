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

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

/**
 * Lazy OSGi→Spring port (ADR-022 B3 / playbook §15.5). Each call resolves the
 * highest-ranked Service Registry entry. Missing Equinox or service uses a
 * no-op. Equinox starts after Spring refresh, so lookup cannot be eager.
 */
public final class OsgiBackedPortFactory {

    private static final String COMMAND_RESULT = "org.apache.fineract.infrastructure.core.data.CommandProcessingResult";

    private OsgiBackedPortFactory() {}

    public static <T> T of(final OsgiServiceLookup lookup, final Class<T> type) {
        return of(lookup, type, empty(type));
    }

    public static <T> T of(final OsgiServiceLookup lookup, final Class<T> type, final T missing) {
        final Object proxy = Proxy.newProxyInstance(type.getClassLoader(), new Class<?>[] { type, OsgiBackedPort.class }, (p, method, args) -> {
            if (method.getDeclaringClass() == Object.class) {
                return objectMethod(p, type, method, args);
            }
            T service = lookup.find(type).orElse(missing);
            if (service instanceof OsgiBackedPort) {
                service = missing;
            }
            try {
                return method.invoke(service, args);
            } catch (final InvocationTargetException ex) {
                final Throwable cause = ex.getCause();
                if (cause instanceof RuntimeException re) {
                    throw re;
                }
                if (cause instanceof Error err) {
                    throw err;
                }
                throw ex;
            }
        });
        return type.cast(proxy);
    }

    public static <T> T empty(final Class<T> type) {
        final Object proxy = Proxy.newProxyInstance(type.getClassLoader(), new Class<?>[] { type }, (p, method, args) -> {
            if (method.getDeclaringClass() == Object.class) {
                return objectMethod(p, type, method, args);
            }
            return defaultValue(method.getReturnType());
        });
        return type.cast(proxy);
    }

    private static Object objectMethod(final Object proxy, final Class<?> type, final Method method, final Object[] args) {
        return switch (method.getName()) {
            case "toString" -> "OsgiBackedPort(" + type.getName() + ")";
            case "hashCode" -> System.identityHashCode(proxy);
            case "equals" -> Boolean.valueOf(proxy == args[0]);
            default -> throw new UnsupportedOperationException(method.getName());
        };
    }

    static Object defaultValue(final Class<?> returnType) {
        if (returnType == void.class || returnType == Void.class) {
            return null;
        }
        if (returnType == boolean.class || returnType == Boolean.class) {
            return Boolean.FALSE;
        }
        if (returnType == char.class || returnType == Character.class) {
            return Character.valueOf('\0');
        }
        if (returnType == byte.class || returnType == Byte.class) {
            return Byte.valueOf((byte) 0);
        }
        if (returnType == short.class || returnType == Short.class) {
            return Short.valueOf((short) 0);
        }
        if (returnType == int.class || returnType == Integer.class) {
            return Integer.valueOf(0);
        }
        if (returnType == long.class || returnType == Long.class) {
            return Long.valueOf(0L);
        }
        if (returnType == float.class || returnType == Float.class) {
            return Float.valueOf(0f);
        }
        if (returnType == double.class || returnType == Double.class) {
            return Double.valueOf(0d);
        }
        if (returnType == Optional.class) {
            return Optional.empty();
        }
        if (returnType == List.class || returnType == Collection.class || returnType == Iterable.class) {
            return List.of();
        }
        if (returnType == Set.class) {
            return Set.of();
        }
        if (returnType == Map.class) {
            return Map.of();
        }
        if (returnType == HashMap.class) {
            return new HashMap<>();
        }
        if (returnType == String.class) {
            return "";
        }
        if (COMMAND_RESULT.equals(returnType.getName())) {
            try {
                return returnType.getMethod("empty").invoke(null);
            } catch (final ReflectiveOperationException ignored) {
                return null;
            }
        }
        return null;
    }
}
