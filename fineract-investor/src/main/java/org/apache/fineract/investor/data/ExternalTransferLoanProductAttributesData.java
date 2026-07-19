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
package org.apache.fineract.investor.data;

import java.io.Serializable;

/**
 * Data object representing an external transfer loan product attribute
 */
public class ExternalTransferLoanProductAttributesData implements Serializable {
    private Long attributeId;
    private Long loanProductId;
    private String attributeKey;
    private String attributeValue;

    @java.lang.SuppressWarnings("all")
        public ExternalTransferLoanProductAttributesData() {
    }

    @java.lang.SuppressWarnings("all")
        public void setAttributeId(final Long attributeId) {
        this.attributeId = attributeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanProductId(final Long loanProductId) {
        this.loanProductId = loanProductId;
    }

    @java.lang.SuppressWarnings("all")
        public void setAttributeKey(final String attributeKey) {
        this.attributeKey = attributeKey;
    }

    @java.lang.SuppressWarnings("all")
        public void setAttributeValue(final String attributeValue) {
        this.attributeValue = attributeValue;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ExternalTransferLoanProductAttributesData)) return false;
        final ExternalTransferLoanProductAttributesData other = (ExternalTransferLoanProductAttributesData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$attributeId = this.getAttributeId();
        final java.lang.Object other$attributeId = other.getAttributeId();
        if (this$attributeId == null ? other$attributeId != null : !this$attributeId.equals(other$attributeId)) return false;
        final java.lang.Object this$loanProductId = this.getLoanProductId();
        final java.lang.Object other$loanProductId = other.getLoanProductId();
        if (this$loanProductId == null ? other$loanProductId != null : !this$loanProductId.equals(other$loanProductId)) return false;
        final java.lang.Object this$attributeKey = this.getAttributeKey();
        final java.lang.Object other$attributeKey = other.getAttributeKey();
        if (this$attributeKey == null ? other$attributeKey != null : !this$attributeKey.equals(other$attributeKey)) return false;
        final java.lang.Object this$attributeValue = this.getAttributeValue();
        final java.lang.Object other$attributeValue = other.getAttributeValue();
        if (this$attributeValue == null ? other$attributeValue != null : !this$attributeValue.equals(other$attributeValue)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ExternalTransferLoanProductAttributesData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $attributeId = this.getAttributeId();
        result = result * PRIME + ($attributeId == null ? 43 : $attributeId.hashCode());
        final java.lang.Object $loanProductId = this.getLoanProductId();
        result = result * PRIME + ($loanProductId == null ? 43 : $loanProductId.hashCode());
        final java.lang.Object $attributeKey = this.getAttributeKey();
        result = result * PRIME + ($attributeKey == null ? 43 : $attributeKey.hashCode());
        final java.lang.Object $attributeValue = this.getAttributeValue();
        result = result * PRIME + ($attributeValue == null ? 43 : $attributeValue.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ExternalTransferLoanProductAttributesData(attributeId=" + this.getAttributeId() + ", loanProductId=" + this.getLoanProductId() + ", attributeKey=" + this.getAttributeKey() + ", attributeValue=" + this.getAttributeValue() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public Long getAttributeId() {
        return this.attributeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanProductId() {
        return this.loanProductId;
    }

    @java.lang.SuppressWarnings("all")
        public String getAttributeKey() {
        return this.attributeKey;
    }

    @java.lang.SuppressWarnings("all")
        public String getAttributeValue() {
        return this.attributeValue;
    }
}
