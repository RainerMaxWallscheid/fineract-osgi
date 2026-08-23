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
package org.apache.fineract.portfolio.loanorigination.service;

import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResultBuilder;
import org.apache.fineract.portfolio.loanorigination.domain.LoanOriginator;
import org.apache.fineract.portfolio.loanorigination.domain.LoanOriginatorRepository;
import org.apache.fineract.portfolio.loanorigination.moduleapi.LoanOriginatorStatus;
import org.apache.fineract.portfolio.loanorigination.domain.WorkingCapitalLoanOriginatorMapping;
import org.apache.fineract.portfolio.loanorigination.domain.WorkingCapitalLoanOriginatorMappingRepository;
import org.apache.fineract.portfolio.loanorigination.exception.LoanOriginatorMappingAlreadyExistsException;
import org.apache.fineract.portfolio.loanorigination.exception.LoanOriginatorNotActiveException;
import org.apache.fineract.portfolio.loanorigination.exception.LoanOriginatorNotFoundException;
import org.apache.fineract.portfolio.loanorigination.exception.WorkingCapitalLoanNotInSubmittedStatusForOriginationException;
import org.apache.fineract.portfolio.loanorigination.exception.WorkingCapitalLoanOriginatorMappingNotFoundException;
import org.apache.fineract.portfolio.workingcapitalloan.moduleapi.WorkingCapitalLoanExistencePort;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@ConditionalOnProperty(value = "fineract.module.loan-origination.enabled", havingValue = "true")
public class WorkingCapitalLoanOriginatorWritePlatformServiceImpl implements WorkingCapitalLoanOriginatorWritePlatformService {
    private final WorkingCapitalLoanExistencePort workingCapitalLoanExistencePort;
    private final LoanOriginatorRepository loanOriginatorRepository;
    private final WorkingCapitalLoanOriginatorMappingRepository workingCapitalLoanOriginatorMappingRepository;

    @Override
    public CommandProcessingResult attachOriginatorToWorkingCapitalLoan(final Long loanId, final Long originatorId) {
        if (!this.workingCapitalLoanExistencePort.isSubmittedAndPendingApproval(loanId)) {
            throw new WorkingCapitalLoanNotInSubmittedStatusForOriginationException(loanId, this.workingCapitalLoanExistencePort.statusCode(loanId));
        }
        final LoanOriginator originator = this.loanOriginatorRepository.findById(originatorId).orElseThrow(() -> new LoanOriginatorNotFoundException(originatorId));
        if (originator.getStatus() != LoanOriginatorStatus.ACTIVE) {
            throw new LoanOriginatorNotActiveException(originatorId, originator.getStatus().getValue());
        }
        if (this.workingCapitalLoanOriginatorMappingRepository.existsByLoanIdAndOriginatorId(loanId, originatorId)) {
            throw new LoanOriginatorMappingAlreadyExistsException(loanId, originatorId);
        }
        final WorkingCapitalLoanOriginatorMapping mapping = WorkingCapitalLoanOriginatorMapping.create(loanId, originator);
        this.workingCapitalLoanOriginatorMappingRepository.saveAndFlush(mapping);
        return  //
        //
        //
        //
        //
        new CommandProcessingResultBuilder().withEntityId(loanId).withEntityExternalId(this.workingCapitalLoanExistencePort.externalId(loanId)).withSubEntityId(originatorId).withSubEntityExternalId(originator.getExternalId()).build();
    }

    @Override
    public CommandProcessingResult detachOriginatorFromWorkingCapitalLoan(final Long loanId, final Long originatorId) {
        if (!this.workingCapitalLoanExistencePort.isSubmittedAndPendingApproval(loanId)) {
            throw new WorkingCapitalLoanNotInSubmittedStatusForOriginationException(loanId, this.workingCapitalLoanExistencePort.statusCode(loanId));
        }
        final LoanOriginator originator = this.loanOriginatorRepository.findById(originatorId).orElseThrow(() -> new LoanOriginatorNotFoundException(originatorId));
        final WorkingCapitalLoanOriginatorMapping mapping = this.workingCapitalLoanOriginatorMappingRepository.findByLoanIdAndOriginatorId(loanId, originatorId).orElseThrow(() -> new WorkingCapitalLoanOriginatorMappingNotFoundException(loanId, originatorId));
        this.workingCapitalLoanOriginatorMappingRepository.delete(mapping);
        return  //
        //
        //
        //
        //
        new CommandProcessingResultBuilder().withEntityId(loanId).withEntityExternalId(this.workingCapitalLoanExistencePort.externalId(loanId)).withSubEntityId(originatorId).withSubEntityExternalId(originator.getExternalId()).build();
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanOriginatorWritePlatformServiceImpl(final WorkingCapitalLoanExistencePort workingCapitalLoanExistencePort, final LoanOriginatorRepository loanOriginatorRepository, final WorkingCapitalLoanOriginatorMappingRepository workingCapitalLoanOriginatorMappingRepository) {
        this.workingCapitalLoanExistencePort = workingCapitalLoanExistencePort;
        this.loanOriginatorRepository = loanOriginatorRepository;
        this.workingCapitalLoanOriginatorMappingRepository = workingCapitalLoanOriginatorMappingRepository;
    }
}
