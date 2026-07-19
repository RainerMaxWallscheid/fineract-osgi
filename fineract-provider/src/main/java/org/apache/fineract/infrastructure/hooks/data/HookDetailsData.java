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

public final class HookDetailsData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private List<HookTemplateData> templates;
    private List<HookGroupingData> groupings;


    @java.lang.SuppressWarnings("all")
        public static class HookDetailsDataBuilder {
        @java.lang.SuppressWarnings("all")
                private List<HookTemplateData> templates;
        @java.lang.SuppressWarnings("all")
                private List<HookGroupingData> groupings;

        @java.lang.SuppressWarnings("all")
                HookDetailsDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookDetailsData.HookDetailsDataBuilder templates(final List<HookTemplateData> templates) {
            this.templates = templates;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookDetailsData.HookDetailsDataBuilder groupings(final List<HookGroupingData> groupings) {
            this.groupings = groupings;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public HookDetailsData build() {
            return new HookDetailsData(this.templates, this.groupings);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "HookDetailsData.HookDetailsDataBuilder(templates=" + this.templates + ", groupings=" + this.groupings + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static HookDetailsData.HookDetailsDataBuilder builder() {
        return new HookDetailsData.HookDetailsDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public List<HookTemplateData> getTemplates() {
        return this.templates;
    }

    @java.lang.SuppressWarnings("all")
        public List<HookGroupingData> getGroupings() {
        return this.groupings;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookDetailsData setTemplates(final List<HookTemplateData> templates) {
        this.templates = templates;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookDetailsData setGroupings(final List<HookGroupingData> groupings) {
        this.groupings = groupings;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof HookDetailsData)) return false;
        final HookDetailsData other = (HookDetailsData) o;
        final java.lang.Object this$templates = this.getTemplates();
        final java.lang.Object other$templates = other.getTemplates();
        if (this$templates == null ? other$templates != null : !this$templates.equals(other$templates)) return false;
        final java.lang.Object this$groupings = this.getGroupings();
        final java.lang.Object other$groupings = other.getGroupings();
        if (this$groupings == null ? other$groupings != null : !this$groupings.equals(other$groupings)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $templates = this.getTemplates();
        result = result * PRIME + ($templates == null ? 43 : $templates.hashCode());
        final java.lang.Object $groupings = this.getGroupings();
        result = result * PRIME + ($groupings == null ? 43 : $groupings.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "HookDetailsData(templates=" + this.getTemplates() + ", groupings=" + this.getGroupings() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public HookDetailsData() {
    }

    @java.lang.SuppressWarnings("all")
        public HookDetailsData(final List<HookTemplateData> templates, final List<HookGroupingData> groupings) {
        this.templates = templates;
        this.groupings = groupings;
    }
}
