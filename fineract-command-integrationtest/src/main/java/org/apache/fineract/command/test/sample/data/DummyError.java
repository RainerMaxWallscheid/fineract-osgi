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

public class DummyError implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String field;
    private String message;
    private String code;


    @java.lang.SuppressWarnings("all")
        public static class DummyErrorBuilder {
        @java.lang.SuppressWarnings("all")
                private String field;
        @java.lang.SuppressWarnings("all")
                private String message;
        @java.lang.SuppressWarnings("all")
                private String code;

        @java.lang.SuppressWarnings("all")
                DummyErrorBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DummyError.DummyErrorBuilder field(final String field) {
            this.field = field;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DummyError.DummyErrorBuilder message(final String message) {
            this.message = message;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DummyError.DummyErrorBuilder code(final String code) {
            this.code = code;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public DummyError build() {
            return new DummyError(this.field, this.message, this.code);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "DummyError.DummyErrorBuilder(field=" + this.field + ", message=" + this.message + ", code=" + this.code + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static DummyError.DummyErrorBuilder builder() {
        return new DummyError.DummyErrorBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getField() {
        return this.field;
    }

    @java.lang.SuppressWarnings("all")
        public String getMessage() {
        return this.message;
    }

    @java.lang.SuppressWarnings("all")
        public String getCode() {
        return this.code;
    }

    @java.lang.SuppressWarnings("all")
        public void setField(final String field) {
        this.field = field;
    }

    @java.lang.SuppressWarnings("all")
        public void setMessage(final String message) {
        this.message = message;
    }

    @java.lang.SuppressWarnings("all")
        public void setCode(final String code) {
        this.code = code;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof DummyError)) return false;
        final DummyError other = (DummyError) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$field = this.getField();
        final java.lang.Object other$field = other.getField();
        if (this$field == null ? other$field != null : !this$field.equals(other$field)) return false;
        final java.lang.Object this$message = this.getMessage();
        final java.lang.Object other$message = other.getMessage();
        if (this$message == null ? other$message != null : !this$message.equals(other$message)) return false;
        final java.lang.Object this$code = this.getCode();
        final java.lang.Object other$code = other.getCode();
        if (this$code == null ? other$code != null : !this$code.equals(other$code)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof DummyError;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $field = this.getField();
        result = result * PRIME + ($field == null ? 43 : $field.hashCode());
        final java.lang.Object $message = this.getMessage();
        result = result * PRIME + ($message == null ? 43 : $message.hashCode());
        final java.lang.Object $code = this.getCode();
        result = result * PRIME + ($code == null ? 43 : $code.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DummyError(field=" + this.getField() + ", message=" + this.getMessage() + ", code=" + this.getCode() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public DummyError() {
    }

    @java.lang.SuppressWarnings("all")
        public DummyError(final String field, final String message, final String code) {
        this.field = field;
        this.message = message;
        this.code = code;
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String field = "field";
        public static final java.lang.String message = "message";
        public static final java.lang.String code = "code";
    }
}
