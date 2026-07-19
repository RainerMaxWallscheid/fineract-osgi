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

import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.v3.oas.annotations.Hidden;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.io.InputStream;
import java.io.Serial;
import java.io.Serializable;

public class DocumentUpdateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @NotNull(message = "{org.apache.fineract.document.id.not-null}")
    private Long id;
    @NotNull(message = "{org.apache.fineract.document.entity-type.not-null}")
    @Size(max = 50, message = "{org.apache.fineract.document.entity-type.size}")
    private String entityType;
    @NotNull(message = "{org.apache.fineract.document.entity-id.not-null}")
    private Long entityId;
    @Size(max = 250, message = "{org.apache.fineract.document.name.size}")
    private String name;
    @Size(max = 250, message = "{org.apache.fineract.document.description.size}")
    private String description;
    @Size(max = 250, message = "{org.apache.fineract.document.file-name.size}")
    private String fileName;
    @NotNull(message = "{org.apache.fineract.document.size.not-null}")
    @Min(value = 1, message = "{org.apache.fineract.document.size.min}")
    private Long size;
    private String type;
    @Hidden
    @JsonIgnore
    private InputStream stream;


    @java.lang.SuppressWarnings("all")
        public static class DocumentUpdateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String entityType;
        @java.lang.SuppressWarnings("all")
                private Long entityId;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private String description;
        @java.lang.SuppressWarnings("all")
                private String fileName;
        @java.lang.SuppressWarnings("all")
                private Long size;
        @java.lang.SuppressWarnings("all")
                private String type;
        @java.lang.SuppressWarnings("all")
                private InputStream stream;

        @java.lang.SuppressWarnings("all")
                DocumentUpdateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentUpdateRequest.DocumentUpdateRequestBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentUpdateRequest.DocumentUpdateRequestBuilder entityType(final String entityType) {
            this.entityType = entityType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentUpdateRequest.DocumentUpdateRequestBuilder entityId(final Long entityId) {
            this.entityId = entityId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentUpdateRequest.DocumentUpdateRequestBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentUpdateRequest.DocumentUpdateRequestBuilder description(final String description) {
            this.description = description;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentUpdateRequest.DocumentUpdateRequestBuilder fileName(final String fileName) {
            this.fileName = fileName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentUpdateRequest.DocumentUpdateRequestBuilder size(final Long size) {
            this.size = size;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentUpdateRequest.DocumentUpdateRequestBuilder type(final String type) {
            this.type = type;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @JsonIgnore
        @java.lang.SuppressWarnings("all")
                public DocumentUpdateRequest.DocumentUpdateRequestBuilder stream(final InputStream stream) {
            this.stream = stream;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public DocumentUpdateRequest build() {
            return new DocumentUpdateRequest(this.id, this.entityType, this.entityId, this.name, this.description, this.fileName, this.size, this.type, this.stream);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "DocumentUpdateRequest.DocumentUpdateRequestBuilder(id=" + this.id + ", entityType=" + this.entityType + ", entityId=" + this.entityId + ", name=" + this.name + ", description=" + this.description + ", fileName=" + this.fileName + ", size=" + this.size + ", type=" + this.type + ", stream=" + this.stream + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static DocumentUpdateRequest.DocumentUpdateRequestBuilder builder() {
        return new DocumentUpdateRequest.DocumentUpdateRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
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
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public String getFileName() {
        return this.fileName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getSize() {
        return this.size;
    }

    @java.lang.SuppressWarnings("all")
        public String getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public InputStream getStream() {
        return this.stream;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntityType(final String entityType) {
        this.entityType = entityType;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntityId(final Long entityId) {
        this.entityId = entityId;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setDescription(final String description) {
        this.description = description;
    }

    @java.lang.SuppressWarnings("all")
        public void setFileName(final String fileName) {
        this.fileName = fileName;
    }

    @java.lang.SuppressWarnings("all")
        public void setSize(final Long size) {
        this.size = size;
    }

    @java.lang.SuppressWarnings("all")
        public void setType(final String type) {
        this.type = type;
    }

    @java.lang.SuppressWarnings("all")
        public void setStream(final InputStream stream) {
        this.stream = stream;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof DocumentUpdateRequest)) return false;
        final DocumentUpdateRequest other = (DocumentUpdateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$entityId = this.getEntityId();
        final java.lang.Object other$entityId = other.getEntityId();
        if (this$entityId == null ? other$entityId != null : !this$entityId.equals(other$entityId)) return false;
        final java.lang.Object this$size = this.getSize();
        final java.lang.Object other$size = other.getSize();
        if (this$size == null ? other$size != null : !this$size.equals(other$size)) return false;
        final java.lang.Object this$entityType = this.getEntityType();
        final java.lang.Object other$entityType = other.getEntityType();
        if (this$entityType == null ? other$entityType != null : !this$entityType.equals(other$entityType)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        final java.lang.Object this$fileName = this.getFileName();
        final java.lang.Object other$fileName = other.getFileName();
        if (this$fileName == null ? other$fileName != null : !this$fileName.equals(other$fileName)) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final java.lang.Object this$stream = this.getStream();
        final java.lang.Object other$stream = other.getStream();
        if (this$stream == null ? other$stream != null : !this$stream.equals(other$stream)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof DocumentUpdateRequest;
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
        final java.lang.Object $size = this.getSize();
        result = result * PRIME + ($size == null ? 43 : $size.hashCode());
        final java.lang.Object $entityType = this.getEntityType();
        result = result * PRIME + ($entityType == null ? 43 : $entityType.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        final java.lang.Object $fileName = this.getFileName();
        result = result * PRIME + ($fileName == null ? 43 : $fileName.hashCode());
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final java.lang.Object $stream = this.getStream();
        result = result * PRIME + ($stream == null ? 43 : $stream.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DocumentUpdateRequest(id=" + this.getId() + ", entityType=" + this.getEntityType() + ", entityId=" + this.getEntityId() + ", name=" + this.getName() + ", description=" + this.getDescription() + ", fileName=" + this.getFileName() + ", size=" + this.getSize() + ", type=" + this.getType() + ", stream=" + this.getStream() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public DocumentUpdateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public DocumentUpdateRequest(final Long id, final String entityType, final Long entityId, final String name, final String description, final String fileName, final Long size, final String type, final InputStream stream) {
        this.id = id;
        this.entityType = entityType;
        this.entityId = entityId;
        this.name = name;
        this.description = description;
        this.fileName = fileName;
        this.size = size;
        this.type = type;
        this.stream = stream;
    }
}
