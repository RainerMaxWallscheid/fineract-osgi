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
package org.apache.fineract.portfolio.floatingrates.data;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

public class FloatingRateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String name;
    private Boolean isBaseLendingRate;
    private Boolean isActive;
    private List<FloatingRatePeriodRequest> ratePeriods;

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsBaseLendingRate() {
        return this.isBaseLendingRate;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsActive() {
        return this.isActive;
    }

    @java.lang.SuppressWarnings("all")
        public List<FloatingRatePeriodRequest> getRatePeriods() {
        return this.ratePeriods;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsBaseLendingRate(final Boolean isBaseLendingRate) {
        this.isBaseLendingRate = isBaseLendingRate;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsActive(final Boolean isActive) {
        this.isActive = isActive;
    }

    @java.lang.SuppressWarnings("all")
        public void setRatePeriods(final List<FloatingRatePeriodRequest> ratePeriods) {
        this.ratePeriods = ratePeriods;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof FloatingRateRequest)) return false;
        final FloatingRateRequest other = (FloatingRateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$isBaseLendingRate = this.getIsBaseLendingRate();
        final java.lang.Object other$isBaseLendingRate = other.getIsBaseLendingRate();
        if (this$isBaseLendingRate == null ? other$isBaseLendingRate != null : !this$isBaseLendingRate.equals(other$isBaseLendingRate)) return false;
        final java.lang.Object this$isActive = this.getIsActive();
        final java.lang.Object other$isActive = other.getIsActive();
        if (this$isActive == null ? other$isActive != null : !this$isActive.equals(other$isActive)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$ratePeriods = this.getRatePeriods();
        final java.lang.Object other$ratePeriods = other.getRatePeriods();
        if (this$ratePeriods == null ? other$ratePeriods != null : !this$ratePeriods.equals(other$ratePeriods)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof FloatingRateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $isBaseLendingRate = this.getIsBaseLendingRate();
        result = result * PRIME + ($isBaseLendingRate == null ? 43 : $isBaseLendingRate.hashCode());
        final java.lang.Object $isActive = this.getIsActive();
        result = result * PRIME + ($isActive == null ? 43 : $isActive.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $ratePeriods = this.getRatePeriods();
        result = result * PRIME + ($ratePeriods == null ? 43 : $ratePeriods.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "FloatingRateRequest(name=" + this.getName() + ", isBaseLendingRate=" + this.getIsBaseLendingRate() + ", isActive=" + this.getIsActive() + ", ratePeriods=" + this.getRatePeriods() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public FloatingRateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public FloatingRateRequest(final String name, final Boolean isBaseLendingRate, final Boolean isActive, final List<FloatingRatePeriodRequest> ratePeriods) {
        this.name = name;
        this.isBaseLendingRate = isBaseLendingRate;
        this.isActive = isActive;
        this.ratePeriods = ratePeriods;
    }
}
