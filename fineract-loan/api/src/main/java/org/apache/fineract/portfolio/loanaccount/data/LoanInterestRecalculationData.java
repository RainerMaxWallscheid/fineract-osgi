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
package org.apache.fineract.portfolio.loanaccount.data;

import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.portfolio.calendar.data.CalendarData;

public class LoanInterestRecalculationData {
    private Long id;
    private Long loanId;
    private EnumOptionData interestRecalculationCompoundingType;
    private EnumOptionData rescheduleStrategyType;
    private CalendarData calendarData;
    private EnumOptionData recalculationRestFrequencyType;
    private Integer recalculationRestFrequencyInterval;
    private EnumOptionData recalculationRestFrequencyNthDay;
    private EnumOptionData recalculationRestFrequencyWeekday;
    private Integer recalculationRestFrequencyOnDay;
    private EnumOptionData recalculationCompoundingFrequencyType;
    private Integer recalculationCompoundingFrequencyInterval;
    private EnumOptionData recalculationCompoundingFrequencyNthDay;
    private EnumOptionData recalculationCompoundingFrequencyWeekday;
    private Integer recalculationCompoundingFrequencyOnDay;
    private Boolean isCompoundingToBePostedAsTransaction;
    private CalendarData compoundingCalendarData;
    private Boolean allowCompoundingOnEod;
    private Boolean disallowInterestCalculationOnPastDue;

    public LoanInterestRecalculationData(final Long id, final Long loanId, final EnumOptionData interestRecalculationCompoundingType, final EnumOptionData rescheduleStrategyType, final CalendarData calendarData, final EnumOptionData recalculationRestFrequencyType, final Integer recalculationRestFrequencyInterval, final EnumOptionData recalculationRestFrequencyNthDay, final EnumOptionData recalculationRestFrequencyWeekday, final Integer recalculationRestFrequencyOnDay, final CalendarData compoundingCalendarData, final EnumOptionData recalculationCompoundingFrequencyType, final Integer recalculationCompoundingFrequencyInterval, final EnumOptionData recalculationCompoundingFrequencyNthDay, final EnumOptionData recalculationCompoundingFrequencyWeekday, final Integer recalculationCompoundingFrequencyOnDay, final Boolean isCompoundingToBePostedAsTransaction, final Boolean allowCompoundingOnEod, final Boolean disallowInterestCalculationOnPastDue) {
        this.id = id;
        this.loanId = loanId;
        this.interestRecalculationCompoundingType = interestRecalculationCompoundingType;
        this.rescheduleStrategyType = rescheduleStrategyType;
        this.calendarData = calendarData;
        this.recalculationRestFrequencyType = recalculationRestFrequencyType;
        this.recalculationRestFrequencyInterval = recalculationRestFrequencyInterval;
        this.recalculationRestFrequencyNthDay = recalculationRestFrequencyNthDay;
        this.recalculationRestFrequencyWeekday = recalculationRestFrequencyWeekday;
        this.recalculationRestFrequencyOnDay = recalculationRestFrequencyOnDay;
        this.recalculationCompoundingFrequencyType = recalculationCompoundingFrequencyType;
        this.recalculationCompoundingFrequencyInterval = recalculationCompoundingFrequencyInterval;
        this.recalculationCompoundingFrequencyNthDay = recalculationCompoundingFrequencyNthDay;
        this.recalculationCompoundingFrequencyWeekday = recalculationCompoundingFrequencyWeekday;
        this.recalculationCompoundingFrequencyOnDay = recalculationCompoundingFrequencyOnDay;
        this.compoundingCalendarData = compoundingCalendarData;
        this.isCompoundingToBePostedAsTransaction = isCompoundingToBePostedAsTransaction;
        this.allowCompoundingOnEod = allowCompoundingOnEod;
        this.disallowInterestCalculationOnPastDue = disallowInterestCalculationOnPastDue;
    }

    public LoanInterestRecalculationData withCalendarData(final CalendarData calendarData, CalendarData compoundingCalendarData) {
        return this.setCalendarData(calendarData).setCompoundingCalendarData(compoundingCalendarData);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getInterestRecalculationCompoundingType() {
        return this.interestRecalculationCompoundingType;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getRescheduleStrategyType() {
        return this.rescheduleStrategyType;
    }

    @java.lang.SuppressWarnings("all")
        public CalendarData getCalendarData() {
        return this.calendarData;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getRecalculationRestFrequencyType() {
        return this.recalculationRestFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRecalculationRestFrequencyInterval() {
        return this.recalculationRestFrequencyInterval;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getRecalculationRestFrequencyNthDay() {
        return this.recalculationRestFrequencyNthDay;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getRecalculationRestFrequencyWeekday() {
        return this.recalculationRestFrequencyWeekday;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRecalculationRestFrequencyOnDay() {
        return this.recalculationRestFrequencyOnDay;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getRecalculationCompoundingFrequencyType() {
        return this.recalculationCompoundingFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRecalculationCompoundingFrequencyInterval() {
        return this.recalculationCompoundingFrequencyInterval;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getRecalculationCompoundingFrequencyNthDay() {
        return this.recalculationCompoundingFrequencyNthDay;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getRecalculationCompoundingFrequencyWeekday() {
        return this.recalculationCompoundingFrequencyWeekday;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRecalculationCompoundingFrequencyOnDay() {
        return this.recalculationCompoundingFrequencyOnDay;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsCompoundingToBePostedAsTransaction() {
        return this.isCompoundingToBePostedAsTransaction;
    }

    @java.lang.SuppressWarnings("all")
        public CalendarData getCompoundingCalendarData() {
        return this.compoundingCalendarData;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getAllowCompoundingOnEod() {
        return this.allowCompoundingOnEod;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getDisallowInterestCalculationOnPastDue() {
        return this.disallowInterestCalculationOnPastDue;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setLoanId(final Long loanId) {
        this.loanId = loanId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setInterestRecalculationCompoundingType(final EnumOptionData interestRecalculationCompoundingType) {
        this.interestRecalculationCompoundingType = interestRecalculationCompoundingType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setRescheduleStrategyType(final EnumOptionData rescheduleStrategyType) {
        this.rescheduleStrategyType = rescheduleStrategyType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setCalendarData(final CalendarData calendarData) {
        this.calendarData = calendarData;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setRecalculationRestFrequencyType(final EnumOptionData recalculationRestFrequencyType) {
        this.recalculationRestFrequencyType = recalculationRestFrequencyType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setRecalculationRestFrequencyInterval(final Integer recalculationRestFrequencyInterval) {
        this.recalculationRestFrequencyInterval = recalculationRestFrequencyInterval;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setRecalculationRestFrequencyNthDay(final EnumOptionData recalculationRestFrequencyNthDay) {
        this.recalculationRestFrequencyNthDay = recalculationRestFrequencyNthDay;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setRecalculationRestFrequencyWeekday(final EnumOptionData recalculationRestFrequencyWeekday) {
        this.recalculationRestFrequencyWeekday = recalculationRestFrequencyWeekday;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setRecalculationRestFrequencyOnDay(final Integer recalculationRestFrequencyOnDay) {
        this.recalculationRestFrequencyOnDay = recalculationRestFrequencyOnDay;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setRecalculationCompoundingFrequencyType(final EnumOptionData recalculationCompoundingFrequencyType) {
        this.recalculationCompoundingFrequencyType = recalculationCompoundingFrequencyType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setRecalculationCompoundingFrequencyInterval(final Integer recalculationCompoundingFrequencyInterval) {
        this.recalculationCompoundingFrequencyInterval = recalculationCompoundingFrequencyInterval;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setRecalculationCompoundingFrequencyNthDay(final EnumOptionData recalculationCompoundingFrequencyNthDay) {
        this.recalculationCompoundingFrequencyNthDay = recalculationCompoundingFrequencyNthDay;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setRecalculationCompoundingFrequencyWeekday(final EnumOptionData recalculationCompoundingFrequencyWeekday) {
        this.recalculationCompoundingFrequencyWeekday = recalculationCompoundingFrequencyWeekday;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setRecalculationCompoundingFrequencyOnDay(final Integer recalculationCompoundingFrequencyOnDay) {
        this.recalculationCompoundingFrequencyOnDay = recalculationCompoundingFrequencyOnDay;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setIsCompoundingToBePostedAsTransaction(final Boolean isCompoundingToBePostedAsTransaction) {
        this.isCompoundingToBePostedAsTransaction = isCompoundingToBePostedAsTransaction;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setCompoundingCalendarData(final CalendarData compoundingCalendarData) {
        this.compoundingCalendarData = compoundingCalendarData;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setAllowCompoundingOnEod(final Boolean allowCompoundingOnEod) {
        this.allowCompoundingOnEod = allowCompoundingOnEod;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData setDisallowInterestCalculationOnPastDue(final Boolean disallowInterestCalculationOnPastDue) {
        this.disallowInterestCalculationOnPastDue = disallowInterestCalculationOnPastDue;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanInterestRecalculationData)) return false;
        final LoanInterestRecalculationData other = (LoanInterestRecalculationData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$loanId = this.getLoanId();
        final java.lang.Object other$loanId = other.getLoanId();
        if (this$loanId == null ? other$loanId != null : !this$loanId.equals(other$loanId)) return false;
        final java.lang.Object this$recalculationRestFrequencyInterval = this.getRecalculationRestFrequencyInterval();
        final java.lang.Object other$recalculationRestFrequencyInterval = other.getRecalculationRestFrequencyInterval();
        if (this$recalculationRestFrequencyInterval == null ? other$recalculationRestFrequencyInterval != null : !this$recalculationRestFrequencyInterval.equals(other$recalculationRestFrequencyInterval)) return false;
        final java.lang.Object this$recalculationRestFrequencyOnDay = this.getRecalculationRestFrequencyOnDay();
        final java.lang.Object other$recalculationRestFrequencyOnDay = other.getRecalculationRestFrequencyOnDay();
        if (this$recalculationRestFrequencyOnDay == null ? other$recalculationRestFrequencyOnDay != null : !this$recalculationRestFrequencyOnDay.equals(other$recalculationRestFrequencyOnDay)) return false;
        final java.lang.Object this$recalculationCompoundingFrequencyInterval = this.getRecalculationCompoundingFrequencyInterval();
        final java.lang.Object other$recalculationCompoundingFrequencyInterval = other.getRecalculationCompoundingFrequencyInterval();
        if (this$recalculationCompoundingFrequencyInterval == null ? other$recalculationCompoundingFrequencyInterval != null : !this$recalculationCompoundingFrequencyInterval.equals(other$recalculationCompoundingFrequencyInterval)) return false;
        final java.lang.Object this$recalculationCompoundingFrequencyOnDay = this.getRecalculationCompoundingFrequencyOnDay();
        final java.lang.Object other$recalculationCompoundingFrequencyOnDay = other.getRecalculationCompoundingFrequencyOnDay();
        if (this$recalculationCompoundingFrequencyOnDay == null ? other$recalculationCompoundingFrequencyOnDay != null : !this$recalculationCompoundingFrequencyOnDay.equals(other$recalculationCompoundingFrequencyOnDay)) return false;
        final java.lang.Object this$isCompoundingToBePostedAsTransaction = this.getIsCompoundingToBePostedAsTransaction();
        final java.lang.Object other$isCompoundingToBePostedAsTransaction = other.getIsCompoundingToBePostedAsTransaction();
        if (this$isCompoundingToBePostedAsTransaction == null ? other$isCompoundingToBePostedAsTransaction != null : !this$isCompoundingToBePostedAsTransaction.equals(other$isCompoundingToBePostedAsTransaction)) return false;
        final java.lang.Object this$allowCompoundingOnEod = this.getAllowCompoundingOnEod();
        final java.lang.Object other$allowCompoundingOnEod = other.getAllowCompoundingOnEod();
        if (this$allowCompoundingOnEod == null ? other$allowCompoundingOnEod != null : !this$allowCompoundingOnEod.equals(other$allowCompoundingOnEod)) return false;
        final java.lang.Object this$disallowInterestCalculationOnPastDue = this.getDisallowInterestCalculationOnPastDue();
        final java.lang.Object other$disallowInterestCalculationOnPastDue = other.getDisallowInterestCalculationOnPastDue();
        if (this$disallowInterestCalculationOnPastDue == null ? other$disallowInterestCalculationOnPastDue != null : !this$disallowInterestCalculationOnPastDue.equals(other$disallowInterestCalculationOnPastDue)) return false;
        final java.lang.Object this$interestRecalculationCompoundingType = this.getInterestRecalculationCompoundingType();
        final java.lang.Object other$interestRecalculationCompoundingType = other.getInterestRecalculationCompoundingType();
        if (this$interestRecalculationCompoundingType == null ? other$interestRecalculationCompoundingType != null : !this$interestRecalculationCompoundingType.equals(other$interestRecalculationCompoundingType)) return false;
        final java.lang.Object this$rescheduleStrategyType = this.getRescheduleStrategyType();
        final java.lang.Object other$rescheduleStrategyType = other.getRescheduleStrategyType();
        if (this$rescheduleStrategyType == null ? other$rescheduleStrategyType != null : !this$rescheduleStrategyType.equals(other$rescheduleStrategyType)) return false;
        final java.lang.Object this$calendarData = this.getCalendarData();
        final java.lang.Object other$calendarData = other.getCalendarData();
        if (this$calendarData == null ? other$calendarData != null : !this$calendarData.equals(other$calendarData)) return false;
        final java.lang.Object this$recalculationRestFrequencyType = this.getRecalculationRestFrequencyType();
        final java.lang.Object other$recalculationRestFrequencyType = other.getRecalculationRestFrequencyType();
        if (this$recalculationRestFrequencyType == null ? other$recalculationRestFrequencyType != null : !this$recalculationRestFrequencyType.equals(other$recalculationRestFrequencyType)) return false;
        final java.lang.Object this$recalculationRestFrequencyNthDay = this.getRecalculationRestFrequencyNthDay();
        final java.lang.Object other$recalculationRestFrequencyNthDay = other.getRecalculationRestFrequencyNthDay();
        if (this$recalculationRestFrequencyNthDay == null ? other$recalculationRestFrequencyNthDay != null : !this$recalculationRestFrequencyNthDay.equals(other$recalculationRestFrequencyNthDay)) return false;
        final java.lang.Object this$recalculationRestFrequencyWeekday = this.getRecalculationRestFrequencyWeekday();
        final java.lang.Object other$recalculationRestFrequencyWeekday = other.getRecalculationRestFrequencyWeekday();
        if (this$recalculationRestFrequencyWeekday == null ? other$recalculationRestFrequencyWeekday != null : !this$recalculationRestFrequencyWeekday.equals(other$recalculationRestFrequencyWeekday)) return false;
        final java.lang.Object this$recalculationCompoundingFrequencyType = this.getRecalculationCompoundingFrequencyType();
        final java.lang.Object other$recalculationCompoundingFrequencyType = other.getRecalculationCompoundingFrequencyType();
        if (this$recalculationCompoundingFrequencyType == null ? other$recalculationCompoundingFrequencyType != null : !this$recalculationCompoundingFrequencyType.equals(other$recalculationCompoundingFrequencyType)) return false;
        final java.lang.Object this$recalculationCompoundingFrequencyNthDay = this.getRecalculationCompoundingFrequencyNthDay();
        final java.lang.Object other$recalculationCompoundingFrequencyNthDay = other.getRecalculationCompoundingFrequencyNthDay();
        if (this$recalculationCompoundingFrequencyNthDay == null ? other$recalculationCompoundingFrequencyNthDay != null : !this$recalculationCompoundingFrequencyNthDay.equals(other$recalculationCompoundingFrequencyNthDay)) return false;
        final java.lang.Object this$recalculationCompoundingFrequencyWeekday = this.getRecalculationCompoundingFrequencyWeekday();
        final java.lang.Object other$recalculationCompoundingFrequencyWeekday = other.getRecalculationCompoundingFrequencyWeekday();
        if (this$recalculationCompoundingFrequencyWeekday == null ? other$recalculationCompoundingFrequencyWeekday != null : !this$recalculationCompoundingFrequencyWeekday.equals(other$recalculationCompoundingFrequencyWeekday)) return false;
        final java.lang.Object this$compoundingCalendarData = this.getCompoundingCalendarData();
        final java.lang.Object other$compoundingCalendarData = other.getCompoundingCalendarData();
        if (this$compoundingCalendarData == null ? other$compoundingCalendarData != null : !this$compoundingCalendarData.equals(other$compoundingCalendarData)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanInterestRecalculationData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $loanId = this.getLoanId();
        result = result * PRIME + ($loanId == null ? 43 : $loanId.hashCode());
        final java.lang.Object $recalculationRestFrequencyInterval = this.getRecalculationRestFrequencyInterval();
        result = result * PRIME + ($recalculationRestFrequencyInterval == null ? 43 : $recalculationRestFrequencyInterval.hashCode());
        final java.lang.Object $recalculationRestFrequencyOnDay = this.getRecalculationRestFrequencyOnDay();
        result = result * PRIME + ($recalculationRestFrequencyOnDay == null ? 43 : $recalculationRestFrequencyOnDay.hashCode());
        final java.lang.Object $recalculationCompoundingFrequencyInterval = this.getRecalculationCompoundingFrequencyInterval();
        result = result * PRIME + ($recalculationCompoundingFrequencyInterval == null ? 43 : $recalculationCompoundingFrequencyInterval.hashCode());
        final java.lang.Object $recalculationCompoundingFrequencyOnDay = this.getRecalculationCompoundingFrequencyOnDay();
        result = result * PRIME + ($recalculationCompoundingFrequencyOnDay == null ? 43 : $recalculationCompoundingFrequencyOnDay.hashCode());
        final java.lang.Object $isCompoundingToBePostedAsTransaction = this.getIsCompoundingToBePostedAsTransaction();
        result = result * PRIME + ($isCompoundingToBePostedAsTransaction == null ? 43 : $isCompoundingToBePostedAsTransaction.hashCode());
        final java.lang.Object $allowCompoundingOnEod = this.getAllowCompoundingOnEod();
        result = result * PRIME + ($allowCompoundingOnEod == null ? 43 : $allowCompoundingOnEod.hashCode());
        final java.lang.Object $disallowInterestCalculationOnPastDue = this.getDisallowInterestCalculationOnPastDue();
        result = result * PRIME + ($disallowInterestCalculationOnPastDue == null ? 43 : $disallowInterestCalculationOnPastDue.hashCode());
        final java.lang.Object $interestRecalculationCompoundingType = this.getInterestRecalculationCompoundingType();
        result = result * PRIME + ($interestRecalculationCompoundingType == null ? 43 : $interestRecalculationCompoundingType.hashCode());
        final java.lang.Object $rescheduleStrategyType = this.getRescheduleStrategyType();
        result = result * PRIME + ($rescheduleStrategyType == null ? 43 : $rescheduleStrategyType.hashCode());
        final java.lang.Object $calendarData = this.getCalendarData();
        result = result * PRIME + ($calendarData == null ? 43 : $calendarData.hashCode());
        final java.lang.Object $recalculationRestFrequencyType = this.getRecalculationRestFrequencyType();
        result = result * PRIME + ($recalculationRestFrequencyType == null ? 43 : $recalculationRestFrequencyType.hashCode());
        final java.lang.Object $recalculationRestFrequencyNthDay = this.getRecalculationRestFrequencyNthDay();
        result = result * PRIME + ($recalculationRestFrequencyNthDay == null ? 43 : $recalculationRestFrequencyNthDay.hashCode());
        final java.lang.Object $recalculationRestFrequencyWeekday = this.getRecalculationRestFrequencyWeekday();
        result = result * PRIME + ($recalculationRestFrequencyWeekday == null ? 43 : $recalculationRestFrequencyWeekday.hashCode());
        final java.lang.Object $recalculationCompoundingFrequencyType = this.getRecalculationCompoundingFrequencyType();
        result = result * PRIME + ($recalculationCompoundingFrequencyType == null ? 43 : $recalculationCompoundingFrequencyType.hashCode());
        final java.lang.Object $recalculationCompoundingFrequencyNthDay = this.getRecalculationCompoundingFrequencyNthDay();
        result = result * PRIME + ($recalculationCompoundingFrequencyNthDay == null ? 43 : $recalculationCompoundingFrequencyNthDay.hashCode());
        final java.lang.Object $recalculationCompoundingFrequencyWeekday = this.getRecalculationCompoundingFrequencyWeekday();
        result = result * PRIME + ($recalculationCompoundingFrequencyWeekday == null ? 43 : $recalculationCompoundingFrequencyWeekday.hashCode());
        final java.lang.Object $compoundingCalendarData = this.getCompoundingCalendarData();
        result = result * PRIME + ($compoundingCalendarData == null ? 43 : $compoundingCalendarData.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanInterestRecalculationData(id=" + this.getId() + ", loanId=" + this.getLoanId() + ", interestRecalculationCompoundingType=" + this.getInterestRecalculationCompoundingType() + ", rescheduleStrategyType=" + this.getRescheduleStrategyType() + ", calendarData=" + this.getCalendarData() + ", recalculationRestFrequencyType=" + this.getRecalculationRestFrequencyType() + ", recalculationRestFrequencyInterval=" + this.getRecalculationRestFrequencyInterval() + ", recalculationRestFrequencyNthDay=" + this.getRecalculationRestFrequencyNthDay() + ", recalculationRestFrequencyWeekday=" + this.getRecalculationRestFrequencyWeekday() + ", recalculationRestFrequencyOnDay=" + this.getRecalculationRestFrequencyOnDay() + ", recalculationCompoundingFrequencyType=" + this.getRecalculationCompoundingFrequencyType() + ", recalculationCompoundingFrequencyInterval=" + this.getRecalculationCompoundingFrequencyInterval() + ", recalculationCompoundingFrequencyNthDay=" + this.getRecalculationCompoundingFrequencyNthDay() + ", recalculationCompoundingFrequencyWeekday=" + this.getRecalculationCompoundingFrequencyWeekday() + ", recalculationCompoundingFrequencyOnDay=" + this.getRecalculationCompoundingFrequencyOnDay() + ", isCompoundingToBePostedAsTransaction=" + this.getIsCompoundingToBePostedAsTransaction() + ", compoundingCalendarData=" + this.getCompoundingCalendarData() + ", allowCompoundingOnEod=" + this.getAllowCompoundingOnEod() + ", disallowInterestCalculationOnPastDue=" + this.getDisallowInterestCalculationOnPastDue() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanInterestRecalculationData() {
    }
}
