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
package org.apache.fineract.organisation.office.moduleapi;

/**
 * Id / persistable lookup for leftover {@code Office} without JPA associations on
 * transaction, journal, closure, rule, and teller/cashier entities (ADR-021).
 */
public final class OfficeAssociation {

    private static OfficePersistablePort port;

    private OfficeAssociation() {}

    public static void setPersistablePort(final OfficePersistablePort port) {
        OfficeAssociation.port = port;
    }

    public static Long id(final Object office) {
        if (office instanceof Long officeId) {
            return officeId;
        }
        if (port != null) {
            return port.id(office);
        }
        if (office == null) {
            return null;
        }
        try {
            final Object id = office.getClass().getMethod("getId").invoke(office);
            return id instanceof Long officeId ? officeId : null;
        } catch (final ReflectiveOperationException ignored) {
            return null;
        }
    }

    public static Object persistableById(final Long officeId) {
        return port == null ? null : port.persistableById(officeId);
    }

    public static String name(final Long officeId) {
        return port == null || officeId == null ? null : port.name(officeId);
    }
}
