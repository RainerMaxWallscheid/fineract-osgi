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
package org.apache.fineract.infrastructure.documentmanagement.data;

import java.io.Serial;
import java.io.Serializable;

public class DocumentDeleteResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long resourceId;
    private String resourceIdentifier;


    @java.lang.SuppressWarnings("all")
        public static class DocumentDeleteResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private Long resourceId;
        @java.lang.SuppressWarnings("all")
                private String resourceIdentifier;

        @java.lang.SuppressWarnings("all")
                DocumentDeleteResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentDeleteResponse.DocumentDeleteResponseBuilder resourceId(final Long resourceId) {
            this.resourceId = resourceId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentDeleteResponse.DocumentDeleteResponseBuilder resourceIdentifier(final String resourceIdentifier) {
            this.resourceIdentifier = resourceIdentifier;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public DocumentDeleteResponse build() {
            return new DocumentDeleteResponse(this.resourceId, this.resourceIdentifier);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "DocumentDeleteResponse.DocumentDeleteResponseBuilder(resourceId=" + this.resourceId + ", resourceIdentifier=" + this.resourceIdentifier + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static DocumentDeleteResponse.DocumentDeleteResponseBuilder builder() {
        return new DocumentDeleteResponse.DocumentDeleteResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getResourceId() {
        return this.resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public String getResourceIdentifier() {
        return this.resourceIdentifier;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceId(final Long resourceId) {
        this.resourceId = resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceIdentifier(final String resourceIdentifier) {
        this.resourceIdentifier = resourceIdentifier;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof DocumentDeleteResponse)) return false;
        final DocumentDeleteResponse other = (DocumentDeleteResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$resourceId = this.getResourceId();
        final java.lang.Object other$resourceId = other.getResourceId();
        if (this$resourceId == null ? other$resourceId != null : !this$resourceId.equals(other$resourceId)) return false;
        final java.lang.Object this$resourceIdentifier = this.getResourceIdentifier();
        final java.lang.Object other$resourceIdentifier = other.getResourceIdentifier();
        if (this$resourceIdentifier == null ? other$resourceIdentifier != null : !this$resourceIdentifier.equals(other$resourceIdentifier)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof DocumentDeleteResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $resourceId = this.getResourceId();
        result = result * PRIME + ($resourceId == null ? 43 : $resourceId.hashCode());
        final java.lang.Object $resourceIdentifier = this.getResourceIdentifier();
        result = result * PRIME + ($resourceIdentifier == null ? 43 : $resourceIdentifier.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DocumentDeleteResponse(resourceId=" + this.getResourceId() + ", resourceIdentifier=" + this.getResourceIdentifier() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public DocumentDeleteResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public DocumentDeleteResponse(final Long resourceId, final String resourceIdentifier) {
        this.resourceId = resourceId;
        this.resourceIdentifier = resourceIdentifier;
    }
}
