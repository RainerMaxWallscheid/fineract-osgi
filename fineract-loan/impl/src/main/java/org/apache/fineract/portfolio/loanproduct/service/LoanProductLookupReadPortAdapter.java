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
package org.apache.fineract.portfolio.loanproduct.service;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.organisation.monetary.domain.MonetaryCurrency;
import org.apache.fineract.portfolio.loanproduct.data.LoanProductData;
import org.apache.fineract.portfolio.loanproduct.data.LoanProductLookupData;
import org.apache.fineract.portfolio.loanproduct.domain.LoanProduct;
import org.apache.fineract.portfolio.loanproduct.domain.LoanProductRepository;
import org.springframework.stereotype.Service;

@Service
public class LoanProductLookupReadPortAdapter implements LoanProductLookupReadPort {

    private final LoanProductReadPlatformService loanProductReadPlatformService;
    private final LoanProductRepository loanProductRepository;

    public LoanProductLookupReadPortAdapter(final LoanProductReadPlatformService loanProductReadPlatformService,
            final LoanProductRepository loanProductRepository) {
        this.loanProductReadPlatformService = loanProductReadPlatformService;
        this.loanProductRepository = loanProductRepository;
    }

    @Override
    public Collection<LoanProductLookupData> retrieveAllLoanProductsForLookup() {
        return retrieveAllLoanProductsForLookup(false);
    }

    @Override
    public Collection<LoanProductLookupData> retrieveAllLoanProductsForLookup(final boolean activeOnly) {
        final Collection<LoanProductData> products = this.loanProductReadPlatformService.retrieveAllLoanProductsForLookup(activeOnly);
        return products.stream().map(p -> LoanProductLookupData.lookup(p.getId(), p.getName(), p.getMultiDisburseLoan()))
                .collect(Collectors.toList());
    }

    @Override
    public String nameById(final Long loanProductId) {
        return this.loanProductReadPlatformService.retrieveLoanProduct(loanProductId).getName();
    }

    @Override
    public String loanEnumerationValue(final String typeName, final int id) {
        final var data = LoanEnumerations.loanEnumeration(typeName, id);
        return data == null ? null : data.getValue();
    }

    @Override
    public Collection<LoanProductLookupData> findAllByNameIgnoreCase(final Collection<String> names) {
        if (names == null || names.isEmpty()) {
            return List.of();
        }
        return this.loanProductRepository.findAllByNameIgnoreCase(names).stream().map(this::toLookupWithCurrency)
                .collect(Collectors.toList());
    }

    private LoanProductLookupData toLookupWithCurrency(final LoanProduct product) {
        final MonetaryCurrency currency = product.getCurrency();
        final CurrencyData currencyData = currency == null ? null : new CurrencyData(currency.getCode());
        return LoanProductLookupData.lookupWithCurrency(product.getId(), product.getName(), currencyData);
    }
}
