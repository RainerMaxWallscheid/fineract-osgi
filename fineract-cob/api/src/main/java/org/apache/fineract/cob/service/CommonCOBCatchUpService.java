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
import java.util.List;
import org.apache.fineract.cob.COBConstant;
import org.apache.fineract.cob.data.COBIdAndLastClosedBusinessDate;
import org.apache.fineract.cob.data.IsCatchUpRunningDTO;
import org.apache.fineract.cob.data.OldestCOBProcessedLoanDTO;
import org.apache.fineract.infrastructure.businessdate.domain.BusinessDateType;
import org.apache.fineract.infrastructure.core.domain.FineractContext;
import org.apache.fineract.infrastructure.core.service.ThreadLocalContextUtil;
import org.apache.fineract.infrastructure.jobs.service.JobExecutionQueryPort;

public abstract class CommonCOBCatchUpService<T> implements COBCatchUpService {
    private final AsyncCOBExecutorService asyncLoanCOBExecutorService;
    private final JobExecutionQueryPort jobExecutionQueryPort;
    private final RetrieveIdService retrieveIdService;
    private final AccountLockService<T> accountLockService;

    @Override
    public void unlockHardLockedLoans() {
        accountLockService.updateCobAndRemoveLocks();
    }

    @Override
    public OldestCOBProcessedLoanDTO getOldestCOBProcessedLoan() {
        List<COBIdAndLastClosedBusinessDate> loanIdAndLastClosedBusinessDate = retrieveIdService.retrieveLoanIdsOldestCobProcessed(ThreadLocalContextUtil.getBusinessDateByType(BusinessDateType.COB_DATE));
        OldestCOBProcessedLoanDTO oldestCOBProcessedLoanDTO = new OldestCOBProcessedLoanDTO();
        oldestCOBProcessedLoanDTO.setLoanIds(loanIdAndLastClosedBusinessDate.stream().map(COBIdAndLastClosedBusinessDate::getId).toList());
        oldestCOBProcessedLoanDTO.setCobProcessedDate(loanIdAndLastClosedBusinessDate.stream().map(COBIdAndLastClosedBusinessDate::getLastClosedBusinessDate).findFirst().orElse(ThreadLocalContextUtil.getBusinessDateByType(BusinessDateType.COB_DATE)));
        oldestCOBProcessedLoanDTO.setCobBusinessDate(ThreadLocalContextUtil.getBusinessDateByType(BusinessDateType.COB_DATE));
        return oldestCOBProcessedLoanDTO;
    }

    @Override
    public void executeLoanCOBCatchUp() {
        FineractContext context = ThreadLocalContextUtil.getContext();
        asyncLoanCOBExecutorService.executeLoanCOBCatchUpAsync(context);
    }

    @Override
    public IsCatchUpRunningDTO isCatchUpRunning() {
        LocalDate runningCatchUpBusinessDate = jobExecutionQueryPort.getBusinessDateOfRunningJobByExecutionParameter(getJobName(), COBConstant.COB_CUSTOM_JOB_PARAMETER_KEY, COBConstant.IS_CATCH_UP_PARAMETER_NAME, "true", COBConstant.BUSINESS_DATE_PARAMETER_NAME);
        return new IsCatchUpRunningDTO(runningCatchUpBusinessDate != null, runningCatchUpBusinessDate);
    }

    public abstract String getJobName();

    @java.lang.SuppressWarnings("all")
        public CommonCOBCatchUpService(final AsyncCOBExecutorService asyncLoanCOBExecutorService, final JobExecutionQueryPort jobExecutionQueryPort, final RetrieveIdService retrieveIdService, final AccountLockService<T> accountLockService) {
        this.asyncLoanCOBExecutorService = asyncLoanCOBExecutorService;
        this.jobExecutionQueryPort = jobExecutionQueryPort;
        this.retrieveIdService = retrieveIdService;
        this.accountLockService = accountLockService;
    }
}
