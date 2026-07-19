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
package org.apache.fineract.template.data;

import jakarta.validation.constraints.NotNull;
import java.io.Serial;
import java.io.Serializable;
import java.util.List;

public class TemplateUpdateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @NotNull(message = "{org.apache.fineract.infrastructure.template.id.not-null}")
    private Long id;
    private String name;
    private String text;
    public Integer entity;
    public Integer type;
    private List<TemplateMapperData> mappers;


    @java.lang.SuppressWarnings("all")
        public static class TemplateUpdateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private String text;
        @java.lang.SuppressWarnings("all")
                private Integer entity;
        @java.lang.SuppressWarnings("all")
                private Integer type;
        @java.lang.SuppressWarnings("all")
                private List<TemplateMapperData> mappers;

        @java.lang.SuppressWarnings("all")
                TemplateUpdateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateUpdateRequest.TemplateUpdateRequestBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateUpdateRequest.TemplateUpdateRequestBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateUpdateRequest.TemplateUpdateRequestBuilder text(final String text) {
            this.text = text;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateUpdateRequest.TemplateUpdateRequestBuilder entity(final Integer entity) {
            this.entity = entity;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateUpdateRequest.TemplateUpdateRequestBuilder type(final Integer type) {
            this.type = type;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateUpdateRequest.TemplateUpdateRequestBuilder mappers(final List<TemplateMapperData> mappers) {
            this.mappers = mappers;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public TemplateUpdateRequest build() {
            return new TemplateUpdateRequest(this.id, this.name, this.text, this.entity, this.type, this.mappers);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "TemplateUpdateRequest.TemplateUpdateRequestBuilder(id=" + this.id + ", name=" + this.name + ", text=" + this.text + ", entity=" + this.entity + ", type=" + this.type + ", mappers=" + this.mappers + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static TemplateUpdateRequest.TemplateUpdateRequestBuilder builder() {
        return new TemplateUpdateRequest.TemplateUpdateRequestBuilder();
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
        public String getText() {
        return this.text;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getEntity() {
        return this.entity;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public List<TemplateMapperData> getMappers() {
        return this.mappers;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setText(final String text) {
        this.text = text;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntity(final Integer entity) {
        this.entity = entity;
    }

    @java.lang.SuppressWarnings("all")
        public void setType(final Integer type) {
        this.type = type;
    }

    @java.lang.SuppressWarnings("all")
        public void setMappers(final List<TemplateMapperData> mappers) {
        this.mappers = mappers;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof TemplateUpdateRequest)) return false;
        final TemplateUpdateRequest other = (TemplateUpdateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$entity = this.getEntity();
        final java.lang.Object other$entity = other.getEntity();
        if (this$entity == null ? other$entity != null : !this$entity.equals(other$entity)) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$text = this.getText();
        final java.lang.Object other$text = other.getText();
        if (this$text == null ? other$text != null : !this$text.equals(other$text)) return false;
        final java.lang.Object this$mappers = this.getMappers();
        final java.lang.Object other$mappers = other.getMappers();
        if (this$mappers == null ? other$mappers != null : !this$mappers.equals(other$mappers)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof TemplateUpdateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $entity = this.getEntity();
        result = result * PRIME + ($entity == null ? 43 : $entity.hashCode());
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $text = this.getText();
        result = result * PRIME + ($text == null ? 43 : $text.hashCode());
        final java.lang.Object $mappers = this.getMappers();
        result = result * PRIME + ($mappers == null ? 43 : $mappers.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "TemplateUpdateRequest(id=" + this.getId() + ", name=" + this.getName() + ", text=" + this.getText() + ", entity=" + this.getEntity() + ", type=" + this.getType() + ", mappers=" + this.getMappers() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public TemplateUpdateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public TemplateUpdateRequest(final Long id, final String name, final String text, final Integer entity, final Integer type, final List<TemplateMapperData> mappers) {
        this.id = id;
        this.name = name;
        this.text = text;
        this.entity = entity;
        this.type = type;
        this.mappers = mappers;
    }
}
