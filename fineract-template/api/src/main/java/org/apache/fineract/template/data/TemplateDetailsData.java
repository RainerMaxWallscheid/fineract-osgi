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

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

public final class TemplateDetailsData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private List<TemplateItemData> entities;
    private List<TemplateItemData> types;
    private TemplateData template;


    @java.lang.SuppressWarnings("all")
        public static class TemplateDetailsDataBuilder {
        @java.lang.SuppressWarnings("all")
                private List<TemplateItemData> entities;
        @java.lang.SuppressWarnings("all")
                private List<TemplateItemData> types;
        @java.lang.SuppressWarnings("all")
                private TemplateData template;

        @java.lang.SuppressWarnings("all")
                TemplateDetailsDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateDetailsData.TemplateDetailsDataBuilder entities(final List<TemplateItemData> entities) {
            this.entities = entities;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateDetailsData.TemplateDetailsDataBuilder types(final List<TemplateItemData> types) {
            this.types = types;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateDetailsData.TemplateDetailsDataBuilder template(final TemplateData template) {
            this.template = template;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public TemplateDetailsData build() {
            return new TemplateDetailsData(this.entities, this.types, this.template);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "TemplateDetailsData.TemplateDetailsDataBuilder(entities=" + this.entities + ", types=" + this.types + ", template=" + this.template + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static TemplateDetailsData.TemplateDetailsDataBuilder builder() {
        return new TemplateDetailsData.TemplateDetailsDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public List<TemplateItemData> getEntities() {
        return this.entities;
    }

    @java.lang.SuppressWarnings("all")
        public List<TemplateItemData> getTypes() {
        return this.types;
    }

    @java.lang.SuppressWarnings("all")
        public TemplateData getTemplate() {
        return this.template;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntities(final List<TemplateItemData> entities) {
        this.entities = entities;
    }

    @java.lang.SuppressWarnings("all")
        public void setTypes(final List<TemplateItemData> types) {
        this.types = types;
    }

    @java.lang.SuppressWarnings("all")
        public void setTemplate(final TemplateData template) {
        this.template = template;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof TemplateDetailsData)) return false;
        final TemplateDetailsData other = (TemplateDetailsData) o;
        final java.lang.Object this$entities = this.getEntities();
        final java.lang.Object other$entities = other.getEntities();
        if (this$entities == null ? other$entities != null : !this$entities.equals(other$entities)) return false;
        final java.lang.Object this$types = this.getTypes();
        final java.lang.Object other$types = other.getTypes();
        if (this$types == null ? other$types != null : !this$types.equals(other$types)) return false;
        final java.lang.Object this$template = this.getTemplate();
        final java.lang.Object other$template = other.getTemplate();
        if (this$template == null ? other$template != null : !this$template.equals(other$template)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $entities = this.getEntities();
        result = result * PRIME + ($entities == null ? 43 : $entities.hashCode());
        final java.lang.Object $types = this.getTypes();
        result = result * PRIME + ($types == null ? 43 : $types.hashCode());
        final java.lang.Object $template = this.getTemplate();
        result = result * PRIME + ($template == null ? 43 : $template.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "TemplateDetailsData(entities=" + this.getEntities() + ", types=" + this.getTypes() + ", template=" + this.getTemplate() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public TemplateDetailsData() {
    }

    @java.lang.SuppressWarnings("all")
        public TemplateDetailsData(final List<TemplateItemData> entities, final List<TemplateItemData> types, final TemplateData template) {
        this.entities = entities;
        this.types = types;
        this.template = template;
    }
}
