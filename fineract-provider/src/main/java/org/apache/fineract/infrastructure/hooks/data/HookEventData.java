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

public final class HookEventData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String actionName;
    private String entityName;

    public static HookEventData instance(final String actionName, final String entityName) {
        return new HookEventData().setActionName(actionName).setEntityName(entityName);
    }


    @java.lang.SuppressWarnings("all")
        public static class HookEventDataBuilder {
        @java.lang.SuppressWarnings("all")
                private String actionName;
        @java.lang.SuppressWarnings("all")
                private String entityName;

        @java.lang.SuppressWarnings("all")
                HookEventDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookEventData.HookEventDataBuilder actionName(final String actionName) {
            this.actionName = actionName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookEventData.HookEventDataBuilder entityName(final String entityName) {
            this.entityName = entityName;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public HookEventData build() {
            return new HookEventData(this.actionName, this.entityName);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "HookEventData.HookEventDataBuilder(actionName=" + this.actionName + ", entityName=" + this.entityName + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static HookEventData.HookEventDataBuilder builder() {
        return new HookEventData.HookEventDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getActionName() {
        return this.actionName;
    }

    @java.lang.SuppressWarnings("all")
        public String getEntityName() {
        return this.entityName;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookEventData setActionName(final String actionName) {
        this.actionName = actionName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookEventData setEntityName(final String entityName) {
        this.entityName = entityName;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof HookEventData)) return false;
        final HookEventData other = (HookEventData) o;
        final java.lang.Object this$actionName = this.getActionName();
        final java.lang.Object other$actionName = other.getActionName();
        if (this$actionName == null ? other$actionName != null : !this$actionName.equals(other$actionName)) return false;
        final java.lang.Object this$entityName = this.getEntityName();
        final java.lang.Object other$entityName = other.getEntityName();
        if (this$entityName == null ? other$entityName != null : !this$entityName.equals(other$entityName)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $actionName = this.getActionName();
        result = result * PRIME + ($actionName == null ? 43 : $actionName.hashCode());
        final java.lang.Object $entityName = this.getEntityName();
        result = result * PRIME + ($entityName == null ? 43 : $entityName.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "HookEventData(actionName=" + this.getActionName() + ", entityName=" + this.getEntityName() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public HookEventData() {
    }

    @java.lang.SuppressWarnings("all")
        public HookEventData(final String actionName, final String entityName) {
        this.actionName = actionName;
        this.entityName = entityName;
    }
}
