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
package org.apache.fineract.organisation.holiday.data;

import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;

public class HolidayData {
    @SuppressWarnings("unused")
    private Long id;
    @SuppressWarnings("unused")
    private String name;
    @SuppressWarnings("unused")
    private String description;
    @SuppressWarnings("unused")
    private LocalDate fromDate;
    @SuppressWarnings("unused")
    private LocalDate toDate;
    @SuppressWarnings("unused")
    private LocalDate repaymentsRescheduledTo;
    @SuppressWarnings("unused")
    private Long officeId;
    @SuppressWarnings("unused")
    private EnumOptionData status;
    private Integer reschedulingType;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
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
        public LocalDate getFromDate() {
        return this.fromDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getToDate() {
        return this.toDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getRepaymentsRescheduledTo() {
        return this.repaymentsRescheduledTo;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getReschedulingType() {
        return this.reschedulingType;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HolidayData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HolidayData setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HolidayData setDescription(final String description) {
        this.description = description;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HolidayData setFromDate(final LocalDate fromDate) {
        this.fromDate = fromDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HolidayData setToDate(final LocalDate toDate) {
        this.toDate = toDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HolidayData setRepaymentsRescheduledTo(final LocalDate repaymentsRescheduledTo) {
        this.repaymentsRescheduledTo = repaymentsRescheduledTo;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HolidayData setOfficeId(final Long officeId) {
        this.officeId = officeId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HolidayData setStatus(final EnumOptionData status) {
        this.status = status;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public HolidayData setReschedulingType(final Integer reschedulingType) {
        this.reschedulingType = reschedulingType;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof HolidayData)) return false;
        final HolidayData other = (HolidayData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$reschedulingType = this.getReschedulingType();
        final java.lang.Object other$reschedulingType = other.getReschedulingType();
        if (this$reschedulingType == null ? other$reschedulingType != null : !this$reschedulingType.equals(other$reschedulingType)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        final java.lang.Object this$fromDate = this.getFromDate();
        final java.lang.Object other$fromDate = other.getFromDate();
        if (this$fromDate == null ? other$fromDate != null : !this$fromDate.equals(other$fromDate)) return false;
        final java.lang.Object this$toDate = this.getToDate();
        final java.lang.Object other$toDate = other.getToDate();
        if (this$toDate == null ? other$toDate != null : !this$toDate.equals(other$toDate)) return false;
        final java.lang.Object this$repaymentsRescheduledTo = this.getRepaymentsRescheduledTo();
        final java.lang.Object other$repaymentsRescheduledTo = other.getRepaymentsRescheduledTo();
        if (this$repaymentsRescheduledTo == null ? other$repaymentsRescheduledTo != null : !this$repaymentsRescheduledTo.equals(other$repaymentsRescheduledTo)) return false;
        final java.lang.Object this$status = this.getStatus();
        final java.lang.Object other$status = other.getStatus();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof HolidayData;
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
        final java.lang.Object $reschedulingType = this.getReschedulingType();
        result = result * PRIME + ($reschedulingType == null ? 43 : $reschedulingType.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        final java.lang.Object $fromDate = this.getFromDate();
        result = result * PRIME + ($fromDate == null ? 43 : $fromDate.hashCode());
        final java.lang.Object $toDate = this.getToDate();
        result = result * PRIME + ($toDate == null ? 43 : $toDate.hashCode());
        final java.lang.Object $repaymentsRescheduledTo = this.getRepaymentsRescheduledTo();
        result = result * PRIME + ($repaymentsRescheduledTo == null ? 43 : $repaymentsRescheduledTo.hashCode());
        final java.lang.Object $status = this.getStatus();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "HolidayData(id=" + this.getId() + ", name=" + this.getName() + ", description=" + this.getDescription() + ", fromDate=" + this.getFromDate() + ", toDate=" + this.getToDate() + ", repaymentsRescheduledTo=" + this.getRepaymentsRescheduledTo() + ", officeId=" + this.getOfficeId() + ", status=" + this.getStatus() + ", reschedulingType=" + this.getReschedulingType() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public HolidayData() {
    }
}
