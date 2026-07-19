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
package org.apache.fineract.util;

import jakarta.ws.rs.container.AsyncResponse;
import jakarta.ws.rs.core.HttpHeaders;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.StreamingOutput;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import org.apache.commons.lang3.StringUtils;

public final class StreamResponseUtil {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(StreamResponseUtil.class);
    public static String DISPOSITION_TYPE_ATTACHMENT = "attachment";
    public static String DISPOSITION_TYPE_INLINE = "inline";
    private static final ExecutorService executor = Executors.newCachedThreadPool();

    private StreamResponseUtil() {
    }

    public static Response ok(final StreamResponseData content) {
        final var stream = new StreamingOutput() {
            @Override
            public void write(OutputStream out) throws IOException {
                content.getStream().transferTo(out);
            }
        };
        if (StringUtils.isEmpty(content.getDispositionType())) {
            return Response.ok(stream, content.getType()).build();
        } else {
            return Response.ok(stream, content.getType()).header(HttpHeaders.CONTENT_DISPOSITION, String.format("%s; filename=\"%s\"", content.getDispositionType(), content.getFileName())).build();
        }
    }

    public static Future<?> ok(final AsyncResponse asyncResponse, final StreamResponseData content) {
        return executor.submit(() -> {
            if (StringUtils.isEmpty(content.getDispositionType())) {
                asyncResponse.resume(Response.ok(content.getStream(), content.getType()).build());
            } else {
                asyncResponse.resume(Response.ok(content.getStream(), content.getType()).header(HttpHeaders.CONTENT_DISPOSITION, String.format("%s; filename=\"%s\"", content.getDispositionType(), content.getFileName())).build());
            }
        });
    }


    public static final class StreamResponseData {
        private InputStream stream;
        private String type;
        private String fileName;
        private String dispositionType;
        private Long size;


        @java.lang.SuppressWarnings("all")
                public static class StreamResponseDataBuilder {
            @java.lang.SuppressWarnings("all")
                        private InputStream stream;
            @java.lang.SuppressWarnings("all")
                        private String type;
            @java.lang.SuppressWarnings("all")
                        private String fileName;
            @java.lang.SuppressWarnings("all")
                        private String dispositionType;
            @java.lang.SuppressWarnings("all")
                        private Long size;

            @java.lang.SuppressWarnings("all")
                        StreamResponseDataBuilder() {
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public StreamResponseUtil.StreamResponseData.StreamResponseDataBuilder stream(final InputStream stream) {
                this.stream = stream;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public StreamResponseUtil.StreamResponseData.StreamResponseDataBuilder type(final String type) {
                this.type = type;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public StreamResponseUtil.StreamResponseData.StreamResponseDataBuilder fileName(final String fileName) {
                this.fileName = fileName;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public StreamResponseUtil.StreamResponseData.StreamResponseDataBuilder dispositionType(final String dispositionType) {
                this.dispositionType = dispositionType;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public StreamResponseUtil.StreamResponseData.StreamResponseDataBuilder size(final Long size) {
                this.size = size;
                return this;
            }

            @java.lang.SuppressWarnings("all")
                        public StreamResponseUtil.StreamResponseData build() {
                return new StreamResponseUtil.StreamResponseData(this.stream, this.type, this.fileName, this.dispositionType, this.size);
            }

            @java.lang.Override
            @java.lang.SuppressWarnings("all")
                        public java.lang.String toString() {
                return "StreamResponseUtil.StreamResponseData.StreamResponseDataBuilder(stream=" + this.stream + ", type=" + this.type + ", fileName=" + this.fileName + ", dispositionType=" + this.dispositionType + ", size=" + this.size + ")";
            }
        }

        @java.lang.SuppressWarnings("all")
                public static StreamResponseUtil.StreamResponseData.StreamResponseDataBuilder builder() {
            return new StreamResponseUtil.StreamResponseData.StreamResponseDataBuilder();
        }

        @java.lang.SuppressWarnings("all")
                public InputStream getStream() {
            return this.stream;
        }

        @java.lang.SuppressWarnings("all")
                public String getType() {
            return this.type;
        }

        @java.lang.SuppressWarnings("all")
                public String getFileName() {
            return this.fileName;
        }

        @java.lang.SuppressWarnings("all")
                public String getDispositionType() {
            return this.dispositionType;
        }

        @java.lang.SuppressWarnings("all")
                public Long getSize() {
            return this.size;
        }

        @java.lang.SuppressWarnings("all")
                public void setStream(final InputStream stream) {
            this.stream = stream;
        }

        @java.lang.SuppressWarnings("all")
                public void setType(final String type) {
            this.type = type;
        }

        @java.lang.SuppressWarnings("all")
                public void setFileName(final String fileName) {
            this.fileName = fileName;
        }

        @java.lang.SuppressWarnings("all")
                public void setDispositionType(final String dispositionType) {
            this.dispositionType = dispositionType;
        }

        @java.lang.SuppressWarnings("all")
                public void setSize(final Long size) {
            this.size = size;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public boolean equals(final java.lang.Object o) {
            if (o == this) return true;
            if (!(o instanceof StreamResponseUtil.StreamResponseData)) return false;
            final StreamResponseUtil.StreamResponseData other = (StreamResponseUtil.StreamResponseData) o;
            final java.lang.Object this$size = this.getSize();
            final java.lang.Object other$size = other.getSize();
            if (this$size == null ? other$size != null : !this$size.equals(other$size)) return false;
            final java.lang.Object this$stream = this.getStream();
            final java.lang.Object other$stream = other.getStream();
            if (this$stream == null ? other$stream != null : !this$stream.equals(other$stream)) return false;
            final java.lang.Object this$type = this.getType();
            final java.lang.Object other$type = other.getType();
            if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
            final java.lang.Object this$fileName = this.getFileName();
            final java.lang.Object other$fileName = other.getFileName();
            if (this$fileName == null ? other$fileName != null : !this$fileName.equals(other$fileName)) return false;
            final java.lang.Object this$dispositionType = this.getDispositionType();
            final java.lang.Object other$dispositionType = other.getDispositionType();
            if (this$dispositionType == null ? other$dispositionType != null : !this$dispositionType.equals(other$dispositionType)) return false;
            return true;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public int hashCode() {
            final int PRIME = 59;
            int result = 1;
            final java.lang.Object $size = this.getSize();
            result = result * PRIME + ($size == null ? 43 : $size.hashCode());
            final java.lang.Object $stream = this.getStream();
            result = result * PRIME + ($stream == null ? 43 : $stream.hashCode());
            final java.lang.Object $type = this.getType();
            result = result * PRIME + ($type == null ? 43 : $type.hashCode());
            final java.lang.Object $fileName = this.getFileName();
            result = result * PRIME + ($fileName == null ? 43 : $fileName.hashCode());
            final java.lang.Object $dispositionType = this.getDispositionType();
            result = result * PRIME + ($dispositionType == null ? 43 : $dispositionType.hashCode());
            return result;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "StreamResponseUtil.StreamResponseData(stream=" + this.getStream() + ", type=" + this.getType() + ", fileName=" + this.getFileName() + ", dispositionType=" + this.getDispositionType() + ", size=" + this.getSize() + ")";
        }

        @java.lang.SuppressWarnings("all")
                public StreamResponseData() {
        }

        @java.lang.SuppressWarnings("all")
                public StreamResponseData(final InputStream stream, final String type, final String fileName, final String dispositionType, final Long size) {
            this.stream = stream;
            this.type = type;
            this.fileName = fileName;
            this.dispositionType = dispositionType;
            this.size = size;
        }
    }
}
