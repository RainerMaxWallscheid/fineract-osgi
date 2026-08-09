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
package org.apache.fineract.infrastructure.campaigns.sms.data;

import java.time.LocalDate;
import java.time.ZonedDateTime;
import java.util.Collection;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;

@SuppressWarnings("unused")
public final class SmsCampaignData {
    private Long id;
    private final String campaignName;
    private final EnumOptionData campaignType;
    private final Long runReportId;
    private final String reportName;
    private final String paramValue;
    private final EnumOptionData campaignStatus;
    private final EnumOptionData triggerType;
    private final String campaignMessage;
    private final ZonedDateTime nextTriggerDate;
    private final LocalDate lastTriggerDate;
    private final SmsCampaignTimeLine smsCampaignTimeLine;
    private final ZonedDateTime recurrenceStartDate;
    private final String recurrence;
    private final Long providerId;
    private final boolean isNotification;
    private final Collection<SmsProviderData> smsProviderOptions;
    private final Collection<EnumOptionData> campaignTypeOptions;
    private final Collection<EnumOptionData> triggerTypeOptions;
    private final Collection<SmsBusinessRulesData> businessRulesOptions;
    private final Collection<EnumOptionData> months;
    private final Collection<EnumOptionData> weekDays;
    private final Collection<EnumOptionData> frequencyTypeOptions;
    private final Collection<EnumOptionData> periodFrequencyOptions;

    public static SmsCampaignData instance(final Long id, final String campaignName, final EnumOptionData campaignType, final EnumOptionData triggerType, final Long runReportId, final String reportName, final String paramValue, final EnumOptionData campaignStatus, final String message, final ZonedDateTime nextTriggerDate, final LocalDate lastTriggerDate, final SmsCampaignTimeLine smsCampaignTimeLine, final ZonedDateTime recurrenceStartDate, final String recurrence, final Long providerId, final boolean isNotification) {
        return SmsCampaignData.builder().id(id).campaignName(campaignName).campaignType(campaignType).triggerType(triggerType).runReportId(runReportId).reportName(reportName).paramValue(paramValue).campaignStatus(campaignStatus).campaignMessage(message).nextTriggerDate(nextTriggerDate).lastTriggerDate(lastTriggerDate).smsCampaignTimeLine(smsCampaignTimeLine).recurrenceStartDate(recurrenceStartDate).recurrence(recurrence).providerId(providerId).isNotification(isNotification).build();
    }

    public static SmsCampaignData template(final Collection<SmsProviderData> smsProviderOptions, final Collection<EnumOptionData> campaignTypeOptions, final Collection<SmsBusinessRulesData> businessRulesOptions, final Collection<EnumOptionData> triggerTypeOptions, final Collection<EnumOptionData> months, final Collection<EnumOptionData> weekDays, final Collection<EnumOptionData> frequencyTypeOptions, final Collection<EnumOptionData> periodFrequencyOptions) {
        return SmsCampaignData.builder().smsProviderOptions(smsProviderOptions).businessRulesOptions(businessRulesOptions).campaignTypeOptions(campaignTypeOptions).triggerTypeOptions(triggerTypeOptions).months(months).weekDays(weekDays).frequencyTypeOptions(frequencyTypeOptions).periodFrequencyOptions(periodFrequencyOptions).build();
    }

    @java.lang.SuppressWarnings("all")
        SmsCampaignData(final Long id, final String campaignName, final EnumOptionData campaignType, final Long runReportId, final String reportName, final String paramValue, final EnumOptionData campaignStatus, final EnumOptionData triggerType, final String campaignMessage, final ZonedDateTime nextTriggerDate, final LocalDate lastTriggerDate, final SmsCampaignTimeLine smsCampaignTimeLine, final ZonedDateTime recurrenceStartDate, final String recurrence, final Long providerId, final boolean isNotification, final Collection<SmsProviderData> smsProviderOptions, final Collection<EnumOptionData> campaignTypeOptions, final Collection<EnumOptionData> triggerTypeOptions, final Collection<SmsBusinessRulesData> businessRulesOptions, final Collection<EnumOptionData> months, final Collection<EnumOptionData> weekDays, final Collection<EnumOptionData> frequencyTypeOptions, final Collection<EnumOptionData> periodFrequencyOptions) {
        this.id = id;
        this.campaignName = campaignName;
        this.campaignType = campaignType;
        this.runReportId = runReportId;
        this.reportName = reportName;
        this.paramValue = paramValue;
        this.campaignStatus = campaignStatus;
        this.triggerType = triggerType;
        this.campaignMessage = campaignMessage;
        this.nextTriggerDate = nextTriggerDate;
        this.lastTriggerDate = lastTriggerDate;
        this.smsCampaignTimeLine = smsCampaignTimeLine;
        this.recurrenceStartDate = recurrenceStartDate;
        this.recurrence = recurrence;
        this.providerId = providerId;
        this.isNotification = isNotification;
        this.smsProviderOptions = smsProviderOptions;
        this.campaignTypeOptions = campaignTypeOptions;
        this.triggerTypeOptions = triggerTypeOptions;
        this.businessRulesOptions = businessRulesOptions;
        this.months = months;
        this.weekDays = weekDays;
        this.frequencyTypeOptions = frequencyTypeOptions;
        this.periodFrequencyOptions = periodFrequencyOptions;
    }


    @java.lang.SuppressWarnings("all")
        public static class SmsCampaignDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String campaignName;
        @java.lang.SuppressWarnings("all")
                private EnumOptionData campaignType;
        @java.lang.SuppressWarnings("all")
                private Long runReportId;
        @java.lang.SuppressWarnings("all")
                private String reportName;
        @java.lang.SuppressWarnings("all")
                private String paramValue;
        @java.lang.SuppressWarnings("all")
                private EnumOptionData campaignStatus;
        @java.lang.SuppressWarnings("all")
                private EnumOptionData triggerType;
        @java.lang.SuppressWarnings("all")
                private String campaignMessage;
        @java.lang.SuppressWarnings("all")
                private ZonedDateTime nextTriggerDate;
        @java.lang.SuppressWarnings("all")
                private LocalDate lastTriggerDate;
        @java.lang.SuppressWarnings("all")
                private SmsCampaignTimeLine smsCampaignTimeLine;
        @java.lang.SuppressWarnings("all")
                private ZonedDateTime recurrenceStartDate;
        @java.lang.SuppressWarnings("all")
                private String recurrence;
        @java.lang.SuppressWarnings("all")
                private Long providerId;
        @java.lang.SuppressWarnings("all")
                private boolean isNotification;
        @java.lang.SuppressWarnings("all")
                private Collection<SmsProviderData> smsProviderOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<EnumOptionData> campaignTypeOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<EnumOptionData> triggerTypeOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<SmsBusinessRulesData> businessRulesOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<EnumOptionData> months;
        @java.lang.SuppressWarnings("all")
                private Collection<EnumOptionData> weekDays;
        @java.lang.SuppressWarnings("all")
                private Collection<EnumOptionData> frequencyTypeOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<EnumOptionData> periodFrequencyOptions;

        @java.lang.SuppressWarnings("all")
                SmsCampaignDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder campaignName(final String campaignName) {
            this.campaignName = campaignName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder campaignType(final EnumOptionData campaignType) {
            this.campaignType = campaignType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder runReportId(final Long runReportId) {
            this.runReportId = runReportId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder reportName(final String reportName) {
            this.reportName = reportName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder paramValue(final String paramValue) {
            this.paramValue = paramValue;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder campaignStatus(final EnumOptionData campaignStatus) {
            this.campaignStatus = campaignStatus;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder triggerType(final EnumOptionData triggerType) {
            this.triggerType = triggerType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder campaignMessage(final String campaignMessage) {
            this.campaignMessage = campaignMessage;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder nextTriggerDate(final ZonedDateTime nextTriggerDate) {
            this.nextTriggerDate = nextTriggerDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder lastTriggerDate(final LocalDate lastTriggerDate) {
            this.lastTriggerDate = lastTriggerDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder smsCampaignTimeLine(final SmsCampaignTimeLine smsCampaignTimeLine) {
            this.smsCampaignTimeLine = smsCampaignTimeLine;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder recurrenceStartDate(final ZonedDateTime recurrenceStartDate) {
            this.recurrenceStartDate = recurrenceStartDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder recurrence(final String recurrence) {
            this.recurrence = recurrence;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder providerId(final Long providerId) {
            this.providerId = providerId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder isNotification(final boolean isNotification) {
            this.isNotification = isNotification;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder smsProviderOptions(final Collection<SmsProviderData> smsProviderOptions) {
            this.smsProviderOptions = smsProviderOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder campaignTypeOptions(final Collection<EnumOptionData> campaignTypeOptions) {
            this.campaignTypeOptions = campaignTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder triggerTypeOptions(final Collection<EnumOptionData> triggerTypeOptions) {
            this.triggerTypeOptions = triggerTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder businessRulesOptions(final Collection<SmsBusinessRulesData> businessRulesOptions) {
            this.businessRulesOptions = businessRulesOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder months(final Collection<EnumOptionData> months) {
            this.months = months;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder weekDays(final Collection<EnumOptionData> weekDays) {
            this.weekDays = weekDays;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder frequencyTypeOptions(final Collection<EnumOptionData> frequencyTypeOptions) {
            this.frequencyTypeOptions = frequencyTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SmsCampaignData.SmsCampaignDataBuilder periodFrequencyOptions(final Collection<EnumOptionData> periodFrequencyOptions) {
            this.periodFrequencyOptions = periodFrequencyOptions;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public SmsCampaignData build() {
            return new SmsCampaignData(this.id, this.campaignName, this.campaignType, this.runReportId, this.reportName, this.paramValue, this.campaignStatus, this.triggerType, this.campaignMessage, this.nextTriggerDate, this.lastTriggerDate, this.smsCampaignTimeLine, this.recurrenceStartDate, this.recurrence, this.providerId, this.isNotification, this.smsProviderOptions, this.campaignTypeOptions, this.triggerTypeOptions, this.businessRulesOptions, this.months, this.weekDays, this.frequencyTypeOptions, this.periodFrequencyOptions);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "SmsCampaignData.SmsCampaignDataBuilder(id=" + this.id + ", campaignName=" + this.campaignName + ", campaignType=" + this.campaignType + ", runReportId=" + this.runReportId + ", reportName=" + this.reportName + ", paramValue=" + this.paramValue + ", campaignStatus=" + this.campaignStatus + ", triggerType=" + this.triggerType + ", campaignMessage=" + this.campaignMessage + ", nextTriggerDate=" + this.nextTriggerDate + ", lastTriggerDate=" + this.lastTriggerDate + ", smsCampaignTimeLine=" + this.smsCampaignTimeLine + ", recurrenceStartDate=" + this.recurrenceStartDate + ", recurrence=" + this.recurrence + ", providerId=" + this.providerId + ", isNotification=" + this.isNotification + ", smsProviderOptions=" + this.smsProviderOptions + ", campaignTypeOptions=" + this.campaignTypeOptions + ", triggerTypeOptions=" + this.triggerTypeOptions + ", businessRulesOptions=" + this.businessRulesOptions + ", months=" + this.months + ", weekDays=" + this.weekDays + ", frequencyTypeOptions=" + this.frequencyTypeOptions + ", periodFrequencyOptions=" + this.periodFrequencyOptions + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static SmsCampaignData.SmsCampaignDataBuilder builder() {
        return new SmsCampaignData.SmsCampaignDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getCampaignName() {
        return this.campaignName;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getCampaignType() {
        return this.campaignType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getRunReportId() {
        return this.runReportId;
    }

    @java.lang.SuppressWarnings("all")
        public String getReportName() {
        return this.reportName;
    }

    @java.lang.SuppressWarnings("all")
        public String getParamValue() {
        return this.paramValue;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getCampaignStatus() {
        return this.campaignStatus;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getTriggerType() {
        return this.triggerType;
    }

    @java.lang.SuppressWarnings("all")
        public String getCampaignMessage() {
        return this.campaignMessage;
    }

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getNextTriggerDate() {
        return this.nextTriggerDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getLastTriggerDate() {
        return this.lastTriggerDate;
    }

    @java.lang.SuppressWarnings("all")
        public SmsCampaignTimeLine getSmsCampaignTimeLine() {
        return this.smsCampaignTimeLine;
    }

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getRecurrenceStartDate() {
        return this.recurrenceStartDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getRecurrence() {
        return this.recurrence;
    }

    @java.lang.SuppressWarnings("all")
        public Long getProviderId() {
        return this.providerId;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isNotification() {
        return this.isNotification;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<SmsProviderData> getSmsProviderOptions() {
        return this.smsProviderOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<EnumOptionData> getCampaignTypeOptions() {
        return this.campaignTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<EnumOptionData> getTriggerTypeOptions() {
        return this.triggerTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<SmsBusinessRulesData> getBusinessRulesOptions() {
        return this.businessRulesOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<EnumOptionData> getMonths() {
        return this.months;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<EnumOptionData> getWeekDays() {
        return this.weekDays;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<EnumOptionData> getFrequencyTypeOptions() {
        return this.frequencyTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<EnumOptionData> getPeriodFrequencyOptions() {
        return this.periodFrequencyOptions;
    }
}
