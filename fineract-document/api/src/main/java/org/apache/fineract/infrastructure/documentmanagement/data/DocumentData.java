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

import java.io.Serial;
import java.io.Serializable;

public class DocumentData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private String parentEntityType;
    private Long parentEntityId;
    private String name;
    private String fileName;
    private Long size;
    private String type;
    private String location;
    private String description;
    private Integer storageType;


    @java.lang.SuppressWarnings("all")
        public static class DocumentDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String parentEntityType;
        @java.lang.SuppressWarnings("all")
                private Long parentEntityId;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private String fileName;
        @java.lang.SuppressWarnings("all")
                private Long size;
        @java.lang.SuppressWarnings("all")
                private String type;
        @java.lang.SuppressWarnings("all")
                private String location;
        @java.lang.SuppressWarnings("all")
                private String description;
        @java.lang.SuppressWarnings("all")
                private Integer storageType;

        @java.lang.SuppressWarnings("all")
                DocumentDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentData.DocumentDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentData.DocumentDataBuilder parentEntityType(final String parentEntityType) {
            this.parentEntityType = parentEntityType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentData.DocumentDataBuilder parentEntityId(final Long parentEntityId) {
            this.parentEntityId = parentEntityId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentData.DocumentDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentData.DocumentDataBuilder fileName(final String fileName) {
            this.fileName = fileName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentData.DocumentDataBuilder size(final Long size) {
            this.size = size;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentData.DocumentDataBuilder type(final String type) {
            this.type = type;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentData.DocumentDataBuilder location(final String location) {
            this.location = location;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentData.DocumentDataBuilder description(final String description) {
            this.description = description;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentData.DocumentDataBuilder storageType(final Integer storageType) {
            this.storageType = storageType;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public DocumentData build() {
            return new DocumentData(this.id, this.parentEntityType, this.parentEntityId, this.name, this.fileName, this.size, this.type, this.location, this.description, this.storageType);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "DocumentData.DocumentDataBuilder(id=" + this.id + ", parentEntityType=" + this.parentEntityType + ", parentEntityId=" + this.parentEntityId + ", name=" + this.name + ", fileName=" + this.fileName + ", size=" + this.size + ", type=" + this.type + ", location=" + this.location + ", description=" + this.description + ", storageType=" + this.storageType + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static DocumentData.DocumentDataBuilder builder() {
        return new DocumentData.DocumentDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getParentEntityType() {
        return this.parentEntityType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getParentEntityId() {
        return this.parentEntityId;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
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
        public String getLocation() {
        return this.location;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getStorageType() {
        return this.storageType;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setParentEntityType(final String parentEntityType) {
        this.parentEntityType = parentEntityType;
    }

    @java.lang.SuppressWarnings("all")
        public void setParentEntityId(final Long parentEntityId) {
        this.parentEntityId = parentEntityId;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
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
        public void setLocation(final String location) {
        this.location = location;
    }

    @java.lang.SuppressWarnings("all")
        public void setDescription(final String description) {
        this.description = description;
    }

    @java.lang.SuppressWarnings("all")
        public void setStorageType(final Integer storageType) {
        this.storageType = storageType;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof DocumentData)) return false;
        final DocumentData other = (DocumentData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$parentEntityId = this.getParentEntityId();
        final java.lang.Object other$parentEntityId = other.getParentEntityId();
        if (this$parentEntityId == null ? other$parentEntityId != null : !this$parentEntityId.equals(other$parentEntityId)) return false;
        final java.lang.Object this$size = this.getSize();
        final java.lang.Object other$size = other.getSize();
        if (this$size == null ? other$size != null : !this$size.equals(other$size)) return false;
        final java.lang.Object this$storageType = this.getStorageType();
        final java.lang.Object other$storageType = other.getStorageType();
        if (this$storageType == null ? other$storageType != null : !this$storageType.equals(other$storageType)) return false;
        final java.lang.Object this$parentEntityType = this.getParentEntityType();
        final java.lang.Object other$parentEntityType = other.getParentEntityType();
        if (this$parentEntityType == null ? other$parentEntityType != null : !this$parentEntityType.equals(other$parentEntityType)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$fileName = this.getFileName();
        final java.lang.Object other$fileName = other.getFileName();
        if (this$fileName == null ? other$fileName != null : !this$fileName.equals(other$fileName)) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final java.lang.Object this$location = this.getLocation();
        final java.lang.Object other$location = other.getLocation();
        if (this$location == null ? other$location != null : !this$location.equals(other$location)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof DocumentData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $parentEntityId = this.getParentEntityId();
        result = result * PRIME + ($parentEntityId == null ? 43 : $parentEntityId.hashCode());
        final java.lang.Object $size = this.getSize();
        result = result * PRIME + ($size == null ? 43 : $size.hashCode());
        final java.lang.Object $storageType = this.getStorageType();
        result = result * PRIME + ($storageType == null ? 43 : $storageType.hashCode());
        final java.lang.Object $parentEntityType = this.getParentEntityType();
        result = result * PRIME + ($parentEntityType == null ? 43 : $parentEntityType.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $fileName = this.getFileName();
        result = result * PRIME + ($fileName == null ? 43 : $fileName.hashCode());
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final java.lang.Object $location = this.getLocation();
        result = result * PRIME + ($location == null ? 43 : $location.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DocumentData(id=" + this.getId() + ", parentEntityType=" + this.getParentEntityType() + ", parentEntityId=" + this.getParentEntityId() + ", name=" + this.getName() + ", fileName=" + this.getFileName() + ", size=" + this.getSize() + ", type=" + this.getType() + ", location=" + this.getLocation() + ", description=" + this.getDescription() + ", storageType=" + this.getStorageType() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public DocumentData() {
    }

    @java.lang.SuppressWarnings("all")
        public DocumentData(final Long id, final String parentEntityType, final Long parentEntityId, final String name, final String fileName, final Long size, final String type, final String location, final String description, final Integer storageType) {
        this.id = id;
        this.parentEntityType = parentEntityType;
        this.parentEntityId = parentEntityId;
        this.name = name;
        this.fileName = fileName;
        this.size = size;
        this.type = type;
        this.location = location;
        this.description = description;
        this.storageType = storageType;
    }
}
