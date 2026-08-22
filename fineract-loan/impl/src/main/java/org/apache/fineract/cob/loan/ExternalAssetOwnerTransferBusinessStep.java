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
package org.apache.fineract.cob.loan;

import org.apache.fineract.investor.moduleapi.ExternalAssetOwnerTransferCobPort;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.stereotype.Component;

@Component
@ConditionalOnBean(ExternalAssetOwnerTransferCobPort.class)
public class ExternalAssetOwnerTransferBusinessStep implements LoanCOBBusinessStep {

    private final ExternalAssetOwnerTransferCobPort externalAssetOwnerTransferCobPort;

    @Override
    public Loan execute(Loan loan) {
        this.externalAssetOwnerTransferCobPort.execute(loan);
        return loan;
    }

    @Override
    public String getEnumStyledName() {
        return "EXTERNAL_ASSET_OWNER_TRANSFER";
    }

    @Override
    public String getHumanReadableName() {
        return "Execute external asset owner transfer";
    }

    public ExternalAssetOwnerTransferBusinessStep(final ExternalAssetOwnerTransferCobPort externalAssetOwnerTransferCobPort) {
        this.externalAssetOwnerTransferCobPort = externalAssetOwnerTransferCobPort;
    }
}
