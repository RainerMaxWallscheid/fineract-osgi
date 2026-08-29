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
package org.apache.fineract.infrastructure.sms.service;

import java.time.LocalDateTime;
import java.util.List;
import org.apache.fineract.infrastructure.sms.domain.SmsMessage;
import org.apache.fineract.infrastructure.sms.domain.SmsMessageRepository;
import org.apache.fineract.infrastructure.sms.domain.SmsMessageStatusType;
import org.apache.fineract.organisation.staff.domain.Staff;
import org.apache.fineract.organisation.staff.domain.StaffRepository;
import org.apache.fineract.portfolio.client.domain.Client;
import org.apache.fineract.portfolio.client.domain.ClientRepository;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SmsMessagePortAdapter implements SmsMessagePort {

    private final SmsMessageRepository smsMessageRepository;
    private final ClientRepository clientRepository;
    private final StaffRepository staffRepository;

    public SmsMessagePortAdapter(final SmsMessageRepository smsMessageRepository, final ClientRepository clientRepository,
            final StaffRepository staffRepository) {
        this.smsMessageRepository = smsMessageRepository;
        this.clientRepository = clientRepository;
        this.staffRepository = staffRepository;
    }

    @Override
    @Transactional
    public OutboundView persistPending(final PendingRequest request) {
        final Client client = request.clientId() == null ? null : this.clientRepository.findById(request.clientId()).orElse(null);
        final Staff staff = request.staffId() == null ? null : this.staffRepository.findById(request.staffId()).orElse(null);
        final SmsMessage message = SmsMessage.pendingSms(null, null, client, staff, request.message(), request.mobileNo(),
                request.campaignId(), request.notification());
        return toView(this.smsMessageRepository.save(message));
    }

    @Override
    public List<OutboundView> findPending(final int limit) {
        return this.smsMessageRepository.findByStatusType(SmsMessageStatusType.PENDING.getValue(), PageRequest.of(0, limit)).getContent()
                .stream().map(this::toView).toList();
    }

    @Override
    @Transactional
    public void markWaitingForDelivery(final List<Long> ids) {
        if (ids == null || ids.isEmpty()) {
            return;
        }
        final List<SmsMessage> messages = this.smsMessageRepository.findAllById(ids);
        for (final SmsMessage message : messages) {
            message.setStatusType(SmsMessageStatusType.WAITING_FOR_DELIVERY_REPORT.getValue());
        }
        this.smsMessageRepository.saveAll(messages);
        this.smsMessageRepository.flush();
    }

    @Override
    @Transactional
    public void applyDeliveryReport(final Long id, final Integer statusType, final String externalId) {
        this.smsMessageRepository.findById(id).ifPresent(message -> {
            if (statusType != null) {
                message.setStatusType(statusType);
            }
            message.setExternalId(externalId);
            this.smsMessageRepository.save(message);
        });
    }

    @Override
    @Transactional
    public void markSent(final Long id, final LocalDateTime deliveredOnDate) {
        this.smsMessageRepository.findById(id).ifPresent(message -> {
            message.setStatusType(SmsMessageStatusType.SENT.getValue());
            message.setDeliveredOnDate(deliveredOnDate);
            this.smsMessageRepository.save(message);
        });
    }

    @Override
    @Transactional
    public void markFailed(final Long id) {
        this.smsMessageRepository.findById(id).ifPresent(message -> {
            message.setStatusType(SmsMessageStatusType.FAILED.getValue());
            this.smsMessageRepository.save(message);
        });
    }

    private OutboundView toView(final SmsMessage message) {
        final Long clientId = message.getClient() == null ? null : message.getClient().getId();
        return new OutboundView(message.getId(), clientId, message.getCampaignId(), message.getMobileNo(), message.getMessage(),
                message.isNotification(), message.getStatusType());
    }
}
