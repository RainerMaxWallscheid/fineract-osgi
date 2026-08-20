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
package org.apache.fineract.portfolio.savings.service;

import java.math.BigDecimal;
import java.util.Collection;
import org.apache.fineract.portfolio.savings.data.GroupSavingsIndividualMonitoringAccountData;
import org.apache.fineract.portfolio.savings.domain.SavingsAccount;
import org.apache.fineract.portfolio.savings.domain.SavingsAccountRepositoryWrapper;
import org.apache.fineract.portfolio.savings.moduleapi.LinkedSavingsAccountPort;
import org.apache.fineract.portfolio.savings.moduleapi.LinkedSavingsAccountView;
import org.springframework.stereotype.Service;

@Service
public class LinkedSavingsAccountPortAdapter implements LinkedSavingsAccountPort {

    private final SavingsAccountRepositoryWrapper savingsAccountRepository;
    private final GSIMReadPlatformService gsimReadPlatformService;

    public LinkedSavingsAccountPortAdapter(final SavingsAccountRepositoryWrapper savingsAccountRepository,
            final GSIMReadPlatformService gsimReadPlatformService) {
        this.savingsAccountRepository = savingsAccountRepository;
        this.gsimReadPlatformService = gsimReadPlatformService;
    }

    @Override
    public LinkedSavingsAccountView requireById(final Long savingsAccountId) {
        final SavingsAccount savingsAccount = savingsAccountRepository.findOneWithNotFoundDetection(savingsAccountId);
        return new LinkedSavingsAccountView(savingsAccount.getId(), savingsAccount.clientId(), !savingsAccount.isNotActive(),
                savingsAccount.getActivationDate());
    }

    @Override
    public Object persistableById(final Long savingsAccountId) {
        return this.savingsAccountRepository.findOneWithNotFoundDetection(savingsAccountId);
    }

    @Override
    public Long childAccountIdForGsimClient(final Long gsimAccountId, final Long clientId) {
        if (gsimAccountId == null || clientId == null) {
            return null;
        }
        final Collection<GroupSavingsIndividualMonitoringAccountData> childSavings = this.gsimReadPlatformService
                .findGSIMAccountsByGSIMId(gsimAccountId);
        final BigDecimal clientIdValue = BigDecimal.valueOf(clientId);
        for (final GroupSavingsIndividualMonitoringAccountData childSaving : childSavings) {
            if (clientIdValue.equals(childSaving.getClientId()) && childSaving.getChildAccountId() != null) {
                return childSaving.getChildAccountId().longValue();
            }
        }
        return null;
    }
}
