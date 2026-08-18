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
import java.util.List;
import org.apache.fineract.infrastructure.entityaccess.data.FineractEntityRelationData;
import org.apache.fineract.infrastructure.entityaccess.data.FineractEntityToEntityMappingData;
import org.apache.fineract.infrastructure.entityaccess.domain.FineractEntityType;
import org.apache.fineract.infrastructure.entityaccess.service.FineractEntityAccessReadService;

/** Composition-root hosted entity-access catalog for the Equinox bridge smoke. */
final class HostedFineractEntityAccessReadService implements FineractEntityAccessReadService {

    static final long HOSTED_ID = 1L;
    static final String HOSTED_SQL = "(1)";

    private final FineractEntityToEntityMappingData hosted = FineractEntityToEntityMappingData.getRelatedEntities(HOSTED_ID, HOSTED_ID,
            HOSTED_ID, HOSTED_ID, null, null, "hosted", "hosted");

    @Override
    public Collection<FineractEntityToEntityMappingData> retrieveEntityAccessFor(final FineractEntityType firstEntityType,
            final Long relId, final Long fromEntityId, final boolean includeAllOffices) {
        return List.of(hosted);
    }

    @Override
    public String getSQLQueryInClause_WithListOfIDsForEntityAccess(final FineractEntityType firstEntityType, final Long relId,
            final Long fromEntityId, final boolean includeAllOffices) {
        return HOSTED_SQL;
    }

    @Override
    public String getSQLQueryInClauseIDList_ForLoanProductsForOffice(final Long officeId, final boolean includeAllOffices) {
        return HOSTED_SQL;
    }

    @Override
    public String getSQLQueryInClauseIDList_ForSavingsProductsForOffice(final Long officeId, final boolean includeAllOffices) {
        return HOSTED_SQL;
    }

    @Override
    public String getSQLQueryInClauseIDList_ForChargesForOffice(final Long officeId, final boolean includeAllOffices) {
        return HOSTED_SQL;
    }

    @Override
    public String getSQLWhereClauseForProductIDsForUserOffice_ifGlobalConfigEnabled(final FineractEntityType fineractEntityType) {
        return HOSTED_SQL;
    }

    @Override
    public Collection<FineractEntityRelationData> retrieveAllSupportedMappingTypes() {
        return List.of(FineractEntityRelationData.getMappingTypes(HOSTED_ID, "hosted"));
    }

    @Override
    public Collection<FineractEntityToEntityMappingData> retrieveOneMapping(final Long mapId) {
        return Long.valueOf(HOSTED_ID).equals(mapId) ? List.of(hosted) : List.of();
    }

    @Override
    public Collection<FineractEntityToEntityMappingData> retrieveEntityToEntityMappings(final Long mapId, final Long fromId,
            final Long toId) {
        return List.of(hosted);
    }
}
