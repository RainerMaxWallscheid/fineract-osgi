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

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.util.HashSet;
import java.util.Set;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableCustom;
import org.apache.fineract.template.domain.Template;

@Entity
@Table(name = "m_hook")
public final class Hook extends AbstractAuditableCustom {
    @Column(name = "name", nullable = false, length = 100)
    private String name;
    @Column(name = "is_active", nullable = false)
    private Boolean isActive;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "hook", orphanRemoval = true, fetch = FetchType.EAGER)
    private Set<HookResource> events = new HashSet<>();
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "hook", orphanRemoval = true, fetch = FetchType.EAGER)
    private Set<HookConfiguration> config = new HashSet<>();
    @ManyToOne(optional = true)
    @JoinColumn(name = "template_id", referencedColumnName = "id", nullable = false)
    private HookTemplate template;
    @ManyToOne(optional = true)
    @JoinColumn(name = "ugd_template_id", referencedColumnName = "id", nullable = true)
    private Template ugdTemplate;

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsActive() {
        return this.isActive;
    }

    @java.lang.SuppressWarnings("all")
        public Set<HookResource> getEvents() {
        return this.events;
    }

    @java.lang.SuppressWarnings("all")
        public Set<HookConfiguration> getConfig() {
        return this.config;
    }

    @java.lang.SuppressWarnings("all")
        public HookTemplate getTemplate() {
        return this.template;
    }

    @java.lang.SuppressWarnings("all")
        public Template getUgdTemplate() {
        return this.ugdTemplate;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Hook setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Hook setIsActive(final Boolean isActive) {
        this.isActive = isActive;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Hook setEvents(final Set<HookResource> events) {
        this.events = events;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Hook setConfig(final Set<HookConfiguration> config) {
        this.config = config;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Hook setTemplate(final HookTemplate template) {
        this.template = template;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Hook setUgdTemplate(final Template ugdTemplate) {
        this.ugdTemplate = ugdTemplate;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public Hook() {
    }
}
