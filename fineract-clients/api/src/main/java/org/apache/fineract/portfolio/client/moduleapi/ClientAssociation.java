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
package org.apache.fineract.portfolio.client.moduleapi;

/**
 * Id / persistable lookup for leftover {@code Client} without JPA associations on
 * domain entities (ADR-021).
 */
public final class ClientAssociation {

    private static ClientActivePort port;

    private ClientAssociation() {}

    public static void setActivePort(final ClientActivePort port) {
        ClientAssociation.port = port;
    }

    public static Long id(final Object client) {
        if (client instanceof Long clientId) {
            return clientId;
        }
        if (port != null) {
            return port.id(client);
        }
        if (client == null) {
            return null;
        }
        try {
            final Object id = client.getClass().getMethod("getId").invoke(client);
            return id instanceof Long clientId ? clientId : null;
        } catch (final ReflectiveOperationException ignored) {
            return null;
        }
    }

    public static Object persistableById(final Long clientId) {
        return port == null ? null : port.persistableById(clientId);
    }

    public static Long officeId(final Long clientId) {
        return port == null || clientId == null ? null : port.officeId(clientId);
    }

    public static String displayName(final Long clientId) {
        return port == null || clientId == null ? null : port.displayName(clientId);
    }
}
