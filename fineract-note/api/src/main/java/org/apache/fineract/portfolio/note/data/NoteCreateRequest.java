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
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.io.Serial;
import java.io.Serializable;
import org.apache.fineract.portfolio.note.domain.NoteType;

public class NoteCreateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Hidden
    private Long resourceId;
    @Hidden
    private NoteType type;
    @Size(max = 1000, message = "{org.apache.fineract.portfolio.note.note.size}")
    @NotNull(message = "{org.apache.fineract.portfolio.note.note.not-null}")
    private String note;


    @java.lang.SuppressWarnings("all")
        public static class NoteCreateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long resourceId;
        @java.lang.SuppressWarnings("all")
                private NoteType type;
        @java.lang.SuppressWarnings("all")
                private String note;

        @java.lang.SuppressWarnings("all")
                NoteCreateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteCreateRequest.NoteCreateRequestBuilder resourceId(final Long resourceId) {
            this.resourceId = resourceId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteCreateRequest.NoteCreateRequestBuilder type(final NoteType type) {
            this.type = type;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public NoteCreateRequest.NoteCreateRequestBuilder note(final String note) {
            this.note = note;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public NoteCreateRequest build() {
            return new NoteCreateRequest(this.resourceId, this.type, this.note);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "NoteCreateRequest.NoteCreateRequestBuilder(resourceId=" + this.resourceId + ", type=" + this.type + ", note=" + this.note + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static NoteCreateRequest.NoteCreateRequestBuilder builder() {
        return new NoteCreateRequest.NoteCreateRequestBuilder();
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
        public String getNote() {
        return this.note;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceId(final Long resourceId) {
        this.resourceId = resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public void setType(final NoteType type) {
        this.type = type;
    }

    @java.lang.SuppressWarnings("all")
        public void setNote(final String note) {
        this.note = note;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof NoteCreateRequest)) return false;
        final NoteCreateRequest other = (NoteCreateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$resourceId = this.getResourceId();
        final java.lang.Object other$resourceId = other.getResourceId();
        if (this$resourceId == null ? other$resourceId != null : !this$resourceId.equals(other$resourceId)) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final java.lang.Object this$note = this.getNote();
        final java.lang.Object other$note = other.getNote();
        if (this$note == null ? other$note != null : !this$note.equals(other$note)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof NoteCreateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $resourceId = this.getResourceId();
        result = result * PRIME + ($resourceId == null ? 43 : $resourceId.hashCode());
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final java.lang.Object $note = this.getNote();
        result = result * PRIME + ($note == null ? 43 : $note.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "NoteCreateRequest(resourceId=" + this.getResourceId() + ", type=" + this.getType() + ", note=" + this.getNote() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public NoteCreateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public NoteCreateRequest(final Long resourceId, final NoteType type, final String note) {
        this.resourceId = resourceId;
        this.type = type;
        this.note = note;
    }
}
