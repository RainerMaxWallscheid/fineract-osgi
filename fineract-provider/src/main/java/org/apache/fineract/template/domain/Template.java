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
package org.apache.fineract.template.domain;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OrderBy;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.util.List;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;

@Entity
@Table(name = "m_template", uniqueConstraints = {@UniqueConstraint(columnNames = {"name"}, name = "unq_name")})
public class Template extends AbstractPersistableCustom<Long> {
    @Column(name = "name", nullable = false, unique = true)
    private String name;
    @Enumerated
    @JsonSerialize(using = TemplateEntitySerializer.class)
    private TemplateEntity entity;
    @Enumerated
    @JsonSerialize(using = TemplateTypeSerializer.class)
    private TemplateType type;
    @Column(name = "text", columnDefinition = "longtext", nullable = false)
    private String text;
    @OrderBy("mapperorder")
    @OneToMany(targetEntity = TemplateMapper.class, cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinTable(name = "m_template_m_templatemappers", joinColumns = {@JoinColumn(name = "m_template_id", referencedColumnName = "id")}, inverseJoinColumns = {@JoinColumn(name = "mappers_id", referencedColumnName = "id", unique = true)})
    private List<TemplateMapper> mappers;

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public TemplateEntity getEntity() {
        return this.entity;
    }

    @java.lang.SuppressWarnings("all")
        public TemplateType getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public String getText() {
        return this.text;
    }

    @java.lang.SuppressWarnings("all")
        public List<TemplateMapper> getMappers() {
        return this.mappers;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Template setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Template setEntity(final TemplateEntity entity) {
        this.entity = entity;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Template setType(final TemplateType type) {
        this.type = type;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Template setText(final String text) {
        this.text = text;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Template setMappers(final List<TemplateMapper> mappers) {
        this.mappers = mappers;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public Template() {
    }
}
