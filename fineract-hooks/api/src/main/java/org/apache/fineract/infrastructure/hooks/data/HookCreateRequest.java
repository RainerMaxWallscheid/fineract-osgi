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

import jakarta.validation.constraints.Size;
import java.io.Serial;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class HookCreateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Size(max = 100, message = "{org.apache.fineract.infrastructure.hooks.name.size}")
    private String name;
    private Boolean isActive;
    private String displayName;
    private Long templateId;
    private List<HookEventData> events;
    private Map<String, String> config;


    @java.lang.SuppressWarnings("all")
        public static class HookCreateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private Boolean isActive;
        @java.lang.SuppressWarnings("all")
                private String displayName;
        @java.lang.SuppressWarnings("all")
                private Long templateId;
        @java.lang.SuppressWarnings("all")
                private List<HookEventData> events;
        @java.lang.SuppressWarnings("all")
                private Map<String, String> config;

        @java.lang.SuppressWarnings("all")
                HookCreateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookCreateRequest.HookCreateRequestBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookCreateRequest.HookCreateRequestBuilder isActive(final Boolean isActive) {
            this.isActive = isActive;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookCreateRequest.HookCreateRequestBuilder displayName(final String displayName) {
            this.displayName = displayName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookCreateRequest.HookCreateRequestBuilder templateId(final Long templateId) {
            this.templateId = templateId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookCreateRequest.HookCreateRequestBuilder events(final List<HookEventData> events) {
            this.events = events;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookCreateRequest.HookCreateRequestBuilder config(final Map<String, String> config) {
            this.config = config;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public HookCreateRequest build() {
            return new HookCreateRequest(this.name, this.isActive, this.displayName, this.templateId, this.events, this.config);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "HookCreateRequest.HookCreateRequestBuilder(name=" + this.name + ", isActive=" + this.isActive + ", displayName=" + this.displayName + ", templateId=" + this.templateId + ", events=" + this.events + ", config=" + this.config + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static HookCreateRequest.HookCreateRequestBuilder builder() {
        return new HookCreateRequest.HookCreateRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsActive() {
        return this.isActive;
    }

    @java.lang.SuppressWarnings("all")
        public String getDisplayName() {
        return this.displayName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getTemplateId() {
        return this.templateId;
    }

    @java.lang.SuppressWarnings("all")
        public List<HookEventData> getEvents() {
        return this.events;
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, String> getConfig() {
        return this.config;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsActive(final Boolean isActive) {
        this.isActive = isActive;
    }

    @java.lang.SuppressWarnings("all")
        public void setDisplayName(final String displayName) {
        this.displayName = displayName;
    }

    @java.lang.SuppressWarnings("all")
        public void setTemplateId(final Long templateId) {
        this.templateId = templateId;
    }

    @java.lang.SuppressWarnings("all")
        public void setEvents(final List<HookEventData> events) {
        this.events = events;
    }

    @java.lang.SuppressWarnings("all")
        public void setConfig(final Map<String, String> config) {
        this.config = config;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof HookCreateRequest)) return false;
        final HookCreateRequest other = (HookCreateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
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
        final java.lang.Object this$events = this.getEvents();
        final java.lang.Object other$events = other.getEvents();
        if (this$events == null ? other$events != null : !this$events.equals(other$events)) return false;
        final java.lang.Object this$config = this.getConfig();
        final java.lang.Object other$config = other.getConfig();
        if (this$config == null ? other$config != null : !this$config.equals(other$config)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof HookCreateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $isActive = this.getIsActive();
        result = result * PRIME + ($isActive == null ? 43 : $isActive.hashCode());
        final java.lang.Object $templateId = this.getTemplateId();
        result = result * PRIME + ($templateId == null ? 43 : $templateId.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $displayName = this.getDisplayName();
        result = result * PRIME + ($displayName == null ? 43 : $displayName.hashCode());
        final java.lang.Object $events = this.getEvents();
        result = result * PRIME + ($events == null ? 43 : $events.hashCode());
        final java.lang.Object $config = this.getConfig();
        result = result * PRIME + ($config == null ? 43 : $config.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "HookCreateRequest(name=" + this.getName() + ", isActive=" + this.getIsActive() + ", displayName=" + this.getDisplayName() + ", templateId=" + this.getTemplateId() + ", events=" + this.getEvents() + ", config=" + this.getConfig() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public HookCreateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public HookCreateRequest(final String name, final Boolean isActive, final String displayName, final Long templateId, final List<HookEventData> events, final Map<String, String> config) {
        this.name = name;
        this.isActive = isActive;
        this.displayName = displayName;
        this.templateId = templateId;
        this.events = events;
        this.config = config;
    }
}
