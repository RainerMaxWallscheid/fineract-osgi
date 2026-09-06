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

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.portfolio.client.moduleapi.ClientAssociation;

@Entity
@Table(name = "m_client_attendance", uniqueConstraints = {@UniqueConstraint(columnNames = {"client_id", "meeting_id"}, name = "unique_client_meeting_attendance")})
public class MeetingAttendance extends AbstractPersistableCustom<Long> {
    /**
     * Client id (no JPA association to leftover Client — ADR-021).
     */
    @Column(name = "client_id", nullable = false)
    private Long clientId;
    @ManyToOne
    @JoinColumn(name = "meeting_id", nullable = false)
    private Meeting meeting;
    @Column(name = "attendance_type_enum", nullable = false)
    private Integer attendanceTypeId;

    @java.lang.SuppressWarnings("all")
        public MeetingAttendance(final Object client, final Meeting meeting, final Integer attendanceTypeId) {
        this.clientId = ClientAssociation.id(client);
        this.meeting = meeting;
        this.attendanceTypeId = attendanceTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public MeetingAttendance() {
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public Meeting getMeeting() {
        return this.meeting;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getAttendanceTypeId() {
        return this.attendanceTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setClient(final Object client) {
        this.clientId = ClientAssociation.id(client);
    }

    @java.lang.SuppressWarnings("all")
        public void setMeeting(final Meeting meeting) {
        this.meeting = meeting;
    }

    @java.lang.SuppressWarnings("all")
        public void setAttendanceTypeId(final Integer attendanceTypeId) {
        this.attendanceTypeId = attendanceTypeId;
    }
}
