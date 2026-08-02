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
package org.apache.fineract.portfolio.workingcapitalloan.service;

import java.util.ArrayList;
import java.util.List;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionData;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort;
import org.apache.fineract.portfolio.workingcapitalloan.data.WorkingCapitalLoanChargeData;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoanCharge;
import org.apache.fineract.portfolio.workingcapitalloan.exception.WorkingCapitalLoanChargeNotFoundException;
import org.apache.fineract.portfolio.workingcapitalloan.repository.WorkingCapitalLoanChargeRepository;
import org.springframework.stereotype.Service;

@Service
public class WorkingCapitalLoanChargeReadPlatformServiceImpl implements WorkingCapitalLoanChargeReadPlatformService {
    private final WorkingCapitalLoanChargeRepository loanChargeRepository;
    private final ChargeDefinitionPort chargeDefinitionPort;

    @Override
    public WorkingCapitalLoanChargeData retrieveLoanChargeDetails(final Long id, final Long loanId) {
        final WorkingCapitalLoanCharge charge = loanChargeRepository.findByIdAndLoan_Id(id, loanId)
                .orElseThrow(() -> new WorkingCapitalLoanChargeNotFoundException(id, loanId));
        final ChargeDefinitionData catalog = chargeDefinitionPort.findCharge(charge.getChargeId()).orElse(null);
        return charge.toData(catalog);
    }

    @Override
    public List<WorkingCapitalLoanChargeData> retrieveLoanCharges(final Long loanId) {
        final List<WorkingCapitalLoanCharge> charges = loanChargeRepository.findByLoanIdAndActiveTrueOrderByDueDateAscIdAsc(loanId);
        final List<WorkingCapitalLoanChargeData> result = new ArrayList<>(charges.size());
        for (final WorkingCapitalLoanCharge charge : charges) {
            final ChargeDefinitionData catalog = chargeDefinitionPort.findCharge(charge.getChargeId()).orElse(null);
            result.add(charge.toData(catalog));
        }
        return result;
    }

    public WorkingCapitalLoanChargeReadPlatformServiceImpl(final WorkingCapitalLoanChargeRepository loanChargeRepository,
            final ChargeDefinitionPort chargeDefinitionPort) {
        this.loanChargeRepository = loanChargeRepository;
        this.chargeDefinitionPort = chargeDefinitionPort;
    }
}
