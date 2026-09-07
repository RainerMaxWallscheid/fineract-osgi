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
package org.apache.fineract.organisation.teller.domain;

import com.google.common.base.Splitter;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.persistence.UniqueConstraint;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.Map;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.organisation.office.moduleapi.OfficeAssociation;
import org.apache.fineract.organisation.staff.moduleapi.StaffAssociation;

/**
 * Provides the base model for a cashier. Represents a row in the &quot;m_cashiers&quot; database table, with each
 * column mapped to a property of this class.
 *
 * @author Markus Geiss
 * @since 2.0.0
 */
@Entity
@Table(name = "m_cashiers", uniqueConstraints = {@UniqueConstraint(name = "ux_cashiers_staff_teller", columnNames = {"staff_id", "teller_id"})})
public class Cashier extends AbstractPersistableCustom<Long> {
    private static final String IS_FULL_DAY_PARAM_NAME = "isFullDay";
    @Transient
    private Long officeId;
    /**
     * Staff id (no JPA association to leftover Staff — ADR-021).
     */
    @Column(name = "staff_id", nullable = false)
    private Long staffId;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "teller_id", nullable = false)
    private Teller teller;
    @Column(name = "description", nullable = true, length = 500)
    private String description;
    @Column(name = "start_date", nullable = false)
    private LocalDate startDate;
    @Column(name = "end_date", nullable = false)
    private LocalDate endDate;
    @Column(name = "full_day", nullable = true)
    private Boolean isFullDay;
    @Column(name = "start_time", nullable = true, length = 10)
    private String startTime;
    @Column(name = "end_time", nullable = true, length = 10)
    private String endTime;

    public static Cashier fromJson(final Object cashierOffice, final Teller teller, final Object staff, final String startTime, final String endTime, final JsonCommand command) {
        final String description = command.stringValueOfParameterNamed("description");
        final LocalDate startDate = command.localDateValueOfParameterNamed("startDate");
        final LocalDate endDate = command.localDateValueOfParameterNamed("endDate");
        final Boolean isFullDay = command.booleanObjectValueOfParameterNamed(IS_FULL_DAY_PARAM_NAME);
        return new Cashier().setOffice(cashierOffice).setTeller(teller).setStaff(staff).setDescription(description).setStartDate(startDate).setEndDate(endDate).setIsFullDay(isFullDay).setStartTime(startTime).setEndTime(endTime);
    }

    public Map<String, Object> update(final JsonCommand command) {
        final Map<String, Object> actualChanges = new LinkedHashMap<>(7);
        final String dateFormatAsInput = command.dateFormat();
        final String localeAsInput = command.locale();
        final String descriptionParamName = "description";
        if (command.isChangeInStringParameterNamed(descriptionParamName, this.description)) {
            final String newValue = command.stringValueOfParameterNamed(descriptionParamName);
            actualChanges.put(descriptionParamName, newValue);
            this.description = newValue;
        }
        final String startDateParamName = "startDate";
        if (command.isChangeInLocalDateParameterNamed(startDateParamName, getStartDate())) {
            final String valueAsInput = command.stringValueOfParameterNamed(startDateParamName);
            actualChanges.put(startDateParamName, valueAsInput);
            actualChanges.put("dateFormat", dateFormatAsInput);
            actualChanges.put("locale", localeAsInput);
            this.startDate = command.localDateValueOfParameterNamed(startDateParamName);
        }
        final String endDateParamName = "endDate";
        if (command.isChangeInLocalDateParameterNamed(endDateParamName, getEndDate())) {
            final String valueAsInput = command.stringValueOfParameterNamed(endDateParamName);
            actualChanges.put(endDateParamName, valueAsInput);
            actualChanges.put("dateFormat", dateFormatAsInput);
            actualChanges.put("locale", localeAsInput);
            this.endDate = command.localDateValueOfParameterNamed(endDateParamName);
        }
        final Boolean fullDayFlag = command.booleanObjectValueOfParameterNamed(IS_FULL_DAY_PARAM_NAME);
        if (command.isChangeInBooleanParameterNamed(IS_FULL_DAY_PARAM_NAME, this.isFullDay)) {
            final Boolean newValue = command.booleanObjectValueOfParameterNamed(IS_FULL_DAY_PARAM_NAME);
            actualChanges.put(IS_FULL_DAY_PARAM_NAME, newValue);
            this.isFullDay = newValue;
        }
        if (!fullDayFlag) {
            String newStartHour = "";
            String newStartMin = "";
            String newEndHour = "";
            String newEndMin = "";
            final String hourStartTimeParamName = "hourStartTime";
            final String minStartTimeParamName = "minStartTime";
            final String hourEndTimeParamName = "hourEndTime";
            final String minEndTimeParamName = "minEndTime";
            if (command.isChangeInLongParameterNamed(hourStartTimeParamName, this.getHourFromStartTime()) || command.isChangeInLongParameterNamed(minStartTimeParamName, this.getMinFromStartTime())) {
                newStartHour = command.stringValueOfParameterNamed(hourStartTimeParamName);
                if (newStartHour.equalsIgnoreCase("0")) {
                    newStartHour = newStartHour + "0";
                }
                actualChanges.put(hourStartTimeParamName, newStartHour);
                newStartMin = command.stringValueOfParameterNamed(minStartTimeParamName);
                if (newStartMin.equalsIgnoreCase("0")) {
                    newStartMin = newStartMin + "0";
                }
                actualChanges.put(minStartTimeParamName, newStartMin);
                this.startTime = newStartHour + ":" + newStartMin;
            }
            if (command.isChangeInLongParameterNamed(hourEndTimeParamName, this.getHourFromEndTime()) || command.isChangeInLongParameterNamed(minEndTimeParamName, this.getMinFromEndTime())) {
                newEndHour = command.stringValueOfParameterNamed(hourEndTimeParamName);
                if (newEndHour.equalsIgnoreCase("0")) {
                    newEndHour = newEndHour + "0";
                }
                actualChanges.put(hourEndTimeParamName, newEndHour);
                newEndMin = command.stringValueOfParameterNamed(minEndTimeParamName);
                if (newEndMin.equalsIgnoreCase("0")) {
                    newEndMin = newEndMin + "0";
                }
                actualChanges.put(minEndTimeParamName, newEndMin);
                this.endTime = newEndHour + ":" + newEndMin;
            }
        }
        return actualChanges;
    }

    public Long getHourFromStartTime() {
        return (this.startTime != null && !this.startTime.isEmpty()) ? Long.parseLong(Splitter.on(':').splitToList(this.startTime).get(1)) : null;
    }

    public Long getMinFromStartTime() {
        return (this.startTime != null && !this.startTime.isEmpty()) ? Long.parseLong(Splitter.on(':').splitToList(this.startTime).get(1)) : null;
    }

    public Long getHourFromEndTime() {
        return (this.endTime != null && !this.endTime.isEmpty()) ? Long.parseLong(Splitter.on(':').splitToList(this.endTime).get(0)) : null;
    }

    public Long getMinFromEndTime() {
        return (this.endTime != null && !this.endTime.isEmpty()) ? Long.parseLong(Splitter.on(':').splitToList(this.endTime).get(1)) : null;
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
        public Teller getTeller() {
        return this.teller;
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

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Cashier setOffice(final Object office) {
        this.officeId = OfficeAssociation.id(office);
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Cashier setStaff(final Object staff) {
        this.staffId = StaffAssociation.id(staff);
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Cashier setTeller(final Teller teller) {
        this.teller = teller;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Cashier setDescription(final String description) {
        this.description = description;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Cashier setStartDate(final LocalDate startDate) {
        this.startDate = startDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Cashier setEndDate(final LocalDate endDate) {
        this.endDate = endDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Cashier setIsFullDay(final Boolean isFullDay) {
        this.isFullDay = isFullDay;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Cashier setStartTime(final String startTime) {
        this.startTime = startTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Cashier setEndTime(final String endTime) {
        this.endTime = endTime;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public Cashier() {
    }

    @java.lang.SuppressWarnings("all")
        public Cashier(final Object office, final Object staff, final Teller teller, final String description, final LocalDate startDate, final LocalDate endDate, final Boolean isFullDay, final String startTime, final String endTime) {
        this.officeId = OfficeAssociation.id(office);
        this.staffId = StaffAssociation.id(staff);
        this.teller = teller;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isFullDay = isFullDay;
        this.startTime = startTime;
        this.endTime = endTime;
    }
}
