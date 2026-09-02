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
package org.apache.fineract.portfolio.account.starter;

import org.apache.fineract.infrastructure.configuration.domain.ConfigurationDomainService;
import org.apache.fineract.infrastructure.core.config.FineractProperties;
import org.apache.fineract.infrastructure.core.service.ExternalIdFactory;
import org.apache.fineract.portfolio.account.data.AccountTransfersDataValidator;
import org.apache.fineract.portfolio.account.data.StandingInstructionDataValidator;
import org.apache.fineract.portfolio.account.domain.AccountTransferAssembler;
import org.apache.fineract.portfolio.account.domain.AccountTransferDetailRepository;
import org.apache.fineract.portfolio.account.domain.AccountTransferRepository;
import org.apache.fineract.portfolio.account.domain.StandingInstructionAssembler;
import org.apache.fineract.portfolio.account.domain.StandingInstructionRepository;
import org.apache.fineract.portfolio.account.service.AccountTransfersWritePlatformService;
import org.apache.fineract.portfolio.account.service.AccountTransfersWritePlatformServiceImpl;
import org.apache.fineract.portfolio.account.service.StandingInstructionWritePlatformService;
import org.apache.fineract.portfolio.account.service.StandingInstructionWritePlatformServiceImpl;
import org.apache.fineract.portfolio.loanaccount.domain.LoanAccountDomainService;
import org.apache.fineract.portfolio.loanaccount.service.LoanAssembler;
import org.apache.fineract.portfolio.loanaccount.service.LoanReadPlatformService;
import org.apache.fineract.portfolio.loanaccount.service.adjustment.LoanAdjustmentService;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AccountConfiguration {

    @Bean
    @ConditionalOnMissingBean(AccountTransfersWritePlatformService.class)
    public AccountTransfersWritePlatformService accountTransfersWritePlatformService(
            AccountTransfersDataValidator accountTransfersDataValidator, AccountTransferAssembler accountTransferAssembler,
            AccountTransferRepository accountTransferRepository, LoanAssembler loanAccountAssembler,
            LoanAccountDomainService loanAccountDomainService, AccountTransferDetailRepository accountTransferDetailRepository,
            LoanReadPlatformService loanReadPlatformService, ConfigurationDomainService configurationDomainService,
            ExternalIdFactory externalIdFactory, FineractProperties fineractProperties, LoanAdjustmentService loanAdjustmentService) {
        return new AccountTransfersWritePlatformServiceImpl(accountTransfersDataValidator, accountTransferAssembler,
                accountTransferRepository, loanAccountAssembler, loanAccountDomainService, accountTransferDetailRepository,
                loanReadPlatformService, configurationDomainService, externalIdFactory, fineractProperties, loanAdjustmentService);
    }

    @Bean
    @ConditionalOnMissingBean(StandingInstructionWritePlatformService.class)
    public StandingInstructionWritePlatformService standingInstructionWritePlatformService(
            StandingInstructionDataValidator standingInstructionDataValidator, StandingInstructionAssembler standingInstructionAssembler,
            AccountTransferDetailRepository accountTransferDetailRepository, StandingInstructionRepository standingInstructionRepository) {
        return new StandingInstructionWritePlatformServiceImpl(standingInstructionDataValidator, standingInstructionAssembler,
                accountTransferDetailRepository, standingInstructionRepository);
    }
}
