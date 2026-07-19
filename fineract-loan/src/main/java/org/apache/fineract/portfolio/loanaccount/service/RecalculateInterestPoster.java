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
package org.apache.fineract.portfolio.loanaccount.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.concurrent.Callable;
import org.apache.fineract.infrastructure.core.domain.FineractContext;
import org.apache.fineract.infrastructure.core.service.ThreadLocalContextUtil;
import org.apache.fineract.infrastructure.jobs.exception.JobExecutionException;

public class RecalculateInterestPoster implements Callable<Void> {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(RecalculateInterestPoster.class);
    private Collection<Long> loanIds;
    private FineractContext fineractContext;
    private final LoanWritePlatformService loanWritePlatformService;

    @Override
    public Void call() throws JobExecutionException {
        if (loanIds.isEmpty()) {
            return null;
        }
        try {
            ThreadLocalContextUtil.init(fineractContext);
            final List<Throwable> errors = new ArrayList<>();
            for (Long loanId : loanIds) {
                log.debug("Loan ID {}", loanId);
                try {
                    loanWritePlatformService.recalculateInterest(loanId);
                } catch (Exception e) {
                    errors.add(e);
                }
            }
            if (!errors.isEmpty()) {
                throw new JobExecutionException(errors);
            }
        } finally {
            ThreadLocalContextUtil.reset();
        }
        return null;
    }

    @java.lang.SuppressWarnings("all")
        public RecalculateInterestPoster(final LoanWritePlatformService loanWritePlatformService) {
        this.loanWritePlatformService = loanWritePlatformService;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanIds(final Collection<Long> loanIds) {
        this.loanIds = loanIds;
    }

    @java.lang.SuppressWarnings("all")
        public void setFineractContext(final FineractContext fineractContext) {
        this.fineractContext = fineractContext;
    }
}
