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

import jakarta.validation.constraints.Size;
import java.io.Serial;
import java.io.Serializable;

public class TemplateCreateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Size(max = 200, message = "{org.apache.fineract.infrastructure.template.name.size}")
    private String name;
    private Integer type;
    private Integer entity;
    private String text;


    @java.lang.SuppressWarnings("all")
        public static class TemplateCreateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private Integer type;
        @java.lang.SuppressWarnings("all")
                private Integer entity;
        @java.lang.SuppressWarnings("all")
                private String text;

        @java.lang.SuppressWarnings("all")
                TemplateCreateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateCreateRequest.TemplateCreateRequestBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateCreateRequest.TemplateCreateRequestBuilder type(final Integer type) {
            this.type = type;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateCreateRequest.TemplateCreateRequestBuilder entity(final Integer entity) {
            this.entity = entity;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateCreateRequest.TemplateCreateRequestBuilder text(final String text) {
            this.text = text;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public TemplateCreateRequest build() {
            return new TemplateCreateRequest(this.name, this.type, this.entity, this.text);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "TemplateCreateRequest.TemplateCreateRequestBuilder(name=" + this.name + ", type=" + this.type + ", entity=" + this.entity + ", text=" + this.text + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static TemplateCreateRequest.TemplateCreateRequestBuilder builder() {
        return new TemplateCreateRequest.TemplateCreateRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getEntity() {
        return this.entity;
    }

    @java.lang.SuppressWarnings("all")
        public String getText() {
        return this.text;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setType(final Integer type) {
        this.type = type;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntity(final Integer entity) {
        this.entity = entity;
    }

    @java.lang.SuppressWarnings("all")
        public void setText(final String text) {
        this.text = text;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof TemplateCreateRequest)) return false;
        final TemplateCreateRequest other = (TemplateCreateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final java.lang.Object this$entity = this.getEntity();
        final java.lang.Object other$entity = other.getEntity();
        if (this$entity == null ? other$entity != null : !this$entity.equals(other$entity)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$text = this.getText();
        final java.lang.Object other$text = other.getText();
        if (this$text == null ? other$text != null : !this$text.equals(other$text)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof TemplateCreateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final java.lang.Object $entity = this.getEntity();
        result = result * PRIME + ($entity == null ? 43 : $entity.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $text = this.getText();
        result = result * PRIME + ($text == null ? 43 : $text.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "TemplateCreateRequest(name=" + this.getName() + ", type=" + this.getType() + ", entity=" + this.getEntity() + ", text=" + this.getText() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public TemplateCreateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public TemplateCreateRequest(final String name, final Integer type, final Integer entity, final String text) {
        this.name = name;
        this.type = type;
        this.entity = entity;
        this.text = text;
    }
}
