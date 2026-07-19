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
package org.apache.fineract.infrastructure.documentmanagement.data;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.io.Serial;
import java.io.Serializable;

public class ImageDeleteRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @NotNull(message = "{org.apache.fineract.document.xxx.not-null}")
    @Size(max = 50, message = "{org.apache.fineract.document.xxx.not-null}")
    private String entityType;
    @NotNull(message = "{org.apache.fineract.document.xxx.not-null}")
    private Long entityId;


    @java.lang.SuppressWarnings("all")
        public static class ImageDeleteRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private String entityType;
        @java.lang.SuppressWarnings("all")
                private Long entityId;

        @java.lang.SuppressWarnings("all")
                ImageDeleteRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ImageDeleteRequest.ImageDeleteRequestBuilder entityType(final String entityType) {
            this.entityType = entityType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ImageDeleteRequest.ImageDeleteRequestBuilder entityId(final Long entityId) {
            this.entityId = entityId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ImageDeleteRequest build() {
            return new ImageDeleteRequest(this.entityType, this.entityId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ImageDeleteRequest.ImageDeleteRequestBuilder(entityType=" + this.entityType + ", entityId=" + this.entityId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ImageDeleteRequest.ImageDeleteRequestBuilder builder() {
        return new ImageDeleteRequest.ImageDeleteRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getEntityType() {
        return this.entityType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getEntityId() {
        return this.entityId;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntityType(final String entityType) {
        this.entityType = entityType;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntityId(final Long entityId) {
        this.entityId = entityId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ImageDeleteRequest)) return false;
        final ImageDeleteRequest other = (ImageDeleteRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$entityId = this.getEntityId();
        final java.lang.Object other$entityId = other.getEntityId();
        if (this$entityId == null ? other$entityId != null : !this$entityId.equals(other$entityId)) return false;
        final java.lang.Object this$entityType = this.getEntityType();
        final java.lang.Object other$entityType = other.getEntityType();
        if (this$entityType == null ? other$entityType != null : !this$entityType.equals(other$entityType)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ImageDeleteRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $entityId = this.getEntityId();
        result = result * PRIME + ($entityId == null ? 43 : $entityId.hashCode());
        final java.lang.Object $entityType = this.getEntityType();
        result = result * PRIME + ($entityType == null ? 43 : $entityType.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ImageDeleteRequest(entityType=" + this.getEntityType() + ", entityId=" + this.getEntityId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ImageDeleteRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public ImageDeleteRequest(final String entityType, final Long entityId) {
        this.entityType = entityType;
        this.entityId = entityId;
    }
}
