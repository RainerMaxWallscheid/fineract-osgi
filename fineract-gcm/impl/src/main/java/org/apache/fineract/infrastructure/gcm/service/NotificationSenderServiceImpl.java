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
package org.apache.fineract.infrastructure.gcm.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.gcm.GcmConstants;
import org.apache.fineract.infrastructure.gcm.domain.GcmPushNotification;
import org.apache.fineract.infrastructure.gcm.domain.Message;
import org.apache.fineract.infrastructure.gcm.domain.Message.Priority;
import org.apache.fineract.infrastructure.gcm.domain.Notification;
import org.apache.fineract.infrastructure.gcm.domain.NotificationConfigurationData;
import org.apache.fineract.infrastructure.gcm.domain.Result;
import org.apache.fineract.infrastructure.gcm.domain.Sender;
import org.springframework.stereotype.Service;

@Service
public class NotificationSenderServiceImpl implements NotificationSenderService {
    private final NotificationConfigurationReadService notificationConfigurationReadService;

    @Override
    public void sendNotification(List<GcmPushNotification> notifications) {
        Map<Long, List<GcmPushNotification>> notificationByEachClient = getNotificationListByClient(notifications);
        for (Map.Entry<Long, List<GcmPushNotification>> entry : notificationByEachClient.entrySet()) {
            sendNotification(entry.getKey(), entry.getValue());
        }
    }

    public Map<Long, List<GcmPushNotification>> getNotificationListByClient(List<GcmPushNotification> notifications) {
        Map<Long, List<GcmPushNotification>> notificationByEachClient = new HashMap<>();
        for (GcmPushNotification notification : notifications) {
            if (notification.getClientId() != null) {
                notificationByEachClient.computeIfAbsent(notification.getClientId(), key -> new ArrayList<>()).add(notification);
            }
        }
        return notificationByEachClient;
    }

    public void sendNotification(Long clientId, List<GcmPushNotification> notifications) {
        NotificationConfigurationData notificationConfigurationData = notificationConfigurationReadService.getNotificationConfiguration();
        String registrationId = null;
        for (GcmPushNotification push : notifications) {
            try {
                Notification notification = new Notification.Builder(GcmConstants.defaultIcon).title(GcmConstants.title).body(push.getMessage()).build();
                Message message = new Message.Builder().notification(notification).dryRun(false).contentAvailable(true).timeToLive(GcmConstants.TIME_TO_LIVE).priority(Priority.HIGH).delayWhileIdle(true).build();
                Sender sender = new Sender(notificationConfigurationData.getServerKey(), notificationConfigurationData.getFcmEndPoint());
                Result res = sender.send(message, registrationId, 3);
                if (res.getSuccess() != null && res.getSuccess() > 0) {
                    push.markSent(DateUtils.getLocalDateTimeOfTenant());
                } else if (res.getFailure() != null && res.getFailure() > 0) {
                    push.markFailed();
                }
            } catch (IOException e) {
                push.markFailed();
            }
        }
    }

    @java.lang.SuppressWarnings("all")
        public NotificationSenderServiceImpl(final NotificationConfigurationReadService notificationConfigurationReadService) {
        this.notificationConfigurationReadService = notificationConfigurationReadService;
    }
}
