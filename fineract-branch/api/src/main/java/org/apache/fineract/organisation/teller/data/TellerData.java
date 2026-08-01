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
import org.apache.fineract.organisation.office.data.OfficeData;
import org.apache.fineract.organisation.staff.data.StaffData;
import org.apache.fineract.organisation.teller.moduleapi.TellerStatus;

/**
 * {@code TellerData} represents an immutable data object for teller data.
 *
 * @version 1.0
 *
 * @since 2.0.0
 * @see java.io.Serializable
 * @since 2.0.0
 */
public final class TellerData implements Serializable {
    private Long id;
    private Long officeId;
    private Long debitAccountId;
    private Long creditAccountId;
    private String name;
    private String description;
    private LocalDate startDate;
    private LocalDate endDate;
    private TellerStatus status;
    private Boolean hasTransactions;
    private Boolean hasMappedCashiers;
    private String officeName;
    private Collection<OfficeData> officeOptions;
    private Collection<StaffData> staffOptions;

    /**
     * Creates a new teller data object.
     *
     * @param id
     *            - id of the teller
     * @param officeId
     *            - id of the related office
     * @param debitAccountId
     *            - id of the debit account to use
     * @param creditAccountId
     *            - id of the credit account to use
     * @param name
     *            - name of the teller
     * @param description
     *            - description of the teller
     * @param startDate
     *            - date when the teller becomes available
     * @param endDate
     *            - date when the teller becomes unavailable
     * @param status
     *            - current state of the teller, eg. active, inactive, pending
     * @param hasTransactions
     *            - indicates that this teller already is used to perform postings
     * @param hasMappedCashiers
     *            - indicates that the teller already has @code Cashier}s assigned to it
     * @return the new created {@code TellerData}
     */
    public static TellerData instance(final Long id, final Long officeId, final Long debitAccountId, final Long creditAccountId, final String name, final String description, final LocalDate startDate, final LocalDate endDate, final TellerStatus status, final String officeName, final Boolean hasTransactions, final Boolean hasMappedCashiers) {
        return new TellerData().setId(id).setOfficeId(officeId).setDebitAccountId(debitAccountId).setCreditAccountId(creditAccountId).setName(name).setDescription(description).setStartDate(startDate).setEndDate(endDate).setStatus(status).setOfficeName(officeName).setHasTransactions(hasTransactions).setHasMappedCashiers(hasMappedCashiers);
    }

    public static TellerData lookup(final Long id, final String name) {
        return new TellerData().setId(id).setName(name);
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
        public Long getDebitAccountId() {
        return this.debitAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCreditAccountId() {
        return this.creditAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
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
        public TellerStatus getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getHasTransactions() {
        return this.hasTransactions;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getHasMappedCashiers() {
        return this.hasMappedCashiers;
    }

    @java.lang.SuppressWarnings("all")
        public String getOfficeName() {
        return this.officeName;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<OfficeData> getOfficeOptions() {
        return this.officeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<StaffData> getStaffOptions() {
        return this.staffOptions;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerData setOfficeId(final Long officeId) {
        this.officeId = officeId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerData setDebitAccountId(final Long debitAccountId) {
        this.debitAccountId = debitAccountId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerData setCreditAccountId(final Long creditAccountId) {
        this.creditAccountId = creditAccountId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerData setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerData setDescription(final String description) {
        this.description = description;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerData setStartDate(final LocalDate startDate) {
        this.startDate = startDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerData setEndDate(final LocalDate endDate) {
        this.endDate = endDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerData setStatus(final TellerStatus status) {
        this.status = status;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerData setHasTransactions(final Boolean hasTransactions) {
        this.hasTransactions = hasTransactions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerData setHasMappedCashiers(final Boolean hasMappedCashiers) {
        this.hasMappedCashiers = hasMappedCashiers;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerData setOfficeName(final String officeName) {
        this.officeName = officeName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerData setOfficeOptions(final Collection<OfficeData> officeOptions) {
        this.officeOptions = officeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerData setStaffOptions(final Collection<StaffData> staffOptions) {
        this.staffOptions = staffOptions;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof TellerData)) return false;
        final TellerData other = (TellerData) o;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$debitAccountId = this.getDebitAccountId();
        final java.lang.Object other$debitAccountId = other.getDebitAccountId();
        if (this$debitAccountId == null ? other$debitAccountId != null : !this$debitAccountId.equals(other$debitAccountId)) return false;
        final java.lang.Object this$creditAccountId = this.getCreditAccountId();
        final java.lang.Object other$creditAccountId = other.getCreditAccountId();
        if (this$creditAccountId == null ? other$creditAccountId != null : !this$creditAccountId.equals(other$creditAccountId)) return false;
        final java.lang.Object this$hasTransactions = this.getHasTransactions();
        final java.lang.Object other$hasTransactions = other.getHasTransactions();
        if (this$hasTransactions == null ? other$hasTransactions != null : !this$hasTransactions.equals(other$hasTransactions)) return false;
        final java.lang.Object this$hasMappedCashiers = this.getHasMappedCashiers();
        final java.lang.Object other$hasMappedCashiers = other.getHasMappedCashiers();
        if (this$hasMappedCashiers == null ? other$hasMappedCashiers != null : !this$hasMappedCashiers.equals(other$hasMappedCashiers)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        final java.lang.Object this$startDate = this.getStartDate();
        final java.lang.Object other$startDate = other.getStartDate();
        if (this$startDate == null ? other$startDate != null : !this$startDate.equals(other$startDate)) return false;
        final java.lang.Object this$endDate = this.getEndDate();
        final java.lang.Object other$endDate = other.getEndDate();
        if (this$endDate == null ? other$endDate != null : !this$endDate.equals(other$endDate)) return false;
        final java.lang.Object this$status = this.getStatus();
        final java.lang.Object other$status = other.getStatus();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        final java.lang.Object this$officeName = this.getOfficeName();
        final java.lang.Object other$officeName = other.getOfficeName();
        if (this$officeName == null ? other$officeName != null : !this$officeName.equals(other$officeName)) return false;
        final java.lang.Object this$officeOptions = this.getOfficeOptions();
        final java.lang.Object other$officeOptions = other.getOfficeOptions();
        if (this$officeOptions == null ? other$officeOptions != null : !this$officeOptions.equals(other$officeOptions)) return false;
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
        final java.lang.Object $officeId = this.getOfficeId();
        result = result * PRIME + ($officeId == null ? 43 : $officeId.hashCode());
        final java.lang.Object $debitAccountId = this.getDebitAccountId();
        result = result * PRIME + ($debitAccountId == null ? 43 : $debitAccountId.hashCode());
        final java.lang.Object $creditAccountId = this.getCreditAccountId();
        result = result * PRIME + ($creditAccountId == null ? 43 : $creditAccountId.hashCode());
        final java.lang.Object $hasTransactions = this.getHasTransactions();
        result = result * PRIME + ($hasTransactions == null ? 43 : $hasTransactions.hashCode());
        final java.lang.Object $hasMappedCashiers = this.getHasMappedCashiers();
        result = result * PRIME + ($hasMappedCashiers == null ? 43 : $hasMappedCashiers.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        final java.lang.Object $startDate = this.getStartDate();
        result = result * PRIME + ($startDate == null ? 43 : $startDate.hashCode());
        final java.lang.Object $endDate = this.getEndDate();
        result = result * PRIME + ($endDate == null ? 43 : $endDate.hashCode());
        final java.lang.Object $status = this.getStatus();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        final java.lang.Object $officeName = this.getOfficeName();
        result = result * PRIME + ($officeName == null ? 43 : $officeName.hashCode());
        final java.lang.Object $officeOptions = this.getOfficeOptions();
        result = result * PRIME + ($officeOptions == null ? 43 : $officeOptions.hashCode());
        final java.lang.Object $staffOptions = this.getStaffOptions();
        result = result * PRIME + ($staffOptions == null ? 43 : $staffOptions.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "TellerData(id=" + this.getId() + ", officeId=" + this.getOfficeId() + ", debitAccountId=" + this.getDebitAccountId() + ", creditAccountId=" + this.getCreditAccountId() + ", name=" + this.getName() + ", description=" + this.getDescription() + ", startDate=" + this.getStartDate() + ", endDate=" + this.getEndDate() + ", status=" + this.getStatus() + ", hasTransactions=" + this.getHasTransactions() + ", hasMappedCashiers=" + this.getHasMappedCashiers() + ", officeName=" + this.getOfficeName() + ", officeOptions=" + this.getOfficeOptions() + ", staffOptions=" + this.getStaffOptions() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public TellerData() {
    }

    @java.lang.SuppressWarnings("all")
        public TellerData(final Long id, final Long officeId, final Long debitAccountId, final Long creditAccountId, final String name, final String description, final LocalDate startDate, final LocalDate endDate, final TellerStatus status, final Boolean hasTransactions, final Boolean hasMappedCashiers, final String officeName, final Collection<OfficeData> officeOptions, final Collection<StaffData> staffOptions) {
        this.id = id;
        this.officeId = officeId;
        this.debitAccountId = debitAccountId;
        this.creditAccountId = creditAccountId;
        this.name = name;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.hasTransactions = hasTransactions;
        this.hasMappedCashiers = hasMappedCashiers;
        this.officeName = officeName;
        this.officeOptions = officeOptions;
        this.staffOptions = staffOptions;
    }
}
