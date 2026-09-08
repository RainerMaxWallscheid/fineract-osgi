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
package org.apache.fineract.organisation.monetary.moduleapi;

/**
 * Id / persistable lookup for leftover {@code ApplicationCurrency} without JPA associations
 * on domain entities (ADR-021).
 */
public final class ApplicationCurrencyAssociation {

    private static ApplicationCurrencyPersistablePort port;

    private ApplicationCurrencyAssociation() {}

    public static void setPersistablePort(final ApplicationCurrencyPersistablePort port) {
        ApplicationCurrencyAssociation.port = port;
    }

    public static Long id(final Object applicationCurrency) {
        if (applicationCurrency instanceof Long applicationCurrencyId) {
            return applicationCurrencyId;
        }
        if (port != null) {
            return port.id(applicationCurrency);
        }
        if (applicationCurrency == null) {
            return null;
        }
        try {
            final Object id = applicationCurrency.getClass().getMethod("getId").invoke(applicationCurrency);
            return id instanceof Long applicationCurrencyId ? applicationCurrencyId : null;
        } catch (final ReflectiveOperationException ignored) {
            return null;
        }
    }

    public static Object persistableById(final Long applicationCurrencyId) {
        return port == null ? null : port.persistableById(applicationCurrencyId);
    }
}
