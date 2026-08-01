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
package org.apache.fineract.portfolio.floatingrates.service;

import java.util.Collection;
import java.util.Collections;
import java.util.Optional;
import org.apache.fineract.portfolio.floatingrates.data.FloatingRateDTO;
import org.apache.fineract.portfolio.floatingrates.data.FloatingRatePeriodData;
import org.apache.fineract.portfolio.floatingrates.domain.FloatingRate;
import org.apache.fineract.portfolio.floatingrates.domain.FloatingRateRepository;
import org.apache.fineract.portfolio.floatingrates.exception.FloatingRateNotFoundException;
import org.apache.fineract.portfolio.floatingrates.moduleapi.FloatingRateDefinitionData;
import org.apache.fineract.portfolio.floatingrates.moduleapi.FloatingRatePort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Spring/JPA adapter for {@link FloatingRatePort}.
 */
@Service
@Transactional(readOnly = true)
public class FloatingRatePortJpaAdapter implements FloatingRatePort {

    private final FloatingRateRepository floatingRateRepository;

    public FloatingRatePortJpaAdapter(final FloatingRateRepository floatingRateRepository) {
        this.floatingRateRepository = floatingRateRepository;
    }

    @Override
    public Optional<FloatingRateDefinitionData> findFloatingRate(final Long floatingRateId) {
        if (floatingRateId == null) {
            return Optional.empty();
        }
        return floatingRateRepository.findById(floatingRateId).map(FloatingRatePortJpaAdapter::toData);
    }

    @Override
    public Optional<FloatingRateDefinitionData> findBaseLendingRate() {
        final FloatingRate rate = floatingRateRepository.retrieveBaseLendingRate();
        return Optional.ofNullable(rate).map(FloatingRatePortJpaAdapter::toData);
    }

    @Override
    public FloatingRateDefinitionData getFloatingRate(final Long floatingRateId) {
        return findFloatingRate(floatingRateId).orElseThrow(() -> new FloatingRateNotFoundException(floatingRateId));
    }

    @Override
    public Collection<FloatingRatePeriodData> fetchInterestRates(final Long floatingRateId, final FloatingRateDTO floatingRateDTO) {
        if (floatingRateId == null || floatingRateDTO == null) {
            return Collections.emptyList();
        }
        final FloatingRate rate = floatingRateRepository.findById(floatingRateId)
                .orElseThrow(() -> new FloatingRateNotFoundException(floatingRateId));
        return rate.fetchInterestRates(floatingRateDTO);
    }

    static FloatingRateDefinitionData toData(final FloatingRate rate) {
        return new FloatingRateDefinitionData(rate.getId(), rate.getName(), rate.isBaseLendingRate(), rate.isActive());
    }
}
