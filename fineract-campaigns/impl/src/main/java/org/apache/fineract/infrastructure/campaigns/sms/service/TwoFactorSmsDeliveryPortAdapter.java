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
package org.apache.fineract.infrastructure.campaigns.sms.service;

import java.util.Collections;
import org.apache.fineract.infrastructure.sms.domain.SmsMessage;
import org.apache.fineract.infrastructure.sms.domain.SmsMessageRepository;
import org.apache.fineract.infrastructure.sms.scheduler.SmsMessageScheduledJobService;
import org.apache.fineract.organisation.staff.domain.Staff;
import org.apache.fineract.portfolio.client.domain.Client;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TwoFactorSmsDeliveryPortAdapter implements TwoFactorSmsDeliveryPort {

    private final SmsMessageRepository smsMessageRepository;
    private final SmsMessageScheduledJobService smsMessageScheduledJobService;

    public TwoFactorSmsDeliveryPortAdapter(final SmsMessageRepository smsMessageRepository,
            final SmsMessageScheduledJobService smsMessageScheduledJobService) {
        this.smsMessageRepository = smsMessageRepository;
        this.smsMessageScheduledJobService = smsMessageScheduledJobService;
    }

    @Override
    @Transactional
    public void deliverOtpSms(final Staff staff, final String mobileNo, final String messageText, final long smsProviderId) {
        persistAndTrigger(SmsMessage.pendingSms(null, null, null, staff, messageText, mobileNo, null, false), smsProviderId);
    }

    @Override
    @Transactional
    public void deliverClientSms(final Client client, final String messageText, final long smsProviderId) {
        persistAndTrigger(SmsMessage.pendingSms(null, null, client, null, messageText, client.mobileNo(), null, false),
                smsProviderId);
    }

    private void persistAndTrigger(final SmsMessage smsMessage, final long smsProviderId) {
        this.smsMessageRepository.save(smsMessage);
        this.smsMessageScheduledJobService.sendTriggeredMessage(Collections.singleton(smsMessage), smsProviderId);
    }
}
