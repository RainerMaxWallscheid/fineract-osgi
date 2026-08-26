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
package org.apache.fineract.organisation.staff.moduleapi;

import java.io.Serial;
import java.io.Serializable;

public class StaffCreateResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long officeId;
    private Long resourceId;


    @java.lang.SuppressWarnings("all")
        public static class StaffCreateResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private Long officeId;
        @java.lang.SuppressWarnings("all")
                private Long resourceId;

        @java.lang.SuppressWarnings("all")
                StaffCreateResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffCreateResponse.StaffCreateResponseBuilder officeId(final Long officeId) {
            this.officeId = officeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffCreateResponse.StaffCreateResponseBuilder resourceId(final Long resourceId) {
            this.resourceId = resourceId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public StaffCreateResponse build() {
            return new StaffCreateResponse(this.officeId, this.resourceId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "StaffCreateResponse.StaffCreateResponseBuilder(officeId=" + this.officeId + ", resourceId=" + this.resourceId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static StaffCreateResponse.StaffCreateResponseBuilder builder() {
        return new StaffCreateResponse.StaffCreateResponseBuilder();
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
        public void setOfficeId(final Long officeId) {
        this.officeId = officeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceId(final Long resourceId) {
        this.resourceId = resourceId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof StaffCreateResponse)) return false;
        final StaffCreateResponse other = (StaffCreateResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$resourceId = this.getResourceId();
        final java.lang.Object other$resourceId = other.getResourceId();
        if (this$resourceId == null ? other$resourceId != null : !this$resourceId.equals(other$resourceId)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof StaffCreateResponse;
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
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "StaffCreateResponse(officeId=" + this.getOfficeId() + ", resourceId=" + this.getResourceId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public StaffCreateResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public StaffCreateResponse(final Long officeId, final Long resourceId) {
        this.officeId = officeId;
        this.resourceId = resourceId;
    }
}
