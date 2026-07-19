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
package org.apache.fineract.portfolio.paymenttype.data;

import java.io.Serial;
import java.io.Serializable;

public class PaymentTypeData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private String name;
    private String description;
    private Boolean isCashPayment;
    private Long position;
    private String codeName;
    private Boolean isSystemDefined;


    @java.lang.SuppressWarnings("all")
        public static class PaymentTypeDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private String description;
        @java.lang.SuppressWarnings("all")
                private Boolean isCashPayment;
        @java.lang.SuppressWarnings("all")
                private Long position;
        @java.lang.SuppressWarnings("all")
                private String codeName;
        @java.lang.SuppressWarnings("all")
                private Boolean isSystemDefined;

        @java.lang.SuppressWarnings("all")
                PaymentTypeDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public PaymentTypeData.PaymentTypeDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public PaymentTypeData.PaymentTypeDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public PaymentTypeData.PaymentTypeDataBuilder description(final String description) {
            this.description = description;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public PaymentTypeData.PaymentTypeDataBuilder isCashPayment(final Boolean isCashPayment) {
            this.isCashPayment = isCashPayment;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public PaymentTypeData.PaymentTypeDataBuilder position(final Long position) {
            this.position = position;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public PaymentTypeData.PaymentTypeDataBuilder codeName(final String codeName) {
            this.codeName = codeName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public PaymentTypeData.PaymentTypeDataBuilder isSystemDefined(final Boolean isSystemDefined) {
            this.isSystemDefined = isSystemDefined;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public PaymentTypeData build() {
            return new PaymentTypeData(this.id, this.name, this.description, this.isCashPayment, this.position, this.codeName, this.isSystemDefined);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "PaymentTypeData.PaymentTypeDataBuilder(id=" + this.id + ", name=" + this.name + ", description=" + this.description + ", isCashPayment=" + this.isCashPayment + ", position=" + this.position + ", codeName=" + this.codeName + ", isSystemDefined=" + this.isSystemDefined + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static PaymentTypeData.PaymentTypeDataBuilder builder() {
        return new PaymentTypeData.PaymentTypeDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsCashPayment() {
        return this.isCashPayment;
    }

    @java.lang.SuppressWarnings("all")
        public Long getPosition() {
        return this.position;
    }

    @java.lang.SuppressWarnings("all")
        public String getCodeName() {
        return this.codeName;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsSystemDefined() {
        return this.isSystemDefined;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setDescription(final String description) {
        this.description = description;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsCashPayment(final Boolean isCashPayment) {
        this.isCashPayment = isCashPayment;
    }

    @java.lang.SuppressWarnings("all")
        public void setPosition(final Long position) {
        this.position = position;
    }

    @java.lang.SuppressWarnings("all")
        public void setCodeName(final String codeName) {
        this.codeName = codeName;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsSystemDefined(final Boolean isSystemDefined) {
        this.isSystemDefined = isSystemDefined;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof PaymentTypeData)) return false;
        final PaymentTypeData other = (PaymentTypeData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$isCashPayment = this.getIsCashPayment();
        final java.lang.Object other$isCashPayment = other.getIsCashPayment();
        if (this$isCashPayment == null ? other$isCashPayment != null : !this$isCashPayment.equals(other$isCashPayment)) return false;
        final java.lang.Object this$position = this.getPosition();
        final java.lang.Object other$position = other.getPosition();
        if (this$position == null ? other$position != null : !this$position.equals(other$position)) return false;
        final java.lang.Object this$isSystemDefined = this.getIsSystemDefined();
        final java.lang.Object other$isSystemDefined = other.getIsSystemDefined();
        if (this$isSystemDefined == null ? other$isSystemDefined != null : !this$isSystemDefined.equals(other$isSystemDefined)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        final java.lang.Object this$codeName = this.getCodeName();
        final java.lang.Object other$codeName = other.getCodeName();
        if (this$codeName == null ? other$codeName != null : !this$codeName.equals(other$codeName)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof PaymentTypeData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $isCashPayment = this.getIsCashPayment();
        result = result * PRIME + ($isCashPayment == null ? 43 : $isCashPayment.hashCode());
        final java.lang.Object $position = this.getPosition();
        result = result * PRIME + ($position == null ? 43 : $position.hashCode());
        final java.lang.Object $isSystemDefined = this.getIsSystemDefined();
        result = result * PRIME + ($isSystemDefined == null ? 43 : $isSystemDefined.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        final java.lang.Object $codeName = this.getCodeName();
        result = result * PRIME + ($codeName == null ? 43 : $codeName.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "PaymentTypeData(id=" + this.getId() + ", name=" + this.getName() + ", description=" + this.getDescription() + ", isCashPayment=" + this.getIsCashPayment() + ", position=" + this.getPosition() + ", codeName=" + this.getCodeName() + ", isSystemDefined=" + this.getIsSystemDefined() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public PaymentTypeData() {
    }

    @java.lang.SuppressWarnings("all")
        public PaymentTypeData(final Long id, final String name, final String description, final Boolean isCashPayment, final Long position, final String codeName, final Boolean isSystemDefined) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.isCashPayment = isCashPayment;
        this.position = position;
        this.codeName = codeName;
        this.isSystemDefined = isSystemDefined;
    }
}
