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
package org.apache.fineract.portfolio.account.data.request;

import java.io.Serial;
import java.io.Serializable;

public class StandingInstructionUpdatesRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String amount;
    private String validTill;
    private String dateFormat;
    private String validFrom;
    private String locale;
    private String priority;
    private String recurrenceType;
    private String recurrenceInterval;
    private String instructionType;
    private String recurrenceFrequency;
    private String recurrenceOnMonthDay;
    private String name;
    private String monthDayFormat;
    private String status;

    @java.lang.SuppressWarnings("all")
        public String getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public String getValidTill() {
        return this.validTill;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getValidFrom() {
        return this.validFrom;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getPriority() {
        return this.priority;
    }

    @java.lang.SuppressWarnings("all")
        public String getRecurrenceType() {
        return this.recurrenceType;
    }

    @java.lang.SuppressWarnings("all")
        public String getRecurrenceInterval() {
        return this.recurrenceInterval;
    }

    @java.lang.SuppressWarnings("all")
        public String getInstructionType() {
        return this.instructionType;
    }

    @java.lang.SuppressWarnings("all")
        public String getRecurrenceFrequency() {
        return this.recurrenceFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public String getRecurrenceOnMonthDay() {
        return this.recurrenceOnMonthDay;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getMonthDayFormat() {
        return this.monthDayFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmount(final String amount) {
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public void setValidTill(final String validTill) {
        this.validTill = validTill;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setValidFrom(final String validFrom) {
        this.validFrom = validFrom;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setPriority(final String priority) {
        this.priority = priority;
    }

    @java.lang.SuppressWarnings("all")
        public void setRecurrenceType(final String recurrenceType) {
        this.recurrenceType = recurrenceType;
    }

    @java.lang.SuppressWarnings("all")
        public void setRecurrenceInterval(final String recurrenceInterval) {
        this.recurrenceInterval = recurrenceInterval;
    }

    @java.lang.SuppressWarnings("all")
        public void setInstructionType(final String instructionType) {
        this.instructionType = instructionType;
    }

    @java.lang.SuppressWarnings("all")
        public void setRecurrenceFrequency(final String recurrenceFrequency) {
        this.recurrenceFrequency = recurrenceFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public void setRecurrenceOnMonthDay(final String recurrenceOnMonthDay) {
        this.recurrenceOnMonthDay = recurrenceOnMonthDay;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setMonthDayFormat(final String monthDayFormat) {
        this.monthDayFormat = monthDayFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setStatus(final String status) {
        this.status = status;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof StandingInstructionUpdatesRequest)) return false;
        final StandingInstructionUpdatesRequest other = (StandingInstructionUpdatesRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$amount = this.getAmount();
        final java.lang.Object other$amount = other.getAmount();
        if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
        final java.lang.Object this$validTill = this.getValidTill();
        final java.lang.Object other$validTill = other.getValidTill();
        if (this$validTill == null ? other$validTill != null : !this$validTill.equals(other$validTill)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$validFrom = this.getValidFrom();
        final java.lang.Object other$validFrom = other.getValidFrom();
        if (this$validFrom == null ? other$validFrom != null : !this$validFrom.equals(other$validFrom)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$priority = this.getPriority();
        final java.lang.Object other$priority = other.getPriority();
        if (this$priority == null ? other$priority != null : !this$priority.equals(other$priority)) return false;
        final java.lang.Object this$recurrenceType = this.getRecurrenceType();
        final java.lang.Object other$recurrenceType = other.getRecurrenceType();
        if (this$recurrenceType == null ? other$recurrenceType != null : !this$recurrenceType.equals(other$recurrenceType)) return false;
        final java.lang.Object this$recurrenceInterval = this.getRecurrenceInterval();
        final java.lang.Object other$recurrenceInterval = other.getRecurrenceInterval();
        if (this$recurrenceInterval == null ? other$recurrenceInterval != null : !this$recurrenceInterval.equals(other$recurrenceInterval)) return false;
        final java.lang.Object this$instructionType = this.getInstructionType();
        final java.lang.Object other$instructionType = other.getInstructionType();
        if (this$instructionType == null ? other$instructionType != null : !this$instructionType.equals(other$instructionType)) return false;
        final java.lang.Object this$recurrenceFrequency = this.getRecurrenceFrequency();
        final java.lang.Object other$recurrenceFrequency = other.getRecurrenceFrequency();
        if (this$recurrenceFrequency == null ? other$recurrenceFrequency != null : !this$recurrenceFrequency.equals(other$recurrenceFrequency)) return false;
        final java.lang.Object this$recurrenceOnMonthDay = this.getRecurrenceOnMonthDay();
        final java.lang.Object other$recurrenceOnMonthDay = other.getRecurrenceOnMonthDay();
        if (this$recurrenceOnMonthDay == null ? other$recurrenceOnMonthDay != null : !this$recurrenceOnMonthDay.equals(other$recurrenceOnMonthDay)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$monthDayFormat = this.getMonthDayFormat();
        final java.lang.Object other$monthDayFormat = other.getMonthDayFormat();
        if (this$monthDayFormat == null ? other$monthDayFormat != null : !this$monthDayFormat.equals(other$monthDayFormat)) return false;
        final java.lang.Object this$status = this.getStatus();
        final java.lang.Object other$status = other.getStatus();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof StandingInstructionUpdatesRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $amount = this.getAmount();
        result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
        final java.lang.Object $validTill = this.getValidTill();
        result = result * PRIME + ($validTill == null ? 43 : $validTill.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $validFrom = this.getValidFrom();
        result = result * PRIME + ($validFrom == null ? 43 : $validFrom.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $priority = this.getPriority();
        result = result * PRIME + ($priority == null ? 43 : $priority.hashCode());
        final java.lang.Object $recurrenceType = this.getRecurrenceType();
        result = result * PRIME + ($recurrenceType == null ? 43 : $recurrenceType.hashCode());
        final java.lang.Object $recurrenceInterval = this.getRecurrenceInterval();
        result = result * PRIME + ($recurrenceInterval == null ? 43 : $recurrenceInterval.hashCode());
        final java.lang.Object $instructionType = this.getInstructionType();
        result = result * PRIME + ($instructionType == null ? 43 : $instructionType.hashCode());
        final java.lang.Object $recurrenceFrequency = this.getRecurrenceFrequency();
        result = result * PRIME + ($recurrenceFrequency == null ? 43 : $recurrenceFrequency.hashCode());
        final java.lang.Object $recurrenceOnMonthDay = this.getRecurrenceOnMonthDay();
        result = result * PRIME + ($recurrenceOnMonthDay == null ? 43 : $recurrenceOnMonthDay.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $monthDayFormat = this.getMonthDayFormat();
        result = result * PRIME + ($monthDayFormat == null ? 43 : $monthDayFormat.hashCode());
        final java.lang.Object $status = this.getStatus();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "StandingInstructionUpdatesRequest(amount=" + this.getAmount() + ", validTill=" + this.getValidTill() + ", dateFormat=" + this.getDateFormat() + ", validFrom=" + this.getValidFrom() + ", locale=" + this.getLocale() + ", priority=" + this.getPriority() + ", recurrenceType=" + this.getRecurrenceType() + ", recurrenceInterval=" + this.getRecurrenceInterval() + ", instructionType=" + this.getInstructionType() + ", recurrenceFrequency=" + this.getRecurrenceFrequency() + ", recurrenceOnMonthDay=" + this.getRecurrenceOnMonthDay() + ", name=" + this.getName() + ", monthDayFormat=" + this.getMonthDayFormat() + ", status=" + this.getStatus() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public StandingInstructionUpdatesRequest() {
    }
}
