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

public class HookGroupingData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String name;
    private List<HookEntityData> entities;


    @java.lang.SuppressWarnings("all")
        public static class HookGroupingDataBuilder {
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private List<HookEntityData> entities;

        @java.lang.SuppressWarnings("all")
                HookGroupingDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookGroupingData.HookGroupingDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookGroupingData.HookGroupingDataBuilder entities(final List<HookEntityData> entities) {
            this.entities = entities;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public HookGroupingData build() {
            return new HookGroupingData(this.name, this.entities);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "HookGroupingData.HookGroupingDataBuilder(name=" + this.name + ", entities=" + this.entities + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static HookGroupingData.HookGroupingDataBuilder builder() {
        return new HookGroupingData.HookGroupingDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public List<HookEntityData> getEntities() {
        return this.entities;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookGroupingData setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookGroupingData setEntities(final List<HookEntityData> entities) {
        this.entities = entities;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof HookGroupingData)) return false;
        final HookGroupingData other = (HookGroupingData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$entities = this.getEntities();
        final java.lang.Object other$entities = other.getEntities();
        if (this$entities == null ? other$entities != null : !this$entities.equals(other$entities)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof HookGroupingData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $entities = this.getEntities();
        result = result * PRIME + ($entities == null ? 43 : $entities.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "HookGroupingData(name=" + this.getName() + ", entities=" + this.getEntities() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public HookGroupingData() {
    }

    @java.lang.SuppressWarnings("all")
        public HookGroupingData(final String name, final List<HookEntityData> entities) {
        this.name = name;
        this.entities = entities;
    }
}
