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

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Collection;
import org.apache.fineract.infrastructure.codes.data.CodeValueData;

public final class ClientFamilyMembersData implements Serializable {
    private final Long id;
    private final Long clientId;
    private final String firstName;
    private final String middleName;
    private final String lastName;
    private final String qualification;
    private final Long relationshipId;
    private final String relationship;
    private final Long maritalStatusId;
    private final String maritalStatus;
    private final Long genderId;
    private final String gender;
    private final LocalDate dateOfBirth;
    private final Long professionId;
    private final String profession;
    private final String mobileNumber;
    private final Long age;
    private final Boolean isDependent;
    // template holder
    private final Collection<CodeValueData> relationshipIdOptions;
    private final Collection<CodeValueData> genderIdOptions;
    private final Collection<CodeValueData> maritalStatusIdOptions;
    private final Collection<CodeValueData> professionIdOptions;

    @java.lang.SuppressWarnings("all")
        ClientFamilyMembersData(final Long id, final Long clientId, final String firstName, final String middleName, final String lastName, final String qualification, final Long relationshipId, final String relationship, final Long maritalStatusId, final String maritalStatus, final Long genderId, final String gender, final LocalDate dateOfBirth, final Long professionId, final String profession, final String mobileNumber, final Long age, final Boolean isDependent, final Collection<CodeValueData> relationshipIdOptions, final Collection<CodeValueData> genderIdOptions, final Collection<CodeValueData> maritalStatusIdOptions, final Collection<CodeValueData> professionIdOptions) {
        this.id = id;
        this.clientId = clientId;
        this.firstName = firstName;
        this.middleName = middleName;
        this.lastName = lastName;
        this.qualification = qualification;
        this.relationshipId = relationshipId;
        this.relationship = relationship;
        this.maritalStatusId = maritalStatusId;
        this.maritalStatus = maritalStatus;
        this.genderId = genderId;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.professionId = professionId;
        this.profession = profession;
        this.mobileNumber = mobileNumber;
        this.age = age;
        this.isDependent = isDependent;
        this.relationshipIdOptions = relationshipIdOptions;
        this.genderIdOptions = genderIdOptions;
        this.maritalStatusIdOptions = maritalStatusIdOptions;
        this.professionIdOptions = professionIdOptions;
    }


    @java.lang.SuppressWarnings("all")
        public static class ClientFamilyMembersDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private Long clientId;
        @java.lang.SuppressWarnings("all")
                private String firstName;
        @java.lang.SuppressWarnings("all")
                private String middleName;
        @java.lang.SuppressWarnings("all")
                private String lastName;
        @java.lang.SuppressWarnings("all")
                private String qualification;
        @java.lang.SuppressWarnings("all")
                private Long relationshipId;
        @java.lang.SuppressWarnings("all")
                private String relationship;
        @java.lang.SuppressWarnings("all")
                private Long maritalStatusId;
        @java.lang.SuppressWarnings("all")
                private String maritalStatus;
        @java.lang.SuppressWarnings("all")
                private Long genderId;
        @java.lang.SuppressWarnings("all")
                private String gender;
        @java.lang.SuppressWarnings("all")
                private LocalDate dateOfBirth;
        @java.lang.SuppressWarnings("all")
                private Long professionId;
        @java.lang.SuppressWarnings("all")
                private String profession;
        @java.lang.SuppressWarnings("all")
                private String mobileNumber;
        @java.lang.SuppressWarnings("all")
                private Long age;
        @java.lang.SuppressWarnings("all")
                private Boolean isDependent;
        @java.lang.SuppressWarnings("all")
                private Collection<CodeValueData> relationshipIdOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<CodeValueData> genderIdOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<CodeValueData> maritalStatusIdOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<CodeValueData> professionIdOptions;

        @java.lang.SuppressWarnings("all")
                ClientFamilyMembersDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder clientId(final Long clientId) {
            this.clientId = clientId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder firstName(final String firstName) {
            this.firstName = firstName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder middleName(final String middleName) {
            this.middleName = middleName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder lastName(final String lastName) {
            this.lastName = lastName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder qualification(final String qualification) {
            this.qualification = qualification;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder relationshipId(final Long relationshipId) {
            this.relationshipId = relationshipId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder relationship(final String relationship) {
            this.relationship = relationship;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder maritalStatusId(final Long maritalStatusId) {
            this.maritalStatusId = maritalStatusId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder maritalStatus(final String maritalStatus) {
            this.maritalStatus = maritalStatus;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder genderId(final Long genderId) {
            this.genderId = genderId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder gender(final String gender) {
            this.gender = gender;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder dateOfBirth(final LocalDate dateOfBirth) {
            this.dateOfBirth = dateOfBirth;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder professionId(final Long professionId) {
            this.professionId = professionId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder profession(final String profession) {
            this.profession = profession;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder mobileNumber(final String mobileNumber) {
            this.mobileNumber = mobileNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder age(final Long age) {
            this.age = age;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder isDependent(final Boolean isDependent) {
            this.isDependent = isDependent;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder relationshipIdOptions(final Collection<CodeValueData> relationshipIdOptions) {
            this.relationshipIdOptions = relationshipIdOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder genderIdOptions(final Collection<CodeValueData> genderIdOptions) {
            this.genderIdOptions = genderIdOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder maritalStatusIdOptions(final Collection<CodeValueData> maritalStatusIdOptions) {
            this.maritalStatusIdOptions = maritalStatusIdOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData.ClientFamilyMembersDataBuilder professionIdOptions(final Collection<CodeValueData> professionIdOptions) {
            this.professionIdOptions = professionIdOptions;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ClientFamilyMembersData build() {
            return new ClientFamilyMembersData(this.id, this.clientId, this.firstName, this.middleName, this.lastName, this.qualification, this.relationshipId, this.relationship, this.maritalStatusId, this.maritalStatus, this.genderId, this.gender, this.dateOfBirth, this.professionId, this.profession, this.mobileNumber, this.age, this.isDependent, this.relationshipIdOptions, this.genderIdOptions, this.maritalStatusIdOptions, this.professionIdOptions);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ClientFamilyMembersData.ClientFamilyMembersDataBuilder(id=" + this.id + ", clientId=" + this.clientId + ", firstName=" + this.firstName + ", middleName=" + this.middleName + ", lastName=" + this.lastName + ", qualification=" + this.qualification + ", relationshipId=" + this.relationshipId + ", relationship=" + this.relationship + ", maritalStatusId=" + this.maritalStatusId + ", maritalStatus=" + this.maritalStatus + ", genderId=" + this.genderId + ", gender=" + this.gender + ", dateOfBirth=" + this.dateOfBirth + ", professionId=" + this.professionId + ", profession=" + this.profession + ", mobileNumber=" + this.mobileNumber + ", age=" + this.age + ", isDependent=" + this.isDependent + ", relationshipIdOptions=" + this.relationshipIdOptions + ", genderIdOptions=" + this.genderIdOptions + ", maritalStatusIdOptions=" + this.maritalStatusIdOptions + ", professionIdOptions=" + this.professionIdOptions + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ClientFamilyMembersData.ClientFamilyMembersDataBuilder builder() {
        return new ClientFamilyMembersData.ClientFamilyMembersDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
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
        public String getLastName() {
        return this.lastName;
    }

    @java.lang.SuppressWarnings("all")
        public String getQualification() {
        return this.qualification;
    }

    @java.lang.SuppressWarnings("all")
        public Long getRelationshipId() {
        return this.relationshipId;
    }

    @java.lang.SuppressWarnings("all")
        public String getRelationship() {
        return this.relationship;
    }

    @java.lang.SuppressWarnings("all")
        public Long getMaritalStatusId() {
        return this.maritalStatusId;
    }

    @java.lang.SuppressWarnings("all")
        public String getMaritalStatus() {
        return this.maritalStatus;
    }

    @java.lang.SuppressWarnings("all")
        public Long getGenderId() {
        return this.genderId;
    }

    @java.lang.SuppressWarnings("all")
        public String getGender() {
        return this.gender;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDateOfBirth() {
        return this.dateOfBirth;
    }

    @java.lang.SuppressWarnings("all")
        public Long getProfessionId() {
        return this.professionId;
    }

    @java.lang.SuppressWarnings("all")
        public String getProfession() {
        return this.profession;
    }

    @java.lang.SuppressWarnings("all")
        public String getMobileNumber() {
        return this.mobileNumber;
    }

    @java.lang.SuppressWarnings("all")
        public Long getAge() {
        return this.age;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsDependent() {
        return this.isDependent;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getRelationshipIdOptions() {
        return this.relationshipIdOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getGenderIdOptions() {
        return this.genderIdOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getMaritalStatusIdOptions() {
        return this.maritalStatusIdOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getProfessionIdOptions() {
        return this.professionIdOptions;
    }
}
