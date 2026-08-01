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
package org.apache.fineract.portfolio.tax.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Map;
import org.apache.fineract.portfolio.tax.domain.TaxComponent;
import org.apache.fineract.portfolio.tax.domain.TaxGroup;
import org.apache.fineract.portfolio.tax.domain.TaxGroupRepository;
import org.apache.fineract.portfolio.tax.moduleapi.TaxComponentShareData;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class ChargeTaxApplicationServiceImpl implements ChargeTaxApplicationService {

    private final TaxGroupRepository taxGroupRepository;

    public ChargeTaxApplicationServiceImpl(final TaxGroupRepository taxGroupRepository) {
        this.taxGroupRepository = taxGroupRepository;
    }

    @Override
    public Collection<TaxComponentShareData> computeTax(final Long taxGroupId, final BigDecimal baseAmount, final LocalDate effectiveDate,
            final int scale) {
        if (taxGroupId == null || baseAmount == null || baseAmount.compareTo(BigDecimal.ZERO) == 0) {
            return Collections.emptyList();
        }
        final TaxGroup taxGroup = taxGroupRepository.findById(taxGroupId).orElse(null);
        if (taxGroup == null) {
            return Collections.emptyList();
        }
        final Map<TaxComponent, BigDecimal> split = TaxEntityUtils.splitTax(baseAmount, effectiveDate, taxGroup.getTaxGroupMappings(), scale);
        final Collection<TaxComponentShareData> shares = new ArrayList<>(split.size());
        for (final Map.Entry<TaxComponent, BigDecimal> entry : split.entrySet()) {
            final TaxComponent component = entry.getKey();
            final Long creditAccountId = component.getCreditAccount() != null ? component.getCreditAccount().getId() : null;
            final Long debitAccountId = component.getDebitAccount() != null ? component.getDebitAccount().getId() : null;
            shares.add(new TaxComponentShareData(component.getId(), component.getName(), entry.getValue(), creditAccountId, debitAccountId));
        }
        return shares;
    }
}
