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
 * Provides an object for separate HTTP responses in the Batch Response for Batch API. It contains all the information
 * about a particular HTTP response in the Batch Response. Getter and Setter functions are also included to access
 * response data fields.
 *
 * @author Rishabh Shukla
 *
 * @see org.apache.fineract.batch.api.BatchApiResource
 * @see org.apache.fineract.batch.service.BatchApiService
 * @see Header
 */
public class BatchResponse {
    private Long requestId;
    private Integer statusCode;
    private Set<Header> headers;
    private String body;

    @java.lang.SuppressWarnings("all")
        public BatchResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public Long getRequestId() {
        return this.requestId;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getStatusCode() {
        return this.statusCode;
    }

    @java.lang.SuppressWarnings("all")
        public Set<Header> getHeaders() {
        return this.headers;
    }

    @java.lang.SuppressWarnings("all")
        public String getBody() {
        return this.body;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public BatchResponse setRequestId(final Long requestId) {
        this.requestId = requestId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public BatchResponse setStatusCode(final Integer statusCode) {
        this.statusCode = statusCode;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public BatchResponse setHeaders(final Set<Header> headers) {
        this.headers = headers;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public BatchResponse setBody(final String body) {
        this.body = body;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof BatchResponse)) return false;
        final BatchResponse other = (BatchResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$requestId = this.getRequestId();
        final java.lang.Object other$requestId = other.getRequestId();
        if (this$requestId == null ? other$requestId != null : !this$requestId.equals(other$requestId)) return false;
        final java.lang.Object this$statusCode = this.getStatusCode();
        final java.lang.Object other$statusCode = other.getStatusCode();
        if (this$statusCode == null ? other$statusCode != null : !this$statusCode.equals(other$statusCode)) return false;
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
        return other instanceof BatchResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $requestId = this.getRequestId();
        result = result * PRIME + ($requestId == null ? 43 : $requestId.hashCode());
        final java.lang.Object $statusCode = this.getStatusCode();
        result = result * PRIME + ($statusCode == null ? 43 : $statusCode.hashCode());
        final java.lang.Object $headers = this.getHeaders();
        result = result * PRIME + ($headers == null ? 43 : $headers.hashCode());
        final java.lang.Object $body = this.getBody();
        result = result * PRIME + ($body == null ? 43 : $body.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "BatchResponse(requestId=" + this.getRequestId() + ", statusCode=" + this.getStatusCode() + ", headers=" + this.getHeaders() + ", body=" + this.getBody() + ")";
    }
}
