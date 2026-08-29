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
package org.apache.fineract.infrastructure.campaigns.jobs.sendmessagetosmsgateway;

import edu.umd.cs.findbugs.annotations.SuppressFBWarnings;
import java.net.URI;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.fineract.infrastructure.campaigns.helper.SmsConfigUtils;
import org.apache.fineract.infrastructure.campaigns.sms.constants.SmsCampaignConstants;
import org.apache.fineract.infrastructure.campaigns.sms.domain.SmsCampaignRepository;
import org.apache.fineract.infrastructure.campaigns.sms.exception.ConnectionFailureException;
import org.apache.fineract.infrastructure.core.domain.FineractPlatformTenant;
import org.apache.fineract.infrastructure.core.service.ThreadLocalContextUtil;
import org.apache.fineract.infrastructure.gcm.domain.GcmPushNotification;
import org.apache.fineract.infrastructure.gcm.service.NotificationSenderService;
import org.apache.fineract.infrastructure.sms.data.SmsMessageApiQueueResourceData;
import org.apache.fineract.infrastructure.sms.service.SmsMessagePort;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextClosedEvent;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.web.client.RestTemplate;

public class SendMessageToSmsGatewayTasklet implements Tasklet {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(SendMessageToSmsGatewayTasklet.class);
    private final SmsMessagePort smsMessagePort;
    private final SmsCampaignRepository smsCampaignRepository;
    private final NotificationSenderService notificationSenderService;
    private final SmsConfigUtils smsConfigUtils;
    private final ThreadPoolTaskExecutor taskExecutor;
    private final RestTemplate restTemplate = new RestTemplate();

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        int pageLimit = 200;
        List<SmsMessagePort.OutboundView> pendingMessages;
        do {
            pendingMessages = smsMessagePort.findPending(pageLimit);
            List<SmsMessagePort.OutboundView> toSendMessages = new ArrayList<>();
            List<SmsMessagePort.OutboundView> toSendNotificationMessages = new ArrayList<>();
            try {
                if (!CollectionUtils.isEmpty(pendingMessages)) {
                    final String tenantIdentifier = ThreadLocalContextUtil.getTenant().getTenantIdentifier();
                    Collection<SmsMessageApiQueueResourceData> apiQueueResourceDataCollection = new ArrayList<>();
                    for (SmsMessagePort.OutboundView smsData : pendingMessages) {
                        if (smsData.notification()) {
                            toSendNotificationMessages.add(smsData);
                        } else {
                            final Long providerId = resolveProviderId(smsData.campaignId());
                            SmsMessageApiQueueResourceData apiQueueResourceData = SmsMessageApiQueueResourceData.instance(smsData.id(), tenantIdentifier, null, null, smsData.mobileNo(), smsData.message(), providerId);
                            apiQueueResourceDataCollection.add(apiQueueResourceData);
                            toSendMessages.add(smsData);
                        }
                    }
                    final List<Long> waitingIds = new ArrayList<>();
                    toSendMessages.forEach(view -> waitingIds.add(view.id()));
                    toSendNotificationMessages.forEach(view -> waitingIds.add(view.id()));
                    smsMessagePort.markWaitingForDelivery(waitingIds);
                    if (!toSendMessages.isEmpty()) {
                        taskExecutor.execute(new SmsTask(ThreadLocalContextUtil.getTenant(), apiQueueResourceDataCollection));
                    }
                    if (!toSendNotificationMessages.isEmpty()) {
                        sendGcmNotifications(toSendNotificationMessages);
                    }
                }
            } catch (Exception e) {
                throw new ConnectionFailureException(SmsCampaignConstants.SMS, e);
            }
        } while (!CollectionUtils.isEmpty(pendingMessages) && pendingMessages.size() == pageLimit);
        return RepeatStatus.FINISHED;
    }


    private void sendGcmNotifications(final List<SmsMessagePort.OutboundView> smsMessages) {
        final List<GcmPushNotification> pushes = new ArrayList<>(smsMessages.size());
        for (final SmsMessagePort.OutboundView smsMessage : smsMessages) {
            pushes.add(new GcmPushNotification(smsMessage.clientId(), smsMessage.message()));
        }
        notificationSenderService.sendNotification(pushes);
        for (int i = 0; i < smsMessages.size(); i++) {
            if (smsMessages.get(i).clientId() == null) {
                continue;
            }
            final GcmPushNotification push = pushes.get(i);
            if (push.isSent()) {
                smsMessagePort.markSent(smsMessages.get(i).id(), push.getDeliveredOnDate());
            } else if (push.isFailed()) {
                smsMessagePort.markFailed(smsMessages.get(i).id());
            }
        }
    }

    class SmsTask implements Runnable, ApplicationListener<ContextClosedEvent> {
        private final FineractPlatformTenant tenant;
        private final Collection<SmsMessageApiQueueResourceData> apiQueueResourceDatas;

        SmsTask(final FineractPlatformTenant tenant, final Collection<SmsMessageApiQueueResourceData> apiQueueResourceDatas) {
            this.tenant = tenant;
            this.apiQueueResourceDatas = apiQueueResourceDatas;
        }

        @Override
        public void run() {
            ThreadLocalContextUtil.setTenant(tenant);
            connectAndSendToIntermediateServer(apiQueueResourceDatas);
        }

        @Override
        public void onApplicationEvent(ContextClosedEvent event) {
            taskExecutor.shutdown();
            log.info("Shutting down the ExecutorService");
        }
    }

    @SuppressFBWarnings("SLF4J_SIGN_ONLY_FORMAT")
    private void connectAndSendToIntermediateServer(Collection<SmsMessageApiQueueResourceData> apiQueueResourceDatas) {
        Map<String, Object> hostConfig = smsConfigUtils.getMessageGateWayRequestURI("sms", SmsMessageApiQueueResourceData.toJsonString(apiQueueResourceDatas));
        URI uri = (URI) hostConfig.get("uri");
        HttpEntity<?> entity = (HttpEntity<?>) hostConfig.get("entity");
        ResponseEntity<String> responseOne = restTemplate.exchange(uri, HttpMethod.POST, entity, new ParameterizedTypeReference<>() {
        });
        if (!responseOne.getStatusCode().equals(HttpStatus.ACCEPTED)) {
            log.debug("{}", responseOne.getStatusCode().value());
            throw new ConnectionFailureException(SmsCampaignConstants.SMS);
        }
    }

    private Long resolveProviderId(final Long campaignId) {
        if (campaignId == null) {
            return null;
        }
        return smsCampaignRepository.findById(campaignId).map(c -> c.getProviderId()).orElse(null);
    }

    @java.lang.SuppressWarnings("all")
        public SendMessageToSmsGatewayTasklet(final SmsMessagePort smsMessagePort, final SmsCampaignRepository smsCampaignRepository, final NotificationSenderService notificationSenderService, final SmsConfigUtils smsConfigUtils, final ThreadPoolTaskExecutor taskExecutor) {
        this.smsMessagePort = smsMessagePort;
        this.smsCampaignRepository = smsCampaignRepository;
        this.notificationSenderService = notificationSenderService;
        this.smsConfigUtils = smsConfigUtils;
        this.taskExecutor = taskExecutor;
    }
}
