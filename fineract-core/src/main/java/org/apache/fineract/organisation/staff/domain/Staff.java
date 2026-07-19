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
package org.apache.fineract.organisation.staff.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.organisation.office.domain.Office;

@Entity
@Table(name = "m_staff", uniqueConstraints = {@UniqueConstraint(columnNames = {"display_name"}, name = "display_name"), @UniqueConstraint(columnNames = {"external_id"}, name = "external_id_UNIQUE"), @UniqueConstraint(columnNames = {"mobile_no"}, name = "mobile_no_UNIQUE")})
public class Staff extends AbstractPersistableCustom<Long> {
    @Column(name = "firstname", length = 50)
    private String firstname;
    @Column(name = "lastname", length = 50)
    private String lastname;
    @Column(name = "display_name", length = 100)
    private String displayName;
    @Column(name = "mobile_no", length = 50, nullable = false, unique = true)
    private String mobileNo;
    @Column(name = "external_id", length = 100, unique = true)
    private String externalId;
    @Column(name = "email_address", length = 50, unique = true)
    private String emailAddress;
    @ManyToOne
    @JoinColumn(name = "office_id", nullable = false)
    private Office office;
    @Column(name = "is_loan_officer", nullable = false)
    private boolean loanOfficer;
    @Column(name = "organisational_role_enum")
    private Integer organisationalRoleType;
    @Column(name = "is_active", nullable = false)
    private boolean active;
    @Column(name = "joining_date")
    private LocalDate joiningDate;
    @ManyToOne
    @JoinColumn(name = "organisational_role_parent_staff_id")
    private Staff organisationalRoleParentStaff;
    @Column(name = "image_id")
    private Long imageId;

    // TODO: these functions are mistakenly included in an API serialization
    @Deprecated(forRemoval = true)
    public boolean isNotLoanOfficer() {
        return !isLoanOfficer();
    }

    @Deprecated(forRemoval = true)
    public boolean isNotActive() {
        return !isActive();
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
        public String getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public String getEmailAddress() {
        return this.emailAddress;
    }

    @java.lang.SuppressWarnings("all")
        public Office getOffice() {
        return this.office;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isLoanOfficer() {
        return this.loanOfficer;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getOrganisationalRoleType() {
        return this.organisationalRoleType;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isActive() {
        return this.active;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getJoiningDate() {
        return this.joiningDate;
    }

    @java.lang.SuppressWarnings("all")
        public Staff getOrganisationalRoleParentStaff() {
        return this.organisationalRoleParentStaff;
    }

    @java.lang.SuppressWarnings("all")
        public Long getImageId() {
        return this.imageId;
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
        public void setExternalId(final String externalId) {
        this.externalId = externalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setEmailAddress(final String emailAddress) {
        this.emailAddress = emailAddress;
    }

    @java.lang.SuppressWarnings("all")
        public void setOffice(final Office office) {
        this.office = office;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanOfficer(final boolean loanOfficer) {
        this.loanOfficer = loanOfficer;
    }

    @java.lang.SuppressWarnings("all")
        public void setOrganisationalRoleType(final Integer organisationalRoleType) {
        this.organisationalRoleType = organisationalRoleType;
    }

    @java.lang.SuppressWarnings("all")
        public void setActive(final boolean active) {
        this.active = active;
    }

    @java.lang.SuppressWarnings("all")
        public void setJoiningDate(final LocalDate joiningDate) {
        this.joiningDate = joiningDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setOrganisationalRoleParentStaff(final Staff organisationalRoleParentStaff) {
        this.organisationalRoleParentStaff = organisationalRoleParentStaff;
    }

    @java.lang.SuppressWarnings("all")
        public void setImageId(final Long imageId) {
        this.imageId = imageId;
    }
}
