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
package org.apache.fineract.portfolio.loanaccount.data;

import org.apache.fineract.infrastructure.core.config.MapstructMapperConfig;
import org.apache.fineract.organisation.monetary.mapper.CurrencyMapper;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.mapper.LoanClientIdLookup;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(config = MapstructMapperConfig.class, uses = { LoanStatusEnumDataMapper.class, CurrencyMapper.class, LoanPrincipalDataMapper.class,
        LoanInterestDataMapper.class, LoanFeeDataMapper.class, LoanPenaltyDataMapper.class, LoanTotalAmountDataMapper.class,
        LoanClientIdLookup.class })
public interface LoanPointInTimeDataMapper {

    @Mapping(source = "accountNumber", target = "accountNo")
    @Mapping(source = "source", target = "status")
    @Mapping(source = "clientId", target = "clientId")
    @Mapping(source = "clientId", target = "clientAccountNo", qualifiedByName = "clientAccountNumber")
    @Mapping(source = "clientId", target = "clientExternalId", qualifiedByName = "clientExternalIdValue")
    @Mapping(source = "clientId", target = "clientDisplayName", qualifiedByName = "clientDisplayName")
    @Mapping(source = "officeId", target = "clientOfficeId")
    @Mapping(source = "summary", target = "principal")
    @Mapping(source = "summary", target = "interest")
    @Mapping(source = "summary", target = "fee")
    @Mapping(source = "summary", target = "penalty")
    @Mapping(source = "summary", target = "total")
    @Mapping(source = "loanProduct.id", target = "loanProductId")
    @Mapping(source = "loanProduct.name", target = "loanProductName")
    @Mapping(target = "arrears", ignore = true)
    LoanPointInTimeData map(Loan source);
}
