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
package org.apache.fineract.portfolio.meeting.data;

import io.swagger.v3.oas.annotations.Hidden;
import jakarta.validation.constraints.NotNull;
import java.io.Serial;
import java.io.Serializable;
import java.util.List;
import org.apache.fineract.portfolio.calendar.domain.CalendarEntityType;

public class MeetingUpdateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    // @NotNull(message = "{org.apache.fineract.portfolio.meeting.id.not-null}")
    @Hidden
    private Long id;
    @Hidden
    private Long entityId;
    @Hidden
    private CalendarEntityType entityType;
    @NotNull(message = "{org.apache.fineract.portfolio.meeting.calendar-id.not-null}")
    private Long calendarId;
    @NotNull(message = "{org.apache.fineract.portfolio.meeting.meeting-date.not-null}")
    private String meetingDate;
    @NotNull(message = "{org.apache.fineract.portfolio.meeting.date-format.not-null}")
    private String dateFormat;
    @NotNull(message = "{org.apache.fineract.portfolio.meeting.locale.not-null}")
    private String locale;
    private List<MeetingAttendanceData> clientsAttendance;


    @java.lang.SuppressWarnings("all")
        public static class MeetingUpdateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private Long entityId;
        @java.lang.SuppressWarnings("all")
                private CalendarEntityType entityType;
        @java.lang.SuppressWarnings("all")
                private Long calendarId;
        @java.lang.SuppressWarnings("all")
                private String meetingDate;
        @java.lang.SuppressWarnings("all")
                private String dateFormat;
        @java.lang.SuppressWarnings("all")
                private String locale;
        @java.lang.SuppressWarnings("all")
                private List<MeetingAttendanceData> clientsAttendance;

        @java.lang.SuppressWarnings("all")
                MeetingUpdateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingUpdateRequest.MeetingUpdateRequestBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingUpdateRequest.MeetingUpdateRequestBuilder entityId(final Long entityId) {
            this.entityId = entityId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingUpdateRequest.MeetingUpdateRequestBuilder entityType(final CalendarEntityType entityType) {
            this.entityType = entityType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingUpdateRequest.MeetingUpdateRequestBuilder calendarId(final Long calendarId) {
            this.calendarId = calendarId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingUpdateRequest.MeetingUpdateRequestBuilder meetingDate(final String meetingDate) {
            this.meetingDate = meetingDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingUpdateRequest.MeetingUpdateRequestBuilder dateFormat(final String dateFormat) {
            this.dateFormat = dateFormat;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingUpdateRequest.MeetingUpdateRequestBuilder locale(final String locale) {
            this.locale = locale;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingUpdateRequest.MeetingUpdateRequestBuilder clientsAttendance(final List<MeetingAttendanceData> clientsAttendance) {
            this.clientsAttendance = clientsAttendance;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public MeetingUpdateRequest build() {
            return new MeetingUpdateRequest(this.id, this.entityId, this.entityType, this.calendarId, this.meetingDate, this.dateFormat, this.locale, this.clientsAttendance);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "MeetingUpdateRequest.MeetingUpdateRequestBuilder(id=" + this.id + ", entityId=" + this.entityId + ", entityType=" + this.entityType + ", calendarId=" + this.calendarId + ", meetingDate=" + this.meetingDate + ", dateFormat=" + this.dateFormat + ", locale=" + this.locale + ", clientsAttendance=" + this.clientsAttendance + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static MeetingUpdateRequest.MeetingUpdateRequestBuilder builder() {
        return new MeetingUpdateRequest.MeetingUpdateRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getEntityId() {
        return this.entityId;
    }

    @java.lang.SuppressWarnings("all")
        public CalendarEntityType getEntityType() {
        return this.entityType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCalendarId() {
        return this.calendarId;
    }

    @java.lang.SuppressWarnings("all")
        public String getMeetingDate() {
        return this.meetingDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public List<MeetingAttendanceData> getClientsAttendance() {
        return this.clientsAttendance;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntityId(final Long entityId) {
        this.entityId = entityId;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntityType(final CalendarEntityType entityType) {
        this.entityType = entityType;
    }

    @java.lang.SuppressWarnings("all")
        public void setCalendarId(final Long calendarId) {
        this.calendarId = calendarId;
    }

    @java.lang.SuppressWarnings("all")
        public void setMeetingDate(final String meetingDate) {
        this.meetingDate = meetingDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientsAttendance(final List<MeetingAttendanceData> clientsAttendance) {
        this.clientsAttendance = clientsAttendance;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof MeetingUpdateRequest)) return false;
        final MeetingUpdateRequest other = (MeetingUpdateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$entityId = this.getEntityId();
        final java.lang.Object other$entityId = other.getEntityId();
        if (this$entityId == null ? other$entityId != null : !this$entityId.equals(other$entityId)) return false;
        final java.lang.Object this$calendarId = this.getCalendarId();
        final java.lang.Object other$calendarId = other.getCalendarId();
        if (this$calendarId == null ? other$calendarId != null : !this$calendarId.equals(other$calendarId)) return false;
        final java.lang.Object this$entityType = this.getEntityType();
        final java.lang.Object other$entityType = other.getEntityType();
        if (this$entityType == null ? other$entityType != null : !this$entityType.equals(other$entityType)) return false;
        final java.lang.Object this$meetingDate = this.getMeetingDate();
        final java.lang.Object other$meetingDate = other.getMeetingDate();
        if (this$meetingDate == null ? other$meetingDate != null : !this$meetingDate.equals(other$meetingDate)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$clientsAttendance = this.getClientsAttendance();
        final java.lang.Object other$clientsAttendance = other.getClientsAttendance();
        if (this$clientsAttendance == null ? other$clientsAttendance != null : !this$clientsAttendance.equals(other$clientsAttendance)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof MeetingUpdateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $entityId = this.getEntityId();
        result = result * PRIME + ($entityId == null ? 43 : $entityId.hashCode());
        final java.lang.Object $calendarId = this.getCalendarId();
        result = result * PRIME + ($calendarId == null ? 43 : $calendarId.hashCode());
        final java.lang.Object $entityType = this.getEntityType();
        result = result * PRIME + ($entityType == null ? 43 : $entityType.hashCode());
        final java.lang.Object $meetingDate = this.getMeetingDate();
        result = result * PRIME + ($meetingDate == null ? 43 : $meetingDate.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $clientsAttendance = this.getClientsAttendance();
        result = result * PRIME + ($clientsAttendance == null ? 43 : $clientsAttendance.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "MeetingUpdateRequest(id=" + this.getId() + ", entityId=" + this.getEntityId() + ", entityType=" + this.getEntityType() + ", calendarId=" + this.getCalendarId() + ", meetingDate=" + this.getMeetingDate() + ", dateFormat=" + this.getDateFormat() + ", locale=" + this.getLocale() + ", clientsAttendance=" + this.getClientsAttendance() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public MeetingUpdateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public MeetingUpdateRequest(final Long id, final Long entityId, final CalendarEntityType entityType, final Long calendarId, final String meetingDate, final String dateFormat, final String locale, final List<MeetingAttendanceData> clientsAttendance) {
        this.id = id;
        this.entityId = entityId;
        this.entityType = entityType;
        this.calendarId = calendarId;
        this.meetingDate = meetingDate;
        this.dateFormat = dateFormat;
        this.locale = locale;
        this.clientsAttendance = clientsAttendance;
    }
}
