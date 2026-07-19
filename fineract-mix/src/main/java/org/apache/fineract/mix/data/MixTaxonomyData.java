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
package org.apache.fineract.mix.data;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.io.Serial;
import java.io.Serializable;

public class MixTaxonomyData implements Serializable {
    public static final Integer PORTFOLIO = 0;
    public static final Integer BALANCE_SHEET = 1;
    public static final Integer INCOME = 2;
    public static final Integer EXPENSE = 3;
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private String name;
    private String namespace;
    private String dimension;
    private Integer type;
    private String description;

    // TODO: why is this different from the PORTFOLIO constant? This doesn't seem right!
    @JsonIgnore
    public boolean isPortfolio() {
        return this.type == 5;
    }


    @java.lang.SuppressWarnings("all")
        public static class MixTaxonomyDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private String namespace;
        @java.lang.SuppressWarnings("all")
                private String dimension;
        @java.lang.SuppressWarnings("all")
                private Integer type;
        @java.lang.SuppressWarnings("all")
                private String description;

        @java.lang.SuppressWarnings("all")
                MixTaxonomyDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixTaxonomyData.MixTaxonomyDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixTaxonomyData.MixTaxonomyDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixTaxonomyData.MixTaxonomyDataBuilder namespace(final String namespace) {
            this.namespace = namespace;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixTaxonomyData.MixTaxonomyDataBuilder dimension(final String dimension) {
            this.dimension = dimension;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixTaxonomyData.MixTaxonomyDataBuilder type(final Integer type) {
            this.type = type;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixTaxonomyData.MixTaxonomyDataBuilder description(final String description) {
            this.description = description;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public MixTaxonomyData build() {
            return new MixTaxonomyData(this.id, this.name, this.namespace, this.dimension, this.type, this.description);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "MixTaxonomyData.MixTaxonomyDataBuilder(id=" + this.id + ", name=" + this.name + ", namespace=" + this.namespace + ", dimension=" + this.dimension + ", type=" + this.type + ", description=" + this.description + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static MixTaxonomyData.MixTaxonomyDataBuilder builder() {
        return new MixTaxonomyData.MixTaxonomyDataBuilder();
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
        public String getNamespace() {
        return this.namespace;
    }

    @java.lang.SuppressWarnings("all")
        public String getDimension() {
        return this.dimension;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixTaxonomyData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixTaxonomyData setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixTaxonomyData setNamespace(final String namespace) {
        this.namespace = namespace;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixTaxonomyData setDimension(final String dimension) {
        this.dimension = dimension;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixTaxonomyData setType(final Integer type) {
        this.type = type;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixTaxonomyData setDescription(final String description) {
        this.description = description;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof MixTaxonomyData)) return false;
        final MixTaxonomyData other = (MixTaxonomyData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$namespace = this.getNamespace();
        final java.lang.Object other$namespace = other.getNamespace();
        if (this$namespace == null ? other$namespace != null : !this$namespace.equals(other$namespace)) return false;
        final java.lang.Object this$dimension = this.getDimension();
        final java.lang.Object other$dimension = other.getDimension();
        if (this$dimension == null ? other$dimension != null : !this$dimension.equals(other$dimension)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof MixTaxonomyData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $namespace = this.getNamespace();
        result = result * PRIME + ($namespace == null ? 43 : $namespace.hashCode());
        final java.lang.Object $dimension = this.getDimension();
        result = result * PRIME + ($dimension == null ? 43 : $dimension.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "MixTaxonomyData(id=" + this.getId() + ", name=" + this.getName() + ", namespace=" + this.getNamespace() + ", dimension=" + this.getDimension() + ", type=" + this.getType() + ", description=" + this.getDescription() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public MixTaxonomyData() {
    }

    @java.lang.SuppressWarnings("all")
        public MixTaxonomyData(final Long id, final String name, final String namespace, final String dimension, final Integer type, final String description) {
        this.id = id;
        this.name = name;
        this.namespace = namespace;
        this.dimension = dimension;
        this.type = type;
        this.description = description;
    }
}
