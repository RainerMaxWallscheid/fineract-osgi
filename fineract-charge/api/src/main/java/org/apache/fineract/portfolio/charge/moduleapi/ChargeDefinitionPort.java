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
package org.apache.fineract.portfolio.charge.moduleapi;

import java.util.Optional;

/**
 * Module API port for the Charge Catalog (fee <em>definitions</em>).
 *
 * <p>
 * Other modules (Loan, Savings, Accounting, Investor, …) must depend on this port instead of
 * {@code org.apache.fineract.portfolio.charge.domain.Charge} or charge repositories.
 * Implementation lives in {@code fineract-charge} (and later {@code charge-impl}) and is wired by Spring /
 * OSGi Service Registry ([ADR-021](docs/arc42/decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md),
 * [charge plan](docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md)).
 * </p>
 */
public interface ChargeDefinitionPort {

    /**
     * @param chargeId catalog charge id
     * @return true if a non-deleted, active charge definition with this id exists
     */
    boolean existsActiveCharge(Long chargeId);

    /**
     * Active catalog charge, if present and not deleted.
     *
     * @param chargeId catalog charge id
     * @return definition data, or empty when missing, deleted, or inactive
     */
    Optional<ChargeDefinitionData> findActiveCharge(Long chargeId);

    /**
     * Catalog charge that is not soft-deleted (may be inactive).
     *
     * @param chargeId catalog charge id
     * @return definition data, or empty when missing or deleted
     */
    Optional<ChargeDefinitionData> findCharge(Long chargeId);

    /**
     * Same as {@link #findActiveCharge(Long)} but throws when not found / inactive / deleted.
     *
     * @param chargeId catalog charge id
     * @return active definition
     * @throws org.apache.fineract.portfolio.charge.exception.ChargeNotFoundException when missing or deleted
     * @throws org.apache.fineract.portfolio.charge.exception.ChargeIsNotActiveException when inactive
     */
    ChargeDefinitionData getActiveCharge(Long chargeId);
}
