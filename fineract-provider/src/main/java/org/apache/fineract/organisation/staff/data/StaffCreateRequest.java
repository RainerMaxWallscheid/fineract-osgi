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
package org.apache.fineract.organisation.staff.data;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import java.io.Serial;
import java.io.Serializable;
import org.hibernate.validator.constraints.Length;

public class StaffCreateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    // @Min(value = 1, message = "{org.apache.fineract.organisation.staff.office-id.min}")
    @NotNull(message = "{org.apache.fineract.organisation.staff.office-id.not-null}")
    private Long officeId;
    @Length(max = 50, message = "{org.apache.fineract.organisation.staff.firstname.max}")
    @NotNull(message = "{org.apache.fineract.organisation.staff.firstname.not-null}")
    private String firstname;
    @Length(max = 50, message = "{org.apache.fineract.organisation.staff.lastname.max}")
    @NotNull(message = "{org.apache.fineract.organisation.staff.lastname.not-null}")
    private String lastname;
    @JsonProperty("isLoanOfficer")
    private Boolean isLoanOfficer;
    // @NotBlank(message = "{org.apache.fineract.organisation.staff.external-id.not-blank}")
    @Length(max = 100, message = "{org.apache.fineract.organisation.staff.external-id.max}")
    private String externalId;
    @Length(max = 50, message = "{org.apache.fineract.organisation.staff.email.max}")
    private String emailAddress;
    // @NotBlank(message = "{org.apache.fineract.organisation.staff.mobile-no.not-blank}")
    @Length(max = 50, message = "{org.apache.fineract.organisation.staff.mobile-no.max}")
    @Pattern(regexp = "^\\+?[0-9]{7,15}$", message = "{org.apache.fineract.organisation.staff.mobile-no.invalid}")
    private String mobileNo;
    @JsonProperty("isActive")
    private Boolean isActive;
    // @NotBlank(message = "{org.apache.fineract.organisation.staff.joining-date.not-blank}")
    private String joiningDate;
    // @NotBlank(message = "{org.apache.fineract.organisation.staff.locale.not-blank}")
    private String locale;
    // @NotBlank(message = "{org.apache.fineract.organisation.staff.date-format.not-blank}")
    private String dateFormat;
    private Boolean forceStatus;

    @java.lang.SuppressWarnings("all")
        private static Boolean $default$isActive() {
        return true;
    }


    @java.lang.SuppressWarnings("all")
        public static class StaffCreateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long officeId;
        @java.lang.SuppressWarnings("all")
                private String firstname;
        @java.lang.SuppressWarnings("all")
                private String lastname;
        @java.lang.SuppressWarnings("all")
                private Boolean isLoanOfficer;
        @java.lang.SuppressWarnings("all")
                private String externalId;
        @java.lang.SuppressWarnings("all")
                private String emailAddress;
        @java.lang.SuppressWarnings("all")
                private String mobileNo;
        @java.lang.SuppressWarnings("all")
                private boolean isActive$set;
        @java.lang.SuppressWarnings("all")
                private Boolean isActive$value;
        @java.lang.SuppressWarnings("all")
                private String joiningDate;
        @java.lang.SuppressWarnings("all")
                private String locale;
        @java.lang.SuppressWarnings("all")
                private String dateFormat;
        @java.lang.SuppressWarnings("all")
                private Boolean forceStatus;

        @java.lang.SuppressWarnings("all")
                StaffCreateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffCreateRequest.StaffCreateRequestBuilder officeId(final Long officeId) {
            this.officeId = officeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffCreateRequest.StaffCreateRequestBuilder firstname(final String firstname) {
            this.firstname = firstname;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffCreateRequest.StaffCreateRequestBuilder lastname(final String lastname) {
            this.lastname = lastname;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @JsonProperty("isLoanOfficer")
        @java.lang.SuppressWarnings("all")
                public StaffCreateRequest.StaffCreateRequestBuilder isLoanOfficer(final Boolean isLoanOfficer) {
            this.isLoanOfficer = isLoanOfficer;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffCreateRequest.StaffCreateRequestBuilder externalId(final String externalId) {
            this.externalId = externalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffCreateRequest.StaffCreateRequestBuilder emailAddress(final String emailAddress) {
            this.emailAddress = emailAddress;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffCreateRequest.StaffCreateRequestBuilder mobileNo(final String mobileNo) {
            this.mobileNo = mobileNo;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @JsonProperty("isActive")
        @java.lang.SuppressWarnings("all")
                public StaffCreateRequest.StaffCreateRequestBuilder isActive(final Boolean isActive) {
            this.isActive$value = isActive;
            isActive$set = true;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffCreateRequest.StaffCreateRequestBuilder joiningDate(final String joiningDate) {
            this.joiningDate = joiningDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffCreateRequest.StaffCreateRequestBuilder locale(final String locale) {
            this.locale = locale;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffCreateRequest.StaffCreateRequestBuilder dateFormat(final String dateFormat) {
            this.dateFormat = dateFormat;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffCreateRequest.StaffCreateRequestBuilder forceStatus(final Boolean forceStatus) {
            this.forceStatus = forceStatus;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public StaffCreateRequest build() {
            Boolean isActive$value = this.isActive$value;
            if (!this.isActive$set) isActive$value = StaffCreateRequest.$default$isActive();
            return new StaffCreateRequest(this.officeId, this.firstname, this.lastname, this.isLoanOfficer, this.externalId, this.emailAddress, this.mobileNo, isActive$value, this.joiningDate, this.locale, this.dateFormat, this.forceStatus);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "StaffCreateRequest.StaffCreateRequestBuilder(officeId=" + this.officeId + ", firstname=" + this.firstname + ", lastname=" + this.lastname + ", isLoanOfficer=" + this.isLoanOfficer + ", externalId=" + this.externalId + ", emailAddress=" + this.emailAddress + ", mobileNo=" + this.mobileNo + ", isActive$value=" + this.isActive$value + ", joiningDate=" + this.joiningDate + ", locale=" + this.locale + ", dateFormat=" + this.dateFormat + ", forceStatus=" + this.forceStatus + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static StaffCreateRequest.StaffCreateRequestBuilder builder() {
        return new StaffCreateRequest.StaffCreateRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getFirstname() {
        return this.firstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getLastname() {
        return this.lastname;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsLoanOfficer() {
        return this.isLoanOfficer;
    }

    @java.lang.SuppressWarnings("all")
        public String getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public String getEmailAddress() {
        return this.emailAddress;
    }

    @java.lang.SuppressWarnings("all")
        public String getMobileNo() {
        return this.mobileNo;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsActive() {
        return this.isActive;
    }

    @java.lang.SuppressWarnings("all")
        public String getJoiningDate() {
        return this.joiningDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getForceStatus() {
        return this.forceStatus;
    }

    @java.lang.SuppressWarnings("all")
        public void setOfficeId(final Long officeId) {
        this.officeId = officeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setFirstname(final String firstname) {
        this.firstname = firstname;
    }

    @java.lang.SuppressWarnings("all")
        public void setLastname(final String lastname) {
        this.lastname = lastname;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsLoanOfficer(final Boolean isLoanOfficer) {
        this.isLoanOfficer = isLoanOfficer;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalId(final String externalId) {
        this.externalId = externalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setEmailAddress(final String emailAddress) {
        this.emailAddress = emailAddress;
    }

    @java.lang.SuppressWarnings("all")
        public void setMobileNo(final String mobileNo) {
        this.mobileNo = mobileNo;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsActive(final Boolean isActive) {
        this.isActive = isActive;
    }

    @java.lang.SuppressWarnings("all")
        public void setJoiningDate(final String joiningDate) {
        this.joiningDate = joiningDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setForceStatus(final Boolean forceStatus) {
        this.forceStatus = forceStatus;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof StaffCreateRequest)) return false;
        final StaffCreateRequest other = (StaffCreateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$isLoanOfficer = this.getIsLoanOfficer();
        final java.lang.Object other$isLoanOfficer = other.getIsLoanOfficer();
        if (this$isLoanOfficer == null ? other$isLoanOfficer != null : !this$isLoanOfficer.equals(other$isLoanOfficer)) return false;
        final java.lang.Object this$isActive = this.getIsActive();
        final java.lang.Object other$isActive = other.getIsActive();
        if (this$isActive == null ? other$isActive != null : !this$isActive.equals(other$isActive)) return false;
        final java.lang.Object this$forceStatus = this.getForceStatus();
        final java.lang.Object other$forceStatus = other.getForceStatus();
        if (this$forceStatus == null ? other$forceStatus != null : !this$forceStatus.equals(other$forceStatus)) return false;
        final java.lang.Object this$firstname = this.getFirstname();
        final java.lang.Object other$firstname = other.getFirstname();
        if (this$firstname == null ? other$firstname != null : !this$firstname.equals(other$firstname)) return false;
        final java.lang.Object this$lastname = this.getLastname();
        final java.lang.Object other$lastname = other.getLastname();
        if (this$lastname == null ? other$lastname != null : !this$lastname.equals(other$lastname)) return false;
        final java.lang.Object this$externalId = this.getExternalId();
        final java.lang.Object other$externalId = other.getExternalId();
        if (this$externalId == null ? other$externalId != null : !this$externalId.equals(other$externalId)) return false;
        final java.lang.Object this$emailAddress = this.getEmailAddress();
        final java.lang.Object other$emailAddress = other.getEmailAddress();
        if (this$emailAddress == null ? other$emailAddress != null : !this$emailAddress.equals(other$emailAddress)) return false;
        final java.lang.Object this$mobileNo = this.getMobileNo();
        final java.lang.Object other$mobileNo = other.getMobileNo();
        if (this$mobileNo == null ? other$mobileNo != null : !this$mobileNo.equals(other$mobileNo)) return false;
        final java.lang.Object this$joiningDate = this.getJoiningDate();
        final java.lang.Object other$joiningDate = other.getJoiningDate();
        if (this$joiningDate == null ? other$joiningDate != null : !this$joiningDate.equals(other$joiningDate)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof StaffCreateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $officeId = this.getOfficeId();
        result = result * PRIME + ($officeId == null ? 43 : $officeId.hashCode());
        final java.lang.Object $isLoanOfficer = this.getIsLoanOfficer();
        result = result * PRIME + ($isLoanOfficer == null ? 43 : $isLoanOfficer.hashCode());
        final java.lang.Object $isActive = this.getIsActive();
        result = result * PRIME + ($isActive == null ? 43 : $isActive.hashCode());
        final java.lang.Object $forceStatus = this.getForceStatus();
        result = result * PRIME + ($forceStatus == null ? 43 : $forceStatus.hashCode());
        final java.lang.Object $firstname = this.getFirstname();
        result = result * PRIME + ($firstname == null ? 43 : $firstname.hashCode());
        final java.lang.Object $lastname = this.getLastname();
        result = result * PRIME + ($lastname == null ? 43 : $lastname.hashCode());
        final java.lang.Object $externalId = this.getExternalId();
        result = result * PRIME + ($externalId == null ? 43 : $externalId.hashCode());
        final java.lang.Object $emailAddress = this.getEmailAddress();
        result = result * PRIME + ($emailAddress == null ? 43 : $emailAddress.hashCode());
        final java.lang.Object $mobileNo = this.getMobileNo();
        result = result * PRIME + ($mobileNo == null ? 43 : $mobileNo.hashCode());
        final java.lang.Object $joiningDate = this.getJoiningDate();
        result = result * PRIME + ($joiningDate == null ? 43 : $joiningDate.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "StaffCreateRequest(officeId=" + this.getOfficeId() + ", firstname=" + this.getFirstname() + ", lastname=" + this.getLastname() + ", isLoanOfficer=" + this.getIsLoanOfficer() + ", externalId=" + this.getExternalId() + ", emailAddress=" + this.getEmailAddress() + ", mobileNo=" + this.getMobileNo() + ", isActive=" + this.getIsActive() + ", joiningDate=" + this.getJoiningDate() + ", locale=" + this.getLocale() + ", dateFormat=" + this.getDateFormat() + ", forceStatus=" + this.getForceStatus() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public StaffCreateRequest() {
        this.isActive = StaffCreateRequest.$default$isActive();
    }

    @java.lang.SuppressWarnings("all")
        public StaffCreateRequest(final Long officeId, final String firstname, final String lastname, final Boolean isLoanOfficer, final String externalId, final String emailAddress, final String mobileNo, final Boolean isActive, final String joiningDate, final String locale, final String dateFormat, final Boolean forceStatus) {
        this.officeId = officeId;
        this.firstname = firstname;
        this.lastname = lastname;
        this.isLoanOfficer = isLoanOfficer;
        this.externalId = externalId;
        this.emailAddress = emailAddress;
        this.mobileNo = mobileNo;
        this.isActive = isActive;
        this.joiningDate = joiningDate;
        this.locale = locale;
        this.dateFormat = dateFormat;
        this.forceStatus = forceStatus;
    }
}
