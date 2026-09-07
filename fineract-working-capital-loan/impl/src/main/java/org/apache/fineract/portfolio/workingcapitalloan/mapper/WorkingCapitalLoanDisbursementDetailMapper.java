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
package org.apache.fineract.portfolio.workingcapitalloan.mapper;

import java.util.List;
import org.apache.fineract.infrastructure.core.config.MapstructMapperConfig;
import org.apache.fineract.portfolio.workingcapitalloan.data.WorkingCapitalLoanDisbursementDetailData;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoanDisbursementDetails;
import org.apache.fineract.useradministration.domain.AppUser;
import org.apache.fineract.useradministration.moduleapi.AppUserAssociation;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;

@Mapper(config = MapstructMapperConfig.class)
public interface WorkingCapitalLoanDisbursementDetailMapper {

    @Mapping(target = "loanId", source = "wcLoan.id")
    @Mapping(target = "principal", source = "expectedAmount")
    @Mapping(target = "disbursedByUsername", source = "disbursedById", qualifiedByName = "userUsername")
    @Mapping(target = "disbursedByFirstname", source = "disbursedById", qualifiedByName = "userFirstname")
    @Mapping(target = "disbursedByLastname", source = "disbursedById", qualifiedByName = "userLastname")
    WorkingCapitalLoanDisbursementDetailData toData(WorkingCapitalLoanDisbursementDetails detail);

    @Named("userUsername")
    default String userUsername(final Long userId) {
        final AppUser user = persistableUser(userId);
        return user == null ? null : user.getUsername();
    }

    @Named("userFirstname")
    default String userFirstname(final Long userId) {
        final AppUser user = persistableUser(userId);
        return user == null ? null : user.getFirstname();
    }

    @Named("userLastname")
    default String userLastname(final Long userId) {
        final AppUser user = persistableUser(userId);
        return user == null ? null : user.getLastname();
    }

    default AppUser persistableUser(final Long userId) {
        final Object persistable = AppUserAssociation.persistableById(userId);
        return persistable instanceof AppUser user ? user : null;
    }

    default List<WorkingCapitalLoanDisbursementDetailData> toDataList(final List<WorkingCapitalLoanDisbursementDetails> details) {
        if (details == null || details.isEmpty()) {
            return null;
        }
        return details.stream().map(this::toData).toList();
    }
}
