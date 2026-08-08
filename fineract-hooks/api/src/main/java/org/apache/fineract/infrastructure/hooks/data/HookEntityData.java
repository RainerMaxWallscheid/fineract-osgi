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

public class HookEntityData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String name;
    private List<String> actions;


    @java.lang.SuppressWarnings("all")
        public static class HookEntityDataBuilder {
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private List<String> actions;

        @java.lang.SuppressWarnings("all")
                HookEntityDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookEntityData.HookEntityDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookEntityData.HookEntityDataBuilder actions(final List<String> actions) {
            this.actions = actions;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public HookEntityData build() {
            return new HookEntityData(this.name, this.actions);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "HookEntityData.HookEntityDataBuilder(name=" + this.name + ", actions=" + this.actions + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static HookEntityData.HookEntityDataBuilder builder() {
        return new HookEntityData.HookEntityDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public List<String> getActions() {
        return this.actions;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookEntityData setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookEntityData setActions(final List<String> actions) {
        this.actions = actions;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof HookEntityData)) return false;
        final HookEntityData other = (HookEntityData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$actions = this.getActions();
        final java.lang.Object other$actions = other.getActions();
        if (this$actions == null ? other$actions != null : !this$actions.equals(other$actions)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof HookEntityData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $actions = this.getActions();
        result = result * PRIME + ($actions == null ? 43 : $actions.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "HookEntityData(name=" + this.getName() + ", actions=" + this.getActions() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public HookEntityData() {
    }

    @java.lang.SuppressWarnings("all")
        public HookEntityData(final String name, final List<String> actions) {
        this.name = name;
        this.actions = actions;
    }
}
