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

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.Collection;
import java.util.List;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.portfolio.calendar.data.CalendarData;
import org.apache.fineract.portfolio.client.data.ClientData;

public class MeetingData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private LocalDate meetingDate;
    private Collection<MeetingAttendanceData> clientsAttendance;
    private Collection<ClientData> clients;
    private CalendarData calendarData;
    private List<EnumOptionData> attendanceTypeOptions;


    @java.lang.SuppressWarnings("all")
        public static class MeetingDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private LocalDate meetingDate;
        @java.lang.SuppressWarnings("all")
                private Collection<MeetingAttendanceData> clientsAttendance;
        @java.lang.SuppressWarnings("all")
                private Collection<ClientData> clients;
        @java.lang.SuppressWarnings("all")
                private CalendarData calendarData;
        @java.lang.SuppressWarnings("all")
                private List<EnumOptionData> attendanceTypeOptions;

        @java.lang.SuppressWarnings("all")
                MeetingDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingData.MeetingDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingData.MeetingDataBuilder meetingDate(final LocalDate meetingDate) {
            this.meetingDate = meetingDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingData.MeetingDataBuilder clientsAttendance(final Collection<MeetingAttendanceData> clientsAttendance) {
            this.clientsAttendance = clientsAttendance;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingData.MeetingDataBuilder clients(final Collection<ClientData> clients) {
            this.clients = clients;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingData.MeetingDataBuilder calendarData(final CalendarData calendarData) {
            this.calendarData = calendarData;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingData.MeetingDataBuilder attendanceTypeOptions(final List<EnumOptionData> attendanceTypeOptions) {
            this.attendanceTypeOptions = attendanceTypeOptions;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public MeetingData build() {
            return new MeetingData(this.id, this.meetingDate, this.clientsAttendance, this.clients, this.calendarData, this.attendanceTypeOptions);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "MeetingData.MeetingDataBuilder(id=" + this.id + ", meetingDate=" + this.meetingDate + ", clientsAttendance=" + this.clientsAttendance + ", clients=" + this.clients + ", calendarData=" + this.calendarData + ", attendanceTypeOptions=" + this.attendanceTypeOptions + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static MeetingData.MeetingDataBuilder builder() {
        return new MeetingData.MeetingDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getMeetingDate() {
        return this.meetingDate;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<MeetingAttendanceData> getClientsAttendance() {
        return this.clientsAttendance;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<ClientData> getClients() {
        return this.clients;
    }

    @java.lang.SuppressWarnings("all")
        public CalendarData getCalendarData() {
        return this.calendarData;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getAttendanceTypeOptions() {
        return this.attendanceTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setMeetingDate(final LocalDate meetingDate) {
        this.meetingDate = meetingDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientsAttendance(final Collection<MeetingAttendanceData> clientsAttendance) {
        this.clientsAttendance = clientsAttendance;
    }

    @java.lang.SuppressWarnings("all")
        public void setClients(final Collection<ClientData> clients) {
        this.clients = clients;
    }

    @java.lang.SuppressWarnings("all")
        public void setCalendarData(final CalendarData calendarData) {
        this.calendarData = calendarData;
    }

    @java.lang.SuppressWarnings("all")
        public void setAttendanceTypeOptions(final List<EnumOptionData> attendanceTypeOptions) {
        this.attendanceTypeOptions = attendanceTypeOptions;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof MeetingData)) return false;
        final MeetingData other = (MeetingData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$meetingDate = this.getMeetingDate();
        final java.lang.Object other$meetingDate = other.getMeetingDate();
        if (this$meetingDate == null ? other$meetingDate != null : !this$meetingDate.equals(other$meetingDate)) return false;
        final java.lang.Object this$clientsAttendance = this.getClientsAttendance();
        final java.lang.Object other$clientsAttendance = other.getClientsAttendance();
        if (this$clientsAttendance == null ? other$clientsAttendance != null : !this$clientsAttendance.equals(other$clientsAttendance)) return false;
        final java.lang.Object this$clients = this.getClients();
        final java.lang.Object other$clients = other.getClients();
        if (this$clients == null ? other$clients != null : !this$clients.equals(other$clients)) return false;
        final java.lang.Object this$calendarData = this.getCalendarData();
        final java.lang.Object other$calendarData = other.getCalendarData();
        if (this$calendarData == null ? other$calendarData != null : !this$calendarData.equals(other$calendarData)) return false;
        final java.lang.Object this$attendanceTypeOptions = this.getAttendanceTypeOptions();
        final java.lang.Object other$attendanceTypeOptions = other.getAttendanceTypeOptions();
        if (this$attendanceTypeOptions == null ? other$attendanceTypeOptions != null : !this$attendanceTypeOptions.equals(other$attendanceTypeOptions)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof MeetingData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $meetingDate = this.getMeetingDate();
        result = result * PRIME + ($meetingDate == null ? 43 : $meetingDate.hashCode());
        final java.lang.Object $clientsAttendance = this.getClientsAttendance();
        result = result * PRIME + ($clientsAttendance == null ? 43 : $clientsAttendance.hashCode());
        final java.lang.Object $clients = this.getClients();
        result = result * PRIME + ($clients == null ? 43 : $clients.hashCode());
        final java.lang.Object $calendarData = this.getCalendarData();
        result = result * PRIME + ($calendarData == null ? 43 : $calendarData.hashCode());
        final java.lang.Object $attendanceTypeOptions = this.getAttendanceTypeOptions();
        result = result * PRIME + ($attendanceTypeOptions == null ? 43 : $attendanceTypeOptions.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "MeetingData(id=" + this.getId() + ", meetingDate=" + this.getMeetingDate() + ", clientsAttendance=" + this.getClientsAttendance() + ", clients=" + this.getClients() + ", calendarData=" + this.getCalendarData() + ", attendanceTypeOptions=" + this.getAttendanceTypeOptions() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public MeetingData() {
    }

    @java.lang.SuppressWarnings("all")
        public MeetingData(final Long id, final LocalDate meetingDate, final Collection<MeetingAttendanceData> clientsAttendance, final Collection<ClientData> clients, final CalendarData calendarData, final List<EnumOptionData> attendanceTypeOptions) {
        this.id = id;
        this.meetingDate = meetingDate;
        this.clientsAttendance = clientsAttendance;
        this.clients = clients;
        this.calendarData = calendarData;
        this.attendanceTypeOptions = attendanceTypeOptions;
    }
}
