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
package org.apache.fineract.portfolio.meeting.domain;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.time.LocalDate;
import java.util.Set;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.portfolio.calendar.domain.CalendarInstance;
import org.apache.fineract.portfolio.calendar.moduleapi.CalendarInstanceAssociation;

@Entity
@Table(name = "m_meeting", uniqueConstraints = {@UniqueConstraint(columnNames = {"calendar_instance_id", "meeting_date"}, name = "unique_calendar_instance_id_meeting_date")})
public class Meeting extends AbstractPersistableCustom<Long> {
    /**
     * Calendar-instance id (no JPA association to leftover CalendarInstance — ADR-021).
     */
    @Column(name = "calendar_instance_id", nullable = false)
    private Long calendarInstanceId;
    @Column(name = "meeting_date", nullable = false)
    private LocalDate meetingDate;
    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, mappedBy = "meeting", orphanRemoval = true)
    private Set<MeetingAttendance> clientsAttendance;

    @java.lang.SuppressWarnings("all")
        public Meeting(final Object calendarInstance, final LocalDate meetingDate, final Set<MeetingAttendance> clientsAttendance) {
        this.calendarInstanceId = CalendarInstanceAssociation.id(calendarInstance);
        this.meetingDate = meetingDate;
        this.clientsAttendance = clientsAttendance;
    }

    @java.lang.SuppressWarnings("all")
        public Meeting() {
    }

    @java.lang.SuppressWarnings("all")
        public Long getCalendarInstanceId() {
        return this.calendarInstanceId;
    }

    public CalendarInstance leftoverCalendarInstance() {
        final Object persistable = CalendarInstanceAssociation.persistableById(this.calendarInstanceId);
        return persistable instanceof CalendarInstance leftover ? leftover : null;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getMeetingDate() {
        return this.meetingDate;
    }

    @java.lang.SuppressWarnings("all")
        public Set<MeetingAttendance> getClientsAttendance() {
        return this.clientsAttendance;
    }

    @java.lang.SuppressWarnings("all")
        public void setCalendarInstance(final Object calendarInstance) {
        this.calendarInstanceId = CalendarInstanceAssociation.id(calendarInstance);
    }

    @java.lang.SuppressWarnings("all")
        public void setMeetingDate(final LocalDate meetingDate) {
        this.meetingDate = meetingDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientsAttendance(final Set<MeetingAttendance> clientsAttendance) {
        this.clientsAttendance = clientsAttendance;
    }
}
