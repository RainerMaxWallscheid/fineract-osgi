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
package org.apache.fineract.portfolio.rate.api;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;

public class RateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String name;
    private BigDecimal percentage;
    private Integer productApply;
    private Boolean active;
    private String locale;

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPercentage() {
        return this.percentage;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getProductApply() {
        return this.productApply;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getActive() {
        return this.active;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setPercentage(final BigDecimal percentage) {
        this.percentage = percentage;
    }

    @java.lang.SuppressWarnings("all")
        public void setProductApply(final Integer productApply) {
        this.productApply = productApply;
    }

    @java.lang.SuppressWarnings("all")
        public void setActive(final Boolean active) {
        this.active = active;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof RateRequest)) return false;
        final RateRequest other = (RateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$productApply = this.getProductApply();
        final java.lang.Object other$productApply = other.getProductApply();
        if (this$productApply == null ? other$productApply != null : !this$productApply.equals(other$productApply)) return false;
        final java.lang.Object this$active = this.getActive();
        final java.lang.Object other$active = other.getActive();
        if (this$active == null ? other$active != null : !this$active.equals(other$active)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$percentage = this.getPercentage();
        final java.lang.Object other$percentage = other.getPercentage();
        if (this$percentage == null ? other$percentage != null : !this$percentage.equals(other$percentage)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof RateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $productApply = this.getProductApply();
        result = result * PRIME + ($productApply == null ? 43 : $productApply.hashCode());
        final java.lang.Object $active = this.getActive();
        result = result * PRIME + ($active == null ? 43 : $active.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $percentage = this.getPercentage();
        result = result * PRIME + ($percentage == null ? 43 : $percentage.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "RateRequest(name=" + this.getName() + ", percentage=" + this.getPercentage() + ", productApply=" + this.getProductApply() + ", active=" + this.getActive() + ", locale=" + this.getLocale() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public RateRequest(final String name, final BigDecimal percentage, final Integer productApply, final Boolean active, final String locale) {
        this.name = name;
        this.percentage = percentage;
        this.productApply = productApply;
        this.active = active;
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public RateRequest() {
    }
}
