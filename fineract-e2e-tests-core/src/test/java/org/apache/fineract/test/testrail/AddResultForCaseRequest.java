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
package org.apache.fineract.test.testrail;

import com.google.gson.annotations.SerializedName;

class AddResultForCaseRequest {
    @SerializedName("status_id")
    private TestRailStatus statusId;
    private String comment;


    @java.lang.SuppressWarnings("all")
        public static class AddResultForCaseRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private TestRailStatus statusId;
        @java.lang.SuppressWarnings("all")
                private String comment;

        @java.lang.SuppressWarnings("all")
                AddResultForCaseRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AddResultForCaseRequest.AddResultForCaseRequestBuilder statusId(final TestRailStatus statusId) {
            this.statusId = statusId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public AddResultForCaseRequest.AddResultForCaseRequestBuilder comment(final String comment) {
            this.comment = comment;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public AddResultForCaseRequest build() {
            return new AddResultForCaseRequest(this.statusId, this.comment);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "AddResultForCaseRequest.AddResultForCaseRequestBuilder(statusId=" + this.statusId + ", comment=" + this.comment + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static AddResultForCaseRequest.AddResultForCaseRequestBuilder builder() {
        return new AddResultForCaseRequest.AddResultForCaseRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public TestRailStatus getStatusId() {
        return this.statusId;
    }

    @java.lang.SuppressWarnings("all")
        public String getComment() {
        return this.comment;
    }

    @java.lang.SuppressWarnings("all")
        public void setStatusId(final TestRailStatus statusId) {
        this.statusId = statusId;
    }

    @java.lang.SuppressWarnings("all")
        public void setComment(final String comment) {
        this.comment = comment;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AddResultForCaseRequest)) return false;
        final AddResultForCaseRequest other = (AddResultForCaseRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$statusId = this.getStatusId();
        final java.lang.Object other$statusId = other.getStatusId();
        if (this$statusId == null ? other$statusId != null : !this$statusId.equals(other$statusId)) return false;
        final java.lang.Object this$comment = this.getComment();
        final java.lang.Object other$comment = other.getComment();
        if (this$comment == null ? other$comment != null : !this$comment.equals(other$comment)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AddResultForCaseRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $statusId = this.getStatusId();
        result = result * PRIME + ($statusId == null ? 43 : $statusId.hashCode());
        final java.lang.Object $comment = this.getComment();
        result = result * PRIME + ($comment == null ? 43 : $comment.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AddResultForCaseRequest(statusId=" + this.getStatusId() + ", comment=" + this.getComment() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AddResultForCaseRequest(final TestRailStatus statusId, final String comment) {
        this.statusId = statusId;
        this.comment = comment;
    }

    @java.lang.SuppressWarnings("all")
        public AddResultForCaseRequest() {
    }
}
