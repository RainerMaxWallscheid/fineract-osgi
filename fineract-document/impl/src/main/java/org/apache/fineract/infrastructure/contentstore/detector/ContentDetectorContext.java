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
package org.apache.fineract.infrastructure.contentstore.detector;

import java.io.InputStream;

public final class ContentDetectorContext {
    private InputStream inputStream;
    private boolean inputStreamEnabled;
    private String fileName;
    private String mimeType;
    private String extension;
    private String format;

    public ContentDetectorContext clone(String mimeType, String extension, String format) {
        return new ContentDetectorContext(this.inputStream, this.inputStreamEnabled, this.fileName, mimeType, extension, format);
    }

    public ContentDetectorContext clone(InputStream inputStream, String mimeType, String extension, String format) {
        return new ContentDetectorContext(inputStream, this.inputStreamEnabled, this.fileName, mimeType, extension, format);
    }

    @java.lang.SuppressWarnings("all")
        private static boolean $default$inputStreamEnabled() {
        return false;
    }


    @java.lang.SuppressWarnings("all")
        public static class ContentDetectorContextBuilder {
        @java.lang.SuppressWarnings("all")
                private InputStream inputStream;
        @java.lang.SuppressWarnings("all")
                private boolean inputStreamEnabled$set;
        @java.lang.SuppressWarnings("all")
                private boolean inputStreamEnabled$value;
        @java.lang.SuppressWarnings("all")
                private String fileName;
        @java.lang.SuppressWarnings("all")
                private String mimeType;
        @java.lang.SuppressWarnings("all")
                private String extension;
        @java.lang.SuppressWarnings("all")
                private String format;

        @java.lang.SuppressWarnings("all")
                ContentDetectorContextBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ContentDetectorContext.ContentDetectorContextBuilder inputStream(final InputStream inputStream) {
            this.inputStream = inputStream;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ContentDetectorContext.ContentDetectorContextBuilder inputStreamEnabled(final boolean inputStreamEnabled) {
            this.inputStreamEnabled$value = inputStreamEnabled;
            inputStreamEnabled$set = true;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ContentDetectorContext.ContentDetectorContextBuilder fileName(final String fileName) {
            this.fileName = fileName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ContentDetectorContext.ContentDetectorContextBuilder mimeType(final String mimeType) {
            this.mimeType = mimeType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ContentDetectorContext.ContentDetectorContextBuilder extension(final String extension) {
            this.extension = extension;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ContentDetectorContext.ContentDetectorContextBuilder format(final String format) {
            this.format = format;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ContentDetectorContext build() {
            boolean inputStreamEnabled$value = this.inputStreamEnabled$value;
            if (!this.inputStreamEnabled$set) inputStreamEnabled$value = ContentDetectorContext.$default$inputStreamEnabled();
            return new ContentDetectorContext(this.inputStream, inputStreamEnabled$value, this.fileName, this.mimeType, this.extension, this.format);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ContentDetectorContext.ContentDetectorContextBuilder(inputStream=" + this.inputStream + ", inputStreamEnabled$value=" + this.inputStreamEnabled$value + ", fileName=" + this.fileName + ", mimeType=" + this.mimeType + ", extension=" + this.extension + ", format=" + this.format + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ContentDetectorContext.ContentDetectorContextBuilder builder() {
        return new ContentDetectorContext.ContentDetectorContextBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public InputStream getInputStream() {
        return this.inputStream;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isInputStreamEnabled() {
        return this.inputStreamEnabled;
    }

    @java.lang.SuppressWarnings("all")
        public String getFileName() {
        return this.fileName;
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
        public String getFormat() {
        return this.format;
    }

    @java.lang.SuppressWarnings("all")
        public void setInputStream(final InputStream inputStream) {
        this.inputStream = inputStream;
    }

    @java.lang.SuppressWarnings("all")
        public void setInputStreamEnabled(final boolean inputStreamEnabled) {
        this.inputStreamEnabled = inputStreamEnabled;
    }

    @java.lang.SuppressWarnings("all")
        public void setFileName(final String fileName) {
        this.fileName = fileName;
    }

    @java.lang.SuppressWarnings("all")
        public void setMimeType(final String mimeType) {
        this.mimeType = mimeType;
    }

    @java.lang.SuppressWarnings("all")
        public void setExtension(final String extension) {
        this.extension = extension;
    }

    @java.lang.SuppressWarnings("all")
        public void setFormat(final String format) {
        this.format = format;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ContentDetectorContext)) return false;
        final ContentDetectorContext other = (ContentDetectorContext) o;
        if (this.isInputStreamEnabled() != other.isInputStreamEnabled()) return false;
        final java.lang.Object this$inputStream = this.getInputStream();
        final java.lang.Object other$inputStream = other.getInputStream();
        if (this$inputStream == null ? other$inputStream != null : !this$inputStream.equals(other$inputStream)) return false;
        final java.lang.Object this$fileName = this.getFileName();
        final java.lang.Object other$fileName = other.getFileName();
        if (this$fileName == null ? other$fileName != null : !this$fileName.equals(other$fileName)) return false;
        final java.lang.Object this$mimeType = this.getMimeType();
        final java.lang.Object other$mimeType = other.getMimeType();
        if (this$mimeType == null ? other$mimeType != null : !this$mimeType.equals(other$mimeType)) return false;
        final java.lang.Object this$extension = this.getExtension();
        final java.lang.Object other$extension = other.getExtension();
        if (this$extension == null ? other$extension != null : !this$extension.equals(other$extension)) return false;
        final java.lang.Object this$format = this.getFormat();
        final java.lang.Object other$format = other.getFormat();
        if (this$format == null ? other$format != null : !this$format.equals(other$format)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isInputStreamEnabled() ? 79 : 97);
        final java.lang.Object $inputStream = this.getInputStream();
        result = result * PRIME + ($inputStream == null ? 43 : $inputStream.hashCode());
        final java.lang.Object $fileName = this.getFileName();
        result = result * PRIME + ($fileName == null ? 43 : $fileName.hashCode());
        final java.lang.Object $mimeType = this.getMimeType();
        result = result * PRIME + ($mimeType == null ? 43 : $mimeType.hashCode());
        final java.lang.Object $extension = this.getExtension();
        result = result * PRIME + ($extension == null ? 43 : $extension.hashCode());
        final java.lang.Object $format = this.getFormat();
        result = result * PRIME + ($format == null ? 43 : $format.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ContentDetectorContext(inputStream=" + this.getInputStream() + ", inputStreamEnabled=" + this.isInputStreamEnabled() + ", fileName=" + this.getFileName() + ", mimeType=" + this.getMimeType() + ", extension=" + this.getExtension() + ", format=" + this.getFormat() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ContentDetectorContext() {
        this.inputStreamEnabled = ContentDetectorContext.$default$inputStreamEnabled();
    }

    @java.lang.SuppressWarnings("all")
        public ContentDetectorContext(final InputStream inputStream, final boolean inputStreamEnabled, final String fileName, final String mimeType, final String extension, final String format) {
        this.inputStream = inputStream;
        this.inputStreamEnabled = inputStreamEnabled;
        this.fileName = fileName;
        this.mimeType = mimeType;
        this.extension = extension;
        this.format = format;
    }
}
