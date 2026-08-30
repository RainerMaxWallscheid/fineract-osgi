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
package org.apache.fineract.cob.processor;

import static org.apache.fineract.cob.data.BusinessStepNameAndOrder.getBusinessStepMap;
import java.time.LocalDate;
import java.util.Set;
import java.util.TreeMap;
import org.apache.fineract.cob.COBBusinessStepService;
import org.apache.fineract.cob.data.BusinessStepNameAndOrder;
import org.apache.fineract.cob.resolver.BusinessDateResolver;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.annotation.AfterStep;
import org.springframework.batch.item.ExecutionContext;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.lang.NonNull;

public abstract class AbstractItemProcessor<I extends AbstractPersistableCustom<Long>> implements ItemProcessor<I, I> {
    private final COBBusinessStepService cobBusinessStepService;
    private ExecutionContext executionContext;
    private LocalDate businessDate;

    @SuppressWarnings({"unchecked"})
    @Override
    public I process(@NonNull I item) throws Exception {
        Set<BusinessStepNameAndOrder> businessSteps = (Set<BusinessStepNameAndOrder>) executionContext.get("businessSteps");
        if (businessSteps == null) {
            throw new IllegalStateException("No business steps found in the execution context");
        }
        TreeMap<Long, String> businessStepMap = getBusinessStepMap(businessSteps);
        I alreadyProcessedLoan = cobBusinessStepService.run(businessStepMap, item);
        setLastRun(alreadyProcessedLoan);
        return alreadyProcessedLoan;
    }

    protected void setBusinessDate(StepExecution stepExecution) {
        businessDate = BusinessDateResolver.resolve(stepExecution);
    }

    @AfterStep
    public ExitStatus afterStep(@NonNull StepExecution stepExecution) {
        return ExitStatus.COMPLETED;
    }

    public abstract void setLastRun(I processedLoan);

    @java.lang.SuppressWarnings("all")
        public AbstractItemProcessor(final COBBusinessStepService cobBusinessStepService) {
        this.cobBusinessStepService = cobBusinessStepService;
    }

    @java.lang.SuppressWarnings("all")
        public void setExecutionContext(final ExecutionContext executionContext) {
        this.executionContext = executionContext;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getBusinessDate() {
        return this.businessDate;
    }
}
