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
import java.time.LocalDateTime;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResultBuilder;
import org.apache.fineract.infrastructure.core.exception.ErrorHandler;
import org.apache.fineract.infrastructure.core.exception.PlatformDataIntegrityException;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.reportmailingjob.ReportMailingJobConstants;
import org.apache.fineract.infrastructure.reportmailingjob.domain.ReportMailingJob;
import org.apache.fineract.infrastructure.reportmailingjob.domain.ReportMailingJobRepository;
import org.apache.fineract.infrastructure.reportmailingjob.domain.ReportMailingJobRepositoryWrapper;
import org.apache.fineract.infrastructure.reportmailingjob.validation.ReportMailingJobValidator;
import org.apache.fineract.infrastructure.security.service.PlatformSecurityContext;
import org.apache.fineract.portfolio.calendar.service.CalendarUtils;
import org.apache.fineract.useradministration.domain.AppUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.dao.NonTransientDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.jpa.JpaSystemException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ReportMailingJobWritePlatformServiceImpl implements ReportMailingJobWritePlatformService {

    private static final Logger LOG = LoggerFactory.getLogger(ReportMailingJobWritePlatformServiceImpl.class);
    private final JdbcTemplate jdbcTemplate;
    private final ReportMailingJobValidator reportMailingJobValidator;
    private final ReportMailingJobRepositoryWrapper reportMailingJobRepositoryWrapper;
    private final ReportMailingJobRepository reportMailingJobRepository;
    private final PlatformSecurityContext platformSecurityContext;

    @Autowired
    public ReportMailingJobWritePlatformServiceImpl(final JdbcTemplate jdbcTemplate,
            final ReportMailingJobValidator reportMailingJobValidator,
            final ReportMailingJobRepositoryWrapper reportMailingJobRepositoryWrapper,
            final PlatformSecurityContext platformSecurityContext) {
        this.jdbcTemplate = jdbcTemplate;
        this.reportMailingJobValidator = reportMailingJobValidator;
        this.reportMailingJobRepositoryWrapper = reportMailingJobRepositoryWrapper;
        this.reportMailingJobRepository = reportMailingJobRepositoryWrapper.getReportMailingJobRepository();
        this.platformSecurityContext = platformSecurityContext;
    }

    @Override
    @Transactional
    public CommandProcessingResult createReportMailingJob(JsonCommand jsonCommand) {
        try {
            this.reportMailingJobValidator.validateCreateRequest(jsonCommand);

            final AppUser appUser = this.platformSecurityContext.authenticatedUser();
            final Long stretchyReportId = jsonCommand.longValueOfParameterNamed(ReportMailingJobConstants.STRETCHY_REPORT_ID_PARAM_NAME);
            ensureStretchyReportExists(stretchyReportId);

            final ReportMailingJob reportMailingJob = ReportMailingJob.newInstance(jsonCommand, stretchyReportId, appUser);
            this.reportMailingJobRepository.saveAndFlush(reportMailingJob);

            return new CommandProcessingResultBuilder() //
                    .withCommandId(jsonCommand.commandId()) //
                    .withEntityId(reportMailingJob.getId()) //
                    .build();
        } catch (final JpaSystemException | DataIntegrityViolationException dve) {
            final Throwable throwable = dve.getMostSpecificCause();
            handleDataIntegrityIssues(jsonCommand, throwable, dve);

            return CommandProcessingResult.empty();
        }
    }

    @Override
    @Transactional
    public CommandProcessingResult updateReportMailingJob(Long reportMailingJobId, JsonCommand jsonCommand) {
        try {
            this.reportMailingJobValidator.validateUpdateRequest(jsonCommand);

            final ReportMailingJob reportMailingJob = this.reportMailingJobRepositoryWrapper
                    .findOneThrowExceptionIfNotFound(reportMailingJobId);

            final Map<String, Object> changes = reportMailingJob.update(jsonCommand);

            final String recurrence = reportMailingJob.getRecurrence();
            LocalDateTime nextRunDateTime = reportMailingJob.getNextRunDateTime();

            if (changes.containsKey(ReportMailingJobConstants.STRETCHY_REPORT_ID_PARAM_NAME)) {
                final Long stretchyReportId = (Long) changes.get(ReportMailingJobConstants.STRETCHY_REPORT_ID_PARAM_NAME);
                ensureStretchyReportExists(stretchyReportId);
                reportMailingJob.setStretchyReportId(stretchyReportId);
            }

            if (changes.containsKey(ReportMailingJobConstants.RECURRENCE_PARAM_NAME)) {
                if (StringUtils.isNotBlank(recurrence)) {
                    LocalDateTime startDateTime = DateUtils.getLocalDateTimeOfTenant();
                    if (changes.containsKey(ReportMailingJobConstants.START_DATE_TIME_PARAM_NAME)) {
                        startDateTime = reportMailingJob.getStartDateTime();
                    }
                    startDateTime = reportMailingJob.getStartDateTime();
                    final LocalDateTime nextRecurringDateTime = this.createNextRecurringDateTime(recurrence, startDateTime);
                    reportMailingJob.setNextRunDateTime(nextRecurringDateTime);
                } else if (StringUtils.isBlank(recurrence) && (nextRunDateTime != null)) {
                    reportMailingJob.setNextRunDateTime(null);
                }
            }

            if (changes.containsKey(ReportMailingJobConstants.START_DATE_TIME_PARAM_NAME)) {
                final LocalDateTime startDateTime = reportMailingJob.getStartDateTime();
                LocalDateTime nextRecurringDateTime = startDateTime;
                if (StringUtils.isNotBlank(recurrence)) {
                    nextRecurringDateTime = this.createNextRecurringDateTime(recurrence, startDateTime);
                }
                reportMailingJob.setNextRunDateTime(nextRecurringDateTime);
            }

            if (!changes.isEmpty()) {
                this.reportMailingJobRepository.saveAndFlush(reportMailingJob);
            }

            return new CommandProcessingResultBuilder() //
                    .withCommandId(jsonCommand.commandId()) //
                    .withEntityId(reportMailingJob.getId()) //
                    .with(changes) //
                    .build();
        } catch (final JpaSystemException | DataIntegrityViolationException dve) {
            final Throwable throwable = dve.getMostSpecificCause();
            handleDataIntegrityIssues(jsonCommand, throwable, dve);

            return CommandProcessingResult.empty();
        }
    }

    @Override
    @Transactional
    public CommandProcessingResult deleteReportMailingJob(Long reportMailingJobId) {
        final ReportMailingJob reportMailingJob = this.reportMailingJobRepositoryWrapper
                .findOneThrowExceptionIfNotFound(reportMailingJobId);
        reportMailingJob.delete();
        this.reportMailingJobRepository.save(reportMailingJob);

        return new CommandProcessingResultBuilder() //
                .withEntityId(reportMailingJobId) //
                .build();
    }

    private void ensureStretchyReportExists(final Long stretchyReportId) {
        if (stretchyReportId == null) {
            throw new PlatformDataIntegrityException("error.msg.report.parameter.id.invalid", "Stretchy report id is required",
                    ReportMailingJobConstants.STRETCHY_REPORT_ID_PARAM_NAME);
        }
        try {
            final Integer count = this.jdbcTemplate.queryForObject("select count(*) from stretchy_report where id = ?", Integer.class,
                    stretchyReportId);
            if (count == null || count == 0) {
                throw new PlatformDataIntegrityException("error.msg.report.parameter.id.invalid",
                        "Report Parameter with identifier " + stretchyReportId + " does not exist",
                        ReportMailingJobConstants.STRETCHY_REPORT_ID_PARAM_NAME, stretchyReportId);
            }
        } catch (final EmptyResultDataAccessException ex) {
            throw new PlatformDataIntegrityException("error.msg.report.parameter.id.invalid",
                    "Report Parameter with identifier " + stretchyReportId + " does not exist",
                    ReportMailingJobConstants.STRETCHY_REPORT_ID_PARAM_NAME, stretchyReportId);
        }
    }

    private LocalDateTime createNextRecurringDateTime(final String recurrencePattern, final LocalDateTime startDateTime) {
        LocalDateTime nextRecurringDateTime = null;
        if (StringUtils.isNotBlank(recurrencePattern) && startDateTime != null) {
            final LocalDateTime nextDayLocalDate = startDateTime.plus(Duration.ofDays(1));
            nextRecurringDateTime = CalendarUtils.getNextRecurringDate(recurrencePattern, startDateTime, nextDayLocalDate);
        }
        return nextRecurringDateTime;
    }

    private void handleDataIntegrityIssues(final JsonCommand jsonCommand, final Throwable realCause,
            final NonTransientDataAccessException dve) {
        if (realCause.getMessage().contains(ReportMailingJobConstants.NAME_PARAM_NAME)) {
            final String name = jsonCommand.stringValueOfParameterNamed(ReportMailingJobConstants.NAME_PARAM_NAME);
            throw new PlatformDataIntegrityException("error.msg.report.mailing.job.duplicate.name",
                    "Report mailing job with name `" + name + "` already exists", ReportMailingJobConstants.NAME_PARAM_NAME, name);
        }

        LOG.error("Error occured.", dve);
        throw ErrorHandler.getMappable(dve, "error.msg.charge.unknown.data.integrity.issue",
                "Unknown data integrity issue with resource: " + realCause.getMessage());
    }
}
