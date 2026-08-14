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

import java.time.LocalDate;
import org.apache.fineract.infrastructure.jobs.domain.JobExecutionRepository;
import org.springframework.stereotype.Service;

@Service
public class JobExecutionQueryPortAdapter implements JobExecutionQueryPort {

    private final JobExecutionRepository jobExecutionRepository;

    public JobExecutionQueryPortAdapter(final JobExecutionRepository jobExecutionRepository) {
        this.jobExecutionRepository = jobExecutionRepository;
    }

    @Override
    public LocalDate getBusinessDateOfRunningJobByExecutionParameter(final String jobName, final String jobCustomParamKeyName,
            final String parameterKeyName, final String parameterValue, final String dateParameterName) {
        return jobExecutionRepository.getBusinessDateOfRunningJobByExecutionParameter(jobName, jobCustomParamKeyName, parameterKeyName,
                parameterValue, dateParameterName);
    }
}
