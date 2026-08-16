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
package org.apache.fineract.portfolio.account.jobs.executestandinginstructions;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.apache.fineract.infrastructure.core.exception.AbstractPlatformServiceUnavailableException;
import org.apache.fineract.infrastructure.core.exception.PlatformApiDataValidationException;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.core.service.database.DatabaseSpecificSQLGenerator;
import org.apache.fineract.infrastructure.jobs.exception.JobExecutionException;
import org.apache.fineract.portfolio.account.PortfolioAccountType;
import org.apache.fineract.portfolio.account.data.AccountTransferFundsData;
import org.apache.fineract.portfolio.account.data.StandingInstructionData;
import org.apache.fineract.portfolio.account.data.StandingInstructionDuesData;
import org.apache.fineract.portfolio.account.domain.AccountTransferRecurrenceType;
import org.apache.fineract.portfolio.account.domain.StandingInstructionStatus;
import org.apache.fineract.portfolio.account.domain.StandingInstructionType;
import org.apache.fineract.portfolio.account.service.AccountTransferFundsWritePort;
import org.apache.fineract.portfolio.account.service.StandingInstructionReadPlatformService;
import org.apache.fineract.portfolio.common.domain.PeriodFrequencyType;
import org.apache.fineract.portfolio.savings.exception.InsufficientAccountBalanceException;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.jdbc.core.JdbcTemplate;

public class ExecuteStandingInstructionsTasklet implements Tasklet {
    @java.lang.SuppressWarnings("all")
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(ExecuteStandingInstructionsTasklet.class);
    private final StandingInstructionReadPlatformService standingInstructionReadPlatformService;
    private final JdbcTemplate jdbcTemplate;
    private final DatabaseSpecificSQLGenerator sqlGenerator;
    private final AccountTransferFundsWritePort accountTransferFundsWritePort;

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        Collection<StandingInstructionData> instructionData = standingInstructionReadPlatformService
                .retrieveAll(StandingInstructionStatus.ACTIVE.getValue());
        List<Throwable> errors = new ArrayList<>();
        for (StandingInstructionData data : instructionData) {
            boolean isDueForTransfer = false;
            AccountTransferRecurrenceType recurrenceType = data.getRecurrenceType();
            StandingInstructionType instructionType = data.getInstructionType();
            LocalDate transactionDate = DateUtils.getBusinessLocalDate();
            if (recurrenceType.isPeriodicRecurrence()) {
                PeriodFrequencyType frequencyType = data.getRecurrenceFrequency();
                LocalDate startDate = data.getValidFrom();
                if (frequencyType.isMonthly()) {
                    startDate = startDate.withDayOfMonth(data.getRecurrenceOnDay());
                    if (DateUtils.isBefore(startDate, data.getValidFrom())) {
                        startDate = startDate.plusMonths(1);
                    }
                } else if (frequencyType.isYearly()) {
                    startDate = startDate.withDayOfMonth(data.getRecurrenceOnDay()).withMonth(data.getRecurrenceOnMonth());
                    if (DateUtils.isBefore(startDate, data.getValidFrom())) {
                        startDate = startDate.plusYears(1);
                    }
                }
                isDueForTransfer = isDateFallsInSchedule(frequencyType, data.getRecurrenceInterval(), startDate, transactionDate);
            }
            BigDecimal transactionAmount = data.getAmount();
            if (PortfolioAccountType.LOAN.equals(data.getToAccountType())
                    && (recurrenceType.isDuesRecurrence() || (isDueForTransfer && instructionType.isDuesAmoutTransfer()))) {
                StandingInstructionDuesData standingInstructionDuesData = standingInstructionReadPlatformService
                        .retriveLoanDuesData(data.getToAccount().getId());
                if (data.getInstructionType().isDuesAmoutTransfer()) {
                    transactionAmount = standingInstructionDuesData.totalDueAmount();
                }
                if (recurrenceType.isDuesRecurrence()) {
                    isDueForTransfer = isDueForTransfer(standingInstructionDuesData);
                }
            }
            if (isDueForTransfer && transactionAmount != null && transactionAmount.compareTo(BigDecimal.ZERO) > 0) {
                final boolean isRegularTransaction = true;
                final boolean isExceptionForBalanceCheck = false;
                final AccountTransferFundsData fundsData = new AccountTransferFundsData(transactionDate, transactionAmount,
                        data.getFromAccountType(), data.getToAccountType(), data.getFromAccount().getId(), data.getToAccount().getId(),
                        data.getName() + " Standing instruction trasfer ", data.toTransferType(), null, null,
                        data.getTransferType().getValue(), isRegularTransaction, isExceptionForBalanceCheck);
                final boolean transferCompleted = transferAmount(errors, fundsData, data.getId());
                if (transferCompleted) {
                    final String updateQuery = "UPDATE m_account_transfer_standing_instructions SET last_run_date = ? where id = ?";
                    jdbcTemplate.update(updateQuery, transactionDate, data.getId());
                }
            }
        }
        if (!errors.isEmpty()) {
            throw new JobExecutionException(errors);
        }
        return RepeatStatus.FINISHED;
    }

    private boolean transferAmount(final List<Throwable> errors, final AccountTransferFundsData fundsData, final Long instructionId) {
        boolean transferCompleted = true;
        StringBuilder errorLog = new StringBuilder();
        StringBuilder updateQuery = new StringBuilder(
                "INSERT INTO m_account_transfer_standing_instructions_history (standing_instruction_id, " + sqlGenerator.escape("status")
                        + ", amount,execution_time, error_log) VALUES (");
        try {
            accountTransferFundsWritePort.transferFunds(fundsData);
        } catch (final PlatformApiDataValidationException e) {
            errors.add(new Exception("Validation exception while transfering funds for standing Instruction id" + instructionId + " from "
                    + fundsData.getFromAccountId() + " to " + fundsData.getToAccountId(), e));
            errorLog.append("Validation exception while trasfering funds ").append(e.getDefaultUserMessage());
        } catch (final InsufficientAccountBalanceException e) {
            errors.add(new Exception("InsufficientAccountBalance Exception while trasfering funds for standing Instruction id"
                    + instructionId + " from " + fundsData.getFromAccountId() + " to " + fundsData.getToAccountId(), e));
            errorLog.append("InsufficientAccountBalance Exception ");
        } catch (final AbstractPlatformServiceUnavailableException e) {
            errors.add(new Exception("Platform exception while trasfering funds for standing Instruction id" + instructionId + " from "
                    + fundsData.getFromAccountId() + " to " + fundsData.getToAccountId(), e));
            errorLog.append("Platform exception while trasfering funds ").append(e.getDefaultUserMessage());
        } catch (Exception e) {
            errors.add(new Exception("Unhandled System Exception while trasfering funds for standing Instruction id" + instructionId
                    + " from " + fundsData.getFromAccountId() + " to " + fundsData.getToAccountId(), e));
            errorLog.append("Exception while trasfering funds ").append(e.getMessage());
        }
        updateQuery.append(instructionId).append(",");
        if (errorLog.length() > 0) {
            transferCompleted = false;
            updateQuery.append("\'failed\'").append(",");
        } else {
            updateQuery.append("\'success\'").append(",");
        }
        updateQuery.append(fundsData.getTransactionAmount().doubleValue());
        updateQuery.append(", now(),");
        updateQuery.append("\'").append(errorLog).append("\')");
        jdbcTemplate.update(updateQuery.toString());
        return transferCompleted;
    }

    public boolean isDueForTransfer(StandingInstructionDuesData standingInstructionDuesData) {
        return standingInstructionDuesData.dueDate() != null
                && !standingInstructionDuesData.dueDate().isAfter(LocalDate.now(DateUtils.getDateTimeZoneOfTenant()));
    }

    /**
     * Schedule membership check previously delegated to leftover loan
     * {@code DefaultScheduledDateGenerator}.
     */
    private static boolean isDateFallsInSchedule(final PeriodFrequencyType frequency, final int repaidEvery, final LocalDate startDate,
            final LocalDate date) {
        boolean isScheduledDate = false;
        switch (frequency) {
            case DAYS:
                int diff = DateUtils.getExactDifferenceInDays(startDate, date);
                isScheduledDate = (diff % repaidEvery) == 0;
            break;
            case WEEKS:
                int weekDiff = DateUtils.getExactDifference(startDate, date, ChronoUnit.WEEKS);
                isScheduledDate = (weekDiff % repaidEvery) == 0;
                if (isScheduledDate) {
                    LocalDate modifiedDate = startDate.plusWeeks(weekDiff);
                    isScheduledDate = DateUtils.isEqual(modifiedDate, date);
                }
            break;
            case MONTHS:
                int monthDiff = DateUtils.getExactDifference(startDate, date, ChronoUnit.MONTHS);
                isScheduledDate = (monthDiff % repaidEvery) == 0;
                if (isScheduledDate) {
                    LocalDate modifiedDate = startDate.plusMonths(monthDiff);
                    isScheduledDate = DateUtils.isEqual(modifiedDate, date);
                }
            break;
            case YEARS:
                int yearDiff = DateUtils.getExactDifference(startDate, date, ChronoUnit.YEARS);
                isScheduledDate = (yearDiff % repaidEvery) == 0;
                if (isScheduledDate) {
                    LocalDate modifiedDate = startDate.plusYears(yearDiff);
                    isScheduledDate = DateUtils.isEqual(modifiedDate, date);
                }
            break;
            case INVALID:
            break;
            case WHOLE_TERM:
            break;
        }
        return isScheduledDate;
    }

    @java.lang.SuppressWarnings("all")
    public ExecuteStandingInstructionsTasklet(final StandingInstructionReadPlatformService standingInstructionReadPlatformService,
            final JdbcTemplate jdbcTemplate, final DatabaseSpecificSQLGenerator sqlGenerator,
            final AccountTransferFundsWritePort accountTransferFundsWritePort) {
        this.standingInstructionReadPlatformService = standingInstructionReadPlatformService;
        this.jdbcTemplate = jdbcTemplate;
        this.sqlGenerator = sqlGenerator;
        this.accountTransferFundsWritePort = accountTransferFundsWritePort;
    }
}
