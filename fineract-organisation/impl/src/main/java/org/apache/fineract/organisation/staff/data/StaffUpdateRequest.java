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
import io.swagger.v3.oas.annotations.Hidden;
import jakarta.validation.constraints.Pattern;
import java.io.Serial;
import java.io.Serializable;
import org.apache.fineract.organisation.staff.validation.StaffForceStatus;
import org.hibernate.validator.constraints.Length;

@StaffForceStatus(message = "{org.apache.fineract.organisation.staff.force-id.staff-assigned}")
public class StaffUpdateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Hidden
    private Long id;
    // @Min(value = 1, message = "{org.apache.fineract.organisation.staff.office-id.min}")
    // @NotNull(message = "{org.apache.fineract.organisation.staff.office-id.not-null}")
    private Long officeId;
    // @NotNull(message = "{org.apache.fineract.organisation.staff.firstname.not-null}")
    @Length(max = 50, message = "{org.apache.fineract.organisation.staff.firstname.max}")
    private String firstname;
    // @NotNull(message = "{org.apache.fineract.organisation.staff.lastname.not-null}")
    @Length(max = 50, message = "{org.apache.fineract.organisation.staff.lastname.max}")
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
    private Boolean forceStatus;


    @java.lang.SuppressWarnings("all")
        public static class StaffUpdateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
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
                private Boolean isActive;
        @java.lang.SuppressWarnings("all")
                private String joiningDate;
        @java.lang.SuppressWarnings("all")
                private Boolean forceStatus;

        @java.lang.SuppressWarnings("all")
                StaffUpdateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUpdateRequest.StaffUpdateRequestBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUpdateRequest.StaffUpdateRequestBuilder officeId(final Long officeId) {
            this.officeId = officeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUpdateRequest.StaffUpdateRequestBuilder firstname(final String firstname) {
            this.firstname = firstname;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUpdateRequest.StaffUpdateRequestBuilder lastname(final String lastname) {
            this.lastname = lastname;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @JsonProperty("isLoanOfficer")
        @java.lang.SuppressWarnings("all")
                public StaffUpdateRequest.StaffUpdateRequestBuilder isLoanOfficer(final Boolean isLoanOfficer) {
            this.isLoanOfficer = isLoanOfficer;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUpdateRequest.StaffUpdateRequestBuilder externalId(final String externalId) {
            this.externalId = externalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUpdateRequest.StaffUpdateRequestBuilder emailAddress(final String emailAddress) {
            this.emailAddress = emailAddress;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUpdateRequest.StaffUpdateRequestBuilder mobileNo(final String mobileNo) {
            this.mobileNo = mobileNo;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @JsonProperty("isActive")
        @java.lang.SuppressWarnings("all")
                public StaffUpdateRequest.StaffUpdateRequestBuilder isActive(final Boolean isActive) {
            this.isActive = isActive;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUpdateRequest.StaffUpdateRequestBuilder joiningDate(final String joiningDate) {
            this.joiningDate = joiningDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUpdateRequest.StaffUpdateRequestBuilder forceStatus(final Boolean forceStatus) {
            this.forceStatus = forceStatus;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public StaffUpdateRequest build() {
            return new StaffUpdateRequest(this.id, this.officeId, this.firstname, this.lastname, this.isLoanOfficer, this.externalId, this.emailAddress, this.mobileNo, this.isActive, this.joiningDate, this.forceStatus);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "StaffUpdateRequest.StaffUpdateRequestBuilder(id=" + this.id + ", officeId=" + this.officeId + ", firstname=" + this.firstname + ", lastname=" + this.lastname + ", isLoanOfficer=" + this.isLoanOfficer + ", externalId=" + this.externalId + ", emailAddress=" + this.emailAddress + ", mobileNo=" + this.mobileNo + ", isActive=" + this.isActive + ", joiningDate=" + this.joiningDate + ", forceStatus=" + this.forceStatus + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static StaffUpdateRequest.StaffUpdateRequestBuilder builder() {
        return new StaffUpdateRequest.StaffUpdateRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
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
        public Boolean getForceStatus() {
        return this.forceStatus;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
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
        public void setForceStatus(final Boolean forceStatus) {
        this.forceStatus = forceStatus;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof StaffUpdateRequest)) return false;
        final StaffUpdateRequest other = (StaffUpdateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
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
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof StaffUpdateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
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
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "StaffUpdateRequest(id=" + this.getId() + ", officeId=" + this.getOfficeId() + ", firstname=" + this.getFirstname() + ", lastname=" + this.getLastname() + ", isLoanOfficer=" + this.getIsLoanOfficer() + ", externalId=" + this.getExternalId() + ", emailAddress=" + this.getEmailAddress() + ", mobileNo=" + this.getMobileNo() + ", isActive=" + this.getIsActive() + ", joiningDate=" + this.getJoiningDate() + ", forceStatus=" + this.getForceStatus() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public StaffUpdateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public StaffUpdateRequest(final Long id, final Long officeId, final String firstname, final String lastname, final Boolean isLoanOfficer, final String externalId, final String emailAddress, final String mobileNo, final Boolean isActive, final String joiningDate, final Boolean forceStatus) {
        this.id = id;
        this.officeId = officeId;
        this.firstname = firstname;
        this.lastname = lastname;
        this.isLoanOfficer = isLoanOfficer;
        this.externalId = externalId;
        this.emailAddress = emailAddress;
        this.mobileNo = mobileNo;
        this.isActive = isActive;
        this.joiningDate = joiningDate;
        this.forceStatus = forceStatus;
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String id = "id";
        public static final java.lang.String officeId = "officeId";
        public static final java.lang.String firstname = "firstname";
        public static final java.lang.String lastname = "lastname";
        public static final java.lang.String isLoanOfficer = "isLoanOfficer";
        public static final java.lang.String externalId = "externalId";
        public static final java.lang.String emailAddress = "emailAddress";
        public static final java.lang.String mobileNo = "mobileNo";
        public static final java.lang.String isActive = "isActive";
        public static final java.lang.String joiningDate = "joiningDate";
        public static final java.lang.String forceStatus = "forceStatus";
    }
}
