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
import java.util.Collection;
import java.util.Collections;
import java.util.Map;
import java.util.Optional;
import org.apache.fineract.portfolio.floatingrates.data.FloatingRateDTO;
import org.apache.fineract.portfolio.floatingrates.data.FloatingRatePeriodData;
import org.apache.fineract.portfolio.floatingrates.exception.FloatingRateNotFoundException;
import org.apache.fineract.portfolio.floatingrates.moduleapi.FloatingRateDefinitionData;
import org.apache.fineract.portfolio.floatingrates.moduleapi.FloatingRatePort;

/**
 * Composition-root hosted floating-rate catalog for the Equinox bridge smoke.
 * Not JPA.
 */
final class HostedFloatingRatePort implements FloatingRatePort {

    static final long HOSTED_ID = 1L;

    private final FloatingRateDefinitionData hosted = new FloatingRateDefinitionData(HOSTED_ID, "hosted", true, true);
    private final Map<Long, FloatingRateDefinitionData> catalog = Map.of(HOSTED_ID, hosted);

    @Override
    public Optional<FloatingRateDefinitionData> findFloatingRate(final Long floatingRateId) {
        if (floatingRateId == null) {
            return Optional.empty();
        }
        return Optional.ofNullable(catalog.get(floatingRateId));
    }

    @Override
    public Optional<FloatingRateDefinitionData> findBaseLendingRate() {
        return Optional.of(hosted);
    }

    @Override
    public FloatingRateDefinitionData getFloatingRate(final Long floatingRateId) {
        return findFloatingRate(floatingRateId).orElseThrow(() -> new FloatingRateNotFoundException(floatingRateId));
    }

    @Override
    public Collection<FloatingRatePeriodData> fetchInterestRates(final Long floatingRateId, final FloatingRateDTO floatingRateDTO) {
        if (findFloatingRate(floatingRateId).isEmpty()) {
            throw new FloatingRateNotFoundException(floatingRateId);
        }
        return Collections.emptyList();
    }
}
