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
package org.apache.fineract.infrastructure.hooks.data;

import java.io.Serial;
import java.io.Serializable;

public final class HookFieldData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String fieldName;
    private String fieldValue;
    private String fieldType;
    private Boolean optional;
    private String placeholder;

    public static HookFieldData fromConfig(final String fieldName, final String fieldValue) {
        return new HookFieldData().setFieldName(fieldName).setFieldValue(fieldValue);
    }

    public static HookFieldData fromSchema(final String fieldType, final String fieldName, final Boolean optional, final String placeholder) {
        return new HookFieldData().setFieldName(fieldName).setFieldType(fieldType).setOptional(optional).setPlaceholder(placeholder);
    }


    @java.lang.SuppressWarnings("all")
        public static class HookFieldDataBuilder {
        @java.lang.SuppressWarnings("all")
                private String fieldName;
        @java.lang.SuppressWarnings("all")
                private String fieldValue;
        @java.lang.SuppressWarnings("all")
                private String fieldType;
        @java.lang.SuppressWarnings("all")
                private Boolean optional;
        @java.lang.SuppressWarnings("all")
                private String placeholder;

        @java.lang.SuppressWarnings("all")
                HookFieldDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookFieldData.HookFieldDataBuilder fieldName(final String fieldName) {
            this.fieldName = fieldName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookFieldData.HookFieldDataBuilder fieldValue(final String fieldValue) {
            this.fieldValue = fieldValue;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookFieldData.HookFieldDataBuilder fieldType(final String fieldType) {
            this.fieldType = fieldType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookFieldData.HookFieldDataBuilder optional(final Boolean optional) {
            this.optional = optional;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public HookFieldData.HookFieldDataBuilder placeholder(final String placeholder) {
            this.placeholder = placeholder;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public HookFieldData build() {
            return new HookFieldData(this.fieldName, this.fieldValue, this.fieldType, this.optional, this.placeholder);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "HookFieldData.HookFieldDataBuilder(fieldName=" + this.fieldName + ", fieldValue=" + this.fieldValue + ", fieldType=" + this.fieldType + ", optional=" + this.optional + ", placeholder=" + this.placeholder + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static HookFieldData.HookFieldDataBuilder builder() {
        return new HookFieldData.HookFieldDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getFieldName() {
        return this.fieldName;
    }

    @java.lang.SuppressWarnings("all")
        public String getFieldValue() {
        return this.fieldValue;
    }

    @java.lang.SuppressWarnings("all")
        public String getFieldType() {
        return this.fieldType;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getOptional() {
        return this.optional;
    }

    @java.lang.SuppressWarnings("all")
        public String getPlaceholder() {
        return this.placeholder;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookFieldData setFieldName(final String fieldName) {
        this.fieldName = fieldName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookFieldData setFieldValue(final String fieldValue) {
        this.fieldValue = fieldValue;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookFieldData setFieldType(final String fieldType) {
        this.fieldType = fieldType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookFieldData setOptional(final Boolean optional) {
        this.optional = optional;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HookFieldData setPlaceholder(final String placeholder) {
        this.placeholder = placeholder;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof HookFieldData)) return false;
        final HookFieldData other = (HookFieldData) o;
        final java.lang.Object this$optional = this.getOptional();
        final java.lang.Object other$optional = other.getOptional();
        if (this$optional == null ? other$optional != null : !this$optional.equals(other$optional)) return false;
        final java.lang.Object this$fieldName = this.getFieldName();
        final java.lang.Object other$fieldName = other.getFieldName();
        if (this$fieldName == null ? other$fieldName != null : !this$fieldName.equals(other$fieldName)) return false;
        final java.lang.Object this$fieldValue = this.getFieldValue();
        final java.lang.Object other$fieldValue = other.getFieldValue();
        if (this$fieldValue == null ? other$fieldValue != null : !this$fieldValue.equals(other$fieldValue)) return false;
        final java.lang.Object this$fieldType = this.getFieldType();
        final java.lang.Object other$fieldType = other.getFieldType();
        if (this$fieldType == null ? other$fieldType != null : !this$fieldType.equals(other$fieldType)) return false;
        final java.lang.Object this$placeholder = this.getPlaceholder();
        final java.lang.Object other$placeholder = other.getPlaceholder();
        if (this$placeholder == null ? other$placeholder != null : !this$placeholder.equals(other$placeholder)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $optional = this.getOptional();
        result = result * PRIME + ($optional == null ? 43 : $optional.hashCode());
        final java.lang.Object $fieldName = this.getFieldName();
        result = result * PRIME + ($fieldName == null ? 43 : $fieldName.hashCode());
        final java.lang.Object $fieldValue = this.getFieldValue();
        result = result * PRIME + ($fieldValue == null ? 43 : $fieldValue.hashCode());
        final java.lang.Object $fieldType = this.getFieldType();
        result = result * PRIME + ($fieldType == null ? 43 : $fieldType.hashCode());
        final java.lang.Object $placeholder = this.getPlaceholder();
        result = result * PRIME + ($placeholder == null ? 43 : $placeholder.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "HookFieldData(fieldName=" + this.getFieldName() + ", fieldValue=" + this.getFieldValue() + ", fieldType=" + this.getFieldType() + ", optional=" + this.getOptional() + ", placeholder=" + this.getPlaceholder() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public HookFieldData() {
    }

    @java.lang.SuppressWarnings("all")
        public HookFieldData(final String fieldName, final String fieldValue, final String fieldType, final Boolean optional, final String placeholder) {
        this.fieldName = fieldName;
        this.fieldValue = fieldValue;
        this.fieldType = fieldType;
        this.optional = optional;
        this.placeholder = placeholder;
    }
}
