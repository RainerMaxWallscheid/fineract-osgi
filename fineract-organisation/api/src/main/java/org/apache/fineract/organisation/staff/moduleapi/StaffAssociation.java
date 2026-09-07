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
package org.apache.fineract.organisation.staff.moduleapi;

/**
 * Id / persistable lookup for leftover {@code Staff} without JPA associations on
 * domain entities (ADR-021).
 */
public final class StaffAssociation {

    private static StaffPersistablePort port;

    private StaffAssociation() {}

    public static void setPersistablePort(final StaffPersistablePort port) {
        StaffAssociation.port = port;
    }

    public static Long id(final Object staff) {
        if (staff instanceof Long staffId) {
            return staffId;
        }
        if (port != null) {
            return port.id(staff);
        }
        if (staff == null) {
            return null;
        }
        try {
            final Object id = staff.getClass().getMethod("getId").invoke(staff);
            return id instanceof Long staffId ? staffId : null;
        } catch (final ReflectiveOperationException ignored) {
            return null;
        }
    }

    public static Object persistableById(final Long staffId) {
        return port == null ? null : port.persistableById(staffId);
    }
}
