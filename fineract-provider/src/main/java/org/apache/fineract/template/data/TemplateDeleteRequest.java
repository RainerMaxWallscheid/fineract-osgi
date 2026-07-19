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

import jakarta.validation.constraints.NotNull;
import java.io.Serial;
import java.io.Serializable;

public class TemplateDeleteRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @NotNull(message = "{org.apache.fineract.infrastructure.template.id.not-null}")
    private Long id;


    @java.lang.SuppressWarnings("all")
        public static class TemplateDeleteRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;

        @java.lang.SuppressWarnings("all")
                TemplateDeleteRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateDeleteRequest.TemplateDeleteRequestBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public TemplateDeleteRequest build() {
            return new TemplateDeleteRequest(this.id);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "TemplateDeleteRequest.TemplateDeleteRequestBuilder(id=" + this.id + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static TemplateDeleteRequest.TemplateDeleteRequestBuilder builder() {
        return new TemplateDeleteRequest.TemplateDeleteRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof TemplateDeleteRequest)) return false;
        final TemplateDeleteRequest other = (TemplateDeleteRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof TemplateDeleteRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "TemplateDeleteRequest(id=" + this.getId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public TemplateDeleteRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public TemplateDeleteRequest(final Long id) {
        this.id = id;
    }
}
