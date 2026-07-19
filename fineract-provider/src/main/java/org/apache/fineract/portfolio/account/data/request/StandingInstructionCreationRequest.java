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

public class StandingInstructionCreationRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String toOfficeId;
    private String amount;
    private String validTill;
    private String toAccountType;
    private String dateFormat;
    private String recurrenceOnMonthDay;
    private String toAccountId;
    private String fromClientId;
    private String validFrom;
    private String locale;
    private String priority;
    private String recurrenceType;
    private String fromAccountType;
    private String recurrenceInterval;
    private String monthDayFormat;
    private String toClientId;
    private String instructionType;
    private String fromAccountId;
    private String recurrenceFrequency;
    private String fromOfficeId;
    private String name;
    private String transferType;
    private String status;

    @java.lang.SuppressWarnings("all")
        public String getToOfficeId() {
        return this.toOfficeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public String getValidTill() {
        return this.validTill;
    }

    @java.lang.SuppressWarnings("all")
        public String getToAccountType() {
        return this.toAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getRecurrenceOnMonthDay() {
        return this.recurrenceOnMonthDay;
    }

    @java.lang.SuppressWarnings("all")
        public String getToAccountId() {
        return this.toAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public String getFromClientId() {
        return this.fromClientId;
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
        public String getFromAccountType() {
        return this.fromAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public String getRecurrenceInterval() {
        return this.recurrenceInterval;
    }

    @java.lang.SuppressWarnings("all")
        public String getMonthDayFormat() {
        return this.monthDayFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getToClientId() {
        return this.toClientId;
    }

    @java.lang.SuppressWarnings("all")
        public String getInstructionType() {
        return this.instructionType;
    }

    @java.lang.SuppressWarnings("all")
        public String getFromAccountId() {
        return this.fromAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public String getRecurrenceFrequency() {
        return this.recurrenceFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public String getFromOfficeId() {
        return this.fromOfficeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransferType() {
        return this.transferType;
    }

    @java.lang.SuppressWarnings("all")
        public String getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public void setToOfficeId(final String toOfficeId) {
        this.toOfficeId = toOfficeId;
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
        public void setToAccountType(final String toAccountType) {
        this.toAccountType = toAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setRecurrenceOnMonthDay(final String recurrenceOnMonthDay) {
        this.recurrenceOnMonthDay = recurrenceOnMonthDay;
    }

    @java.lang.SuppressWarnings("all")
        public void setToAccountId(final String toAccountId) {
        this.toAccountId = toAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromClientId(final String fromClientId) {
        this.fromClientId = fromClientId;
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
        public void setFromAccountType(final String fromAccountType) {
        this.fromAccountType = fromAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public void setRecurrenceInterval(final String recurrenceInterval) {
        this.recurrenceInterval = recurrenceInterval;
    }

    @java.lang.SuppressWarnings("all")
        public void setMonthDayFormat(final String monthDayFormat) {
        this.monthDayFormat = monthDayFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setToClientId(final String toClientId) {
        this.toClientId = toClientId;
    }

    @java.lang.SuppressWarnings("all")
        public void setInstructionType(final String instructionType) {
        this.instructionType = instructionType;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromAccountId(final String fromAccountId) {
        this.fromAccountId = fromAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public void setRecurrenceFrequency(final String recurrenceFrequency) {
        this.recurrenceFrequency = recurrenceFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromOfficeId(final String fromOfficeId) {
        this.fromOfficeId = fromOfficeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransferType(final String transferType) {
        this.transferType = transferType;
    }

    @java.lang.SuppressWarnings("all")
        public void setStatus(final String status) {
        this.status = status;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof StandingInstructionCreationRequest)) return false;
        final StandingInstructionCreationRequest other = (StandingInstructionCreationRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$toOfficeId = this.getToOfficeId();
        final java.lang.Object other$toOfficeId = other.getToOfficeId();
        if (this$toOfficeId == null ? other$toOfficeId != null : !this$toOfficeId.equals(other$toOfficeId)) return false;
        final java.lang.Object this$amount = this.getAmount();
        final java.lang.Object other$amount = other.getAmount();
        if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
        final java.lang.Object this$validTill = this.getValidTill();
        final java.lang.Object other$validTill = other.getValidTill();
        if (this$validTill == null ? other$validTill != null : !this$validTill.equals(other$validTill)) return false;
        final java.lang.Object this$toAccountType = this.getToAccountType();
        final java.lang.Object other$toAccountType = other.getToAccountType();
        if (this$toAccountType == null ? other$toAccountType != null : !this$toAccountType.equals(other$toAccountType)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$recurrenceOnMonthDay = this.getRecurrenceOnMonthDay();
        final java.lang.Object other$recurrenceOnMonthDay = other.getRecurrenceOnMonthDay();
        if (this$recurrenceOnMonthDay == null ? other$recurrenceOnMonthDay != null : !this$recurrenceOnMonthDay.equals(other$recurrenceOnMonthDay)) return false;
        final java.lang.Object this$toAccountId = this.getToAccountId();
        final java.lang.Object other$toAccountId = other.getToAccountId();
        if (this$toAccountId == null ? other$toAccountId != null : !this$toAccountId.equals(other$toAccountId)) return false;
        final java.lang.Object this$fromClientId = this.getFromClientId();
        final java.lang.Object other$fromClientId = other.getFromClientId();
        if (this$fromClientId == null ? other$fromClientId != null : !this$fromClientId.equals(other$fromClientId)) return false;
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
        final java.lang.Object this$fromAccountType = this.getFromAccountType();
        final java.lang.Object other$fromAccountType = other.getFromAccountType();
        if (this$fromAccountType == null ? other$fromAccountType != null : !this$fromAccountType.equals(other$fromAccountType)) return false;
        final java.lang.Object this$recurrenceInterval = this.getRecurrenceInterval();
        final java.lang.Object other$recurrenceInterval = other.getRecurrenceInterval();
        if (this$recurrenceInterval == null ? other$recurrenceInterval != null : !this$recurrenceInterval.equals(other$recurrenceInterval)) return false;
        final java.lang.Object this$monthDayFormat = this.getMonthDayFormat();
        final java.lang.Object other$monthDayFormat = other.getMonthDayFormat();
        if (this$monthDayFormat == null ? other$monthDayFormat != null : !this$monthDayFormat.equals(other$monthDayFormat)) return false;
        final java.lang.Object this$toClientId = this.getToClientId();
        final java.lang.Object other$toClientId = other.getToClientId();
        if (this$toClientId == null ? other$toClientId != null : !this$toClientId.equals(other$toClientId)) return false;
        final java.lang.Object this$instructionType = this.getInstructionType();
        final java.lang.Object other$instructionType = other.getInstructionType();
        if (this$instructionType == null ? other$instructionType != null : !this$instructionType.equals(other$instructionType)) return false;
        final java.lang.Object this$fromAccountId = this.getFromAccountId();
        final java.lang.Object other$fromAccountId = other.getFromAccountId();
        if (this$fromAccountId == null ? other$fromAccountId != null : !this$fromAccountId.equals(other$fromAccountId)) return false;
        final java.lang.Object this$recurrenceFrequency = this.getRecurrenceFrequency();
        final java.lang.Object other$recurrenceFrequency = other.getRecurrenceFrequency();
        if (this$recurrenceFrequency == null ? other$recurrenceFrequency != null : !this$recurrenceFrequency.equals(other$recurrenceFrequency)) return false;
        final java.lang.Object this$fromOfficeId = this.getFromOfficeId();
        final java.lang.Object other$fromOfficeId = other.getFromOfficeId();
        if (this$fromOfficeId == null ? other$fromOfficeId != null : !this$fromOfficeId.equals(other$fromOfficeId)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$transferType = this.getTransferType();
        final java.lang.Object other$transferType = other.getTransferType();
        if (this$transferType == null ? other$transferType != null : !this$transferType.equals(other$transferType)) return false;
        final java.lang.Object this$status = this.getStatus();
        final java.lang.Object other$status = other.getStatus();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof StandingInstructionCreationRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $toOfficeId = this.getToOfficeId();
        result = result * PRIME + ($toOfficeId == null ? 43 : $toOfficeId.hashCode());
        final java.lang.Object $amount = this.getAmount();
        result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
        final java.lang.Object $validTill = this.getValidTill();
        result = result * PRIME + ($validTill == null ? 43 : $validTill.hashCode());
        final java.lang.Object $toAccountType = this.getToAccountType();
        result = result * PRIME + ($toAccountType == null ? 43 : $toAccountType.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $recurrenceOnMonthDay = this.getRecurrenceOnMonthDay();
        result = result * PRIME + ($recurrenceOnMonthDay == null ? 43 : $recurrenceOnMonthDay.hashCode());
        final java.lang.Object $toAccountId = this.getToAccountId();
        result = result * PRIME + ($toAccountId == null ? 43 : $toAccountId.hashCode());
        final java.lang.Object $fromClientId = this.getFromClientId();
        result = result * PRIME + ($fromClientId == null ? 43 : $fromClientId.hashCode());
        final java.lang.Object $validFrom = this.getValidFrom();
        result = result * PRIME + ($validFrom == null ? 43 : $validFrom.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $priority = this.getPriority();
        result = result * PRIME + ($priority == null ? 43 : $priority.hashCode());
        final java.lang.Object $recurrenceType = this.getRecurrenceType();
        result = result * PRIME + ($recurrenceType == null ? 43 : $recurrenceType.hashCode());
        final java.lang.Object $fromAccountType = this.getFromAccountType();
        result = result * PRIME + ($fromAccountType == null ? 43 : $fromAccountType.hashCode());
        final java.lang.Object $recurrenceInterval = this.getRecurrenceInterval();
        result = result * PRIME + ($recurrenceInterval == null ? 43 : $recurrenceInterval.hashCode());
        final java.lang.Object $monthDayFormat = this.getMonthDayFormat();
        result = result * PRIME + ($monthDayFormat == null ? 43 : $monthDayFormat.hashCode());
        final java.lang.Object $toClientId = this.getToClientId();
        result = result * PRIME + ($toClientId == null ? 43 : $toClientId.hashCode());
        final java.lang.Object $instructionType = this.getInstructionType();
        result = result * PRIME + ($instructionType == null ? 43 : $instructionType.hashCode());
        final java.lang.Object $fromAccountId = this.getFromAccountId();
        result = result * PRIME + ($fromAccountId == null ? 43 : $fromAccountId.hashCode());
        final java.lang.Object $recurrenceFrequency = this.getRecurrenceFrequency();
        result = result * PRIME + ($recurrenceFrequency == null ? 43 : $recurrenceFrequency.hashCode());
        final java.lang.Object $fromOfficeId = this.getFromOfficeId();
        result = result * PRIME + ($fromOfficeId == null ? 43 : $fromOfficeId.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $transferType = this.getTransferType();
        result = result * PRIME + ($transferType == null ? 43 : $transferType.hashCode());
        final java.lang.Object $status = this.getStatus();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "StandingInstructionCreationRequest(toOfficeId=" + this.getToOfficeId() + ", amount=" + this.getAmount() + ", validTill=" + this.getValidTill() + ", toAccountType=" + this.getToAccountType() + ", dateFormat=" + this.getDateFormat() + ", recurrenceOnMonthDay=" + this.getRecurrenceOnMonthDay() + ", toAccountId=" + this.getToAccountId() + ", fromClientId=" + this.getFromClientId() + ", validFrom=" + this.getValidFrom() + ", locale=" + this.getLocale() + ", priority=" + this.getPriority() + ", recurrenceType=" + this.getRecurrenceType() + ", fromAccountType=" + this.getFromAccountType() + ", recurrenceInterval=" + this.getRecurrenceInterval() + ", monthDayFormat=" + this.getMonthDayFormat() + ", toClientId=" + this.getToClientId() + ", instructionType=" + this.getInstructionType() + ", fromAccountId=" + this.getFromAccountId() + ", recurrenceFrequency=" + this.getRecurrenceFrequency() + ", fromOfficeId=" + this.getFromOfficeId() + ", name=" + this.getName() + ", transferType=" + this.getTransferType() + ", status=" + this.getStatus() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public StandingInstructionCreationRequest() {
    }
}
