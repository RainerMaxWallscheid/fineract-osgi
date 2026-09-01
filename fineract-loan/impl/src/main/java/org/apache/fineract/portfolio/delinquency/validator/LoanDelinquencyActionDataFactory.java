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
package org.apache.fineract.portfolio.delinquency.validator;

import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.portfolio.delinquency.domain.LoanDelinquencyAction;

public final class LoanDelinquencyActionDataFactory {

    private LoanDelinquencyActionDataFactory() {}

    public static LoanDelinquencyActionData from(LoanDelinquencyAction loanDelinquencyAction) {
        LoanDelinquencyActionData data = new LoanDelinquencyActionData();
        data.setId(loanDelinquencyAction.getId());
        data.setAction(loanDelinquencyAction.getAction());
        data.setStartDate(loanDelinquencyAction.getStartDate());
        data.setEndDate(loanDelinquencyAction.getEndDate());
        loanDelinquencyAction.getCreatedBy().ifPresent(data::setCreatedById);
        loanDelinquencyAction.getLastModifiedBy().ifPresent(data::setUpdatedById);
        data.setCreatedOn(loanDelinquencyAction.getCreatedDate().orElse(DateUtils.getAuditOffsetDateTime()));
        data.setLastModifiedOn(loanDelinquencyAction.getLastModifiedDate().orElse(DateUtils.getAuditOffsetDateTime()));
        return data;
    }
}
