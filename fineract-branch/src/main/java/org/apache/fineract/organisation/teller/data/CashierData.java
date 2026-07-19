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
package org.apache.fineract.organisation.teller.data;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Collection;
import org.apache.fineract.organisation.staff.data.StaffData;

/**
 * Represents a cashier, providing access to the cashier's office, staff information, teller, and more.
 *
 * @author Markus Geiss
 *
 * @since 2.0.0
 * @see org.apache.fineract.organisation.teller.domain.Cashier
 * @since 2.0.0
 */
public final class CashierData implements Serializable {
    private Long id;
    private Long tellerId;
    private Long officeId;
    private Long staffId;
    private String description;
    private LocalDate startDate;
    private LocalDate endDate;
    private Boolean isFullDay;
    private String startTime;
    private String endTime;
    // Template fields
    private String officeName;
    private String tellerName;
    private String staffName;
    private Collection<StaffData> staffOptions;

    /**
     * Creates a new cashier.
     *
     * <p>
     * The valid from/to dates may be used to define a time period in which the cashier is assignable to a teller.
     * </p>
     *
     * <p>
     * The start/end times may be used to define a time period in which the cashier works part time.
     * </p>
     *
     * @param id
     *            the primary key of this cashier
     * @param officeId
     *            the primary key of the related office
     * @param officeName
     *            the primary key of the related staff
     * @param staffId
     *            the primary key of the related teller
     * @param staffName
     * @param tellerId
     *            the primary key of the related teller
     * @param tellerName
     * @param description
     *            the description of this cashier
     * @param startDate
     *            the valid from date of this cashier
     * @param endDate
     *            the valid to date of this cashier
     * @param isFullDay
     *            the part time flag of this cashier
     * @param startTime
     *            the start time of this cashier
     * @param endTime
     *            the end time of this cashier
     * @return
     */
    public static CashierData instance(final Long id, final Long officeId, String officeName, final Long staffId, final String staffName, final Long tellerId, final String tellerName, final String description, final LocalDate startDate, final LocalDate endDate, final Boolean isFullDay, final String startTime, final String endTime) {
        return new CashierData().setId(id).setOfficeId(officeId).setOfficeName(officeName).setStaffId(staffId).setStaffName(staffName).setTellerId(tellerId).setTellerName(tellerName).setDescription(description).setStartDate(startDate).setEndDate(endDate).setIsFullDay(isFullDay).setStartTime(startTime).setEndTime(endTime);
    }

    /*
     * Creates a new cashier.
     */
    public static CashierData template(final Long officeId, final String officeName, final Long tellerId, final String tellerName, final Collection<StaffData> staffOptions) {
        return new CashierData().setOfficeId(officeId).setOfficeName(officeName).setTellerId(tellerId).setTellerName(tellerName).setStaffOptions(staffOptions);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getTellerId() {
        return this.tellerId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getStaffId() {
        return this.staffId;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getStartDate() {
        return this.startDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getEndDate() {
        return this.endDate;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsFullDay() {
        return this.isFullDay;
    }

    @java.lang.SuppressWarnings("all")
        public String getStartTime() {
        return this.startTime;
    }

    @java.lang.SuppressWarnings("all")
        public String getEndTime() {
        return this.endTime;
    }

    @java.lang.SuppressWarnings("all")
        public String getOfficeName() {
        return this.officeName;
    }

    @java.lang.SuppressWarnings("all")
        public String getTellerName() {
        return this.tellerName;
    }

    @java.lang.SuppressWarnings("all")
        public String getStaffName() {
        return this.staffName;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<StaffData> getStaffOptions() {
        return this.staffOptions;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierData setTellerId(final Long tellerId) {
        this.tellerId = tellerId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierData setOfficeId(final Long officeId) {
        this.officeId = officeId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierData setStaffId(final Long staffId) {
        this.staffId = staffId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierData setDescription(final String description) {
        this.description = description;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierData setStartDate(final LocalDate startDate) {
        this.startDate = startDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierData setEndDate(final LocalDate endDate) {
        this.endDate = endDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierData setIsFullDay(final Boolean isFullDay) {
        this.isFullDay = isFullDay;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierData setStartTime(final String startTime) {
        this.startTime = startTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierData setEndTime(final String endTime) {
        this.endTime = endTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierData setOfficeName(final String officeName) {
        this.officeName = officeName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierData setTellerName(final String tellerName) {
        this.tellerName = tellerName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierData setStaffName(final String staffName) {
        this.staffName = staffName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CashierData setStaffOptions(final Collection<StaffData> staffOptions) {
        this.staffOptions = staffOptions;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CashierData)) return false;
        final CashierData other = (CashierData) o;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$tellerId = this.getTellerId();
        final java.lang.Object other$tellerId = other.getTellerId();
        if (this$tellerId == null ? other$tellerId != null : !this$tellerId.equals(other$tellerId)) return false;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$staffId = this.getStaffId();
        final java.lang.Object other$staffId = other.getStaffId();
        if (this$staffId == null ? other$staffId != null : !this$staffId.equals(other$staffId)) return false;
        final java.lang.Object this$isFullDay = this.getIsFullDay();
        final java.lang.Object other$isFullDay = other.getIsFullDay();
        if (this$isFullDay == null ? other$isFullDay != null : !this$isFullDay.equals(other$isFullDay)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        final java.lang.Object this$startDate = this.getStartDate();
        final java.lang.Object other$startDate = other.getStartDate();
        if (this$startDate == null ? other$startDate != null : !this$startDate.equals(other$startDate)) return false;
        final java.lang.Object this$endDate = this.getEndDate();
        final java.lang.Object other$endDate = other.getEndDate();
        if (this$endDate == null ? other$endDate != null : !this$endDate.equals(other$endDate)) return false;
        final java.lang.Object this$startTime = this.getStartTime();
        final java.lang.Object other$startTime = other.getStartTime();
        if (this$startTime == null ? other$startTime != null : !this$startTime.equals(other$startTime)) return false;
        final java.lang.Object this$endTime = this.getEndTime();
        final java.lang.Object other$endTime = other.getEndTime();
        if (this$endTime == null ? other$endTime != null : !this$endTime.equals(other$endTime)) return false;
        final java.lang.Object this$officeName = this.getOfficeName();
        final java.lang.Object other$officeName = other.getOfficeName();
        if (this$officeName == null ? other$officeName != null : !this$officeName.equals(other$officeName)) return false;
        final java.lang.Object this$tellerName = this.getTellerName();
        final java.lang.Object other$tellerName = other.getTellerName();
        if (this$tellerName == null ? other$tellerName != null : !this$tellerName.equals(other$tellerName)) return false;
        final java.lang.Object this$staffName = this.getStaffName();
        final java.lang.Object other$staffName = other.getStaffName();
        if (this$staffName == null ? other$staffName != null : !this$staffName.equals(other$staffName)) return false;
        final java.lang.Object this$staffOptions = this.getStaffOptions();
        final java.lang.Object other$staffOptions = other.getStaffOptions();
        if (this$staffOptions == null ? other$staffOptions != null : !this$staffOptions.equals(other$staffOptions)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $tellerId = this.getTellerId();
        result = result * PRIME + ($tellerId == null ? 43 : $tellerId.hashCode());
        final java.lang.Object $officeId = this.getOfficeId();
        result = result * PRIME + ($officeId == null ? 43 : $officeId.hashCode());
        final java.lang.Object $staffId = this.getStaffId();
        result = result * PRIME + ($staffId == null ? 43 : $staffId.hashCode());
        final java.lang.Object $isFullDay = this.getIsFullDay();
        result = result * PRIME + ($isFullDay == null ? 43 : $isFullDay.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        final java.lang.Object $startDate = this.getStartDate();
        result = result * PRIME + ($startDate == null ? 43 : $startDate.hashCode());
        final java.lang.Object $endDate = this.getEndDate();
        result = result * PRIME + ($endDate == null ? 43 : $endDate.hashCode());
        final java.lang.Object $startTime = this.getStartTime();
        result = result * PRIME + ($startTime == null ? 43 : $startTime.hashCode());
        final java.lang.Object $endTime = this.getEndTime();
        result = result * PRIME + ($endTime == null ? 43 : $endTime.hashCode());
        final java.lang.Object $officeName = this.getOfficeName();
        result = result * PRIME + ($officeName == null ? 43 : $officeName.hashCode());
        final java.lang.Object $tellerName = this.getTellerName();
        result = result * PRIME + ($tellerName == null ? 43 : $tellerName.hashCode());
        final java.lang.Object $staffName = this.getStaffName();
        result = result * PRIME + ($staffName == null ? 43 : $staffName.hashCode());
        final java.lang.Object $staffOptions = this.getStaffOptions();
        result = result * PRIME + ($staffOptions == null ? 43 : $staffOptions.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CashierData(id=" + this.getId() + ", tellerId=" + this.getTellerId() + ", officeId=" + this.getOfficeId() + ", staffId=" + this.getStaffId() + ", description=" + this.getDescription() + ", startDate=" + this.getStartDate() + ", endDate=" + this.getEndDate() + ", isFullDay=" + this.getIsFullDay() + ", startTime=" + this.getStartTime() + ", endTime=" + this.getEndTime() + ", officeName=" + this.getOfficeName() + ", tellerName=" + this.getTellerName() + ", staffName=" + this.getStaffName() + ", staffOptions=" + this.getStaffOptions() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CashierData() {
    }

    @java.lang.SuppressWarnings("all")
        public CashierData(final Long id, final Long tellerId, final Long officeId, final Long staffId, final String description, final LocalDate startDate, final LocalDate endDate, final Boolean isFullDay, final String startTime, final String endTime, final String officeName, final String tellerName, final String staffName, final Collection<StaffData> staffOptions) {
        this.id = id;
        this.tellerId = tellerId;
        this.officeId = officeId;
        this.staffId = staffId;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isFullDay = isFullDay;
        this.startTime = startTime;
        this.endTime = endTime;
        this.officeName = officeName;
        this.tellerName = tellerName;
        this.staffName = staffName;
        this.staffOptions = staffOptions;
    }
}
