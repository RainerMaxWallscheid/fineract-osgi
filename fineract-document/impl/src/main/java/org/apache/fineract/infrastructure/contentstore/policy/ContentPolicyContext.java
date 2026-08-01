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
package org.apache.fineract.infrastructure.contentstore.policy;

import java.io.InputStream;

public final class ContentPolicyContext {
    private String path;
    private Long size;
    private InputStream inputStream;
    private String mimeType;
    private String extension;


    @java.lang.SuppressWarnings("all")
        public static class ContentPolicyContextBuilder {
        @java.lang.SuppressWarnings("all")
                private String path;
        @java.lang.SuppressWarnings("all")
                private Long size;
        @java.lang.SuppressWarnings("all")
                private InputStream inputStream;
        @java.lang.SuppressWarnings("all")
                private String mimeType;
        @java.lang.SuppressWarnings("all")
                private String extension;

        @java.lang.SuppressWarnings("all")
                ContentPolicyContextBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ContentPolicyContext.ContentPolicyContextBuilder path(final String path) {
            this.path = path;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ContentPolicyContext.ContentPolicyContextBuilder size(final Long size) {
            this.size = size;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ContentPolicyContext.ContentPolicyContextBuilder inputStream(final InputStream inputStream) {
            this.inputStream = inputStream;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ContentPolicyContext.ContentPolicyContextBuilder mimeType(final String mimeType) {
            this.mimeType = mimeType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ContentPolicyContext.ContentPolicyContextBuilder extension(final String extension) {
            this.extension = extension;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ContentPolicyContext build() {
            return new ContentPolicyContext(this.path, this.size, this.inputStream, this.mimeType, this.extension);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ContentPolicyContext.ContentPolicyContextBuilder(path=" + this.path + ", size=" + this.size + ", inputStream=" + this.inputStream + ", mimeType=" + this.mimeType + ", extension=" + this.extension + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ContentPolicyContext.ContentPolicyContextBuilder builder() {
        return new ContentPolicyContext.ContentPolicyContextBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getPath() {
        return this.path;
    }

    @java.lang.SuppressWarnings("all")
        public Long getSize() {
        return this.size;
    }

    @java.lang.SuppressWarnings("all")
        public InputStream getInputStream() {
        return this.inputStream;
    }

    @java.lang.SuppressWarnings("all")
        public String getMimeType() {
        return this.mimeType;
    }

    @java.lang.SuppressWarnings("all")
        public String getExtension() {
        return this.extension;
    }

    @java.lang.SuppressWarnings("all")
        public void setPath(final String path) {
        this.path = path;
    }

    @java.lang.SuppressWarnings("all")
        public void setSize(final Long size) {
        this.size = size;
    }

    @java.lang.SuppressWarnings("all")
        public void setInputStream(final InputStream inputStream) {
        this.inputStream = inputStream;
    }

    @java.lang.SuppressWarnings("all")
        public void setMimeType(final String mimeType) {
        this.mimeType = mimeType;
    }

    @java.lang.SuppressWarnings("all")
        public void setExtension(final String extension) {
        this.extension = extension;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ContentPolicyContext)) return false;
        final ContentPolicyContext other = (ContentPolicyContext) o;
        final java.lang.Object this$size = this.getSize();
        final java.lang.Object other$size = other.getSize();
        if (this$size == null ? other$size != null : !this$size.equals(other$size)) return false;
        final java.lang.Object this$path = this.getPath();
        final java.lang.Object other$path = other.getPath();
        if (this$path == null ? other$path != null : !this$path.equals(other$path)) return false;
        final java.lang.Object this$inputStream = this.getInputStream();
        final java.lang.Object other$inputStream = other.getInputStream();
        if (this$inputStream == null ? other$inputStream != null : !this$inputStream.equals(other$inputStream)) return false;
        final java.lang.Object this$mimeType = this.getMimeType();
        final java.lang.Object other$mimeType = other.getMimeType();
        if (this$mimeType == null ? other$mimeType != null : !this$mimeType.equals(other$mimeType)) return false;
        final java.lang.Object this$extension = this.getExtension();
        final java.lang.Object other$extension = other.getExtension();
        if (this$extension == null ? other$extension != null : !this$extension.equals(other$extension)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $size = this.getSize();
        result = result * PRIME + ($size == null ? 43 : $size.hashCode());
        final java.lang.Object $path = this.getPath();
        result = result * PRIME + ($path == null ? 43 : $path.hashCode());
        final java.lang.Object $inputStream = this.getInputStream();
        result = result * PRIME + ($inputStream == null ? 43 : $inputStream.hashCode());
        final java.lang.Object $mimeType = this.getMimeType();
        result = result * PRIME + ($mimeType == null ? 43 : $mimeType.hashCode());
        final java.lang.Object $extension = this.getExtension();
        result = result * PRIME + ($extension == null ? 43 : $extension.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ContentPolicyContext(path=" + this.getPath() + ", size=" + this.getSize() + ", inputStream=" + this.getInputStream() + ", mimeType=" + this.getMimeType() + ", extension=" + this.getExtension() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ContentPolicyContext() {
    }

    @java.lang.SuppressWarnings("all")
        public ContentPolicyContext(final String path, final Long size, final InputStream inputStream, final String mimeType, final String extension) {
        this.path = path;
        this.size = size;
        this.inputStream = inputStream;
        this.mimeType = mimeType;
        this.extension = extension;
    }
}
