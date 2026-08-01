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
package org.apache.fineract.portfolio.tax.moduleapi;

import java.io.Serializable;
import java.util.Objects;

/**
 * Stable catalog projection of a tax group for other bounded contexts.
 *
 * <p>Pure Java (no JPA / Spring). Prefer this over navigating the {@code TaxGroup} entity.
 */
public final class TaxGroupDefinitionData implements Serializable {

    private static final long serialVersionUID = 1L;

    private final Long id;
    private final String name;

    public TaxGroupDefinitionData(final Long id, final String name) {
        this.id = id;
        this.name = name;
    }

    public Long getId() {
        return this.id;
    }

    public String getName() {
        return this.name;
    }

    @Override
    public boolean equals(final Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof TaxGroupDefinitionData)) {
            return false;
        }
        final TaxGroupDefinitionData that = (TaxGroupDefinitionData) o;
        return Objects.equals(this.id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }

    @Override
    public String toString() {
        return "TaxGroupDefinitionData{id=" + this.id + ", name='" + this.name + "'}";
    }
}
