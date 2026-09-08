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
package org.apache.fineract.portfolio.calendar.moduleapi;

/**
 * Id / persistable lookup for leftover {@code CalendarInstance} without JPA associations
 * on domain entities (ADR-021).
 */
public final class CalendarInstanceAssociation {

    private static CalendarInstancePersistablePort port;

    private CalendarInstanceAssociation() {}

    public static void setPersistablePort(final CalendarInstancePersistablePort port) {
        CalendarInstanceAssociation.port = port;
    }

    public static Long id(final Object calendarInstance) {
        if (calendarInstance instanceof Long calendarInstanceId) {
            return calendarInstanceId;
        }
        if (port != null) {
            return port.id(calendarInstance);
        }
        if (calendarInstance == null) {
            return null;
        }
        try {
            final Object id = calendarInstance.getClass().getMethod("getId").invoke(calendarInstance);
            return id instanceof Long calendarInstanceId ? calendarInstanceId : null;
        } catch (final ReflectiveOperationException ignored) {
            return null;
        }
    }

    public static Object persistableById(final Long calendarInstanceId) {
        return port == null ? null : port.persistableById(calendarInstanceId);
    }
}
