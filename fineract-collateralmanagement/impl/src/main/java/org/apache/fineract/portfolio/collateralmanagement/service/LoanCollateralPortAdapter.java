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
package org.apache.fineract.portfolio.collateralmanagement.service;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.apache.commons.lang3.StringUtils;
import org.apache.fineract.organisation.monetary.domain.MoneyHelper;
import org.apache.fineract.portfolio.accountdetails.domain.AccountType;
import org.apache.fineract.portfolio.collateralmanagement.domain.ClientCollateralManagement;
import org.apache.fineract.portfolio.collateralmanagement.domain.ClientCollateralManagementRepositoryWrapper;
import org.apache.fineract.portfolio.collateralmanagement.domain.CollateralManagementDomain;
import org.apache.fineract.portfolio.collateralmanagement.domain.LoanCollateralManagement;
import org.apache.fineract.portfolio.collateralmanagement.mapper.LoanCollateralManagementMapper;
import org.apache.fineract.portfolio.loanaccount.data.LoanCollateralManagementData;
import org.apache.fineract.portfolio.loanaccount.exception.InvalidAmountOfCollaterals;
import org.springframework.stereotype.Service;

@Service
public class LoanCollateralPortAdapter implements LoanCollateralPort {

    private final LoanCollateralLifecycleService loanCollateralLifecycleService;
    private final LoanCollateralAssembler loanCollateralAssembler;
    private final LoanCollateralManagementMapper loanCollateralManagementMapper;
    private final ClientCollateralManagementRepositoryWrapper clientCollateralManagementRepositoryWrapper;

    public LoanCollateralPortAdapter(final LoanCollateralLifecycleService loanCollateralLifecycleService,
            final LoanCollateralAssembler loanCollateralAssembler, final LoanCollateralManagementMapper loanCollateralManagementMapper,
            final ClientCollateralManagementRepositoryWrapper clientCollateralManagementRepositoryWrapper) {
        this.loanCollateralLifecycleService = loanCollateralLifecycleService;
        this.loanCollateralAssembler = loanCollateralAssembler;
        this.loanCollateralManagementMapper = loanCollateralManagementMapper;
        this.clientCollateralManagementRepositoryWrapper = clientCollateralManagementRepositoryWrapper;
    }

    @Override
    public void updateAndSaveLoanCollateralTransactionsForIndividualAccounts(final Long loanId, final boolean individualAccount,
            final boolean closed, final Long loanTransactionId) {
        this.loanCollateralLifecycleService.updateAndSaveLoanCollateralTransactionsForIndividualAccounts(loanId, individualAccount, closed,
                loanTransactionId);
    }

    @Override
    public void releaseOnLoanDelete(final Long loanId) {
        final Set<LoanCollateralManagement> loanCollateralManagements = this.loanCollateralLifecycleService.findByLoanAsSet(loanId);
        for (final LoanCollateralManagement loanCollateralManagement : loanCollateralManagements) {
            final BigDecimal quantity = loanCollateralManagement.getQuantity();
            final ClientCollateralManagement clientCollateralManagement = loanCollateralManagement.getClientCollateralManagement();
            clientCollateralManagement.updateQuantityAfterLoanClosed(quantity);
            loanCollateralManagement.setIsReleased(true);
            loanCollateralManagement.setClientCollateralManagement(clientCollateralManagement);
        }
        this.loanCollateralLifecycleService.replaceLoanCollaterals(loanId, loanCollateralManagements);
    }

    @Override
    public void releaseAttached(final Long loanId) {
        final Set<LoanCollateralManagement> loanCollateralManagements = this.loanCollateralLifecycleService.findByLoanAsSet(loanId);
        for (final LoanCollateralManagement loanCollateralManagement : loanCollateralManagements) {
            final ClientCollateralManagement clientCollateralManagement = loanCollateralManagement.getClientCollateralManagement();
            clientCollateralManagement.updateQuantity(clientCollateralManagement.getQuantity().add(loanCollateralManagement.getQuantity()));
            loanCollateralManagement.setClientCollateralManagement(clientCollateralManagement);
            loanCollateralManagement.setIsReleased(true);
        }
        this.loanCollateralLifecycleService.replaceLoanCollaterals(loanId, loanCollateralManagements);
    }

    @Override
    @SuppressWarnings("unchecked")
    public void replaceFromPending(final Long loanId, final Set<?> pendingCollaterals) {
        this.loanCollateralLifecycleService.replaceLoanCollaterals(loanId, (Set<LoanCollateralManagement>) pendingCollaterals);
    }

    @Override
    public BigDecimal totalCollateralValue(final Long loanId) {
        BigDecimal totalCollateral = BigDecimal.ZERO;
        for (final LoanCollateralManagement loanCollateralManagement : this.loanCollateralLifecycleService.findByLoan(loanId)) {
            final BigDecimal quantity = loanCollateralManagement.getQuantity();
            final BigDecimal pctToBase = loanCollateralManagement.getClientCollateralManagement().getCollaterals().getPctToBase();
            final BigDecimal basePrice = loanCollateralManagement.getClientCollateralManagement().getCollaterals().getBasePrice();
            totalCollateral = totalCollateral.add(quantity.multiply(basePrice).multiply(pctToBase).divide(BigDecimal.valueOf(100)));
        }
        return totalCollateral;
    }

    @Override
    public void validateIndividualCollateral(final String json, final BigDecimal disbursementPrincipal) {
        if (StringUtils.isBlank(json)) {
            return;
        }
        final JsonElement element = JsonParser.parseString(json);
        if (!element.isJsonObject()) {
            return;
        }
        final String loanTypeStr = element.getAsJsonObject().has("loanType") ? element.getAsJsonObject().get("loanType").getAsString()
                : null;
        if (StringUtils.isBlank(loanTypeStr) || !AccountType.fromName(loanTypeStr).isIndividualAccount()) {
            return;
        }
        final Set<LoanCollateralManagement> collateral = this.loanCollateralAssembler.fromParsedJson(element);
        if (collateral.isEmpty()) {
            return;
        }
        BigDecimal totalValue = BigDecimal.ZERO;
        for (final LoanCollateralManagement collateralManagement : collateral) {
            final CollateralManagementDomain collateralManagementDomain = collateralManagement.getClientCollateralManagement()
                    .getCollaterals();
            final BigDecimal totalCollateral = collateralManagement.getQuantity().multiply(collateralManagementDomain.getBasePrice())
                    .multiply(collateralManagementDomain.getPctToBase()).divide(BigDecimal.valueOf(100), MoneyHelper.getMathContext());
            totalValue = totalValue.add(totalCollateral);
        }
        if (disbursementPrincipal != null && disbursementPrincipal.compareTo(totalValue) > 0) {
            throw new InvalidAmountOfCollaterals(totalValue);
        }
    }

    @Override
    public Set<?> assembleFromJson(final String json) {
        if (StringUtils.isBlank(json)) {
            return new HashSet<>();
        }
        return this.loanCollateralAssembler.fromParsedJson(JsonParser.parseString(json));
    }

    @Override
    @SuppressWarnings("unchecked")
    public Set<LoanCollateralManagementData> mapToData(final Set<?> collaterals) {
        if (collaterals == null) {
            return Set.of();
        }
        return this.loanCollateralManagementMapper.map((Set<LoanCollateralManagement>) collaterals);
    }

    @Override
    public BigDecimal availableQuantity(final Long clientCollateralId) {
        return this.clientCollateralManagementRepositoryWrapper.getCollateral(clientCollateralId).getQuantity();
    }

    @Override
    public CollateralPricing pricing(final Long clientCollateralId) {
        final ClientCollateralManagement clientCollateral = this.clientCollateralManagementRepositoryWrapper.getCollateral(clientCollateralId);
        return new CollateralPricing(clientCollateral.getCollaterals().getBasePrice(), clientCollateral.getCollaterals().getPctToBase());
    }

    @Override
    public List<ClientCollateralSummary> collateralsPerClient(final Long clientId) {
        final List<ClientCollateralSummary> summaries = new ArrayList<>();
        for (final ClientCollateralManagement clientCollateralManagement : this.clientCollateralManagementRepositoryWrapper
                .getCollateralsPerClient(clientId)) {
            final BigDecimal total = clientCollateralManagement.getTotal();
            final BigDecimal totalCollateral = clientCollateralManagement.getTotalCollateral(total);
            summaries.add(new ClientCollateralSummary(clientCollateralManagement.getId(),
                    clientCollateralManagement.getCollaterals().getName(), clientCollateralManagement.getQuantity(),
                    clientCollateralManagement.getCollaterals().getPctToBase(), clientCollateralManagement.getCollaterals().getBasePrice(),
                    total, totalCollateral));
        }
        return summaries;
    }
}
