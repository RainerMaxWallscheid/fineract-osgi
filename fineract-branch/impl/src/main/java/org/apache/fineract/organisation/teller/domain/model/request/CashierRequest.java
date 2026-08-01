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
package org.apache.fineract.organisation.teller.domain.model.request;

import java.io.Serial;
import java.io.Serializable;

public class CashierRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String description;
    private Boolean isFullDay;
    private Long staffId;
    private String dateFormat;
    private String startDate;
    private String endDate;
    private String locale;
    private String hourStartTime;
    private String minStartTime;
    private String hourEndTime;
    private String minEndTime;

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsFullDay() {
        return this.isFullDay;
    }

    @java.lang.SuppressWarnings("all")
        public Long getStaffId() {
        return this.staffId;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getStartDate() {
        return this.startDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getEndDate() {
        return this.endDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getHourStartTime() {
        return this.hourStartTime;
    }

    @java.lang.SuppressWarnings("all")
        public String getMinStartTime() {
        return this.minStartTime;
    }

    @java.lang.SuppressWarnings("all")
        public String getHourEndTime() {
        return this.hourEndTime;
    }

    @java.lang.SuppressWarnings("all")
        public String getMinEndTime() {
        return this.minEndTime;
    }

    @java.lang.SuppressWarnings("all")
        public void setDescription(final String description) {
        this.description = description;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsFullDay(final Boolean isFullDay) {
        this.isFullDay = isFullDay;
    }

    @java.lang.SuppressWarnings("all")
        public void setStaffId(final Long staffId) {
        this.staffId = staffId;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setStartDate(final String startDate) {
        this.startDate = startDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setEndDate(final String endDate) {
        this.endDate = endDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setHourStartTime(final String hourStartTime) {
        this.hourStartTime = hourStartTime;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinStartTime(final String minStartTime) {
        this.minStartTime = minStartTime;
    }

    @java.lang.SuppressWarnings("all")
        public void setHourEndTime(final String hourEndTime) {
        this.hourEndTime = hourEndTime;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinEndTime(final String minEndTime) {
        this.minEndTime = minEndTime;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CashierRequest)) return false;
        final CashierRequest other = (CashierRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$isFullDay = this.getIsFullDay();
        final java.lang.Object other$isFullDay = other.getIsFullDay();
        if (this$isFullDay == null ? other$isFullDay != null : !this$isFullDay.equals(other$isFullDay)) return false;
        final java.lang.Object this$staffId = this.getStaffId();
        final java.lang.Object other$staffId = other.getStaffId();
        if (this$staffId == null ? other$staffId != null : !this$staffId.equals(other$staffId)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$startDate = this.getStartDate();
        final java.lang.Object other$startDate = other.getStartDate();
        if (this$startDate == null ? other$startDate != null : !this$startDate.equals(other$startDate)) return false;
        final java.lang.Object this$endDate = this.getEndDate();
        final java.lang.Object other$endDate = other.getEndDate();
        if (this$endDate == null ? other$endDate != null : !this$endDate.equals(other$endDate)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$hourStartTime = this.getHourStartTime();
        final java.lang.Object other$hourStartTime = other.getHourStartTime();
        if (this$hourStartTime == null ? other$hourStartTime != null : !this$hourStartTime.equals(other$hourStartTime)) return false;
        final java.lang.Object this$minStartTime = this.getMinStartTime();
        final java.lang.Object other$minStartTime = other.getMinStartTime();
        if (this$minStartTime == null ? other$minStartTime != null : !this$minStartTime.equals(other$minStartTime)) return false;
        final java.lang.Object this$hourEndTime = this.getHourEndTime();
        final java.lang.Object other$hourEndTime = other.getHourEndTime();
        if (this$hourEndTime == null ? other$hourEndTime != null : !this$hourEndTime.equals(other$hourEndTime)) return false;
        final java.lang.Object this$minEndTime = this.getMinEndTime();
        final java.lang.Object other$minEndTime = other.getMinEndTime();
        if (this$minEndTime == null ? other$minEndTime != null : !this$minEndTime.equals(other$minEndTime)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof CashierRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $isFullDay = this.getIsFullDay();
        result = result * PRIME + ($isFullDay == null ? 43 : $isFullDay.hashCode());
        final java.lang.Object $staffId = this.getStaffId();
        result = result * PRIME + ($staffId == null ? 43 : $staffId.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $startDate = this.getStartDate();
        result = result * PRIME + ($startDate == null ? 43 : $startDate.hashCode());
        final java.lang.Object $endDate = this.getEndDate();
        result = result * PRIME + ($endDate == null ? 43 : $endDate.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $hourStartTime = this.getHourStartTime();
        result = result * PRIME + ($hourStartTime == null ? 43 : $hourStartTime.hashCode());
        final java.lang.Object $minStartTime = this.getMinStartTime();
        result = result * PRIME + ($minStartTime == null ? 43 : $minStartTime.hashCode());
        final java.lang.Object $hourEndTime = this.getHourEndTime();
        result = result * PRIME + ($hourEndTime == null ? 43 : $hourEndTime.hashCode());
        final java.lang.Object $minEndTime = this.getMinEndTime();
        result = result * PRIME + ($minEndTime == null ? 43 : $minEndTime.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CashierRequest(description=" + this.getDescription() + ", isFullDay=" + this.getIsFullDay() + ", staffId=" + this.getStaffId() + ", dateFormat=" + this.getDateFormat() + ", startDate=" + this.getStartDate() + ", endDate=" + this.getEndDate() + ", locale=" + this.getLocale() + ", hourStartTime=" + this.getHourStartTime() + ", minStartTime=" + this.getMinStartTime() + ", hourEndTime=" + this.getHourEndTime() + ", minEndTime=" + this.getMinEndTime() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CashierRequest() {
    }
}
