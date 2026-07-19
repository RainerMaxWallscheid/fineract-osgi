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
import java.util.List;

/**
 * Result of a GCM message request that returned HTTP status code 200.
 *
 * <p>
 * If the message is successfully created, the {@link #getMessageId()} returns the message id and
 * {@link #getErrorCode()} returns {@literal null}; otherwise, {@link #getMessageId()} returns {@literal null} and
 * {@link #getErrorCode()} returns the code of the error.
 *
 * <p>
 * There are cases when a request is accept and the message successfully created, but GCM has a canonical registration
 * id for that device. In this case, the server should update the registration id to avoid rejected requests in the
 * future.
 *
 * <p>
 * In a nutshell, the workflow to handle a result is:
 *
 * <pre>
 *   - Call {@link #getMessageId()}:
 *     - {@literal null} means error, call {@link #getErrorCode()}
 *     - non-{@literal null} means the message was created:
 *       - Call {@link #getCanonicalRegistrationId()}
 *         - if it returns {@literal null}, do nothing.
 *         - otherwise, update the server datastore with the new id.
 * </pre>
 */
public final class Result implements Serializable {
    private static final long serialVersionUID = 1L;
    private String messageId;
    private String canonicalRegistrationId;
    private String errorCode;
    private Integer success;
    private Integer failure;
    private List<String> failedRegistrationIds;
    private int status;


    public static final class Builder {
        // optional parameters
        private String messageId;
        private String canonicalRegistrationId;
        private String errorCode;
        private Integer success;
        private Integer failure;
        private List<String> failedRegistrationIds;
        private int status;

        public Builder canonicalRegistrationId(String value) {
            canonicalRegistrationId = value;
            return this;
        }

        public Builder messageId(String value) {
            messageId = value;
            return this;
        }

        public Builder errorCode(String value) {
            errorCode = value;
            return this;
        }

        public Builder success(Integer value) {
            success = value;
            return this;
        }

        public Builder failure(Integer value) {
            failure = value;
            return this;
        }

        public Builder status(int value) {
            status = value;
            return this;
        }

        public Builder failedRegistrationIds(List<String> value) {
            failedRegistrationIds = value;
            return this;
        }

        public Result build() {
            return new Result(this);
        }
    }

    private Result(Builder builder) {
        canonicalRegistrationId = builder.canonicalRegistrationId;
        messageId = builder.messageId;
        errorCode = builder.errorCode;
        success = builder.success;
        failure = builder.failure;
        failedRegistrationIds = builder.failedRegistrationIds;
        status = builder.status;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder("[");
        if (messageId != null) {
            builder.append(" messageId=").append(messageId);
        }
        if (canonicalRegistrationId != null) {
            builder.append(" canonicalRegistrationId=").append(canonicalRegistrationId);
        }
        if (errorCode != null) {
            builder.append(" errorCode=").append(errorCode);
        }
        if (success != null) {
            builder.append(" groupSuccess=").append(success);
        }
        if (failure != null) {
            builder.append(" groupFailure=").append(failure);
        }
        if (failedRegistrationIds != null) {
            builder.append(" failedRegistrationIds=").append(failedRegistrationIds);
        }
        return builder.append(" ]").toString();
    }

    @java.lang.SuppressWarnings("all")
        public String getMessageId() {
        return this.messageId;
    }

    @java.lang.SuppressWarnings("all")
        public String getCanonicalRegistrationId() {
        return this.canonicalRegistrationId;
    }

    @java.lang.SuppressWarnings("all")
        public String getErrorCode() {
        return this.errorCode;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getSuccess() {
        return this.success;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getFailure() {
        return this.failure;
    }

    @java.lang.SuppressWarnings("all")
        public List<String> getFailedRegistrationIds() {
        return this.failedRegistrationIds;
    }

    @java.lang.SuppressWarnings("all")
        public int getStatus() {
        return this.status;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Result setMessageId(final String messageId) {
        this.messageId = messageId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Result setCanonicalRegistrationId(final String canonicalRegistrationId) {
        this.canonicalRegistrationId = canonicalRegistrationId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Result setErrorCode(final String errorCode) {
        this.errorCode = errorCode;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Result setSuccess(final Integer success) {
        this.success = success;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Result setFailure(final Integer failure) {
        this.failure = failure;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Result setFailedRegistrationIds(final List<String> failedRegistrationIds) {
        this.failedRegistrationIds = failedRegistrationIds;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Result setStatus(final int status) {
        this.status = status;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof Result)) return false;
        final Result other = (Result) o;
        if (this.getStatus() != other.getStatus()) return false;
        final java.lang.Object this$success = this.getSuccess();
        final java.lang.Object other$success = other.getSuccess();
        if (this$success == null ? other$success != null : !this$success.equals(other$success)) return false;
        final java.lang.Object this$failure = this.getFailure();
        final java.lang.Object other$failure = other.getFailure();
        if (this$failure == null ? other$failure != null : !this$failure.equals(other$failure)) return false;
        final java.lang.Object this$messageId = this.getMessageId();
        final java.lang.Object other$messageId = other.getMessageId();
        if (this$messageId == null ? other$messageId != null : !this$messageId.equals(other$messageId)) return false;
        final java.lang.Object this$canonicalRegistrationId = this.getCanonicalRegistrationId();
        final java.lang.Object other$canonicalRegistrationId = other.getCanonicalRegistrationId();
        if (this$canonicalRegistrationId == null ? other$canonicalRegistrationId != null : !this$canonicalRegistrationId.equals(other$canonicalRegistrationId)) return false;
        final java.lang.Object this$errorCode = this.getErrorCode();
        final java.lang.Object other$errorCode = other.getErrorCode();
        if (this$errorCode == null ? other$errorCode != null : !this$errorCode.equals(other$errorCode)) return false;
        final java.lang.Object this$failedRegistrationIds = this.getFailedRegistrationIds();
        final java.lang.Object other$failedRegistrationIds = other.getFailedRegistrationIds();
        if (this$failedRegistrationIds == null ? other$failedRegistrationIds != null : !this$failedRegistrationIds.equals(other$failedRegistrationIds)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + this.getStatus();
        final java.lang.Object $success = this.getSuccess();
        result = result * PRIME + ($success == null ? 43 : $success.hashCode());
        final java.lang.Object $failure = this.getFailure();
        result = result * PRIME + ($failure == null ? 43 : $failure.hashCode());
        final java.lang.Object $messageId = this.getMessageId();
        result = result * PRIME + ($messageId == null ? 43 : $messageId.hashCode());
        final java.lang.Object $canonicalRegistrationId = this.getCanonicalRegistrationId();
        result = result * PRIME + ($canonicalRegistrationId == null ? 43 : $canonicalRegistrationId.hashCode());
        final java.lang.Object $errorCode = this.getErrorCode();
        result = result * PRIME + ($errorCode == null ? 43 : $errorCode.hashCode());
        final java.lang.Object $failedRegistrationIds = this.getFailedRegistrationIds();
        result = result * PRIME + ($failedRegistrationIds == null ? 43 : $failedRegistrationIds.hashCode());
        return result;
    }

    @java.lang.SuppressWarnings("all")
        public Result() {
    }
}
