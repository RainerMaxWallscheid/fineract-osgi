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
package org.apache.fineract.command.test.sample.data;

import java.io.Serial;
import java.io.Serializable;

public class DummyErrorResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String content;
    private String error;


    @java.lang.SuppressWarnings("all")
        public static class DummyErrorResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private String content;
        @java.lang.SuppressWarnings("all")
                private String error;

        @java.lang.SuppressWarnings("all")
                DummyErrorResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DummyErrorResponse.DummyErrorResponseBuilder content(final String content) {
            this.content = content;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DummyErrorResponse.DummyErrorResponseBuilder error(final String error) {
            this.error = error;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public DummyErrorResponse build() {
            return new DummyErrorResponse(this.content, this.error);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "DummyErrorResponse.DummyErrorResponseBuilder(content=" + this.content + ", error=" + this.error + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static DummyErrorResponse.DummyErrorResponseBuilder builder() {
        return new DummyErrorResponse.DummyErrorResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getContent() {
        return this.content;
    }

    @java.lang.SuppressWarnings("all")
        public String getError() {
        return this.error;
    }

    @java.lang.SuppressWarnings("all")
        public void setContent(final String content) {
        this.content = content;
    }

    @java.lang.SuppressWarnings("all")
        public void setError(final String error) {
        this.error = error;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof DummyErrorResponse)) return false;
        final DummyErrorResponse other = (DummyErrorResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$content = this.getContent();
        final java.lang.Object other$content = other.getContent();
        if (this$content == null ? other$content != null : !this$content.equals(other$content)) return false;
        final java.lang.Object this$error = this.getError();
        final java.lang.Object other$error = other.getError();
        if (this$error == null ? other$error != null : !this$error.equals(other$error)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof DummyErrorResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $content = this.getContent();
        result = result * PRIME + ($content == null ? 43 : $content.hashCode());
        final java.lang.Object $error = this.getError();
        result = result * PRIME + ($error == null ? 43 : $error.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DummyErrorResponse(content=" + this.getContent() + ", error=" + this.getError() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public DummyErrorResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public DummyErrorResponse(final String content, final String error) {
        this.content = content;
        this.error = error;
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String content = "content";
        public static final java.lang.String error = "error";
    }
}
