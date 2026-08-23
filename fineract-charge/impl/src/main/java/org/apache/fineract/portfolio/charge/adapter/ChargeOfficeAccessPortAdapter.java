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
package org.apache.fineract.portfolio.charge.adapter;

import org.apache.fineract.infrastructure.entityaccess.domain.FineractEntityAccessType;
import org.apache.fineract.infrastructure.entityaccess.domain.FineractEntityType;
import org.apache.fineract.infrastructure.entityaccess.service.OfficeProductRestrictionService;
import org.apache.fineract.portfolio.charge.service.ChargeOfficeAccessPort;
import org.springframework.stereotype.Component;

/**
 * Bridges charge-impl office-access port to entity-access {@link OfficeProductRestrictionService}.
 */
@Component
public class ChargeOfficeAccessPortAdapter implements ChargeOfficeAccessPort {

    private final OfficeProductRestrictionService officeProductRestrictionService;

    public ChargeOfficeAccessPortAdapter(final OfficeProductRestrictionService officeProductRestrictionService) {
        this.officeProductRestrictionService = officeProductRestrictionService;
    }

    @Override
    public String chargeIdsInClauseForCurrentUserOfficeIfEnabled() {
        return this.officeProductRestrictionService
                .getSQLWhereClauseForProductIDsForUserOffice_ifGlobalConfigEnabled(FineractEntityType.CHARGE);
    }

    @Override
    public void restrictNewChargeToCurrentUserOfficeIfEnabled(final Long chargeId) {
        this.officeProductRestrictionService.checkConfigurationAndAddProductResrictionsForUserOffice(
                FineractEntityAccessType.OFFICE_ACCESS_TO_CHARGES, chargeId);
    }
}
