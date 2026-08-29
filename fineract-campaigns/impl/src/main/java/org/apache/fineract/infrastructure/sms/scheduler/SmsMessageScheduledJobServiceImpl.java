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
package org.apache.fineract.infrastructure.sms.scheduler;

import edu.umd.cs.findbugs.annotations.SuppressFBWarnings;
import java.net.URI;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import org.apache.fineract.infrastructure.campaigns.helper.SmsConfigUtils;
import org.apache.fineract.infrastructure.campaigns.sms.constants.SmsCampaignConstants;
import org.apache.fineract.infrastructure.campaigns.sms.domain.SmsCampaign;
import org.apache.fineract.infrastructure.campaigns.sms.exception.ConnectionFailureException;
import org.apache.fineract.infrastructure.core.config.TaskExecutorConstant;
import org.apache.fineract.infrastructure.core.domain.FineractContext;
import org.apache.fineract.infrastructure.core.service.ThreadLocalContextUtil;
import org.apache.fineract.infrastructure.gcm.domain.GcmPushNotification;
import org.apache.fineract.infrastructure.gcm.service.NotificationSenderService;
import org.apache.fineract.infrastructure.sms.data.SmsMessageApiQueueResourceData;
import org.apache.fineract.infrastructure.sms.service.SmsMessagePort;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextClosedEvent;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

/**
 * Scheduled job services that send SMS messages and get delivery reports for the sent SMS messages
 */
@Service
public class SmsMessageScheduledJobServiceImpl implements SmsMessageScheduledJobService {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(SmsMessageScheduledJobServiceImpl.class);
    private final SmsMessagePort smsMessagePort;
    private final RestTemplate restTemplate = new RestTemplate();
    private final SmsConfigUtils smsConfigUtils;
    private final NotificationSenderService notificationSenderService;
    @Qualifier(TaskExecutorConstant.DEFAULT_TASK_EXECUTOR_BEAN_NAME)
    private final ThreadPoolTaskExecutor taskExecutor;

    @SuppressFBWarnings("SLF4J_SIGN_ONLY_FORMAT")
    private void connectAndSendToIntermediateServer(Collection<SmsMessageApiQueueResourceData> apiQueueResourceDatas) {
        Map<String, Object> hostConfig = this.smsConfigUtils.getMessageGateWayRequestURI("sms", SmsMessageApiQueueResourceData.toJsonString(apiQueueResourceDatas));
        URI uri = (URI) hostConfig.get("uri");
        HttpEntity<?> entity = (HttpEntity<?>) hostConfig.get("entity");
        ResponseEntity<String> responseOne = restTemplate.exchange(uri, HttpMethod.POST, entity, new ParameterizedTypeReference<String>() {
        });
        if (responseOne != null) {
            // String smsResponse = responseOne.getBody();
            if (!responseOne.getStatusCode().equals(HttpStatus.ACCEPTED)) {
                log.debug("{}", responseOne.getStatusCode().value());
                throw new ConnectionFailureException(SmsCampaignConstants.SMS);
            }
        }
    }

    @Override
    public void sendTriggeredMessages(Map<SmsCampaign, Collection<SmsMessagePort.OutboundView>> smsDataMap) {
        try {
            if (!smsDataMap.isEmpty()) {
                List<SmsMessagePort.OutboundView> toSendMessages = new ArrayList<>();
                List<SmsMessagePort.OutboundView> toSendNotificationMessages = new ArrayList<>();
                for (Map.Entry<SmsCampaign, Collection<SmsMessagePort.OutboundView>> entry : smsDataMap.entrySet()) {
                    for (SmsMessagePort.OutboundView smsMessage : entry.getValue()) {
                        if (smsMessage.notification()) {
                            toSendNotificationMessages.add(smsMessage);
                        } else {
                            toSendMessages.add(smsMessage);
                        }
                    }
                }
                final List<Long> waitingIds = new ArrayList<>();
                toSendMessages.forEach(view -> waitingIds.add(view.id()));
                toSendNotificationMessages.forEach(view -> waitingIds.add(view.id()));
                this.smsMessagePort.markWaitingForDelivery(waitingIds);
                if (!toSendMessages.isEmpty()) {
                    for (Map.Entry<SmsCampaign, Collection<SmsMessagePort.OutboundView>> entry : smsDataMap.entrySet()) {
                        Collection<SmsMessageApiQueueResourceData> apiQueueResourceDatas = new ArrayList<>();
                        for (SmsMessagePort.OutboundView smsMessage : entry.getValue()) {
                            if (!smsMessage.notification()) {
                                SmsMessageApiQueueResourceData apiQueueResourceData = SmsMessageApiQueueResourceData.instance(smsMessage.id(), null, null, null, smsMessage.mobileNo(), smsMessage.message(), entry.getKey().getProviderId());
                                apiQueueResourceDatas.add(apiQueueResourceData);
                            }
                        }
                        if (!apiQueueResourceDatas.isEmpty()) {
                            this.taskExecutor.execute(new SmsTask(apiQueueResourceDatas, ThreadLocalContextUtil.getContext()));
                        }
                    }
                }
                if (!toSendNotificationMessages.isEmpty()) {
                    sendGcmNotifications(toSendNotificationMessages);
                }
            }
        } catch (Exception e) {
            log.error("Error occurred.", e);
        }
    }

    @Override
    public void sendTriggeredMessage(Collection<SmsMessagePort.OutboundView> smsMessages, long providerId) {
        try {
            Collection<SmsMessageApiQueueResourceData> apiQueueResourceDatas = new ArrayList<>();
            StringBuilder request = new StringBuilder();
            final List<Long> waitingIds = new ArrayList<>();
            for (SmsMessagePort.OutboundView smsMessage : smsMessages) {
                SmsMessageApiQueueResourceData apiQueueResourceData = SmsMessageApiQueueResourceData.instance(smsMessage.id(), null, null, null, smsMessage.mobileNo(), smsMessage.message(), providerId);
                apiQueueResourceDatas.add(apiQueueResourceData);
                waitingIds.add(smsMessage.id());
            }
            this.smsMessagePort.markWaitingForDelivery(waitingIds);
            request.append(SmsMessageApiQueueResourceData.toJsonString(apiQueueResourceDatas));
            log.debug("Sending triggered SMS to specific provider with request - {}", request);
            this.taskExecutor.execute(new SmsTask(apiQueueResourceDatas, ThreadLocalContextUtil.getContext()));
        } catch (Exception e) {
            log.error("Error occured.", e);
        }
    }

    private void sendGcmNotifications(final List<SmsMessagePort.OutboundView> smsMessages) {
        final List<GcmPushNotification> pushes = new ArrayList<>(smsMessages.size());
        for (final SmsMessagePort.OutboundView smsMessage : smsMessages) {
            pushes.add(new GcmPushNotification(smsMessage.clientId(), smsMessage.message()));
        }
        this.notificationSenderService.sendNotification(pushes);
        for (int i = 0; i < smsMessages.size(); i++) {
            if (smsMessages.get(i).clientId() == null) {
                continue;
            }
            final GcmPushNotification push = pushes.get(i);
            if (push.isSent()) {
                this.smsMessagePort.markSent(smsMessages.get(i).id(), push.getDeliveredOnDate());
            } else if (push.isFailed()) {
                this.smsMessagePort.markFailed(smsMessages.get(i).id());
            }
        }
    }

    class SmsTask implements Runnable, ApplicationListener<ContextClosedEvent> {
        private final FineractContext context;
        private final Collection<SmsMessageApiQueueResourceData> apiQueueResourceDatas;

        SmsTask(final Collection<SmsMessageApiQueueResourceData> apiQueueResourceDatas, final FineractContext context) {
            this.context = context;
            this.apiQueueResourceDatas = apiQueueResourceDatas;
        }

        @Override
        public void run() {
            try {
                ThreadLocalContextUtil.init(context);
                connectAndSendToIntermediateServer(apiQueueResourceDatas);
            } finally {
                ThreadLocalContextUtil.reset();
            }
        }

        @Override
        public void onApplicationEvent(ContextClosedEvent event) {
            taskExecutor.shutdown();
            log.info("Shutting down the ExecutorService");
        }
    }

    @java.lang.SuppressWarnings("all")
        public SmsMessageScheduledJobServiceImpl(final SmsMessagePort smsMessagePort, final SmsConfigUtils smsConfigUtils, final NotificationSenderService notificationSenderService, @Qualifier(TaskExecutorConstant.DEFAULT_TASK_EXECUTOR_BEAN_NAME) final ThreadPoolTaskExecutor taskExecutor) {
        this.smsMessagePort = smsMessagePort;
        this.smsConfigUtils = smsConfigUtils;
        this.notificationSenderService = notificationSenderService;
        this.taskExecutor = taskExecutor;
    }
}
