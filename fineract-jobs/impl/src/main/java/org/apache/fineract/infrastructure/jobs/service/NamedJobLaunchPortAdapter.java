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

import java.util.Set;
import org.apache.fineract.infrastructure.jobs.data.JobParameterDTO;
import org.apache.fineract.infrastructure.jobs.domain.ScheduledJobDetail;
import org.apache.fineract.infrastructure.jobs.domain.ScheduledJobDetailRepository;
import org.apache.fineract.infrastructure.jobs.exception.JobNotFoundException;
import org.quartz.JobExecutionException;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobParametersInvalidException;
import org.springframework.batch.core.configuration.JobLocator;
import org.springframework.batch.core.launch.NoSuchJobException;
import org.springframework.batch.core.repository.JobExecutionAlreadyRunningException;
import org.springframework.batch.core.repository.JobInstanceAlreadyCompleteException;
import org.springframework.batch.core.repository.JobRestartException;
import org.springframework.stereotype.Service;

@Service
public class NamedJobLaunchPortAdapter implements NamedJobLaunchPort {

    private final JobLocator jobLocator;
    private final ScheduledJobDetailRepository scheduledJobDetailRepository;
    private final JobStarter jobStarter;

    public NamedJobLaunchPortAdapter(final JobLocator jobLocator, final ScheduledJobDetailRepository scheduledJobDetailRepository,
            final JobStarter jobStarter) {
        this.jobLocator = jobLocator;
        this.scheduledJobDetailRepository = scheduledJobDetailRepository;
        this.jobStarter = jobStarter;
    }

    @Override
    public void run(final String jobName, final String humanReadableName, final Set<JobParameterDTO> parameters,
            final String tenantIdentifier) {
        try {
            final Job job = jobLocator.getJob(jobName);
            final ScheduledJobDetail scheduledJobDetail = scheduledJobDetailRepository.findByJobName(humanReadableName);
            if (scheduledJobDetail == null) {
                throw new JobNotFoundException(humanReadableName);
            }
            jobStarter.run(job, scheduledJobDetail, parameters, tenantIdentifier);
        } catch (final NoSuchJobException ex) {
            throw new JobNotFoundException(jobName, ex);
        } catch (final JobInstanceAlreadyCompleteException | JobRestartException | JobParametersInvalidException
                | JobExecutionAlreadyRunningException | JobExecutionException ex) {
            throw new IllegalStateException("Error executing job " + jobName, ex);
        }
    }
}
