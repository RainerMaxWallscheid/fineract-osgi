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
package org.apache.fineract.portfolio.charge.service;

import java.util.Optional;
import org.apache.fineract.portfolio.charge.domain.Charge;
import org.apache.fineract.portfolio.charge.domain.ChargeRepository;
import org.apache.fineract.portfolio.charge.exception.ChargeIsNotActiveException;
import org.apache.fineract.portfolio.charge.exception.ChargeNotFoundException;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionData;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Spring/JPA adapter for {@link ChargeDefinitionPort}. Maps the catalog aggregate to pure Module API data.
 */
@Service
@Transactional(readOnly = true)
public class ChargeDefinitionPortJpaAdapter implements ChargeDefinitionPort {

    private final ChargeRepository chargeRepository;

    public ChargeDefinitionPortJpaAdapter(final ChargeRepository chargeRepository) {
        this.chargeRepository = chargeRepository;
    }

    @Override
    public boolean existsActiveCharge(final Long chargeId) {
        return findActiveCharge(chargeId).isPresent();
    }

    @Override
    public Optional<ChargeDefinitionData> findActiveCharge(final Long chargeId) {
        return findNonDeleted(chargeId).filter(Charge::isActive).map(ChargeDefinitionPortJpaAdapter::toData);
    }

    @Override
    public Optional<ChargeDefinitionData> findCharge(final Long chargeId) {
        return findNonDeleted(chargeId).map(ChargeDefinitionPortJpaAdapter::toData);
    }

    @Override
    public ChargeDefinitionData getActiveCharge(final Long chargeId) {
        final Charge charge = findNonDeleted(chargeId).orElseThrow(() -> new ChargeNotFoundException(chargeId));
        if (!charge.isActive()) {
            throw new ChargeIsNotActiveException(chargeId, charge.getName());
        }
        return toData(charge);
    }

    private Optional<Charge> findNonDeleted(final Long chargeId) {
        if (chargeId == null) {
            return Optional.empty();
        }
        return chargeRepository.findById(chargeId).filter(c -> !c.isDeleted());
    }

    static ChargeDefinitionData toData(final Charge charge) {
        return charge.toDefinitionData();
    }
}
