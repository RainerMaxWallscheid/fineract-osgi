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

@Table("m_image")
public final class Image implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Id
    @Column("id")
    private Long id;
    @Column("location")
    private String location;
    @Column("storage_type_enum")
    private Integer storageType;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
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
        public Image setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Image setLocation(final String location) {
        this.location = location;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Image setStorageType(final Integer storageType) {
        this.storageType = storageType;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public Image() {
    }

    @java.lang.SuppressWarnings("all")
        public Image(final Long id, final String location, final Integer storageType) {
        this.id = id;
        this.location = location;
        this.storageType = storageType;
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String id = "id";
        public static final java.lang.String location = "location";
        public static final java.lang.String storageType = "storageType";
    }
}
