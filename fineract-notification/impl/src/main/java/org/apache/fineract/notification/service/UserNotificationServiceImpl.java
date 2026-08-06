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

import static java.util.stream.Collectors.toSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import org.apache.fineract.infrastructure.core.config.FineractProperties;
import org.apache.fineract.infrastructure.core.service.ThreadLocalContextUtil;
import org.apache.fineract.notification.data.NotificationData;
import org.apache.fineract.notification.eventandlistener.NotificationEventPublisher;
import org.apache.fineract.useradministration.domain.AppUser;
import org.apache.fineract.useradministration.domain.AppUserRepository;

public class UserNotificationServiceImpl implements UserNotificationService {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(UserNotificationServiceImpl.class);
    private final NotificationEventPublisher notificationEventPublisher;
    private final AppUserRepository appUserRepository;
    private final FineractProperties fineractProperties;
    private final NotificationReadPlatformService notificationReadPlatformService;
    private final NotificationWritePlatformService notificationWritePlatformService;

    @Override
    public void notifyUsers(String permission, String objectType, Long objectIdentifier, String notificationContent, String eventType, Long appUserId, Long officeId) {
        if (userNotificationSystemIsEnabled()) {
            String tenantIdentifier = ThreadLocalContextUtil.getTenant().getTenantIdentifier();
            Set<Long> userIds = getNotifiableUserIds(officeId, permission);
            NotificationData notificationData = new NotificationData().setObjectType(objectType).setObjectId(objectIdentifier).setAction(eventType).setActorId(appUserId).setContent(notificationContent).setRead(false).setSystemGenerated(false).setTenantIdentifier(tenantIdentifier).setOfficeId(officeId).setUserIds(userIds);
            try {
                notificationEventPublisher.broadcastNotification(notificationData);
            } catch (Exception e) {
                // We want to avoid rethrowing the exception to stop the business transaction from rolling back
                log.error("Error while broadcasting notification event", e);
            }
        }
    }

    @Override
    public boolean hasUnreadUserNotifications(Long appUserId) {
        if (userNotificationSystemIsEnabled()) {
            return notificationReadPlatformService.hasUnreadNotifications(appUserId);
        } else {
            return false;
        }
    }

    @Override
    public void notifyUsers(NotificationData notificationData) {
        if (userNotificationSystemIsEnabled()) {
            Long appUserId = notificationData.getActorId();
            Set<Long> userIds = notificationData.getUserIds();
            if (notificationData.getOfficeId() != null) {
                List<Long> tempUserIds = new ArrayList<>(userIds);
                for (Long userId : tempUserIds) {
                    AppUser appUser = appUserRepository.findById(userId).orElseThrow();
                    if (appUser.getOffice() == null || !Objects.equals(appUser.getOffice().getId(), notificationData.getOfficeId())) {
                        userIds.remove(userId);
                    }
                }
            }
            // Don't notify the same user who triggered the event
            if (userIds.contains(appUserId)) {
                userIds.remove(appUserId);
            }
            notificationWritePlatformService.notify(userIds, notificationData.getObjectType(), notificationData.getObjectId(), notificationData.getAction(), notificationData.getActorId(), notificationData.getContent(), notificationData.isSystemGenerated());
        }
    }

    private boolean userNotificationSystemIsEnabled() {
        return fineractProperties.getNotification().getUserNotificationSystem().isEnabled();
    }

    private Set<Long> getNotifiableUserIds(Long officeId, String permission) {
        Collection<AppUser> users = appUserRepository.findByOfficeId(officeId);
        Collection<AppUser> usersWithPermission = users.stream().filter(aU -> aU.hasAnyPermission(permission, "ALL_FUNCTIONS")).toList();
        return usersWithPermission.stream().map(AppUser::getId).collect(toSet());
    }

    @java.lang.SuppressWarnings("all")
        public UserNotificationServiceImpl(final NotificationEventPublisher notificationEventPublisher, final AppUserRepository appUserRepository, final FineractProperties fineractProperties, final NotificationReadPlatformService notificationReadPlatformService, final NotificationWritePlatformService notificationWritePlatformService) {
        this.notificationEventPublisher = notificationEventPublisher;
        this.appUserRepository = appUserRepository;
        this.fineractProperties = fineractProperties;
        this.notificationReadPlatformService = notificationReadPlatformService;
        this.notificationWritePlatformService = notificationWritePlatformService;
    }
}
