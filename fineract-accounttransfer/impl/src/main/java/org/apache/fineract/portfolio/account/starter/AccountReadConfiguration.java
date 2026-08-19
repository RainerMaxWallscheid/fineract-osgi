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

import org.apache.fineract.infrastructure.core.service.PaginationHelper;
import org.apache.fineract.infrastructure.core.service.database.DatabaseSpecificSQLGenerator;
import org.apache.fineract.infrastructure.security.service.SqlValidator;
import org.apache.fineract.infrastructure.security.utils.ColumnValidator;
import org.apache.fineract.organisation.office.service.OfficeReadPlatformService;
import org.apache.fineract.portfolio.account.mapper.AccountTransfersMapper;
import org.apache.fineract.portfolio.account.service.AccountAssociationsReadPlatformService;
import org.apache.fineract.portfolio.account.service.AccountAssociationsReadPlatformServiceImpl;
import org.apache.fineract.portfolio.account.service.AccountTransfersReadPlatformService;
import org.apache.fineract.portfolio.account.service.AccountTransfersReadPlatformServiceImpl;
import org.apache.fineract.portfolio.account.service.PortfolioAccountReadPlatformService;
import org.apache.fineract.portfolio.account.service.PortfolioAccountReadPlatformServiceImpl;
import org.apache.fineract.portfolio.account.service.StandingInstructionHistoryReadService;
import org.apache.fineract.portfolio.account.service.StandingInstructionHistoryReadServiceImpl;
import org.apache.fineract.portfolio.account.service.StandingInstructionReadPlatformService;
import org.apache.fineract.portfolio.account.service.StandingInstructionReadPlatformServiceImpl;
import org.apache.fineract.portfolio.client.moduleapi.ClientReadPlatformService;
import org.apache.fineract.portfolio.common.service.DropdownReadPlatformService;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;

@Configuration
public class AccountReadConfiguration {

    @Bean
    @ConditionalOnMissingBean(AccountAssociationsReadPlatformService.class)
    public AccountAssociationsReadPlatformService accountAssociationsReadPlatformService(JdbcTemplate jdbcTemplate) {
        return new AccountAssociationsReadPlatformServiceImpl(jdbcTemplate);
    }

    @Bean
    @ConditionalOnMissingBean(AccountTransfersReadPlatformService.class)
    public AccountTransfersReadPlatformService accountTransfersReadPlatformService(JdbcTemplate jdbcTemplate,
            ClientReadPlatformService clientReadPlatformService, OfficeReadPlatformService officeReadPlatformService,
            PortfolioAccountReadPlatformService portfolioAccountReadPlatformService, ColumnValidator columnValidator,
            DatabaseSpecificSQLGenerator sqlGenerator, AccountTransfersMapper accountTransfersMapper, PaginationHelper paginationHelper,
            SqlValidator sqlValidator) {
        return new AccountTransfersReadPlatformServiceImpl(jdbcTemplate, clientReadPlatformService, officeReadPlatformService,
                portfolioAccountReadPlatformService, columnValidator, sqlGenerator, accountTransfersMapper, paginationHelper, sqlValidator);
    }

    @Bean
    @ConditionalOnMissingBean(PortfolioAccountReadPlatformService.class)
    public PortfolioAccountReadPlatformService portfolioAccountReadPlatformService(JdbcTemplate jdbcTemplate,
            DatabaseSpecificSQLGenerator sqlGenerator) {
        return new PortfolioAccountReadPlatformServiceImpl(jdbcTemplate, sqlGenerator);
    }

    @Bean
    @ConditionalOnMissingBean(StandingInstructionHistoryReadService.class)
    public StandingInstructionHistoryReadService standingInstructionHistoryReadService(JdbcTemplate jdbcTemplate,
            ColumnValidator columnValidator, DatabaseSpecificSQLGenerator sqlGenerator, PaginationHelper paginationHelper) {
        return new StandingInstructionHistoryReadServiceImpl(jdbcTemplate, columnValidator, sqlGenerator, paginationHelper);
    }

    @Bean
    @ConditionalOnMissingBean(StandingInstructionReadPlatformService.class)
    public StandingInstructionReadPlatformService standingInstructionReadPlatformService(JdbcTemplate jdbcTemplate,
            ClientReadPlatformService clientReadPlatformService, OfficeReadPlatformService officeReadPlatformService,
            PortfolioAccountReadPlatformService portfolioAccountReadPlatformService,
            DropdownReadPlatformService dropdownReadPlatformService, ColumnValidator columnValidator,
            DatabaseSpecificSQLGenerator sqlGenerator, PaginationHelper paginationHelper) {
        return new StandingInstructionReadPlatformServiceImpl(jdbcTemplate, clientReadPlatformService, officeReadPlatformService,
                portfolioAccountReadPlatformService, dropdownReadPlatformService, columnValidator, sqlGenerator, paginationHelper);
    }
}
