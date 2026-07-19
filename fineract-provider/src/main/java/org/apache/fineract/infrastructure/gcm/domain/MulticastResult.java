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
package org.apache.fineract.infrastructure.gcm.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Result of a GCM multicast message request .
 */
public final class MulticastResult implements Serializable {
    private static final long serialVersionUID = 1L;
    private int success;
    private int failure;
    private int canonicalIds;
    private long multicastId;
    private List<Result> results;
    private List<Long> retryMulticastIds;


    public static final class Builder {
        private final List<Result> results = new ArrayList<>();
        // required parameters
        private final int success;
        private final int failure;
        private final int canonicalIds;
        private final long multicastId;
        // optional parameters
        private List<Long> retryMulticastIds;

        public Builder(int success, int failure, int canonicalIds, long multicastId) {
            this.success = success;
            this.failure = failure;
            this.canonicalIds = canonicalIds;
            this.multicastId = multicastId;
        }

        public Builder addResult(Result result) {
            results.add(result);
            return this;
        }

        public Builder retryMulticastIds(List<Long> retryMulticastIds) {
            this.retryMulticastIds = retryMulticastIds;
            return this;
        }

        public MulticastResult build() {
            return new MulticastResult(this);
        }
    }

    private MulticastResult(Builder builder) {
        success = builder.success;
        failure = builder.failure;
        canonicalIds = builder.canonicalIds;
        multicastId = builder.multicastId;
        results = Collections.unmodifiableList(builder.results);
        List<Long> tmpList = builder.retryMulticastIds;
        if (tmpList == null) {
            tmpList = Collections.emptyList();
        }
        retryMulticastIds = Collections.unmodifiableList(tmpList);
    }

    @java.lang.SuppressWarnings("all")
        public int getSuccess() {
        return this.success;
    }

    @java.lang.SuppressWarnings("all")
        public int getFailure() {
        return this.failure;
    }

    @java.lang.SuppressWarnings("all")
        public int getCanonicalIds() {
        return this.canonicalIds;
    }

    @java.lang.SuppressWarnings("all")
        public long getMulticastId() {
        return this.multicastId;
    }

    @java.lang.SuppressWarnings("all")
        public List<Result> getResults() {
        return this.results;
    }

    @java.lang.SuppressWarnings("all")
        public List<Long> getRetryMulticastIds() {
        return this.retryMulticastIds;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MulticastResult setSuccess(final int success) {
        this.success = success;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MulticastResult setFailure(final int failure) {
        this.failure = failure;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MulticastResult setCanonicalIds(final int canonicalIds) {
        this.canonicalIds = canonicalIds;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MulticastResult setMulticastId(final long multicastId) {
        this.multicastId = multicastId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MulticastResult setResults(final List<Result> results) {
        this.results = results;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MulticastResult setRetryMulticastIds(final List<Long> retryMulticastIds) {
        this.retryMulticastIds = retryMulticastIds;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof MulticastResult)) return false;
        final MulticastResult other = (MulticastResult) o;
        if (this.getSuccess() != other.getSuccess()) return false;
        if (this.getFailure() != other.getFailure()) return false;
        if (this.getCanonicalIds() != other.getCanonicalIds()) return false;
        if (this.getMulticastId() != other.getMulticastId()) return false;
        final java.lang.Object this$results = this.getResults();
        final java.lang.Object other$results = other.getResults();
        if (this$results == null ? other$results != null : !this$results.equals(other$results)) return false;
        final java.lang.Object this$retryMulticastIds = this.getRetryMulticastIds();
        final java.lang.Object other$retryMulticastIds = other.getRetryMulticastIds();
        if (this$retryMulticastIds == null ? other$retryMulticastIds != null : !this$retryMulticastIds.equals(other$retryMulticastIds)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + this.getSuccess();
        result = result * PRIME + this.getFailure();
        result = result * PRIME + this.getCanonicalIds();
        final long $multicastId = this.getMulticastId();
        result = result * PRIME + (int) ($multicastId >>> 32 ^ $multicastId);
        final java.lang.Object $results = this.getResults();
        result = result * PRIME + ($results == null ? 43 : $results.hashCode());
        final java.lang.Object $retryMulticastIds = this.getRetryMulticastIds();
        result = result * PRIME + ($retryMulticastIds == null ? 43 : $retryMulticastIds.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "MulticastResult(success=" + this.getSuccess() + ", failure=" + this.getFailure() + ", canonicalIds=" + this.getCanonicalIds() + ", multicastId=" + this.getMulticastId() + ", results=" + this.getResults() + ", retryMulticastIds=" + this.getRetryMulticastIds() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public MulticastResult() {
    }
}
