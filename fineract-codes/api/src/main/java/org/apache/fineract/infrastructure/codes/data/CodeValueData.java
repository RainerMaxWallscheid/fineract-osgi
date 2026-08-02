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
package org.apache.fineract.infrastructure.codes.data;

import java.io.Serializable;

/**
 * Immutable data object represent code-value data in system.
 */
public class CodeValueData implements Serializable {
    private Long id;
    private String name;
    private Integer position;
    private String description;
    private Boolean active;
    private Boolean mandatory;

    public static CodeValueData instance(final Long id, final String name, final String description, final Integer position, final boolean isActive, final boolean mandatory) {
        return new CodeValueData().setId(id).setName(name).setPosition(position).setDescription(description).setActive(isActive).setMandatory(mandatory);
    }

    public static CodeValueData instance(final Long id, final String name, final String description, final boolean isActive) {
        Integer position = null;
        boolean mandatory = false;
        return new CodeValueData().setId(id).setName(name).setPosition(position).setDescription(description).setActive(isActive).setMandatory(mandatory);
    }

    public static CodeValueData instance(final Long id, final String name) {
        String description = null;
        Integer position = null;
        Boolean active = null;
        Boolean mandatory = null;
        return new CodeValueData().setId(id).setName(name).setPosition(position).setDescription(description).setActive(active).setMandatory(mandatory);
    }

    public static CodeValueData instance(final Long id, final String name, final Integer position, final String description, final boolean isActive, final boolean mandatory) {
        return new CodeValueData().setId(id).setName(name).setPosition(position).setDescription(description).setActive(isActive).setMandatory(mandatory);
    }


    @java.lang.SuppressWarnings("all")
        public static class CodeValueDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private Integer position;
        @java.lang.SuppressWarnings("all")
                private String description;
        @java.lang.SuppressWarnings("all")
                private Boolean active;
        @java.lang.SuppressWarnings("all")
                private Boolean mandatory;

        @java.lang.SuppressWarnings("all")
                CodeValueDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CodeValueData.CodeValueDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CodeValueData.CodeValueDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CodeValueData.CodeValueDataBuilder position(final Integer position) {
            this.position = position;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CodeValueData.CodeValueDataBuilder description(final String description) {
            this.description = description;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CodeValueData.CodeValueDataBuilder active(final Boolean active) {
            this.active = active;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CodeValueData.CodeValueDataBuilder mandatory(final Boolean mandatory) {
            this.mandatory = mandatory;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public CodeValueData build() {
            return new CodeValueData(this.id, this.name, this.position, this.description, this.active, this.mandatory);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "CodeValueData.CodeValueDataBuilder(id=" + this.id + ", name=" + this.name + ", position=" + this.position + ", description=" + this.description + ", active=" + this.active + ", mandatory=" + this.mandatory + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static CodeValueData.CodeValueDataBuilder builder() {
        return new CodeValueData.CodeValueDataBuilder();
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
        public Integer getPosition() {
        return this.position;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getActive() {
        return this.active;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getMandatory() {
        return this.mandatory;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CodeValueData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CodeValueData setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CodeValueData setPosition(final Integer position) {
        this.position = position;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CodeValueData setDescription(final String description) {
        this.description = description;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CodeValueData setActive(final Boolean active) {
        this.active = active;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CodeValueData setMandatory(final Boolean mandatory) {
        this.mandatory = mandatory;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CodeValueData)) return false;
        final CodeValueData other = (CodeValueData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$position = this.getPosition();
        final java.lang.Object other$position = other.getPosition();
        if (this$position == null ? other$position != null : !this$position.equals(other$position)) return false;
        final java.lang.Object this$active = this.getActive();
        final java.lang.Object other$active = other.getActive();
        if (this$active == null ? other$active != null : !this$active.equals(other$active)) return false;
        final java.lang.Object this$mandatory = this.getMandatory();
        final java.lang.Object other$mandatory = other.getMandatory();
        if (this$mandatory == null ? other$mandatory != null : !this$mandatory.equals(other$mandatory)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof CodeValueData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $position = this.getPosition();
        result = result * PRIME + ($position == null ? 43 : $position.hashCode());
        final java.lang.Object $active = this.getActive();
        result = result * PRIME + ($active == null ? 43 : $active.hashCode());
        final java.lang.Object $mandatory = this.getMandatory();
        result = result * PRIME + ($mandatory == null ? 43 : $mandatory.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CodeValueData(id=" + this.getId() + ", name=" + this.getName() + ", position=" + this.getPosition() + ", description=" + this.getDescription() + ", active=" + this.getActive() + ", mandatory=" + this.getMandatory() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CodeValueData() {
    }

    @java.lang.SuppressWarnings("all")
        public CodeValueData(final Long id, final String name, final Integer position, final String description, final Boolean active, final Boolean mandatory) {
        this.id = id;
        this.name = name;
        this.position = position;
        this.description = description;
        this.active = active;
        this.mandatory = mandatory;
    }
}
