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
package org.apache.fineract.portfolio.charge.impl.osgi;

import java.util.Optional;
import org.apache.fineract.portfolio.charge.exception.ChargeNotFoundException;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionData;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort;

/**
 * Empty catalog for Equinox without Spring/JPA. Same outcome as a
 * repository that finds no non-deleted charges.
 */
final class OsgiChargeDefinitionPort implements ChargeDefinitionPort {

    @Override
    public boolean existsActiveCharge(final Long chargeId) {
        return false;
    }

    @Override
    public Optional<ChargeDefinitionData> findActiveCharge(final Long chargeId) {
        return Optional.empty();
    }

    @Override
    public Optional<ChargeDefinitionData> findCharge(final Long chargeId) {
        return Optional.empty();
    }

    @Override
    public ChargeDefinitionData getActiveCharge(final Long chargeId) {
        throw new ChargeNotFoundException(chargeId);
    }
}
