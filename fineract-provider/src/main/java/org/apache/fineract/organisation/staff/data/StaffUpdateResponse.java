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
package org.apache.fineract.organisation.staff.data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Map;

public class StaffUpdateResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long officeId;
    private Long resourceId;
    private Map<String, Object> changes;


    @java.lang.SuppressWarnings("all")
        public static class StaffUpdateResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private Long officeId;
        @java.lang.SuppressWarnings("all")
                private Long resourceId;
        @java.lang.SuppressWarnings("all")
                private Map<String, Object> changes;

        @java.lang.SuppressWarnings("all")
                StaffUpdateResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUpdateResponse.StaffUpdateResponseBuilder officeId(final Long officeId) {
            this.officeId = officeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUpdateResponse.StaffUpdateResponseBuilder resourceId(final Long resourceId) {
            this.resourceId = resourceId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUpdateResponse.StaffUpdateResponseBuilder changes(final Map<String, Object> changes) {
            this.changes = changes;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public StaffUpdateResponse build() {
            return new StaffUpdateResponse(this.officeId, this.resourceId, this.changes);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "StaffUpdateResponse.StaffUpdateResponseBuilder(officeId=" + this.officeId + ", resourceId=" + this.resourceId + ", changes=" + this.changes + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static StaffUpdateResponse.StaffUpdateResponseBuilder builder() {
        return new StaffUpdateResponse.StaffUpdateResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getResourceId() {
        return this.resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, Object> getChanges() {
        return this.changes;
    }

    @java.lang.SuppressWarnings("all")
        public void setOfficeId(final Long officeId) {
        this.officeId = officeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceId(final Long resourceId) {
        this.resourceId = resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public void setChanges(final Map<String, Object> changes) {
        this.changes = changes;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof StaffUpdateResponse)) return false;
        final StaffUpdateResponse other = (StaffUpdateResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$resourceId = this.getResourceId();
        final java.lang.Object other$resourceId = other.getResourceId();
        if (this$resourceId == null ? other$resourceId != null : !this$resourceId.equals(other$resourceId)) return false;
        final java.lang.Object this$changes = this.getChanges();
        final java.lang.Object other$changes = other.getChanges();
        if (this$changes == null ? other$changes != null : !this$changes.equals(other$changes)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof StaffUpdateResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $officeId = this.getOfficeId();
        result = result * PRIME + ($officeId == null ? 43 : $officeId.hashCode());
        final java.lang.Object $resourceId = this.getResourceId();
        result = result * PRIME + ($resourceId == null ? 43 : $resourceId.hashCode());
        final java.lang.Object $changes = this.getChanges();
        result = result * PRIME + ($changes == null ? 43 : $changes.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "StaffUpdateResponse(officeId=" + this.getOfficeId() + ", resourceId=" + this.getResourceId() + ", changes=" + this.getChanges() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public StaffUpdateResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public StaffUpdateResponse(final Long officeId, final Long resourceId, final Map<String, Object> changes) {
        this.officeId = officeId;
        this.resourceId = resourceId;
        this.changes = changes;
    }
}
