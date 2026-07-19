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
package org.apache.fineract.portfolio.loanaccount.guarantor.data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;

public class GuarantorsRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String locale;
    private String dateFormat; // "yyyyMMdd"
    /**
     * Fields for capturing relationship of Guarantor with customer *
     */
    private Long clientRelationshipTypeId;
    /**
     * Fields for current customers serving as guarantors *
     */
    private Integer guarantorTypeId;
    private Long entityId;
    /**
     * Fields for external persons serving as guarantors **
     */
    private String firstname;
    private String lastname;
    private String addressLine1;
    private String addressLine2;
    private String city;
    private String state;
    private String zip;
    private String country;
    private String mobileNumber;
    private String housePhoneNumber;
    private String comment;
    private String dob;
    private Long savingsId;
    private BigDecimal amount;

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    /**
     * Fields for capturing relationship of Guarantor with customer *
     */
    @java.lang.SuppressWarnings("all")
        public void setClientRelationshipTypeId(final Long clientRelationshipTypeId) {
        this.clientRelationshipTypeId = clientRelationshipTypeId;
    }

    /**
     * Fields for current customers serving as guarantors *
     */
    @java.lang.SuppressWarnings("all")
        public void setGuarantorTypeId(final Integer guarantorTypeId) {
        this.guarantorTypeId = guarantorTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntityId(final Long entityId) {
        this.entityId = entityId;
    }

    /**
     * Fields for external persons serving as guarantors **
     */
    @java.lang.SuppressWarnings("all")
        public void setFirstname(final String firstname) {
        this.firstname = firstname;
    }

    @java.lang.SuppressWarnings("all")
        public void setLastname(final String lastname) {
        this.lastname = lastname;
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
        public void setCity(final String city) {
        this.city = city;
    }

    @java.lang.SuppressWarnings("all")
        public void setState(final String state) {
        this.state = state;
    }

    @java.lang.SuppressWarnings("all")
        public void setZip(final String zip) {
        this.zip = zip;
    }

    @java.lang.SuppressWarnings("all")
        public void setCountry(final String country) {
        this.country = country;
    }

    @java.lang.SuppressWarnings("all")
        public void setMobileNumber(final String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setHousePhoneNumber(final String housePhoneNumber) {
        this.housePhoneNumber = housePhoneNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setComment(final String comment) {
        this.comment = comment;
    }

    @java.lang.SuppressWarnings("all")
        public void setDob(final String dob) {
        this.dob = dob;
    }

    @java.lang.SuppressWarnings("all")
        public void setSavingsId(final Long savingsId) {
        this.savingsId = savingsId;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmount(final BigDecimal amount) {
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    /**
     * Fields for capturing relationship of Guarantor with customer *
     */
    @java.lang.SuppressWarnings("all")
        public Long getClientRelationshipTypeId() {
        return this.clientRelationshipTypeId;
    }

    /**
     * Fields for current customers serving as guarantors *
     */
    @java.lang.SuppressWarnings("all")
        public Integer getGuarantorTypeId() {
        return this.guarantorTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getEntityId() {
        return this.entityId;
    }

    /**
     * Fields for external persons serving as guarantors **
     */
    @java.lang.SuppressWarnings("all")
        public String getFirstname() {
        return this.firstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getLastname() {
        return this.lastname;
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
        public String getCity() {
        return this.city;
    }

    @java.lang.SuppressWarnings("all")
        public String getState() {
        return this.state;
    }

    @java.lang.SuppressWarnings("all")
        public String getZip() {
        return this.zip;
    }

    @java.lang.SuppressWarnings("all")
        public String getCountry() {
        return this.country;
    }

    @java.lang.SuppressWarnings("all")
        public String getMobileNumber() {
        return this.mobileNumber;
    }

    @java.lang.SuppressWarnings("all")
        public String getHousePhoneNumber() {
        return this.housePhoneNumber;
    }

    @java.lang.SuppressWarnings("all")
        public String getComment() {
        return this.comment;
    }

    @java.lang.SuppressWarnings("all")
        public String getDob() {
        return this.dob;
    }

    @java.lang.SuppressWarnings("all")
        public Long getSavingsId() {
        return this.savingsId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public GuarantorsRequest() {
    }
}
