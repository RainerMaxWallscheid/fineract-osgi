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
package org.apache.fineract.portfolio.collateral.service;

import java.util.Map;
import org.apache.fineract.infrastructure.codes.domain.CodeValue;
import org.apache.fineract.infrastructure.codes.domain.CodeValueRepositoryWrapper;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResultBuilder;
import org.apache.fineract.infrastructure.core.exception.ErrorHandler;
import org.apache.fineract.infrastructure.security.service.PlatformSecurityContext;
import org.apache.fineract.portfolio.collateral.api.CollateralApiConstants;
import org.apache.fineract.portfolio.collateral.api.CollateralApiConstants.CollateralJSONinputParams;
import org.apache.fineract.portfolio.collateral.command.CollateralCommand;
import org.apache.fineract.portfolio.collateral.domain.LoanCollateral;
import org.apache.fineract.portfolio.collateral.domain.LoanCollateralRepository;
import org.apache.fineract.portfolio.collateral.exception.CollateralCannotBeCreatedException;
import org.apache.fineract.portfolio.collateral.exception.CollateralCannotBeCreatedException.LoanCollateralCannotBeCreatedReason;
import org.apache.fineract.portfolio.collateral.exception.CollateralCannotBeDeletedException;
import org.apache.fineract.portfolio.collateral.exception.CollateralCannotBeDeletedException.LoanCollateralCannotBeDeletedReason;
import org.apache.fineract.portfolio.collateral.exception.CollateralCannotBeUpdatedException;
import org.apache.fineract.portfolio.collateral.exception.CollateralCannotBeUpdatedException.LoanCollateralCannotBeUpdatedReason;
import org.apache.fineract.portfolio.collateral.exception.CollateralNotFoundException;
import org.apache.fineract.portfolio.collateral.serialization.CollateralCommandFromApiJsonDeserializer;
import org.apache.fineract.portfolio.loanaccount.exception.LoanNotFoundException;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanExistencePort;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.NonTransientDataAccessException;
import org.springframework.orm.jpa.JpaSystemException;
import org.springframework.transaction.annotation.Transactional;

public class CollateralWritePlatformServiceJpaRepositoryImpl implements CollateralWritePlatformService {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(CollateralWritePlatformServiceJpaRepositoryImpl.class);
    private final PlatformSecurityContext context;
    private final LoanExistencePort loanExistencePort;
    private final LoanCollateralRepository collateralRepository;
    private final CodeValueRepositoryWrapper codeValueRepository;
    private final CollateralCommandFromApiJsonDeserializer collateralCommandFromApiJsonDeserializer;

    @Transactional
    @Override
    public CommandProcessingResult addCollateral(final Long loanId, final JsonCommand command) {
        this.context.authenticatedUser();
        final CollateralCommand collateralCommand = this.collateralCommandFromApiJsonDeserializer.commandFromApiJson(command.json());
        collateralCommand.validateForCreate();
        try {
            if (!this.loanExistencePort.isSubmittedAndPendingApproval(loanId)) {
                throw new CollateralCannotBeCreatedException(LoanCollateralCannotBeCreatedReason.LOAN_NOT_IN_SUBMITTED_AND_PENDING_APPROVAL_STAGE, loanId);
            }
            final CodeValue collateralType = this.codeValueRepository.findOneByCodeNameAndIdWithNotFoundDetection(CollateralApiConstants.COLLATERAL_CODE_NAME, collateralCommand.getCollateralTypeId());
            final LoanCollateral collateral = LoanCollateral.fromJson(loanId, collateralType, command);
            this.collateralRepository.saveAndFlush(collateral);
            return  //
            //
            //
            //
            new CommandProcessingResultBuilder().withCommandId(command.commandId()).withLoanId(loanId).withEntityId(collateral.getId()).build();
        } catch (final JpaSystemException | DataIntegrityViolationException dve) {
            handleCollateralDataIntegrityViolation(dve);
            return CommandProcessingResult.empty();
        }
    }

    @Transactional
    @Override
    public CommandProcessingResult updateCollateral(final Long loanId, final Long collateralId, final JsonCommand command) {
        this.context.authenticatedUser();
        final CollateralCommand collateralCommand = this.collateralCommandFromApiJsonDeserializer.commandFromApiJson(command.json());
        collateralCommand.validateForUpdate();
        final Long collateralTypeId = collateralCommand.getCollateralTypeId();
        try {
            if (!this.loanExistencePort.existsById(loanId)) {
                throw new LoanNotFoundException(loanId);
            }
            CodeValue collateralType = null;
            final LoanCollateral collateralForUpdate = this.collateralRepository.findById(collateralId).orElseThrow(() -> new CollateralNotFoundException(loanId, collateralId));
            final Map<String, Object> changes = collateralForUpdate.update(command);
            if (changes.containsKey(CollateralJSONinputParams.COLLATERAL_TYPE_ID.getValue())) {
                collateralType = this.codeValueRepository.findOneByCodeNameAndIdWithNotFoundDetection(CollateralApiConstants.COLLATERAL_CODE_NAME, collateralTypeId);
                collateralForUpdate.setCollateralType(collateralType);
            }
            if (!this.loanExistencePort.isSubmittedAndPendingApproval(loanId)) {
                throw new CollateralCannotBeUpdatedException(LoanCollateralCannotBeUpdatedReason.LOAN_NOT_IN_SUBMITTED_AND_PENDING_APPROVAL_STAGE, loanId);
            }
            if (!changes.isEmpty()) {
                this.collateralRepository.saveAndFlush(collateralForUpdate);
            }
            return  //
            //
            //
            //
            //
            new CommandProcessingResultBuilder().withCommandId(command.commandId()).withLoanId(command.getLoanId()).withEntityId(collateralId).with(changes).build();
        } catch (final JpaSystemException | DataIntegrityViolationException dve) {
            handleCollateralDataIntegrityViolation(dve);
            return CommandProcessingResult.resourceResult(-1L);
        }
    }

    @Transactional
    @Override
    public CommandProcessingResult deleteCollateral(final Long loanId, final Long collateralId, final Long commandId) {
        if (!this.loanExistencePort.existsById(loanId)) {
            throw new LoanNotFoundException(loanId);
        }
        final LoanCollateral collateral = this.collateralRepository.findByLoanIdAndId(loanId, collateralId);
        if (collateral == null) {
            throw new CollateralNotFoundException(loanId, collateralId);
        }
        if (!this.loanExistencePort.isSubmittedAndPendingApproval(loanId)) {
            throw new CollateralCannotBeDeletedException(LoanCollateralCannotBeDeletedReason.LOAN_NOT_IN_SUBMITTED_AND_PENDING_APPROVAL_STAGE, loanId, collateralId);
        }
        this.collateralRepository.delete(collateral);
        return  //
        //
        //
        //
        new CommandProcessingResultBuilder().withCommandId(commandId).withLoanId(loanId).withEntityId(collateralId).build();
    }

    /**
     * Collaterals may be deleted only when the loan associated with them are yet to be approved
     */
    private void handleCollateralDataIntegrityViolation(final NonTransientDataAccessException dve) {
        log.error("Error occured.", dve);
        throw ErrorHandler.getMappable(dve, "error.msg.collateral.unknown.data.integrity.issue", "Unknown data integrity issue with resource.");
    }

    @java.lang.SuppressWarnings("all")
        public CollateralWritePlatformServiceJpaRepositoryImpl(final PlatformSecurityContext context, final LoanExistencePort loanExistencePort, final LoanCollateralRepository collateralRepository, final CodeValueRepositoryWrapper codeValueRepository, final CollateralCommandFromApiJsonDeserializer collateralCommandFromApiJsonDeserializer) {
        this.context = context;
        this.loanExistencePort = loanExistencePort;
        this.collateralRepository = collateralRepository;
        this.codeValueRepository = codeValueRepository;
        this.collateralCommandFromApiJsonDeserializer = collateralCommandFromApiJsonDeserializer;
    }
}
