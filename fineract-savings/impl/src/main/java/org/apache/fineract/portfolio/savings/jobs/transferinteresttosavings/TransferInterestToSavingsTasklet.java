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
package org.apache.fineract.portfolio.savings.jobs.transferinteresttosavings;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.apache.fineract.infrastructure.core.exception.PlatformApiDataValidationException;
import org.apache.fineract.infrastructure.jobs.exception.JobExecutionException;
import org.apache.fineract.portfolio.savings.data.InterestTransferData;
import org.apache.fineract.portfolio.savings.exception.InsufficientAccountBalanceException;
import org.apache.fineract.portfolio.savings.service.DepositAccountInterestTransferReadService;
import org.apache.fineract.portfolio.savings.service.InterestTransferWritePort;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

public class TransferInterestToSavingsTasklet implements Tasklet {
    @java.lang.SuppressWarnings("all")
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(TransferInterestToSavingsTasklet.class);
    private final DepositAccountInterestTransferReadService depositAccountInterestTransferReadService;
    private final InterestTransferWritePort interestTransferWritePort;

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        List<Throwable> errors = new ArrayList<>();
        Collection<InterestTransferData> interestTransfers = depositAccountInterestTransferReadService.retrieveDataForInterestTransfer();
        for (InterestTransferData interestTransfer : interestTransfers) {
            try {
                interestTransferWritePort.transferInterest(interestTransfer);
            } catch (final PlatformApiDataValidationException e) {
                log.error("Validation exception while trasfering Interest from {} to {}", interestTransfer.getFromAccountId(),
                        interestTransfer.getToAccountId(), e);
                errors.add(e);
            } catch (final InsufficientAccountBalanceException e) {
                log.warn("InsufficientAccountBalanceException while trasfering Interest from {} to {} ",
                        interestTransfer.getFromAccountId(), interestTransfer.getToAccountId(), e);
                errors.add(e);
            }
        }
        if (!errors.isEmpty()) {
            throw new JobExecutionException(errors);
        }
        return RepeatStatus.FINISHED;
    }

    @java.lang.SuppressWarnings("all")
    public TransferInterestToSavingsTasklet(final DepositAccountInterestTransferReadService depositAccountInterestTransferReadService,
            final InterestTransferWritePort interestTransferWritePort) {
        this.depositAccountInterestTransferReadService = depositAccountInterestTransferReadService;
        this.interestTransferWritePort = interestTransferWritePort;
    }
}
