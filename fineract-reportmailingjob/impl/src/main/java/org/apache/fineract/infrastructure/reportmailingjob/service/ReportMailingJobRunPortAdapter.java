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
package org.apache.fineract.infrastructure.reportmailingjob.service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang3.StringUtils;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.reportmailingjob.data.DueReportMailingJob;
import org.apache.fineract.infrastructure.reportmailingjob.data.ReportMailingJobPreviousRunStatus;
import org.apache.fineract.infrastructure.reportmailingjob.domain.ReportMailingJob;
import org.apache.fineract.infrastructure.reportmailingjob.domain.ReportMailingJobRepository;
import org.apache.fineract.infrastructure.reportmailingjob.domain.ReportMailingJobRunHistory;
import org.apache.fineract.infrastructure.reportmailingjob.domain.ReportMailingJobRunHistoryRepository;
import org.apache.fineract.portfolio.calendar.service.CalendarUtils;
import org.springframework.stereotype.Service;

@Service
public class ReportMailingJobRunPortAdapter implements ReportMailingJobRunPort {

    private static final String DATETIME_FORMAT = "yyyy-MM-dd HH:mm:ss";

    private final ReportMailingJobRepository reportMailingJobRepository;
    private final ReportMailingJobRunHistoryRepository reportMailingJobRunHistoryRepository;

    public ReportMailingJobRunPortAdapter(final ReportMailingJobRepository reportMailingJobRepository,
            final ReportMailingJobRunHistoryRepository reportMailingJobRunHistoryRepository) {
        this.reportMailingJobRepository = reportMailingJobRepository;
        this.reportMailingJobRunHistoryRepository = reportMailingJobRunHistoryRepository;
    }

    @Override
    public List<DueReportMailingJob> findDueJobs() {
        final LocalDateTime now = DateUtils.getLocalDateTimeOfTenant();
        final List<DueReportMailingJob> due = new ArrayList<>();
        for (final ReportMailingJob job : reportMailingJobRepository.findByIsActiveTrueAndIsDeletedFalse()) {
            final LocalDateTime nextRunDateTime = job.getNextRunDateTime();
            if (nextRunDateTime != null && DateUtils.isBefore(nextRunDateTime, now)) {
                due.add(new DueReportMailingJob(job.getId(), job.getEmailAttachmentFileFormat(), job.getStretchyReportId(),
                        job.getStretchyReportParamMap(), job.getEmailRecipients(), job.getEmailMessage(), job.getEmailSubject(),
                        job.getRecurrence()));
            }
        }
        return due;
    }

    @Override
    public void recordRun(final Long jobId, final LocalDateTime jobStart, final boolean success, final String errorLog) {
        final ReportMailingJob job = reportMailingJobRepository.findById(jobId).orElse(null);
        if (job == null) {
            return;
        }
        final ReportMailingJobPreviousRunStatus status = success ? ReportMailingJobPreviousRunStatus.SUCCESS
                : ReportMailingJobPreviousRunStatus.ERROR;
        job.setPreviousRunErrorLog(success ? null : errorLog);
        job.increaseNumberOfRunsByOne();
        job.setPreviousRunStatus(status.getValue());
        job.setPreviousRunDateTime(job.getNextRunDateTime());
        if (StringUtils.isEmpty(job.getRecurrence())) {
            job.setActive(false);
            job.setNextRunDateTime(null);
        } else if (job.getNextRunDateTime() != null) {
            job.setNextRunDateTime(nextRecurringDateTime(job.getRecurrence(), job.getNextRunDateTime()));
        }
        reportMailingJobRepository.save(job);
        final String errorLogToString = success ? null : errorLog;
        reportMailingJobRunHistoryRepository.save(ReportMailingJobRunHistory.newInstance(job, jobStart, DateUtils.getLocalDateTimeOfTenant(),
                status.getValue(), null, errorLogToString));
    }

    private static LocalDateTime nextRecurringDateTime(final String recurrencePattern, final LocalDateTime startDateTime) {
        if (StringUtils.isBlank(recurrencePattern) || startDateTime == null) {
            return null;
        }
        final LocalDate nextDayLocalDate = startDateTime.plus(Duration.ofDays(1)).toLocalDate();
        final LocalDate nextRecurringLocalDate = CalendarUtils.getNextRecurringDate(recurrencePattern, startDateTime.toLocalDate(),
                nextDayLocalDate);
        final String nextDateTimeString = nextRecurringLocalDate + " " + startDateTime.getHour() + ":" + startDateTime.getMinute() + ":"
                + startDateTime.getSecond();
        return LocalDateTime.parse(nextDateTimeString, DateTimeFormatter.ofPattern(DATETIME_FORMAT));
    }
}
