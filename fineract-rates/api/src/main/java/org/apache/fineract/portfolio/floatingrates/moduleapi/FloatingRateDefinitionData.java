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
package org.apache.fineract.portfolio.floatingrates.moduleapi;

import java.io.Serializable;
import java.util.Objects;

/**
 * Stable catalog projection of a floating rate definition for other bounded contexts.
 *
 * <p>Pure Java (no JPA / Spring). Prefer this over navigating the {@code FloatingRate} entity.
 */
public final class FloatingRateDefinitionData implements Serializable {

    private static final long serialVersionUID = 1L;

    private final Long id;
    private final String name;
    private final boolean baseLendingRate;
    private final boolean active;

    public FloatingRateDefinitionData(final Long id, final String name, final boolean baseLendingRate, final boolean active) {
        this.id = id;
        this.name = name;
        this.baseLendingRate = baseLendingRate;
        this.active = active;
    }

    public Long getId() {
        return this.id;
    }

    public String getName() {
        return this.name;
    }

    public boolean isBaseLendingRate() {
        return this.baseLendingRate;
    }

    public boolean isActive() {
        return this.active;
    }

    @Override
    public boolean equals(final Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof FloatingRateDefinitionData)) {
            return false;
        }
        final FloatingRateDefinitionData that = (FloatingRateDefinitionData) o;
        return Objects.equals(this.id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }

    @Override
    public String toString() {
        return "FloatingRateDefinitionData{id=" + this.id + ", name='" + this.name + "'}";
    }
}
