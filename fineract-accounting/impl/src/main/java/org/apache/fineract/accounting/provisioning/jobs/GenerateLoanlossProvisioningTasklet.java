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
package org.apache.fineract.accounting.provisioning.jobs;

import java.time.LocalDate;
import org.apache.fineract.accounting.provisioning.exception.ProvisioningEntryAlreadyCreatedException;
import org.apache.fineract.accounting.provisioning.service.ProvisioningEntriesWritePlatformService;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.organisation.provisioning.moduleapi.ProvisioningExistencePort;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

public class GenerateLoanlossProvisioningTasklet implements Tasklet {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(GenerateLoanlossProvisioningTasklet.class);
    private final ProvisioningExistencePort provisioningExistencePort;
    private final ProvisioningEntriesWritePlatformService provisioningEntriesWritePlatformService;

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        LocalDate currentDate = DateUtils.getBusinessLocalDate();
        boolean addJournalEntries = true;
        try {
            if (provisioningExistencePort.hasAnyCriteria()) {
                provisioningEntriesWritePlatformService.createProvisioningEntry(currentDate, addJournalEntries);
            }
        } catch (ProvisioningEntryAlreadyCreatedException e) {
            log.error("Provisioning entry already created", e);
        } catch (Exception e) {
            log.error("Problem occurred when generating provisioning entries", e);
        }
        return RepeatStatus.FINISHED;
    }

    @java.lang.SuppressWarnings("all")
        public GenerateLoanlossProvisioningTasklet(final ProvisioningExistencePort provisioningExistencePort, final ProvisioningEntriesWritePlatformService provisioningEntriesWritePlatformService) {
        this.provisioningExistencePort = provisioningExistencePort;
        this.provisioningEntriesWritePlatformService = provisioningEntriesWritePlatformService;
    }
}
