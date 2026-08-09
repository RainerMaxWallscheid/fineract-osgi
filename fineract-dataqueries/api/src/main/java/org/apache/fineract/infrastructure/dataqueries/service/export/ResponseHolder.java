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
package org.apache.fineract.infrastructure.dataqueries.service.export;

import jakarta.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;

public class ResponseHolder {
    private String contentType;
    private String fileName;
    private final Response.Status status;
    private Object entity;
    private List<Header> headers = new ArrayList<>();

    public ResponseHolder addHeader(String key, String value) {
        headers.add(new Header(key, value));
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public String contentType() {
        return this.contentType;
    }

    @java.lang.SuppressWarnings("all")
        public String fileName() {
        return this.fileName;
    }

    @java.lang.SuppressWarnings("all")
        public Response.Status status() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public Object entity() {
        return this.entity;
    }

    @java.lang.SuppressWarnings("all")
        public List<Header> headers() {
        return this.headers;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ResponseHolder contentType(final String contentType) {
        this.contentType = contentType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ResponseHolder fileName(final String fileName) {
        this.fileName = fileName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ResponseHolder entity(final Object entity) {
        this.entity = entity;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ResponseHolder headers(final List<Header> headers) {
        this.headers = headers;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ResponseHolder)) return false;
        final ResponseHolder other = (ResponseHolder) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$contentType = this.contentType();
        final java.lang.Object other$contentType = other.contentType();
        if (this$contentType == null ? other$contentType != null : !this$contentType.equals(other$contentType)) return false;
        final java.lang.Object this$fileName = this.fileName();
        final java.lang.Object other$fileName = other.fileName();
        if (this$fileName == null ? other$fileName != null : !this$fileName.equals(other$fileName)) return false;
        final java.lang.Object this$status = this.status();
        final java.lang.Object other$status = other.status();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        final java.lang.Object this$entity = this.entity();
        final java.lang.Object other$entity = other.entity();
        if (this$entity == null ? other$entity != null : !this$entity.equals(other$entity)) return false;
        final java.lang.Object this$headers = this.headers();
        final java.lang.Object other$headers = other.headers();
        if (this$headers == null ? other$headers != null : !this$headers.equals(other$headers)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ResponseHolder;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $contentType = this.contentType();
        result = result * PRIME + ($contentType == null ? 43 : $contentType.hashCode());
        final java.lang.Object $fileName = this.fileName();
        result = result * PRIME + ($fileName == null ? 43 : $fileName.hashCode());
        final java.lang.Object $status = this.status();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        final java.lang.Object $entity = this.entity();
        result = result * PRIME + ($entity == null ? 43 : $entity.hashCode());
        final java.lang.Object $headers = this.headers();
        result = result * PRIME + ($headers == null ? 43 : $headers.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ResponseHolder(contentType=" + this.contentType() + ", fileName=" + this.fileName() + ", status=" + this.status() + ", entity=" + this.entity() + ", headers=" + this.headers() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ResponseHolder(final Response.Status status) {
        this.status = status;
    }
}
