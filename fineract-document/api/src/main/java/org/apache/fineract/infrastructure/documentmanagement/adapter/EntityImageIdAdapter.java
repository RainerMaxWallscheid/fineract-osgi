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
package org.apache.fineract.infrastructure.documentmanagement.adapter;

import java.io.Serial;
import java.io.Serializable;
import java.util.Optional;
// NOTE: this is a trick to decouple the entity image IDs from the image service
@Deprecated
public interface EntityImageIdAdapter {
    boolean accept(String entityType);

    Optional<ImageIdResult> get(Long entityId);

    Optional<ImageIdResult> set(Long entityId, Long imageId);


    class ImageIdResult implements Serializable {
        @Serial
        private static final long serialVersionUID = 1L;
        private Long id;
        private String displayName;


        @java.lang.SuppressWarnings("all")
                public static class ImageIdResultBuilder {
            @java.lang.SuppressWarnings("all")
                        private Long id;
            @java.lang.SuppressWarnings("all")
                        private String displayName;

            @java.lang.SuppressWarnings("all")
                        ImageIdResultBuilder() {
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public EntityImageIdAdapter.ImageIdResult.ImageIdResultBuilder id(final Long id) {
                this.id = id;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public EntityImageIdAdapter.ImageIdResult.ImageIdResultBuilder displayName(final String displayName) {
                this.displayName = displayName;
                return this;
            }

            @java.lang.SuppressWarnings("all")
                        public EntityImageIdAdapter.ImageIdResult build() {
                return new EntityImageIdAdapter.ImageIdResult(this.id, this.displayName);
            }

            @java.lang.Override
            @java.lang.SuppressWarnings("all")
                        public java.lang.String toString() {
                return "EntityImageIdAdapter.ImageIdResult.ImageIdResultBuilder(id=" + this.id + ", displayName=" + this.displayName + ")";
            }
        }

        @java.lang.SuppressWarnings("all")
                public static EntityImageIdAdapter.ImageIdResult.ImageIdResultBuilder builder() {
            return new EntityImageIdAdapter.ImageIdResult.ImageIdResultBuilder();
        }

        @java.lang.SuppressWarnings("all")
                public Long getId() {
            return this.id;
        }

        @java.lang.SuppressWarnings("all")
                public String getDisplayName() {
            return this.displayName;
        }

        @java.lang.SuppressWarnings("all")
                public void setId(final Long id) {
            this.id = id;
        }

        @java.lang.SuppressWarnings("all")
                public void setDisplayName(final String displayName) {
            this.displayName = displayName;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public boolean equals(final java.lang.Object o) {
            if (o == this) return true;
            if (!(o instanceof EntityImageIdAdapter.ImageIdResult)) return false;
            final EntityImageIdAdapter.ImageIdResult other = (EntityImageIdAdapter.ImageIdResult) o;
            if (!other.canEqual((java.lang.Object) this)) return false;
            final java.lang.Object this$id = this.getId();
            final java.lang.Object other$id = other.getId();
            if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
            final java.lang.Object this$displayName = this.getDisplayName();
            final java.lang.Object other$displayName = other.getDisplayName();
            if (this$displayName == null ? other$displayName != null : !this$displayName.equals(other$displayName)) return false;
            return true;
        }

        @java.lang.SuppressWarnings("all")
                protected boolean canEqual(final java.lang.Object other) {
            return other instanceof EntityImageIdAdapter.ImageIdResult;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public int hashCode() {
            final int PRIME = 59;
            int result = 1;
            final java.lang.Object $id = this.getId();
            result = result * PRIME + ($id == null ? 43 : $id.hashCode());
            final java.lang.Object $displayName = this.getDisplayName();
            result = result * PRIME + ($displayName == null ? 43 : $displayName.hashCode());
            return result;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "EntityImageIdAdapter.ImageIdResult(id=" + this.getId() + ", displayName=" + this.getDisplayName() + ")";
        }

        @java.lang.SuppressWarnings("all")
                public ImageIdResult() {
        }

        @java.lang.SuppressWarnings("all")
                public ImageIdResult(final Long id, final String displayName) {
            this.id = id;
            this.displayName = displayName;
        }
    }
}
