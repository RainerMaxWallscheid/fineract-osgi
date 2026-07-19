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
package org.apache.fineract.infrastructure.hooks.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;

@Entity
@Table(name = "m_hook_schema")
public class HookSchema extends AbstractPersistableCustom<Long> {
    @ManyToOne(optional = false)
    @JoinColumn(name = "hook_template_id", referencedColumnName = "id", nullable = false)
    private HookTemplate template;
    @Column(name = "field_type", nullable = false, length = 20)
    private String fieldType;
    @Column(name = "field_name", nullable = false, length = 100)
    private String fieldName;
    @Column(name = "placeholder", length = 100)
    private String placeholder;
    @Column(name = "optional", nullable = false)
    private boolean optional = false;

    @java.lang.SuppressWarnings("all")
        public HookTemplate getTemplate() {
        return this.template;
    }

    @java.lang.SuppressWarnings("all")
        public String getFieldType() {
        return this.fieldType;
    }

    @java.lang.SuppressWarnings("all")
        public String getFieldName() {
        return this.fieldName;
    }

    @java.lang.SuppressWarnings("all")
        public String getPlaceholder() {
        return this.placeholder;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isOptional() {
        return this.optional;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookSchema setTemplate(final HookTemplate template) {
        this.template = template;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookSchema setFieldType(final String fieldType) {
        this.fieldType = fieldType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookSchema setFieldName(final String fieldName) {
        this.fieldName = fieldName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookSchema setPlaceholder(final String placeholder) {
        this.placeholder = placeholder;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookSchema setOptional(final boolean optional) {
        this.optional = optional;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public HookSchema() {
    }
}
