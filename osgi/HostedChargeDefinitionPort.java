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
import org.apache.fineract.portfolio.charge.exception.ChargeNotFoundException;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionData;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort;

/**
 * Composition-root hosted charge catalog for the Equinox bridge smoke.
 * Not JPA — {@code ChargeDefinitionPortJpaAdapter} stays on the Boot classpath.
 */
final class HostedChargeDefinitionPort implements ChargeDefinitionPort {

    static final long HOSTED_ID = 1L;

    private final Map<Long, ChargeDefinitionData> catalog = Map.of(HOSTED_ID,
            new ChargeDefinitionData(HOSTED_ID, "hosted", BigDecimal.ONE, "USD", 1, 1, 1, 1, false, true, null, null, null, null, null,
                    null));

    @Override
    public boolean existsActiveCharge(final Long chargeId) {
        return findActiveCharge(chargeId).isPresent();
    }

    @Override
    public Optional<ChargeDefinitionData> findActiveCharge(final Long chargeId) {
        return findCharge(chargeId).filter(ChargeDefinitionData::isActive);
    }

    @Override
    public Optional<ChargeDefinitionData> findCharge(final Long chargeId) {
        if (chargeId == null) {
            return Optional.empty();
        }
        return Optional.ofNullable(catalog.get(chargeId));
    }

    @Override
    public ChargeDefinitionData getActiveCharge(final Long chargeId) {
        return findActiveCharge(chargeId).orElseThrow(() -> new ChargeNotFoundException(chargeId));
    }
}
