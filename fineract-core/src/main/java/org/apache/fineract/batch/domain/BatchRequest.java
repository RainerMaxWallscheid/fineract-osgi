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
package org.apache.fineract.batch.domain;

import java.util.Set;

/**
 * Provides an object for separate HTTP requests in the Batch Request for Batch API. A requestId is also included as
 * data field which takes care of dependency issues among various requests. This class also provides getter and setter
 * functions to access Batch Request data fields.
 *
 * @author Rishabh Shukla
 *
 * @see org.apache.fineract.batch.api.BatchApiResource
 * @see Header
 */
public class BatchRequest {
    private Long requestId;
    private String relativeUrl;
    private String method;
    private Set<Header> headers;
    private Long reference;
    private String body;

    @java.lang.SuppressWarnings("all")
        public BatchRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public Long getRequestId() {
        return this.requestId;
    }

    @java.lang.SuppressWarnings("all")
        public String getRelativeUrl() {
        return this.relativeUrl;
    }

    @java.lang.SuppressWarnings("all")
        public String getMethod() {
        return this.method;
    }

    @java.lang.SuppressWarnings("all")
        public Set<Header> getHeaders() {
        return this.headers;
    }

    @java.lang.SuppressWarnings("all")
        public Long getReference() {
        return this.reference;
    }

    @java.lang.SuppressWarnings("all")
        public String getBody() {
        return this.body;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public BatchRequest setRequestId(final Long requestId) {
        this.requestId = requestId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public BatchRequest setRelativeUrl(final String relativeUrl) {
        this.relativeUrl = relativeUrl;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public BatchRequest setMethod(final String method) {
        this.method = method;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public BatchRequest setHeaders(final Set<Header> headers) {
        this.headers = headers;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public BatchRequest setReference(final Long reference) {
        this.reference = reference;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public BatchRequest setBody(final String body) {
        this.body = body;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof BatchRequest)) return false;
        final BatchRequest other = (BatchRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$requestId = this.getRequestId();
        final java.lang.Object other$requestId = other.getRequestId();
        if (this$requestId == null ? other$requestId != null : !this$requestId.equals(other$requestId)) return false;
        final java.lang.Object this$reference = this.getReference();
        final java.lang.Object other$reference = other.getReference();
        if (this$reference == null ? other$reference != null : !this$reference.equals(other$reference)) return false;
        final java.lang.Object this$relativeUrl = this.getRelativeUrl();
        final java.lang.Object other$relativeUrl = other.getRelativeUrl();
        if (this$relativeUrl == null ? other$relativeUrl != null : !this$relativeUrl.equals(other$relativeUrl)) return false;
        final java.lang.Object this$method = this.getMethod();
        final java.lang.Object other$method = other.getMethod();
        if (this$method == null ? other$method != null : !this$method.equals(other$method)) return false;
        final java.lang.Object this$headers = this.getHeaders();
        final java.lang.Object other$headers = other.getHeaders();
        if (this$headers == null ? other$headers != null : !this$headers.equals(other$headers)) return false;
        final java.lang.Object this$body = this.getBody();
        final java.lang.Object other$body = other.getBody();
        if (this$body == null ? other$body != null : !this$body.equals(other$body)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof BatchRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $requestId = this.getRequestId();
        result = result * PRIME + ($requestId == null ? 43 : $requestId.hashCode());
        final java.lang.Object $reference = this.getReference();
        result = result * PRIME + ($reference == null ? 43 : $reference.hashCode());
        final java.lang.Object $relativeUrl = this.getRelativeUrl();
        result = result * PRIME + ($relativeUrl == null ? 43 : $relativeUrl.hashCode());
        final java.lang.Object $method = this.getMethod();
        result = result * PRIME + ($method == null ? 43 : $method.hashCode());
        final java.lang.Object $headers = this.getHeaders();
        result = result * PRIME + ($headers == null ? 43 : $headers.hashCode());
        final java.lang.Object $body = this.getBody();
        result = result * PRIME + ($body == null ? 43 : $body.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "BatchRequest(requestId=" + this.getRequestId() + ", relativeUrl=" + this.getRelativeUrl() + ", method=" + this.getMethod() + ", headers=" + this.getHeaders() + ", reference=" + this.getReference() + ", body=" + this.getBody() + ")";
    }
}
