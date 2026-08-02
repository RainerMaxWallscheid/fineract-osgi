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
package org.apache.fineract.mix.domain;

import java.io.Serial;
import java.io.Serializable;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

@Table("mix_taxonomy")
public final class MixTaxonomy implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Id
    @Column("id")
    private Long id;
    @Column("name")
    private String name;
    @Column("namespace_id")
    private Long namespaceId;
    @Column("dimension")
    private String dimension;
    @Column("type")
    private Integer type;
    @Column("description")
    private String description;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public Long getNamespaceId() {
        return this.namespaceId;
    }

    @java.lang.SuppressWarnings("all")
        public String getDimension() {
        return this.dimension;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixTaxonomy setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixTaxonomy setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixTaxonomy setNamespaceId(final Long namespaceId) {
        this.namespaceId = namespaceId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixTaxonomy setDimension(final String dimension) {
        this.dimension = dimension;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixTaxonomy setType(final Integer type) {
        this.type = type;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixTaxonomy setDescription(final String description) {
        this.description = description;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public MixTaxonomy() {
    }
    // TODO: this is never used, but creates an error on MySQL (tinyint vs boolean mapping)
    // @Column("need_mapping")
    // private Boolean needMapping;
}
