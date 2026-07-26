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

import jakarta.validation.constraints.NotBlank;
import java.io.Serial;
import java.io.Serializable;

public class DummyErrorRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @NotBlank(message = "{org.apache.fineract.dummy.request.content.not-empty}")
    private String content;


    @java.lang.SuppressWarnings("all")
        public static class DummyErrorRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private String content;

        @java.lang.SuppressWarnings("all")
                DummyErrorRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DummyErrorRequest.DummyErrorRequestBuilder content(final String content) {
            this.content = content;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public DummyErrorRequest build() {
            return new DummyErrorRequest(this.content);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "DummyErrorRequest.DummyErrorRequestBuilder(content=" + this.content + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static DummyErrorRequest.DummyErrorRequestBuilder builder() {
        return new DummyErrorRequest.DummyErrorRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getContent() {
        return this.content;
    }

    @java.lang.SuppressWarnings("all")
        public void setContent(final String content) {
        this.content = content;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof DummyErrorRequest)) return false;
        final DummyErrorRequest other = (DummyErrorRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$content = this.getContent();
        final java.lang.Object other$content = other.getContent();
        if (this$content == null ? other$content != null : !this$content.equals(other$content)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof DummyErrorRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $content = this.getContent();
        result = result * PRIME + ($content == null ? 43 : $content.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DummyErrorRequest(content=" + this.getContent() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public DummyErrorRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public DummyErrorRequest(final String content) {
        this.content = content;
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String content = "content";
    }
}
