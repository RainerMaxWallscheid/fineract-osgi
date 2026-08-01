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

import java.util.Collection;
import java.util.Optional;
import org.apache.fineract.portfolio.floatingrates.data.FloatingRateDTO;
import org.apache.fineract.portfolio.floatingrates.data.FloatingRatePeriodData;

/**
 * Module API port for the Floating Rates catalog.
 *
 * <p>Other modules (Loan product assembly, schedule generation, …) should depend on this port
 * instead of {@code FloatingRate} JPA entities or repositories. Implementation lives in rates-impl.
 *
 * @see docs/arc42/15_osgi_bundle_refactoring_fineract-rates.md
 */
public interface FloatingRatePort {

    /**
     * @param floatingRateId catalog floating rate id
     * @return definition data, or empty when missing
     */
    Optional<FloatingRateDefinitionData> findFloatingRate(Long floatingRateId);

    /**
     * Active base lending rate, if configured.
     */
    Optional<FloatingRateDefinitionData> findBaseLendingRate();

    /**
     * Same as {@link #findFloatingRate(Long)} but throws when missing.
     *
     * @throws org.apache.fineract.portfolio.floatingrates.exception.FloatingRateNotFoundException when missing
     */
    FloatingRateDefinitionData getFloatingRate(Long floatingRateId);

    /**
     * Applicable interest periods for a loan product linked to this floating rate (includes product differential
     * already applied via {@link FloatingRateDTO#addInterestRateDiff}).
     */
    Collection<FloatingRatePeriodData> fetchInterestRates(Long floatingRateId, FloatingRateDTO floatingRateDTO);
}
