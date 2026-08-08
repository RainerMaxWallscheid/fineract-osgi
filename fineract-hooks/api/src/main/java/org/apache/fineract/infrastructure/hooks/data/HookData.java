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
package org.apache.fineract.infrastructure.hooks.data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

public final class HookData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private String name;
    private String displayName;
    private Boolean isActive;
    private LocalDate createdAt;
    private LocalDate updatedAt;
    private Long templateId;
    private String templateName;
    private List<HookEventData> events;
    private List<HookFieldData> config;
    private List<HookTemplateData> templates;
    private List<HookGroupingData> groupings;


    @java.lang.SuppressWarnings("all")
        public static class HookDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private String displayName;
        @java.lang.SuppressWarnings("all")
                private Boolean isActive;
        @java.lang.SuppressWarnings("all")
                private LocalDate createdAt;
        @java.lang.SuppressWarnings("all")
                private LocalDate updatedAt;
        @java.lang.SuppressWarnings("all")
                private Long templateId;
        @java.lang.SuppressWarnings("all")
                private String templateName;
        @java.lang.SuppressWarnings("all")
                private List<HookEventData> events;
        @java.lang.SuppressWarnings("all")
                private List<HookFieldData> config;
        @java.lang.SuppressWarnings("all")
                private List<HookTemplateData> templates;
        @java.lang.SuppressWarnings("all")
                private List<HookGroupingData> groupings;

        @java.lang.SuppressWarnings("all")
                HookDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookData.HookDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookData.HookDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookData.HookDataBuilder displayName(final String displayName) {
            this.displayName = displayName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookData.HookDataBuilder isActive(final Boolean isActive) {
            this.isActive = isActive;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookData.HookDataBuilder createdAt(final LocalDate createdAt) {
            this.createdAt = createdAt;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookData.HookDataBuilder updatedAt(final LocalDate updatedAt) {
            this.updatedAt = updatedAt;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookData.HookDataBuilder templateId(final Long templateId) {
            this.templateId = templateId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookData.HookDataBuilder templateName(final String templateName) {
            this.templateName = templateName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookData.HookDataBuilder events(final List<HookEventData> events) {
            this.events = events;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookData.HookDataBuilder config(final List<HookFieldData> config) {
            this.config = config;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookData.HookDataBuilder templates(final List<HookTemplateData> templates) {
            this.templates = templates;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookData.HookDataBuilder groupings(final List<HookGroupingData> groupings) {
            this.groupings = groupings;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public HookData build() {
            return new HookData(this.id, this.name, this.displayName, this.isActive, this.createdAt, this.updatedAt, this.templateId, this.templateName, this.events, this.config, this.templates, this.groupings);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "HookData.HookDataBuilder(id=" + this.id + ", name=" + this.name + ", displayName=" + this.displayName + ", isActive=" + this.isActive + ", createdAt=" + this.createdAt + ", updatedAt=" + this.updatedAt + ", templateId=" + this.templateId + ", templateName=" + this.templateName + ", events=" + this.events + ", config=" + this.config + ", templates=" + this.templates + ", groupings=" + this.groupings + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static HookData.HookDataBuilder builder() {
        return new HookData.HookDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getDisplayName() {
        return this.displayName;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsActive() {
        return this.isActive;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getCreatedAt() {
        return this.createdAt;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getUpdatedAt() {
        return this.updatedAt;
    }

    @java.lang.SuppressWarnings("all")
        public Long getTemplateId() {
        return this.templateId;
    }

    @java.lang.SuppressWarnings("all")
        public String getTemplateName() {
        return this.templateName;
    }

    @java.lang.SuppressWarnings("all")
        public List<HookEventData> getEvents() {
        return this.events;
    }

    @java.lang.SuppressWarnings("all")
        public List<HookFieldData> getConfig() {
        return this.config;
    }

    @java.lang.SuppressWarnings("all")
        public List<HookTemplateData> getTemplates() {
        return this.templates;
    }

    @java.lang.SuppressWarnings("all")
        public List<HookGroupingData> getGroupings() {
        return this.groupings;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookData setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookData setDisplayName(final String displayName) {
        this.displayName = displayName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookData setIsActive(final Boolean isActive) {
        this.isActive = isActive;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookData setCreatedAt(final LocalDate createdAt) {
        this.createdAt = createdAt;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookData setUpdatedAt(final LocalDate updatedAt) {
        this.updatedAt = updatedAt;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookData setTemplateId(final Long templateId) {
        this.templateId = templateId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookData setTemplateName(final String templateName) {
        this.templateName = templateName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookData setEvents(final List<HookEventData> events) {
        this.events = events;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookData setConfig(final List<HookFieldData> config) {
        this.config = config;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookData setTemplates(final List<HookTemplateData> templates) {
        this.templates = templates;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookData setGroupings(final List<HookGroupingData> groupings) {
        this.groupings = groupings;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof HookData)) return false;
        final HookData other = (HookData) o;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$isActive = this.getIsActive();
        final java.lang.Object other$isActive = other.getIsActive();
        if (this$isActive == null ? other$isActive != null : !this$isActive.equals(other$isActive)) return false;
        final java.lang.Object this$templateId = this.getTemplateId();
        final java.lang.Object other$templateId = other.getTemplateId();
        if (this$templateId == null ? other$templateId != null : !this$templateId.equals(other$templateId)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$displayName = this.getDisplayName();
        final java.lang.Object other$displayName = other.getDisplayName();
        if (this$displayName == null ? other$displayName != null : !this$displayName.equals(other$displayName)) return false;
        final java.lang.Object this$createdAt = this.getCreatedAt();
        final java.lang.Object other$createdAt = other.getCreatedAt();
        if (this$createdAt == null ? other$createdAt != null : !this$createdAt.equals(other$createdAt)) return false;
        final java.lang.Object this$updatedAt = this.getUpdatedAt();
        final java.lang.Object other$updatedAt = other.getUpdatedAt();
        if (this$updatedAt == null ? other$updatedAt != null : !this$updatedAt.equals(other$updatedAt)) return false;
        final java.lang.Object this$templateName = this.getTemplateName();
        final java.lang.Object other$templateName = other.getTemplateName();
        if (this$templateName == null ? other$templateName != null : !this$templateName.equals(other$templateName)) return false;
        final java.lang.Object this$events = this.getEvents();
        final java.lang.Object other$events = other.getEvents();
        if (this$events == null ? other$events != null : !this$events.equals(other$events)) return false;
        final java.lang.Object this$config = this.getConfig();
        final java.lang.Object other$config = other.getConfig();
        if (this$config == null ? other$config != null : !this$config.equals(other$config)) return false;
        final java.lang.Object this$templates = this.getTemplates();
        final java.lang.Object other$templates = other.getTemplates();
        if (this$templates == null ? other$templates != null : !this$templates.equals(other$templates)) return false;
        final java.lang.Object this$groupings = this.getGroupings();
        final java.lang.Object other$groupings = other.getGroupings();
        if (this$groupings == null ? other$groupings != null : !this$groupings.equals(other$groupings)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $isActive = this.getIsActive();
        result = result * PRIME + ($isActive == null ? 43 : $isActive.hashCode());
        final java.lang.Object $templateId = this.getTemplateId();
        result = result * PRIME + ($templateId == null ? 43 : $templateId.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $displayName = this.getDisplayName();
        result = result * PRIME + ($displayName == null ? 43 : $displayName.hashCode());
        final java.lang.Object $createdAt = this.getCreatedAt();
        result = result * PRIME + ($createdAt == null ? 43 : $createdAt.hashCode());
        final java.lang.Object $updatedAt = this.getUpdatedAt();
        result = result * PRIME + ($updatedAt == null ? 43 : $updatedAt.hashCode());
        final java.lang.Object $templateName = this.getTemplateName();
        result = result * PRIME + ($templateName == null ? 43 : $templateName.hashCode());
        final java.lang.Object $events = this.getEvents();
        result = result * PRIME + ($events == null ? 43 : $events.hashCode());
        final java.lang.Object $config = this.getConfig();
        result = result * PRIME + ($config == null ? 43 : $config.hashCode());
        final java.lang.Object $templates = this.getTemplates();
        result = result * PRIME + ($templates == null ? 43 : $templates.hashCode());
        final java.lang.Object $groupings = this.getGroupings();
        result = result * PRIME + ($groupings == null ? 43 : $groupings.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "HookData(id=" + this.getId() + ", name=" + this.getName() + ", displayName=" + this.getDisplayName() + ", isActive=" + this.getIsActive() + ", createdAt=" + this.getCreatedAt() + ", updatedAt=" + this.getUpdatedAt() + ", templateId=" + this.getTemplateId() + ", templateName=" + this.getTemplateName() + ", events=" + this.getEvents() + ", config=" + this.getConfig() + ", templates=" + this.getTemplates() + ", groupings=" + this.getGroupings() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public HookData() {
    }

    @java.lang.SuppressWarnings("all")
        public HookData(final Long id, final String name, final String displayName, final Boolean isActive, final LocalDate createdAt, final LocalDate updatedAt, final Long templateId, final String templateName, final List<HookEventData> events, final List<HookFieldData> config, final List<HookTemplateData> templates, final List<HookGroupingData> groupings) {
        this.id = id;
        this.name = name;
        this.displayName = displayName;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.templateId = templateId;
        this.templateName = templateName;
        this.events = events;
        this.config = config;
        this.templates = templates;
        this.groupings = groupings;
    }
}
