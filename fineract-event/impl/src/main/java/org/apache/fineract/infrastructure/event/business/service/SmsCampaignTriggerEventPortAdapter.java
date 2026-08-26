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
package org.apache.fineract.infrastructure.event.business.service;

import java.util.function.Consumer;
import org.apache.fineract.infrastructure.event.business.domain.client.ClientActivateBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.client.ClientRejectBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.savings.SavingsActivateBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.savings.SavingsRejectBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.savings.transaction.SavingsDepositBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.savings.transaction.SavingsWithdrawalBusinessEvent;
import org.apache.fineract.infrastructure.event.business.moduleapi.SmsCampaignTriggerEventPort;
import org.springframework.stereotype.Service;

@Service
public class SmsCampaignTriggerEventPortAdapter implements SmsCampaignTriggerEventPort {

    private final BusinessEventNotifierService businessEventNotifierService;

    public SmsCampaignTriggerEventPortAdapter(final BusinessEventNotifierService businessEventNotifierService) {
        this.businessEventNotifierService = businessEventNotifierService;
    }

    @Override
    public void onClientActivated(final Consumer<Object> handler) {
        businessEventNotifierService.addPostBusinessEventListener(ClientActivateBusinessEvent.class, event -> handler.accept(event.get()));
    }

    @Override
    public void onClientRejected(final Consumer<Object> handler) {
        businessEventNotifierService.addPostBusinessEventListener(ClientRejectBusinessEvent.class, event -> handler.accept(event.get()));
    }

    @Override
    public void onSavingsActivated(final Consumer<Object> handler) {
        businessEventNotifierService.addPostBusinessEventListener(SavingsActivateBusinessEvent.class, event -> handler.accept(event.get()));
    }

    @Override
    public void onSavingsRejected(final Consumer<Object> handler) {
        businessEventNotifierService.addPostBusinessEventListener(SavingsRejectBusinessEvent.class, event -> handler.accept(event.get()));
    }

    @Override
    public void onSavingsDeposit(final Consumer<Object> handler) {
        businessEventNotifierService.addPostBusinessEventListener(SavingsDepositBusinessEvent.class, event -> handler.accept(event.get()));
    }

    @Override
    public void onSavingsWithdrawal(final Consumer<Object> handler) {
        businessEventNotifierService.addPostBusinessEventListener(SavingsWithdrawalBusinessEvent.class, event -> handler.accept(event.get()));
    }
}
