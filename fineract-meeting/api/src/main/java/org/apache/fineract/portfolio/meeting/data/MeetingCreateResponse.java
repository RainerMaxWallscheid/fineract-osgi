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

public class MeetingCreateResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long entityId;
    private Long groupId;


    @java.lang.SuppressWarnings("all")
        public static class MeetingCreateResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private Long entityId;
        @java.lang.SuppressWarnings("all")
                private Long groupId;

        @java.lang.SuppressWarnings("all")
                MeetingCreateResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingCreateResponse.MeetingCreateResponseBuilder entityId(final Long entityId) {
            this.entityId = entityId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MeetingCreateResponse.MeetingCreateResponseBuilder groupId(final Long groupId) {
            this.groupId = groupId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public MeetingCreateResponse build() {
            return new MeetingCreateResponse(this.entityId, this.groupId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "MeetingCreateResponse.MeetingCreateResponseBuilder(entityId=" + this.entityId + ", groupId=" + this.groupId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static MeetingCreateResponse.MeetingCreateResponseBuilder builder() {
        return new MeetingCreateResponse.MeetingCreateResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getEntityId() {
        return this.entityId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getGroupId() {
        return this.groupId;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntityId(final Long entityId) {
        this.entityId = entityId;
    }

    @java.lang.SuppressWarnings("all")
        public void setGroupId(final Long groupId) {
        this.groupId = groupId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof MeetingCreateResponse)) return false;
        final MeetingCreateResponse other = (MeetingCreateResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$entityId = this.getEntityId();
        final java.lang.Object other$entityId = other.getEntityId();
        if (this$entityId == null ? other$entityId != null : !this$entityId.equals(other$entityId)) return false;
        final java.lang.Object this$groupId = this.getGroupId();
        final java.lang.Object other$groupId = other.getGroupId();
        if (this$groupId == null ? other$groupId != null : !this$groupId.equals(other$groupId)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof MeetingCreateResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $entityId = this.getEntityId();
        result = result * PRIME + ($entityId == null ? 43 : $entityId.hashCode());
        final java.lang.Object $groupId = this.getGroupId();
        result = result * PRIME + ($groupId == null ? 43 : $groupId.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "MeetingCreateResponse(entityId=" + this.getEntityId() + ", groupId=" + this.getGroupId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public MeetingCreateResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public MeetingCreateResponse(final Long entityId, final Long groupId) {
        this.entityId = entityId;
        this.groupId = groupId;
    }
}
