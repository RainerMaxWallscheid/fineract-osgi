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
package org.apache.fineract.portfolio.tax.service;

import java.util.Optional;
import org.apache.fineract.portfolio.tax.domain.TaxComponent;
import org.apache.fineract.portfolio.tax.domain.TaxComponentRepository;
import org.apache.fineract.portfolio.tax.domain.TaxGroup;
import org.apache.fineract.portfolio.tax.domain.TaxGroupRepository;
import org.apache.fineract.portfolio.tax.exception.TaxComponentNotFoundException;
import org.apache.fineract.portfolio.tax.exception.TaxGroupNotFoundException;
import org.apache.fineract.portfolio.tax.moduleapi.TaxCatalogPort;
import org.apache.fineract.portfolio.tax.moduleapi.TaxComponentDefinitionData;
import org.apache.fineract.portfolio.tax.moduleapi.TaxGroupDefinitionData;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Spring/JPA adapter for {@link TaxCatalogPort}.
 */
@Service
@Transactional(readOnly = true)
public class TaxCatalogPortJpaAdapter implements TaxCatalogPort {

    private final TaxGroupRepository taxGroupRepository;
    private final TaxComponentRepository taxComponentRepository;

    public TaxCatalogPortJpaAdapter(final TaxGroupRepository taxGroupRepository,
            final TaxComponentRepository taxComponentRepository) {
        this.taxGroupRepository = taxGroupRepository;
        this.taxComponentRepository = taxComponentRepository;
    }

    @Override
    public Optional<TaxGroupDefinitionData> findTaxGroup(final Long taxGroupId) {
        if (taxGroupId == null) {
            return Optional.empty();
        }
        return taxGroupRepository.findById(taxGroupId).map(TaxCatalogPortJpaAdapter::toGroupData);
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
        return taxComponentRepository.findById(taxComponentId).map(TaxCatalogPortJpaAdapter::toComponentData);
    }

    @Override
    public TaxComponentDefinitionData getTaxComponent(final Long taxComponentId) {
        return findTaxComponent(taxComponentId).orElseThrow(() -> new TaxComponentNotFoundException(taxComponentId));
    }

    static TaxGroupDefinitionData toGroupData(final TaxGroup group) {
        return new TaxGroupDefinitionData(group.getId(), group.getName());
    }

    static TaxComponentDefinitionData toComponentData(final TaxComponent component) {
        final Long creditAccountId = component.getCreditAccount() != null ? component.getCreditAccount().getId() : null;
        final Long debitAccountId = component.getDebitAccount() != null ? component.getDebitAccount().getId() : null;
        return new TaxComponentDefinitionData(component.getId(), component.getName(), component.getPercentage(), creditAccountId,
                debitAccountId);
    }
}
