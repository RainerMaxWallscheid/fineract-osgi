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
package org.apache.fineract.infrastructure.documentmanagement.domain;

import java.io.Serial;
import java.io.Serializable;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

@Table("m_document")
public final class Document implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Id
    @Column("id")
    private Long id;
    @Column("parent_entity_type")
    private String parentEntityType;
    @Column("parent_entity_id")
    private Long parentEntityId;
    @Column("name")
    private String name;
    @Column("file_name")
    private String fileName;
    @Column("size")
    private Long size;
    @Column("type")
    private String type;
    @Column("description")
    private String description;
    @Column("location")
    private String location;
    @Column("storage_type_enum")
    private Integer storageType;

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
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocation() {
        return this.location;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getStorageType() {
        return this.storageType;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Document setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Document setParentEntityType(final String parentEntityType) {
        this.parentEntityType = parentEntityType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Document setParentEntityId(final Long parentEntityId) {
        this.parentEntityId = parentEntityId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Document setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Document setFileName(final String fileName) {
        this.fileName = fileName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Document setSize(final Long size) {
        this.size = size;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Document setType(final String type) {
        this.type = type;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Document setDescription(final String description) {
        this.description = description;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Document setLocation(final String location) {
        this.location = location;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Document setStorageType(final Integer storageType) {
        this.storageType = storageType;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public Document() {
    }

    @java.lang.SuppressWarnings("all")
        public Document(final Long id, final String parentEntityType, final Long parentEntityId, final String name, final String fileName, final Long size, final String type, final String description, final String location, final Integer storageType) {
        this.id = id;
        this.parentEntityType = parentEntityType;
        this.parentEntityId = parentEntityId;
        this.name = name;
        this.fileName = fileName;
        this.size = size;
        this.type = type;
        this.description = description;
        this.location = location;
        this.storageType = storageType;
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String id = "id";
        public static final java.lang.String parentEntityType = "parentEntityType";
        public static final java.lang.String parentEntityId = "parentEntityId";
        public static final java.lang.String name = "name";
        public static final java.lang.String fileName = "fileName";
        public static final java.lang.String size = "size";
        public static final java.lang.String type = "type";
        public static final java.lang.String description = "description";
        public static final java.lang.String location = "location";
        public static final java.lang.String storageType = "storageType";
    }
}
