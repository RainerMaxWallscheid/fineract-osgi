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
package org.apache.fineract.infrastructure.jobs.service;

import java.util.List;
import org.apache.fineract.infrastructure.jobs.data.partitionedjobs.PartitionedJob;
import org.apache.fineract.infrastructure.jobs.domain.JobExecutionRepository;
import org.springframework.batch.core.launch.JobOperator;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.support.TransactionTemplate;

@Service
public class StuckJobExecutorServiceImpl implements StuckJobExecutorService {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(StuckJobExecutorServiceImpl.class);
    private final JobExecutionRepository jobExecutionRepository;
    @Qualifier("requiresNewTransactionJdbcTemplate")
    private final TransactionTemplate requiresNewTransactionJdbcTemplate;
    private final JobOperator jobOperator;

    @Override
    public void resumeStuckJob(String jobName) {
        List<Long> stuckJobIds = getStuckJobIds(jobName);
        if (isPartitionedJob(jobName) && areThereStuckJobs(jobName)) {
            restartPartitionedJobs(jobName, stuckJobIds);
        } else {
            restartTaskletJobs(stuckJobIds);
        }
    }

    private void restartTaskletJobs(List<Long> stuckJobIds) {
        stuckJobIds.forEach(this::handleStuckTaskletJob);
    }

    private void handleStuckTaskletJob(Long stuckJobId) {
        try {
            jobOperator.restart(stuckJobId);
        } catch (Exception e) {
            throw new RuntimeException("Exception while handling a stuck job", e);
        }
    }

    private void restartPartitionedJobs(String jobName, List<Long> stuckJobIds) {
        stuckJobIds.forEach(stuckJobId -> handleStuckPartitionedJob(stuckJobId, getPartitionerStepName(jobName)));
    }

    private boolean isPartitionedJob(String jobName) {
        return PartitionedJob.existsByJobName(jobName);
    }

    private String getPartitionerStepName(String name) {
        return PartitionedJob.valueOf(name).getPartitionerStepName();
    }

    private boolean areThereStuckJobs(String jobName) {
        Long stuckJobCount = jobExecutionRepository.getStuckJobCountByJobName(jobName);
        return stuckJobCount != 0L;
    }

    private List<Long> getStuckJobIds(String jobName) {
        return jobExecutionRepository.getStuckJobIdsByJobName(jobName);
    }

    private void handleStuckPartitionedJob(Long stuckJobId, String partitionerStepName) {
        try {
            waitUntilAllPartitionsFinished(stuckJobId, partitionerStepName);
            updateJobStatusToFailedInNewTransaction(stuckJobId, partitionerStepName);
            jobOperator.restart(stuckJobId);
        } catch (Exception e) {
            throw new RuntimeException("Exception while handling a stuck job", e);
        }
    }

    private void updateJobStatusToFailedInNewTransaction(Long stuckJobId, String partitionerStepName) {
        requiresNewTransactionJdbcTemplate.executeWithoutResult(status -> jobExecutionRepository.updateJobStatusToFailed(stuckJobId, partitionerStepName));
    }

    private void waitUntilAllPartitionsFinished(Long stuckJobId, String partitionerStepName) throws InterruptedException {
        while (!areAllPartitionsCompleted(stuckJobId, partitionerStepName)) {
            log.info("Sleeping for a second to wait for the partitions to complete for job {}", stuckJobId);
            Thread.sleep(1000);
        }
    }

    private boolean areAllPartitionsCompleted(Long stuckJobId, String partitionerStepName) {
        Long notCompletedPartitions = jobExecutionRepository.getNotCompletedPartitionsCount(stuckJobId, partitionerStepName);
        return notCompletedPartitions == 0L;
    }

    @java.lang.SuppressWarnings("all")
        public StuckJobExecutorServiceImpl(final JobExecutionRepository jobExecutionRepository, @Qualifier("requiresNewTransactionJdbcTemplate") final TransactionTemplate requiresNewTransactionJdbcTemplate, final JobOperator jobOperator) {
        this.jobExecutionRepository = jobExecutionRepository;
        this.requiresNewTransactionJdbcTemplate = requiresNewTransactionJdbcTemplate;
        this.jobOperator = jobOperator;
    }
}
