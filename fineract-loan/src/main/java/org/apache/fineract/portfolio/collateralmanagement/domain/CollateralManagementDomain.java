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
package org.apache.fineract.portfolio.collateralmanagement.domain;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.organisation.monetary.domain.ApplicationCurrency;

@Entity
@Table(name = "m_collateral_management")
public class CollateralManagementDomain extends AbstractPersistableCustom<Long> {
    @Column(name = "name", length = 20, columnDefinition = " ")
    private String name;
    @Column(name = "quality", nullable = false, length = 40)
    private String quality;
    @Column(name = "base_price", nullable = false, scale = 5, precision = 20)
    private BigDecimal basePrice;
    @Column(name = "unit_type", nullable = false, length = 10)
    private String unitType;
    @Column(name = "pct_to_base", nullable = false, scale = 5, precision = 20)
    private BigDecimal pctToBase;
    @ManyToOne
    @JoinColumn(name = "currency")
    private ApplicationCurrency currency;
    @OneToMany(mappedBy = "collateral", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private Set<ClientCollateralManagement> clientCollateralManagements = new HashSet<>();

    protected CollateralManagementDomain() {
        // for JPA
    }

    private CollateralManagementDomain(final String name, final String quality, final BigDecimal basePrice, final String unitType, final BigDecimal pctToBase, final ApplicationCurrency currency) {
        this.name = name;
        this.quality = quality;
        this.basePrice = basePrice;
        this.unitType = unitType;
        this.pctToBase = pctToBase;
        this.currency = currency;
    }


    @java.lang.SuppressWarnings("all")
        public static class CollateralManagementDomainBuilder {
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
                private ApplicationCurrency currency;

        @java.lang.SuppressWarnings("all")
                CollateralManagementDomainBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollateralManagementDomain.CollateralManagementDomainBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollateralManagementDomain.CollateralManagementDomainBuilder quality(final String quality) {
            this.quality = quality;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollateralManagementDomain.CollateralManagementDomainBuilder basePrice(final BigDecimal basePrice) {
            this.basePrice = basePrice;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollateralManagementDomain.CollateralManagementDomainBuilder unitType(final String unitType) {
            this.unitType = unitType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollateralManagementDomain.CollateralManagementDomainBuilder pctToBase(final BigDecimal pctToBase) {
            this.pctToBase = pctToBase;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollateralManagementDomain.CollateralManagementDomainBuilder currency(final ApplicationCurrency currency) {
            this.currency = currency;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public CollateralManagementDomain build() {
            return new CollateralManagementDomain(this.name, this.quality, this.basePrice, this.unitType, this.pctToBase, this.currency);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "CollateralManagementDomain.CollateralManagementDomainBuilder(name=" + this.name + ", quality=" + this.quality + ", basePrice=" + this.basePrice + ", unitType=" + this.unitType + ", pctToBase=" + this.pctToBase + ", currency=" + this.currency + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static CollateralManagementDomain.CollateralManagementDomainBuilder builder() {
        return new CollateralManagementDomain.CollateralManagementDomainBuilder();
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
        public ApplicationCurrency getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public Set<ClientCollateralManagement> getClientCollateralManagements() {
        return this.clientCollateralManagements;
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
        public void setCurrency(final ApplicationCurrency currency) {
        this.currency = currency;
    }
}
