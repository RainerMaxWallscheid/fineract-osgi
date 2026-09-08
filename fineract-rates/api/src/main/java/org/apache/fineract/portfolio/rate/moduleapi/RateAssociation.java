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
package org.apache.fineract.portfolio.rate.moduleapi;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * Id / persistable lookup for leftover {@code Rate} without JPA associations
 * on domain entities (ADR-021).
 */
public final class RateAssociation {

    private static RatePersistablePort port;

    private RateAssociation() {}

    public static void setPersistablePort(final RatePersistablePort port) {
        RateAssociation.port = port;
    }

    public static Long id(final Object rate) {
        if (rate instanceof Long rateId) {
            return rateId;
        }
        if (port != null) {
            return port.id(rate);
        }
        if (rate == null) {
            return null;
        }
        try {
            final Object id = rate.getClass().getMethod("getId").invoke(rate);
            return id instanceof Long rateId ? rateId : null;
        } catch (final ReflectiveOperationException ignored) {
            return null;
        }
    }

    public static List<Long> ids(final Collection<?> rates) {
        if (rates == null) {
            return null;
        }
        final List<Long> ids = new ArrayList<>(rates.size());
        for (final Object rate : rates) {
            ids.add(id(rate));
        }
        return ids;
    }

    public static Object persistableById(final Long rateId) {
        return port == null ? null : port.persistableById(rateId);
    }
}
