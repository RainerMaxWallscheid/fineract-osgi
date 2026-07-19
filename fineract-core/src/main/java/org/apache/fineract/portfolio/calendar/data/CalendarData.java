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
package org.apache.fineract.portfolio.calendar.data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.OffsetDateTime;
import java.util.Collection;
import java.util.List;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.portfolio.calendar.domain.CalendarFrequencyType;
import org.apache.fineract.portfolio.calendar.domain.CalendarRemindBy;
import org.apache.fineract.portfolio.calendar.domain.CalendarType;
import org.apache.fineract.portfolio.calendar.domain.CalendarWeekDaysType;
import org.apache.fineract.portfolio.calendar.service.CalendarEnumerations;
import org.apache.fineract.portfolio.calendar.service.CalendarUtils;
import org.apache.fineract.portfolio.common.domain.NthDayType;

public final class CalendarData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private Long calendarInstanceId;
    private Long entityId;
    private EnumOptionData entityType;
    private String title;
    private String description;
    private String location;
    private LocalDate startDate;
    private LocalDate endDate;
    private LocalTime meetingTime;
    private Integer duration;
    private EnumOptionData type;
    private boolean repeating;
    private String recurrence;
    private EnumOptionData frequency;
    private Integer interval;
    private EnumOptionData repeatsOnDay;
    private EnumOptionData repeatsOnNthDayOfMonth;
    private EnumOptionData remindBy;
    private Integer firstReminder;
    private Integer secondReminder;
    private Collection<LocalDate> recurringDates;
    private Collection<LocalDate> nextTenRecurringDates;
    private String humanReadable;
    private LocalDate recentEligibleMeetingDate;
    private OffsetDateTime createdDate;
    private OffsetDateTime lastUpdatedDate;
    private Long createdByUserId;
    private String createdByUsername;
    private Long lastUpdatedByUserId;
    private String lastUpdatedByUsername;
    private Integer repeatsOnDayOfMonth;
    // template related
    private List<EnumOptionData> entityTypeOptions;
    private List<EnumOptionData> calendarTypeOptions;
    private List<EnumOptionData> remindByOptions;
    private List<EnumOptionData> frequencyOptions;
    private List<EnumOptionData> repeatsOnDayOptions;
    private List<EnumOptionData> frequencyNthDayTypeOptions;
    // import fields
    private Integer rowIndex;
    private String dateFormat;
    private String locale;
    private String centerId;
    private String typeId;

    public static CalendarData importInstanceNoRepeatsOnDay(LocalDate startDate, boolean repeating, EnumOptionData frequency, Integer interval, Integer rowIndex, String locale, String dateFormat) {
        return new CalendarData(startDate, repeating, frequency, interval, rowIndex, locale, dateFormat);
    }

    public static CalendarData importInstanceWithRepeatsOnDay(LocalDate startDate, boolean repeating, EnumOptionData frequency, Integer interval, EnumOptionData repeatsOnDay, Integer rowIndex, String locale, String dateFormat) {
        return new CalendarData(startDate, repeating, frequency, interval, repeatsOnDay, rowIndex, locale, dateFormat);
    }

    private CalendarData(LocalDate startDate, boolean repeating, EnumOptionData frequency, Integer interval, Integer rowIndex, String locale, String dateFormat) {
        this.startDate = startDate;
        this.repeating = repeating;
        this.frequency = frequency;
        this.interval = interval;
        this.rowIndex = rowIndex;
        this.dateFormat = dateFormat;
        this.locale = locale;
        this.description = "";
        this.typeId = "4";
        this.id = null;
        this.calendarInstanceId = null;
        this.entityId = null;
        this.entityType = null;
        this.title = null;
        this.location = null;
        this.endDate = null;
        this.meetingTime = null;
        this.type = null;
        this.recurrence = null;
        this.repeatsOnDay = null;
        this.repeatsOnNthDayOfMonth = null;
        this.remindBy = null;
        this.firstReminder = null;
        this.secondReminder = null;
        this.recurringDates = null;
        this.nextTenRecurringDates = null;
        this.humanReadable = null;
        this.recentEligibleMeetingDate = null;
        this.createdDate = null;
        this.lastUpdatedDate = null;
        this.createdByUserId = null;
        this.createdByUsername = null;
        this.lastUpdatedByUserId = null;
        this.lastUpdatedByUsername = null;
        this.repeatsOnDayOfMonth = null;
        this.entityTypeOptions = null;
        this.calendarTypeOptions = null;
        this.remindByOptions = null;
        this.frequencyOptions = null;
        this.repeatsOnDayOptions = null;
        this.frequencyNthDayTypeOptions = null;
        this.duration = null;
    }

    private CalendarData(LocalDate startDate, boolean repeating, EnumOptionData frequency, Integer interval, EnumOptionData repeatsOnDay, Integer rowIndex, String locale, String dateFormat) {
        this.startDate = startDate;
        this.repeating = repeating;
        this.frequency = frequency;
        this.interval = interval;
        this.repeatsOnDay = repeatsOnDay;
        this.rowIndex = rowIndex;
        this.dateFormat = dateFormat;
        this.locale = locale;
        this.description = "";
        this.typeId = "1";
        this.id = null;
        this.calendarInstanceId = null;
        this.entityId = null;
        this.entityType = null;
        this.title = null;
        this.location = null;
        this.endDate = null;
        this.meetingTime = null;
        this.type = null;
        this.recurrence = null;
        this.repeatsOnNthDayOfMonth = null;
        this.remindBy = null;
        this.firstReminder = null;
        this.secondReminder = null;
        this.recurringDates = null;
        this.nextTenRecurringDates = null;
        this.humanReadable = null;
        this.recentEligibleMeetingDate = null;
        this.createdDate = null;
        this.lastUpdatedDate = null;
        this.createdByUserId = null;
        this.createdByUsername = null;
        this.lastUpdatedByUserId = null;
        this.lastUpdatedByUsername = null;
        this.repeatsOnDayOfMonth = null;
        this.entityTypeOptions = null;
        this.calendarTypeOptions = null;
        this.remindByOptions = null;
        this.frequencyOptions = null;
        this.repeatsOnDayOptions = null;
        this.frequencyNthDayTypeOptions = null;
        this.duration = null;
    }

    public CalendarData(String title, String description, LocalDate startDate, boolean repeating, EnumOptionData frequency, Integer interval, EnumOptionData repeatsOnDay, String dateFormat, String locale, String typeId) {
        this.title = title;
        this.description = description;
        this.startDate = startDate;
        this.repeating = repeating;
        this.frequency = frequency;
        this.interval = interval;
        this.repeatsOnDay = repeatsOnDay;
        this.dateFormat = dateFormat;
        this.locale = locale;
        this.typeId = typeId;
    }

    public void setCenterId(String centerId) {
        this.centerId = centerId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public static CalendarData instance(final Long id, final Long calendarInstanceId, final Long entityId, final EnumOptionData entityType, final String title, final String description, final String location, final LocalDate startDate, final LocalDate endDate, final Integer duration, final EnumOptionData type, final boolean repeating, final String recurrence, final EnumOptionData frequency, final Integer interval, final EnumOptionData repeatsOnDay, final EnumOptionData repeatsOnNthDayOfMonth, final EnumOptionData remindBy, final Integer firstReminder, final Integer secondReminder, final String humanReadable, final OffsetDateTime createdDate, final OffsetDateTime lastUpdatedDate, final Long createdByUserId, final String createdByUsername, final Long lastUpdatedByUserId, final String lastUpdatedByUsername, final LocalTime meetingTime, final Integer repeatsOnDayOfMonth) {
        final Collection<LocalDate> recurringDates = null;
        final Collection<LocalDate> nextTenRecurringDates = null;
        final LocalDate recentEligibleMeetingDate = null;
        final List<EnumOptionData> entityTypeOptions = null;
        final List<EnumOptionData> calendarTypeOptions = null;
        final List<EnumOptionData> remindByOptions = null;
        final List<EnumOptionData> frequencyOptions = null;
        final List<EnumOptionData> repeatsOnDayOptions = null;
        final List<EnumOptionData> frequencyNthDayTypeOptions = null;
        return new CalendarData(id, calendarInstanceId, entityId, entityType, title, description, location, startDate, endDate, duration, type, repeating, recurrence, frequency, interval, repeatsOnDay, repeatsOnNthDayOfMonth, remindBy, firstReminder, secondReminder, recurringDates, nextTenRecurringDates, humanReadable, recentEligibleMeetingDate, createdDate, lastUpdatedDate, createdByUserId, createdByUsername, lastUpdatedByUserId, lastUpdatedByUsername, repeatsOnDayOfMonth, entityTypeOptions, calendarTypeOptions, remindByOptions, frequencyOptions, repeatsOnDayOptions, meetingTime, frequencyNthDayTypeOptions);
    }

    public static CalendarData withRecurringDates(final CalendarData calendarData, final Collection<LocalDate> recurringDates, final Collection<LocalDate> nextTenRecurringDates, final LocalDate recentEligibleMeetingDate) {
        return new CalendarData(calendarData.id, calendarData.calendarInstanceId, calendarData.entityId, calendarData.entityType, calendarData.title, calendarData.description, calendarData.location, calendarData.startDate, calendarData.endDate, calendarData.duration, calendarData.type, calendarData.repeating, calendarData.recurrence, calendarData.frequency, calendarData.interval, calendarData.repeatsOnDay, calendarData.repeatsOnNthDayOfMonth, calendarData.remindBy, calendarData.firstReminder, calendarData.secondReminder, recurringDates, nextTenRecurringDates, calendarData.humanReadable, recentEligibleMeetingDate, calendarData.createdDate, calendarData.lastUpdatedDate, calendarData.createdByUserId, calendarData.createdByUsername, calendarData.lastUpdatedByUserId, calendarData.lastUpdatedByUsername, calendarData.repeatsOnDayOfMonth, calendarData.entityTypeOptions, calendarData.calendarTypeOptions, calendarData.remindByOptions, calendarData.frequencyOptions, calendarData.repeatsOnDayOptions, calendarData.meetingTime, calendarData.frequencyNthDayTypeOptions);
    }

    public static CalendarData withRecentEligibleMeetingDate(final CalendarData calendarData, final LocalDate recentEligibleMeetingDate) {
        return new CalendarData(calendarData.id, calendarData.calendarInstanceId, calendarData.entityId, calendarData.entityType, calendarData.title, calendarData.description, calendarData.location, calendarData.startDate, calendarData.endDate, calendarData.duration, calendarData.type, calendarData.repeating, calendarData.recurrence, calendarData.frequency, calendarData.interval, calendarData.repeatsOnDay, calendarData.repeatsOnNthDayOfMonth, calendarData.remindBy, calendarData.firstReminder, calendarData.secondReminder, calendarData.recurringDates, calendarData.nextTenRecurringDates, calendarData.humanReadable, recentEligibleMeetingDate, calendarData.createdDate, calendarData.lastUpdatedDate, calendarData.createdByUserId, calendarData.createdByUsername, calendarData.lastUpdatedByUserId, calendarData.lastUpdatedByUsername, calendarData.repeatsOnDayOfMonth, calendarData.entityTypeOptions, calendarData.calendarTypeOptions, calendarData.remindByOptions, calendarData.frequencyOptions, calendarData.repeatsOnDayOptions, calendarData.meetingTime, calendarData.frequencyNthDayTypeOptions);
    }

    public static CalendarData sensibleDefaultsForNewCalendarCreation() {
        final Long id = null;
        final Long calendarInstanceId = null;
        final Long entityId = null;
        final EnumOptionData entityType = null;
        final String title = null;
        final String description = null;
        final String location = null;
        final LocalDate startDate = null;
        final LocalDate endDate = null;
        final Integer duration = 0;
        final EnumOptionData type = CalendarEnumerations.calendarType(CalendarType.COLLECTION);
        final boolean repeating = false;
        final String recurrence = null;
        final EnumOptionData frequency = CalendarEnumerations.calendarFrequencyType(CalendarFrequencyType.DAILY);
        final Integer interval = 1;
        final EnumOptionData repeatsOnDay = CalendarEnumerations.calendarWeekDaysType(CalendarWeekDaysType.MO);
        final EnumOptionData repeatsOnNthDayOfMonth = CalendarEnumerations.calendarFrequencyNthDayType(NthDayType.ONE);
        final EnumOptionData remindBy = CalendarEnumerations.calendarRemindBy(CalendarRemindBy.EMAIL);
        final Integer firstReminder = 0;
        final Integer secondReminder = 0;
        final String humanReadable = null;
        final Collection<LocalDate> recurringDates = null;
        final Collection<LocalDate> nextTenRecurringDates = null;
        final LocalDate recentEligibleMeetingDate = null;
        final List<EnumOptionData> entityTypeOptions = null;
        final List<EnumOptionData> calendarTypeOptions = null;
        final List<EnumOptionData> remindByOptions = null;
        final List<EnumOptionData> frequencyOptions = null;
        final List<EnumOptionData> repeatsOnDayOptions = null;
        final List<EnumOptionData> frequencyNthDayTypeOptions = null;
        final OffsetDateTime createdDate = null;
        final OffsetDateTime lastUpdatedDate = null;
        final Long createdByUserId = null;
        final String createdByUsername = null;
        final Long lastUpdatedByUserId = null;
        final String lastUpdatedByUsername = null;
        final LocalTime meetingTime = null;
        final Integer repeatsOnDayOfMonth = null;
        return new CalendarData(id, calendarInstanceId, entityId, entityType, title, description, location, startDate, endDate, duration, type, repeating, recurrence, frequency, interval, repeatsOnDay, repeatsOnNthDayOfMonth, remindBy, firstReminder, secondReminder, recurringDates, nextTenRecurringDates, humanReadable, recentEligibleMeetingDate, createdDate, lastUpdatedDate, createdByUserId, createdByUsername, lastUpdatedByUserId, lastUpdatedByUsername, repeatsOnDayOfMonth, entityTypeOptions, calendarTypeOptions, remindByOptions, frequencyOptions, repeatsOnDayOptions, meetingTime, frequencyNthDayTypeOptions);
    }

    public static CalendarData withTemplateOptions(final CalendarData calendarData, final List<EnumOptionData> entityTypeOptions, final List<EnumOptionData> calendarTypeOptions, final List<EnumOptionData> remindByOptions, final List<EnumOptionData> repeatsOptions, final List<EnumOptionData> repeatsOnDayOptions, final List<EnumOptionData> frequencyNthDayTypeOptions) {
        return new CalendarData(calendarData.id, calendarData.calendarInstanceId, calendarData.entityId, calendarData.entityType, calendarData.title, calendarData.description, calendarData.location, calendarData.startDate, calendarData.endDate, calendarData.duration, calendarData.type, calendarData.repeating, calendarData.recurrence, calendarData.frequency, calendarData.interval, calendarData.repeatsOnDay, calendarData.repeatsOnNthDayOfMonth, calendarData.remindBy, calendarData.firstReminder, calendarData.secondReminder, calendarData.recurringDates, calendarData.nextTenRecurringDates, calendarData.humanReadable, calendarData.recentEligibleMeetingDate, calendarData.createdDate, calendarData.lastUpdatedDate, calendarData.createdByUserId, calendarData.createdByUsername, calendarData.lastUpdatedByUserId, calendarData.lastUpdatedByUsername, calendarData.repeatsOnDayOfMonth, entityTypeOptions, calendarTypeOptions, remindByOptions, repeatsOptions, repeatsOnDayOptions, calendarData.meetingTime, frequencyNthDayTypeOptions);
    }

    private CalendarData(final Long id, final Long calendarInstanceId, final Long entityId, final EnumOptionData entityType, final String title, final String description, final String location, final LocalDate startDate, final LocalDate endDate, final Integer duration, final EnumOptionData type, final boolean repeating, final String recurrence, final EnumOptionData frequency, final Integer interval, final EnumOptionData repeatsOnDay, final EnumOptionData repeatsOnNthDayOfMonth, final EnumOptionData remindBy, final Integer firstReminder, final Integer secondReminder, final Collection<LocalDate> recurringDates, final Collection<LocalDate> nextTenRecurringDates, final String humanReadable, final LocalDate recentEligibleMeetingDate, final OffsetDateTime createdDate, final OffsetDateTime lastUpdatedDate, final Long createdByUserId, final String createdByUsername, final Long lastUpdatedByUserId, final String lastUpdatedByUsername, final Integer repeatsOnDayOfMonth, final List<EnumOptionData> entityTypeOptions, final List<EnumOptionData> calendarTypeOptions, final List<EnumOptionData> remindByOptions, final List<EnumOptionData> repeatsOptions, final List<EnumOptionData> repeatsOnDayOptions, final LocalTime meetingTime, final List<EnumOptionData> frequencyNthDayTypeOptions) {
        this.id = id;
        this.calendarInstanceId = calendarInstanceId;
        this.entityId = entityId;
        this.entityType = entityType;
        this.title = title;
        this.description = description;
        this.location = location;
        this.startDate = startDate;
        this.endDate = endDate;
        this.duration = duration;
        this.type = type;
        this.repeating = repeating;
        this.recurrence = recurrence;
        this.frequency = frequency;
        this.interval = interval;
        this.repeatsOnDay = repeatsOnDay;
        this.repeatsOnNthDayOfMonth = repeatsOnNthDayOfMonth;
        this.remindBy = remindBy;
        this.firstReminder = firstReminder;
        this.secondReminder = secondReminder;
        this.recurringDates = recurringDates;
        this.nextTenRecurringDates = nextTenRecurringDates;
        this.humanReadable = humanReadable;
        this.recentEligibleMeetingDate = recentEligibleMeetingDate;
        this.createdDate = createdDate;
        this.lastUpdatedDate = lastUpdatedDate;
        this.createdByUserId = createdByUserId;
        this.createdByUsername = createdByUsername;
        this.lastUpdatedByUserId = lastUpdatedByUserId;
        this.lastUpdatedByUsername = lastUpdatedByUsername;
        this.repeatsOnDayOfMonth = repeatsOnDayOfMonth;
        this.entityTypeOptions = entityTypeOptions;
        this.calendarTypeOptions = calendarTypeOptions;
        this.remindByOptions = remindByOptions;
        this.frequencyOptions = repeatsOptions;
        this.repeatsOnDayOptions = repeatsOnDayOptions;
        this.meetingTime = meetingTime;
        this.frequencyNthDayTypeOptions = frequencyNthDayTypeOptions;
    }

    public boolean isStartDateBeforeOrEqual(final LocalDate compareDate) {
        return this.startDate != null && compareDate != null && !DateUtils.isAfter(this.startDate, compareDate);
    }

    public boolean isEndDateAfterOrEqual(final LocalDate compareDate) {
        return this.endDate != null && compareDate != null && !DateUtils.isBefore(this.endDate, compareDate);
    }

    public boolean isBetweenStartAndEndDate(final LocalDate compareDate) {
        return isStartDateBeforeOrEqual(compareDate) && (this.endDate == null || isEndDateAfterOrEqual(compareDate));
    }

    public boolean isValidRecurringDate(final LocalDate compareDate, final Boolean isSkipMeetingOnFirstDay, final Integer numberOfDays) {
        if (isBetweenStartAndEndDate(compareDate)) {
            return CalendarUtils.isValidRecurringDate(this.getRecurrence(), this.getStartDate(), compareDate, isSkipMeetingOnFirstDay, numberOfDays);
        }
        return false;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCalendarInstanceId() {
        return this.calendarInstanceId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getEntityId() {
        return this.entityId;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getEntityType() {
        return this.entityType;
    }

    @java.lang.SuppressWarnings("all")
        public String getTitle() {
        return this.title;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocation() {
        return this.location;
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
        public LocalTime getMeetingTime() {
        return this.meetingTime;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getDuration() {
        return this.duration;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isRepeating() {
        return this.repeating;
    }

    @java.lang.SuppressWarnings("all")
        public String getRecurrence() {
        return this.recurrence;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getFrequency() {
        return this.frequency;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getInterval() {
        return this.interval;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getRepeatsOnDay() {
        return this.repeatsOnDay;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getRepeatsOnNthDayOfMonth() {
        return this.repeatsOnNthDayOfMonth;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getRemindBy() {
        return this.remindBy;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getFirstReminder() {
        return this.firstReminder;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getSecondReminder() {
        return this.secondReminder;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LocalDate> getRecurringDates() {
        return this.recurringDates;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<LocalDate> getNextTenRecurringDates() {
        return this.nextTenRecurringDates;
    }

    @java.lang.SuppressWarnings("all")
        public String getHumanReadable() {
        return this.humanReadable;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getRecentEligibleMeetingDate() {
        return this.recentEligibleMeetingDate;
    }

    @java.lang.SuppressWarnings("all")
        public OffsetDateTime getCreatedDate() {
        return this.createdDate;
    }

    @java.lang.SuppressWarnings("all")
        public OffsetDateTime getLastUpdatedDate() {
        return this.lastUpdatedDate;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCreatedByUserId() {
        return this.createdByUserId;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreatedByUsername() {
        return this.createdByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLastUpdatedByUserId() {
        return this.lastUpdatedByUserId;
    }

    @java.lang.SuppressWarnings("all")
        public String getLastUpdatedByUsername() {
        return this.lastUpdatedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRepeatsOnDayOfMonth() {
        return this.repeatsOnDayOfMonth;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getEntityTypeOptions() {
        return this.entityTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getCalendarTypeOptions() {
        return this.calendarTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getRemindByOptions() {
        return this.remindByOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getFrequencyOptions() {
        return this.frequencyOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getRepeatsOnDayOptions() {
        return this.repeatsOnDayOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<EnumOptionData> getFrequencyNthDayTypeOptions() {
        return this.frequencyNthDayTypeOptions;
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
        public String getCenterId() {
        return this.centerId;
    }

    @java.lang.SuppressWarnings("all")
        public String getTypeId() {
        return this.typeId;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setCalendarInstanceId(final Long calendarInstanceId) {
        this.calendarInstanceId = calendarInstanceId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setEntityId(final Long entityId) {
        this.entityId = entityId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setEntityType(final EnumOptionData entityType) {
        this.entityType = entityType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setDescription(final String description) {
        this.description = description;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setLocation(final String location) {
        this.location = location;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setStartDate(final LocalDate startDate) {
        this.startDate = startDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setEndDate(final LocalDate endDate) {
        this.endDate = endDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setMeetingTime(final LocalTime meetingTime) {
        this.meetingTime = meetingTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setDuration(final Integer duration) {
        this.duration = duration;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setType(final EnumOptionData type) {
        this.type = type;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setRepeating(final boolean repeating) {
        this.repeating = repeating;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setRecurrence(final String recurrence) {
        this.recurrence = recurrence;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setFrequency(final EnumOptionData frequency) {
        this.frequency = frequency;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setInterval(final Integer interval) {
        this.interval = interval;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setRepeatsOnDay(final EnumOptionData repeatsOnDay) {
        this.repeatsOnDay = repeatsOnDay;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setRepeatsOnNthDayOfMonth(final EnumOptionData repeatsOnNthDayOfMonth) {
        this.repeatsOnNthDayOfMonth = repeatsOnNthDayOfMonth;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setRemindBy(final EnumOptionData remindBy) {
        this.remindBy = remindBy;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setFirstReminder(final Integer firstReminder) {
        this.firstReminder = firstReminder;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setSecondReminder(final Integer secondReminder) {
        this.secondReminder = secondReminder;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setRecurringDates(final Collection<LocalDate> recurringDates) {
        this.recurringDates = recurringDates;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setNextTenRecurringDates(final Collection<LocalDate> nextTenRecurringDates) {
        this.nextTenRecurringDates = nextTenRecurringDates;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setHumanReadable(final String humanReadable) {
        this.humanReadable = humanReadable;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setRecentEligibleMeetingDate(final LocalDate recentEligibleMeetingDate) {
        this.recentEligibleMeetingDate = recentEligibleMeetingDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setCreatedDate(final OffsetDateTime createdDate) {
        this.createdDate = createdDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setLastUpdatedDate(final OffsetDateTime lastUpdatedDate) {
        this.lastUpdatedDate = lastUpdatedDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setCreatedByUserId(final Long createdByUserId) {
        this.createdByUserId = createdByUserId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setCreatedByUsername(final String createdByUsername) {
        this.createdByUsername = createdByUsername;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setLastUpdatedByUserId(final Long lastUpdatedByUserId) {
        this.lastUpdatedByUserId = lastUpdatedByUserId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setLastUpdatedByUsername(final String lastUpdatedByUsername) {
        this.lastUpdatedByUsername = lastUpdatedByUsername;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setRepeatsOnDayOfMonth(final Integer repeatsOnDayOfMonth) {
        this.repeatsOnDayOfMonth = repeatsOnDayOfMonth;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setEntityTypeOptions(final List<EnumOptionData> entityTypeOptions) {
        this.entityTypeOptions = entityTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setCalendarTypeOptions(final List<EnumOptionData> calendarTypeOptions) {
        this.calendarTypeOptions = calendarTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setRemindByOptions(final List<EnumOptionData> remindByOptions) {
        this.remindByOptions = remindByOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setFrequencyOptions(final List<EnumOptionData> frequencyOptions) {
        this.frequencyOptions = frequencyOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setRepeatsOnDayOptions(final List<EnumOptionData> repeatsOnDayOptions) {
        this.repeatsOnDayOptions = repeatsOnDayOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setFrequencyNthDayTypeOptions(final List<EnumOptionData> frequencyNthDayTypeOptions) {
        this.frequencyNthDayTypeOptions = frequencyNthDayTypeOptions;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setRowIndex(final Integer rowIndex) {
        this.rowIndex = rowIndex;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setLocale(final String locale) {
        this.locale = locale;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CalendarData setTypeId(final String typeId) {
        this.typeId = typeId;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CalendarData)) return false;
        final CalendarData other = (CalendarData) o;
        if (this.isRepeating() != other.isRepeating()) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$calendarInstanceId = this.getCalendarInstanceId();
        final java.lang.Object other$calendarInstanceId = other.getCalendarInstanceId();
        if (this$calendarInstanceId == null ? other$calendarInstanceId != null : !this$calendarInstanceId.equals(other$calendarInstanceId)) return false;
        final java.lang.Object this$entityId = this.getEntityId();
        final java.lang.Object other$entityId = other.getEntityId();
        if (this$entityId == null ? other$entityId != null : !this$entityId.equals(other$entityId)) return false;
        final java.lang.Object this$duration = this.getDuration();
        final java.lang.Object other$duration = other.getDuration();
        if (this$duration == null ? other$duration != null : !this$duration.equals(other$duration)) return false;
        final java.lang.Object this$interval = this.getInterval();
        final java.lang.Object other$interval = other.getInterval();
        if (this$interval == null ? other$interval != null : !this$interval.equals(other$interval)) return false;
        final java.lang.Object this$firstReminder = this.getFirstReminder();
        final java.lang.Object other$firstReminder = other.getFirstReminder();
        if (this$firstReminder == null ? other$firstReminder != null : !this$firstReminder.equals(other$firstReminder)) return false;
        final java.lang.Object this$secondReminder = this.getSecondReminder();
        final java.lang.Object other$secondReminder = other.getSecondReminder();
        if (this$secondReminder == null ? other$secondReminder != null : !this$secondReminder.equals(other$secondReminder)) return false;
        final java.lang.Object this$createdByUserId = this.getCreatedByUserId();
        final java.lang.Object other$createdByUserId = other.getCreatedByUserId();
        if (this$createdByUserId == null ? other$createdByUserId != null : !this$createdByUserId.equals(other$createdByUserId)) return false;
        final java.lang.Object this$lastUpdatedByUserId = this.getLastUpdatedByUserId();
        final java.lang.Object other$lastUpdatedByUserId = other.getLastUpdatedByUserId();
        if (this$lastUpdatedByUserId == null ? other$lastUpdatedByUserId != null : !this$lastUpdatedByUserId.equals(other$lastUpdatedByUserId)) return false;
        final java.lang.Object this$repeatsOnDayOfMonth = this.getRepeatsOnDayOfMonth();
        final java.lang.Object other$repeatsOnDayOfMonth = other.getRepeatsOnDayOfMonth();
        if (this$repeatsOnDayOfMonth == null ? other$repeatsOnDayOfMonth != null : !this$repeatsOnDayOfMonth.equals(other$repeatsOnDayOfMonth)) return false;
        final java.lang.Object this$rowIndex = this.getRowIndex();
        final java.lang.Object other$rowIndex = other.getRowIndex();
        if (this$rowIndex == null ? other$rowIndex != null : !this$rowIndex.equals(other$rowIndex)) return false;
        final java.lang.Object this$entityType = this.getEntityType();
        final java.lang.Object other$entityType = other.getEntityType();
        if (this$entityType == null ? other$entityType != null : !this$entityType.equals(other$entityType)) return false;
        final java.lang.Object this$title = this.getTitle();
        final java.lang.Object other$title = other.getTitle();
        if (this$title == null ? other$title != null : !this$title.equals(other$title)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        final java.lang.Object this$location = this.getLocation();
        final java.lang.Object other$location = other.getLocation();
        if (this$location == null ? other$location != null : !this$location.equals(other$location)) return false;
        final java.lang.Object this$startDate = this.getStartDate();
        final java.lang.Object other$startDate = other.getStartDate();
        if (this$startDate == null ? other$startDate != null : !this$startDate.equals(other$startDate)) return false;
        final java.lang.Object this$endDate = this.getEndDate();
        final java.lang.Object other$endDate = other.getEndDate();
        if (this$endDate == null ? other$endDate != null : !this$endDate.equals(other$endDate)) return false;
        final java.lang.Object this$meetingTime = this.getMeetingTime();
        final java.lang.Object other$meetingTime = other.getMeetingTime();
        if (this$meetingTime == null ? other$meetingTime != null : !this$meetingTime.equals(other$meetingTime)) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final java.lang.Object this$recurrence = this.getRecurrence();
        final java.lang.Object other$recurrence = other.getRecurrence();
        if (this$recurrence == null ? other$recurrence != null : !this$recurrence.equals(other$recurrence)) return false;
        final java.lang.Object this$frequency = this.getFrequency();
        final java.lang.Object other$frequency = other.getFrequency();
        if (this$frequency == null ? other$frequency != null : !this$frequency.equals(other$frequency)) return false;
        final java.lang.Object this$repeatsOnDay = this.getRepeatsOnDay();
        final java.lang.Object other$repeatsOnDay = other.getRepeatsOnDay();
        if (this$repeatsOnDay == null ? other$repeatsOnDay != null : !this$repeatsOnDay.equals(other$repeatsOnDay)) return false;
        final java.lang.Object this$repeatsOnNthDayOfMonth = this.getRepeatsOnNthDayOfMonth();
        final java.lang.Object other$repeatsOnNthDayOfMonth = other.getRepeatsOnNthDayOfMonth();
        if (this$repeatsOnNthDayOfMonth == null ? other$repeatsOnNthDayOfMonth != null : !this$repeatsOnNthDayOfMonth.equals(other$repeatsOnNthDayOfMonth)) return false;
        final java.lang.Object this$remindBy = this.getRemindBy();
        final java.lang.Object other$remindBy = other.getRemindBy();
        if (this$remindBy == null ? other$remindBy != null : !this$remindBy.equals(other$remindBy)) return false;
        final java.lang.Object this$recurringDates = this.getRecurringDates();
        final java.lang.Object other$recurringDates = other.getRecurringDates();
        if (this$recurringDates == null ? other$recurringDates != null : !this$recurringDates.equals(other$recurringDates)) return false;
        final java.lang.Object this$nextTenRecurringDates = this.getNextTenRecurringDates();
        final java.lang.Object other$nextTenRecurringDates = other.getNextTenRecurringDates();
        if (this$nextTenRecurringDates == null ? other$nextTenRecurringDates != null : !this$nextTenRecurringDates.equals(other$nextTenRecurringDates)) return false;
        final java.lang.Object this$humanReadable = this.getHumanReadable();
        final java.lang.Object other$humanReadable = other.getHumanReadable();
        if (this$humanReadable == null ? other$humanReadable != null : !this$humanReadable.equals(other$humanReadable)) return false;
        final java.lang.Object this$recentEligibleMeetingDate = this.getRecentEligibleMeetingDate();
        final java.lang.Object other$recentEligibleMeetingDate = other.getRecentEligibleMeetingDate();
        if (this$recentEligibleMeetingDate == null ? other$recentEligibleMeetingDate != null : !this$recentEligibleMeetingDate.equals(other$recentEligibleMeetingDate)) return false;
        final java.lang.Object this$createdDate = this.getCreatedDate();
        final java.lang.Object other$createdDate = other.getCreatedDate();
        if (this$createdDate == null ? other$createdDate != null : !this$createdDate.equals(other$createdDate)) return false;
        final java.lang.Object this$lastUpdatedDate = this.getLastUpdatedDate();
        final java.lang.Object other$lastUpdatedDate = other.getLastUpdatedDate();
        if (this$lastUpdatedDate == null ? other$lastUpdatedDate != null : !this$lastUpdatedDate.equals(other$lastUpdatedDate)) return false;
        final java.lang.Object this$createdByUsername = this.getCreatedByUsername();
        final java.lang.Object other$createdByUsername = other.getCreatedByUsername();
        if (this$createdByUsername == null ? other$createdByUsername != null : !this$createdByUsername.equals(other$createdByUsername)) return false;
        final java.lang.Object this$lastUpdatedByUsername = this.getLastUpdatedByUsername();
        final java.lang.Object other$lastUpdatedByUsername = other.getLastUpdatedByUsername();
        if (this$lastUpdatedByUsername == null ? other$lastUpdatedByUsername != null : !this$lastUpdatedByUsername.equals(other$lastUpdatedByUsername)) return false;
        final java.lang.Object this$entityTypeOptions = this.getEntityTypeOptions();
        final java.lang.Object other$entityTypeOptions = other.getEntityTypeOptions();
        if (this$entityTypeOptions == null ? other$entityTypeOptions != null : !this$entityTypeOptions.equals(other$entityTypeOptions)) return false;
        final java.lang.Object this$calendarTypeOptions = this.getCalendarTypeOptions();
        final java.lang.Object other$calendarTypeOptions = other.getCalendarTypeOptions();
        if (this$calendarTypeOptions == null ? other$calendarTypeOptions != null : !this$calendarTypeOptions.equals(other$calendarTypeOptions)) return false;
        final java.lang.Object this$remindByOptions = this.getRemindByOptions();
        final java.lang.Object other$remindByOptions = other.getRemindByOptions();
        if (this$remindByOptions == null ? other$remindByOptions != null : !this$remindByOptions.equals(other$remindByOptions)) return false;
        final java.lang.Object this$frequencyOptions = this.getFrequencyOptions();
        final java.lang.Object other$frequencyOptions = other.getFrequencyOptions();
        if (this$frequencyOptions == null ? other$frequencyOptions != null : !this$frequencyOptions.equals(other$frequencyOptions)) return false;
        final java.lang.Object this$repeatsOnDayOptions = this.getRepeatsOnDayOptions();
        final java.lang.Object other$repeatsOnDayOptions = other.getRepeatsOnDayOptions();
        if (this$repeatsOnDayOptions == null ? other$repeatsOnDayOptions != null : !this$repeatsOnDayOptions.equals(other$repeatsOnDayOptions)) return false;
        final java.lang.Object this$frequencyNthDayTypeOptions = this.getFrequencyNthDayTypeOptions();
        final java.lang.Object other$frequencyNthDayTypeOptions = other.getFrequencyNthDayTypeOptions();
        if (this$frequencyNthDayTypeOptions == null ? other$frequencyNthDayTypeOptions != null : !this$frequencyNthDayTypeOptions.equals(other$frequencyNthDayTypeOptions)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$centerId = this.getCenterId();
        final java.lang.Object other$centerId = other.getCenterId();
        if (this$centerId == null ? other$centerId != null : !this$centerId.equals(other$centerId)) return false;
        final java.lang.Object this$typeId = this.getTypeId();
        final java.lang.Object other$typeId = other.getTypeId();
        if (this$typeId == null ? other$typeId != null : !this$typeId.equals(other$typeId)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isRepeating() ? 79 : 97);
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $calendarInstanceId = this.getCalendarInstanceId();
        result = result * PRIME + ($calendarInstanceId == null ? 43 : $calendarInstanceId.hashCode());
        final java.lang.Object $entityId = this.getEntityId();
        result = result * PRIME + ($entityId == null ? 43 : $entityId.hashCode());
        final java.lang.Object $duration = this.getDuration();
        result = result * PRIME + ($duration == null ? 43 : $duration.hashCode());
        final java.lang.Object $interval = this.getInterval();
        result = result * PRIME + ($interval == null ? 43 : $interval.hashCode());
        final java.lang.Object $firstReminder = this.getFirstReminder();
        result = result * PRIME + ($firstReminder == null ? 43 : $firstReminder.hashCode());
        final java.lang.Object $secondReminder = this.getSecondReminder();
        result = result * PRIME + ($secondReminder == null ? 43 : $secondReminder.hashCode());
        final java.lang.Object $createdByUserId = this.getCreatedByUserId();
        result = result * PRIME + ($createdByUserId == null ? 43 : $createdByUserId.hashCode());
        final java.lang.Object $lastUpdatedByUserId = this.getLastUpdatedByUserId();
        result = result * PRIME + ($lastUpdatedByUserId == null ? 43 : $lastUpdatedByUserId.hashCode());
        final java.lang.Object $repeatsOnDayOfMonth = this.getRepeatsOnDayOfMonth();
        result = result * PRIME + ($repeatsOnDayOfMonth == null ? 43 : $repeatsOnDayOfMonth.hashCode());
        final java.lang.Object $rowIndex = this.getRowIndex();
        result = result * PRIME + ($rowIndex == null ? 43 : $rowIndex.hashCode());
        final java.lang.Object $entityType = this.getEntityType();
        result = result * PRIME + ($entityType == null ? 43 : $entityType.hashCode());
        final java.lang.Object $title = this.getTitle();
        result = result * PRIME + ($title == null ? 43 : $title.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        final java.lang.Object $location = this.getLocation();
        result = result * PRIME + ($location == null ? 43 : $location.hashCode());
        final java.lang.Object $startDate = this.getStartDate();
        result = result * PRIME + ($startDate == null ? 43 : $startDate.hashCode());
        final java.lang.Object $endDate = this.getEndDate();
        result = result * PRIME + ($endDate == null ? 43 : $endDate.hashCode());
        final java.lang.Object $meetingTime = this.getMeetingTime();
        result = result * PRIME + ($meetingTime == null ? 43 : $meetingTime.hashCode());
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final java.lang.Object $recurrence = this.getRecurrence();
        result = result * PRIME + ($recurrence == null ? 43 : $recurrence.hashCode());
        final java.lang.Object $frequency = this.getFrequency();
        result = result * PRIME + ($frequency == null ? 43 : $frequency.hashCode());
        final java.lang.Object $repeatsOnDay = this.getRepeatsOnDay();
        result = result * PRIME + ($repeatsOnDay == null ? 43 : $repeatsOnDay.hashCode());
        final java.lang.Object $repeatsOnNthDayOfMonth = this.getRepeatsOnNthDayOfMonth();
        result = result * PRIME + ($repeatsOnNthDayOfMonth == null ? 43 : $repeatsOnNthDayOfMonth.hashCode());
        final java.lang.Object $remindBy = this.getRemindBy();
        result = result * PRIME + ($remindBy == null ? 43 : $remindBy.hashCode());
        final java.lang.Object $recurringDates = this.getRecurringDates();
        result = result * PRIME + ($recurringDates == null ? 43 : $recurringDates.hashCode());
        final java.lang.Object $nextTenRecurringDates = this.getNextTenRecurringDates();
        result = result * PRIME + ($nextTenRecurringDates == null ? 43 : $nextTenRecurringDates.hashCode());
        final java.lang.Object $humanReadable = this.getHumanReadable();
        result = result * PRIME + ($humanReadable == null ? 43 : $humanReadable.hashCode());
        final java.lang.Object $recentEligibleMeetingDate = this.getRecentEligibleMeetingDate();
        result = result * PRIME + ($recentEligibleMeetingDate == null ? 43 : $recentEligibleMeetingDate.hashCode());
        final java.lang.Object $createdDate = this.getCreatedDate();
        result = result * PRIME + ($createdDate == null ? 43 : $createdDate.hashCode());
        final java.lang.Object $lastUpdatedDate = this.getLastUpdatedDate();
        result = result * PRIME + ($lastUpdatedDate == null ? 43 : $lastUpdatedDate.hashCode());
        final java.lang.Object $createdByUsername = this.getCreatedByUsername();
        result = result * PRIME + ($createdByUsername == null ? 43 : $createdByUsername.hashCode());
        final java.lang.Object $lastUpdatedByUsername = this.getLastUpdatedByUsername();
        result = result * PRIME + ($lastUpdatedByUsername == null ? 43 : $lastUpdatedByUsername.hashCode());
        final java.lang.Object $entityTypeOptions = this.getEntityTypeOptions();
        result = result * PRIME + ($entityTypeOptions == null ? 43 : $entityTypeOptions.hashCode());
        final java.lang.Object $calendarTypeOptions = this.getCalendarTypeOptions();
        result = result * PRIME + ($calendarTypeOptions == null ? 43 : $calendarTypeOptions.hashCode());
        final java.lang.Object $remindByOptions = this.getRemindByOptions();
        result = result * PRIME + ($remindByOptions == null ? 43 : $remindByOptions.hashCode());
        final java.lang.Object $frequencyOptions = this.getFrequencyOptions();
        result = result * PRIME + ($frequencyOptions == null ? 43 : $frequencyOptions.hashCode());
        final java.lang.Object $repeatsOnDayOptions = this.getRepeatsOnDayOptions();
        result = result * PRIME + ($repeatsOnDayOptions == null ? 43 : $repeatsOnDayOptions.hashCode());
        final java.lang.Object $frequencyNthDayTypeOptions = this.getFrequencyNthDayTypeOptions();
        result = result * PRIME + ($frequencyNthDayTypeOptions == null ? 43 : $frequencyNthDayTypeOptions.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $centerId = this.getCenterId();
        result = result * PRIME + ($centerId == null ? 43 : $centerId.hashCode());
        final java.lang.Object $typeId = this.getTypeId();
        result = result * PRIME + ($typeId == null ? 43 : $typeId.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CalendarData(id=" + this.getId() + ", calendarInstanceId=" + this.getCalendarInstanceId() + ", entityId=" + this.getEntityId() + ", entityType=" + this.getEntityType() + ", title=" + this.getTitle() + ", description=" + this.getDescription() + ", location=" + this.getLocation() + ", startDate=" + this.getStartDate() + ", endDate=" + this.getEndDate() + ", meetingTime=" + this.getMeetingTime() + ", duration=" + this.getDuration() + ", type=" + this.getType() + ", repeating=" + this.isRepeating() + ", recurrence=" + this.getRecurrence() + ", frequency=" + this.getFrequency() + ", interval=" + this.getInterval() + ", repeatsOnDay=" + this.getRepeatsOnDay() + ", repeatsOnNthDayOfMonth=" + this.getRepeatsOnNthDayOfMonth() + ", remindBy=" + this.getRemindBy() + ", firstReminder=" + this.getFirstReminder() + ", secondReminder=" + this.getSecondReminder() + ", recurringDates=" + this.getRecurringDates() + ", nextTenRecurringDates=" + this.getNextTenRecurringDates() + ", humanReadable=" + this.getHumanReadable() + ", recentEligibleMeetingDate=" + this.getRecentEligibleMeetingDate() + ", createdDate=" + this.getCreatedDate() + ", lastUpdatedDate=" + this.getLastUpdatedDate() + ", createdByUserId=" + this.getCreatedByUserId() + ", createdByUsername=" + this.getCreatedByUsername() + ", lastUpdatedByUserId=" + this.getLastUpdatedByUserId() + ", lastUpdatedByUsername=" + this.getLastUpdatedByUsername() + ", repeatsOnDayOfMonth=" + this.getRepeatsOnDayOfMonth() + ", entityTypeOptions=" + this.getEntityTypeOptions() + ", calendarTypeOptions=" + this.getCalendarTypeOptions() + ", remindByOptions=" + this.getRemindByOptions() + ", frequencyOptions=" + this.getFrequencyOptions() + ", repeatsOnDayOptions=" + this.getRepeatsOnDayOptions() + ", frequencyNthDayTypeOptions=" + this.getFrequencyNthDayTypeOptions() + ", rowIndex=" + this.getRowIndex() + ", dateFormat=" + this.getDateFormat() + ", locale=" + this.getLocale() + ", centerId=" + this.getCenterId() + ", typeId=" + this.getTypeId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CalendarData() {
    }
}
