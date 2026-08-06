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
import java.io.Serial;
import java.io.Serializable;
import java.util.List;
import org.apache.fineract.portfolio.calendar.domain.CalendarEntityType;

public class MeetingAttendanceUpdateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    @Hidden
    private Long entityId;
    @Hidden
    private CalendarEntityType entityType;
    // @NotNull(message = "{org.apache.fineract.portfolio.meeting.attendance.id.not-null}")
    @Hidden
    private List<MeetingAttendanceData> meetingAttendance;
    private Integer attendanceType;


    @java.lang.SuppressWarnings("all")
        public static class MeetingAttendanceUpdateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private Long entityId;
        @java.lang.SuppressWarnings("all")
                private CalendarEntityType entityType;
        @java.lang.SuppressWarnings("all")
                private List<MeetingAttendanceData> meetingAttendance;
        @java.lang.SuppressWarnings("all")
                private Integer attendanceType;

        @java.lang.SuppressWarnings("all")
                MeetingAttendanceUpdateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingAttendanceUpdateRequest.MeetingAttendanceUpdateRequestBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingAttendanceUpdateRequest.MeetingAttendanceUpdateRequestBuilder entityId(final Long entityId) {
            this.entityId = entityId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingAttendanceUpdateRequest.MeetingAttendanceUpdateRequestBuilder entityType(final CalendarEntityType entityType) {
            this.entityType = entityType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingAttendanceUpdateRequest.MeetingAttendanceUpdateRequestBuilder meetingAttendance(final List<MeetingAttendanceData> meetingAttendance) {
            this.meetingAttendance = meetingAttendance;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingAttendanceUpdateRequest.MeetingAttendanceUpdateRequestBuilder attendanceType(final Integer attendanceType) {
            this.attendanceType = attendanceType;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public MeetingAttendanceUpdateRequest build() {
            return new MeetingAttendanceUpdateRequest(this.id, this.entityId, this.entityType, this.meetingAttendance, this.attendanceType);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "MeetingAttendanceUpdateRequest.MeetingAttendanceUpdateRequestBuilder(id=" + this.id + ", entityId=" + this.entityId + ", entityType=" + this.entityType + ", meetingAttendance=" + this.meetingAttendance + ", attendanceType=" + this.attendanceType + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static MeetingAttendanceUpdateRequest.MeetingAttendanceUpdateRequestBuilder builder() {
        return new MeetingAttendanceUpdateRequest.MeetingAttendanceUpdateRequestBuilder();
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
        public List<MeetingAttendanceData> getMeetingAttendance() {
        return this.meetingAttendance;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getAttendanceType() {
        return this.attendanceType;
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
        public void setMeetingAttendance(final List<MeetingAttendanceData> meetingAttendance) {
        this.meetingAttendance = meetingAttendance;
    }

    @java.lang.SuppressWarnings("all")
        public void setAttendanceType(final Integer attendanceType) {
        this.attendanceType = attendanceType;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof MeetingAttendanceUpdateRequest)) return false;
        final MeetingAttendanceUpdateRequest other = (MeetingAttendanceUpdateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$entityId = this.getEntityId();
        final java.lang.Object other$entityId = other.getEntityId();
        if (this$entityId == null ? other$entityId != null : !this$entityId.equals(other$entityId)) return false;
        final java.lang.Object this$attendanceType = this.getAttendanceType();
        final java.lang.Object other$attendanceType = other.getAttendanceType();
        if (this$attendanceType == null ? other$attendanceType != null : !this$attendanceType.equals(other$attendanceType)) return false;
        final java.lang.Object this$entityType = this.getEntityType();
        final java.lang.Object other$entityType = other.getEntityType();
        if (this$entityType == null ? other$entityType != null : !this$entityType.equals(other$entityType)) return false;
        final java.lang.Object this$meetingAttendance = this.getMeetingAttendance();
        final java.lang.Object other$meetingAttendance = other.getMeetingAttendance();
        if (this$meetingAttendance == null ? other$meetingAttendance != null : !this$meetingAttendance.equals(other$meetingAttendance)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof MeetingAttendanceUpdateRequest;
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
        final java.lang.Object $attendanceType = this.getAttendanceType();
        result = result * PRIME + ($attendanceType == null ? 43 : $attendanceType.hashCode());
        final java.lang.Object $entityType = this.getEntityType();
        result = result * PRIME + ($entityType == null ? 43 : $entityType.hashCode());
        final java.lang.Object $meetingAttendance = this.getMeetingAttendance();
        result = result * PRIME + ($meetingAttendance == null ? 43 : $meetingAttendance.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "MeetingAttendanceUpdateRequest(id=" + this.getId() + ", entityId=" + this.getEntityId() + ", entityType=" + this.getEntityType() + ", meetingAttendance=" + this.getMeetingAttendance() + ", attendanceType=" + this.getAttendanceType() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public MeetingAttendanceUpdateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public MeetingAttendanceUpdateRequest(final Long id, final Long entityId, final CalendarEntityType entityType, final List<MeetingAttendanceData> meetingAttendance, final Integer attendanceType) {
        this.id = id;
        this.entityId = entityId;
        this.entityType = entityType;
        this.meetingAttendance = meetingAttendance;
        this.attendanceType = attendanceType;
    }
}
