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

import jakarta.validation.constraints.NotNull;
import java.io.Serial;
import java.io.Serializable;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;

public class MeetingAttendanceData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    @NotNull(message = "{org.apache.fineract.portfolio.meeting.attendance.client-id.not-null}")
    private Long clientId;
    private String clientName;
    @NotNull(message = "{org.apache.fineract.portfolio.meeting.attendance.attendance-type.not-null}")
    private EnumOptionData attendanceType;


    @java.lang.SuppressWarnings("all")
        public static class MeetingAttendanceDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private Long clientId;
        @java.lang.SuppressWarnings("all")
                private String clientName;
        @java.lang.SuppressWarnings("all")
                private EnumOptionData attendanceType;

        @java.lang.SuppressWarnings("all")
                MeetingAttendanceDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingAttendanceData.MeetingAttendanceDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingAttendanceData.MeetingAttendanceDataBuilder clientId(final Long clientId) {
            this.clientId = clientId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingAttendanceData.MeetingAttendanceDataBuilder clientName(final String clientName) {
            this.clientName = clientName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingAttendanceData.MeetingAttendanceDataBuilder attendanceType(final EnumOptionData attendanceType) {
            this.attendanceType = attendanceType;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public MeetingAttendanceData build() {
            return new MeetingAttendanceData(this.id, this.clientId, this.clientName, this.attendanceType);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "MeetingAttendanceData.MeetingAttendanceDataBuilder(id=" + this.id + ", clientId=" + this.clientId + ", clientName=" + this.clientName + ", attendanceType=" + this.attendanceType + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static MeetingAttendanceData.MeetingAttendanceDataBuilder builder() {
        return new MeetingAttendanceData.MeetingAttendanceDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public String getClientName() {
        return this.clientName;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getAttendanceType() {
        return this.attendanceType;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientId(final Long clientId) {
        this.clientId = clientId;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientName(final String clientName) {
        this.clientName = clientName;
    }

    @java.lang.SuppressWarnings("all")
        public void setAttendanceType(final EnumOptionData attendanceType) {
        this.attendanceType = attendanceType;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof MeetingAttendanceData)) return false;
        final MeetingAttendanceData other = (MeetingAttendanceData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$clientId = this.getClientId();
        final java.lang.Object other$clientId = other.getClientId();
        if (this$clientId == null ? other$clientId != null : !this$clientId.equals(other$clientId)) return false;
        final java.lang.Object this$clientName = this.getClientName();
        final java.lang.Object other$clientName = other.getClientName();
        if (this$clientName == null ? other$clientName != null : !this$clientName.equals(other$clientName)) return false;
        final java.lang.Object this$attendanceType = this.getAttendanceType();
        final java.lang.Object other$attendanceType = other.getAttendanceType();
        if (this$attendanceType == null ? other$attendanceType != null : !this$attendanceType.equals(other$attendanceType)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof MeetingAttendanceData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $clientId = this.getClientId();
        result = result * PRIME + ($clientId == null ? 43 : $clientId.hashCode());
        final java.lang.Object $clientName = this.getClientName();
        result = result * PRIME + ($clientName == null ? 43 : $clientName.hashCode());
        final java.lang.Object $attendanceType = this.getAttendanceType();
        result = result * PRIME + ($attendanceType == null ? 43 : $attendanceType.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "MeetingAttendanceData(id=" + this.getId() + ", clientId=" + this.getClientId() + ", clientName=" + this.getClientName() + ", attendanceType=" + this.getAttendanceType() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public MeetingAttendanceData() {
    }

    @java.lang.SuppressWarnings("all")
        public MeetingAttendanceData(final Long id, final Long clientId, final String clientName, final EnumOptionData attendanceType) {
        this.id = id;
        this.clientId = clientId;
        this.clientName = clientName;
        this.attendanceType = attendanceType;
    }
}
