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

import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.v3.oas.annotations.Hidden;
import java.io.InputStream;
import java.io.Serial;
import java.io.Serializable;

public class DocumentContent implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String displayName;
    private String fileName;
    private String contentType;
    private String format;
    private Long size;
    @Hidden
    @JsonIgnore
    private InputStream stream;


    @java.lang.SuppressWarnings("all")
        public static class DocumentContentBuilder {
        @java.lang.SuppressWarnings("all")
                private String displayName;
        @java.lang.SuppressWarnings("all")
                private String fileName;
        @java.lang.SuppressWarnings("all")
                private String contentType;
        @java.lang.SuppressWarnings("all")
                private String format;
        @java.lang.SuppressWarnings("all")
                private Long size;
        @java.lang.SuppressWarnings("all")
                private InputStream stream;

        @java.lang.SuppressWarnings("all")
                DocumentContentBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentContent.DocumentContentBuilder displayName(final String displayName) {
            this.displayName = displayName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentContent.DocumentContentBuilder fileName(final String fileName) {
            this.fileName = fileName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentContent.DocumentContentBuilder contentType(final String contentType) {
            this.contentType = contentType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentContent.DocumentContentBuilder format(final String format) {
            this.format = format;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DocumentContent.DocumentContentBuilder size(final Long size) {
            this.size = size;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @JsonIgnore
        @java.lang.SuppressWarnings("all")
                public DocumentContent.DocumentContentBuilder stream(final InputStream stream) {
            this.stream = stream;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public DocumentContent build() {
            return new DocumentContent(this.displayName, this.fileName, this.contentType, this.format, this.size, this.stream);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "DocumentContent.DocumentContentBuilder(displayName=" + this.displayName + ", fileName=" + this.fileName + ", contentType=" + this.contentType + ", format=" + this.format + ", size=" + this.size + ", stream=" + this.stream + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static DocumentContent.DocumentContentBuilder builder() {
        return new DocumentContent.DocumentContentBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getDisplayName() {
        return this.displayName;
    }

    @java.lang.SuppressWarnings("all")
        public String getFileName() {
        return this.fileName;
    }

    @java.lang.SuppressWarnings("all")
        public String getContentType() {
        return this.contentType;
    }

    @java.lang.SuppressWarnings("all")
        public String getFormat() {
        return this.format;
    }

    @java.lang.SuppressWarnings("all")
        public Long getSize() {
        return this.size;
    }

    @java.lang.SuppressWarnings("all")
        public InputStream getStream() {
        return this.stream;
    }

    @java.lang.SuppressWarnings("all")
        public void setDisplayName(final String displayName) {
        this.displayName = displayName;
    }

    @java.lang.SuppressWarnings("all")
        public void setFileName(final String fileName) {
        this.fileName = fileName;
    }

    @java.lang.SuppressWarnings("all")
        public void setContentType(final String contentType) {
        this.contentType = contentType;
    }

    @java.lang.SuppressWarnings("all")
        public void setFormat(final String format) {
        this.format = format;
    }

    @java.lang.SuppressWarnings("all")
        public void setSize(final Long size) {
        this.size = size;
    }

    @java.lang.SuppressWarnings("all")
        public void setStream(final InputStream stream) {
        this.stream = stream;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof DocumentContent)) return false;
        final DocumentContent other = (DocumentContent) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$size = this.getSize();
        final java.lang.Object other$size = other.getSize();
        if (this$size == null ? other$size != null : !this$size.equals(other$size)) return false;
        final java.lang.Object this$displayName = this.getDisplayName();
        final java.lang.Object other$displayName = other.getDisplayName();
        if (this$displayName == null ? other$displayName != null : !this$displayName.equals(other$displayName)) return false;
        final java.lang.Object this$fileName = this.getFileName();
        final java.lang.Object other$fileName = other.getFileName();
        if (this$fileName == null ? other$fileName != null : !this$fileName.equals(other$fileName)) return false;
        final java.lang.Object this$contentType = this.getContentType();
        final java.lang.Object other$contentType = other.getContentType();
        if (this$contentType == null ? other$contentType != null : !this$contentType.equals(other$contentType)) return false;
        final java.lang.Object this$format = this.getFormat();
        final java.lang.Object other$format = other.getFormat();
        if (this$format == null ? other$format != null : !this$format.equals(other$format)) return false;
        final java.lang.Object this$stream = this.getStream();
        final java.lang.Object other$stream = other.getStream();
        if (this$stream == null ? other$stream != null : !this$stream.equals(other$stream)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof DocumentContent;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $size = this.getSize();
        result = result * PRIME + ($size == null ? 43 : $size.hashCode());
        final java.lang.Object $displayName = this.getDisplayName();
        result = result * PRIME + ($displayName == null ? 43 : $displayName.hashCode());
        final java.lang.Object $fileName = this.getFileName();
        result = result * PRIME + ($fileName == null ? 43 : $fileName.hashCode());
        final java.lang.Object $contentType = this.getContentType();
        result = result * PRIME + ($contentType == null ? 43 : $contentType.hashCode());
        final java.lang.Object $format = this.getFormat();
        result = result * PRIME + ($format == null ? 43 : $format.hashCode());
        final java.lang.Object $stream = this.getStream();
        result = result * PRIME + ($stream == null ? 43 : $stream.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DocumentContent(displayName=" + this.getDisplayName() + ", fileName=" + this.getFileName() + ", contentType=" + this.getContentType() + ", format=" + this.getFormat() + ", size=" + this.getSize() + ", stream=" + this.getStream() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public DocumentContent() {
    }

    @java.lang.SuppressWarnings("all")
        public DocumentContent(final String displayName, final String fileName, final String contentType, final String format, final Long size, final InputStream stream) {
        this.displayName = displayName;
        this.fileName = fileName;
        this.contentType = contentType;
        this.format = format;
        this.size = size;
        this.stream = stream;
    }
}
