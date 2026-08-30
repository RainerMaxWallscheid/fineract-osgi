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
package org.apache.fineract.cob.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.apache.fineract.cob.COBConstant;
import org.apache.fineract.cob.data.COBIdAndLastClosedBusinessDate;
import org.apache.fineract.infrastructure.businessdate.domain.BusinessDateType;
import org.apache.fineract.infrastructure.core.config.TaskExecutorConstant;
import org.apache.fineract.infrastructure.core.domain.FineractContext;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.core.service.ThreadLocalContextUtil;
import org.apache.fineract.infrastructure.jobs.data.JobParameterDTO;
import org.apache.fineract.infrastructure.jobs.exception.JobNotFoundException;
import org.apache.fineract.infrastructure.jobs.service.NamedJobLaunchPort;
import org.apache.fineract.infrastructure.jobs.service.SchedulerServiceConstants;
import org.springframework.scheduling.annotation.Async;

public abstract class AsyncCommonCOBExecutorService implements AsyncCOBExecutorService {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(AsyncCommonCOBExecutorService.class);
    private final NamedJobLaunchPort jobLaunchPort;
    private final RetrieveIdService retrieveIdService;

    @Override
    @Async(TaskExecutorConstant.LOAN_COB_CATCH_UP_TASK_EXECUTOR_BEAN_NAME)
    public void executeLoanCOBCatchUpAsync(FineractContext context) {
        try {
            ThreadLocalContextUtil.init(context);
            LocalDate cobBusinessDate = ThreadLocalContextUtil.getBusinessDateByType(BusinessDateType.COB_DATE);
            List<COBIdAndLastClosedBusinessDate> loanIdAndLastClosedBusinessDate = retrieveIdService.retrieveLoanIdsOldestCobProcessed(cobBusinessDate);
            LocalDate oldestCOBProcessedDate = !loanIdAndLastClosedBusinessDate.isEmpty() ? loanIdAndLastClosedBusinessDate.get(0).getLastClosedBusinessDate() : cobBusinessDate;
            if (DateUtils.isBefore(oldestCOBProcessedDate, cobBusinessDate)) {
                executeLoanCOBDayByDayUntilCOBBusinessDate(oldestCOBProcessedDate, cobBusinessDate);
            }
        } catch (JobNotFoundException e) {
            // Throwing an error here is useless as it will be swallowed hence it is async method
            log.error("Job not found: {}", getJobName(), e);
        } catch (RuntimeException e) {
            // Throwing an error here is useless as it will be swallowed hence it is async method
            log.error("Error executing job", e);
        } finally {
            ThreadLocalContextUtil.reset();
        }
    }

    public abstract String getJobName();

    public abstract String getJobHumanReadableName();

    private void executeLoanCOBDayByDayUntilCOBBusinessDate(LocalDate oldestCOBProcessedDate, LocalDate cobBusinessDate) {
        LocalDate executingBusinessDate = oldestCOBProcessedDate.plusDays(1);
        String tenantIdentifier = ThreadLocalContextUtil.getTenant().getTenantIdentifier();
        while (!DateUtils.isAfter(executingBusinessDate, cobBusinessDate)) {
            JobParameterDTO jobParameterDTO = new JobParameterDTO(COBConstant.BUSINESS_DATE_PARAMETER_NAME, executingBusinessDate.format(DateTimeFormatter.ISO_DATE));
            JobParameterDTO jobParameterCatchUpDTO = new JobParameterDTO(COBConstant.IS_CATCH_UP_PARAMETER_NAME, "true");
            JobParameterDTO tenantParameterDTO = new JobParameterDTO(SchedulerServiceConstants.TENANT_IDENTIFIER, tenantIdentifier);
            Set<JobParameterDTO> jobParameters = new HashSet<>();
            Collections.addAll(jobParameters, jobParameterDTO, jobParameterCatchUpDTO, tenantParameterDTO);
            jobLaunchPort.run(getJobName(), getJobHumanReadableName(), jobParameters, tenantIdentifier);
            executingBusinessDate = executingBusinessDate.plusDays(1);
        }
    }

    @java.lang.SuppressWarnings("all")
        public AsyncCommonCOBExecutorService(final NamedJobLaunchPort jobLaunchPort, final RetrieveIdService retrieveIdService) {
        this.jobLaunchPort = jobLaunchPort;
        this.retrieveIdService = retrieveIdService;
    }
}
