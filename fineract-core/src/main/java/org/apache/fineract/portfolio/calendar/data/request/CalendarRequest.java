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
package org.apache.fineract.portfolio.calendar.data.request;

import java.io.Serial;
import java.io.Serializable;

public class CalendarRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String repeatsOnDay;
    private String dateFormat;
    private String repeating;
    private String interval;
    private String typeId;
    private String locale;
    private String title;
    private String startDate;
    private String frequency;

    @java.lang.SuppressWarnings("all")
        public String getRepeatsOnDay() {
        return this.repeatsOnDay;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getRepeating() {
        return this.repeating;
    }

    @java.lang.SuppressWarnings("all")
        public String getInterval() {
        return this.interval;
    }

    @java.lang.SuppressWarnings("all")
        public String getTypeId() {
        return this.typeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getTitle() {
        return this.title;
    }

    @java.lang.SuppressWarnings("all")
        public String getStartDate() {
        return this.startDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getFrequency() {
        return this.frequency;
    }

    @java.lang.SuppressWarnings("all")
        public void setRepeatsOnDay(final String repeatsOnDay) {
        this.repeatsOnDay = repeatsOnDay;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setRepeating(final String repeating) {
        this.repeating = repeating;
    }

    @java.lang.SuppressWarnings("all")
        public void setInterval(final String interval) {
        this.interval = interval;
    }

    @java.lang.SuppressWarnings("all")
        public void setTypeId(final String typeId) {
        this.typeId = typeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setTitle(final String title) {
        this.title = title;
    }

    @java.lang.SuppressWarnings("all")
        public void setStartDate(final String startDate) {
        this.startDate = startDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setFrequency(final String frequency) {
        this.frequency = frequency;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CalendarRequest)) return false;
        final CalendarRequest other = (CalendarRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$repeatsOnDay = this.getRepeatsOnDay();
        final java.lang.Object other$repeatsOnDay = other.getRepeatsOnDay();
        if (this$repeatsOnDay == null ? other$repeatsOnDay != null : !this$repeatsOnDay.equals(other$repeatsOnDay)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$repeating = this.getRepeating();
        final java.lang.Object other$repeating = other.getRepeating();
        if (this$repeating == null ? other$repeating != null : !this$repeating.equals(other$repeating)) return false;
        final java.lang.Object this$interval = this.getInterval();
        final java.lang.Object other$interval = other.getInterval();
        if (this$interval == null ? other$interval != null : !this$interval.equals(other$interval)) return false;
        final java.lang.Object this$typeId = this.getTypeId();
        final java.lang.Object other$typeId = other.getTypeId();
        if (this$typeId == null ? other$typeId != null : !this$typeId.equals(other$typeId)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$title = this.getTitle();
        final java.lang.Object other$title = other.getTitle();
        if (this$title == null ? other$title != null : !this$title.equals(other$title)) return false;
        final java.lang.Object this$startDate = this.getStartDate();
        final java.lang.Object other$startDate = other.getStartDate();
        if (this$startDate == null ? other$startDate != null : !this$startDate.equals(other$startDate)) return false;
        final java.lang.Object this$frequency = this.getFrequency();
        final java.lang.Object other$frequency = other.getFrequency();
        if (this$frequency == null ? other$frequency != null : !this$frequency.equals(other$frequency)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof CalendarRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $repeatsOnDay = this.getRepeatsOnDay();
        result = result * PRIME + ($repeatsOnDay == null ? 43 : $repeatsOnDay.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $repeating = this.getRepeating();
        result = result * PRIME + ($repeating == null ? 43 : $repeating.hashCode());
        final java.lang.Object $interval = this.getInterval();
        result = result * PRIME + ($interval == null ? 43 : $interval.hashCode());
        final java.lang.Object $typeId = this.getTypeId();
        result = result * PRIME + ($typeId == null ? 43 : $typeId.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $title = this.getTitle();
        result = result * PRIME + ($title == null ? 43 : $title.hashCode());
        final java.lang.Object $startDate = this.getStartDate();
        result = result * PRIME + ($startDate == null ? 43 : $startDate.hashCode());
        final java.lang.Object $frequency = this.getFrequency();
        result = result * PRIME + ($frequency == null ? 43 : $frequency.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CalendarRequest(repeatsOnDay=" + this.getRepeatsOnDay() + ", dateFormat=" + this.getDateFormat() + ", repeating=" + this.getRepeating() + ", interval=" + this.getInterval() + ", typeId=" + this.getTypeId() + ", locale=" + this.getLocale() + ", title=" + this.getTitle() + ", startDate=" + this.getStartDate() + ", frequency=" + this.getFrequency() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CalendarRequest() {
    }
}
