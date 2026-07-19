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
import java.util.List;

public final class HookTemplateData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private String name;
    // associations
    private List<HookFieldData> schema;

    public static HookTemplateData instance(final Long id, final String name, final List<HookFieldData> schema) {
        return new HookTemplateData().setId(id).setName(name).setSchema(schema);
    }


    @java.lang.SuppressWarnings("all")
        public static class HookTemplateDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private List<HookFieldData> schema;

        @java.lang.SuppressWarnings("all")
                HookTemplateDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookTemplateData.HookTemplateDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookTemplateData.HookTemplateDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookTemplateData.HookTemplateDataBuilder schema(final List<HookFieldData> schema) {
            this.schema = schema;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public HookTemplateData build() {
            return new HookTemplateData(this.id, this.name, this.schema);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "HookTemplateData.HookTemplateDataBuilder(id=" + this.id + ", name=" + this.name + ", schema=" + this.schema + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static HookTemplateData.HookTemplateDataBuilder builder() {
        return new HookTemplateData.HookTemplateDataBuilder();
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
        public List<HookFieldData> getSchema() {
        return this.schema;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookTemplateData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookTemplateData setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookTemplateData setSchema(final List<HookFieldData> schema) {
        this.schema = schema;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof HookTemplateData)) return false;
        final HookTemplateData other = (HookTemplateData) o;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$schema = this.getSchema();
        final java.lang.Object other$schema = other.getSchema();
        if (this$schema == null ? other$schema != null : !this$schema.equals(other$schema)) return false;
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
        final java.lang.Object $schema = this.getSchema();
        result = result * PRIME + ($schema == null ? 43 : $schema.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "HookTemplateData(id=" + this.getId() + ", name=" + this.getName() + ", schema=" + this.getSchema() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public HookTemplateData() {
    }

    @java.lang.SuppressWarnings("all")
        public HookTemplateData(final Long id, final String name, final List<HookFieldData> schema) {
        this.id = id;
        this.name = name;
        this.schema = schema;
    }
}
