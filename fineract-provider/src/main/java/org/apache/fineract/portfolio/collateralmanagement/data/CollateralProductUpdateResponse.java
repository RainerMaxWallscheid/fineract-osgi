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
package org.apache.fineract.portfolio.collateralmanagement.data;

import io.swagger.v3.oas.annotations.media.Schema;
import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;

public class CollateralProductUpdateResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long resourceId;
    private Changes changes;


    @Schema(name = "CollateralProductUpdateChanges")
    public static class Changes implements Serializable {
        @Serial
        private static final long serialVersionUID = 1L;
        private String name;
        private String quality;
        private BigDecimal basePrice;
        private String unitType;
        private BigDecimal pctToBase;
        private String currency;

        @java.lang.SuppressWarnings("all")
                Changes(final String name, final String quality, final BigDecimal basePrice, final String unitType, final BigDecimal pctToBase, final String currency) {
            this.name = name;
            this.quality = quality;
            this.basePrice = basePrice;
            this.unitType = unitType;
            this.pctToBase = pctToBase;
            this.currency = currency;
        }


        @java.lang.SuppressWarnings("all")
                public static class ChangesBuilder {
            @java.lang.SuppressWarnings("all")
                        private String name;
            @java.lang.SuppressWarnings("all")
                        private String quality;
            @java.lang.SuppressWarnings("all")
                        private BigDecimal basePrice;
            @java.lang.SuppressWarnings("all")
                        private String unitType;
            @java.lang.SuppressWarnings("all")
                        private BigDecimal pctToBase;
            @java.lang.SuppressWarnings("all")
                        private String currency;

            @java.lang.SuppressWarnings("all")
                        ChangesBuilder() {
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public CollateralProductUpdateResponse.Changes.ChangesBuilder name(final String name) {
                this.name = name;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public CollateralProductUpdateResponse.Changes.ChangesBuilder quality(final String quality) {
                this.quality = quality;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public CollateralProductUpdateResponse.Changes.ChangesBuilder basePrice(final BigDecimal basePrice) {
                this.basePrice = basePrice;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public CollateralProductUpdateResponse.Changes.ChangesBuilder unitType(final String unitType) {
                this.unitType = unitType;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public CollateralProductUpdateResponse.Changes.ChangesBuilder pctToBase(final BigDecimal pctToBase) {
                this.pctToBase = pctToBase;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public CollateralProductUpdateResponse.Changes.ChangesBuilder currency(final String currency) {
                this.currency = currency;
                return this;
            }

            @java.lang.SuppressWarnings("all")
                        public CollateralProductUpdateResponse.Changes build() {
                return new CollateralProductUpdateResponse.Changes(this.name, this.quality, this.basePrice, this.unitType, this.pctToBase, this.currency);
            }

            @java.lang.Override
            @java.lang.SuppressWarnings("all")
                        public java.lang.String toString() {
                return "CollateralProductUpdateResponse.Changes.ChangesBuilder(name=" + this.name + ", quality=" + this.quality + ", basePrice=" + this.basePrice + ", unitType=" + this.unitType + ", pctToBase=" + this.pctToBase + ", currency=" + this.currency + ")";
            }
        }

        @java.lang.SuppressWarnings("all")
                public static CollateralProductUpdateResponse.Changes.ChangesBuilder builder() {
            return new CollateralProductUpdateResponse.Changes.ChangesBuilder();
        }

        @java.lang.SuppressWarnings("all")
                public String getName() {
            return this.name;
        }

        @java.lang.SuppressWarnings("all")
                public String getQuality() {
            return this.quality;
        }

        @java.lang.SuppressWarnings("all")
                public BigDecimal getBasePrice() {
            return this.basePrice;
        }

        @java.lang.SuppressWarnings("all")
                public String getUnitType() {
            return this.unitType;
        }

        @java.lang.SuppressWarnings("all")
                public BigDecimal getPctToBase() {
            return this.pctToBase;
        }

        @java.lang.SuppressWarnings("all")
                public String getCurrency() {
            return this.currency;
        }

        @java.lang.SuppressWarnings("all")
                public void setName(final String name) {
            this.name = name;
        }

        @java.lang.SuppressWarnings("all")
                public void setQuality(final String quality) {
            this.quality = quality;
        }

        @java.lang.SuppressWarnings("all")
                public void setBasePrice(final BigDecimal basePrice) {
            this.basePrice = basePrice;
        }

        @java.lang.SuppressWarnings("all")
                public void setUnitType(final String unitType) {
            this.unitType = unitType;
        }

        @java.lang.SuppressWarnings("all")
                public void setPctToBase(final BigDecimal pctToBase) {
            this.pctToBase = pctToBase;
        }

        @java.lang.SuppressWarnings("all")
                public void setCurrency(final String currency) {
            this.currency = currency;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public boolean equals(final java.lang.Object o) {
            if (o == this) return true;
            if (!(o instanceof CollateralProductUpdateResponse.Changes)) return false;
            final CollateralProductUpdateResponse.Changes other = (CollateralProductUpdateResponse.Changes) o;
            if (!other.canEqual((java.lang.Object) this)) return false;
            final java.lang.Object this$name = this.getName();
            final java.lang.Object other$name = other.getName();
            if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
            final java.lang.Object this$quality = this.getQuality();
            final java.lang.Object other$quality = other.getQuality();
            if (this$quality == null ? other$quality != null : !this$quality.equals(other$quality)) return false;
            final java.lang.Object this$basePrice = this.getBasePrice();
            final java.lang.Object other$basePrice = other.getBasePrice();
            if (this$basePrice == null ? other$basePrice != null : !this$basePrice.equals(other$basePrice)) return false;
            final java.lang.Object this$unitType = this.getUnitType();
            final java.lang.Object other$unitType = other.getUnitType();
            if (this$unitType == null ? other$unitType != null : !this$unitType.equals(other$unitType)) return false;
            final java.lang.Object this$pctToBase = this.getPctToBase();
            final java.lang.Object other$pctToBase = other.getPctToBase();
            if (this$pctToBase == null ? other$pctToBase != null : !this$pctToBase.equals(other$pctToBase)) return false;
            final java.lang.Object this$currency = this.getCurrency();
            final java.lang.Object other$currency = other.getCurrency();
            if (this$currency == null ? other$currency != null : !this$currency.equals(other$currency)) return false;
            return true;
        }

        @java.lang.SuppressWarnings("all")
                protected boolean canEqual(final java.lang.Object other) {
            return other instanceof CollateralProductUpdateResponse.Changes;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public int hashCode() {
            final int PRIME = 59;
            int result = 1;
            final java.lang.Object $name = this.getName();
            result = result * PRIME + ($name == null ? 43 : $name.hashCode());
            final java.lang.Object $quality = this.getQuality();
            result = result * PRIME + ($quality == null ? 43 : $quality.hashCode());
            final java.lang.Object $basePrice = this.getBasePrice();
            result = result * PRIME + ($basePrice == null ? 43 : $basePrice.hashCode());
            final java.lang.Object $unitType = this.getUnitType();
            result = result * PRIME + ($unitType == null ? 43 : $unitType.hashCode());
            final java.lang.Object $pctToBase = this.getPctToBase();
            result = result * PRIME + ($pctToBase == null ? 43 : $pctToBase.hashCode());
            final java.lang.Object $currency = this.getCurrency();
            result = result * PRIME + ($currency == null ? 43 : $currency.hashCode());
            return result;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "CollateralProductUpdateResponse.Changes(name=" + this.getName() + ", quality=" + this.getQuality() + ", basePrice=" + this.getBasePrice() + ", unitType=" + this.getUnitType() + ", pctToBase=" + this.getPctToBase() + ", currency=" + this.getCurrency() + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        CollateralProductUpdateResponse(final Long resourceId, final Changes changes) {
        this.resourceId = resourceId;
        this.changes = changes;
    }


    @java.lang.SuppressWarnings("all")
        public static class CollateralProductUpdateResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private Long resourceId;
        @java.lang.SuppressWarnings("all")
                private Changes changes;

        @java.lang.SuppressWarnings("all")
                CollateralProductUpdateResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollateralProductUpdateResponse.CollateralProductUpdateResponseBuilder resourceId(final Long resourceId) {
            this.resourceId = resourceId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollateralProductUpdateResponse.CollateralProductUpdateResponseBuilder changes(final Changes changes) {
            this.changes = changes;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public CollateralProductUpdateResponse build() {
            return new CollateralProductUpdateResponse(this.resourceId, this.changes);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "CollateralProductUpdateResponse.CollateralProductUpdateResponseBuilder(resourceId=" + this.resourceId + ", changes=" + this.changes + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static CollateralProductUpdateResponse.CollateralProductUpdateResponseBuilder builder() {
        return new CollateralProductUpdateResponse.CollateralProductUpdateResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getResourceId() {
        return this.resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public Changes getChanges() {
        return this.changes;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceId(final Long resourceId) {
        this.resourceId = resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public void setChanges(final Changes changes) {
        this.changes = changes;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CollateralProductUpdateResponse)) return false;
        final CollateralProductUpdateResponse other = (CollateralProductUpdateResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$resourceId = this.getResourceId();
        final java.lang.Object other$resourceId = other.getResourceId();
        if (this$resourceId == null ? other$resourceId != null : !this$resourceId.equals(other$resourceId)) return false;
        final java.lang.Object this$changes = this.getChanges();
        final java.lang.Object other$changes = other.getChanges();
        if (this$changes == null ? other$changes != null : !this$changes.equals(other$changes)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof CollateralProductUpdateResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $resourceId = this.getResourceId();
        result = result * PRIME + ($resourceId == null ? 43 : $resourceId.hashCode());
        final java.lang.Object $changes = this.getChanges();
        result = result * PRIME + ($changes == null ? 43 : $changes.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CollateralProductUpdateResponse(resourceId=" + this.getResourceId() + ", changes=" + this.getChanges() + ")";
    }
}
