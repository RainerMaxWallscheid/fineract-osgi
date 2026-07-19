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
package org.apache.fineract.portfolio.client.data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;

public class ClientAddressRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String city;
    private Long countryId;
    private Boolean isActive;
    private String postalCode;
    private Long addressTypeId;
    private String addressLine1;
    private String addressLine2;
    private String addressLine3;
    private String townVillage;
    private String countyDistrict;
    private Long stateProvinceId;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private String createdBy;
    private String createdOn;
    private String updatedBy;
    private String updatedOn;
    private Long addressId;

    @java.lang.SuppressWarnings("all")
        public String getCity() {
        return this.city;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCountryId() {
        return this.countryId;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsActive() {
        return this.isActive;
    }

    @java.lang.SuppressWarnings("all")
        public String getPostalCode() {
        return this.postalCode;
    }

    @java.lang.SuppressWarnings("all")
        public Long getAddressTypeId() {
        return this.addressTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getAddressLine1() {
        return this.addressLine1;
    }

    @java.lang.SuppressWarnings("all")
        public String getAddressLine2() {
        return this.addressLine2;
    }

    @java.lang.SuppressWarnings("all")
        public String getAddressLine3() {
        return this.addressLine3;
    }

    @java.lang.SuppressWarnings("all")
        public String getTownVillage() {
        return this.townVillage;
    }

    @java.lang.SuppressWarnings("all")
        public String getCountyDistrict() {
        return this.countyDistrict;
    }

    @java.lang.SuppressWarnings("all")
        public Long getStateProvinceId() {
        return this.stateProvinceId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getLatitude() {
        return this.latitude;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getLongitude() {
        return this.longitude;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreatedBy() {
        return this.createdBy;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreatedOn() {
        return this.createdOn;
    }

    @java.lang.SuppressWarnings("all")
        public String getUpdatedBy() {
        return this.updatedBy;
    }

    @java.lang.SuppressWarnings("all")
        public String getUpdatedOn() {
        return this.updatedOn;
    }

    @java.lang.SuppressWarnings("all")
        public Long getAddressId() {
        return this.addressId;
    }

    @java.lang.SuppressWarnings("all")
        public void setCity(final String city) {
        this.city = city;
    }

    @java.lang.SuppressWarnings("all")
        public void setCountryId(final Long countryId) {
        this.countryId = countryId;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsActive(final Boolean isActive) {
        this.isActive = isActive;
    }

    @java.lang.SuppressWarnings("all")
        public void setPostalCode(final String postalCode) {
        this.postalCode = postalCode;
    }

    @java.lang.SuppressWarnings("all")
        public void setAddressTypeId(final Long addressTypeId) {
        this.addressTypeId = addressTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setAddressLine1(final String addressLine1) {
        this.addressLine1 = addressLine1;
    }

    @java.lang.SuppressWarnings("all")
        public void setAddressLine2(final String addressLine2) {
        this.addressLine2 = addressLine2;
    }

    @java.lang.SuppressWarnings("all")
        public void setAddressLine3(final String addressLine3) {
        this.addressLine3 = addressLine3;
    }

    @java.lang.SuppressWarnings("all")
        public void setTownVillage(final String townVillage) {
        this.townVillage = townVillage;
    }

    @java.lang.SuppressWarnings("all")
        public void setCountyDistrict(final String countyDistrict) {
        this.countyDistrict = countyDistrict;
    }

    @java.lang.SuppressWarnings("all")
        public void setStateProvinceId(final Long stateProvinceId) {
        this.stateProvinceId = stateProvinceId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLatitude(final BigDecimal latitude) {
        this.latitude = latitude;
    }

    @java.lang.SuppressWarnings("all")
        public void setLongitude(final BigDecimal longitude) {
        this.longitude = longitude;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreatedBy(final String createdBy) {
        this.createdBy = createdBy;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreatedOn(final String createdOn) {
        this.createdOn = createdOn;
    }

    @java.lang.SuppressWarnings("all")
        public void setUpdatedBy(final String updatedBy) {
        this.updatedBy = updatedBy;
    }

    @java.lang.SuppressWarnings("all")
        public void setUpdatedOn(final String updatedOn) {
        this.updatedOn = updatedOn;
    }

    @java.lang.SuppressWarnings("all")
        public void setAddressId(final Long addressId) {
        this.addressId = addressId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ClientAddressRequest)) return false;
        final ClientAddressRequest other = (ClientAddressRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$countryId = this.getCountryId();
        final java.lang.Object other$countryId = other.getCountryId();
        if (this$countryId == null ? other$countryId != null : !this$countryId.equals(other$countryId)) return false;
        final java.lang.Object this$isActive = this.getIsActive();
        final java.lang.Object other$isActive = other.getIsActive();
        if (this$isActive == null ? other$isActive != null : !this$isActive.equals(other$isActive)) return false;
        final java.lang.Object this$addressTypeId = this.getAddressTypeId();
        final java.lang.Object other$addressTypeId = other.getAddressTypeId();
        if (this$addressTypeId == null ? other$addressTypeId != null : !this$addressTypeId.equals(other$addressTypeId)) return false;
        final java.lang.Object this$stateProvinceId = this.getStateProvinceId();
        final java.lang.Object other$stateProvinceId = other.getStateProvinceId();
        if (this$stateProvinceId == null ? other$stateProvinceId != null : !this$stateProvinceId.equals(other$stateProvinceId)) return false;
        final java.lang.Object this$addressId = this.getAddressId();
        final java.lang.Object other$addressId = other.getAddressId();
        if (this$addressId == null ? other$addressId != null : !this$addressId.equals(other$addressId)) return false;
        final java.lang.Object this$city = this.getCity();
        final java.lang.Object other$city = other.getCity();
        if (this$city == null ? other$city != null : !this$city.equals(other$city)) return false;
        final java.lang.Object this$postalCode = this.getPostalCode();
        final java.lang.Object other$postalCode = other.getPostalCode();
        if (this$postalCode == null ? other$postalCode != null : !this$postalCode.equals(other$postalCode)) return false;
        final java.lang.Object this$addressLine1 = this.getAddressLine1();
        final java.lang.Object other$addressLine1 = other.getAddressLine1();
        if (this$addressLine1 == null ? other$addressLine1 != null : !this$addressLine1.equals(other$addressLine1)) return false;
        final java.lang.Object this$addressLine2 = this.getAddressLine2();
        final java.lang.Object other$addressLine2 = other.getAddressLine2();
        if (this$addressLine2 == null ? other$addressLine2 != null : !this$addressLine2.equals(other$addressLine2)) return false;
        final java.lang.Object this$addressLine3 = this.getAddressLine3();
        final java.lang.Object other$addressLine3 = other.getAddressLine3();
        if (this$addressLine3 == null ? other$addressLine3 != null : !this$addressLine3.equals(other$addressLine3)) return false;
        final java.lang.Object this$townVillage = this.getTownVillage();
        final java.lang.Object other$townVillage = other.getTownVillage();
        if (this$townVillage == null ? other$townVillage != null : !this$townVillage.equals(other$townVillage)) return false;
        final java.lang.Object this$countyDistrict = this.getCountyDistrict();
        final java.lang.Object other$countyDistrict = other.getCountyDistrict();
        if (this$countyDistrict == null ? other$countyDistrict != null : !this$countyDistrict.equals(other$countyDistrict)) return false;
        final java.lang.Object this$latitude = this.getLatitude();
        final java.lang.Object other$latitude = other.getLatitude();
        if (this$latitude == null ? other$latitude != null : !this$latitude.equals(other$latitude)) return false;
        final java.lang.Object this$longitude = this.getLongitude();
        final java.lang.Object other$longitude = other.getLongitude();
        if (this$longitude == null ? other$longitude != null : !this$longitude.equals(other$longitude)) return false;
        final java.lang.Object this$createdBy = this.getCreatedBy();
        final java.lang.Object other$createdBy = other.getCreatedBy();
        if (this$createdBy == null ? other$createdBy != null : !this$createdBy.equals(other$createdBy)) return false;
        final java.lang.Object this$createdOn = this.getCreatedOn();
        final java.lang.Object other$createdOn = other.getCreatedOn();
        if (this$createdOn == null ? other$createdOn != null : !this$createdOn.equals(other$createdOn)) return false;
        final java.lang.Object this$updatedBy = this.getUpdatedBy();
        final java.lang.Object other$updatedBy = other.getUpdatedBy();
        if (this$updatedBy == null ? other$updatedBy != null : !this$updatedBy.equals(other$updatedBy)) return false;
        final java.lang.Object this$updatedOn = this.getUpdatedOn();
        final java.lang.Object other$updatedOn = other.getUpdatedOn();
        if (this$updatedOn == null ? other$updatedOn != null : !this$updatedOn.equals(other$updatedOn)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ClientAddressRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $countryId = this.getCountryId();
        result = result * PRIME + ($countryId == null ? 43 : $countryId.hashCode());
        final java.lang.Object $isActive = this.getIsActive();
        result = result * PRIME + ($isActive == null ? 43 : $isActive.hashCode());
        final java.lang.Object $addressTypeId = this.getAddressTypeId();
        result = result * PRIME + ($addressTypeId == null ? 43 : $addressTypeId.hashCode());
        final java.lang.Object $stateProvinceId = this.getStateProvinceId();
        result = result * PRIME + ($stateProvinceId == null ? 43 : $stateProvinceId.hashCode());
        final java.lang.Object $addressId = this.getAddressId();
        result = result * PRIME + ($addressId == null ? 43 : $addressId.hashCode());
        final java.lang.Object $city = this.getCity();
        result = result * PRIME + ($city == null ? 43 : $city.hashCode());
        final java.lang.Object $postalCode = this.getPostalCode();
        result = result * PRIME + ($postalCode == null ? 43 : $postalCode.hashCode());
        final java.lang.Object $addressLine1 = this.getAddressLine1();
        result = result * PRIME + ($addressLine1 == null ? 43 : $addressLine1.hashCode());
        final java.lang.Object $addressLine2 = this.getAddressLine2();
        result = result * PRIME + ($addressLine2 == null ? 43 : $addressLine2.hashCode());
        final java.lang.Object $addressLine3 = this.getAddressLine3();
        result = result * PRIME + ($addressLine3 == null ? 43 : $addressLine3.hashCode());
        final java.lang.Object $townVillage = this.getTownVillage();
        result = result * PRIME + ($townVillage == null ? 43 : $townVillage.hashCode());
        final java.lang.Object $countyDistrict = this.getCountyDistrict();
        result = result * PRIME + ($countyDistrict == null ? 43 : $countyDistrict.hashCode());
        final java.lang.Object $latitude = this.getLatitude();
        result = result * PRIME + ($latitude == null ? 43 : $latitude.hashCode());
        final java.lang.Object $longitude = this.getLongitude();
        result = result * PRIME + ($longitude == null ? 43 : $longitude.hashCode());
        final java.lang.Object $createdBy = this.getCreatedBy();
        result = result * PRIME + ($createdBy == null ? 43 : $createdBy.hashCode());
        final java.lang.Object $createdOn = this.getCreatedOn();
        result = result * PRIME + ($createdOn == null ? 43 : $createdOn.hashCode());
        final java.lang.Object $updatedBy = this.getUpdatedBy();
        result = result * PRIME + ($updatedBy == null ? 43 : $updatedBy.hashCode());
        final java.lang.Object $updatedOn = this.getUpdatedOn();
        result = result * PRIME + ($updatedOn == null ? 43 : $updatedOn.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ClientAddressRequest(city=" + this.getCity() + ", countryId=" + this.getCountryId() + ", isActive=" + this.getIsActive() + ", postalCode=" + this.getPostalCode() + ", addressTypeId=" + this.getAddressTypeId() + ", addressLine1=" + this.getAddressLine1() + ", addressLine2=" + this.getAddressLine2() + ", addressLine3=" + this.getAddressLine3() + ", townVillage=" + this.getTownVillage() + ", countyDistrict=" + this.getCountyDistrict() + ", stateProvinceId=" + this.getStateProvinceId() + ", latitude=" + this.getLatitude() + ", longitude=" + this.getLongitude() + ", createdBy=" + this.getCreatedBy() + ", createdOn=" + this.getCreatedOn() + ", updatedBy=" + this.getUpdatedBy() + ", updatedOn=" + this.getUpdatedOn() + ", addressId=" + this.getAddressId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ClientAddressRequest() {
    }
}
