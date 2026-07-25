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

public class DummyResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long commandId;
    private String content;
    private String error;


    @java.lang.SuppressWarnings("all")
        public static class DummyResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private Long commandId;
        @java.lang.SuppressWarnings("all")
                private String content;
        @java.lang.SuppressWarnings("all")
                private String error;

        @java.lang.SuppressWarnings("all")
                DummyResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DummyResponse.DummyResponseBuilder commandId(final Long commandId) {
            this.commandId = commandId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DummyResponse.DummyResponseBuilder content(final String content) {
            this.content = content;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DummyResponse.DummyResponseBuilder error(final String error) {
            this.error = error;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public DummyResponse build() {
            return new DummyResponse(this.commandId, this.content, this.error);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "DummyResponse.DummyResponseBuilder(commandId=" + this.commandId + ", content=" + this.content + ", error=" + this.error + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static DummyResponse.DummyResponseBuilder builder() {
        return new DummyResponse.DummyResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getCommandId() {
        return this.commandId;
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
        public void setCommandId(final Long commandId) {
        this.commandId = commandId;
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
        if (!(o instanceof DummyResponse)) return false;
        final DummyResponse other = (DummyResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$commandId = this.getCommandId();
        final java.lang.Object other$commandId = other.getCommandId();
        if (this$commandId == null ? other$commandId != null : !this$commandId.equals(other$commandId)) return false;
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
        return other instanceof DummyResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $commandId = this.getCommandId();
        result = result * PRIME + ($commandId == null ? 43 : $commandId.hashCode());
        final java.lang.Object $content = this.getContent();
        result = result * PRIME + ($content == null ? 43 : $content.hashCode());
        final java.lang.Object $error = this.getError();
        result = result * PRIME + ($error == null ? 43 : $error.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DummyResponse(commandId=" + this.getCommandId() + ", content=" + this.getContent() + ", error=" + this.getError() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public DummyResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public DummyResponse(final Long commandId, final String content, final String error) {
        this.commandId = commandId;
        this.content = content;
        this.error = error;
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String commandId = "commandId";
        public static final java.lang.String content = "content";
        public static final java.lang.String error = "error";
    }
}
