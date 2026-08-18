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
package org.apache.fineract.infrastructure.entityaccess.impl.osgi;

import java.util.Collection;
import java.util.List;
import org.apache.fineract.infrastructure.entityaccess.data.FineractEntityRelationData;
import org.apache.fineract.infrastructure.entityaccess.data.FineractEntityToEntityMappingData;
import org.apache.fineract.infrastructure.entityaccess.domain.FineractEntityType;
import org.apache.fineract.infrastructure.entityaccess.service.FineractEntityAccessReadService;

/**
 * Empty entity-access read port for Equinox without Spring/JPA.
 */
final class OsgiFineractEntityAccessReadService implements FineractEntityAccessReadService {

    @Override
    public Collection<FineractEntityToEntityMappingData> retrieveEntityAccessFor(final FineractEntityType firstEntityType, final Long relId,
            final Long fromEntityId, final boolean includeAllSubOffices) {
        return List.of();
    }

    @Override
    public String getSQLQueryInClause_WithListOfIDsForEntityAccess(final FineractEntityType firstEntityType, final Long relId,
            final Long fromEntityId, final boolean includeAllOffices) {
        return "";
    }

    @Override
    public String getSQLQueryInClauseIDList_ForLoanProductsForOffice(final Long loanProductId, final boolean includeAllOffices) {
        return "";
    }

    @Override
    public String getSQLQueryInClauseIDList_ForSavingsProductsForOffice(final Long savingsProductId, final boolean includeAllOffices) {
        return "";
    }

    @Override
    public String getSQLQueryInClauseIDList_ForChargesForOffice(final Long officeId, final boolean includeAllOffices) {
        return "";
    }

    @Override
    public String getSQLWhereClauseForProductIDsForUserOffice_ifGlobalConfigEnabled(final FineractEntityType fineractEntityType) {
        return "";
    }

    @Override
    public Collection<FineractEntityRelationData> retrieveAllSupportedMappingTypes() {
        return List.of();
    }

    @Override
    public Collection<FineractEntityToEntityMappingData> retrieveOneMapping(final Long mapId) {
        return List.of();
    }

    @Override
    public Collection<FineractEntityToEntityMappingData> retrieveEntityToEntityMappings(final Long mapId, final Long fromoId,
            final Long toId) {
        return List.of();
    }
}
