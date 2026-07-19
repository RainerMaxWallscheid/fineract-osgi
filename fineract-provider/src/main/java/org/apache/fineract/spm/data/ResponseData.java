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
package org.apache.fineract.spm.data;

/**
 * Model representing a survey response option for internal mapping
 */
public class ResponseData {
    private Long id;
    private String text;
    private Integer value;
    private Integer sequenceNo;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getText() {
        return this.text;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getValue() {
        return this.value;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getSequenceNo() {
        return this.sequenceNo;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ResponseData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ResponseData setText(final String text) {
        this.text = text;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ResponseData setValue(final Integer value) {
        this.value = value;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ResponseData setSequenceNo(final Integer sequenceNo) {
        this.sequenceNo = sequenceNo;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ResponseData)) return false;
        final ResponseData other = (ResponseData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$value = this.getValue();
        final java.lang.Object other$value = other.getValue();
        if (this$value == null ? other$value != null : !this$value.equals(other$value)) return false;
        final java.lang.Object this$sequenceNo = this.getSequenceNo();
        final java.lang.Object other$sequenceNo = other.getSequenceNo();
        if (this$sequenceNo == null ? other$sequenceNo != null : !this$sequenceNo.equals(other$sequenceNo)) return false;
        final java.lang.Object this$text = this.getText();
        final java.lang.Object other$text = other.getText();
        if (this$text == null ? other$text != null : !this$text.equals(other$text)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ResponseData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $value = this.getValue();
        result = result * PRIME + ($value == null ? 43 : $value.hashCode());
        final java.lang.Object $sequenceNo = this.getSequenceNo();
        result = result * PRIME + ($sequenceNo == null ? 43 : $sequenceNo.hashCode());
        final java.lang.Object $text = this.getText();
        result = result * PRIME + ($text == null ? 43 : $text.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ResponseData(id=" + this.getId() + ", text=" + this.getText() + ", value=" + this.getValue() + ", sequenceNo=" + this.getSequenceNo() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ResponseData() {
    }

    @java.lang.SuppressWarnings("all")
        public ResponseData(final Long id, final String text, final Integer value, final Integer sequenceNo) {
        this.id = id;
        this.text = text;
        this.value = value;
        this.sequenceNo = sequenceNo;
    }
}
