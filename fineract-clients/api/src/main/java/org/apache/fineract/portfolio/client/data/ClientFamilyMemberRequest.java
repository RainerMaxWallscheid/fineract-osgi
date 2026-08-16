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

public class ClientFamilyMemberRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String lastName;
    private String firstName;
    private String middleName;
    private Long clientId;
    private String dateFormat;
    private String mobileNumber;
    private Long genderId;
    private Boolean isDependent;
    private String dateOfBirth;
    private Long relationshipId;
    private String locale;
    private String familyMembers;
    private String qualification;
    private Long maritalStatusId;
    private Long id;
    private Long age;
    private Long professionId;


    @java.lang.SuppressWarnings("all")
        public static class ClientFamilyMemberRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private String lastName;
        @java.lang.SuppressWarnings("all")
                private String firstName;
        @java.lang.SuppressWarnings("all")
                private String middleName;
        @java.lang.SuppressWarnings("all")
                private Long clientId;
        @java.lang.SuppressWarnings("all")
                private String dateFormat;
        @java.lang.SuppressWarnings("all")
                private String mobileNumber;
        @java.lang.SuppressWarnings("all")
                private Long genderId;
        @java.lang.SuppressWarnings("all")
                private Boolean isDependent;
        @java.lang.SuppressWarnings("all")
                private String dateOfBirth;
        @java.lang.SuppressWarnings("all")
                private Long relationshipId;
        @java.lang.SuppressWarnings("all")
                private String locale;
        @java.lang.SuppressWarnings("all")
                private String familyMembers;
        @java.lang.SuppressWarnings("all")
                private String qualification;
        @java.lang.SuppressWarnings("all")
                private Long maritalStatusId;
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private Long age;
        @java.lang.SuppressWarnings("all")
                private Long professionId;

        @java.lang.SuppressWarnings("all")
                ClientFamilyMemberRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder lastName(final String lastName) {
            this.lastName = lastName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder firstName(final String firstName) {
            this.firstName = firstName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder middleName(final String middleName) {
            this.middleName = middleName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder clientId(final Long clientId) {
            this.clientId = clientId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder dateFormat(final String dateFormat) {
            this.dateFormat = dateFormat;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder mobileNumber(final String mobileNumber) {
            this.mobileNumber = mobileNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder genderId(final Long genderId) {
            this.genderId = genderId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder isDependent(final Boolean isDependent) {
            this.isDependent = isDependent;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder dateOfBirth(final String dateOfBirth) {
            this.dateOfBirth = dateOfBirth;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder relationshipId(final Long relationshipId) {
            this.relationshipId = relationshipId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder locale(final String locale) {
            this.locale = locale;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder familyMembers(final String familyMembers) {
            this.familyMembers = familyMembers;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder qualification(final String qualification) {
            this.qualification = qualification;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder maritalStatusId(final Long maritalStatusId) {
            this.maritalStatusId = maritalStatusId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder age(final Long age) {
            this.age = age;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder professionId(final Long professionId) {
            this.professionId = professionId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ClientFamilyMemberRequest build() {
            return new ClientFamilyMemberRequest(this.lastName, this.firstName, this.middleName, this.clientId, this.dateFormat, this.mobileNumber, this.genderId, this.isDependent, this.dateOfBirth, this.relationshipId, this.locale, this.familyMembers, this.qualification, this.maritalStatusId, this.id, this.age, this.professionId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder(lastName=" + this.lastName + ", firstName=" + this.firstName + ", middleName=" + this.middleName + ", clientId=" + this.clientId + ", dateFormat=" + this.dateFormat + ", mobileNumber=" + this.mobileNumber + ", genderId=" + this.genderId + ", isDependent=" + this.isDependent + ", dateOfBirth=" + this.dateOfBirth + ", relationshipId=" + this.relationshipId + ", locale=" + this.locale + ", familyMembers=" + this.familyMembers + ", qualification=" + this.qualification + ", maritalStatusId=" + this.maritalStatusId + ", id=" + this.id + ", age=" + this.age + ", professionId=" + this.professionId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder builder() {
        return new ClientFamilyMemberRequest.ClientFamilyMemberRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getLastName() {
        return this.lastName;
    }

    @java.lang.SuppressWarnings("all")
        public String getFirstName() {
        return this.firstName;
    }

    @java.lang.SuppressWarnings("all")
        public String getMiddleName() {
        return this.middleName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getMobileNumber() {
        return this.mobileNumber;
    }

    @java.lang.SuppressWarnings("all")
        public Long getGenderId() {
        return this.genderId;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsDependent() {
        return this.isDependent;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateOfBirth() {
        return this.dateOfBirth;
    }

    @java.lang.SuppressWarnings("all")
        public Long getRelationshipId() {
        return this.relationshipId;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getFamilyMembers() {
        return this.familyMembers;
    }

    @java.lang.SuppressWarnings("all")
        public String getQualification() {
        return this.qualification;
    }

    @java.lang.SuppressWarnings("all")
        public Long getMaritalStatusId() {
        return this.maritalStatusId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getAge() {
        return this.age;
    }

    @java.lang.SuppressWarnings("all")
        public Long getProfessionId() {
        return this.professionId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLastName(final String lastName) {
        this.lastName = lastName;
    }

    @java.lang.SuppressWarnings("all")
        public void setFirstName(final String firstName) {
        this.firstName = firstName;
    }

    @java.lang.SuppressWarnings("all")
        public void setMiddleName(final String middleName) {
        this.middleName = middleName;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientId(final Long clientId) {
        this.clientId = clientId;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setMobileNumber(final String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setGenderId(final Long genderId) {
        this.genderId = genderId;
    }

    @java.lang.SuppressWarnings("all")
        public void setIsDependent(final Boolean isDependent) {
        this.isDependent = isDependent;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateOfBirth(final String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    @java.lang.SuppressWarnings("all")
        public void setRelationshipId(final Long relationshipId) {
        this.relationshipId = relationshipId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setFamilyMembers(final String familyMembers) {
        this.familyMembers = familyMembers;
    }

    @java.lang.SuppressWarnings("all")
        public void setQualification(final String qualification) {
        this.qualification = qualification;
    }

    @java.lang.SuppressWarnings("all")
        public void setMaritalStatusId(final Long maritalStatusId) {
        this.maritalStatusId = maritalStatusId;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setAge(final Long age) {
        this.age = age;
    }

    @java.lang.SuppressWarnings("all")
        public void setProfessionId(final Long professionId) {
        this.professionId = professionId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ClientFamilyMemberRequest)) return false;
        final ClientFamilyMemberRequest other = (ClientFamilyMemberRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$clientId = this.getClientId();
        final java.lang.Object other$clientId = other.getClientId();
        if (this$clientId == null ? other$clientId != null : !this$clientId.equals(other$clientId)) return false;
        final java.lang.Object this$genderId = this.getGenderId();
        final java.lang.Object other$genderId = other.getGenderId();
        if (this$genderId == null ? other$genderId != null : !this$genderId.equals(other$genderId)) return false;
        final java.lang.Object this$isDependent = this.getIsDependent();
        final java.lang.Object other$isDependent = other.getIsDependent();
        if (this$isDependent == null ? other$isDependent != null : !this$isDependent.equals(other$isDependent)) return false;
        final java.lang.Object this$relationshipId = this.getRelationshipId();
        final java.lang.Object other$relationshipId = other.getRelationshipId();
        if (this$relationshipId == null ? other$relationshipId != null : !this$relationshipId.equals(other$relationshipId)) return false;
        final java.lang.Object this$maritalStatusId = this.getMaritalStatusId();
        final java.lang.Object other$maritalStatusId = other.getMaritalStatusId();
        if (this$maritalStatusId == null ? other$maritalStatusId != null : !this$maritalStatusId.equals(other$maritalStatusId)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$age = this.getAge();
        final java.lang.Object other$age = other.getAge();
        if (this$age == null ? other$age != null : !this$age.equals(other$age)) return false;
        final java.lang.Object this$professionId = this.getProfessionId();
        final java.lang.Object other$professionId = other.getProfessionId();
        if (this$professionId == null ? other$professionId != null : !this$professionId.equals(other$professionId)) return false;
        final java.lang.Object this$lastName = this.getLastName();
        final java.lang.Object other$lastName = other.getLastName();
        if (this$lastName == null ? other$lastName != null : !this$lastName.equals(other$lastName)) return false;
        final java.lang.Object this$firstName = this.getFirstName();
        final java.lang.Object other$firstName = other.getFirstName();
        if (this$firstName == null ? other$firstName != null : !this$firstName.equals(other$firstName)) return false;
        final java.lang.Object this$middleName = this.getMiddleName();
        final java.lang.Object other$middleName = other.getMiddleName();
        if (this$middleName == null ? other$middleName != null : !this$middleName.equals(other$middleName)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$mobileNumber = this.getMobileNumber();
        final java.lang.Object other$mobileNumber = other.getMobileNumber();
        if (this$mobileNumber == null ? other$mobileNumber != null : !this$mobileNumber.equals(other$mobileNumber)) return false;
        final java.lang.Object this$dateOfBirth = this.getDateOfBirth();
        final java.lang.Object other$dateOfBirth = other.getDateOfBirth();
        if (this$dateOfBirth == null ? other$dateOfBirth != null : !this$dateOfBirth.equals(other$dateOfBirth)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$familyMembers = this.getFamilyMembers();
        final java.lang.Object other$familyMembers = other.getFamilyMembers();
        if (this$familyMembers == null ? other$familyMembers != null : !this$familyMembers.equals(other$familyMembers)) return false;
        final java.lang.Object this$qualification = this.getQualification();
        final java.lang.Object other$qualification = other.getQualification();
        if (this$qualification == null ? other$qualification != null : !this$qualification.equals(other$qualification)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ClientFamilyMemberRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $clientId = this.getClientId();
        result = result * PRIME + ($clientId == null ? 43 : $clientId.hashCode());
        final java.lang.Object $genderId = this.getGenderId();
        result = result * PRIME + ($genderId == null ? 43 : $genderId.hashCode());
        final java.lang.Object $isDependent = this.getIsDependent();
        result = result * PRIME + ($isDependent == null ? 43 : $isDependent.hashCode());
        final java.lang.Object $relationshipId = this.getRelationshipId();
        result = result * PRIME + ($relationshipId == null ? 43 : $relationshipId.hashCode());
        final java.lang.Object $maritalStatusId = this.getMaritalStatusId();
        result = result * PRIME + ($maritalStatusId == null ? 43 : $maritalStatusId.hashCode());
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $age = this.getAge();
        result = result * PRIME + ($age == null ? 43 : $age.hashCode());
        final java.lang.Object $professionId = this.getProfessionId();
        result = result * PRIME + ($professionId == null ? 43 : $professionId.hashCode());
        final java.lang.Object $lastName = this.getLastName();
        result = result * PRIME + ($lastName == null ? 43 : $lastName.hashCode());
        final java.lang.Object $firstName = this.getFirstName();
        result = result * PRIME + ($firstName == null ? 43 : $firstName.hashCode());
        final java.lang.Object $middleName = this.getMiddleName();
        result = result * PRIME + ($middleName == null ? 43 : $middleName.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $mobileNumber = this.getMobileNumber();
        result = result * PRIME + ($mobileNumber == null ? 43 : $mobileNumber.hashCode());
        final java.lang.Object $dateOfBirth = this.getDateOfBirth();
        result = result * PRIME + ($dateOfBirth == null ? 43 : $dateOfBirth.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $familyMembers = this.getFamilyMembers();
        result = result * PRIME + ($familyMembers == null ? 43 : $familyMembers.hashCode());
        final java.lang.Object $qualification = this.getQualification();
        result = result * PRIME + ($qualification == null ? 43 : $qualification.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ClientFamilyMemberRequest(lastName=" + this.getLastName() + ", firstName=" + this.getFirstName() + ", middleName=" + this.getMiddleName() + ", clientId=" + this.getClientId() + ", dateFormat=" + this.getDateFormat() + ", mobileNumber=" + this.getMobileNumber() + ", genderId=" + this.getGenderId() + ", isDependent=" + this.getIsDependent() + ", dateOfBirth=" + this.getDateOfBirth() + ", relationshipId=" + this.getRelationshipId() + ", locale=" + this.getLocale() + ", familyMembers=" + this.getFamilyMembers() + ", qualification=" + this.getQualification() + ", maritalStatusId=" + this.getMaritalStatusId() + ", id=" + this.getId() + ", age=" + this.getAge() + ", professionId=" + this.getProfessionId() + ")";
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String lastName = "lastName";
        public static final java.lang.String firstName = "firstName";
        public static final java.lang.String middleName = "middleName";
        public static final java.lang.String clientId = "clientId";
        public static final java.lang.String dateFormat = "dateFormat";
        public static final java.lang.String mobileNumber = "mobileNumber";
        public static final java.lang.String genderId = "genderId";
        public static final java.lang.String isDependent = "isDependent";
        public static final java.lang.String dateOfBirth = "dateOfBirth";
        public static final java.lang.String relationshipId = "relationshipId";
        public static final java.lang.String locale = "locale";
        public static final java.lang.String familyMembers = "familyMembers";
        public static final java.lang.String qualification = "qualification";
        public static final java.lang.String maritalStatusId = "maritalStatusId";
        public static final java.lang.String id = "id";
        public static final java.lang.String age = "age";
        public static final java.lang.String professionId = "professionId";
    }

    @java.lang.SuppressWarnings("all")
        public ClientFamilyMemberRequest(final String lastName, final String firstName, final String middleName, final Long clientId, final String dateFormat, final String mobileNumber, final Long genderId, final Boolean isDependent, final String dateOfBirth, final Long relationshipId, final String locale, final String familyMembers, final String qualification, final Long maritalStatusId, final Long id, final Long age, final Long professionId) {
        this.lastName = lastName;
        this.firstName = firstName;
        this.middleName = middleName;
        this.clientId = clientId;
        this.dateFormat = dateFormat;
        this.mobileNumber = mobileNumber;
        this.genderId = genderId;
        this.isDependent = isDependent;
        this.dateOfBirth = dateOfBirth;
        this.relationshipId = relationshipId;
        this.locale = locale;
        this.familyMembers = familyMembers;
        this.qualification = qualification;
        this.maritalStatusId = maritalStatusId;
        this.id = id;
        this.age = age;
        this.professionId = professionId;
    }

    @java.lang.SuppressWarnings("all")
        public ClientFamilyMemberRequest() {
    }
}
