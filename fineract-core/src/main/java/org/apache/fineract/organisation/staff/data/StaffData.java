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

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.Collection;
import org.apache.fineract.organisation.office.data.OfficeData;

public final class StaffData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private String externalId;
    private String firstname;
    private String lastname;
    private String displayName;
    private String mobileNo;
    private Long officeId;
    private String officeName;
    private Boolean isLoanOfficer;
    private Boolean isActive;
    private LocalDate joiningDate;
    private Integer rowIndex;
    private String dateFormat;
    private String locale;
    private Collection<OfficeData> allowedOffices;

    @java.lang.SuppressWarnings("all")
        private static String $default$dateFormat() {
        return "yyyyMMdd";
    }


    @java.lang.SuppressWarnings("all")
        public static class StaffDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String externalId;
        @java.lang.SuppressWarnings("all")
                private String firstname;
        @java.lang.SuppressWarnings("all")
                private String lastname;
        @java.lang.SuppressWarnings("all")
                private String displayName;
        @java.lang.SuppressWarnings("all")
                private String mobileNo;
        @java.lang.SuppressWarnings("all")
                private Long officeId;
        @java.lang.SuppressWarnings("all")
                private String officeName;
        @java.lang.SuppressWarnings("all")
                private Boolean isLoanOfficer;
        @java.lang.SuppressWarnings("all")
                private Boolean isActive;
        @java.lang.SuppressWarnings("all")
                private LocalDate joiningDate;
        @java.lang.SuppressWarnings("all")
                private Integer rowIndex;
        @java.lang.SuppressWarnings("all")
                private boolean dateFormat$set;
        @java.lang.SuppressWarnings("all")
                private String dateFormat$value;
        @java.lang.SuppressWarnings("all")
                private String locale;
        @java.lang.SuppressWarnings("all")
                private Collection<OfficeData> allowedOffices;

        @java.lang.SuppressWarnings("all")
                StaffDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffData.StaffDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffData.StaffDataBuilder externalId(final String externalId) {
            this.externalId = externalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffData.StaffDataBuilder firstname(final String firstname) {
            this.firstname = firstname;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffData.StaffDataBuilder lastname(final String lastname) {
            this.lastname = lastname;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffData.StaffDataBuilder displayName(final String displayName) {
            this.displayName = displayName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffData.StaffDataBuilder mobileNo(final String mobileNo) {
            this.mobileNo = mobileNo;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffData.StaffDataBuilder officeId(final Long officeId) {
            this.officeId = officeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffData.StaffDataBuilder officeName(final String officeName) {
            this.officeName = officeName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffData.StaffDataBuilder isLoanOfficer(final Boolean isLoanOfficer) {
            this.isLoanOfficer = isLoanOfficer;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffData.StaffDataBuilder isActive(final Boolean isActive) {
            this.isActive = isActive;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffData.StaffDataBuilder joiningDate(final LocalDate joiningDate) {
            this.joiningDate = joiningDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffData.StaffDataBuilder rowIndex(final Integer rowIndex) {
            this.rowIndex = rowIndex;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffData.StaffDataBuilder dateFormat(final String dateFormat) {
            this.dateFormat$value = dateFormat;
            dateFormat$set = true;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffData.StaffDataBuilder locale(final String locale) {
            this.locale = locale;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffData.StaffDataBuilder allowedOffices(final Collection<OfficeData> allowedOffices) {
            this.allowedOffices = allowedOffices;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public StaffData build() {
            String dateFormat$value = this.dateFormat$value;
            if (!this.dateFormat$set) dateFormat$value = StaffData.$default$dateFormat();
            return new StaffData(this.id, this.externalId, this.firstname, this.lastname, this.displayName, this.mobileNo, this.officeId, this.officeName, this.isLoanOfficer, this.isActive, this.joiningDate, this.rowIndex, dateFormat$value, this.locale, this.allowedOffices);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "StaffData.StaffDataBuilder(id=" + this.id + ", externalId=" + this.externalId + ", firstname=" + this.firstname + ", lastname=" + this.lastname + ", displayName=" + this.displayName + ", mobileNo=" + this.mobileNo + ", officeId=" + this.officeId + ", officeName=" + this.officeName + ", isLoanOfficer=" + this.isLoanOfficer + ", isActive=" + this.isActive + ", joiningDate=" + this.joiningDate + ", rowIndex=" + this.rowIndex + ", dateFormat$value=" + this.dateFormat$value + ", locale=" + this.locale + ", allowedOffices=" + this.allowedOffices + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static StaffData.StaffDataBuilder builder() {
        return new StaffData.StaffDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getExternalId() {
        return this.externalId;
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
        public String getDisplayName() {
        return this.displayName;
    }

    @java.lang.SuppressWarnings("all")
        public String getMobileNo() {
        return this.mobileNo;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getOfficeName() {
        return this.officeName;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsLoanOfficer() {
        return this.isLoanOfficer;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsActive() {
        return this.isActive;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getJoiningDate() {
        return this.joiningDate;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRowIndex() {
        return this.rowIndex;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<OfficeData> getAllowedOffices() {
        return this.allowedOffices;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalId(final String externalId) {
        this.externalId = externalId;
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
        public void setDisplayName(final String displayName) {
        this.displayName = displayName;
    }

    @java.lang.SuppressWarnings("all")
        public void setMobileNo(final String mobileNo) {
        this.mobileNo = mobileNo;
    }

    @java.lang.SuppressWarnings("all")
        public void setOfficeId(final Long officeId) {
        this.officeId = officeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setOfficeName(final String officeName) {
        this.officeName = officeName;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsLoanOfficer(final Boolean isLoanOfficer) {
        this.isLoanOfficer = isLoanOfficer;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsActive(final Boolean isActive) {
        this.isActive = isActive;
    }

    @java.lang.SuppressWarnings("all")
        public void setJoiningDate(final LocalDate joiningDate) {
        this.joiningDate = joiningDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setRowIndex(final Integer rowIndex) {
        this.rowIndex = rowIndex;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setAllowedOffices(final Collection<OfficeData> allowedOffices) {
        this.allowedOffices = allowedOffices;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof StaffData)) return false;
        final StaffData other = (StaffData) o;
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
        final java.lang.Object this$rowIndex = this.getRowIndex();
        final java.lang.Object other$rowIndex = other.getRowIndex();
        if (this$rowIndex == null ? other$rowIndex != null : !this$rowIndex.equals(other$rowIndex)) return false;
        final java.lang.Object this$externalId = this.getExternalId();
        final java.lang.Object other$externalId = other.getExternalId();
        if (this$externalId == null ? other$externalId != null : !this$externalId.equals(other$externalId)) return false;
        final java.lang.Object this$firstname = this.getFirstname();
        final java.lang.Object other$firstname = other.getFirstname();
        if (this$firstname == null ? other$firstname != null : !this$firstname.equals(other$firstname)) return false;
        final java.lang.Object this$lastname = this.getLastname();
        final java.lang.Object other$lastname = other.getLastname();
        if (this$lastname == null ? other$lastname != null : !this$lastname.equals(other$lastname)) return false;
        final java.lang.Object this$displayName = this.getDisplayName();
        final java.lang.Object other$displayName = other.getDisplayName();
        if (this$displayName == null ? other$displayName != null : !this$displayName.equals(other$displayName)) return false;
        final java.lang.Object this$mobileNo = this.getMobileNo();
        final java.lang.Object other$mobileNo = other.getMobileNo();
        if (this$mobileNo == null ? other$mobileNo != null : !this$mobileNo.equals(other$mobileNo)) return false;
        final java.lang.Object this$officeName = this.getOfficeName();
        final java.lang.Object other$officeName = other.getOfficeName();
        if (this$officeName == null ? other$officeName != null : !this$officeName.equals(other$officeName)) return false;
        final java.lang.Object this$joiningDate = this.getJoiningDate();
        final java.lang.Object other$joiningDate = other.getJoiningDate();
        if (this$joiningDate == null ? other$joiningDate != null : !this$joiningDate.equals(other$joiningDate)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$allowedOffices = this.getAllowedOffices();
        final java.lang.Object other$allowedOffices = other.getAllowedOffices();
        if (this$allowedOffices == null ? other$allowedOffices != null : !this$allowedOffices.equals(other$allowedOffices)) return false;
        return true;
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
        final java.lang.Object $rowIndex = this.getRowIndex();
        result = result * PRIME + ($rowIndex == null ? 43 : $rowIndex.hashCode());
        final java.lang.Object $externalId = this.getExternalId();
        result = result * PRIME + ($externalId == null ? 43 : $externalId.hashCode());
        final java.lang.Object $firstname = this.getFirstname();
        result = result * PRIME + ($firstname == null ? 43 : $firstname.hashCode());
        final java.lang.Object $lastname = this.getLastname();
        result = result * PRIME + ($lastname == null ? 43 : $lastname.hashCode());
        final java.lang.Object $displayName = this.getDisplayName();
        result = result * PRIME + ($displayName == null ? 43 : $displayName.hashCode());
        final java.lang.Object $mobileNo = this.getMobileNo();
        result = result * PRIME + ($mobileNo == null ? 43 : $mobileNo.hashCode());
        final java.lang.Object $officeName = this.getOfficeName();
        result = result * PRIME + ($officeName == null ? 43 : $officeName.hashCode());
        final java.lang.Object $joiningDate = this.getJoiningDate();
        result = result * PRIME + ($joiningDate == null ? 43 : $joiningDate.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $allowedOffices = this.getAllowedOffices();
        result = result * PRIME + ($allowedOffices == null ? 43 : $allowedOffices.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "StaffData(id=" + this.getId() + ", externalId=" + this.getExternalId() + ", firstname=" + this.getFirstname() + ", lastname=" + this.getLastname() + ", displayName=" + this.getDisplayName() + ", mobileNo=" + this.getMobileNo() + ", officeId=" + this.getOfficeId() + ", officeName=" + this.getOfficeName() + ", isLoanOfficer=" + this.getIsLoanOfficer() + ", isActive=" + this.getIsActive() + ", joiningDate=" + this.getJoiningDate() + ", rowIndex=" + this.getRowIndex() + ", dateFormat=" + this.getDateFormat() + ", locale=" + this.getLocale() + ", allowedOffices=" + this.getAllowedOffices() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public StaffData() {
        this.dateFormat = StaffData.$default$dateFormat();
    }

    @java.lang.SuppressWarnings("all")
        public StaffData(final Long id, final String externalId, final String firstname, final String lastname, final String displayName, final String mobileNo, final Long officeId, final String officeName, final Boolean isLoanOfficer, final Boolean isActive, final LocalDate joiningDate, final Integer rowIndex, final String dateFormat, final String locale, final Collection<OfficeData> allowedOffices) {
        this.id = id;
        this.externalId = externalId;
        this.firstname = firstname;
        this.lastname = lastname;
        this.displayName = displayName;
        this.mobileNo = mobileNo;
        this.officeId = officeId;
        this.officeName = officeName;
        this.isLoanOfficer = isLoanOfficer;
        this.isActive = isActive;
        this.joiningDate = joiningDate;
        this.rowIndex = rowIndex;
        this.dateFormat = dateFormat;
        this.locale = locale;
        this.allowedOffices = allowedOffices;
    }
}
