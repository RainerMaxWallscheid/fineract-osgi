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
package org.apache.fineract.portfolio.note.data;

import io.swagger.v3.oas.annotations.Hidden;
import java.io.Serial;
import java.io.Serializable;
import org.apache.fineract.portfolio.note.domain.NoteType;

public class NoteDeleteRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Hidden
    private Long id;
    @Hidden
    private Long resourceId;
    @Hidden
    private NoteType type;


    @java.lang.SuppressWarnings("all")
        public static class NoteDeleteRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private Long resourceId;
        @java.lang.SuppressWarnings("all")
                private NoteType type;

        @java.lang.SuppressWarnings("all")
                NoteDeleteRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteDeleteRequest.NoteDeleteRequestBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteDeleteRequest.NoteDeleteRequestBuilder resourceId(final Long resourceId) {
            this.resourceId = resourceId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteDeleteRequest.NoteDeleteRequestBuilder type(final NoteType type) {
            this.type = type;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public NoteDeleteRequest build() {
            return new NoteDeleteRequest(this.id, this.resourceId, this.type);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "NoteDeleteRequest.NoteDeleteRequestBuilder(id=" + this.id + ", resourceId=" + this.resourceId + ", type=" + this.type + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static NoteDeleteRequest.NoteDeleteRequestBuilder builder() {
        return new NoteDeleteRequest.NoteDeleteRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getResourceId() {
        return this.resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public NoteType getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceId(final Long resourceId) {
        this.resourceId = resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public void setType(final NoteType type) {
        this.type = type;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof NoteDeleteRequest)) return false;
        final NoteDeleteRequest other = (NoteDeleteRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$resourceId = this.getResourceId();
        final java.lang.Object other$resourceId = other.getResourceId();
        if (this$resourceId == null ? other$resourceId != null : !this$resourceId.equals(other$resourceId)) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof NoteDeleteRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $resourceId = this.getResourceId();
        result = result * PRIME + ($resourceId == null ? 43 : $resourceId.hashCode());
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "NoteDeleteRequest(id=" + this.getId() + ", resourceId=" + this.getResourceId() + ", type=" + this.getType() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public NoteDeleteRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public NoteDeleteRequest(final Long id, final Long resourceId, final NoteType type) {
        this.id = id;
        this.resourceId = resourceId;
        this.type = type;
    }
}
