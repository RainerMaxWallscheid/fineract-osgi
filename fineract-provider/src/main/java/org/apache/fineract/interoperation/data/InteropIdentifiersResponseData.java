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
package org.apache.fineract.interoperation.data;

import jakarta.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.apache.fineract.interoperation.domain.InteropIdentifier;
import org.apache.fineract.portfolio.savings.domain.SavingsAccount;

/**
 * Account identifiers list response. Composes command-result identifiers instead of
 * extending {@code CommandProcessingResult}.
 */
public final class InteropIdentifiersResponseData {

    private final Long resourceId;
    private final Long officeId;
    private final Long commandId;
    private final Map<String, Object> changes;

    @NotNull
    private final List<InteropIdentifierData> identifiers;

    private InteropIdentifiersResponseData(Long resourceId, Long officeId, Long commandId, Map<String, Object> changesOnly,
            @NotNull List<InteropIdentifierData> identifiers) {
        this.resourceId = resourceId;
        this.officeId = officeId;
        this.commandId = commandId;
        this.changes = changesOnly;
        this.identifiers = identifiers;
    }

    private InteropIdentifiersResponseData(@NotNull List<InteropIdentifierData> identifiers) {
        this(null, null, null, null, identifiers);
    }

    public static InteropIdentifiersResponseData build(SavingsAccount account) {
        List<InteropIdentifierData> result = new ArrayList<>();
        if (account != null) {
            for (InteropIdentifier identifier : account.getIdentifiers()) {
                result.add(InteropIdentifierData.build(identifier));
            }
        }
        return new InteropIdentifiersResponseData(result);
    }

    public Long getResourceId() {
        return resourceId;
    }

    public Long getOfficeId() {
        return officeId;
    }

    public Long getCommandId() {
        return commandId;
    }

    public Map<String, Object> getChanges() {
        return changes;
    }

    @NotNull
    public List<InteropIdentifierData> getIdentifiers() {
        return identifiers;
    }
}
