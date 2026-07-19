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
package org.apache.fineract.infrastructure.sms.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.apache.fineract.infrastructure.campaigns.sms.domain.SmsCampaign;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.sms.SmsApiConstants;
import org.apache.fineract.organisation.staff.domain.Staff;
import org.apache.fineract.portfolio.client.domain.Client;
import org.apache.fineract.portfolio.group.domain.Group;

@Entity
@Table(name = "sms_messages_outbound")
public class SmsMessage extends AbstractPersistableCustom<Long> {
    @Column(name = "external_id")
    private String externalId;
    @ManyToOne
    @JoinColumn(name = "group_id")
    private Group group;
    @ManyToOne
    @JoinColumn(name = "client_id")
    private Client client;
    @ManyToOne
    @JoinColumn(name = "staff_id")
    private Staff staff;
    @ManyToOne
    @JoinColumn(name = "campaign_id")
    private SmsCampaign smsCampaign;
    @Column(name = "status_enum", nullable = false)
    private Integer statusType;
    @Column(name = "mobile_no", length = 50)
    private String mobileNo;
    @Column(name = "message", nullable = false)
    private String message;
    @Column(name = "submittedon_date")
    private LocalDate submittedOnDate;
    @Column(name = "delivered_on_date")
    private LocalDateTime deliveredOnDate;
    @Column(name = "is_notification")
    private boolean isNotification;

    public static SmsMessage pendingSms(final String externalId, final Group group, final Client client, final Staff staff, final String message, final String mobileNo, final SmsCampaign smsCampaign, final boolean isNotification) {
        return new SmsMessage().setExternalId(externalId).setGroup(group).setClient(client).setStaff(staff).setStatusType(SmsMessageStatusType.PENDING.getValue()).setMessage(message).setMobileNo(mobileNo).setSmsCampaign(smsCampaign).setNotification(isNotification).setSubmittedOnDate(DateUtils.getBusinessLocalDate());
    }

    public static SmsMessage sentSms(final String externalId, final Group group, final Client client, final Staff staff, final String message, final String mobileNo, final SmsCampaign smsCampaign, final boolean isNotification) {
        return new SmsMessage().setExternalId(externalId).setGroup(group).setClient(client).setStaff(staff).setStatusType(SmsMessageStatusType.WAITING_FOR_DELIVERY_REPORT.getValue()).setMessage(message).setMobileNo(mobileNo).setSmsCampaign(smsCampaign).setNotification(isNotification).setSubmittedOnDate(DateUtils.getBusinessLocalDate());
    }

    public static SmsMessage instance(String externalId, final Group group, final Client client, final Staff staff, final SmsMessageStatusType statusType, final String message, final String mobileNo, final SmsCampaign smsCampaign, final boolean isNotification) {
        return new SmsMessage().setExternalId(externalId).setGroup(group).setClient(client).setStaff(staff).setStatusType(statusType.getValue()).setMessage(message).setMobileNo(mobileNo).setSmsCampaign(smsCampaign).setNotification(isNotification).setSubmittedOnDate(DateUtils.getBusinessLocalDate());
    }

    public Map<String, Object> update(final JsonCommand command) {
        final Map<String, Object> actualChanges = new LinkedHashMap<>(1);
        if (command.isChangeInStringParameterNamed(SmsApiConstants.messageParamName, this.message)) {
            final String newValue = command.stringValueOfParameterNamed(SmsApiConstants.messageParamName);
            actualChanges.put(SmsApiConstants.messageParamName, newValue);
            this.message = StringUtils.defaultIfEmpty(newValue, null);
        }
        return actualChanges;
    }

    @java.lang.SuppressWarnings("all")
        public String getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public Group getGroup() {
        return this.group;
    }

    @java.lang.SuppressWarnings("all")
        public Client getClient() {
        return this.client;
    }

    @java.lang.SuppressWarnings("all")
        public Staff getStaff() {
        return this.staff;
    }

    @java.lang.SuppressWarnings("all")
        public SmsCampaign getSmsCampaign() {
        return this.smsCampaign;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getStatusType() {
        return this.statusType;
    }

    @java.lang.SuppressWarnings("all")
        public String getMobileNo() {
        return this.mobileNo;
    }

    @java.lang.SuppressWarnings("all")
        public String getMessage() {
        return this.message;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSubmittedOnDate() {
        return this.submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDateTime getDeliveredOnDate() {
        return this.deliveredOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isNotification() {
        return this.isNotification;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessage setExternalId(final String externalId) {
        this.externalId = externalId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessage setGroup(final Group group) {
        this.group = group;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessage setClient(final Client client) {
        this.client = client;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessage setStaff(final Staff staff) {
        this.staff = staff;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessage setSmsCampaign(final SmsCampaign smsCampaign) {
        this.smsCampaign = smsCampaign;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessage setStatusType(final Integer statusType) {
        this.statusType = statusType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessage setMobileNo(final String mobileNo) {
        this.mobileNo = mobileNo;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessage setMessage(final String message) {
        this.message = message;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessage setSubmittedOnDate(final LocalDate submittedOnDate) {
        this.submittedOnDate = submittedOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessage setDeliveredOnDate(final LocalDateTime deliveredOnDate) {
        this.deliveredOnDate = deliveredOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SmsMessage setNotification(final boolean isNotification) {
        this.isNotification = isNotification;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public SmsMessage() {
    }
}
