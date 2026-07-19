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

import io.swagger.v3.oas.annotations.media.Schema;
import java.io.Serial;
import java.io.Serializable;
import java.util.List;

public final class TemplateData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private String name;
    private String text;
    @Schema(implementation = Integer.class)
    private String entity;
    @Schema(implementation = Integer.class)
    private String type;
    private List<TemplateMapperData> mappers;


    @java.lang.SuppressWarnings("all")
        public static class TemplateDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private String text;
        @java.lang.SuppressWarnings("all")
                private String entity;
        @java.lang.SuppressWarnings("all")
                private String type;
        @java.lang.SuppressWarnings("all")
                private List<TemplateMapperData> mappers;

        @java.lang.SuppressWarnings("all")
                TemplateDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateData.TemplateDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateData.TemplateDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateData.TemplateDataBuilder text(final String text) {
            this.text = text;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateData.TemplateDataBuilder entity(final String entity) {
            this.entity = entity;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateData.TemplateDataBuilder type(final String type) {
            this.type = type;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateData.TemplateDataBuilder mappers(final List<TemplateMapperData> mappers) {
            this.mappers = mappers;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public TemplateData build() {
            return new TemplateData(this.id, this.name, this.text, this.entity, this.type, this.mappers);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "TemplateData.TemplateDataBuilder(id=" + this.id + ", name=" + this.name + ", text=" + this.text + ", entity=" + this.entity + ", type=" + this.type + ", mappers=" + this.mappers + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static TemplateData.TemplateDataBuilder builder() {
        return new TemplateData.TemplateDataBuilder();
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
        public String getEntity() {
        return this.entity;
    }

    @java.lang.SuppressWarnings("all")
        public String getType() {
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
        public void setEntity(final String entity) {
        this.entity = entity;
    }

    @java.lang.SuppressWarnings("all")
        public void setType(final String type) {
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
        if (!(o instanceof TemplateData)) return false;
        final TemplateData other = (TemplateData) o;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$text = this.getText();
        final java.lang.Object other$text = other.getText();
        if (this$text == null ? other$text != null : !this$text.equals(other$text)) return false;
        final java.lang.Object this$entity = this.getEntity();
        final java.lang.Object other$entity = other.getEntity();
        if (this$entity == null ? other$entity != null : !this$entity.equals(other$entity)) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final java.lang.Object this$mappers = this.getMappers();
        final java.lang.Object other$mappers = other.getMappers();
        if (this$mappers == null ? other$mappers != null : !this$mappers.equals(other$mappers)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $text = this.getText();
        result = result * PRIME + ($text == null ? 43 : $text.hashCode());
        final java.lang.Object $entity = this.getEntity();
        result = result * PRIME + ($entity == null ? 43 : $entity.hashCode());
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final java.lang.Object $mappers = this.getMappers();
        result = result * PRIME + ($mappers == null ? 43 : $mappers.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "TemplateData(id=" + this.getId() + ", name=" + this.getName() + ", text=" + this.getText() + ", entity=" + this.getEntity() + ", type=" + this.getType() + ", mappers=" + this.getMappers() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public TemplateData() {
    }

    @java.lang.SuppressWarnings("all")
        public TemplateData(final Long id, final String name, final String text, final String entity, final String type, final List<TemplateMapperData> mappers) {
        this.id = id;
        this.name = name;
        this.text = text;
        this.entity = entity;
        this.type = type;
        this.mappers = mappers;
    }
}
