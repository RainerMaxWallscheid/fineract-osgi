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
package org.apache.fineract.cob.workingcapitalloan;

import org.springframework.lang.NonNull;

import java.util.List;
import org.apache.fineract.cob.domain.LockOwner;
import org.apache.fineract.cob.domain.LockingService;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoan;
import org.springframework.batch.item.Chunk;
import org.springframework.batch.item.data.RepositoryItemWriter;
import org.springframework.data.repository.CrudRepository;

public abstract class AbstractWorkingCapitalLoanCOBWorkerItemWriter extends RepositoryItemWriter<WorkingCapitalLoan> {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(AbstractWorkingCapitalLoanCOBWorkerItemWriter.class);
    private final LockingService loanLockingService;

    public AbstractWorkingCapitalLoanCOBWorkerItemWriter(LockingService loanLockingService, CrudRepository<WorkingCapitalLoan, Long> repository) {
        this.loanLockingService = loanLockingService;
        setRepository(repository);
    }

    @Override
    public void write(@NonNull Chunk<? extends WorkingCapitalLoan> items) throws Exception {
        if (items == null) {
            throw new java.lang.NullPointerException("items is marked non-null but is null");
        }
        if (!items.isEmpty()) {
            super.write(items);
            List<Long> loanIds = items.getItems().stream().map(AbstractPersistableCustom::getId).toList();
            loanLockingService.deleteByLoanIdInAndLockOwner(loanIds, getLockOwner());
        }
    }

    protected abstract LockOwner getLockOwner();
}
