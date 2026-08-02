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
package org.apache.fineract.accounting.glaccount.jobs.updatetrialbalancedetails;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Date;
import java.util.List;
import org.apache.fineract.accounting.glaccount.domain.TrialBalance;
import org.apache.fineract.accounting.glaccount.domain.TrialBalanceRepository;
import org.apache.fineract.accounting.glaccount.domain.TrialBalanceRepositoryWrapper;
import org.apache.fineract.accounting.journalentry.domain.JournalEntryRepository;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.core.service.ThreadLocalContextUtil;
import org.apache.fineract.infrastructure.core.service.database.RoutingDataSourceServiceFactory;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.util.CollectionUtils;

public class UpdateTrialBalanceDetailsTasklet implements Tasklet {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(UpdateTrialBalanceDetailsTasklet.class);
    private final RoutingDataSourceServiceFactory dataSourceServiceFactory;
    private final TrialBalanceRepositoryWrapper trialBalanceRepositoryWrapper;
    private final TrialBalanceRepository trialBalanceRepository;
    private final JournalEntryRepository journalEntryRepository;

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        final JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSourceServiceFactory.determineDataSourceService().retrieveDataSource());
        processTrialBalanceGaps(jdbcTemplate);
        updateClosingBalances(jdbcTemplate);
        return RepeatStatus.FINISHED;
    }

    private void processTrialBalanceGaps(JdbcTemplate jdbcTemplate) {
        LocalDate maxCreatedDate = trialBalanceRepository.findMaxCreatedDate();
        LocalDate baselineDate = maxCreatedDate != null ? maxCreatedDate : LocalDate.of(2010, 1, 1);
        List<LocalDate> tbGaps = journalEntryRepository.findTransactionDatesAfter(baselineDate);
        for (LocalDate tbGap : tbGaps) {
            if (DateUtils.getExactDifferenceInDays(tbGap, DateUtils.getBusinessLocalDate()) < 1) {
                continue;
            }
            insertTrialBalanceForDate(tbGap);
        }
    }

    private void insertTrialBalanceForDate(LocalDate tbGap) {
        List<Object[]> rows = journalEntryRepository.findTrialBalanceLinesForDate(tbGap);
        List<TrialBalance> trialBalances = rows.stream().map(row -> {
            TrialBalance tb = new TrialBalance();
            tb.setOfficeId(toLong(row[0]));
            tb.setGlAccountId(toLong(row[1]));
            tb.setAmount(toBigDecimal(row[2]));
            // JPQL Object[] projections may return LocalDate, OffsetDateTime, Timestamp, etc.
            // (createdDate is typically a timestamp type — never cast blindly to LocalDate)
            tb.setEntryDate(toLocalDate(row[3]));
            tb.setTransactionDate(toLocalDate(row[4]));
            tb.setClosingBalance(toBigDecimal(row[5]));
            return tb;
        }).toList();
        trialBalanceRepositoryWrapper.save(trialBalances);
        log.debug("{}: Records affected by updateTrialBalanceDetails: {}", ThreadLocalContextUtil.getTenant().getName(), trialBalances.size());
    }

    /**
     * Coerce JPA/native projection date values to {@link LocalDate}.
     *
     * <p>
     * EclipseLink may materialize temporal columns as {@link OffsetDateTime}, {@link LocalDateTime},
     * {@link Timestamp}, etc. depending on mapping and JDBC driver — not only {@link LocalDate}.
     * </p>
     */
    static LocalDate toLocalDate(final Object value) {
        if (value == null) {
            return null;
        }
        if (value instanceof LocalDate localDate) {
            return localDate;
        }
        if (value instanceof LocalDateTime localDateTime) {
            return localDateTime.toLocalDate();
        }
        if (value instanceof OffsetDateTime offsetDateTime) {
            return offsetDateTime.toLocalDate();
        }
        if (value instanceof ZonedDateTime zonedDateTime) {
            return zonedDateTime.toLocalDate();
        }
        if (value instanceof Instant instant) {
            return LocalDate.ofInstant(instant, ZoneId.systemDefault());
        }
        if (value instanceof Timestamp timestamp) {
            return timestamp.toLocalDateTime().toLocalDate();
        }
        if (value instanceof java.sql.Date sqlDate) {
            return sqlDate.toLocalDate();
        }
        if (value instanceof Date date) {
            return date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        }
        throw new IllegalArgumentException("Cannot convert temporal value of type " + value.getClass().getName() + " to LocalDate");
    }

    static Long toLong(final Object value) {
        if (value == null) {
            return null;
        }
        if (value instanceof Long longValue) {
            return longValue;
        }
        if (value instanceof Number number) {
            return number.longValue();
        }
        throw new IllegalArgumentException("Cannot convert value of type " + value.getClass().getName() + " to Long");
    }

    static BigDecimal toBigDecimal(final Object value) {
        if (value == null) {
            return null;
        }
        if (value instanceof BigDecimal bigDecimal) {
            return bigDecimal;
        }
        if (value instanceof Number number) {
            return new BigDecimal(number.toString());
        }
        throw new IllegalArgumentException("Cannot convert value of type " + value.getClass().getName() + " to BigDecimal");
    }

    private void updateClosingBalances(JdbcTemplate jdbcTemplate) {
        final List<Long> officeIds = trialBalanceRepository.findDistinctOfficeIdsWithNullClosingBalance();
        for (Long officeId : officeIds) {
            updateClosingBalancesForOffice(jdbcTemplate, officeId);
        }
    }

    private void updateClosingBalancesForOffice(JdbcTemplate jdbcTemplate, Long officeId) {
        final List<Long> accountIds = trialBalanceRepository.findDistinctAccountIdsWithNullClosingBalanceByOfficeId(officeId);
        for (Long accountId : accountIds) {
            updateClosingBalanceForAccount(jdbcTemplate, officeId, accountId);
        }
    }

    private void updateClosingBalanceForAccount(JdbcTemplate jdbcTemplate, Long officeId, Long accountId) {
        BigDecimal closingBalance = getPreviousClosingBalance(officeId, accountId);
        List<TrialBalance> tbRows = trialBalanceRepositoryWrapper.findNewByOfficeAndAccount(officeId, accountId);
        updateTrialBalanceRows(tbRows, closingBalance);
    }

    private BigDecimal getPreviousClosingBalance(Long officeId, Long accountId) {
        List<BigDecimal> closingBalanceData = trialBalanceRepository.findLastClosingBalance(officeId, accountId);
        return CollectionUtils.isEmpty(closingBalanceData) ? BigDecimal.ZERO : closingBalanceData.getFirst();
    }

    private void updateTrialBalanceRows(List<TrialBalance> tbRows, BigDecimal initialClosingBalance) {
        BigDecimal closingBalance = initialClosingBalance;
        for (TrialBalance row : tbRows) {
            if (closingBalance != null) {
                closingBalance = closingBalance.add(row.getAmount());
            }
            row.setClosingBalance(closingBalance);
        }
    }

    @java.lang.SuppressWarnings("all")
        public UpdateTrialBalanceDetailsTasklet(final RoutingDataSourceServiceFactory dataSourceServiceFactory, final TrialBalanceRepositoryWrapper trialBalanceRepositoryWrapper, final TrialBalanceRepository trialBalanceRepository, final JournalEntryRepository journalEntryRepository) {
        this.dataSourceServiceFactory = dataSourceServiceFactory;
        this.trialBalanceRepositoryWrapper = trialBalanceRepositoryWrapper;
        this.trialBalanceRepository = trialBalanceRepository;
        this.journalEntryRepository = journalEntryRepository;
    }
}
