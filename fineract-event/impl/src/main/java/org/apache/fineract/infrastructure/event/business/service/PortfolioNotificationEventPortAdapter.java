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
import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;
import org.apache.fineract.infrastructure.event.business.domain.PortfolioAccountEventData;
import org.apache.fineract.infrastructure.event.business.domain.client.ClientCreateBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.deposit.FixedDepositAccountCreateBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.deposit.RecurringDepositAccountCreateBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.group.CentersCreateBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.group.GroupsCreateBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.savings.SavingsApproveBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.savings.SavingsCloseBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.savings.SavingsCreateBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.savings.SavingsPostInterestBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.savings.transaction.SavingsDepositBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.share.ShareAccountApproveBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.share.ShareAccountCreateBusinessEvent;
import org.apache.fineract.infrastructure.event.business.moduleapi.PortfolioNotificationEventPort;
import org.apache.fineract.portfolio.client.domain.Client;
import org.apache.fineract.portfolio.savings.DepositAccountType;
import org.springframework.stereotype.Service;

@Service
public class PortfolioNotificationEventPortAdapter implements PortfolioNotificationEventPort {

    private final BusinessEventNotifierService businessEventNotifierService;

    public PortfolioNotificationEventPortAdapter(final BusinessEventNotifierService businessEventNotifierService) {
        this.businessEventNotifierService = businessEventNotifierService;
    }

    @Override
    public void onNotifications(final Consumer<Notification> handler) {
        businessEventNotifierService.addPostBusinessEventListener(ClientCreateBusinessEvent.class, event -> {
            final Client client = event.get();
            handler.accept(new Notification("ACTIVATE_CLIENT", "client", client.getId(), "New client created", "created",
                    client.getOffice().getId()));
        });
        businessEventNotifierService.addPostBusinessEventListener(CentersCreateBusinessEvent.class, event -> {
            final CommandProcessingResult result = event.get();
            handler.accept(new Notification("ACTIVATE_CENTER", "center", result.getGroupId(), "New center created", "created",
                    result.getOfficeId()));
        });
        businessEventNotifierService.addPostBusinessEventListener(GroupsCreateBusinessEvent.class, event -> {
            final CommandProcessingResult result = event.get();
            handler.accept(new Notification("ACTIVATE_GROUP", "group", result.getGroupId(), "New group created", "created",
                    result.getOfficeId()));
        });
        businessEventNotifierService.addPostBusinessEventListener(SavingsDepositBusinessEvent.class, event -> handler.accept(
                new Notification("READ_SAVINGSACCOUNT", "savingsAccount", event.getAggregateRootId(), "Deposit made", "depositMade",
                        event.officeId())));
        businessEventNotifierService.addPostBusinessEventListener(FixedDepositAccountCreateBusinessEvent.class, event -> {
            final PortfolioAccountEventData data = event.get();
            handler.accept(new Notification("APPROVE_FIXEDDEPOSITACCOUNT", "fixedDeposit", data.getAccountId(),
                    "New fixed deposit account created", "created", data.getOfficeId()));
        });
        businessEventNotifierService.addPostBusinessEventListener(RecurringDepositAccountCreateBusinessEvent.class, event -> {
            final PortfolioAccountEventData data = event.get();
            handler.accept(new Notification("APPROVE_RECURRINGDEPOSITACCOUNT", "recurringDepositAccount", data.getAccountId(),
                    "New recurring deposit account created", "created", data.getOfficeId()));
        });
        businessEventNotifierService.addPostBusinessEventListener(SavingsApproveBusinessEvent.class, event -> {
            if (event.depositAccountType().equals(DepositAccountType.FIXED_DEPOSIT)) {
                handler.accept(new Notification("ACTIVATE_FIXEDDEPOSITACCOUNT", "fixedDeposit", event.getAggregateRootId(),
                        "Fixed deposit account approved", "approved", event.officeId()));
            } else if (event.depositAccountType().equals(DepositAccountType.RECURRING_DEPOSIT)) {
                handler.accept(new Notification("ACTIVATE_RECURRINGDEPOSITACCOUNT", "recurringDepositAccount", event.getAggregateRootId(),
                        "Recurring deposit account approved", "approved", event.officeId()));
            } else if (event.depositAccountType().equals(DepositAccountType.SAVINGS_DEPOSIT)) {
                handler.accept(new Notification("ACTIVATE_SAVINGSACCOUNT", "savingsAccount", event.getAggregateRootId(),
                        "Savings account approved", "approved", event.officeId()));
            }
        });
        businessEventNotifierService.addPostBusinessEventListener(SavingsPostInterestBusinessEvent.class, event -> handler.accept(
                new Notification("READ_SAVINGSACCOUNT", "savingsAccount", event.getAggregateRootId(), "Interest posted to account",
                        "interestPosted", event.officeId())));
        businessEventNotifierService.addPostBusinessEventListener(SavingsCreateBusinessEvent.class, event -> handler.accept(
                new Notification("APPROVE_SAVINGSACCOUNT", "savingsAccount", event.getAggregateRootId(), "New savings account created",
                        "created", event.officeId())));
        businessEventNotifierService.addPostBusinessEventListener(SavingsCloseBusinessEvent.class, event -> handler.accept(
                new Notification("READ_SAVINGSACCOUNT", "savingsAccount", event.getAggregateRootId(), "Savings has gone into dormant",
                        "closed", event.officeId())));
        businessEventNotifierService.addPostBusinessEventListener(ShareAccountCreateBusinessEvent.class, event -> {
            final PortfolioAccountEventData data = event.get();
            handler.accept(new Notification("APPROVE_SHAREACCOUNT", "shareAccount", data.getAccountId(), "New share account created",
                    "created", data.getOfficeId()));
        });
        businessEventNotifierService.addPostBusinessEventListener(ShareAccountApproveBusinessEvent.class, event -> {
            final PortfolioAccountEventData data = event.get();
            handler.accept(new Notification("ACTIVATE_SHAREACCOUNT", "shareAccount", data.getAccountId(), "Share account approved",
                    "approved", data.getOfficeId()));
        });
    }
}
