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
package org.apache.fineract.infrastructure.hooks.data;

import java.io.Serial;
import java.io.Serializable;

public class HookDeleteResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long resourceId;


    @java.lang.SuppressWarnings("all")
        public static class HookDeleteResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private Long resourceId;

        @java.lang.SuppressWarnings("all")
                HookDeleteResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookDeleteResponse.HookDeleteResponseBuilder resourceId(final Long resourceId) {
            this.resourceId = resourceId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public HookDeleteResponse build() {
            return new HookDeleteResponse(this.resourceId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "HookDeleteResponse.HookDeleteResponseBuilder(resourceId=" + this.resourceId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static HookDeleteResponse.HookDeleteResponseBuilder builder() {
        return new HookDeleteResponse.HookDeleteResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getResourceId() {
        return this.resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceId(final Long resourceId) {
        this.resourceId = resourceId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof HookDeleteResponse)) return false;
        final HookDeleteResponse other = (HookDeleteResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$resourceId = this.getResourceId();
        final java.lang.Object other$resourceId = other.getResourceId();
        if (this$resourceId == null ? other$resourceId != null : !this$resourceId.equals(other$resourceId)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof HookDeleteResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $resourceId = this.getResourceId();
        result = result * PRIME + ($resourceId == null ? 43 : $resourceId.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "HookDeleteResponse(resourceId=" + this.getResourceId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public HookDeleteResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public HookDeleteResponse(final Long resourceId) {
        this.resourceId = resourceId;
    }
}
