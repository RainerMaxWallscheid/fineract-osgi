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
package org.apache.fineract.infrastructure.jobs.service.aggregationjob;

import java.util.List;
import org.apache.fineract.infrastructure.jobs.service.aggregationjob.data.JournalEntryAggregationSummaryData;
import org.apache.fineract.infrastructure.jobs.service.aggregationjob.services.JournalEntryAggregationWriterService;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.StepExecutionListener;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.item.Chunk;
import org.springframework.batch.item.ItemWriter;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Component;

@Component
@StepScope
public class JournalEntryAggregationJobWriter implements ItemWriter<JournalEntryAggregationSummaryData>, StepExecutionListener {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(JournalEntryAggregationJobWriter.class);
    private final JournalEntryAggregationWriterService journalEntryAggregationWriterService;
    private StepExecution stepExecution;

    @Override
    public void beforeStep(@NonNull StepExecution stepExecution) {
        this.stepExecution = stepExecution;
    }

    @Override
    public void write(@NonNull Chunk<? extends JournalEntryAggregationSummaryData> journalEntrySummaries) {
        final Long jobExecutionId = stepExecution.getJobExecution().getId();
        List<JournalEntryAggregationSummaryData> summariesList = journalEntrySummaries.getItems().stream().map(item -> {
            item.setJobExecutionId(jobExecutionId);
            return (JournalEntryAggregationSummaryData) item;
        }).toList();
        journalEntryAggregationWriterService.insertJournalEntrySummaryBatch(summariesList);
    }

    @java.lang.SuppressWarnings("all")
        public JournalEntryAggregationJobWriter(final JournalEntryAggregationWriterService journalEntryAggregationWriterService) {
        this.journalEntryAggregationWriterService = journalEntryAggregationWriterService;
    }
}
