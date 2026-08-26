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
import org.apache.fineract.infrastructure.event.business.BusinessEventListener;
import org.apache.fineract.infrastructure.event.business.domain.share.ShareProductDividentsCreateBusinessEvent;
import org.apache.fineract.infrastructure.event.business.moduleapi.PortfolioNotificationEventPort;
import org.apache.fineract.infrastructure.event.business.service.BusinessEventNotifierService;
import org.apache.fineract.infrastructure.security.service.PlatformSecurityContext;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanNotificationEventPort;

public class NotificationDomainServiceImpl implements NotificationDomainService {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(NotificationDomainServiceImpl.class);
    private final BusinessEventNotifierService businessEventNotifierService;
    private final PlatformSecurityContext context;
    private final UserNotificationService userNotificationService;
    private final LoanNotificationEventPort loanNotificationEventPort;
    private final PortfolioNotificationEventPort portfolioNotificationEventPort;

    @PostConstruct
    public void addListeners() {
        businessEventNotifierService.addPostBusinessEventListener(ShareProductDividentsCreateBusinessEvent.class,
                new ShareProductDividendCreatedListener());
        loanNotificationEventPort.onLoanNotifications(notification -> buildNotification(notification.permission(), notification.objectType(),
                notification.objectId(), notification.notificationContent(), notification.eventType(), context.authenticatedUser().getId(),
                notification.officeId() != null ? notification.officeId() : context.authenticatedUser().getOffice().getId()));
        portfolioNotificationEventPort.onNotifications(notification -> buildNotification(notification.permission(),
                notification.objectType(), notification.objectId(), notification.notificationContent(), notification.eventType(),
                context.authenticatedUser().getId(),
                notification.officeId() != null ? notification.officeId() : context.authenticatedUser().getOffice().getId()));
    }

    private final class ShareProductDividendCreatedListener implements BusinessEventListener<ShareProductDividentsCreateBusinessEvent> {
        @Override
        public void onBusinessEvent(ShareProductDividentsCreateBusinessEvent event) {
            Long shareProductId = event.get();
            buildNotification("READ_DIVIDEND_SHAREPRODUCT", "shareProduct", shareProductId, "Dividend posted to account", "dividendPosted",
                    context.authenticatedUser().getId(), context.authenticatedUser().getOffice().getId());
        }
    }

    private void buildNotification(String permission, String objectType, Long objectIdentifier, String notificationContent, String eventType,
            Long appUserId, Long officeId) {
        userNotificationService.notifyUsers(permission, objectType, objectIdentifier, notificationContent, eventType, appUserId, officeId);
    }

    @java.lang.SuppressWarnings("all")
        public NotificationDomainServiceImpl(final BusinessEventNotifierService businessEventNotifierService, final PlatformSecurityContext context, final UserNotificationService userNotificationService, final LoanNotificationEventPort loanNotificationEventPort, final PortfolioNotificationEventPort portfolioNotificationEventPort) {
        this.businessEventNotifierService = businessEventNotifierService;
        this.context = context;
        this.userNotificationService = userNotificationService;
        this.loanNotificationEventPort = loanNotificationEventPort;
        this.portfolioNotificationEventPort = portfolioNotificationEventPort;
    }
}
