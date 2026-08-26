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
package org.apache.fineract.notification.service;

import jakarta.annotation.PostConstruct;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;
import org.apache.fineract.infrastructure.event.business.BusinessEventListener;
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
import org.apache.fineract.infrastructure.event.business.domain.share.ShareProductDividentsCreateBusinessEvent;
import org.apache.fineract.infrastructure.event.business.service.BusinessEventNotifierService;
import org.apache.fineract.infrastructure.security.service.PlatformSecurityContext;
import org.apache.fineract.portfolio.client.domain.Client;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanNotificationEventPort;
import org.apache.fineract.portfolio.savings.DepositAccountType;

public class NotificationDomainServiceImpl implements NotificationDomainService {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(NotificationDomainServiceImpl.class);
    private final BusinessEventNotifierService businessEventNotifierService;
    private final PlatformSecurityContext context;
    private final UserNotificationService userNotificationService;
    private final LoanNotificationEventPort loanNotificationEventPort;

    @PostConstruct
    public void addListeners() {
        businessEventNotifierService.addPostBusinessEventListener(ClientCreateBusinessEvent.class, new ClientCreatedListener());
        businessEventNotifierService.addPostBusinessEventListener(SavingsApproveBusinessEvent.class, new SavingsAccountApprovedListener());
        businessEventNotifierService.addPostBusinessEventListener(CentersCreateBusinessEvent.class, new CenterCreatedListener());
        businessEventNotifierService.addPostBusinessEventListener(GroupsCreateBusinessEvent.class, new GroupCreatedListener());
        businessEventNotifierService.addPostBusinessEventListener(SavingsDepositBusinessEvent.class, new SavingsAccountDepositListener());
        businessEventNotifierService.addPostBusinessEventListener(ShareProductDividentsCreateBusinessEvent.class, new ShareProductDividendCreatedListener());
        businessEventNotifierService.addPostBusinessEventListener(FixedDepositAccountCreateBusinessEvent.class, new FixedDepositAccountCreatedListener());
        businessEventNotifierService.addPostBusinessEventListener(RecurringDepositAccountCreateBusinessEvent.class, new RecurringDepositAccountCreatedListener());
        businessEventNotifierService.addPostBusinessEventListener(SavingsPostInterestBusinessEvent.class, new SavingsPostInterestListener());
        loanNotificationEventPort.onLoanNotifications(notification -> buildNotification(notification.permission(), notification.objectType(),
                notification.objectId(), notification.notificationContent(), notification.eventType(), context.authenticatedUser().getId(),
                notification.officeId() != null ? notification.officeId() : context.authenticatedUser().getOffice().getId()));
        businessEventNotifierService.addPostBusinessEventListener(SavingsCreateBusinessEvent.class, new SavingsAccountCreatedListener());
        businessEventNotifierService.addPostBusinessEventListener(SavingsCloseBusinessEvent.class, new SavingsAccountClosedListener());
        businessEventNotifierService.addPostBusinessEventListener(ShareAccountCreateBusinessEvent.class, new ShareAccountCreatedListener());
        businessEventNotifierService.addPostBusinessEventListener(ShareAccountApproveBusinessEvent.class, new ShareAccountApprovedListener());
    }


    private final class ClientCreatedListener implements BusinessEventListener<ClientCreateBusinessEvent> {
        @Override
        public void onBusinessEvent(ClientCreateBusinessEvent event) {
            Client client = event.get();
            buildNotification("ACTIVATE_CLIENT", "client", client.getId(), "New client created", "created", context.authenticatedUser().getId(), client.getOffice().getId());
        }
    }


    private final class CenterCreatedListener implements BusinessEventListener<CentersCreateBusinessEvent> {
        @Override
        public void onBusinessEvent(CentersCreateBusinessEvent event) {
            CommandProcessingResult commandProcessingResult = event.get();
            buildNotification("ACTIVATE_CENTER", "center", commandProcessingResult.getGroupId(), "New center created", "created", context.authenticatedUser().getId(), commandProcessingResult.getOfficeId());
        }
    }


    private final class GroupCreatedListener implements BusinessEventListener<GroupsCreateBusinessEvent> {
        @Override
        public void onBusinessEvent(GroupsCreateBusinessEvent event) {
            CommandProcessingResult commandProcessingResult = event.get();
            buildNotification("ACTIVATE_GROUP", "group", commandProcessingResult.getGroupId(), "New group created", "created", context.authenticatedUser().getId(), commandProcessingResult.getOfficeId());
        }
    }


    private final class SavingsAccountDepositListener implements BusinessEventListener<SavingsDepositBusinessEvent> {
        @Override
        public void onBusinessEvent(SavingsDepositBusinessEvent event) {
            buildNotification("READ_SAVINGSACCOUNT", "savingsAccount", event.getAggregateRootId(), "Deposit made", "depositMade", context.authenticatedUser().getId(), event.officeId());
        }
    }


    private final class ShareProductDividendCreatedListener implements BusinessEventListener<ShareProductDividentsCreateBusinessEvent> {
        @Override
        public void onBusinessEvent(ShareProductDividentsCreateBusinessEvent event) {
            Long shareProductId = event.get();
            buildNotification("READ_DIVIDEND_SHAREPRODUCT", "shareProduct", shareProductId, "Dividend posted to account", "dividendPosted", context.authenticatedUser().getId(), context.authenticatedUser().getOffice().getId());
        }
    }


    private final class FixedDepositAccountCreatedListener implements BusinessEventListener<FixedDepositAccountCreateBusinessEvent> {
        @Override
        public void onBusinessEvent(FixedDepositAccountCreateBusinessEvent event) {
            buildNotification("APPROVE_FIXEDDEPOSITACCOUNT", "fixedDeposit", event.get().getAccountId(), "New fixed deposit account created", "created", context.authenticatedUser().getId(), event.get().getOfficeId());
        }
    }


    private final class RecurringDepositAccountCreatedListener implements BusinessEventListener<RecurringDepositAccountCreateBusinessEvent> {
        @Override
        public void onBusinessEvent(RecurringDepositAccountCreateBusinessEvent event) {
            buildNotification("APPROVE_RECURRINGDEPOSITACCOUNT", "recurringDepositAccount", event.get().getAccountId(), "New recurring deposit account created", "created", context.authenticatedUser().getId(), event.get().getOfficeId());
        }
    }


    private final class SavingsAccountApprovedListener implements BusinessEventListener<SavingsApproveBusinessEvent> {
        @Override
        public void onBusinessEvent(SavingsApproveBusinessEvent event) {
            if (event.depositAccountType().equals(DepositAccountType.FIXED_DEPOSIT)) {
                buildNotification("ACTIVATE_FIXEDDEPOSITACCOUNT", "fixedDeposit", event.getAggregateRootId(), "Fixed deposit account approved", "approved", context.authenticatedUser().getId(), event.officeId());
            } else if (event.depositAccountType().equals(DepositAccountType.RECURRING_DEPOSIT)) {
                buildNotification("ACTIVATE_RECURRINGDEPOSITACCOUNT", "recurringDepositAccount", event.getAggregateRootId(), "Recurring deposit account approved", "approved", context.authenticatedUser().getId(), event.officeId());
            } else if (event.depositAccountType().equals(DepositAccountType.SAVINGS_DEPOSIT)) {
                buildNotification("ACTIVATE_SAVINGSACCOUNT", "savingsAccount", event.getAggregateRootId(), "Savings account approved", "approved", context.authenticatedUser().getId(), event.officeId());
            }
        }
    }


    private final class SavingsPostInterestListener implements BusinessEventListener<SavingsPostInterestBusinessEvent> {
        @Override
        public void onBusinessEvent(SavingsPostInterestBusinessEvent event) {
            buildNotification("READ_SAVINGSACCOUNT", "savingsAccount", event.getAggregateRootId(), "Interest posted to account", "interestPosted", context.authenticatedUser().getId(), event.officeId());
        }
    }


    private final class SavingsAccountCreatedListener implements BusinessEventListener<SavingsCreateBusinessEvent> {
        @Override
        public void onBusinessEvent(SavingsCreateBusinessEvent event) {
            buildNotification("APPROVE_SAVINGSACCOUNT", "savingsAccount", event.getAggregateRootId(), "New savings account created", "created", context.authenticatedUser().getId(), event.officeId());
        }
    }


    private final class SavingsAccountClosedListener implements BusinessEventListener<SavingsCloseBusinessEvent> {
        @Override
        public void onBusinessEvent(SavingsCloseBusinessEvent event) {
            buildNotification("READ_SAVINGSACCOUNT", "savingsAccount", event.getAggregateRootId(), "Savings has gone into dormant", "closed", context.authenticatedUser().getId(), event.officeId());
        }
    }


    private final class ShareAccountCreatedListener implements BusinessEventListener<ShareAccountCreateBusinessEvent> {
        @Override
        public void onBusinessEvent(ShareAccountCreateBusinessEvent event) {
            buildNotification("APPROVE_SHAREACCOUNT", "shareAccount", event.get().getAccountId(), "New share account created", "created", context.authenticatedUser().getId(), event.get().getOfficeId());
        }
    }


    private final class ShareAccountApprovedListener implements BusinessEventListener<ShareAccountApproveBusinessEvent> {
        @Override
        public void onBusinessEvent(ShareAccountApproveBusinessEvent event) {
            buildNotification("ACTIVATE_SHAREACCOUNT", "shareAccount", event.get().getAccountId(), "Share account approved", "approved", context.authenticatedUser().getId(), event.get().getOfficeId());
        }
    }

    private void buildNotification(String permission, String objectType, Long objectIdentifier, String notificationContent, String eventType, Long appUserId, Long officeId) {
        userNotificationService.notifyUsers(permission, objectType, objectIdentifier, notificationContent, eventType, appUserId, officeId);
    }

    @java.lang.SuppressWarnings("all")
        public NotificationDomainServiceImpl(final BusinessEventNotifierService businessEventNotifierService, final PlatformSecurityContext context, final UserNotificationService userNotificationService, final LoanNotificationEventPort loanNotificationEventPort) {
        this.businessEventNotifierService = businessEventNotifierService;
        this.context = context;
        this.userNotificationService = userNotificationService;
        this.loanNotificationEventPort = loanNotificationEventPort;
    }
}
