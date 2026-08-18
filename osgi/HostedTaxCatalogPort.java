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
import java.math.BigDecimal;
import java.util.Map;
import java.util.Optional;
import org.apache.fineract.portfolio.tax.exception.TaxComponentNotFoundException;
import org.apache.fineract.portfolio.tax.exception.TaxGroupNotFoundException;
import org.apache.fineract.portfolio.tax.moduleapi.TaxCatalogPort;
import org.apache.fineract.portfolio.tax.moduleapi.TaxComponentDefinitionData;
import org.apache.fineract.portfolio.tax.moduleapi.TaxGroupDefinitionData;

/**
 * Composition-root hosted tax catalog for the Equinox bridge smoke. Not JPA.
 */
final class HostedTaxCatalogPort implements TaxCatalogPort {

    static final long HOSTED_ID = 1L;

    private final Map<Long, TaxGroupDefinitionData> groups = Map.of(HOSTED_ID, new TaxGroupDefinitionData(HOSTED_ID, "hosted"));
    private final Map<Long, TaxComponentDefinitionData> components = Map.of(HOSTED_ID,
            new TaxComponentDefinitionData(HOSTED_ID, "hosted", BigDecimal.TEN));

    @Override
    public Optional<TaxGroupDefinitionData> findTaxGroup(final Long taxGroupId) {
        if (taxGroupId == null) {
            return Optional.empty();
        }
        return Optional.ofNullable(groups.get(taxGroupId));
    }

    @Override
    public TaxGroupDefinitionData getTaxGroup(final Long taxGroupId) {
        return findTaxGroup(taxGroupId).orElseThrow(() -> new TaxGroupNotFoundException(taxGroupId));
    }

    @Override
    public Optional<TaxComponentDefinitionData> findTaxComponent(final Long taxComponentId) {
        if (taxComponentId == null) {
            return Optional.empty();
        }
        return Optional.ofNullable(components.get(taxComponentId));
    }

    @Override
    public TaxComponentDefinitionData getTaxComponent(final Long taxComponentId) {
        return findTaxComponent(taxComponentId).orElseThrow(() -> new TaxComponentNotFoundException(taxComponentId));
    }
}
